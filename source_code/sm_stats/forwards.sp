stock void LoadForwardEvents()
{
	switch(GetEngineVersion())
	{
		case Engine_TF2, Engine_CSS:
		{
			HookEvent("player_connect_client", OnPlayerConnected, EventHookMode_Pre);
		}
	}
	
	HookEvent("player_disconnect", OnPlayerDisconnected, EventHookMode_Pre);
}

// player connected event

public void OnClientConnected(int client)
{
	if(!bLoaded)
	{
		return;
	}
	
	if(!sql)
	{
		PrintToServer("%s OnClientConnected error: No database connection.", core_chattag);
		return;
	}
	
	if(!IsValidClient(client))
	{
		return;
	}
	
	int userid = GetClientUserId(client);
	
	if(!GetClientAuthId(client, AuthId_Steam2, g_Player[client].auth, sizeof(g_Player[].auth), false))
	{
		PrintToServer("%s OnClientConnected error: Failed to authenticate steamid of user index %i (userid %i)", core_chattag, client, userid);
		return;
	}
	if(!GetClientAuthId(client, AuthId_SteamID64, g_Player[client].profileid, sizeof(g_Player[].profileid), false))
	{
		PrintToServer("%s OnClientConnected error: Failed to authenticate profileid of user index %i (userid %i)", core_chattag, client, userid);
		return;
	}
	
	if(strlen(g_Player[client].auth) < 1)
	{
		PrintToServer("%s OnClientConnected error: Obtained an empty steamid from user index (userid %i)", core_chattag, client, userid);
		return;
	}
	if(strlen(g_Player[client].profileid) < 1)
	{
		PrintToServer("%s OnClientConnected error: Obtained an empty profileid from user index (userid %i)", core_chattag, client, userid);
		return;
	}
	
	g_Player[client].userid = userid;
	GetPlayerName(client, g_Player[client].name, sizeof(g_Player[].name));
	Format(g_Player[client].name2, sizeof(g_Player[].name2), "%N", client);
	
	if(!GetClientIP(client, g_Player[client].ip, sizeof(g_Player[].ip)))
	{
		PrintToServer("%s OnClientConnect error: Failed to obtain ip from user index %i (userid %i)", core_chattag, client, userid);
		return;
	}
	
	Transaction txn = new Transaction();
	char query[255];
	
	Format(query, sizeof(query), "select ServerID from `"...sql_table_playerlist..."` where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
	txn.AddQuery(query, 1);
	
	Format(query, sizeof(query), "select ServerID from `"...sql_table_weapons..."` where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
	txn.AddQuery(query, 2);
	
	Format(query, sizeof(query), "select * from `"...sql_table_settings..."` where SteamID = '%s'", g_Player[client].auth);
	txn.AddQuery(query, 3);
	
	sql.Execute(txn, CheckUserSQL_Success, CheckUserSQL_Failed, userid);
	
	//g_Player[client].bAlreadyConnected = true;
}

public void OnClientPutInServer(int client)
{
	CheckActivePlayers();
	
	SDKHook(client, SDKHook_OnTakeDamage, OnPlayerTakeDamage);
	
	CreateTimer(60.0, Timer_TimePlayed, GetClientUserId(client), TIMER_REPEAT);
}

public void OnClientSettingsChanged(int client)
{
	if(!bLoaded)
	{
		return;
	}
	
	// too early to gather info, delay has to be added..
	CreateTimer(0.2, Timer_OnPlayerUpdated, GetClientUserId(client));
}

Action Timer_OnPlayerUpdated(Handle timer, int userid)
{
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid)), false))
	{
		UpdatePlayerName(client);
		
		// check & obtain player name
		char name[64];
		GetClientName(client, name, sizeof(name));
		
		// no name stored yet.
		if(strlen(g_Player[client].name2) < 1)
		{
			strcopy(g_Player[client].name2, sizeof(g_Player[].name2), name);
		}
		// duplicate runs of same event.
		else if(!StrEqual(name, g_Player[client].name2))
		{
			strcopy(g_Player[client].name2, sizeof(g_Player[].name2), name);
			
			CallbackQuery("update `"...sql_table_playerlist..."` set PlayerName = '%s' where SteamID = '%s' and ServerID = %i"
			, query_error_uniqueid_OnPlayerNameUpdate
			, name, g_Player[client].auth, g_ServerID);
		}
	}
	
	return Plugin_Continue;
}

