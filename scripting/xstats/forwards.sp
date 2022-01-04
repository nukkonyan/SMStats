public void OnClientAuthorized(int client, const char[] auth)
{
	if(Tklib_IsValidClient(client, true, false, false))
	{
		Database database = SQL_Connect2("xstats", false);
		DBResultSet results = SQL_QueryEx(database, "select * from `%s` where SteamID='%s'", auth, playerlist);
		GetClientNameEx(client, Playername[client], sizeof(Playername[]));
		GetClientIP(client, IP[client], sizeof(IP[]));
		Format(SteamID[client], sizeof(SteamID[]), auth);
		
		switch(results != null && !results.FetchRow())
		{
			case	true:
			{
				results = SQL_QueryEx(database, "insert into `%s` (Playername, SteamID, IPAddress) values ('%s', '%s', '%s')",
				playerlist, Playername[client], SteamID[client], IP[client]);
				
				switch(results == null)
				{
					case	true:
					{
						char error[256];
						SQL_GetError(database, error, sizeof(error));
						SetFailState("%s Inserting player table into \"%s\" failed! (%s)", logprefix, playerlist, error);
					}
					case	false:
					{
						int points = GetClientPoints(auth);
						CPrintToChatAll("%s {grey}%N {default}(%i) has connected.", Prefix, client, points);
						PrintToServer("%s %N (%i points) has connected.", logprefix, client, points);
					}
				}
			}
			case	false:
			{
				results = SQL_QueryEx(database, "update `playerlist_csgo` set Playername = '%s', IPAddress = '%s' where SteamID='%s'",
				Playername[client], IP[client], SteamID[client]);
				
				switch(results == null)
				{
					case	true:
					{
						char error[256];
						SQL_GetError(database, error, sizeof(error));
						SetFailState("%s Updating player table into \"%s\" failed! (%s)", logprefix, playerlist, error);
					}
					case	false:
					{
						int points = GetClientPoints(auth);
						CPrintToChatAll("%s {grey}%N {default}(%i) has connected.", Prefix, client, points);
						PrintToServer("%s %N (%i points) has connected.", logprefix, client, points);
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
	if(Tklib_IsValidClient(client, true, false, false))
	{
		CreateTimer(60.0, IntervalPlayTimer, client, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	}
}

Action IntervalPlayTimer(Handle timer, int client)
{
	if(!IsClientConnected(client))
	{
		KillTimer(timer);
		return	Plugin_Handled;
	}
	
	char auth[64];
	GetClientAuth(client, auth, sizeof(auth));
	
	Session[client].Time++;
	
	char query[256];
	Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where SteamID='%s'", playerlist, auth);
	db.Query(DBQuery_IntervalPlayTimer, query, client);
	
	return	Plugin_Handled;
}