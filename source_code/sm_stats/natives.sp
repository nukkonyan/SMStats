stock any Native_GetPlayerSessionInfo(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	SMStats_Type type = GetNativeCell(2);
	Function callback = GetNativeFunction(3);
	
	g_GetPlayerSessionInfoFwd.AddFunction(plugin, callback);
	Call_StartForward(g_GetPlayerSessionInfoFwd);
	Call_PushCell(client);
	Call_PushCell(g_Player[client].session[type]);
	Call_PushCell(type);
	Call_Finish();
	
	return 0;
}

/* ============================================================== */

stock any Native_BanPlayer_Auth(Handle plugin, int params)
{
	if(!sql)
	{
		ThrowNativeError(SP_ERROR_NATIVE, "%s _sm_stats_detect_ban_player_auth Invalid SQL Connection.", core_chattag);
		return 0;
	}
	
	int maxlen;
	GetNativeStringLength(1, maxlen);
	maxlen += 1;
	char[] auth = new char[maxlen];
	GetNativeString(1, auth, maxlen);
	bool only_same_gameserver = view_as<bool>(GetNativeCell(2));
	
	//
	
	char query[256], error[256];
	DBResultSet results;
	SQL_LockDatabase(sql);
	switch(only_same_gameserver)
	{
		case false:
		{
			Format(query, sizeof(query), "select `PlayerName` from playerlist_* where SteamID = '%s'", auth);
			if(!(results = SQL_Query(sql, query)))
			{
				SQL_GetError(sql, error, sizeof(error));
			}
		}
		case true:
		{
			Format(query, sizeof(query), "select `PlayerName` from `"...sql_table_playerlist..."` where SteamID = '%s'", auth);
			if(!(results = SQL_Query(sql, query)))
			{
				SQL_GetError(sql, error, sizeof(error));
			}
		}
	}
	SQL_UnlockDatabase(sql);
	
	//
	
	if(results == null)
	{
		ThrowNativeError(SP_ERROR_NATIVE, "%s _sm_stats_detect_ban_player error : steamid '%s' was not found in database."
		... "\nError below:"
		... "\n%s"
		, core_chattag
		, auth
		, error);
		return 0;
	}
	if(!results.FetchRow())
	{
		ThrowNativeError(SP_ERROR_NATIVE, "%s _sm_stats_detect_ban_player error : Failed to fetch row.", core_chattag);
		return 0;
	}
	
	//
	
	char PlayerName[64];
	results.FetchString(0, PlayerName, sizeof(PlayerName));
	
	DataPack pack = new DataPack();
	pack.WriteCell(strlen(PlayerName)+1);
	pack.WriteString(PlayerName);
	pack.WriteCell(maxlen);
	pack.WriteString(auth);
	pack.WriteCell(only_same_gameserver);
	pack.Reset();
	
	//
	
	Transaction txn = new Transaction();
	switch(only_same_gameserver)
	{
		case false:
		{
			Format(query, sizeof(query), "delete from playerlist_* where SteamID = '%s'", auth);
			txn.AddQuery(query, 1);
			
			Format(query, sizeof(query), "select from weapon_* where SteamID = '%s'", auth);
			txn.AddQuery(query, 2);
			
			//Format(query, sizeof(query), "delete * from kill_log_* where SteamID = '%s'", auth);
			//txn.AddQuery(query, 3);
			
			//Format(query, sizeof(query), "delete from item_log_* where SteamID = '%s'", auth);
			//txn.AddQuery(query, 4);
			
			//Format(query, sizeof(query), "delete from achievements_* where SteamID = '%s'", auth);
			//txn.AddQuery(query, 5);
		}
		
		case true:
		{
			Format(query, sizeof(query), "delete from `"...sql_table_playerlist..."` where SteamID = '%s'", auth);
			txn.AddQuery(query, 1);
			
			Format(query, sizeof(query), "delete * from `"...sql_table_weapons..."` where SteamID = '%s'", auth);
			txn.AddQuery(query, 2);
			
			//Format(query, sizeof(query), "delete from `"...sql_table_kill_log..."` where SteamID = '%s'", auth);
			//txn.AddQuery(query, 3);
			
			//Format(query, sizeof(query), "delete from `"...sql_table_item_log..."` * where SteamID = '%s'", auth);
			//txn.AddQuery(query, 4);
			
			//Format(query, sizeof(query), "delete from achievements_* where SteamID = '%s'", auth);
			//txn.AddQuery(query, 5);
		}
	}
	
	Format(query, sizeof(query), "delete from settings where SteamID = '%s'", auth);
	txn.AddQuery(query, 6);
	
	sql.Execute(txn);
	
	//
	
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) != -1)
	{
		if(IsValidClient(player))
		{
			CPrintToChat(player, "%s %T", g_ChatTag, "#SMStats_Player_Detected_Banned", player, PlayerName, auth);
		}
	}
	
	return 0;
}