void CheckUserSQL_Success(Database db, int userid, int numQueries, DBResultSet[] results, int[] queryData)
{
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		PrintToServer("%s CheckUser_SQL error: Attempted reading invalid userid %i (Disconnected during query?)", core_chattag, userid);
		return;
	}
	
	Transaction txn = new Transaction();
	
	for(int i = 0; i < numQueries; i++)
	{
		int query_id = queryData[i];
		char query[256];
		
		switch(query_id)
		{
			// playerlist
			case 1:
			{
				// we have to do this way, as transaction sql query is bugged with 'valid' null results.
				int server_id = -1;
				
				if(results[i] != null && results[i].FetchRow())
				{
					server_id = results[i].FetchInt(0);
				}
				
				char name[64];
				GetClientName(client, name, sizeof(name));
				TrimString(name);
				
				if(server_id >= 0)
				{
					// found table, update it.
					Format(query, sizeof(query), "update `"...sql_table_playerlist..."` set LastConnected = %i, IPAddress = '%s', PlayerName = '%s' where SteamID = '%s' and ServerID = %i"
					, GetTime(), g_Player[client].ip, g_Player[client].name2, g_Player[client].auth, g_ServerID);
					txn.AddQuery(query, 1);
				}
				else
				{
					// table not found, insert it.
					Format(query, sizeof(query), "insert into `"...sql_table_playerlist..."` (LastConnected, IPAddress, PlayerName, SteamID, ServerID) values (%i, '%s', '%s', '%s', %i)"
					, GetTime(), g_Player[client].ip, g_Player[client].name2, g_Player[client].auth, g_ServerID);
					txn.AddQuery(query, 2);
				}
			}
			// weapons
			case 2:
			{
				int server_id = -1;
				
				if(results[i] != null && results[i].FetchRow())
				{
					server_id = results[i].FetchInt(0);
				}
				
				if(server_id >= 0)
				{
					// query 3
				}
				else
				{
					// table not found, insert it.
					Format(query, sizeof(query), "insert into `"...sql_table_weapons..."` (SteamID, ServerID) values ('%s', %i)", g_Player[client].auth, g_ServerID);
					txn.AddQuery(query, 4);
				}
			}
			// settings
			case 3:
			{
				int row_count = results[i].RowCount;
				
				if(row_count > 0)
				{
					char sQuery[1024];
					Format(sQuery, sizeof(sQuery), "select"
					/*0*/..." PlayConnectSnd"
					/*1*/...",ShowFragMsg"
					/*2*/...",ShowAssistMsg"
					/*3*/...",ShowDeathMsg"
					..." from `"...sql_table_settings..."` where SteamID = '%s'", g_Player[client].auth);
					txn.AddQuery(sQuery, 5);
				}
				else
				{
					// table not found, insert it.
					Format(query, sizeof(query), "insert into `"...sql_table_settings..."` (SteamID) values ('%s')", g_Player[client].auth);
					txn.AddQuery(query, 6);
				}
			}
		}
	}
	
	db.Execute(txn, CheckUserSQL_Query_Success, CheckUserSQL_Query_Failed, userid);
}

void CheckUserSQL_Failed(Database db, int userid, int numQueries, const char[] error, int failIndex, int[] queryData)
{
	PrintToServer("%s CheckUser_SQL error: query id %i failed! (%s)", core_chattag, queryData[failIndex], error);
}

