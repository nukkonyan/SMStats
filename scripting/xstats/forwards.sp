public void OnClientAuthorized(int client, const char[] auth)	{
	if(!Tklib_IsValidClient(client, true, _, false))
		return;
	
	Database database = SQL_Connect2(Xstats, false);
	
	if(database == null)	{
		delete database;
		SetFailState("Failed to connect to database");
		return;
	}
	
	database.SetCharset("utf8mb4"); /* Fix characters */
	DBResultSet results = SQL_QueryEx(database, "select * from `%s` where SteamID='%s' and ServerID='%i'", playerlist, auth, ServerID.IntValue);
	GetClientNameEx(client, Playername[client], sizeof(Playername[]));
	GetClientTeamString(client, Name[client], sizeof(Name[]));
	GetClientIP(client, IP[client], sizeof(IP[]));
	Format(SteamID[client], sizeof(SteamID[]), auth);
	
	if(!GeoipCountry(IP[client], Country[client], sizeof(Country[])))
		Country[client] = "unknown country";
	
	UpdateLastConnectedState(SteamID[client]);
	
	switch(results != null && results.FetchRow())	{
		/* Player was found */
		case	true:	{			
			results = SQL_QueryEx(database, "update `%s` set Playername = '%s', IPAddress = '%s' where SteamID='%s' and ServerID='%i'",
			playerlist, Playername[client], IP[client], SteamID[client], ServerID.IntValue);
			
			if(Debug.BoolValue)	{
				/* Avoid showing ip due to privacy */
				PrintToServer("[XStats Debug] Updating table \"%s\" \nPlayername \"%s\" in SteamID \"%s\" (ServerID %i)",
				playerlist, Playername[client], SteamID[client], ServerID.IntValue);
			}
			
			if(results == null)	{
				char error[256];
				SQL_GetError(database, error, sizeof(error));
				SetFailState("%s Updating player table into \"%s\" failed! (%s)", LogTag, playerlist, error);
			}
		}
		/* Player wasn't found, adding.. */
		case	false:	{
			results = SQL_QueryEx(database, "insert into `%s` (Playername, SteamID, IPAddress, ServerID) values ('%s', '%s', '%s', '%i')",
			playerlist, Playername[client], SteamID[client], IP[client], ServerID.IntValue);
			
			if(Debug.BoolValue)	{
				PrintToServer("[XStats Debug] Inserting into table \"%s\" \nPlayername \"%s\"\nSteamID \"%s\" (ServerID %i)",
				playerlist, Playername[client], SteamID[client], ServerID.IntValue);
			}
			
			if(results == null)	{
				char error[256];
				SQL_GetError(database, error, sizeof(error));
				SetFailState("%s Inserting player table into \"%s\" failed! (%s)", LogTag, playerlist, error);
			}
		}
	}
	
	delete database;
	delete results;
}

