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
		PrintToServer("[SM Stats] OnClientConnected error: No database connection.");
		return;
	}
	
	if(!IsValidClient(client))
	{
		return;
	}
	
	int userid = GetClientUserId(client);
	
	if(!GetClientAuthId(client, AuthId_Steam2, g_Player[client].auth, sizeof(g_Player[].auth), false))
	{
		PrintToServer("[SM Stats] OnClientConnected error: Failed to authenticate user index %i (userid %i)", client, userid);
		return;
	}
	
	if(strlen(g_Player[client].auth) < 1)
	{
		PrintToServer("[SM Stats] OnClientConnected error: Obtained an empty steamid of user index (userid %i)", client, userid);
		return;
	}
	
	g_Player[client].userid = userid;
	GetPlayerName(client, g_Player[client].name, sizeof(g_Player[].name));
	GetClientName(client, g_Player[client].name2, sizeof(g_Player[].name2));
	
	if(!GetClientIP(client, g_Player[client].ip, sizeof(g_Player[].ip)))
	{
		PrintToServer("[SM Stats] Failed to obtain ip from user index %i (userid %i)", client, userid);
		return;
	}
	
	Transaction txn = new Transaction();
	char query[256];
	
	Format(query, sizeof(query), "select ServerID from `%s` where SteamID = '%s' and ServerID = %i", sql_table_playerlist, g_Player[client].auth, g_ServerID);
	txn.AddQuery(query, 1);
	
	Format(query, sizeof(query), "select ServerID from `%s` where SteamID = '%s' and ServerID = %i", sql_table_weapons, g_Player[client].auth, g_ServerID);
	txn.AddQuery(query, 2);
	
	sql.Execute(txn, CheckUserSQL_Success, CheckUserSQL_Failed, g_Player[client].userid);
	
	//g_Player[client].bAlreadyConnected = true;
}

public void OnClientPutInServer(int client)
{
	CheckActivePlayers();
	
	SDKHook(client, SDKHook_OnTakeDamage, OnPlayerTakeDamage);
	
	CreateTimer(60.0, Timer_MinutePlayed, GetClientUserId(client), TIMER_REPEAT);
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
			
			CallbackQuery("update `%s` set PlayerName = '%s' where SteamID = '%s' and ServerID = %i"
			, query_error_uniqueid_OnPlayerNameUpdate
			, sql_table_playerlist, name, g_Player[client].auth, g_ServerID);
		}
	}
	
	return Plugin_Continue;
}

void CheckUserSQL_Success(Database db, int userid, int numQueries, DBResultSet[] results, int[] queryData)
{
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		PrintToServer("[SM Stats] CheckUser_SQL error: Attempted reading invalid userid %i (Disconnected during query?)", userid);
		return;
	}
	
	Transaction txn = new Transaction();
	
	for(int i = 0; i < numQueries; i++)
	{
		int query_id = queryData[i];
		char query[256];
		
		switch(query_id)
		{
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
					Format(query, sizeof(query), "update `%s` set LastConnected = %i, IPAddress = '%s', PlayerName = '%s' where SteamID = '%s' and ServerID = %i"
					, sql_table_playerlist, GetTime(), g_Player[client].ip, g_Player[client].name2, g_Player[client].auth, g_ServerID);
					txn.AddQuery(query, 1);
				}
				else
				{
					// table not found, insert it.
					Format(query, sizeof(query), "insert into `%s` (LastConnected, IPAddress, PlayerName, SteamID, ServerID) values (%i, '%s', '%s', '%s', %i)"
					, sql_table_playerlist, GetTime(), g_Player[client].ip, g_Player[client].name2, g_Player[client].auth, g_ServerID);
					txn.AddQuery(query, 2);
				}
			}
			
			case 2:
			{
				int server_id = -1;
				
				if(results[i] != null && results[i].FetchRow())
				{
					server_id = results[i].FetchInt(0);
				}
				
				if(server_id >= 0)
				{
					
				}
				else
				{
					// table not found, insert it.
					Format(query, sizeof(query), "insert into `%s` (SteamID, ServerID) values ('%s', %i)"
					, sql_table_weapons, g_Player[client].auth, g_ServerID);
					txn.AddQuery(query, 4);
				}
			}
		}
	}
	
	db.Execute(txn, CheckUserSQL_Query_Success, CheckUserSQL_Query_Failed, userid);
}

void CheckUserSQL_Failed(Database db, int userid, int numQueries, const char[] error, int failIndex, int[] queryData)
{
	PrintToServer("[SM Stats] CheckUser_SQL error: query id %i failed! (%s)", queryData[failIndex], error);
}

