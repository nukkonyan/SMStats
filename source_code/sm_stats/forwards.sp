char szEventConn[][] =
{
	"player_connect_client",
	"player_connect"
};

stock int szEventConnType()
{
	switch(GetEngineVersion())
	{
		case Engine_Left4Dead2, Engine_CSGO:
		{
			return 1;
		}
	}
	
	return 0;
}

stock void LoadForwardEvents()
{
	HookEvent(szEventConn[szEventConnType()], OnPlayerConnected, EventHookMode_Pre);
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
		PrintToServer(core_chattag ..." OnClientConnected error: No database connection.");
		return;
	}
	
	if(!SMStats_IsValidConnected(client))
	{
		PrintToServer(core_chattag ... " OnClientConnected error: Invalid index %i", client);
		return;
	}
	
	int userid = (g_Player[client].userid = GetClientUserId(client));
	g_Player[client].iTeam = IsClientInGame(client) ? GetClientTeam(client) : 0;
	
	if(!GetClientAuthId(client, AuthId_Steam3, g_Player[client].auth, sizeof(g_Player[].auth), false))
	{
		LogMessage("OnClientConnected error: Failed to authenticate steamid3 of user index %i (userid %i)", client, userid);
		return;
	}
	if(strlen(g_Player[client].auth) < 1)
	{
		LogMessage("OnClientConnected error: Obtained an empty steamid from user index (userid %i)", client, userid);
		return;
	}
	
	if(!GetClientAuthId(client, AuthId_SteamID64, g_Player[client].profileid, sizeof(g_Player[].profileid), false))
	{
		LogMessage("OnClientConnected error: Failed to authenticate profileid of user index %i (userid %i)", client, userid);
		return;
	}
	if(strlen(g_Player[client].profileid) < 1)
	{
		LogMessage("OnClientConnected error: Obtained an empty profileid from user index (userid %i)", client, userid);
		return;
	}
	
	GetPlayerName(client, g_Player[client].name, sizeof(g_Player[].name), g_Player[client].name2, sizeof(g_Player[].name2));
	
	if(!GetClientIP(client, g_Player[client].ip, sizeof(g_Player[].ip)))
	{
		PrintToServer("%s OnClientConnect error: Failed to obtain ip from user index %i (userid %i)", core_chattag, client, userid);
		return;
	}
	
	Transaction txn = new Transaction();
	char query[255];
	
	Format(query, sizeof(query), "select * from `%s` where `auth`='%s'", sql.settings, g_Player[client].auth);
	txn.AddQuery(query, 1);
	
	Format(query, sizeof(query), "select `sID` from `%s` where `auth`='%s' and `sID`='%i'", sql.playerlist, g_Player[client].auth, g_StatsID);
	txn.AddQuery(query, 2);
	
	Format(query, sizeof(query), "select `sID` from `%s` where `auth`='%s' and `sID`='%i'", sql.weapons, g_Player[client].auth, g_StatsID);
	txn.AddQuery(query, 3);
	
	sql.setsuzoku.Execute(txn, CheckUserSQL_Success, CheckUserSQL_Failed, g_Player[client].userid);
	
	//g_Player[client].bAlreadyConnected = true;
}

public void OnClientPutInServer(int client)
{
	CheckActivePlayers();
	
	SDKHook(client, SDKHook_OnTakeDamage, OnPlayerTakeDamage);
	
	CreateTimer(60.0, Timer_TimePlayed, g_Player[client].userid, TIMER_REPEAT);
}

public void OnClientPostAdminCheck(int client)
{
	if(SMStats_IsValidClient(client))
	{
		Send_Player_Connected_CheckTop10(client);
	}
}

public void OnClientSettingsChanged(int client)
{
	if(bLoaded)
	{
		// too early to gather info, delay has to be added..
		CreateTimer(0.2, Timer_OnPlayerUpdated, g_Player[client].userid);
	}
}