public void OnClientPutInServer(int client)	{
	if(!PluginActive.BoolValue)
		return;
	
	/* Make sure names aren't empty just to be sure */
	GetClientTeamString(client, Name[client], sizeof(Name[]));

	if(IsFakeClient(client) && AllowBots.BoolValue)	{
		CPrintToChatAll("%s BOT %s was added", Prefix, Name[client]);
		if(!StrEqual(ConnectSound[0], NULL_STRING))
			EmitSoundToAll(ConnectSound[0]);
	}
	
	/* Experimental Assister */
	SDKHook(client, SDKHook_OnTakeDamage, Assister_OnTakeDamage);
	
	for(int i = 1; i < MaxClients; i++)
		PlayerDamaged[i][client] = 0;
	
	/* Check active players */
	CheckActivePlayers();
	
	/* No bots after this line will be read */
	if(!Tklib_IsValidClient(client, true, false, false))
		return;

	int points = GetClientPoints(SteamID[client]);
	int position = GetClientPosition(SteamID[client]);
	
	CPrintToChatAll("%s %s (Pos #%i, %i points) has connected from %s", Prefix, Name[client], position, points, Country[client]);
	PrintToServer("%s %s (Pos #%i, %i points) has connected from %s", LogTag, Playername[client], position, points, Country[client]);
	
	if(!IsFakeClient(client))	{
		if(position <= 10 && !StrEqual(ConnectSound[0], NULL_STRING))
			EmitSoundToAll(ConnectSound[0]);
		else if(!StrEqual(ConnectSound[1], NULL_STRING))
			EmitSoundToAll(ConnectSound[1]);
	}
	
	CreateTimer(60.0, IntervalPlayTimer, client, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	
	/* Safety callback if the steamid weren't acquired. (for some reason) */
	if(StrEqual(SteamID[client], NULL_STRING))
		GetClientAuth(client, SteamID[client], sizeof(SteamID[]));
}

Action IntervalPlayTimer(Handle timer, int client)	{	
	/* Incase the player disconnected or plugin is disabled. */
	if(!PluginActive.BoolValue || !IsClientConnected(client))	{
		KillTimer(timer);
		return	Plugin_Handled;
	}
	
	Session[client].Time++;
	char query[256];
	Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where SteamID='%s' and ServerID='%i'",
	playerlist, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_IntervalPlayTimer, query, client);
	
	return	Plugin_Handled;
}

public void OnMapStart()	{
	if(!PluginActive.BoolValue)
		return;
	
	/* If database lost connection or plugin was late loaded */
	PrepareDatabase(); /* Database */
	
	GetCurrentMap(CurrentMap, sizeof(CurrentMap));	
	CreateTimer(60.0, MapLogTimer, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	if(Debug.BoolValue)	{
		PrintToServer("//===== Map Log =====//");
		PrintToServer("Creating a minute long repeating timer for map \"%s\"", CurrentMap);
		PrintToServer(" ");
	}
}

Action MapLogTimer(Handle timer)	{
	if(!PluginActive.BoolValue)	{
		KillTimer(timer);
		return Plugin_Handled;
	}
	
	/* Check if map exists in database table */
	char query[512];
	Format(query, sizeof(query), "select '%s' from `%s`", CurrentMap, maps_log);
	db.Query(DBQuery_MapLog_1, query);
	
	if(Debug.BoolValue)	{
		PrintToServer("//===== Map Log =====//");
		PrintToServer("Checking if map \"%s\" exists on database table \"%s\"", CurrentMap, maps_log);
		PrintToServer(" ");
	}
	
	return Plugin_Handled;
}

void DBQuery_MapLog_1(Database database, DBResultSet results, const char[] error, any data)	{		
	char query[512];
	
	switch(results != null && results.FetchRow())	{
		/* Map was found, lets update it */
		case	true:	{
			Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where MapName='%s' and ServerID='%i'",
			maps_log, CurrentMap, ServerID.IntValue);
			db.Query(DBQuery_MapLog_2, query);
			
			if(Debug.BoolValue)	{
				PrintToServer("Map was found, updating the playtime for \"%s\" by adding additional minute on database table \"%s\"", CurrentMap, maps_log);
				PrintToServer(" ");
			}
		}
		/* Map was not found, lets add it */
		case	false:	{
			Format(query, sizeof(query), "insert into `%s` (MapName) values ('%s')", maps_log, CurrentMap);
			db.Query(DBQuery_MapLog_2, query);
			
			if(Debug.BoolValue)	{
				PrintToServer("Map \"%s\" not found on database, inserting it..", CurrentMap);
				PrintToServer(" ");
			}
			
			Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where MapName='%s' and ServerID='%i'",
			maps_log, CurrentMap, ServerID.IntValue);
			db.Query(DBQuery_MapLog_2, query);
			
			if(Debug.BoolValue)	{
				PrintToServer("Updating the playtime on the added map by adding additional minute");
				PrintToServer(" ");
			}
		}
	}
}

void DBQuery_MapLog_2(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		SetFailState("%s Map Log Updater failed! (%s)", LogTag, error);
}