void CheckUserSQL_Query_Success(Database db, int userid, int numQueries, DBResultSet[] results, int[] queryData)
{
	int client;
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		PrintToServer("%s CheckUserSQL_Query error: Attempted reading invalid userid %i (Disconnected during query?)", core_chattag, userid);
		return;
	}
	
	for(int i = 0; i < numQueries; i++)
	{
		int query_id = queryData[i];
		
		switch(query_id)
		{
			// updated playerlist table
			case 1:
			{
				g_TotalTablePlayers = GetTablePlayerCount();
				
				char query[256];
				Format(query, sizeof(query), "select Points from `"...sql_table_playerlist..."` where SteamID = '%s' and ServerID = %i"
				, g_Player[client].auth, g_ServerID);
				sql.Query(DBQuery_CheckUserSQL_Points, query, client);
			}
			
			// inserted playerlist table
			case 2:
			{
				g_TotalTablePlayers = GetTablePlayerCount();
				g_Player[client].points = _sm_stats_default_points;
				Send_Player_Connected(g_Player[client]);
			}
			
			// read weapons table
			case 3:
			{
				
			}
			
			// inserted weapons table
			case 4:
			{
				
			}
			
			// read settings table
			case 5:
			{
				if(results[i].FetchRow())
				{
					g_Player[client].bPlayConSnd = view_as<bool>(results[i].FetchInt(0));
					g_Player[client].bShowFragMsg = view_as<bool>(results[i].FetchInt(1));
					g_Player[client].bShowAssistMsg = view_as<bool>(results[i].FetchInt(2));
					g_Player[client].bShowDeathMsg = view_as<bool>(results[i].FetchInt(3));
				}
			}
			
			// inserted settings table
			case 6:
			{
				g_Player[client].bPlayConSnd = false
				g_Player[client].bShowFragMsg = true;
				g_Player[client].bShowAssistMsg = true;
				g_Player[client].bShowDeathMsg = true;
			}
		}
	}
}

void DBQuery_CheckUserSQL_Points(Database db, DBResultSet results, const char[] error, int client)
{
	switch(results != null && results.FetchRow())
	{
		case false:
		{
			PrintToServer("%s CheckUserSQL_Points error: Failed to obtain points for user index %i (userid %i)\nError: %s"
			, core_chattag, client, g_Player[client].userid, error);
		}
		
		case true:
		{
			g_Player[client].points = results.FetchInt(0);
			Send_Player_Connected(g_Player[client]);
		}
	}
}

void CheckUserSQL_Query_Failed(Database db, int userid, int numQueries, const char[] error, int failIndex, any[] queryData)
{
	PrintToServer("%s CheckUserSQL_Query error: query id %i failed (%s)", core_chattag, queryData[failIndex], error);
}

void OnPlayerConnected(Event event, const char[] event_name, bool dontBroadcast)
{
	if(bLoaded) event.BroadcastDisabled = true;
}

// player disconnected event

public void OnClientDisconnect_Post(int client)
{
	SMStatsInfo.ResetPlayerStats(client);
	
	if(!IsValidStats())
	{
		return;
	}
	
	if(g_Player[client].session[Stats_DamageDone] > 0)
	{
		UpdateDamageDone(g_Player[client]);
	}
	
	g_Player[client].Reset();
	
	CheckActivePlayers();
	
	OnClientDisconnect_Post_Game(client);
}

void OnPlayerDisconnected(Event event, const char[] event_name, bool dontBroadcast)
{
	if(bLoaded)
	{
		int client, userid = event.GetInt("userid");
		if(userid > 0)
		{
			if(IsValidClient((client = GetClientOfUserId(userid))))
			{
				event.BroadcastDisabled = true;
				
				char event_reason[256], auth[64];
				event.GetString("reason", event_reason, sizeof(event_reason));
				GetClientAuthId(client, AuthId_Steam2, auth, sizeof(auth));
				int timestamp = GetTime();
				
				char query[255];
				Format(query, sizeof(query), "select PlayTime from `"...sql_table_playerlist..."` where SteamID = '%s' and ServerID = %i"
				, auth, g_ServerID);
				DataPack pack = new DataPack();
				pack.WriteCell(strlen(auth)+1);
				pack.WriteString(auth);
				pack.WriteCell(timestamp);
				pack.WriteCell(g_Player[client].session[Stats_PlayTime]);
				pack.Reset();
				sql.Query(DBQuery_OnPlayerDisconnected, query, pack);
				
				Send_Player_Disconnected(g_Player[client], event_reason);
			}
		}
	}
}

