enum
{
	Bomb_Planted = 0,
	Bomb_Defused = 1,
	Bomb_Exploded = 2,
	
	Hostage_Rescued = 0,
	Hostage_Fragged = 1,
}

/* Custom network props */
int m_hLastFlashBangGrenade = 0;
stock int m_hLastHEGrenade = 0;
stock int m_hLastSmokeGrenade = 0;
//int m_hLastGrenade[MaxPlayers+1] = {-1, ...};

stock int m_hLastBombPlanter = -1;
stock int m_hLastBombDefuser = -1;

bool m_bIsBlinded[MaxPlayers+1] = {false, ...};

/* ========== Convars ========= */
/* bomb */
ConVar g_BombEvent[3];

/* hostage */
ConVar g_HostageEvent[2];

/* other */
ConVar g_SuicideAssisted;
ConVar g_Collateral;

//

enum struct FragEventInfo
{
	int timestamp;
	int userid;
	int assister;
	int inflictor;
	
	int penetrated;
	
	bool suicide;
	bool suicide_assisted;
	bool headshot;
	bool backstab;
	bool noscope;
	bool dominated;
	bool dominated_assister;
	bool revenge;
	bool revenge_assister;
	bool collateral;
	bool midair;
	bool airshot;
	bool blinded;
	
	char classname[64];
	int itemdef;
}

//

enum struct CSS_GameInfo
{
	ArrayList aFragEvent;
	
	//
	
	void Reset()
	{
		if(!!this.aFragEvent)
		{
			delete this.aFragEvent;
		}
	}
}

CSS_GameInfo g_Game[MaxPlayers+1];

//

