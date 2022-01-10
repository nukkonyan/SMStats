public void OnClientAuthorized(int client, const char[] auth)
{
	if(Tklib_IsValidClient(client, true, _, false))
	{
		Database database = SQL_Connect2(Xstats, false);
		
		if(database == null)
		{
			delete database;
			SetFailState("Failed to connect to database");
			return;
		}
		
		database.SetCharset("utf8mb4"); /* Fix characters */
		DBResultSet results = SQL_QueryEx(database, "select Points from `%s` where SteamID='%s'", playerlist, auth);
		GetClientNameEx(client, Playername[client], sizeof(Playername[]));
		GetClientTeamString(client, Name[client], sizeof(Name[]));
		GetClientIP(client, IP[client], sizeof(IP[]));
		Format(SteamID[client], sizeof(SteamID[]), auth);
		
		char country[96];
		if(!GeoipCountry(IP[client], country, sizeof(country)))
			country = "unknown country";
		
		switch(results != null && results.FetchRow())
		{
			/* Player was found */
			case	true:
			{			
				int points = results.FetchInt(0);
				int position = GetClientPosition(auth);
				results = SQL_QueryEx(database, "update `%s` set Playername = '%s', IPAddress = '%s' where SteamID='%s'",
				playerlist, Playername[client], IP[client], SteamID[client]);
				
				if(Debug.BoolValue)
				{
					/* Avoid showing ip due to privacy */
					PrintToServer("[Xstats Debug] Updating table \"%s\" \nPlayername \"%s\" in SteamID \"%s\"",
					playerlist, Playername[client], SteamID[client]);
				}
				
				switch(results == null)
				{
					case	true:
					{
						char error[256];
						SQL_GetError(database, error, sizeof(error));
						SetFailState("%s Updating player table into \"%s\" failed! (%s)", LogTag, playerlist, error);
					}
					case	false:
					{
						if(ConnectMsg.BoolValue)
						{
							CPrintToChatAll("%s %s (Pos #%i, %i points) has connected from %s", Prefix, Name[client], position, points, country);
							PrintToServer("%s %s (Pos #%i, %i points) has connected from %s.", LogTag, Playername[client], position, points, country);
						}
					}
				}
			}
			/* Player wasn't found, adding.. */
			case	false:
			{
				results = SQL_QueryEx(database, "insert into `%s` (Playername, SteamID, IPAddress) values ('%s', '%s', '%s')",
				playerlist, Playername[client], SteamID[client], IP[client]);
				
				if(Debug.BoolValue)
				{
					PrintToServer("[Xstats Debug] Inserting into table \"%s\" \nPlayername \"%s\"\nSteamID \"%s\"",
					playerlist, Playername[client], SteamID[client]);
				}
				
				switch(results == null)
				{
					case	true:	{
						char error[256];
						SQL_GetError(database, error, sizeof(error));
						SetFailState("%s Inserting player table into \"%s\" failed! (%s)", LogTag, playerlist, error);
					}
					case	false:
					{
						if(ConnectMsg.BoolValue)
						{
							int points = GetClientPoints(auth);
							int position = GetClientPosition(auth);
							CPrintToChatAll("%s %s (Pos #%i, %i points) has connected from %s", Prefix, Name[client], position, points, country);
							PrintToServer("%s %s (Pos #%i, %i points) has connected from %s.", LogTag, Playername[client], position, points, country);
						}
					}
				}
			}
		}
		
		delete database;
		delete results;
	}
}

public void OnClientPutInServer(int client)
{
	if(Tklib_IsValidClient(client, true, _, false))
		CreateTimer(60.0, IntervalPlayTimer, client, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	
	/* Experimental Assister */
	SDKHook(client, SDKHook_OnTakeDamage, Assister_OnTakeDamage);
	
	for(int i = 1; i < MaxClients; i++)
	{
		PlayerDamaged[i][client] = 0;
	}
	
	/* Safety callback if the steamid weren't acquired. */
	GetClientAuthId(client, AuthId_Steam2, SteamID[client], sizeof(SteamID[]));
	
	/* Check active players */
	if(!RankActive && GetClientCountEx(AllowBots.BoolValue) < MinimumPlayers.IntValue)
	{
		RankActive = true;
		CPrintToChatAll("%s Enough players, enabling statistical tracking..", Prefix);
		if(Debug.BoolValue)
			PrintToServer("%s Enough Players, enabling statistical tracking..");
	}
}

public void OnClientDisconnect(int client)
{
	if(ConnectMsg.BoolValue && Tklib_IsValidClient(client, true))
	{
		char country[96];
		if(!GeoipCountry(IP[client], country, sizeof(country)))
			country = "unknown country";
		
		int points = GetClientPoints(SteamID[client]);
		int position = GetClientPosition(SteamID[client]);
		CPrintToChatAll("%s %s (Pos #%i, %i points) has left from %s", Prefix, Name[client], position, points, country);
	}
	
	for(int i = 1; i < MaxClients; i++)
	{
		PlayerDamaged[i][client] = 0;
	}
	
	/* Clear the steamid. */
	SteamID[client] = NULL_STRING;
	
	/* Check active players */
	if(RankActive && GetClientCountEx(AllowBots.BoolValue) >= MinimumPlayers.IntValue)
	{
		RankActive = false;
		CPrintToChatAll("%s %t", Prefix, "Not Enough Players");
		if(Debug.BoolValue)
			PrintToServer("%s Not Enough Players, disabling tracking..");
	}
}

Action IntervalPlayTimer(Handle timer, int client)	{
	/* Incase the player disconnected */
	if(!IsClientConnected(client))
	{
		KillTimer(timer);
		return	Plugin_Handled;
	}
	
	GetClientAuth(client, SteamID[client], sizeof(SteamID[]));
	
	Session[client].Time++;
	
	char query[256];
	Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where SteamID='%s'", playerlist, SteamID[client]);
	db.Query(DBQuery_IntervalPlayTimer, query, client);
	
	return	Plugin_Handled;
}