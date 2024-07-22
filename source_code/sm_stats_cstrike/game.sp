/* custom network props */
stock int m_hLastFlashBangGrenade = 0;
stock int m_hLastHeGrenade = 0;
stock int m_hLastSmokeGrenade = 0;
stock int m_hLastFirebombGrenade[MAXPLAYERS+1] = {-1, ...};
stock int m_hLastGrenade[MAXPLAYERS+1] = {-1, ...};

stock int m_hLastBombPlanter = 0;
stock int m_hLastBombDefuser = 0;

stock bool m_bIsBlinded[MAXPLAYERS+1] = {false, ...};

stock int n_hLastSniperScopedInfo[2][MAXPLAYERS+1] = { {-1, -1}, {-1, ...} };

/* cvars */
ConVar g_cvarBombPlanted;
ConVar g_cvarBombDefused;

ConVar g_cvarHostageRescued;
//ConVar g_cvarHostageRescuedAll;
ConVar g_cvarHostageFragged;

ConVar g_cvarBlindedMulti;

// query errors

#define query_error_uniqueid_OnBombPlantedPlayerlist 90
#define query_error_uniqueid_OnBombPlantedMapsLog 91
#define query_error_uniqueid_OnBombDefusedPlayerlist 92
#define query_error_uniqueid_OnBombDefusedMapsLog 93
#define query_error_uniqueid_OnHostageRescuedPlayerlist 94
#define query_error_uniqueid_OnHostageRescuedMapsLog 95
#define query_error_uniqueid_OnHostageFraggedPlayerlist 94
#define query_error_uniqueid_OnHostageFraggedMapsLog 95

//

void PrepareGame_CStrike()
{
	/* cvars */
	g_cvarBombPlanted = CreateConVar("sm_stats_points_bomb_planted", "2", "SMStats : CStrike - Points earned when planting the Bomb.", _, true);
	g_cvarBombDefused = CreateConVar("sm_stats_points_bomb_defused", "2", "SMStats : CStrike - Points earned when defusing the Bomb.", _, true);
	
	g_cvarHostageRescued = CreateConVar("sm_stats_points_hostage_rescued", "2", "SMStats : CStrike - Points earned when rescuing a Hostage.", _, true);
	g_cvarHostageFragged = CreateConVar("sm_stats_points_hostage_killed", "2", "SMStats : CStrike - Points lost when killing a Hostage.", _, true);
	
	g_cvarBlindedMulti = CreateConVar("sm_stats_points_blinded_multi", "1", "SMStats : CStrike - Points earned when blinding multiple opponents at once.", _, true);
	
	/* bomb */
	HookEvent("bomb_planted", OnBombPlanted, EventHookMode_Pre);
	HookEvent("bomb_defused", OnBombDefused, EventHookMode_Pre);
	HookEvent("bomb_exploded", OnBombExploded, EventHookMode_Pre);
	
	/* hostages */
	HookEvent("hostage_rescued", OnHostageRescued, EventHookMode_Pre);
	HookEvent("hostage_killed", OnHostageFragged, EventHookMode_Pre);
	
	/* weapons */
	HookEventEx("weapon_fire", OnWeaponFired, EventHookMode_Pre);
	HookEventEx("weapon_zoom", OnWeaponZoomed, EventHookMode_Pre);
	
	/* grenades */
	HookEvent("player_blind", OnPlayerBlinded, EventHookMode_Pre);
}

/* Called as soon as the bomb has been planted. */
void OnBombPlanted(Event event, const char[] szASDF, bool bASDF)
{
	if(!bLoaded || !bStatsActive)
	{
		return;
	}
	
	int userid, client;
	if((userid = event.GetInt("userid")) < 1)
	{
		return;
	}
	if(!IsValidClient((client = GetClientOfUserId(userid))))
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
void OnBombDefused(Event event, const char[] szASDF, bool bASDF)
{
	if(!bLoaded || !bStatsActive)
	{
		return;
	}
	
	int userid, client;
	if((userid = event.GetInt("userid")) < 1)
	{
		return;
	}
	if(!IsValidClient((client = GetClientOfUserId(userid))))
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
void OnBombExploded(Event event, const char[] szASDF, bool bASDF)
{
	if(!bLoaded || !bStatsActive)
	{
		return;
	}
	
	int userid, client;
	if((userid = event.GetInt("userid")) < 1)
	{
		return;
	}
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		return;
	}
	if(IsValidAbuse(client))
	{
		return;
	}
	
	g_Player[client].session[Stats_BombsExploded] += 1;
}

// ======================================================================== //

/* Called as soon as a hostage has been rescued. */
void OnHostageRescued(Event event, const char[] szASDF, bool bASDF)
{
	if(!bLoaded || !bStatsActive)
	{
		return;
	}
	
	int userid, client;
	if((userid = event.GetInt("userid")) < 1)
	{
		return;
	}
	if(!IsValidClient((client = GetClientOfUserId(userid))))
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

/* Called as soon as a hostage was killed. */
void OnHostageFragged(Event event, const char[] szASDF, bool bASDF)
{
	if(!bLoaded || !bStatsActive)
	{
		return;
	}
	
	int userid, client;
	if((userid = event.GetInt("userid")) < 1)
	{
		return;
	}
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		return;
	}
	if(IsValidAbuse(client))
	{
		return;
	}
	
	g_Player[client].session[Stats_HostagesFragged]++;
	
	int points;
	if((points = g_cvarHostageFragged.IntValue) > 0)
	{
		g_Player[client].session[Stats_Points] -= points;
		
		Transaction txn = new Transaction();
		char query[256];
		
		Format(query, sizeof(query), "update `"...sql_table_playerlist..."` set `HostagesFragged`=`HostagesFragged`+1 where SteamID=`%s` and StatsID=`%i`"
		, g_Player[client].auth, g_StatsID);
		txn.AddQuery(query, query_error_uniqueid_OnHostageFraggedPlayerlist);
		
		Format(query, sizeof(query), "update"...sql_table_maps_log..."` set `HostagesFragged`=`HostagesFragged`+1 where StatsID='%i'"
		, g_StatsID);
		txn.AddQuery(query, query_error_uniqueid_OnHostageFraggedMapsLog);
		
		sql.Execute(txn, _, TXN_Callback_Failure);
		
		char points_plural[64];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural), PointSplit_Minus);
		
		CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_CStrike_Hostage_Fragged", client, points_plural);
	}
}