Action Timer_OnPlayerUpdated(Handle timer, int userid)
{
	int client;
	if(SMStats_IsValidUserID(client, userid))
	{
		UpdatePlayerInfo(client);
		
		// check & obtain player name
		char name[64];
		GetClientName(client, name, sizeof(name));
		
		// no name stored yet.
		if(strlen(g_Player[client].name2) < 1)
		{
			strcopy(g_Player[client].name2, sizeof(g_Player[].name2), name);
		}
		// duplicate runs of same event.
		else if(strcmp(name, g_Player[client].name2) == -1)
		{
			strcopy(g_Player[client].name2, sizeof(g_Player[].name), name);
			
			CallbackQuery("update `%s` set `name`='%s' where `auth`='%s'"
			, query_error_uniqueid_OnPlayerNameUpdate
			, sql.settings, name, g_Player[client].auth);
		}
	}
	
	return Plugin_Continue;
}

ArrayList g_penaltySQLCheck;

void CheckUserSQL_Success(Database db, int userid, int numQueries, DBResultSet[] results, int[] queryData)
{
	int client;
	if(!IsValidConnectedUserID(client, userid))
	{
		PrintToServer("%s CheckUser_SQL error: Attempted reading invalid userid %i (Disconnected during query?)", core_chattag, userid);
		return;
	}
	
	Transaction txn = new Transaction();
	int timestamp = GetTime();
	
	for(int i = 0; i < numQueries; i++)
	{
		int query_id = queryData[i];
		
		switch(query_id)
		{
			// settings
			case 1:
			{
				int row_count = results[i].RowCount;
				
				switch(row_count > 0)
				{
					case true:
					{
						// table found
						char query[1024];
						Format(query, sizeof(query), "select"
						/*0*/..." Penalty"
						/*1*/...",PlayConnectSnd"
						/*2*/...",ShowConnectMsg"
						/*3*/...",ShowTopConnectMsg"
						/*4*/...",ShowFragMsg"
						/*5*/...",ShowAssistMsg"
						/*6*/...",ShowDeathMsg"
						..." from `%s` where `auth`='%s'", sql.settings, g_Player[client].auth);
						txn.AddQuery(query, 1);
						
						Format(query, sizeof(query), "update `%s` set `name`='%s' where `auth`='%s'"
						, sql.settings, g_Player[client].name2, g_Player[client].auth);
						txn.AddQuery(query, 2);
					}
					case false:
					{
						// table not found, insert it.
						char query[1024];
						Format(query, sizeof(query), "insert into `%s`"
						... " (`name`,`auth`,`ip`,`lcgame`,`lcsID`,`lct`) values"
						... " ('%s', '%s', '%s', '%s', '%i', '%i')"
						, sql.settings, g_Player[client].name2, g_Player[client].auth, g_Player[client].ip, GameType, g_StatsID, timestamp);
						txn.AddQuery(query, 3);
					}
				}
			}
			// playerlist
			case 2:
			{
				// we have to do this way, as transaction sql query is bugged with 'valid' null results.
				int stats_id = -1;
				
				if(results[i] != null && results[i].FetchRow())
				{
					stats_id = results[i].FetchInt(0);
				}
				
				if(stats_id >= 0)
				{
					// found table, update it.
					char query[256];
					Format(query, sizeof(query), "update `%s` set `lcn`='%s',`lct`='%i' where `auth`='%s' and `sID`='%i'"
					, sql.playerlist, g_Player[client].name2, timestamp, g_Player[client].auth, g_StatsID);
					txn.AddQuery(query, 4);
				}
				else
				{
					// table not found, insert it.
					char query[256];
					Format(query, sizeof(query), "insert into `%s` (`lcn`,`lct`,`auth`,`sID`) values ('%s','%i','%s','%i')"
					, sql.playerlist, g_Player[client].name2, timestamp, g_Player[client].auth, g_StatsID);
					txn.AddQuery(query, 5);
				}
			}
			// weapons
			case 3:
			{
				int stats_id = -1;
				
				if(results[i] != null && results[i].FetchRow())
				{
					stats_id = results[i].FetchInt(0);
				}
				
				if(stats_id >= 0)
				{
					// query 6
				}
				else
				{
					// table not found, insert it.
					char query[256];
					Format(query, sizeof(query), "insert into `%s` (`auth`,`sID`) values ('%s','%i')"
					, sql.weapons, g_Player[client].auth, g_StatsID);
					txn.AddQuery(query, 7);
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
	if(!IsValidConnectedUserID(client, userid))
	{
		PrintToServer("%s CheckUserSQL_Query error: Attempted reading invalid userid %i (Disconnected during query?)", core_chattag, userid);
		return;
	}
	
	//
	
	for(int i = 0; i < numQueries; i++)
	{
		int query_id = queryData[i];
		
		switch(query_id)
		{
			// read settings table
			case 1:
			{
				if(results[i].FetchRow())
				{
					g_Player[client].bPenalty = view_as<bool>(results[i].FetchInt(0));
					g_Player[client].bPlayConSnd = view_as<bool>(results[i].FetchInt(1));
					g_Player[client].bShowConMsg = view_as<bool>(results[i].FetchInt(2));
					g_Player[client].bShowTopConMsg = view_as<bool>(results[i].FetchInt(3));
					g_Player[client].bShowFragMsg = view_as<bool>(results[i].FetchInt(4));
					g_Player[client].bShowAssistMsg = view_as<bool>(results[i].FetchInt(5));
					g_Player[client].bShowDeathMsg = view_as<bool>(results[i].FetchInt(6));
					
					if(g_Player[client].bPenalty)
					{
						if(g_penaltySQLCheck == null)
						{
							g_penaltySQLCheck = new ArrayList(6);
						}
						
						g_penaltySQLCheck.Push(userid);
						g_penaltySQLCheck.PushString(g_Player[client].auth);
					}
				}
			}
			
			// inserted settings table
			case 2:
			{
				g_Player[client].bPenalty = false;
				g_Player[client].bPlayConSnd = true
				g_Player[client].bShowConMsg = true;
				g_Player[client].bShowTopConMsg = true;
				g_Player[client].bShowFragMsg = true;
				g_Player[client].bShowAssistMsg = true;
				g_Player[client].bShowDeathMsg = true;
			}
			
			// update settings playername table
			case 3:
			{
				
			}
			
			// updated playerlist table
			case 4:
			{
				g_TotalTablePlayers = GetTablePlayerCount();
				
				char query[256];
				Format(query, sizeof(query), "select `p` from `%s` where `auth`='%s' and `sID`='%i'"
				, sql.playerlist, g_Player[client].auth, g_StatsID);
				sql.setsuzoku.Query(DBQuery_CheckUserSQL_Points, query, client);
			}
			
			// inserted playerlist table
			case 5:
			{
				g_TotalTablePlayers = GetTablePlayerCount();
				g_Player[client].points = _sm_stats_default_points;
				Send_Player_Connected(client);
			}
			
			// read weapons table
			case 6:
			{
				
			}
			
			// inserted weapons table
			case 7:
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
			PrintToServer("%s CheckUserSQL_Points error: Failed to obtain points for user index %i (userid %i)\nError: %s"
			, core_chattag, client, g_Player[client].userid, error);
		}
		
		case true:
		{
			g_Player[client].points = results.FetchInt(0);
			Send_Player_Connected(client);
		}
	}
}

void CheckUserSQL_Query_Failed(Database db, int userid, int numQueries, const char[] error, int failIndex, any[] queryData)
{
	PrintToServer("%s CheckUserSQL_Query error: query id %i failed (%s)", core_chattag, queryData[failIndex], error);
}

void OnPlayerConnected(Event event, const char[] event_name, bool dontBroadcast)
{
	if(bLoaded)
	{
		//event.BroadcastDisabled = true; // this has no effect.
		SetEventBroadcast(event, true);
	}
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
	
	
	SMStatsInfo.ResetPlayerInfo(client);
	g_Player[client].Reset();
	
	CheckActivePlayers();
	
	OnClientDisconnect_Post_Game(client);
}

void OnPlayerDisconnected(Event event, const char[] event_name, bool dontBroadcast)
{
	if(bLoaded)
	{
		int client;
		if(SMStats_IsValidUserID(client, event.GetInt("userid")))
		{
			//event.BroadcastDisabled = true; // this has no effect as well, likely a bug.
			SetEventBroadcast(event, true);
			
			char event_reason[256], auth[28], name[64];
			event.GetString("reason", event_reason, sizeof(event_reason));
			GetClientAuthId(client, AuthId_Steam3, auth, sizeof(auth));
			strcopy(name, sizeof(name), g_Player[client].name2);
			int timestamp = GetTime();
			
			char query[255];
			Format(query, sizeof(query), "select `pt` from `%s` where `auth`='%s' and `sID`='%i'"
			, sql.playerlist, auth, g_StatsID);
			DataPack pack = new DataPack();
			pack.WriteCell(strlen(name)+1);
			pack.WriteString(name);
			pack.WriteCell(strlen(auth)+1);
			pack.WriteString(auth);
			pack.WriteCell(timestamp);
			pack.WriteCell(g_Player[client].session[Stats_PlayTime]);
			pack.Reset();
			sql.setsuzoku.Query(DBQuery_OnPlayerDisconnected, query, pack);
			
			Send_Player_Disconnected(client, event_reason);
		}
	}
}

void DBQuery_OnPlayerDisconnected(Database database, DBResultSet results, const char[] error, DataPack pack)
{
	int maxlen1 = pack.ReadCell();
	char[] name = new char[maxlen1];
	pack.ReadString(name, maxlen1);
	int maxlen2 = pack.ReadCell();
	char[] auth = new char[maxlen2];
	pack.ReadString(auth, maxlen2);
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
		
		Transaction txn = new Transaction();
		
		char query[512];
		Format(query, sizeof(query), "update `%s` set"
		..." `lcgame`='%s'"
		...",`lcsID`='%i'"
		...",`lct`='%i'"
		..." where `auth`='%s'"
		, sql.settings, GameType, g_StatsID, timestamp, auth);
		txn.AddQuery(query, query_error_uniqueid_OnPlayerDisconnectUpdateLastConnected);
		
		Format(query, sizeof(query), "update `%s` set "
		... " `lcn`= '%s'"
		... ",`lct`='%i'"
		... ",`pt`=`pt`+%i"
		... " where `auth`='%s' and `sID`='%s'"
		, sql.playerlist, name, timestamp, calculate, auth, g_StatsID);
		txn.AddQuery(query, query_error_uniqueid_OnPlayerDisconnectUpdatePlayTime);
		
		sql.setsuzoku.Execute(txn, _, TXN_Callback_Failure);
	}
}

//

Action OnPlayerTakeDamage(int victim, int &client, int &inflictor, float &damage, int &damagetype)
{
	if(SMStats_IsValidClient(victim, {1,2,0,0,0}, 1, client)
	&& SMStats_IsValidClient(client, {1,1,0,0,0}, 1, victim))
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

Action Timer_TimePlayed(Handle timer, int userid)
{
	int client;
	if(SMStats_IsValidUserID(client, userid))
	{
		if(sql.setsuzoku != null)
		{
			char query[256];
			Format(query, sizeof(query), "select `pt` from `%s` where `auth`='%s' and `sID`='%i'"
			, sql.playerlist, g_Player[client].auth, g_StatsID);
			sql.setsuzoku.Query(DBQuery_TimePlayed, query, userid);
			
			#if defined load_menus
			if(g_Player[client].active_page_session == 1)
			{
				StatsMenu.Session(client, 1);
			}
			#endif
		}
	}
	
	return Plugin_Handled;
}

void DBQuery_TimePlayed(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(!SMStats_IsValidUserID(client, userid))
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
		CallbackQuery("update `%s` set `pt`=`pt`+%i where `auth`='%s' and `sID`='%i'"
		, query_error_uniqueid_UpdatePlayTime
		, sql.playerlist
		, calculate
		, g_Player[client].auth
		, g_StatsID);
	}
}

public void OnMapStart()
{
	GetCurrentMap(cMap, sizeof(cMap));
	if(hMapTimer == null)
	{
		hMapTimer = CreateTimer(60.0, MapTimer_OnMapStart_Timer, _, TIMER_REPEAT);
	}
	if(hMapTimerSeconds == null)
	{
		hMapTimerSeconds = CreateTimer(1.0, MapTimer_OnMapStart_Seconds, _, TIMER_REPEAT);
	}
	if(hGameTimer == null)
	{
		hGameTimer = CreateTimer(0.215751257555125, MapTimer_GameTimer, _, TIMER_REPEAT);
	}
	
	#if defined load_cstrike
	OnMapStart_CStrike();
	#endif
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
	
	#if defined load_cstrike
	OnMapEnd_CStrike();
	#endif
}

Action MapTimer_OnMapStart_Timer(Handle timer)
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
	if(sql.setsuzoku != null)
	{
		char query[255];
		Format(query, sizeof(query), "select `pt` from `%s` where `name`='%s' and `sID`='%i'", sql.maps_log, cMap, g_StatsID);
		sql.setsuzoku.Query(DBQuery_MapTimer, query, GetTime());
	}
}

void DBQuery_MapTimer(Database db, DBResultSet results, const char[] error, int LastPlayedTime)
{
	switch(results != null && results.RowCount > 0)
	{
		// not found
		case false:
		{
			CallbackQuery("insert into `%s` (`pt`,`lpt`,`sID`,`name`) values ('%i','%i','%i','%s')"
			, query_error_uniqueid_UpdateMapTimeInserting
			, sql.maps_log, iMapTimerSeconds, LastPlayedTime, g_StatsID, cMap);
		}
		// found
		case true:
		{
			if(results.FetchRow())
			{
				int PlayTime = results.FetchInt(0);
				int session = iMapTimerSeconds;
				int calculate = session - PlayTime;
				
				CallbackQuery("update `%s` set `pt`=`pt`+'%i',`lpt`='%i' where `sID`='%i' and `name`='%s'"
				, query_error_uniqueid_UpdateMapTimeUpdating
				, sql.maps_log, calculate, LastPlayedTime, g_StatsID, cMap);
			}
		}
	}
}

void UpdateMapTimerSeconds(const char[] map, int seconds)
{
	if(sql.setsuzoku != null)
	{
		char query[255];
		Format(query, sizeof(query), "select `pt` from `%s` where `name`='%s' and `sID`='%i'", sql.maps_log, map, g_StatsID);
		DataPack pack = new DataPack();
		pack.WriteCell(strlen(map)+1);
		pack.WriteString(map);
		pack.WriteCell(seconds);
		pack.WriteCell(GetTime());
		pack.Reset();
		sql.setsuzoku.Query(DBQuery_UpdateMapTimerSeconds, query, pack);
	}
}

void DBQuery_UpdateMapTimerSeconds(Database db, DBResultSet results, const char[] error, DataPack pack)
{
	int maxlen = pack.ReadCell();
	char[] map = new char[maxlen];
	pack.ReadString(map, maxlen);
	int seconds = pack.ReadCell();
	int lastplayed = pack.ReadCell();
	delete pack;
	
	if(results.FetchRow())
	{
		int PlayTime = results.FetchInt(0);
		int session = seconds;
		int calculate = session - PlayTime;
		
		CallbackQuery("update `%s` set `pt`=`pt`+'%i',`lpt`='%i' where `sID`='%i' and `name`='%s'"
		, query_error_uniqueid_UpdateMapTimeUpdatingSeconds
		, sql.maps_log, calculate, lastplayed, g_StatsID, map);
	}
}