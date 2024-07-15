/* custom network props */
stock int m_hLastFlashBangGrenade = 0;
stock int m_hLastHeGrenade = 0;
stock int m_hLastSmokeGrenade = 0;
stock int m_hLastFirebombGrenade[MAXPLAYERS+1] = {-1, ...};
stock int m_hLastGrenade[MAXPLAYERS+1] = {-1, ...};

stock int m_hLastBombPlanter = 0;
stock int m_hLastBombDefuser = 0;

stock bool m_bIsBlinded[MAXPLAYERS+1] = {false, ...};

/* cvars */
ConVar g_cvarBombPlanted;
ConVar g_cvarBombDefused;

ConVar g_cvarHostageRescued;
//ConVar g_cvarHostageRescuedAll;
//ConVar g_cvarHostageFragged;

ConVar g_cvarBlindedMulti;

void PrepareGame_CStrike()
{
	/* cvars */
	g_cvarBombPlanted = CreateConVar("sm_stats_points_bomb_planted", "2", "SM Stats : CStrike - Points earned when planting the Bomb.", _, true);
	g_cvarBombDefused = CreateConVar("sm_stats_points_bomb_defused", "2", "SM Stats : CStrike - Points earned when defusing the Bomb.", _, true);
	
	g_cvarHostageRescued = CreateConVar("sm_stats_points_bomb_defused", "2", "SM Stats : CStrike - Points earned when rescuing a Hostage.", _, true);
	
	g_cvarBlindedMulti = CreateConVar("sm_stats_points_blinded_multi", "1", "SM Stats : CStrike - Points earned when blinding multiple opponents at once.", _, true);
	
	/* bomb */
	HookEvent("bomb_planted", OnBombPlanted, EventHookMode_Pre);
	HookEvent("bomb_defused", OnBombDefused, EventHookMode_Pre);
	HookEvent("bomb_exploded", OnBombExploded, EventHookMode_Pre);
	HookEvent("hostage_rescued", OnHostageRescued, EventHookMode_Pre);
	
	/* weapons */
	HookEventEx("weapon_fire", OnWeaponFired, EventHookMode_Pre);
	
	/* grenades */
	HookEvent("player_blind", OnPlayerBlinded, EventHookMode_Pre);
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
	
	m_hLastBombPlanter = client;
	
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
	
	m_hLastBombDefuser = client;
	
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

/* Called as soon as a weapon was fired. */
void OnWeaponFired(Event event, const char[] event_name, bool asdf)
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
	
	int client;
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	/* Since both incendiary and molotov counts as 'firebomb' in 'player_death' event, we need to get the correct grenade. */
	char weapon[64];
	event.GetString("weapon", weapon, sizeof(weapon));
	
	bool bGrenade;
	if(StrEqual(weapon, "weapon_incgrenade", false))
	{
		m_hLastFirebombGrenade[client] = 48;
		bGrenade = true;
	}
	else if(StrEqual(weapon, "weapon_molotov", false))
	{
		m_hLastFirebombGrenade[client] = 46;
		bGrenade = true;
	}
	
	//
	
	if(bDebug && bGrenade)
	{
		char t[11];
		
		switch(GetClientTeam(client))
		{
			case 1: t = "SPEC"
			case 2: t = "T";
			case 3: t = "CT";
			default:t = "UNASSIGNED"
		}
		
		LogMessage("OnWeaponFired() Debug : "
		..."\nuserid : %i ['%s'] (team : %s)"
		..."\nweapon : '%s'"
		..."\nsilenced : %s"
		..."\n"
		, userid, g_Player[client].name2, t
		, weapon
		, event.GetBool("silenced") ? "true" : "false");
	}
}

/* Called as soon as a player was blinded. */
void OnPlayerBlinded(Event event, const char[] event_name, bool asdf)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int userid = event.GetInt("userid");
	int attacker = event.GetInt("attacker");
	if(userid < 1
	|| attacker < 1)
	{
		return;
	}
	
	int client;
	int victim;
	if(!IsValidClient((client = GetClientOfUserId(attacker)))
	|| !IsValidClient((victim = GetClientOfUserId(userid)), !bAllowBots))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	if(GetClientTeam(client) == GetClientTeam(victim))
	{
		return;
	}
	
	float duration;
	if((duration = event.GetFloat("blind_duration")) < 5.0)
	{
		return;
	}
	
	if(!g_Game[client].aFrameBlinded)
	{
		g_Game[client].aFrameBlinded = new ArrayList();
	}
	
	if(!IsFakeClient(victim))
	{
		g_Player[victim].session[Stats_Blinded] += 1;
	}
	
	//
	
	if(bDebug)
	{
		char t1[11];
		char t2[11];
		int entityid = event.GetInt("entityid");
		
		switch(GetClientTeam(client))
		{
			case 1: t1 = "SPEC"
			case 2: t1 = "T";
			case 3: t1 = "CT";
			default:t1 = "UNASSIGNED"
		}
		switch(GetClientTeam(victim))
		{
			case 1: t2 = "SPEC";
			case 2: t2 = "T";
			case 3: t2 = "CT";
			default:t2 = "UNASSIGNED";
		}
		
		LogMessage("OnPlayerBlinded() Debug : "
		..."\nattacker : %i ['%s'] (team : %s)"
		..."\nvictim : %i ['%s'] (team : %s)"
		..."\nflashbang entityid : %i"
		..."\nduration : %.6f"
		..."\n"
		, attacker, g_Player[client].name2, t1
		, userid, g_Player[victim].name2, t2
		, entityid
		, duration);
	}
	
	//
}

//

void MapTimer_GameTimer_CStrike(int client, Transaction txn)
{
	if(g_Game[client].aFrameBlinded != null)
	{
		int blinded;
		if((blinded = g_Game[client].aFrameBlinded.Length) > 0)
		{
			if(txn == null)
			{
				txn = new Transaction();
			}
			
			g_Game[client].aFrameBlinded.Clear();
			g_Player[client].session[Stats_BlindedOpponents] += blinded;
			
			int len;
			char query[256];
			len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set");
			len += Format(query[len], sizeof(query)-len, "`BlindedOpponents`=`BlindedOpponents`+'%i'", blinded);
			
			int points;
			if(blinded >= 3)
			{
				if((points = g_cvarBlindedMulti.IntValue) > 0)
				{
					g_Player[client].session[Stats_Points] += points;
					
					len += Format(query[len], sizeof(query)-len, ", `Points`=`Points`='%i'", points);
				}
			}
			
			len += Format(query[len], sizeof(query)-len, " where `SteamID`='%s' and `StatsID`='%i'", g_Player[client].auth, g_StatsID);
			txn.AddQuery(query);
			
			// in case the text was not formatted correctly, this is to prevent a sql query halt and cause server to crash.
			
			if(blinded >= 3 && points >= 1)
			{
				char points_plural[64];
				PointsPluralSplitter(client, points, points_plural, sizeof(points_plural), PointSplit_Plus);
				
				CPrintToChat(client, "%s %T%T", g_ChatTag, "#SMStats_CStrike_Blinded_Multi", client, points_plural, "#SMStats_Counter", blinded);
			}
		}
	}
}