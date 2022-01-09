public void OnClientAuthorized(int client, const char[] auth)	{
	if(Tklib_IsValidClient(client, true, _, false))	{
		Database database = SQL_Connect2("xstats", false);
		DBResultSet results = SQL_QueryEx(database, "select Points from `%s` where SteamID='%s'", auth, playerlist);
		GetClientNameEx(client, Playername[client], sizeof(Playername[]));
		GetClientTeamString(client, Name[client], sizeof(Name[]));
		GetClientIP(client, IP[client], sizeof(IP[]));
		Format(SteamID[client], sizeof(SteamID[]), auth);
		
		switch(results != null && !results.FetchRow())	{
			/* Player was found */
			case	true:	{				
				int points = results.FetchInt(0);
				results = SQL_QueryEx(database, "update `%s` set Playername = '%s', IPAddress = '%s' where SteamID='%s'",
				playerlist, Playername[client], IP[client], SteamID[client]);
				
				if(Debug.BoolValue)	{
					PrintToServer("Updating table \"%s\" \nPlayername \"%s\"\nIPAddress \"%s\" in SteamID \"%s\"",
					playerlist, Playername[client], IP[client], SteamID[client]);
				}
				
				switch(results == null)	{
					case	true:	{
						char error[256];
						SQL_GetError(database, error, sizeof(error));
						SetFailState("%s Updating player table into \"%s\" failed! (%s)", logprefix, playerlist, error);
					}
					case	false:	{
						CPrintToChatAll("%s %s (%i points) has connected.", Prefix, Name[client], points);
						PrintToServer("%s %s (%i points) has connected.", logprefix, Playername[client], points);
					}
				}
			}
			/* Player wasn't found, adding.. */
			case	false:	{
				results = SQL_QueryEx(database, "insert into `%s` (Playername, SteamID, IPAddress) values ('%s', '%s', '%s')",
				playerlist, Playername[client], SteamID[client], IP[client]);
				
				if(Debug.BoolValue)	{
					PrintToServer("Inserting into table \"%s\" \nPlayername \"%s\"\nSteamID \"%s\"\nIPAddress \"%s\"",
					playerlist, Playername[client], SteamID[client], IP[client]);
				}
				
				switch(results == null)	{
					case	true:	{
						char error[256];
						SQL_GetError(database, error, sizeof(error));
						SetFailState("%s Inserting player table into \"%s\" failed! (%s)", logprefix, playerlist, error);
					}
					case	false:	{
						int points = GetClientPoints(auth);
						CPrintToChatAll("%s %s (%i points) has connected.", Prefix, Name[client], points);
						PrintToServer("%s %s (%i points) has connected.", logprefix, Playername[client], points);
					}
				}
			}
		}
		
		delete database;
		delete results;
	}
}

public void OnClientPutInServer(int client)	{
	if(Tklib_IsValidClient(client, true, _, false))
		CreateTimer(60.0, IntervalPlayTimer, client, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	
	/* Experimental Assister */
	SDKHook(client, SDKHook_OnTakeDamage, Assister_OnTakeDamage);
	
	for(int i = 1; i < MaxClients; i++)
		PlayerDamaged[i][client] = 0;
	
	/* Safety callback if the steamid wasn't acquired. */
	GetClientAuth(client, SteamID[client], sizeof(SteamID[]));
}

public void OnClientDisconnect(int client)	{
	for(int i = 1; i < MaxClients; i++)
		PlayerDamaged[i][client] = 0;
	
	/* Clear the steamid. */
	SteamID[client] = NULL_STRING;
}

Action IntervalPlayTimer(Handle timer, int client)	{
	if(!IsClientConnected(client))	{
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