// ======================================================================== //

/* Called as soon as a weapon was fired. */
void OnWeaponFired(Event event, const char[] szASDF, bool bASDF)
{
	if(!bLoaded || !bStatsActive)
	{
		return;
	}
	
	int userid, client;
	if((userid = event.GetInt("userid")) < 1)
	{
		return;
	}
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

/* Called as soon as a weapon was zoomed. */
void OnWeaponZoomed(Event event, const char[] szASDF, bool bASDF)
{
	if(!bLoaded || !bStatsActive)
	{
		return;
	}
	
	int userid, client;
	if((userid = event.GetInt("userid")) < 1)
	{
		return;
	}
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		return;
	}
	
	int sniper = GetPlayerWeaponSlot(client, 0);
	if(IsValidEntity(sniper))
	{
		int m_zoomLevel = GetEntProp(sniper, Prop_Send, "m_zoomLevel");
		
		n_hLastSniperScopedInfo[0][client] = m_zoomLevel;
		n_hLastSniperScopedInfo[1][client] = GetGameTickCount();
	}
	else
	{
		n_hLastSniperScopedInfo[0][client] = -1;
		n_hLastSniperScopedInfo[1][client] = -1;
	}
}

/* Called as soon as a player was blinded. */
void OnPlayerBlinded(Event event, const char[] szASDF, bool bASDF)
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
	
	if(g_Player[client].iTeam == g_Player[victim].iTeam)
	{
		return;
	}
	
	if(event.GetFloat("blind_duration") >= 4.785)
	{
		if(!g_Game[client].aFrameBlinded)
		{
			g_Game[client].aFrameBlinded = new ArrayList();
		}
		
		g_Game[client].aFrameBlinded.Push(userid);
		
		if(!IsFakeClient(victim))
		{
			g_Player[victim].session[Stats_Blinded] += 1;
		}
	}
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
			
			int[] list = new int[blinded];
			
			for(int i = 0; i < blinded; i++)
			{
				list[i] = g_Game[client].aFrameBlinded.Get(i);
			}
			
			g_Game[client].aFrameBlinded.Clear();
			
			if(bDebug)
			{
				int msglen = 0;
				char msg[256];
				msglen += Format(msg[msglen], sizeof(msg)-msglen, "OnPlayerBlindedDebug() :");
				msglen += Format(msg[msglen], sizeof(msg)-msglen, "\nattacker :");
				msglen += Format(msg[msglen], sizeof(msg)-msglen, "\n{");
				msglen += Format(msg[msglen], sizeof(msg)-msglen, "\n   userid %i ['%s'] (team : %s)", g_Player[client].userid, g_Player[client].name2, g_Player[client].team);
				msglen += Format(msg[msglen], sizeof(msg)-msglen, "\n}");
				msglen += Format(msg[msglen], sizeof(msg)-msglen, "\nvictims :");
				msglen += Format(msg[msglen], sizeof(msg)-msglen, "\n{");
				
				for(int i = 0; i < blinded; i++)
				{
					int victim = GetClientOfUserId(list[i]);
					msglen += Format(msg[msglen], sizeof(msg)-msglen, "\n   userid %i ['%s'] (Team : %s)", list[i], g_Player[victim].name2, g_Player[victim].team);
				}
				
				msglen += Format(msg[msglen], sizeof(msg)-msglen, "\n}");
				msglen += Format(msg[msglen], sizeof(msg)-msglen, "\n");
				
				LogMessage(msg);
			}
			
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
				
				CPrintToChat(client, "%s %T%T", g_ChatTag, "#SMStats_CStrike_Blinded_Multi", client, points_plural, "#SMStats_Counter", client, blinded);
			}
		}
	}
}

// CStrike related post OnMapStart() and OnMapEnd() stuff

void OnMapStart_CStrike()
{
	//
}

void OnMapEnd_CStrike()
{
	//
}