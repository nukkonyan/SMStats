/**
 *	Returns the amount of points a player has.
 *
 *	@param	auth	The players steam authentication id.
 */
stock int GetClientPoints(const char[] auth)	{
	int points = 0;
	Database database = SQL_Connect2(Xstats, false);
	
	if(database != null)	{
		DBResultSet results = SQL_QueryEx(database, "select Points from `%s` where SteamID='%s' and ServerID='%i'", playerlist, auth, ServerID.IntValue);
		points = (results != null && results.FetchRow()) ? results.FetchInt(0) : 0;
		delete results;
	}
	
	delete database;
	return points;
}

/**
 *	Returns the position of the player.
 *
 *	@param	auth	The players steam authentication id.
 */
stock int GetClientPosition(const char[] auth)	{
	int position = 0;
	int points = 0;
	Database database = SQL_Connect2(Xstats, false);
	
	if(database != null)	{
		DBResultSet results = SQL_QueryEx(database, "select Points from `%s` where SteamID='%s' and ServerID='%i'", playerlist, auth, ServerID.IntValue);
		while(results != null && results.FetchRow())	{
			points = results.FetchInt(0);
			
			results = SQL_QueryEx(database, "select count(*) from `%s` where Points >='%i' and ServerID='%i'", playerlist, points, ServerID.IntValue);
			while(results.FetchRow())
				position = results.FetchInt(0);
		}
		
		delete results;
	}
	
	delete database;
	return position;
}

/**
 *	Returns the total player count in a database table.
 */
stock int GetTablePlayerCount()	{
	int playercount = 0;
	Database database = SQL_Connect2(Xstats, false);
	
	if(database != null)	{
		DBResultSet results = SQL_QueryEx(database, "select count(*) from `%s` where ServerID='%i'", playerlist, ServerID.IntValue);
		while(results != null && results.FetchRow())
			playercount = results.FetchInt(0);
		
		delete results;
	}
	
	delete database;
	return playercount;
}

/**
 *	Returns the amount of playtime in minutes a player has.
 *
 *	@param	auth	The players steam authentication id.
 */
stock int GetClientPlayTime(const char[] auth)	{
	int playtime = 0;
	Database database = SQL_Connect2(Xstats, false);
	
	if(database != null)	{
		DBResultSet results = SQL_QueryEx(database, "select PlayTime from `%s` where SteamID='%s' and ServerID='%i'", playerlist, auth, ServerID.IntValue);
		playtime = (results != null && results.FetchRow()) ? results.FetchInt(0) : 0;
		delete results;
	}
	
	delete database;
	return playtime;
}

/**
 *	Returns the KDR (Kill-Death-Ratio)
 *
 *	@param	kills	The kill count to check.
 *	@param	deaths	The death count to check.
 *	@param	assists	The assist count to check.
 */
stock float GetKDR(int kills, int deaths, int assists)	{
	float kdr = 1.00;
	float fkills = float(kills);
	float fdeaths = float(deaths);
	float fassists = float(assists);
	
	fkills = fkills + (fassists / 2.0);
	
	if(Debug.BoolValue)	{
		PrintToServer("//===== GetKDR =====//");
		PrintToServer("kills: %i", kills);
		PrintToServer("deaths: %i", deaths);
		PrintToServer("assists: %i", assists);
		PrintToServer("fkills: %.2f", float(kills));
		PrintToServer("fkills = fkills + (fassists / 2.0): %.2f", fkills);
		PrintToServer("fdeaths: %.2f", fdeaths);
		PrintToServer("fassists: %.2f", fassists);
	}
	
	if(fdeaths == 0.0)
		fdeaths = 1.0;
	
	if(Debug.BoolValue)
		PrintToServer("after fdeaths check: %.2f", fdeaths);
	
	kdr = fkills / fdeaths;
	if(Debug.BoolValue)	{
		PrintToServer("kdr: %.2f", kdr);
		PrintToServer(" ");
	}
	
	return kdr;
}

/**
 *	Add session points. Just to make it easier :)
 */
stock void AddSessionPoints(int client, int value)	{
	Session[client].Points += value;
}

/**
 *	Remove session points. Just to make it easier :)
 */
stock void RemoveSessionPoints(int client, int value)	{
	Session[client].Points -= value;
}

/**
 *	Update players last connected time state.
 *
 *	@param	auth	The players steam authentication id.
 */
