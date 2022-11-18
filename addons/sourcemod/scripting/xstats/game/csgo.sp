/**
 *	Initialize: Counter-Strike Global Offensive.
 */
void PrepareGame_CSGO()	{
	//Weapon cvars
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Deagle, "xstats_points_weapon_deagle", 10, "Deagle");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Glock, "xstats_points_weapon_glock", 10, "Glock");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Ak47, "xstats_points_weapon_ak47", 10, "Ak47");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Aug, "xstats_points_weapon_aug", 10, "AUG");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_AWP, "xstats_points_weapon_awp", 10, "AWP");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Famas, "xstats_points_weapon_famas",	10, "FAMAS");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_G3SG1, "xstats_points_weapon_g3sg1",	10, "G3SG1");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_GalilAR, "xstats_points_weapon_galilar",	10, "Galilar");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_M249, "xstats_points_weapon_m249", 10, "M249");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_M4A4, "xstats_points_weapon_m4a4", 10, "M4A4.");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Mac10, "xstats_points_weapon_mac10", 10, "MAC10");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_P90, "xstats_points_weapon_p90", 10, "P90");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_MP5, "xstats_points_weapon_mp5", 10, "MP5-SD");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_UMP45, "xstats_points_weapon_ump45", 10, "UMP45");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_XM1014, "xstats_points_weapon_xm1014", 10, "XM1014");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Bizon, "xstats_points_weapon_bizon", 10, "PP-Bizon");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_MAG7, "xstats_points_weapon_mag7", 10, "MAG-7");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Negev, "xstats_points_weapon_negev", 10, "Negev");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_SawedOff, "xstats_points_weapon_sawedoff", 10, "Sawed-Off");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Tec9, "xstats_points_weapon_tec9", 10, "Tec9");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Taser, "xstats_points_weapon_taser", 10, "Taser");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_P2000, "xstats_points_weapon_hkp2000", 10, "P2000.");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_MP7, "xstats_points_weapon_mp7", 10, "MP7");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_MP9, "xstats_points_weapon_mp9", 10, "MP9");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Nova, "xstats_points_weapon_nova", 10, "Nova");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_P250, "xstats_points_weapon_p250", 10, "P250");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Scar20, "xstats_points_weapon_scar20", 10, "Scar-20.");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_SG556, "xstats_points_weapon_sg556",	10, "SG556");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_SSG08, "xstats_points_weapon_ssg08",	10, "Scout");
	Cvars.CreateCSGOWeapon(CSGO_Knife_CT, "xstats_points_weapon_knife",	10, "Knife");
	Cvars.SameWeapon(CSGO_Knife_Gold, CSGO_Knife_CT);
	Cvars.CreateCSGOWeapon(CSGO_Grenade_Flashbang, "xstats_points_weapon_flashbang", 10, "Flashbang.");
	Cvars.CreateCSGOWeapon(CSGO_Grenade_HEGrenade, "xstats_points_weapon_hegrenade", 10, "HE Grenade.");
	Cvars.CreateCSGOWeapon(CSGO_Grenade_SmokeGrenade, "xstats_points_weapon_smokegrenade", 10, "Smokegrenade");
	Cvars.CreateCSGOWeapon(CSGO_Grenade_Molotov, "xstats_points_weapon_molotov", 10, "Molotov");
	Cvars.CreateCSGOWeapon(CSGO_Grenade_Decoy, "xstats_points_weapon_decoy", 10, "Decoy");
	Cvars.CreateCSGOWeapon(CSGO_Grenade_Incendiary, "xstats_points_weapon_incendiary", 10, "Incendiary");
	Cvars.CreateCSGOWeapon(CSGO_Grenade_TAGrenade, "xstats_points_weapon_tagrenade", 10, "Tactical Awareness Grenade");
	Cvars.CreateCSGOWeapon(CSGO_Grenade_BreachCharge, "xstats_points_weapon_breachcharge", 10, "Breach Charge");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_C4, "xstats_points_weapon_c4", 10, "C4 Bomb");
	Cvars.SameWeapon(CSGO_Knife_T, CSGO_Knife_CT);
	Cvars.CreateCSGOWeapon(CSGO_Weapon_M4A1_S, "xstats_points_weapon_m4a1_silencer", 10, "M4A1-S");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_USP_S, "xstats_points_weapon_usp_silencer", 10, "USP-S");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_CZ75_A, "xstats_points_weapon_cz75a", 10, "CZ75-A");
	Cvars.CreateCSGOWeapon(CSGO_Weapon_Revolver, "xstats_points_weapon_revolver", 10, "Revolver");
	Cvars.SameWeapon(CSGO_Knife_Ghost, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Bayonet, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Classic, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Flip, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Gut, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Karambit, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_M9_Bayonet, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Huntsman, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Falchion, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Bowie, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Butterfly, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_ButtPlugs, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Paracord, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Survival, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Ursus, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Navaja, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Nomad, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Stiletto, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Talon, CSGO_Knife_CT);
	Cvars.SameWeapon(CSGO_Knife_Skeleton, CSGO_Knife_CT);
	
	/* Events */
	
	/* Deaths */
	HookEventEx(EVENT_PLAYER_DEATH, Player_Death_CSGO, EventHookMode_Pre);
	
	/* Other Deaths */
	HookEventEx(EVENT_OTHER_DEATH, Other_Death_CSGO, EventHookMode_Pre);
	
	/* Config file */
	AutoExecConfig(true, "csgo.xstats.plugin");
}