void CheckUserSQL_Query_Success(Database db, int userid, int numQueries, DBResultSet[] results, int[] queryData)
{
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		PrintToServer("[SM Stats] CheckUserSQL_Query error: Attempted reading invalid userid %i (Disconnected during query?)", userid);
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
				Format(query, sizeof(query), "select Points from `%s` where SteamID = '%s' and ServerID = %i"
				, sql_table_playerlist, g_Player[client].auth, g_ServerID);
				sql.Query(DBQuery_CheckUserSQL_Points, query, client);
			}
			
			// inserted playerlist table
			case 2:
			{
				g_TotalTablePlayers = GetTablePlayerCount();
				g_Player[client].points = _sm_stats_default_points;
				Send_Player_Connected(g_Player[client]);
			}
			
			// updated weapons table
			case 3:
			{
				
			}
			
			// inserted weapons table
			case 4:
			{
				
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
			PrintToServer("[SM Stats] CheckUserSQL_Points error: Failed to obtain points for user index %i (userid %i)\nError: %s"
			, client, g_Player[client].userid, error);
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
	PrintToServer("[SM Stats] CheckUserSQL_Query error: query id %i failed (%s)", queryData[failIndex], error);
}

void OnPlayerConnected(Event event, const char[] event_name, bool dontBroadcast)
{
	if(bLoaded) event.BroadcastDisabled = true;
}

// player disconnected event

public void OnClientDisconnect_Post(int client)
{
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
				
				CallbackQuery("update `" ... sql_table_playerlist ... "` set LastConnected = %i where SteamID = '%s' and ServerID = '%s'"
				, query_error_uniqueid_OnPlayerDisconnectUpdateLastConnected
				, GetTime(), auth, g_ServerID);
				
				Send_Player_Disconnected(g_Player[client], event_reason);
			}
		}
	}
}

//

Action OnPlayerTakeDamage(int victim, int &client, int &inflictor, float &damage, int &damagetype)
{
	if(IsValidClient(victim) && IsValidClient(client, true) && GetClientTeam(victim) != GetClientTeam(client))
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
	
	return Plugin_Continue;
}

//

Action Timer_MinutePlayed(Handle timer, int userid)
{
	int client = 0;
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		KillTimer(timer);
		return Plugin_Handled;
	}
	
	g_Player[client].session[Stats_PlayTime]++;
	
	CallbackQuery("update `%s` set PlayTime = PlayTime+1 where SteamID = '%s' and ServerID = %i"
	, query_error_uniqueid_UpdatePlayTime
	, sql_table_playerlist
	, g_Player[client].auth
	, g_ServerID);
	
	if(g_Player[client].active_page_session > 0)
	{
		StatsMenu.Session(client, g_Player[client].active_page_session);
	}
	
	return Plugin_Continue;
}

// map load event

Handle hMapTimer = null;
char cMap[64];

public void OnMapStart()
{
	GetCurrentMap(cMap, sizeof(cMap));
	hMapTimer = CreateTimer(60.0, MapTimer_OnMapStart, _, TIMER_REPEAT);
}

public void OnMapEnd()
{
	if(hMapTimer != null)
	{
		KillTimer(hMapTimer);
		hMapTimer = null;
	}
}

Action MapTimer_OnMapStart(Handle timer)
{
	SQLUpdateMapTimer();
	return Plugin_Continue;
}

//

void SQLUpdateMapTimer()
{
	if(sql != null)
	{
		char query[255];
		Format(query, sizeof(query), "select ServerID from `%s` where MapName = '%s' and ServerID = %i"
		, sql_table_maps_log
		, cMap, g_ServerID);
		sql.Query(DBQuery_MapTimer_1, query);
	}
}

void DBQuery_MapTimer_1(Database db, DBResultSet results, const char[] error, any data)
{
	switch(results != null && (results.RowCount != 0))
	{
		// not found
		case false:
		{
			CallbackQuery("insert into `%s` (PlayTime, ServerID, MapName) values (1, %i, '%s')"
			, query_error_uniqueid_UpdateMapTimeInserting
			, sql_table_maps_log, g_ServerID, cMap);
		}
		// found
		case true:
		{
			CallbackQuery("update `%s` set PlayTime = PlayTime+1 where ServerID = %i and MapName = '%s'"
			, query_error_uniqueid_UpdateMapTimeUpdating
			, sql_table_maps_log, g_ServerID, cMap);
		}
	}
}