stock void UpdateLastConnectedState(const char[] auth)	{
	char query[512];
	Format(query, sizeof(query), "update `%s` Set LastConnected='%i' where SteamID='%s' and ServerID='%i'",
	playerlist, GetTime(), auth, ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
}

/**
 *	Remove players from the database table if found too old.
 *
 *	@param	days	If the player has not been in this many days, the player gets removed.
 */
stock void RemoveOldConnectedPlayers(int days = 30)	{
	int time = GetTime() - (days * 86400);
	char query[512];
	Format(query, sizeof(query), "select SteamID `%s` where LastConnected < '%i' and ServerID='%i'",
	playerlist, time, ServerID.IntValue);
	
	DataPack pack = new DataPack();
	pack.WriteCell(time);
	pack.WriteCell(days);
	db.Query(DBQuery_RemoveOldPlayers_1, query, days);
}

stock void DBQuery_RemoveOldPlayers_1(Database database, DBResultSet results, const char[] error, DataPack pack)	{
	pack.Reset();
	int time = pack.ReadCell();
	int days = pack.ReadCell();
	delete pack;
	
	if(results == null)
		SetFailState("%s Deleting old players failed! (%s)", LogTag, error);
	
	int count = 0;
	while(results.FetchRow())	{
		count++;
		
		char auth[64];
		results.FetchString(0, auth, sizeof(auth));
		if(Debug.BoolValue)
			PrintToServer("%s [%i] Deleted %s from database after %i days of no activity",
			LogTag, count, auth, days);
	}
	
	/* Avoid spamming this in the while loop */
	if(count > 0)	{
		char query[512];
		Format(query, sizeof(query), "delete from `%s` where LastLastConnectedServerID='%i'",
		playerlist, time, ServerID.IntValue);
		db.Query(DBQuery_RemoveOldPlayers_2, query);
	}
}

stock void DBQuery_RemoveOldPlayers_2(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		SetFailState("%s Deleting old players failed! (%s)", LogTag, error);
}

//====================//
// Database stuff.
//====================//

/**
 *	Callback query for death events.
 */
stock void DBQuery_Callback(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		SetFailState("%s Updating table \"%s\" failed! (%s)", logprefix, playerlist, error);
}

/**
 *	Callback query for kill log.
 */
stock void DBQuery_Kill_Log(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		SetFailState("%s Adding kill log event to \"%s\" failed! (%s)", logprefix, kill_log, error);
}

/**
 *	Callback query for playtimer.
 */
void DBQuery_IntervalPlayTimer(Database database, DBResultSet results, const char[] error, int client)	{
	if(!IsClientConnected(client))
		return;
	
	if(results == null)
		SetFailState("%s Updating playtime by 1 minute for client index %i to \"%s\" failed! (%s)", logprefix, client, playerlist, error);
}

/**
 *	Callback query for database query insertions.
 */
void DBQuery_DB(Database database, DBResultSet results, const char[] error, int data)	{
	if(results == null)
		SetFailState("%s Creating query for database table id %i failed! (%s)", logprefix, data, error);
}

/**
 *	Callback for the panel.
 */
int PanelCallback(Menu menu, MenuAction action, int client, int selection)	{}

/**
 *	Check active players.
 */
stock void CheckActivePlayers()	{
	int needed = MinimumPlayers.IntValue;
	int players = GetClientCountEx(!AllowBots.BoolValue);
	//PrintToServer("Players: [%i/%i]", players, needed);
	
	switch(RankActive)	{
		case	true:	{
			if(needed > players)	{
				RankActive = false;
				
				CPrintToChatAll("%s Not enough players [%i/%i], disabling..", Prefix, players, needed);
				if(Debug.BoolValue)
					PrintToServer("%s Not Enough Players [%i/%i], disabling..", Prefix, players, needed);
			}
		}
		case	false:	{
			if(needed <= players)	{
				if(RoundActive)	{
					RankActive = true;
					CPrintToChatAll("%s Enough players [%i/%i], enabling..", Prefix, players, needed);
					if(Debug.BoolValue)
						PrintToServer("%s Enough Players [%i/%i], enabling..", Prefix, players, needed);
				}
			}
		}
	}
}

/**
 *	Make sure the stats is properly configured.
 */
stock bool IsValidStats()	{
	if(!PluginActive.BoolValue || !RankActive || WarmupActive && !AllowWarmup.BoolValue)
		return	false;
	return	true;
}