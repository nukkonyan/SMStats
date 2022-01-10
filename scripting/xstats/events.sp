/* Initialize global events */
void PrepareEvents()	{
	HookEventEx(EVENT_PLAYER_DEATH, Deaths, EventHookMode_Pre);
	HookEventEx(EVENT_PLAYER_TEAM, Teams, EventHookMode_Pre);
}

stock void Deaths(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!PluginActive.BoolValue || !RankActive || WarmupActive && !AllowWarmup.BoolValue)
		return;
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	
	char query[256];
	
	/* Check if it's a suicide */
	if(Tklib_IsValidClient(client, true) && Tklib_IsValidClient(victim, true) && IsSamePlayers(client, victim))	{
		Session[client].Suicides++;
		Format(query, sizeof(query), "update `%s` set Suicides = Suicides+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[victim], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
}

stock void Teams(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!PluginActive.BoolValue || !RankActive || WarmupActive && !AllowWarmup.BoolValue)
		return;
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(client, false, false, false))
		return;
	
	GetClientTeamString(client, Name[client], sizeof(Name[]));
}