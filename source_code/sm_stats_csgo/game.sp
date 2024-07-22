/* ========== Convars ========= */
ConVar g_cvarCollateral;

ConVar g_cvarBurned;

//

enum struct FragEventInfo
{
	int timestamp;
	int userid;
	int assister;
	int inflictor;
	int crit_type;
	
	int penetrated;
	
	bool teamfrag;
	bool suicide;
	bool headshot;
	bool backstab;
	bool noscope;
	bool smoked;
	bool blinded;
	bool dominated;
	bool revenge;
	bool gibfrag;
	bool collateral;
	bool grenade;
	bool midair;
	bool airshot;
	bool quickscope;
	bool wallbang;
	bool burned;
	bool knifed;
	
	char classname[64];
	int itemdef;
}

//

void PrepareGame()
{
	/* other */
	g_cvarCollateral = CreateConVar("sm_stats_points_collateral", "2", "SMStats: CSGO - Points earned when doing a collateral frag.", _, true);
	g_cvarBurned = CreateConVar("sm_stats_points_burned", "2", "SMStats: CSGO - Points earned when burning an enemy.", _, true);
	
	/* ========================================================================================== */
	
	/* weapons */
	array_InitializeWeapons();
	array_AddWeapon(1, "sm_stats_points_deagle", 10, "Desert Eagle");
	array_AddWeapon(2, "sm_stats_points_elites", 10, "Dual Elites");
	array_AddWeapon(3, "sm_stats_points_fiveseven", 10, "Five-SeveN");
	array_AddWeapon(4, "sm_stats_points_glock", 10, "Glock-18");
	array_AddWeapon(7, "sm_stats_points_ak47", 10, "AK-47");
	array_AddWeapon(8, "sm_stats_points_aug", 10, "AUG");
	array_AddWeapon(9, "sm_stats_points_awp", 10, "AWP");
	array_AddWeapon(10, "sm_stats_points_famas", 10, "FAMAS");
	array_AddWeapon(11, "sm_stats_points_g3sg1", 10, "G3SG1");
	array_AddWeapon(13, "sm_stats_points_galilar", 10, "Galil-AR");
	array_AddWeapon(14, "sm_stats_points_m249", 10, "M249");
	array_AddWeapon(16, "sm_stats_points_m4a4", 10, "M4A4");
	array_AddWeapon(17, "sm_stats_points_mac10", 10, "MAC-10");
	array_AddWeapon(19, "sm_stats_points_p90", 10, "P90");
	array_AddWeapon(23, "sm_stats_points_mp5", 10, "MP5");
	array_AddWeapon(24, "sm_stats_points_ump45", 10, "UMP45");
	array_AddWeapon(25, "sm_stats_points_xm1014", 10, "XM1014");
	array_AddWeapon(26, "sm_stats_points_bizon", 10, "Bizon");
	array_AddWeapon(27, "sm_stats_points_mag7", 10, "MAG7");
	array_AddWeapon(28, "sm_stats_points_negev", 10, "Negev");
	array_AddWeapon(29, "sm_stats_points_sawedoff", 10, "Sawed-Off");
	array_AddWeapon(30, "sm_stats_points_tec9", 10, "TEC-9");
	array_AddWeapon(31, "sm_stats_points_taser", 10, "Taser");
	array_AddWeapon(32, "sm_stats_points_p2000", 10, "P2000");
	array_AddWeapon(33, "sm_stats_points_mp7", 10, "MP7");
	array_AddWeapon(34, "sm_stats_points_mp9", 10, "MP9");
	array_AddWeapon(35, "sm_stats_points_nova", 10, "Nova");
	array_AddWeapon(36, "sm_stats_points_p250", 10, "P250");
	array_AddWeapon(38, "sm_stats_points_scar20", 10, "SCAR-20");
	array_AddWeapon(39, "sm_stats_points_sg553", 10, "SG553");
	array_AddWeapon(40, "sm_stats_points_ssg08", 10, "SSG08");
	array_AddWeapon(41, "sm_stats_points_knife", 10, "Knife"); // Arms-Race Golden Knife.
	array_AddSameWeapon(41, 42); // Counter-Terrorist Knife.
	array_AddWeapon(43, "sm_stats_points_flashbang", 10, "Flashbang Grenade");
	array_AddWeapon(44, "sm_stats_points_hegrenade", 10, "High-Explosive Grenade");
	array_AddWeapon(45, "sm_stats_points_smokegrenade", 10, "Smoke Grenade");
	array_AddWeapon(46, "sm_stats_points_molotov", 10, "Molotov");
	array_AddWeapon(47, "sm_stats_points_decoy", 10, "Decoy");
	array_AddWeapon(48, "sm_stats_points_incendiary", 10, "Incendiary Grenade");
	array_AddSameWeapon(41, 59); // Terrorist Knife.
	array_AddWeapon(60, "sm_stats_points_m4a1", 10, "M4A1-S");
	array_AddWeapon(61, "sm_stats_points_usp", 10, "USP-S");
	array_AddWeapon(62, "sm_stats_points_cz75a", 10, "CZ75-A");
	array_AddWeapon(64, "sm_stats_points_revolver", 10, "Revolver");
	//array_AddWeapon(69, "sm_stats_points_dz_barehands", 10, "Bare Hands");
	//array_AddWeapon(70, "sm_stats_points_breachcharge", 10, "Breach Charge");
	array_AddWeapon(80, "sm_stats_points_knife_spectral", 10, "Spectral Knife");
	array_AddWeapon(500, "sm_stats_points_knife_bayonet", 10, "Bayonet Knife");
	array_AddWeapon(503, "sm_stats_points_knife_classic", 10, "Classic Knife");
	array_AddWeapon(505, "sm_stats_points_knife_flip", 10, "Flip Knife");
	array_AddWeapon(506, "sm_stats_points_knife_gut", 10, "Gut Knife");
	array_AddWeapon(507, "sm_stats_points_knife_karambit", 10, "Karambit Knife");
	array_AddWeapon(508, "sm_stats_points_knife_m9_bayonet", 10, "M9 Bayonet Knife");
	array_AddWeapon(509, "sm_stats_points_knife_huntsman", 10, "Huntsman Knife");
	array_AddWeapon(512, "sm_stats_points_knife_falchion", 10, "Falchion Knife");
	array_AddWeapon(514, "sm_stats_points_knife_bowie", 10, "Bowie Knife");
	array_AddWeapon(515, "sm_stats_points_knife_butterfly", 10, "Butterfly Knife");
	array_AddWeapon(516, "sm_stats_points_knife_shadowdaggers", 10, "Shadow Daggers");
	array_AddWeapon(517, "sm_stats_points_knife_paracord", 10, "Paracord Knife");
	array_AddWeapon(518, "sm_stats_points_knife_survival", 10, "Survival Knife");
	array_AddWeapon(519, "sm_stats_points_knife_ursus", 10, "Ursus Knife");
	array_AddWeapon(520, "sm_stats_points_knife_navaja", 10, "Navaja Knife");
	array_AddWeapon(521, "sm_stats_points_knife_nomad", 10, "Nomad Knife");
	array_AddWeapon(522, "sm_stats_points_knife_stiletto", 10, "Stiletto Knife");
	array_AddWeapon(523, "sm_stats_points_knife_talon", 10, "Talon Knife");
	array_AddWeapon(525, "sm_stats_points_knife_skeleton", 10, "Skeleton Knife");
	
	/* ========================================================================================== */
	
	/* events */
	
	/* core */
	HookEvent("player_death", OnPlayerDeath, EventHookMode_Pre);
	HookEvent("player_team", OnPlayerTeamChange, EventHookMode_Pre);
	
	/* item was traded, found, unboxed, etc */
	//HookEvent("item_found", OnItemFound, EventHookMode_Pre);
	
	/* Rounds */
	
	/* Round started */
	HookEvent("round_start", OnRoundStarted, EventHookMode_Pre);
	
	/* Round ended */
	HookEvent("round_end", OnRoundEnded, EventHookMode_Pre);
	
	// AutoExecConfig(true);
}

