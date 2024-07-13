ConVar g_cvarBombPlanted;
ConVar g_cvarBombDefused;

ConVar g_cvarHostageRescued;
//ConVar g_cvarHostageRescuedAll;
//ConVar g_cvarHostageFragged;

void PrepareGame_CStrike()
{
	/* cvars */
	g_cvarBombPlanted = CreateConVar("sm_stats_points_bomb_planted", "2", "SM Stats : CStrike - Points earned when planting the Bomb.", _, true);
	g_cvarBombDefused = CreateConVar("sm_stats_points_bomb_defused", "2", "SM Stats : CStrike - Points earned when defusing the Bomb.", _, true);
	
	g_cvarHostageRescued = CreateConVar("sm_stats_points_bomb_defused", "2", "SM Stats : CStrike - Points earned when rescuing a Hostage.", _, true);
	
	/* bomb */
	HookEvent("bomb_planted", OnBombPlanted, EventHookMode_Pre);
	HookEvent("bomb_defused", OnBombDefused, EventHookMode_Pre);
	HookEvent("bomb_exploded", OnBombExploded, EventHookMode_Pre);
	HookEvent("hostage_rescued", OnHostageRescued, EventHookMode_Pre);
}

/* Called as soon as the bomb has been planted. */
void OnBombPlanted(Event event, const char[] event_name, bool asdf)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int userid = event.GetInt("userid");
	if(userid < 1)
	{
		return;
	}
	
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	g_Player[client].session[Stats_BombsPlanted] += 1;
	
	int points;
	if((points = g_cvarBombPlanted.IntValue) > 0)
	{
		g_Player[client].session[Stats_Points] += points;
		
		Transaction txn = new Transaction();
		char query[256];
		
		Format(query, sizeof(query), "update `"...sql_table_playerlist..."` set `BombsPlanted`=`BombsPlanted`+1 where SteamID=`%s` and StatsID=`%i`"
		, g_Player[client].auth, g_StatsID);
		txn.AddQuery(query, query_error_uniqueid_OnBombPlantedPlayerlist);
		
		Format(query, sizeof(query), "update"...sql_table_maps_log..."` set `BombsPlanted`=`BombsPlanted`+1 where StatsID='%i'"
		, g_StatsID);
		txn.AddQuery(query, query_error_uniqueid_OnBombPlantedMapsLog);
		
		sql.Execute(txn, _, TXN_Callback_Failure);
		
		char points_plural[64];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural), PointSplit_Plus);
		
		CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_CStrike_Bomb_Planted", client, points_plural);
	}
}

/* Called as soon as the bomb has been defused. */
void OnBombDefused(Event event, const char[] event_name, bool asdf)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int userid = event.GetInt("userid");
	if(userid < 1)
	{
		return;
	}
	
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	g_Player[client].session[Stats_BombsDefused] += 1;
	
	int points;
	if((points = g_cvarBombDefused.IntValue) > 0)
	{
		g_Player[client].session[Stats_Points] += points;
		
		Transaction txn = new Transaction();
		char query[256];
		
		Format(query, sizeof(query), "update `"...sql_table_playerlist..."` set `BombsDefused`=`BombsDefused`+1 where SteamID=`%s` and StatsID=`%i`"
		, g_Player[client].auth, g_StatsID);
		txn.AddQuery(query, query_error_uniqueid_OnBombDefusedPlayerlist);
		
		Format(query, sizeof(query), "update"...sql_table_maps_log..."` set `BombsDefused`=`BombsDefused`+1 where StatsID='%i'"
		, g_StatsID);
		txn.AddQuery(query, query_error_uniqueid_OnBombDefusedMapsLog);
		
		sql.Execute(txn, _, TXN_Callback_Failure);
		
		char points_plural[64];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural), PointSplit_Plus);
		
		CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_CStrike_Bomb_Defused", client, points_plural);
	}
}

/* Called as soon as the bomb has exploded. */
void OnBombExploded(Event event, const char[] event_name, bool asdf)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int userid = event.GetInt("userid");
	if(userid < 1)
	{
		return;
	}
	
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	g_Player[client].session[Stats_BombsExploded] += 1;
}

/* Called as soon as a hostage has been rescued. */
void OnHostageRescued(Event event, const char[] event_name, bool asdf)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int userid = event.GetInt("userid");
	if(userid < 1)
	{
		return;
	}
	
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	g_Player[client].session[Stats_HostagesRescued] += 1;
	
	int points;
	if((points = g_cvarHostageRescued.IntValue) > 0)
	{
		g_Player[client].session[Stats_Points] += points;
		
		Transaction txn = new Transaction();
		char query[256];
		
		Format(query, sizeof(query), "update `"...sql_table_playerlist..."` set `HostagesRescued`=`HostagesRescued`+1 where SteamID=`%s` and StatsID=`%i`"
		, g_Player[client].auth, g_StatsID);
		txn.AddQuery(query, query_error_uniqueid_OnHostageRescuedPlayerlist);
		
		Format(query, sizeof(query), "update"...sql_table_maps_log..."` set `HostagesRescued`=`HostagesRescued`+1 where StatsID='%i'"
		, g_StatsID);
		txn.AddQuery(query, query_error_uniqueid_OnHostageRescuedMapsLog);
		
		sql.Execute(txn, _, TXN_Callback_Failure);
		
		char points_plural[64];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural), PointSplit_Plus);
		
		CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_CStrike_Hostage_Rescued", client, points_plural);
	}
}