void PrepareGame()
{
	/* Bomb events */
	g_BombEvent[Bomb_Planted] = CreateConVar("xstats_points_bomb_planted", "2", "SM Stats: CSS - Points earned when planting the bomb.", _, true);
	g_BombEvent[Bomb_Defused] = CreateConVar("xstats_points_bomb_defused", "2", "SM Stats: CSS - Points earned when defusing the bomb.", _, true);
	g_BombEvent[Bomb_Exploded] = CreateConVar("xstats_points_bomb_exploded", "2", "SM Stats: CSS - Points earned when bomb explodes.", _, true);
	
	/* Hostage events */
	g_HostageEvent[Hostage_Rescued] = CreateConVar("xstats_points_hostage_rescued", "2", "SM Stats: CSS - Points earned when hostage is rescued.", _, true);
	g_HostageEvent[Hostage_Fragged] = CreateConVar("xstats_points_hostage_killed", "2", "SM Stats: CSS - Points taken when hostage is killed.", _, true);
	
	/* other */
	g_SuicideAssisted = CreateConVar("sm_stats_points_assisted_suicide", "1", "SM Stats: CSS - Points earned when assisted in an opponents suicide.", _, true);
	g_Collateral = CreateConVar("sm_stats_points_collateral", "2", "SM Stats: CSS - Points earned when doing a collateral frag. Paired with frag event.", _, true);
	
	/* ========================================================================================== */
	
	/* weapons */
	array_InitializeWeapons();
	array_AddWeapon(0, "sm_stats_points_weapon_deagle", 10, "Desert Eagle");
	array_AddWeapon(1, "sm_stats_points_weapon_glock", 10, "Glock");
	array_AddWeapon(2, "sm_stats_points_weapon_ak47", 10, "AK-47");
	array_AddWeapon(3, "sm_stats_points_weapon_aug", 10, "AUG");
	array_AddWeapon(4, "sm_stats_points_weapon_famas", 10, "FAMAS");
	array_AddWeapon(5, "sm_stats_points_weapon_g3sg1", 10, "G3SG1");
	array_AddWeapon(6, "sm_stats_points_weapon_galil", 10, "Galil");
	array_AddWeapon(7, "sm_stats_points_weapon_m249", 10, "M249");
	array_AddWeapon(8, "sm_stats_points_weapon_m4a1", 10, "M4A1");
	array_AddWeapon(9, "sm_stats_points_weapon_mac10", 10, "MAC-10");
	array_AddWeapon(10, "sm_stats_points_weapon_p90", 10, "P90");
	array_AddWeapon(11, "sm_stats_points_weapon_mp5", 10, "MP5");
	array_AddWeapon(12, "sm_stats_points_weapon_ump45", 10, "UMP45");
	array_AddWeapon(13, "sm_stats_points_weapon_xm1014", 10, "XM1014");
	array_AddWeapon(14, "sm_stats_points_weapon_m3", 10, "M3");
	array_AddWeapon(15, "sm_stats_points_weapon_usp", 10, "USP");
	array_AddWeapon(16, "sm_stats_points_weapon_p228", 10, "P228");
	array_AddWeapon(17, "sm_stats_points_weapon_sg550", 10, "SG550");
	array_AddWeapon(18, "sm_stats_points_weapon_sg552", 10, "SG552");
	array_AddWeapon(19, "sm_stats_points_weapon_sg556", 10, "SG556");
	array_AddWeapon(20, "sm_stats_points_weapon_scout", 10, "Scout");
	array_AddWeapon(21, "sm_stats_points_weapon_knife", 10, "Knife");
	array_AddWeapon(22, "sm_stats_points_weapon_flashgrenade", 10, "Flashbang");
	array_AddWeapon(23, "sm_stats_points_weapon_hegrenade", 10, "HE Grenade");
	array_AddWeapon(24, "sm_stats_points_weapon_smokegrenade", 10, "Smokegrenade");
	array_AddWeapon(25, "sm_stats_points_weapon_c4", 10, "C4");
	
	/* ========================================================================================== */
	
	/* events */
	
	/* core */
	HookEvent("player_death", OnPlayerDeath, EventHookMode_Pre);
	HookEvent("player_team", OnPlayerTeamChange, EventHookMode_Pre);
	
	/* Events */
	HookEventEx("bomb_planted", OnBombEvent, EventHookMode_Pre);
	HookEventEx("bomb_defused", OnBombEvent, EventHookMode_Pre);
	HookEventEx("bomb_exploded", OnBombEvent, EventHookMode_Pre);
	
	/* Hostages */
	HookEventEx("hostage_rescued", OnHostageEvent, EventHookMode_Pre);
	HookEventEx("hostage_killed", OnHostageEvent, EventHookMode_Pre);
	
	/* Blinded */
	HookEventEx("player_blind", OnPlayerBlinded, EventHookMode_Pre);
	
	/* Rounds */
	
	/* Round started */
	HookEvent("round_start", OnRoundStarted, EventHookMode_Pre);
	
	/* Round ended */
	HookEvent("round_end", OnRoundEnded, EventHookMode_Pre);
	
	AutoExecConfig(true);
}