void DBQuery_OnPlayerDisconnected(Database database, DBResultSet results, const char[] error, DataPack pack)
{
	int maxlen = pack.ReadCell();
	char[] auth = new char[maxlen];
	pack.ReadString(auth, maxlen);
	int timestamp = pack.ReadCell();
	int session_PlayTime = pack.ReadCell();
	delete pack;
	
	if(results == null)
	{
		PrintToServer("%s OnPlayerDisconnected() Error: Failed checking user on disconnect\nSteamID: %s\nError below:\n%s"
		, core_chattag, auth, error);
		return;
	}
	
	if(results.FetchRow())
	{
		int PlayTime = results.FetchInt(0);
		int calculate = session_PlayTime - PlayTime;
		
		CallbackQuery("update `" ... sql_table_playerlist ... "` set LastConnected = %i, PlayTime = PlayTime+%i where SteamID = '%s' and ServerID = '%s'"
		, query_error_uniqueid_OnPlayerDisconnectUpdateLastConnected
		, timestamp, calculate, auth, g_ServerID);
	}
}

//

Action OnPlayerTakeDamage(int victim, int &client, int &inflictor, float &damage, int &damagetype)
{
	if(IsValidClient(victim) && IsValidClient(client, true))
	{
		if(GetClientTeam(victim) != GetClientTeam(client) && client != victim)
		{
			//Turn the float into a valid integer.
			char getdmg[96];
			FloatToString(damage, getdmg, sizeof(getdmg));
			SplitString(getdmg, ".", getdmg, sizeof(getdmg));
			int dmg = StringToInt(getdmg);
			
			//PrintToChatAll("[%N] Damage done: %i", client, dmg);
			
			#if defined assister_func
			g_PlayerDamaged[victim][client] += dmg;
			#endif
			
			g_Player[client].session[Stats_DamageDone] += dmg;
		}
	}
	
	return Plugin_Continue;
}

//

Action Timer_TimePlayed(Handle timer, int userid)
{
	int client = 0;
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		KillTimer(timer);
		return Plugin_Handled;
	}
	
	if(sql != null)
	{
		char query[255];
		Format(query, sizeof(query), "select PlayTime from `" ... sql_table_playerlist ..."` where SteamID = '%s' and ServerID = %i"
		, g_Player[client].auth, g_ServerID);
		sql.Query(DBQuery_TimePlayed, query, userid);
		
		if(g_Player[client].active_page_session == 1)
		{
			StatsMenu.Session(client, 1);
		}
	}
	
	return Plugin_Continue;
}

void DBQuery_TimePlayed(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		PrintToServer("%s Attempted to check playtime of userid %i that isn't valid!", core_chattag, userid);
		return;
	}
	
	if(results == null)
	{
		PrintToServer("%s Attemped to check playtime of userid %i but results is invalid!\nError below:\n%s", core_chattag, userid, error);
		return;
	}
	
	if(results.FetchRow())
	{
		int PlayTime = results.FetchInt(0);
		int session = g_Player[client].session[Stats_PlayTime];
		int calculate = session - PlayTime;
		CallbackQuery("update `" ... sql_table_playerlist ..."` set PlayTime = PlayTime+%i where SteamID = '%s' and ServerID = %i"
		, query_error_uniqueid_UpdatePlayTime
		, calculate
		, g_Player[client].auth
		, g_ServerID);
	}
}