/* Called as soon as a player is killed. */
stock void OnPlayerDeath(Event event, const char[] szASDF, bool bASDF)
{
	if(!IsValidStats())
	{
		return;
	}
	
	if(!sql)
	{
		LogError(core_chattag..." OnPlayerDeath error: No database connection available.");
		return;
	}
	
	int userid, attacker, client, victim;
	if((userid = event.GetInt("userid")) < 1
	|| (attacker = event.GetInt("attacker")) < 1)
	{
		return;
	}
	if(!IsValidClient((client = GetClientOfUserId(attacker)))
	|| !IsValidClient((victim = GetClientOfUserId(userid)), !bAllowBots))
	{
		return;
	}
	if(IsValidAbuse(client))
	{
		return;
	}
	
	//
	
	if(client == victim)
	{
		g_Player[client].session[Stats_Suicides]++;
		return;
	}
	
	bool bTeamFrag;
	if(g_Player[client].iTeam == g_Player[victim].iTeam)
	{
		bTeamFrag = true;
		
		if(!bAllowTeamFrag)
		{
			return;
		}
	}
	
	int assister = event.GetInt("assister");
	
	char classname[64];
	event.GetString("weapon", classname, sizeof(classname));
	
	if(StrContains(classname, "trigger_") != -1
	|| StrContains(classname, "prop_") != -1
	|| (StrEqual(classname, "world") && assister < 1))
	{
		return;
	}
	
	int itemdef = event.GetInt("weapon_fauxitemid");
	
	bool bValidMidAir = true;
	bool bBackstab = false;
	bool bGrenade = false;
	bool bBurned = false;
	bool bKnifed = false;
	
	if(StrEqual(classname, "flashbang"))
	{
		// weapon_flashbang
		itemdef = 43;
	}
	else if(StrEqual(classname, "hegrenade"))
	{
		bGrenade = true;
		
		// weapon_hegrenade
		itemdef = 44;
	}
	else if(StrEqual(classname, "smokegrenade"))
	{
		// weapon_smokegrenade
		itemdef = 45;
	}
	else if(StrEqual(classname, "molotov"))
	{
		// weapon_molotov
		itemdef = 46;
	}
	else if(StrEqual(classname, "incgrenade"))
	{
		// weapon_incgrenade
		itemdef = 47;
	}
	else if(StrEqual(classname, "inferno"))
	{
		bBurned = true;
		
		switch(m_hLastFirebombGrenade[client])
		{
			// weapon_molotov
			case 46:
			{
				strcopy(classname, sizeof(classname), "weapon_molotov");
				itemdef = 46;
			}
			// weapon_incgrenade
			case 48:
			{
				strcopy(classname, sizeof(classname), "weapon_incgrenade");
				itemdef = 48;
			}
		}
	}
	else if(StrContains(classname, "knife", false) != -1)
	{
		bKnifed = true;
	}
	
	//
	
	if(itemdef != ITEMDEF_INVALID)
	{
		if(itemdef > MaxItemDef)
		{
			LogError("%s An error has occured, itemdef %i (classname '%s') seems to be new to the current version (%s) and needs to be updated."
			, core_chattag, itemdef, classname, Version);
			CPrintToChat(client, "%s %T"
			, g_ChatTag, "#SMStats_FragEventError_NewItem", client, itemdef, classname, Version);
			return;
		}
		else if(itemdef < 0)
		{
			LogError("%s An error has occured, itemdef %i (classname '%s') is invalid."
			, core_chattag, itemdef, classname);
			CPrintToChat(client, "%s %T"
			, g_ChatTag, "#SMStats_FragEventError_InvalidItem", client, itemdef, classname);
			return;
		}
		else if(!array_GetWeapon(itemdef))
		{
			LogError("%s An error has occured, itemdef %i (classname '%s') seems to have invalid convar handle! (New item perhaps?)"
			, core_chattag, itemdef, classname);
			CPrintToChat(client, "%s %T"
			, g_ChatTag, "#SMStats_FragEventError_InvalidItemCvar", client, itemdef, classname);
			return;
		}
		else if(array_GetWeapon(itemdef).IntValue < 1)
		{
			return;
		}
	}
	
	// quickscope check
	
	bool bQuickscope = false; // will use timestamp check to correctly identify if the kill was a quickscope.
	
	if(StrEqual(classname, "awp")
	|| StrEqual(classname, "ssg08")
	|| StrEqual(classname, "scar20")
	|| StrEqual(classname, "g3sg1"))
	{
		int sniper = GetPlayerWeaponSlot(client, 0);
		
		if(IsValidEntity(sniper))
		{
			bool bZoomed = CStrike_IsSniperRifleZoomed(sniper);
			
			if(bZoomed)
			{
				int scoped_level = n_hLastSniperScopedInfo[0][client];
				
				if(scoped_level > 0)
				{
					int time_scoped = n_hLastSniperScopedInfo[1][client];
					int time_frag = GetGameTickCount();
					int time = ( time_frag - time_scoped );
					
					PrintToServer("Quickscope Debug:"
					... "\nscoped_level : %i"
					... "\ntime_scoped : %i"
					... "\ntime_frag : %i"
					... "\ntime : %i"
					, scoped_level
					, time_scoped
					, time_frag
					, time);
					
					if(time <= 24)
					{
						bQuickscope = true;
					}
				}
			}
		}
	}
	
	// wallbang check
	
	bool bWallbang = false;
	
	//
	
	int penetrated;
	
	FragEventInfo frag;
	frag.timestamp = GetTime();
	frag.userid = userid;
	frag.assister = assister;
	frag.teamfrag = bTeamFrag;
	frag.suicide = (userid == attacker);
	frag.headshot = event.GetBool("headshot");
	frag.backstab = bBackstab;
	frag.noscope =  event.GetBool("noscope");
	frag.smoked = event.GetBool("thrusmoke");
	frag.blinded = event.GetBool("attackerblind");
	frag.quickscope = bQuickscope;
	frag.wallbang = bWallbang;
	frag.burned = bBurned;
	frag.knifed = bKnifed;
	
	frag.dominated = event.GetBool("dominated");
	frag.revenge = event.GetBool("revenge");
	
	frag.collateral = ((penetrated = event.GetInt("penetrated")) > 0);
	frag.grenade = bGrenade;
	
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
		frag.airshot = (gd_userid >= 65.2517525135751254595*2);
	}
	
	strcopy(frag.classname, sizeof(frag.classname), classname);
	frag.itemdef = itemdef;
	
	//
	
	if(bDebug)
	{
		int assist = (assister > 0) ? GetClientOfUserId(assister) : 0;
		
		LogMessage("OnPlayerDeath() Debug : "
		..."\nattacker : %i ['%s'] (gd : %.1f) (g : %s)"
		..."\nvictim : %i ['%s'] (gd : %.1f) (g : %s)"
		..."\nassister : %i ['%s']"
		..."\nweapon itemdef : %i ['%s'] / id : %i"
		..."\npenetrated objects : %i"
		..."\nthrough smoke : %s"
		..."\nquickscope : %s"
		..."\nwallbang : %s"
		..."\nburned : %s"
		..."\nknifed : %s"
		..."\nteamfrag : %s"
		..."\n"
		, attacker, g_Player[client].name2, gd_attacker, g_attacker ? "true":"false"
		, userid, g_Player[victim].name2, gd_userid, g_userid ? "true":"false"
		, assister, (assist > 0) ? g_Player[assist].name2 : ""
		, itemdef, classname, event.GetInt("weapon_itemid")
		, penetrated
		, frag.smoked ? "true" : "false"
		, frag.quickscope ? "true" : "false"
		, frag.wallbang ? "true" : "false"
		, frag.burned ? "true" : "false"
		, frag.knifed ? "true" : "false"
		, frag.teamfrag ? "true" : "false");
	}
	
	//
	
	if(!g_Game[client].aFragEvent)
	{
		g_Game[client].aFragEvent = new ArrayList(sizeof(FragEventInfo));
	}
	
	g_Game[client].aFragEvent.PushArray(frag, sizeof(frag));
}