/* Called as soon as a player is killed. */
void OnPlayerDeath(Event event, const char[] event_name, bool dontBroadcast)
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
	
	if(!sql)
	{
		LogError(core_chattag..." OnPlayerDeath error: No database connection available.");
		return;
	}
	
	//
	
	int client = GetClientOfUserId(attacker);
	if(!IsValidClient(client))
	{
		return;
	}
	
	int victim = GetClientOfUserId(userid);
	if(!IsValidClient(victim, !bAllowBots))
	{
		return;
	}
	
	//
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	//
	
	if(!bAllowBots)
	{
		if(IsFakeClient(victim))
		{
			return;
		}
	}
	
	if(client == victim)
	{
		g_Player[client].session[Stats_Suicides]++;
		return;
	}
	
	if(GetClientTeam(client) == GetClientTeam(victim))
	{
		return;
	}
	
	//
	
	//int assister = GetLatestAssister(victim, client);
	int assister;
	
	//
	
	int itemdef = 0;
	bool assisted_suicide = false;
	
	char classname[64];
	event.GetString("weapon", classname, sizeof(classname));
	
	if(StrContains(classname, "trigger_") != -1
	|| StrContains(classname, "prop_") != -1
	|| (StrEqual(classname, "world") && assister < 1))
	{
		return;
	}
	
	bool bValidMidAir = true;
	
	/* Assisted suicide. */
	// this will get re-done.
	if(StrEqual(classname, "world", false))
	{
		bValidMidAir = false;
		assisted_suicide = (assister > 0);
		itemdef = ITEMDEF_INVALID;
	}
	else if(StrEqual(classname, "player", false))
	{
		bValidMidAir = false;
		assisted_suicide = (assister > 0);
		itemdef = ITEMDEF_INVALID;
	}
	
	if((itemdef = GetWeaponItemdef(classname)) == -1)
	{
		PrintToServer("%s An error has occured, unable to obtain itemdef of classname '%s'."
		, core_chattag, classname);
		return;
	}
	
	//
	
	if(itemdef < 0)
	{
		PrintToServer("%s An error has occured, itemdef %i (classname '%s') is invalid."
		, core_chattag, itemdef, classname);
		return;
	}
	else if(!array_GetWeapon(itemdef))
	{
		PrintToServer("%s An error has occured, itemdef %i (classname '%s') seems to have invalid convar handle! (New item perhaps?)"
		, core_chattag, itemdef, classname);
		return;
	}
	else if(array_GetWeapon(itemdef).IntValue < 1)
	{
		return;
	}

	//
	
	FragEventInfo frag;
	frag.userid = userid;
	frag.assister = assister;
	
	frag.suicide = (userid == attacker);
	frag.suicide_assisted = assisted_suicide; // will be redone soon to be separated.
	frag.headshot = event.GetBool("headshot");
	frag.backstab = false;
	frag.noscope = false;
	
	frag.collateral = false;
	
	frag.blinded = m_bIsBlinded[client];
	
	float gd_attacker = DistanceAboveGround(client);
	float gd_userid = DistanceAboveGround(victim);
	
	bool g_attacker;
	bool g_userid;
	if(GetEntityFlags(client) & FL_ONGROUND) g_attacker = true;
	if(GetEntityFlags(victim) & FL_ONGROUND) g_userid = true;
	
	if(!g_attacker && bValidMidAir)
	{
		frag.midair = (gd_attacker >= 65.2517525135751254595);
	}
	
	if(!g_userid)
	{
		frag.airshot = (gd_userid >= 65.2517525135751254595);
	}
	
	strcopy(frag.classname, sizeof(frag.classname), classname);
	frag.itemdef = itemdef;
	
	if(!g_Game[client].aFragEvent)
	{
		g_Game[client].aFragEvent = new ArrayList(sizeof(FragEventInfo));
	}
	
	g_Game[client].aFragEvent.PushArray(frag, sizeof(frag));
}

/* Called as soon a player changes their team. */
void OnPlayerTeamChange(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!bLoaded)
	{
		return;
	}
	
	// too early to gather info, delay has to be added..
	CreateTimer(0.2, Timer_OnPlayerUpdated, event.GetInt("userid"));
}

