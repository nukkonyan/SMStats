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
	int userid;
	int assister;
	
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
	
	if(!sql)
	{
		LogError("%s OnPlayerDeath error: No database connection available.", core_chattag);
		return;
	}
	
	int userid = event.GetInt("userid");
	int attacker = event.GetInt("attacker");
	if(userid < 1
	|| attacker < 1)
	{
		return;
	}
	
	int client = 0;
	if(!IsValidClient((client = GetClientOfUserId(attacker))))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	int victim = 0;
	if(!IsValidClient((victim = GetClientOfUserId(userid)), false))
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
	
	if(client == victim)
	{
		g_Player[client].session[Stats_Suicides]++;
		return;
	}
	
	if(GetClientTeam(client) == GetClientTeam(victim))
	{
		return;
	}
	
	int assister = GetLatestAssister(victim, client);
	
	//
	
	bool assisted_suicide = false;
	
	char classname[64];
	event.GetString("weapon", classname, sizeof(classname));
	
	if(!(assisted_suicide = (StrContains(classname, "world") != -1 && assister > 0)))
	{
		return;
	}
	
	int itemdef = 0;
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
	
	bool headshot = event.GetBool("headshot");
	
	
	//
	
	FragEventInfo frag;
	frag.userid = userid;
	frag.assister = assister;
	
	frag.suicide = (userid == attacker);
	frag.suicide_assisted = assisted_suicide; // will be redone soon to be separated.
	frag.headshot = headshot;
	frag.backstab = false;
	frag.noscope = false;
	
	frag.collateral = false;
	
	frag.midair = IsClientMidAir(client);
	frag.airshot = (GetClientFlags(victim) == 258);
	
	frag.blinded = m_bIsBlinded[client];
	
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
		Format(query, sizeof(query), "update `%s` set BombsPlanted = BombsPlanted+1 where SteamID='%s' and ServerID = %i"
		, sql_table_playerlist, g_Player[client].auth, g_ServerID);
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
		Format(query, sizeof(query), "update `%s` set BombsDefused = BombsDefused+1 where SteamID = '%s' and ServerID = %i"
		, sql_table_playerlist, g_Player[client].auth, g_ServerID);
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
		Format(query, sizeof(query), "update `%s` set BombsExploded = BombsExploded+1 where SteamID='%s' and ServerID = %i"
		, sql_table_playerlist, g_Player[client].auth, g_ServerID);
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
			
			Format(query, sizeof(query), "update `%s` set Points = Points+%i, HostagesRescued = HostagesRescued+1 where SteamID = '%s' and ServerID = %i",
			sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
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
			
			Format(query, sizeof(query), "update `%s` set Points = Points+%i, HostagesFragged = HostagesFragged+1 where SteamID = '%s' and ServerID = %i",
			sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
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
	Format(query, sizeof(query), "update `%s` set FlashedOpponents = FlashedOpponents+1 where SteamID = '%s' and ServerID = %i"
	, sql_table_playerlist, g_Player[client].auth, g_ServerID);
	sql.Query(DBQuery_Callback, query);
}

Action Timer_OnPlayerBlinded(Handle timer, int client)
{
	m_bIsBlinded[client] = false;
	return Plugin_Continue;
}

/* ===================================================================================== */

public void OnGameFrame()
{
	if(!bLoaded)
	{
		return;
	}
	
	//CheckActivePlayers();
	
	// this is because it's called a little bit too early when you pull multiple kill within a short span,
	// causing independant 'events' when it was within one 'event'.
	CreateTimer(0.1, Timer_OnGameFrame);
}

Action Timer_OnGameFrame(Handle timer)
{
	int client = 0;
	
	while((client = FindEntityByClassname(client, "player")) > 0)
	{
		if(!IsValidClient(client))
		{
			continue;
		}
		
		if(!!g_Game[client].aFragEvent)
		{
			int frags;
			if((frags = g_Game[client].aFragEvent.Length) > 0)
			{
				FragEventInfo event;
				int[] list = new int[frags];
				int[] list_assister = new int[frags];
				int count_frags;
				int count_assisted_suicide;
				
				for(int i = 0; i < frags; i++)
				{
					g_Game[client].aFragEvent.GetArray(i, event, sizeof(event));
					list[i] = event.userid;
					list_assister[i] = event.assister;
					if(event.suicide_assisted)
					{
						count_assisted_suicide++;
					}
					else
					{
						count_frags++;
					}
				}
				
				g_Game[client].aFragEvent.Clear();
				
				int attacker = GetClientOfUserId(client);
				_sm_stats_player_death_fwd(attacker, frags, list, list_assister, event.classname, event.itemdef);
				
				char dummy[256];
				GetMultipleTargets(client, list, frags, dummy, sizeof(dummy));
				
				Transaction txn = new Transaction();
				
				int points = 0;
				if(count_frags > 0)
				{
					points += (array_GetWeapon(event.itemdef).IntValue * frags);
				}
				if(count_assisted_suicide > 0)
				{
					points += (count_assisted_suicide * g_SuicideAssisted.IntValue);
				}
				
				AssistedKills(txn, list_assister, frags, client, event);
				VictimDied(txn, list, frags);
				
				//
				
				char query[512];
				int len = 0;
				len += Format(query[len], sizeof(query)-len, "update `%s` set Frags = Frags+%i", sql_table_playerlist, frags);
				
				char fix_weapon[256];
				CorrectWeaponClassname(fix_weapon, sizeof(fix_weapon), event.itemdef);
				
				char query_wep[256];
				Format(query_wep, sizeof(query_wep), "update `%s` set %s = %s+1 where SteamID = '%s' and ServerID = %i"
				, sql_table_weapons, fix_weapon, fix_weapon, g_Player[client].auth, g_ServerID);
				txn.AddQuery(query_wep, queryId_frag_weapon);
				
				//
				
				if(event.headshot)
				{
					g_Player[client].session[Stats_Headshots]++;
					g_Player[client].fragmsg.Headshot = true;
					len += Format(query[len], sizeof(query)-len, ", Headshots = Headshots+%i", frags);
				}
				
				if(event.backstab)
				{
					g_Player[client].session[Stats_Backstabs]++;
					g_Player[client].fragmsg.Backstab = true;
					len += Format(query[len], sizeof(query)-len, ", Backstabs = Backstabs+%i", frags);
				}
				
				if(event.dominated)
				{
					g_Player[client].session[Stats_Dominations]++;
					g_Player[client].fragmsg.Domination = true;
					len += Format(query[len], sizeof(query)-len, ", Dominations = Dominations+%i", frags);
				}
				
				if(event.revenge)
				{
					g_Player[client].session[Stats_Revenges]++;
					g_Player[client].fragmsg.Revenge = true;
					len += Format(query[len], sizeof(query)-len, ", Revenges = Revenges+%i", frags);
				}
				
				if(event.noscope)
				{
					g_Player[client].session[Stats_Noscopes]++;
					g_Player[client].fragmsg.Noscope = true;
					len += Format(query[len], sizeof(query)-len, ", Noscopes = Noscopes+%i", frags);
				}
				
				if(event.airshot)
				{
					g_Player[client].session[Stats_Airshots]++;
					g_Player[client].fragmsg.Airshot = true;
					len += Format(query[len], sizeof(query)-len, ", Airshots = Airshots+%i", frags);
				}
				
				if(event.collateral)
				{
					g_Player[client].session[Stats_Collaterals]++;
					g_Player[client].fragmsg.Collateral = true;
					len += Format(query[len], sizeof(query)-len, ", Collaterals = Collaterals+%i", frags);
					
					if(g_Collateral.IntValue)
					{
						points += g_Collateral.IntValue;
					}
				}
				
				if(event.midair)
				{
					g_Player[client].session[Stats_MidAirFrags]++;
					g_Player[client].fragmsg.MidAir = true;
					len += Format(query[len], sizeof(query)-len, ", MidAirFrags = MidAirFrags+%i", frags);
				}
				
				g_Player[client].session[Stats_Frags] += frags;
				
				if(points > 0)
				{
					g_Player[client].session[Stats_Points] += points;
					g_Player[client].points += points;
					len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
					
					PrepareFragMessage(client, dummy, points, frags);
				}
				
				len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
				txn.AddQuery(query, queryId_frag_playerlist);
				
				sql.Execute(txn, _, FragEvent_OnFailed, attacker);
				
				if(g_Player[client].active_page_session > 0)
				{
					StatsMenu.Session(g_Player[client].active_page_session);
				}
			}
		}
	}
	
	return Plugin_Continue;
}

//

void GetMultipleTargets(int client, int[] list, int counter, char[] dummy, int maxlen)
{
	if(counter == 1)
	{
		int userid = list[0];
		int target = GetClientOfUserId(userid);
		strcopy(dummy, maxlen, g_Player[target].name);
	}
	else if(counter == 2)
	{
		int userid1 = list[0];
		int target1 = GetClientOfUserId(userid1);
		
		int userid2 = list[1];
		int target2 = GetClientOfUserId(userid2);
		
		Format(dummy, maxlen, "%s%T%s%T", g_Player[target1].name, "#SMStats_And", client, g_Player[target2].name, "#SMStats_Counter", client, counter);
	}
	else if(counter > 2 && counter <= 4)
	{
		for(int i = 0; i < counter-1; i++)
		{
			int userid = list[i];
			int target = GetClientOfUserId(userid);
			
			if(dummy[0] != '\0')
			{
				Format(dummy, maxlen, "%s%T", dummy, "#SMStats_Comma", client);
			}
			
			Format(dummy, maxlen, "%s%s", dummy, g_Player[target].name);
		}
		
		int target = GetClientOfUserId(list[counter-1]);
		Format(dummy, maxlen, "%s%T%s%T", dummy, "#SMStats_And", client, g_Player[target].name, "#SMStats_Counter", client, counter);
		// outputs the "and last player".
	}
	else
	{
		Format(dummy, maxlen, "%T", "#SMStats_MultipleTargets", client);
	}
}

//

void OnClientDisconnect_Post_Game(int client)
{
	g_Game[client].Reset();
}