enum struct BanInfoShitThingy
{
	char auth[28];
	char name[64];
}

stock any Native_BanPlayer_IPAddress(Handle plugin, int params)
{
	if(!sql)
	{
		ThrowNativeError(SP_ERROR_NATIVE, "%s _sm_stats_detect_ban_player_ip Invalid SQL Connection.", core_chattag);
		return 0;
	}
	
	int maxlen;
	GetNativeStringLength(1, maxlen);
	maxlen += 1;
	char[] ip = new char[maxlen];
	GetNativeString(1, ip, maxlen);
	bool only_same_gameserver = view_as<bool>(GetNativeCell(2));
	
	//
	
	char query[256];
	DBResultSet results;
	SQL_LockDatabase(sql);
	switch(only_same_gameserver)
	{
		case false:
		{
			Format(query, sizeof(query), "select PlayerName, SteamID from playerlist_* where IPAddress = '%s'", ip);
			results = SQL_Query(sql, query);
		}
		case true:
		{
			Format(query, sizeof(query), "select PlayerName, SteamID from `"...sql_table_playerlist..."` where IPAddress = '%s'", ip);
			results = SQL_Query(sql, query);
		}
	}
	SQL_UnlockDatabase(sql);
	
	//
	
	// sql bug, always returns '1' when nothing is returned.
	if(results.RowCount == 1 || results == null)
	{
		PrintToServer("%s _sm_stats_detect_ban_player_ip error : ip '%s' was not found in database.", core_chattag, ip);
		return -1;
	}
	
	//
	
	ArrayList list = new ArrayList(16);
	Transaction txn = new Transaction();
	while(results.FetchRow())
	{
		char name[64], auth[28];
		results.FetchString(0, name, sizeof(name));
		results.FetchString(1, auth, sizeof(auth));
		
		if(list.FindString(auth) == -1)
		{
			BanInfoShitThingy thing;
			strcopy(thing.auth, sizeof(thing.auth), auth);
			strcopy(thing.name, sizeof(thing.name), name);
			list.PushArray(thing, sizeof(thing));
		}
	}
	
	int count = list.Length;
	char[][] PlayerName = new char[count][64];
	char[][] SteamID = new char[count][28];
	for(int i = 0; i < count; i++)
	{
		BanInfoShitThingy thing;
		list.GetArray(i, thing, sizeof(thing));
		strcopy(SteamID[i], sizeof(thing.auth), thing.auth);
		strcopy(PlayerName[i], sizeof(thing.name), thing.name);
		
		switch(only_same_gameserver)
		{
			case false:
			{
				Format(query, sizeof(query), "delete from playerlist_* where SteamID = '%s'", thing.auth);
				txn.AddQuery(query, 1);
				
				Format(query, sizeof(query), "delete from weapon_* where SteamID = '%s'", thing.auth);
				txn.AddQuery(query, 2);
				
				//Format(query, sizeof(query), "delete from kill_log_* where SteamID = '%s'", thing.auth);
				//txn.AddQuery(query, 3);
				
				//Format(query, sizeof(query), "delete from item_log_* where SteamID = '%s'", thing.auth);
				//txn.AddQuery(query, 4);
				
				//Format(query, sizeof(query), "delete from achievements_* where SteamID = '%s'", thing.auth);
				//txn.AddQuery(query, 5);
			}
			
			case true:
			{
				Format(query, sizeof(query), "delete from `"...sql_table_playerlist..."` where SteamID = '%s'", thing.auth);
				txn.AddQuery(query, 1);
				
				Format(query, sizeof(query), "delete from `"...sql_table_weapons..."` where SteamID = '%s'", thing.auth);
				txn.AddQuery(query, 2);
				
				//Format(query, sizeof(query), "delete from `"...sql_table_kill_log..."` where SteamID = '%s'", thing.auth);
				//txn.AddQuery(query, 3);
				
				//Format(query, sizeof(query), "delete from `"...sql_table_item_log..."` * where SteamID = '%s'", thing.auth);
				//txn.AddQuery(query, 4);
				
				//Format(query, sizeof(query), "delete from `"...sql_table_achievements..."` where SteamID = '%s'", thing.auth);
				//txn.AddQuery(query, 5);
			}
		}
	
		Format(query, sizeof(query), "delete from settings where SteamID = '%s'", thing.auth);
		txn.AddQuery(query, 6);
	}
	delete list;
	
	sql.Execute(txn);
	
	//
	
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) != -1)
	{
		if(IsValidClient(player))
		{
			for(int i = 0; i < count; i++)
			{
				CPrintToChat(player, "%s %T", g_ChatTag, "#SMStats_Player_Detected_IPBanned", player, PlayerName[i], SteamID[i]);
			}
		}
	}
	
	return -1;
}