/* Called on bomb event. */
void OnBombEvent(Event event, const char[] event_name, bool dontBroadcast)
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
	
	int client = 0;
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		return;
	}
	
	char query[256];
	int points = 0;
	
	if(StrEqual(event_name, "bomb_planted") && GetClientTeam(client) == CS_TEAM_T)
	{
		m_hLastBombPlanter = client;
		
		g_Player[client].session[Stats_BombsPlanted]++;
		Format(query, sizeof(query), "update `%s` set BombsPlanted = BombsPlanted+1 where SteamID='%s' and StatsID='%i'"
		, sql_table_playerlist, g_Player[client].auth, g_StatsID);
		sql.Query(DBQuery_Callback, query);
		
		if((points = g_BombEvent[Bomb_Planted].IntValue) > 0)
		{
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", sql_table_playerlist, points, g_Player[client].auth);
			sql.Query(DBQuery_Callback, query);
			
			CPrintToChat(client, "%s %t", g_ChatTag, "#SMStats_Bomb_Planted", g_Player[client].name, g_Player[client].points, points);
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
		}
	}
	else if(StrEqual(event_name, "bomb_defused") && GetClientTeam(client) == CS_TEAM_CT)
	{
		m_hLastBombDefuser = client;
		
		g_Player[client].session[Stats_BombsDefused]++;
		Format(query, sizeof(query), "update `%s` set BombsDefused = BombsDefused+1 where SteamID = '%s' and StatsID='%i'"
		, sql_table_playerlist, g_Player[client].auth, g_StatsID);
		sql.Query(DBQuery_Callback, query);
		
		if((points = g_BombEvent[Bomb_Defused].IntValue) > 0)
		{
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", sql_table_playerlist, points, g_Player[client].auth);
			sql.Query(DBQuery_Callback, query);
			
			CPrintToChat(client, "%s %t", g_ChatTag, "#SMStats_Bomb_Defused", g_Player[client].name, g_Player[client].points, points);
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
		}
	}
	else if(StrEqual(event_name, "bomb_exploded") && GetClientTeam(client) == CS_TEAM_T)
	{
		g_Player[client].session[Stats_BombsExploded]++;
		Format(query, sizeof(query), "update `%s` set BombsExploded = BombsExploded+1 where SteamID='%s' and StatsID='%i'"
		, sql_table_playerlist, g_Player[client].auth, g_StatsID);
		sql.Query(DBQuery_Callback, query);
		
		if((points = g_BombEvent[Bomb_Exploded].IntValue) > 0)
		{
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", sql_table_playerlist, points, g_Player[client].auth);
			sql.Query(DBQuery_Callback, query);
			
			CPrintToChat(client, "%s %t", g_ChatTag, "#SMStats_Bomb_Exploded", g_Player[client].name, g_Player[client].points, points);
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
		}
	}
}

/* Called on hostage event */
void OnHostageEvent(Event event, const char[] event_name, bool dontBroadcast)
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
	
	int client = 0;
	if(!IsValidClient((client = event.GetInt("userid"))))
	{
		return;
	}
	
	char query[512];
	int points = 0;
	
	if(StrEqual(event_name, "hostage_rescued"))
	{
		g_Player[client].session[Stats_HostagesRescued]++;
		
		if((points = g_HostageEvent[Hostage_Rescued].IntValue) > 0)
		{
			CPrintToChat(client, "%s %t", g_ChatTag, "#SMStats_Hostage_Rescued", g_Player[client].name, g_Player[client].points, points);
			
			Format(query, sizeof(query), "update `%s` set Points=Points+'%i', HostagesRescued=HostagesRescued+1 where SteamID='%s' and StatsID='%i'",
			sql_table_playerlist, points, g_Player[client].auth, g_StatsID);
			sql.Query(DBQuery_Callback, query);
			
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
		}
	}
	else if(StrEqual(event_name, "hostage_killed"))
	{
		g_Player[client].session[Stats_HostagesFragged]++;
		
		if((points = g_HostageEvent[Hostage_Fragged].IntValue) > 0)
		{
			CPrintToChat(client, "%s %t", g_ChatTag, "#SMStats_Hostage_Fragged", g_Player[client].name, g_Player[client].points, points);
			
			Format(query, sizeof(query), "update `%s` set Points=Points+'%i', HostagesFragged=HostagesFragged+1 where SteamID='%s' and StatsID='%i'",
			sql_table_playerlist, points, g_Player[client].auth, g_StatsID);
			sql.Query(DBQuery_Callback, query);
			
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
		}
	}
}

