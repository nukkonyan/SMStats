/* Initialize global events */
void PrepareEvents()	{
	HookEventEx(EVENT_PLAYER_DEATH, Suicide, EventHookMode_Pre);
	HookEventEx(EVENT_PLAYER_TEAM, UploadStuff);
	HookEventEx(EVENT_PLAYER_CHANGENAME, UploadStuff);
	HookEventEx(EVENT_PLAYER_DISCONNECT, Disconnected, EventHookMode_Pre);
	
	/* Rounds */
	HookEventEx(EVENT_ROUND_END,				Rounds);
	HookEventEx(EVENT_ROUND_START,				Rounds);
	HookEventEx(EVENT_TEAMPLAY_ROUND_ACTIVE,	Rounds);
	HookEventEx(EVENT_ARENA_ROUND_START,		Rounds);
	HookEventEx(EVENT_TEAMPLAY_ROUND_WIN,		Rounds);
	HookEventEx(EVENT_DOD_ROUND_ACTIVE,			Rounds);
	HookEventEx(EVENT_DOD_ROUND_WIN,			Rounds);
}

/* Check if it's a suicide */
stock void Suicide(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats())
		return;
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));	
	if(!Tklib_IsValidClient(client, true))
		return;
	
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!IsSamePlayers(client, victim))
		return;
	
	char query[256];
	Session[client].Suicides++;
	Format(query, sizeof(query), "update `%s` set Suicides = Suicides+1 where SteamID='%s' and ServerID='%i'",
	playerlist, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
}


/**
 *	If player changed team or name,
 *	this is a backup for some games using this event.
 */
stock void UploadStuff(Event event, const char[] event_name, bool dontBroadcast)	{
	OnClientSettingsChanged(GetClientOfUserId(event.GetInt(EVENT_STR_USERID)));
}

/**
 *	Acquire the playername and teamcoloured name.
 *	Need this because some games doesn't use "player_changename" event anymore (Could be the fact it's broken perhaps).
 */
public void OnClientSettingsChanged(int client)	{
	if(!PluginActive.BoolValue)
		return;
	
	if(!Tklib_IsValidClient(client, false, false, false))
		return;
	
	/* Too early to gain info, lets add a delay */
	CreateTimer(0.2, Timer_UploadStuff, client);
}

Action Timer_UploadStuff(Handle timer, int client)	{
	if(!Tklib_IsValidClient(client, false, false, false))	{
		KillTimer(timer);
		return	Plugin_Handled;
	}
	
	GetClientTeamString(client, Name[client], sizeof(Name[]));
	GetClientNameEx(client, Playername[client], sizeof(Playername[]));
	//PrintToServer("%N team %d", client, GetClientTeam(client));
	
	return	Plugin_Handled;
}

/**
 *	If connected messages are enabled, make sure to disable the ingame ones
 *	since otherwise we get double disconnect messages.
 */
stock void Disconnected(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!PluginActive.BoolValue)
		return;
	
	if(!ConnectMsg.BoolValue)
		return;
	
	event.BroadcastDisabled = true;	
	
	/* Check active players */
	CheckActivePlayers();
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	
	char reason[96];
	event.GetString(EVENT_STR_REASON, reason, sizeof(reason));
	if(IsFakeClient(client) && AllowBots.BoolValue)
		CPrintToChatAll("%s BOT %s was removed {grey}(%s)", Prefix, Name[client], reason);
	
	if(!Tklib_IsValidClient(client, true))
		return;
	
	for(int i = 1; i < MaxClients; i++)
		PlayerDamaged[i][client] = 0;
	
	if(ConnectMsg.BoolValue)	{
		int points = GetClientPoints(SteamID[client]);
		int position = GetClientPosition(SteamID[client]);
		CPrintToChatAll("%s %t", "Player Disconnected", Prefix, Name[client], position, points, Country[client], reason);
		PrintToServer("%s %s (Pos #%i, %i points) has disconnected from %s", LogTag, Playername[client], position, points, Country[client]);
		
		UpdateLastConnectedState(SteamID[client]);
	}
	
	/* Clear the steamid. */
	SteamID[client] = NULL_STRING;
}

stock void Rounds(Event event, const char[] event_name, bool dontBroadcast)	{
	if(Debug.BoolValue)	{
		PrintToServer("//===== Rounds =====//");
		PrintToServer("\"%s\" Was fired", event_name);
		PrintToServer(" ");
	}
	
	DataPack pack = new DataPack();
	pack.WriteString(event_name);
	CreateTimer(0.1, Timer_Rounds, pack);
}

stock Action Timer_Rounds(Handle timer, DataPack pack)	{
	pack.Reset();
	char event_name[64];
	pack.ReadString(event_name, sizeof(event_name));
	delete pack;
	
	(StrEqual(event_name, EVENT_ROUND_END)
	|| StrEqual(event_name, EVENT_TEAMPLAY_ROUND_WIN)
	|| StrEqual(event_name, EVENT_DOD_ROUND_WIN)) ? RoundEnded() : RoundStarted();
}