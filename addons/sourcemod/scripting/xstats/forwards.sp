/* Prepare forwards */
stock void PrepareForwards()	{
	Forward.Prefix = new GlobalForward("XStats_OnPrefixUpdated",
		ET_Event,
		Param_String);
	Forward.Death = new GlobalForward("XStats_OnDeathEvent",
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell,
		Param_String,
		Param_Cell);
	Forward.Suicide = new GlobalForward("XStats_OnSuicideEvent",
		ET_Ignore,
		Param_Cell);
	Forward.GetStats = new PrivateForward(
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell);
	Forward.TF2_FlagEvent = new GlobalForward("XStats_TF2_OnFlagEvent",
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell,
		Param_Cell);
}

public void OnClientAuthorized(int client, const char[] auth)	{
	if(!Tklib_IsValidClient(client, true, _, false))
		return;
	
	GetClientNameEx(client, Player[client].Playername, sizeof(Player[].Playername));
	GetClientNameTeamString(client, Player[client].Name, sizeof(Player[].Name));
	GetClientIP(client, Player[client].IP, sizeof(Player[].IP));
	Format(Player[client].SteamID, sizeof(Player[].SteamID), auth);
	if(!GeoipCountry(Player[client].IP, Player[client].Country, sizeof(Player[].Country)))
		Player[client].Country = "unknown country";
	
	if(!DatabaseDirect())	{
		XStats_DebugText(false, "Player %s was unable to be authorized properly due to database connection unavailable.", Player[client].Playername);
		return;
	}
	
	DBResultSet results = SQL_QueryEx(DB.Direct, "select * from `%s` where SteamID='%s' and ServerID='%i'", Global.playerlist, auth, Cvars.ServerID.IntValue);
	
	/* Prevent invalid characters within playername when being sent over to the database. */
	char temp_playername[64];
	temp_playername = Player[client].Playername;
	TrimString(temp_playername);
	DB.Direct.Escape(temp_playername, temp_playername, sizeof(temp_playername));
	
	switch(results != null && results.FetchRow())	{
		/* Player was found */
		case	true:	{
			results = SQL_QueryEx(DB.Direct, "update `%s` set Playername = '%s', IPAddress = '%s' where SteamID='%s' and ServerID='%i'",
			Global.playerlist, temp_playername, Player[client].IP, Player[client].SteamID, Cvars.ServerID.IntValue);
			
			/* Avoid showing ip due to privacy */
			XStats_DebugText(false, "Updating table \"%s\" \nPlayername \"%s\" in SteamID \"%s\" (ServerID %i)",
			Global.playerlist, temp_playername, Player[client].SteamID, Cvars.ServerID.IntValue);
			
			if(results == null)	{
				char error[256];
				SQL_GetError(DB.Direct, error, sizeof(error));
				XStats_DebugText(true, "Updating player table into \"%s\" failed! (%s)", Global.playerlist, error);
			}
		}
		/* Player wasn't found, adding.. */
		case	false:	{
			results = SQL_QueryEx(DB.Direct, "insert into `%s` (Playername, SteamID, IPAddress, ServerID) values ('%s', '%s', '%s', '%i')",
			Global.playerlist, temp_playername, Player[client].SteamID, Player[client].IP, Cvars.ServerID.IntValue);
			
			XStats_DebugText(false, "Inserting into table \"%s\" \nPlayername \"%s\"\nSteamID \"%s\" (ServerID %i)",
			Global.playerlist, temp_playername, Player[client].SteamID, Cvars.ServerID.IntValue);
			
			if(results == null)	{
				char error[256];
				SQL_GetError(DB.Direct, error, sizeof(error));
				XStats_DebugText(true, "Inserting player table into \"%s\" failed! (%s)", Global.playerlist, error);
			}
		}
	}
	
	delete results;
}