/* Called as soon as a player finds, unboxes, trades, etc an item. */
stock void OnItemFound(Event event, const char[] szASDF, bool bASDF)
{
	// to be added later
}

/* Called as soon a player changes their team. */
void OnPlayerTeamChange(Event event, const char[] szASDF, bool bASDF)
{
	if(bLoaded)
	{
		// too early to gather info, delay has to be added..
		CreateTimer(0.2, Timer_OnPlayerUpdated, event.GetInt("userid"));
	}
}

/* ===================================================================================== */

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
			
			#if defined load_menus
			if(g_Player[client].active_page_mainmenu >= 1)
			{
				StatsMenu.Main(client, g_Player[client].active_page_mainmenu);
			}
			else if(g_Player[client].active_page_session == 1)
			{
				StatsMenu.Session(client, g_Player[client].active_page_session);
			}
			#endif
			
			if(g_Game[client].aFragEvent != null)
			{
				int frags;
				if((frags = g_Game[client].aFragEvent.Length) > 0)
				{
					FragEventInfo event;
					int[] list = new int[frags];
					int[] list_assister = new int[frags];
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
					//int iThroughSmokes;
					int iAirshots;
					int iCollaterals;
					int iMidAirFrags;
					int iBurnedFrags;
					
					int iWepFrags;
					
					int points;
					
					// store temporary info for frag message
					
					bool bPrev_headshot;
					bool bPrev_backstab;
					bool bPrev_domination;
					bool bPrev_revenge;
					bool bPrev_noscope;
					bool bPrev_smoked;
					bool bPrev_blinded;
					bool bPrev_quickscope;
					bool bPrev_airshot;
					bool bPrev_collateral;
					bool bPrev_grenade;
					bool bPrev_midair;
					bool bPrev_burned;
					bool bPrev_knifed;
					
					//
					
					for(int i = 0; i < frags; i++)
					{
						g_Game[client].aFragEvent.GetArray(i, event, sizeof(event));
						list_timestamp = event.timestamp;
						int userid_victim = (list[i] = event.userid);
						list_assister[i] = event.assister;
						list_itemdef[i] = event.itemdef;
						strcopy(list_classname[i], sizeof(event.classname), event.classname);
						
						// kill log
						switch(strlen(list_itemdefs) < 1)
						{
							case false: Format(list_itemdefs, sizeof(list_itemdefs), "%s;%i", list_itemdefs, list_itemdef[i]);
							case true: Format(list_itemdefs, sizeof(list_itemdefs), "%i", list_itemdef[i]);
						}
						
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
						switch((g_Player[client].fragmsg.ThroughSmoke = event.smoked))
						{
							case false: bPrev_smoked = false;
							case true:
							{
								//iThroughSmokes++;
								if(frags > 1 && !bPrev_smoked)
								{
									g_Player[client].fragmsg.ThroughSmoke = false;
								}
								bPrev_smoked = true;
							}
						}
						switch((g_Player[client].fragmsg.Blinded = event.blinded))
						{
							case false: bPrev_blinded = false;
							case true:
							{
								if(frags > 1 && !bPrev_blinded)
								{
									g_Player[client].fragmsg.Blinded = false;
								}
								bPrev_blinded = true;
							}
						}
						switch((g_Player[client].fragmsg.Quickscope = event.quickscope))
						{
							case false: bPrev_quickscope = false;
							case true:
							{
								if(frags > 1 && !bPrev_quickscope)
								{
									g_Player[client].fragmsg.Quickscope = false;
								}
								bPrev_quickscope = true;
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
						switch((g_Player[client].fragmsg.Grenade = event.grenade))
						{
							case false: bPrev_grenade = false;
							case true:
							{
								if(frags > 1 && !bPrev_grenade)
								{
									g_Player[client].fragmsg.Grenade = false;
								}
								bPrev_grenade = true;
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
						switch((g_Player[client].fragmsg.Burned = event.burned))
						{
							case false: bPrev_burned = false;
							case true:
							{
								iBurnedFrags++;
								if(frags > 1 && !bPrev_burned)
								{
									g_Player[client].fragmsg.Burned = false;
								}
								bPrev_burned = true;
							}
						}
						switch((g_Player[client].fragmsg.Knifed = event.knifed))
						{
							case false: bPrev_knifed = false;
							case true:
							{
								if(frags > 1 && !bPrev_knifed)
								{
									g_Player[client].fragmsg.Knifed = false;
								}
								bPrev_knifed = true;
							}
						}
						
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
					
					g_Game[client].aFragEvent.Clear();
					
					int attacker = GetClientUserId(client); // native string arrays needs to be added (・`ω´・)
					_sm_stats_player_death_fwd(attacker, frags, list, list_assister, event.classname, list_itemdef);
					
					char dummy[256];
					GetMultipleTargets(client, list, frags, dummy, sizeof(dummy));
					
					txn = new Transaction();
					AssistedKills(txn, list, list_assister, frags, client, list_steamid_assister, sizeof(list_steamid_assister));
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
							txn.AddQuery(query_wep, queryId_kill_weapon);
							
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
						
						if(g_cvarCollateral.IntValue)
						{
							points += g_cvarCollateral.IntValue;
						}
					}
					if(iMidAirFrags > 0)
					{
						g_Player[client].session[Stats_MidAirFrags] += iMidAirFrags;
						len += Format(query[len], sizeof(query)-len, ",`MidAirFrags`=`MidAirFrags`+%i", iMidAirFrags);
						len_map += Format(query[len_map], sizeof(query_map)-len_map, ",`MidAirFrags`=`MidAirFrags`+%i", iMidAirFrags);
					}
					if(iBurnedFrags > 0)
					{
						g_Player[client].session[Stats_BurnedFrags] += iBurnedFrags;
						len += Format(query[len], sizeof(query)-len, ",`BurnedFrags`=`BurnedFrags`+%i", iBurnedFrags);
						len_map += Format(query[len_map], sizeof(query_map)-len_map, ",`BurnedFrags`=`BurnedFrags`+%i", iBurnedFrags);
						
						if(g_cvarBurned.IntValue)
						{
							points += g_cvarBurned.IntValue;
						}
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
					txn.AddQuery(query, queryId_kill_playerlist);
					txn.AddQuery(query_map, queryId_kill_playerlist_MapUpdate);
					
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
					
					#if defined load_menus
					if(g_Player[client].active_page_session > 0)
					{
						StatsMenu.Session(client, g_Player[client].active_page_session);
					}
					#endif
					
					// translation, separated instead.
					if(points >= 1 && g_Player[client].bShowFragMsg)
					{
						PrepareFragMessage(client, dummy, points, frags);
					}
				}
			}
			
			// \sm_stats_cstrike\game.sp
			
			MapTimer_GameTimer_CStrike(client, txn);
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

void OnClientDisconnect_Post_Game(int client)
{
	SMStatsInfo.ResetGameStats(client);
	g_Game[client].Reset();
}