/* Called as soon as a player was blinded by a flashbang grenade */
void OnPlayerBlinded(Event event, const char[] event_name, bool dontBroadcast)
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
	
	int victim = 0;
	if(!IsValidClient((victim = GetClientOfUserId(userid))))
	{
		return;
	}
	
	if(!bAllowBots)
	{
		if(IsFakeClient(victim))
		{
			return;
		}
	}
	
	if(!IsFakeClient(victim))
	{
		float m_flFlashDuration = GetEntPropFloat(victim, Prop_Send, "m_flFlashDuration");
		m_bIsBlinded[victim] = (m_flFlashDuration > 1.0);
		
		CreateTimer(m_flFlashDuration-1.1257525125, Timer_OnPlayerBlinded, victim);
	}
	
	int client = m_hLastFlashBangGrenade;
	if(!IsValidClient(client, true))
	{
		return;
	}
	
	if(GetClientTeam(client) == GetClientTeam(victim) || client == victim)
	{
		return;
	}
	
	g_Player[client].session[Stats_FlashedOpponents]++;
	
	char query[384];
	Format(query, sizeof(query), "update `%s` set FlashedOpponents = FlashedOpponents+1 where SteamID = '%s' and StatsID='%i'"
	, sql_table_playerlist, g_Player[client].auth, g_StatsID);
	sql.Query(DBQuery_Callback, query);
}

Action Timer_OnPlayerBlinded(Handle timer, int client)
{
	m_bIsBlinded[client] = false;
	return Plugin_Continue;
}

/* ===================================================================================== */

enum struct TempLmao
{
	char classname[64];
	int itemdef;
	int quantity;
}