public void OnClientPutInServer(int client)	{
	if(!Cvars.PluginActive.BoolValue)
		return;
	
	if(!Tklib_IsValidClient(client, _, _, false))
		return;
	
	if(IsFakeClient(client))	{
		if(Cvars.AllowBots.BoolValue)	{
			GetClientNameTeamString(client, Player[client].Name, sizeof(Player[].Name));
			CPrintToChatAll("%s BOT %s was added", Global.Prefix, Player[client].Name);
			if(!StrEqual(Sound[0].path, NULL_STRING))
				EmitSoundToAll(Sound[0].path);
		}
		return;
	}
	
	/* Session */
	ClearSessions(client);
	
	/* Experimental Assister */
	SDKHook(client, SDKHook_OnTakeDamage, Assister_OnTakeDamage);
	
	for(int i = 1; i < MaxClients; i++)
		PlayerDamaged[i][client] = 0;
	
	/* Check active players */
	CheckActivePlayers();
	
	UpdateLastConnectedState(Player[client].SteamID);
	Player[client].Points = GetClientPoints(Player[client].SteamID);
	Player[client].Position = GetClientPosition(Player[client].SteamID);
	
	CPrintToChatAll("%s %t", Global.Prefix, "Player Connected", Player[client].Name, Player[client].Position, Player[client].Points, Player[client].Country);
	XStats_DebugText(false, "%s (Pos #%i, %i points) has connected from %s",
	Player[client].Playername, Player[client].Position, Player[client].Points, Player[client].Country);
	
	if(Player[client].Position <= 10 && !StrEqual(Sound[0].path, NULL_STRING))
		EmitSoundToAll(Sound[0].path);
	else if(!StrEqual(Sound[1].path, NULL_STRING))
		EmitSoundToAll(Sound[1].path);
	
	CreateTimer(60.0, IntervalPlayTimer, client, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	
	/* Safety callback if the steamid weren't acquired. (for some reason) */
	if(StrEqual(Player[client].SteamID, NULL_STRING))
		GetClientAuth(client, Player[client].SteamID, sizeof(Player[].SteamID));
}

Action IntervalPlayTimer(Handle timer, int client)	{	
	/* Incase the player disconnected or plugin is disabled. */
	if(!Cvars.PluginActive.BoolValue || !IsClientConnected(client))	{
		KillTimer(timer);
		return Plugin_Handled;
	}
	
	Session[client].PlayTime++;
	char query[256];
	Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	DB.Threaded.Query(DBQuery_IntervalPlayTimer, query, client);
	XStats_DebugText(false, "Updating playtime by adding additional minute for %s", Player[client].Playername);
	return Plugin_Handled;
}

public void OnClientDisconnect(int client)	{
	if(!Tklib_IsValidClient(client, true))
		return;
	
	UpdateDamage(client);
}

public void OnMapStart()	{
	if(!Cvars.PluginActive.BoolValue)
		return;
	
	/* If database lost connection or plugin was late loaded */
	PrepareDatabase(); /* Database */
	
	GetCurrentMap(Global.CurrentMap, sizeof(Global.CurrentMap));	
	CreateTimer(60.0, MapLogTimer, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	XStats_DebugText(false, "//===== Map Log =====//");
	XStats_DebugText(false, "Creating a minute long repeating timer for map \"%s\"", Global.CurrentMap);
	XStats_DebugText(false, " ");
}

Action MapLogTimer(Handle timer)	{
	if(!Cvars.PluginActive.BoolValue)	{
		KillTimer(timer);
		return Plugin_Handled;
	}
	
	/* Check if map exists in database table */
	char query[256];
	Format(query, sizeof(query), "select '%s' from `%s`", Global.CurrentMap, Global.maps_log);
	DB.Threaded.Query(DBQuery_MapLog_1, query);
	
	XStats_DebugText(false, "//===== Map Log =====//");
	XStats_DebugText(false, "Checking if map \"%s\" exists on database table \"%s\"", Global.CurrentMap, Global.maps_log);
	XStats_DebugText(false, " ");
	return Plugin_Handled;
}

void DBQuery_MapLog_1(Database database, DBResultSet results, const char[] error, any data)	{		
	char query[512];
	
	switch(results != null && results.FetchRow())	{
		/* Map was found, lets update it */
		case	true:	{
			Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where MapName='%s' and ServerID='%i'",
			Global.maps_log, Global.CurrentMap, Cvars.ServerID.IntValue);
			DB.Threaded.Query(DBQuery_MapLog_2, query);
			XStats_DebugText(false, "Map was found, updating the playtime for \"%s\" by adding additional minute on database table \"%s\"", Global.CurrentMap, Global.maps_log);
			XStats_DebugText(false, " ");
		}
		/* Map was not found, lets add it */
		case	false:	{
			Format(query, sizeof(query), "insert into `%s` (MapName) values ('%s')", Global.maps_log, Global.CurrentMap);
			DB.Threaded.Query(DBQuery_MapLog_2, query);
			XStats_DebugText(false, "Map \"%s\" not found on database, inserting it..", Global.CurrentMap);
			XStats_DebugText(false, " ");
			
			Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where MapName='%s' and ServerID='%i'",
			Global.maps_log, Global.CurrentMap, Cvars.ServerID.IntValue);
			DB.Threaded.Query(DBQuery_MapLog_2, query);
			XStats_DebugText(false, "Updating the playtime on the added map by adding additional minute");
			XStats_DebugText(false, " ");
		}
	}
}

void DBQuery_MapLog_2(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		XStats_DebugText(true, "Map Log Updater failed! (%s)", error);
}

public void OnEntityCreated(int entity, const char[] classname)	{
	OnEntityCreated_CounterStrike(entity, classname);
}

public void OnConfigsExecuted()	{
	CheckActivePlayers(); /* Check active players */
}
public void OnPluginEnd()	{
	XStats_DebugText(false, "Ending..");	
}