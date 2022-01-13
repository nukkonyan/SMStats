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
	DBResultSet results = SQL_QueryEx(database, "select Points from `%s` where SteamID='%s' and ServerID='%i'", playerlist, auth, ServerID.IntValue);
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
			int points = results.FetchInt(0);
			int position = GetClientPosition(auth);
			results = SQL_QueryEx(database, "update `%s` set Playername = '%s', IPAddress = '%s' where SteamID='%s' and ServerID='%i'",
			playerlist, Playername[client], IP[client], SteamID[client], ServerID.IntValue);
			
			if(Debug.BoolValue)	{
				/* Avoid showing ip due to privacy */
				PrintToServer("[Xstats Debug] Updating table \"%s\" \nPlayername \"%s\" in SteamID \"%s\" (ServerID %i)",
				playerlist, Playername[client], SteamID[client], ServerID.IntValue);
			}
			
			switch(results == null)	{
				case	true:	{
					char error[256];
					SQL_GetError(database, error, sizeof(error));
					SetFailState("%s Updating player table into \"%s\" failed! (%s)", LogTag, playerlist, error);
				}
				case	false:	{
					if(ConnectMsg.BoolValue)	{
						CPrintToChatAll("%s %s (Pos #%i, %i points) has connected from %s", Prefix, Name[client], position, points, Country[client]);
						PrintToServer("%s %s (Pos #%i, %i points) has connected from %s.", LogTag, Playername[client], position, points, Country[client]);
					}
				}
			}
		}
		/* Player wasn't found, adding.. */
		case	false:	{
			results = SQL_QueryEx(database, "insert into `%s` (Playername, SteamID, IPAddress, ServerID) values ('%s', '%s', '%s', '%i')",
			playerlist, Playername[client], SteamID[client], IP[client], ServerID.IntValue);
			
			if(Debug.BoolValue)	{
				PrintToServer("[Xstats Debug] Inserting into table \"%s\" \nPlayername \"%s\"\nSteamID \"%s\" (ServerID %i)",
				playerlist, Playername[client], SteamID[client], ServerID.IntValue);
			}
			
			switch(results == null)	{
				case	true:	{
					char error[256];
					SQL_GetError(database, error, sizeof(error));
					SetFailState("%s Inserting player table into \"%s\" failed! (%s)", LogTag, playerlist, error);
				}
				case	false:	{
					if(ConnectMsg.BoolValue)	{
						int points = GetClientPoints(auth);
						int position = GetClientPosition(auth);
						CPrintToChatAll("%s %s (Pos #%i, %i points) has connected from %s", Prefix, Name[client], position, points, Country[client]);
						PrintToServer("%s %s (Pos #%i, %i points) has connected from %s.", LogTag, Playername[client], position, points, Country[client]);
					}
				}
			}
		}
	}
	
	delete database;
	delete results;
}

public void OnClientPutInServer(int client)	{
	if(!PluginActive.BoolValue)
		return;
	
	/* Make sure bots can have names */
	GetClientTeamString(client, Name[client], sizeof(Name[]));

	if(IsFakeClient(client) && AllowBots.BoolValue)
		CPrintToChatAll("%s BOT %s has connected.", Prefix, Name[client]);
	
	/* Experimental Assister */
	SDKHook(client, SDKHook_OnTakeDamage, Assister_OnTakeDamage);
	
	for(int i = 1; i < MaxClients; i++)
		PlayerDamaged[i][client] = 0;
	
	/* Check active players */
	CheckActivePlayers();
	
	if(!Tklib_IsValidClient(client, true, _, false))
		return;
	
	CreateTimer(60.0, IntervalPlayTimer, client, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	
	/* Safety callback if the steamid weren't acquired. (for some reason) */
	if(StrEqual(SteamID[client], NULL_STRING))
		GetClientAuth(client, SteamID[client], sizeof(SteamID[]));
}

public void OnClientDisconnect(int client)	{
	if(!PluginActive.BoolValue)
		return;

	if(IsFakeClient(client) && AllowBots.BoolValue)
		CPrintToChatAll("%s BOT %s has connected.", Prefix, Name[client]);

	if(!Tklib_IsValidClient(client, true))
		return;
	
	/* Check active players */
	CheckActivePlayers();
	
	for(int i = 1; i < MaxClients; i++)
		PlayerDamaged[i][client] = 0;
	
	if(ConnectMsg.BoolValue)	{
		int points = GetClientPoints(SteamID[client]);
		int position = GetClientPosition(SteamID[client]);
		CPrintToChatAll("%s %s (Pos #%i, %i points) has left from %s", Prefix, Name[client], position, points, Country[client]);
		PrintToServer("%s %s (Pos #%i, %i points) has left from %s", LogTag, Playername[client], position, points, Country[client]);
		
		UpdateLastConnectedState(SteamID[client]);
	}
	
	/* Clear the steamid. */
	SteamID[client] = NULL_STRING;
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
	
	GetCurrentMap(CurrentMap, sizeof(CurrentMap));	
	CreateTimer(60.0, MapLogTimer, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
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
	
	return Plugin_Handled;
}

void DBQuery_MapLog_1(Database database, DBResultSet results, const char[] error, any data)	{		
	char query[512];
	
	switch(results == null)	{
		/* Map was not found, lets add it */
		case	true:	{
			Format(query, sizeof(query), "insert into `%s` (MapName) values ('%s')",
			maps_log, CurrentMap);
			db.Query(DBQuery_MapLog_2, query);
			
			Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where MapName='%s' and ServerID='%i'",
			maps_log, CurrentMap, ServerID.IntValue);
			db.Query(DBQuery_MapLog_2, query);
		}
		/* Map was found, lets update it */
		case	false:	{
			Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where MapName='%s' and ServerID='%i'",
			maps_log, CurrentMap, ServerID.IntValue);
			db.Query(DBQuery_MapLog_2, query);
		}
	}	
}

void DBQuery_MapLog_2(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		SetFailState("%s Map Log Updater failed! (%s)", LogTag, error);
}