// instead of OnGameFrame, we have custom delayed game timer.
// For optimization purposes.
// Workaround with OnGameFrame possible would be greatly appreciated.
Action MapTimer_GameTimer(Handle timer)
{
	if(bLoaded)
	{
		Transaction txn; // All-In-One Query.
		
		// alternative over a for() loop.
		int client = 0;
		while((client = FindEntityByClassname(client, "player")) != -1)
		{
			if(!IsValidClient(client))
			{
				continue;
			}
			
			char str_playtime[11];
			FloatToString(GetClientTime(client), str_playtime, sizeof(str_playtime));
			g_Player[client].session[Stats_PlayTime] = StringToInt(str_playtime);
			if(g_Player[client].active_page_mainmenu >= 1)
			{
				StatsMenu.Main(client, g_Player[client].active_page_mainmenu);
			}
			else if(g_Player[client].active_page_session == 1)
			{
				StatsMenu.Session(client, g_Player[client].active_page_session);
			}
			
			if(g_Game[client].aFragEvent != null)
			{
				int frags;
				if((frags = g_Game[client].aFragEvent.Length) > 0)
				{
					FragEventInfo event;
					int[] list = new int[frags];
					int[] list_assister = new int[frags];
					bool[] list_assister_dominate = new bool[frags];
					bool[] list_assister_revenge = new bool[frags];
					int[] list_itemdef = new int[frags];
					bool[] list_wepfrag = new bool[frags];
					char[][] list_classname = new char[frags][64];
					
					// kill log
					
					char list_steamid_victim[448];
					char list_steamid_assister[448];
					int list_timestamp;
					char list_itemdefs[176];
					
					//
					
					int iHeadshots;
					int iBackstabs;
					int iDominated;
					int iRevenges;
					int iNoscopes;
					int iAirshots;
					int iCollaterals;
					int iMidAirFrags;
					
					int iWepFrags;
					
					int points = 0;
					
					// store temporary info for frag message
					
					bool bPrev_headshot;
					bool bPrev_backstab;
					bool bPrev_domination;
					bool bPrev_revenge;
					bool bPrev_noscope;
					bool bPrev_airshot;
					bool bPrev_collateral;
					bool bPrev_midair;
					
					//
					
					for(int i = 0; i < frags; i++)
					{
						g_Game[client].aFragEvent.GetArray(i, event, sizeof(event));
						list_timestamp = event.timestamp;
						int userid_victim = (list[i] = event.userid);
						list_assister[i] = event.assister;
						list_assister_dominate[i] = event.dominated_assister;
						list_assister_revenge[i] = event.revenge_assister;
						list_itemdef[i] = event.itemdef;
						strcopy(list_classname[i], sizeof(event.classname), event.classname);
						
						switch(strlen(list_itemdefs) < 1)
						{
							case false: Format(list_itemdefs, sizeof(list_itemdefs), "%s;%i", list_itemdefs, list_itemdef[i]);
							case true: Format(list_itemdefs, sizeof(list_itemdefs), "%i", list_itemdef[i]);
						}
						
						// kill log
						int victim;
						if(IsValidClient((victim = GetClientOfUserId(userid_victim))))
						{
							switch(strlen(list_steamid_victim) < 1)
							{
								case false: Format(list_steamid_victim, sizeof(list_steamid_victim), "%s;%s", list_steamid_victim, g_Player[victim].auth);
								case true: strcopy(list_steamid_victim, sizeof(list_steamid_victim), g_Player[victim].auth);
							}
						}
						
						switch((g_Player[client].fragmsg.Headshot = event.headshot))
						{
							case false: bPrev_headshot = false;
							case true:
							{
								iHeadshots++;
								if(frags > 1 && !bPrev_headshot)
								{
									g_Player[client].fragmsg.Headshot = false;
								}
								bPrev_headshot = true;
							}
						}
						switch((g_Player[client].fragmsg.Backstab = event.backstab))
						{
							case false: bPrev_backstab = false;
							case true:
							{
								iBackstabs++;
								if(frags > 1 && !bPrev_backstab)
								{
									g_Player[client].fragmsg.Backstab = false;
								}
								bPrev_backstab = true;
							}
						}
						switch((g_Player[client].fragmsg.Domination = event.dominated))
						{
							case false: bPrev_domination = false;
							case true:
							{
								iDominated++;
								if(frags > 1 && !bPrev_domination)
								{
									g_Player[client].fragmsg.Domination = false;
								}
								bPrev_domination = true;
							}
						}
						switch((g_Player[client].fragmsg.Revenge = event.revenge))
						{
							case false: bPrev_revenge = false;
							case true:
							{
								iRevenges++;
								if(frags > 1 && bPrev_revenge)
								{
									g_Player[client].fragmsg.Revenge = false;
								}
								bPrev_revenge = true;
							}
						}
						switch((g_Player[client].fragmsg.Noscope = event.noscope))
						{
							case false: bPrev_noscope = false;
							case true:
							{
								iNoscopes++;
								if(frags > 1 && !bPrev_noscope)
								{
									g_Player[client].fragmsg.Noscope = false;
								}
								bPrev_noscope = true;
							}
						}
						switch((g_Player[client].fragmsg.Airshot = event.airshot))
						{
							case false: bPrev_airshot = false;
							case true:
							{
								iAirshots++;
								if(frags > 1 && !bPrev_airshot)
								{
									g_Player[client].fragmsg.Airshot = false;
								}
								bPrev_airshot = true;
							}
						}
						switch((g_Player[client].fragmsg.Collateral = event.collateral))
						{
							case false: bPrev_collateral = false;
							case true:
							{
								iCollaterals++;
								if(frags > 1 && !bPrev_collateral)
								{
									g_Player[client].fragmsg.Collateral = false;
								}
								bPrev_collateral = true;
							}
						}
						switch((g_Player[client].fragmsg.MidAir = event.midair))
						{
							case false: bPrev_midair = false;
							case true:
							{
								iMidAirFrags++;
								if(frags > 1 && !bPrev_midair)
								{
									g_Player[client].fragmsg.MidAir = false;
								}
								bPrev_midair = true;
							}
						}
						
						bool bValidWeapon = true;
						if(event.suicide_assisted)
						{
							points += g_SuicideAssisted.IntValue;
							bValidWeapon = false;
						}
						
						if(bValidWeapon)
						{
							iWepFrags++;
							list_wepfrag[i] = true;
							
							int itemdef = (list_itemdef[i] = event.itemdef);
							ConVar cvar_points;
							switch((cvar_points = array_GetWeapon(itemdef)) == null)
							{
								case false: points += cvar_points.IntValue;
								case true:
								{
									LogError("%s itemdef %i has invalid convar!"
									... "\nattacker userid : %i"
									... "\nvictim userid : %i"
									... "\nclassname : '%s'"
									... "\n "
									, core_chattag, itemdef
									, GetClientUserId(client)
									, list[i]
									, list_classname[i]);
									continue;
								}
							}
						}
					}
					
					g_Game[client].aFragEvent.Clear();
					
					int attacker = GetClientUserId(client); // native string arrays needs to be added (・`ω´・)
					_sm_stats_player_death_fwd(attacker, frags, list, list_assister, event.classname, list_itemdef);
					
					char dummy[256];
					GetMultipleTargets(client, list, frags, dummy, sizeof(dummy));
					
					txn = new Transaction();
					AssistedKills(txn, list, list_assister, list_assister_dominate, list_assister_revenge, frags, client, list_steamid_assister, sizeof(list_steamid_assister));
					VictimDied(txn, list, frags);
					
					char query[4096], query_map[4096];
					int len = 0, len_map = 0;
					len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set `Frags`=`Frags`+%i", frags);
					len_map += Format(query_map[len_map], sizeof(query_map)-len_map, "update `"...sql_table_maps_log..."` set `Frags`=`Frags`+%i", frags);
					
					if(iWepFrags > 0)
					{
						// needs to be arrayed, multiple same classname calls for update.
						
						ArrayList lmao = new ArrayList(sizeof(TempLmao));
						
						for(int i = 0; i < frags; i++)
						{
							if(list_wepfrag[i])
							{
								int index;
								switch((index = lmao.FindString(list_classname[i])) == -1)
								{
									// valid, updating..
									case false:
									{
										TempLmao epic;
										lmao.GetArray(index, epic, sizeof(epic));
										epic.quantity++;
										lmao.SetArray(index, epic, sizeof(epic));
									}
									
									// not valid, adding..
									case true:
									{
										TempLmao epic;
										strcopy(epic.classname, sizeof(epic.classname), list_classname[i]);
										epic.itemdef = list_itemdef[i];
										epic.quantity = 1;
										lmao.PushArray(epic, sizeof(epic));
									}
								}
							}
						}
						
						for(int i = 0; i < lmao.Length; i++)
						{
							TempLmao epic;
							lmao.GetArray(i, epic, sizeof(epic));
							
							char fix_weapon[64], query_wep[256];
							CorrectWeaponClassname(fix_weapon, sizeof(fix_weapon), epic.itemdef, epic.classname);
							Format(query_wep, sizeof(query_wep), "update `"...sql_table_weapons..."` set `%s`=`%s`+'%i' where `SteamID`='%s' and `StatsID`='%i'"
							, fix_weapon, fix_weapon, epic.quantity, g_Player[client].auth, g_StatsID);
							txn.AddQuery(query_wep, queryId_frag_weapon);
							
							if(bDebug) PrintToServer("%s OnPlayerDeath() DEBUG: [userid %i] classname '%s' / itemdef '%i' / quantity '%i'"
							, core_chattag, attacker, epic.classname, epic.itemdef, epic.quantity);
						}
						
						delete lmao;
					}
					if(iHeadshots > 0)
					{
						g_Player[client].session[Stats_Headshots] += iHeadshots;
						len += Format(query[len], sizeof(query)-len, ",`Headshots`=`Headshots`+%i", iHeadshots);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ",`Headshots`=`Headshots`+%i", iHeadshots);
					}
					if(iBackstabs > 0)
					{
						g_Player[client].session[Stats_Backstabs] += iBackstabs;
						len += Format(query[len], sizeof(query)-len, ",`Backstabs`=`Backstabs`+%i", iBackstabs);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ",`Backstabs`=`Backstabs`+%i", iBackstabs);
					}
					if(iDominated > 0)
					{
						g_Player[client].session[Stats_Dominations] += iDominated;
						len += Format(query[len], sizeof(query)-len, ",`Dominations`=`Dominations`+%i", iDominated);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ",`Dominations`=`Dominations`+%i", iDominated);
					}
					if(iRevenges > 0)
					{
						g_Player[client].session[Stats_Revenges] += iRevenges;
						len += Format(query[len], sizeof(query)-len, ",`Revenges`=`Revenges`+%i", iRevenges);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ",`Revenges`=`Revenges`+%i", iRevenges);
					}
					if(iNoscopes > 0)
					{
						g_Player[client].session[Stats_Noscopes] += iNoscopes;
						len += Format(query[len], sizeof(query)-len, ",`Noscopes`=`Noscopes`+%i", iNoscopes);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ",`Noscopes`=`Noscopes`+%i", iNoscopes);
					}
					if(iAirshots > 0)
					{
						g_Player[client].session[Stats_Airshots] += iAirshots;
						len += Format(query[len], sizeof(query)-len, ", Airshots = Airshots+%i", iAirshots);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", Airshots = Airshots+%i", iAirshots);
					}
					if(iCollaterals > 0)
					{
						g_Player[client].session[Stats_Collaterals] += iCollaterals;
						len += Format(query[len], sizeof(query)-len, ",`Collaterals`=`Collaterals`+%i", iCollaterals);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ",`Collaterals`=`Collaterals`+%i", iCollaterals);
						
						if(g_Collateral.IntValue)
						{
							points += g_Collateral.IntValue;
						}
					}
					if(iMidAirFrags > 0)
					{
						g_Player[client].session[Stats_MidAirFrags] += iMidAirFrags;
						len += Format(query[len], sizeof(query)-len, ",`MidAirFrags`=`MidAirFrags`+%i", iMidAirFrags);
						len_map += Format(query[len_map], sizeof(query_map)-len_map, ",`MidAirFrags`=`MidAirFrags`+%i", iMidAirFrags);
					}
					
					//
					
					g_Player[client].session[Stats_Frags] += frags;
					
					if(points >= 1 && !g_Player[client].bPenalty)
					{
						g_Player[client].session[Stats_Points] += points;
						g_Player[client].points += points;
						len += Format(query[len], sizeof(query)-len, ",`Points`=`Points`+%i", points);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ",`Points`=`Points`+%i", points);
					}
					
					len += Format(query[len], sizeof(query)-len, " where `SteamID`='%s' and `StatsID`='%i'", g_Player[client].auth, g_StatsID);
					len_map += Format(query_map[len_map], sizeof(query_map)-len_map, " where `StatsID`='%i'", g_StatsID);
					txn.AddQuery(query, queryId_frag_playerlist);
					txn.AddQuery(query_map, queryId_frag_playerlist_MapUpdate);
					
					// kill log
					
					int lenk;
					char queryk[4096];
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "insert into `"...sql_table_kill_log..."`");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "(");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "StatsID");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",SteamID_Attacker");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",SteamID_Victim");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",SteamID_Assister");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Timestamp");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Itemdefs");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Quantity");
					
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Dominations");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Revenges");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Airshots");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Headshots");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Noscopes");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Backstabs");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Collaterals");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",MidAirFrags");
					
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ")");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "values");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "(");
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "%i", g_StatsID);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%s'", g_Player[client].auth);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%s'", list_steamid_victim);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%s'", list_steamid_assister);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_timestamp);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%s'", list_itemdefs);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", frags);
					
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", iDominated);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", iRevenges);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", iAirshots);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", iHeadshots);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", iNoscopes);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", iBackstabs);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", iCollaterals);
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", iMidAirFrags);
					
					lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ")");
					txn.AddQuery(queryk, query_error_uniqueid_OnKillLogInsert);
					
					//
					
					if(g_Player[client].active_page_session > 0)
					{
						StatsMenu.Session(client, g_Player[client].active_page_session);
					}
					
					// translation, separated instead.
					if(points >= 1 && g_Player[client].bShowFragMsg)
					{
						PrepareFragMessage(client, dummy, points, frags);
					}
				}
			}
		}
		
		//
		
		if(txn != null)
		{
			sql.Execute(txn, _, TXN_OnGameFrameCallback_Failure);
		}
	}
	
	return Plugin_Continue;
}

//

stock void OnClientDisconnect_Post_Game(int client)
{
	//g_Game[client].Reset();
}