/* Deaths */
stock void Player_Death_CSGO(Event event, const char[] event_name, bool dontBroadcast) {
	if(!IsValidStats()) return;
	
	char weapon[64];
	event.GetString(EVENT_STR_WEAPON, weapon, sizeof(weapon));
	if(StrEqual(weapon, "world")
	|| StrEqual(weapon, "player")) {
		XStats_DebugText(false, "//===== XStats Debug Log: Player_Death_CSGO =====//");
		XStats_DebugText(false, "Detected invalid killer \"%s\", ignoring to prevent issues..\n", weapon);
		return; //Since it's not a valid killer, lets end here.
	}
	
	/* Another method but is not used.
	Entity planted_c4 = Entity_Invalid;
	while((planted_c4 = Entity.FindByClassname(planted_c4, "planted_c4")) != Entity_Invalid)	{
		if(planted_c4.IsValid() && planted_c4.Owner > 0)
			client = planted_c4.Owner;
	}
	*/
	
	int client = StrEqual(weapon, "planted_c4") ? m_hLastBombPlanter : GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	
	if(!Tklib_IsValidClient(client, true) || !Tklib_IsValidClient(victim))
		return;
	
	if(IsValidAbuse(client) || IsSamePlayers(client, victim) || IsSameTeam(client, victim) || IsFakeClient(victim) && !Cvars.AllowBots.BoolValue)
		return;
	
	/* Fix the weapon entity prefix */
	Format(weapon, sizeof(weapon), "weapon_%s", weapon);
	
	if(StrEqual(weapon, "weapon_breachcharge_projectile"))
		weapon = "weapon_breachcharge";
	if(StrContains(weapon, "weapon_planted_c4") != -1)
		weapon = "weapon_c4";
	
	/* Since 'inferno' applies for Incendiary and Molotov. */
	if(StrEqual(weapon, "weapon_inferno")) {
		switch(m_hLastFirebombGrenade[client])	{
			case CSGO_Grenade_Molotov: weapon = "weapon_molotov";
			case CSGO_Grenade_Incendiary: weapon = "weapon_incgrenade";
		}
	}
	
	/* Make sure the midair is unchecked for grenade kills. */
	bool grenadekill = (StrEqual(weapon, "weapon_molotov")
	|| StrEqual(weapon, "weapon_incgrenade")
	|| StrEqual(weapon, "weapon_flashbang")
	|| StrEqual(weapon, "weapon_decoy")
	|| StrEqual(weapon, "weapon_hegrenade")
	|| StrEqual(weapon, "weapon_frag")
	|| StrEqual(weapon, "weapon_tagrenade")
	|| StrEqual(weapon, "weapon_snowball")); /* Not really a grenade but whatever, just for some specific stuff */
	
	int assist = GetClientOfUserId(event.GetInt(EVENT_STR_ASSISTER));
	int defindex = CSGO_GetItemDefindex(weapon);
	//int penetrated = event.GetInt(EVENT_STR_PENETRATED);
	bool midair = IsClientMidAir(client);
	bool headshot = event.GetBool(EVENT_STR_HEADSHOT);
	bool dominated = event.GetBool(EVENT_STR_DOMINATED);
	bool revenge = event.GetBool(EVENT_STR_REVENGE);
	bool noscope = event.GetBool(EVENT_STR_NOSCOPE);
	bool thrusmoke = event.GetBool(EVENT_STR_THRUSMOKE);
	bool attackerblind = event.GetBool(EVENT_STR_ATTACKERBLIND);
	bool knifekill = (StrContains(weapon, "knife", false) != -1); /* Support custom plugins */
	bool bombkill = ((StrContains(weapon, "c4", false) != -1) || StrContains(weapon, "breachcharge") != -1);
	//bool collateral = (penetrated > 0);
	
	if(Cvars.Weapon[defindex] == null)	{
		XStats_DebugText(false, "weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.\n", weapon, defindex);
		return;
	}
	
	if(StrEqual(weapon, "weapon_knife", false)) {
		char clsname[][] = {"","","weapon_knife_t","weapon_knife_ct"};
		strcopy(weapon, sizeof(weapon), clsname[CS_GetClientTeam(client)]);
		//Make the knife to its respected team. T player with default knife -> weapon_knife_t. ct player with default knife -> weapon_knife_ct.
	}
	
	if(StrEqual(weapon, "weapon_m4a1", false)) {
		weapon = "weapon_m4a4";
		//It's proper name. M4A4 is not a M4A1, it's just leftover from CS:S.
	}
	
	int points = Cvars.Weapon[defindex].IntValue;
	
	/* Debug */
	XStats_DebugText(false, "//===== Player_Death_CSGO =====\\"
	... "\nClient: %s (index %i, userid %i)"
	... "\nVictim: %s (index %i, userid %i)"
	... "\nAssist: %s (index %i, userid %i)"
	... "\ndefindex: %i"
	... "\nweapon: %s"
	... "\nmidair: %s"
	... "\nheadshot: %s"
	... "\ndominated: %s"
	... "\nrevenge: %s"
	... "\nnoscope: %s"
	... "\nthrusmoke: %s"
	... "\nattackerblind: %s"
	... "\ngrenadekill: %s"
	... "\nbombkill: %s"
	... "Points %i\n"
	, Player[client].Playername, client, Player[client].UserID
	, Player[victim].Playername, victim, Player[victim].UserID
	, Tklib_IsValidClient(assist) ? Player[assist].Playername : "No assister", assist, Player[assist].UserID
	, defindex
	, weapon
	, Bool[midair]
	, Bool[headshot]
	, Bool[dominated]
	, Bool[revenge]
	, Bool[noscope]
	, Bool[thrusmoke]
	, Bool[attackerblind]
	, Bool[grenadekill]
	, Bool[bombkill]
	, points);
	
	/* Kill msg stuff */
	Player[client].KillMsg.MidAirKill = midair;
	Player[client].KillMsg.SmokeKill = thrusmoke;
	Player[client].KillMsg.HeadshotKill = headshot;
	Player[client].KillMsg.NoscopeKill = noscope;
	Player[client].KillMsg.GrenadeKill = grenadekill;
	Player[client].KillMsg.BombKill = bombkill;
	Player[client].KillMsg.BlindedKill = attackerblind;
	
	PrepareOnDeathForward(client, victim, assist, weapon, defindex);
	AssistedKill(assist, client, victim);
	VictimDied(victim);
	
	char query[1024];
	//int len = 0;
	
	Player[client].Session.Kills++;
	Format(query, sizeof(query), "update `%s` set Kills = Kills+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
	
	Format(query, sizeof(query), "update `%s` set %s = %s+1 where SteamID='%s' and ServerID='%i'",
	Global.weapons, weapon, weapon, Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
	
	if(headshot) {
		Player[client].Session.Headshots++;
		Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Headshot\n");
	}
	
	if(dominated) {
		Player[client].Session.Dominations++;
		Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Dominated\n");
	}
		
	if(revenge)	{
		Player[client].Session.Revenges++;
		Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Revenge\n");
	}
	
	if(noscope) {
		Player[client].Session.Noscopes++;
		Format(query, sizeof(query), "update `%s` set Noscopes = Noscopes+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Noscope\n");
	}
	
	if(thrusmoke) {
		Player[client].Session.SmokeKills++;
		Format(query, sizeof(query), "update `%s` set ThruSmokes = ThruSmokes+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Thru smoke\n");
	}
	
	if(knifekill) {
		Player[client].Session.KnifeKills++;
		Format(query, sizeof(query), "update `%s` set KnifeKills = KnifeKills+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Knife Kill\n");
	}
	
	if(grenadekill) {
		Player[client].Session.GrenadeKills++;
		Format(query, sizeof(query), "update `%s` set GrenadeKills = GrenadeKills+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Grenade kill\n");
	}
	
	if(bombkill) {
		Player[client].Session.BombKills++;
		Format(query, sizeof(query), "update `%s` set BombKills = BombKills+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Bomb kill\n");
	}
	
	if(points > 0) {
		Player[client].Session.AddPoints(points);
		Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s' and ServerID='%i'",
		Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		PrepareKillMessage(client, victim, points);
		
		if(!IsFakeClient(victim)) {
			char log[2048];
			int len = 0;
			len += Format(log[len], sizeof(log)-len, "insert into `%s`", Global.kill_log);
			len += Format(log[len], sizeof(log)-len, "(ServerID, Time, Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, ThruSmoke, BlindedKill)");
			len += Format(log[len], sizeof(log)-len, "values");
			len += Format(log[len], sizeof(log)-len, "('%i', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', '%i', '%i')",
			Cvars.ServerID.IntValue, GetTime(), Player[client].Playername, Player[client].SteamID, Player[victim].Playername, Player[victim].SteamID, Player[assist].Playername, Player[assist].SteamID, weapon, headshot, noscope, thrusmoke, attackerblind);
			SQL.Query(DBQuery_Kill_Log, log);
			
			XStats_DebugText(false, "Inserting (ServerID, Time, Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, ThruSmoke, BlindedKill) values ('%i', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', '%i', '%i') into %s",
			Cvars.ServerID.IntValue, GetTime(), Player[client].Playername, Player[client].SteamID, Player[victim].Playername, Player[victim].SteamID, Player[assist].Playername, Player[assist].SteamID, weapon, headshot, noscope, thrusmoke, attackerblind, Global.kill_log);
		}
	}
}

/* Other Deaths */
stock void Other_Death_CSGO(Event event, const char[] event_name, bool dontBroadcast)	{
	int client = GetClientOfUserId(event.GetInt("attacker"));
	if(!Tklib_IsValidClient(client, true))
		return;
	
	int entity = event.GetInt("otherid");
	if(!IsValidEntity(entity))
		return;
	
	char classname[128], weapon[4][128];
	event.GetString("othertype", classname, sizeof(classname));
	event.GetString("weapon", weapon[0], sizeof(weapon[]));
	event.GetString("weapon_itemid", weapon[1], sizeof(weapon[]));
	event.GetString("weapon_fauxitemid", weapon[2], sizeof(weapon[]));
	event.GetString("weapon_originalowner_xuid", weapon[3], sizeof(weapon[]));
	bool headshot = event.GetBool("headshot");
	int penetrated = event.GetInt("penetrated");
	bool noscope = event.GetBool("noscope");
	bool thrusmoke = event.GetBool("thrusmoke");
	bool attackerblind = event.GetBool("attackerblind");
	
	/* Chicken Kill */
	if(StrEqual(classname, "chicken", false)) Player[client].Session.ChickenKills++;
	
	XStats_DebugText(false, "//===== XStats Debug Log: Other_Death_CSGO =====//");
	XStats_DebugText(false, "Client: %N", client);
	XStats_DebugText(false, "Entity index: %d", entity);
	XStats_DebugText(false, "Entity Classname: \"%s\"\n", classname);
	XStats_DebugText(false, "Weapon: \"%s\"", weapon[0]);
	XStats_DebugText(false, "Weapon ID: \"%s\"", weapon[1]);
	XStats_DebugText(false, "Weapon Faux ID: \"%s\"", weapon[2]);
	XStats_DebugText(false, "Weapon Original Owner xuid: \"%s\"\n", weapon[3]);
	XStats_DebugText(false, "Headshot: %s", Bool[headshot]);
	XStats_DebugText(false, "Penetrated: %i", penetrated);
	XStats_DebugText(false, "Noscope: %s", Bool[noscope]);
	XStats_DebugText(false, "Through Smoke: %s", Bool[thrusmoke]);
	XStats_DebugText(false, "Attacker was blind: %s\n", Bool[attackerblind]);
}