public void OnMapStart()
{
	GetCurrentMap(cMap, sizeof(cMap));
	if(hMapTimer == null)
	{
		hMapTimer = CreateTimer(60.0, MapTimer_OnMapStart_Minutes, _, TIMER_REPEAT);
	}
	if(hMapTimerSeconds == null)
	{
		hMapTimerSeconds = CreateTimer(1.0, MapTimer_OnMapStart_Seconds, _, TIMER_REPEAT);
	}
	if(hGameTimer == null)
	{
		hGameTimer = CreateTimer(0.215751257555125, MapTimer_GameTimer, _, TIMER_REPEAT);
	}
}

public void OnMapEnd()
{
	if(hMapTimer != null)
	{
		KillTimer(hMapTimer);
		hMapTimer = null;
	}
	
	if(hMapTimerSeconds != null)
	{
		KillTimer(hMapTimerSeconds)
		hMapTimerSeconds = null;
		UpdateMapTimerSeconds(cMap, iMapTimerSeconds);
		iMapTimerSeconds = 0;
	}
	
	if(hGameTimer != null)
	{
		KillTimer(hGameTimer);
		hGameTimer = null;
	}
}

Action MapTimer_OnMapStart_Minutes(Handle timer)
{
	SQLUpdateMapTimer();
	return Plugin_Continue;
}

Action MapTimer_OnMapStart_Seconds(Handle timer)
{
	iMapTimerSeconds++;
	_sm_stats_info_update_maptimer(iMapTimerSeconds);
	return Plugin_Continue;
}

//

void SQLUpdateMapTimer()
{
	if(sql != null)
	{
		char query[255];
		Format(query, sizeof(query), "select PlayTime from `"...sql_table_maps_log..."` where MapName = '%s' and ServerID = %i", cMap, g_ServerID);
		sql.Query(DBQuery_MapTimer, query);
	}
}

void DBQuery_MapTimer(Database db, DBResultSet results, const char[] error, any data)
{
	switch(results != null && results.RowCount > 0)
	{
		// not found
		case false:
		{
			CallbackQuery("insert into `" ... sql_table_maps_log ... "` (PlayTime, ServerID, MapName) values (%i, %i, '%s')"
			, query_error_uniqueid_UpdateMapTimeInserting
			, iMapTimerSeconds, g_ServerID, cMap);
		}
		// found
		case true:
		{
			if(results.FetchRow())
			{
				int PlayTime = results.FetchInt(0);
				int session = iMapTimerSeconds;
				int calculate = session - PlayTime;
				
				CallbackQuery("update `" ... sql_table_maps_log ... "` set PlayTime = PlayTime+%i where ServerID = %i and MapName = '%s'"
				, query_error_uniqueid_UpdateMapTimeUpdating
				, calculate, g_ServerID, cMap);
			}
		}
	}
}

void UpdateMapTimerSeconds(const char[] map, int seconds)
{
	if(sql != null)
	{
		char query[255];
		Format(query, sizeof(query), "select PlayTime from `"...sql_table_maps_log..."` where MapName = '%s' and ServerID = %i", map, g_ServerID);
		DataPack pack = new DataPack();
		pack.WriteCell(strlen(map)+1);
		pack.WriteString(map);
		pack.WriteCell(seconds);
		pack.Reset();
		sql.Query(DBQuery_UpdateMapTimerSeconds, query, pack);
	}
}

void DBQuery_UpdateMapTimerSeconds(Database db, DBResultSet results, const char[] error, DataPack pack)
{
	int maxlen = pack.ReadCell();
	char[] map = new char[maxlen];
	pack.ReadString(map, maxlen);
	int seconds = pack.ReadCell();
	delete pack;
	
	if(results.FetchRow())
	{
		int PlayTime = results.FetchInt(0);
		int session = seconds;
		int calculate = session - PlayTime;
		
		CallbackQuery("update `" ... sql_table_maps_log ... "` set PlayTime = PlayTime+%i where ServerID = %i and MapName = '%s'"
		, query_error_uniqueid_UpdateMapTimeUpdatingSeconds
		, calculate, g_ServerID, map);
	}
}