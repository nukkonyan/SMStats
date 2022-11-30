/**
 *	Initialize: Counter-Strike Source.
 */
void PrepareGame_CSS()	{
	//Weapon cvars
	Cvars.CreateCSSWeapon(CSS_Weapon_Deagle, "xstats_points_weapon_deagle",	5, "Deagle");
	Cvars.CreateCSSWeapon(CSS_Weapon_Glock, "xstats_points_weapon_glock", 5, "Glock");
	Cvars.CreateCSSWeapon(CSS_Weapon_Ak47, "xstats_points_weapon_ak47", 5, "Ak47");
	Cvars.CreateCSSWeapon(CSS_Weapon_Aug, "xstats_points_weapon_aug", 5, "AUG");
	Cvars.CreateCSSWeapon(CSS_Weapon_AWP, "xstats_points_weapon_awp", 5, "AWP");
	Cvars.CreateCSSWeapon(CSS_Weapon_Famas, "xstats_points_weapon_famas", 5, "FAMAS");
	Cvars.CreateCSSWeapon(CSS_Weapon_G3SG1, "xstats_points_weapon_g3sg1", 5, "G3SG1");
	Cvars.CreateCSSWeapon(CSS_Weapon_Galil, "xstats_points_weapon_galil", 5, "Galil");
	Cvars.CreateCSSWeapon(CSS_Weapon_M249, "xstats_points_weapon_m249", 5, "M249");
	Cvars.CreateCSSWeapon(CSS_Weapon_M4A1, "xstats_points_weapon_m4a1", 5, "M4A1");
	Cvars.CreateCSSWeapon(CSS_Weapon_Mac10, "xstats_points_weapon_mac10", 5, "MAC10");
	Cvars.CreateCSSWeapon(CSS_Weapon_P90, "xstats_points_weapon_p90", 5, "P90");
	Cvars.CreateCSSWeapon(CSS_Weapon_MP5, "xstats_points_weapon_mp5", 5, "MP5");
	Cvars.CreateCSSWeapon(CSS_Weapon_UMP45, "xstats_points_weapon_ump45", 5, "UMP45");
	Cvars.CreateCSSWeapon(CSS_Weapon_XM1014, "xstats_points_weapon_xm1014", 5, "XM1014");
	Cvars.CreateCSSWeapon(CSS_Weapon_M3, "xstats_points_weapon_m3", 5, "M3");
	Cvars.CreateCSSWeapon(CSS_Weapon_USP, "xstats_points_weapon_usp", 5, "P2000");
	Cvars.CreateCSSWeapon(CSS_Weapon_P228, "xstats_points_weapon_p250", 5, "P250");
	Cvars.CreateCSSWeapon(CSS_Weapon_SG550, "xstats_points_weapon_sg550", 5, "SG550");
	Cvars.CreateCSSWeapon(CSS_Weapon_SG552, "xstats_points_weapon_sg552", 5, "SG552");
	Cvars.CreateCSSWeapon(CSS_Weapon_Scout, "xstats_points_weapon_scout", 5, "Scout");
	Cvars.CreateCSSWeapon(CSS_Weapon_Knife, "xstats_points_weapon_knife", 5, "Knife");
	
	/* Events */
	HookEventEx(EVENT_PLAYER_DEATH, Player_Death_CSS, EventHookMode_Pre);
}

stock void Player_Death_CSS(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats()) return;
	
	char weapon[64];
	event.GetString(EVENT_STR_WEAPON, weapon, sizeof(weapon));
	
	if(StrEqual(weapon, "player")
	|| StrEqual(weapon, "world")) {
		XStats_DebugText(false, "//===== XStats Debug Log: Player_Death_CSS =====//");
		XStats_DebugText(false, "Detected invalid killer \"%s\", ignoring to prevent issues..\n", weapon);
		return;	
	}
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	if(!Tklib_IsValidClient(client, true))
		return;
	
	if(IsValidAbuse(client))
		return;

	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(client)) return;
	if(IsFakeClient(victim) && !Cvars.AllowBots.BoolValue) return;
	if(IsSamePlayers(client, victim) || IsSameTeam(client, victim)) return;
	
	Format(weapon, sizeof(weapon), "weapon_%s", weapon);
	int defindex = CSS_GetWeaponDefindex(weapon);
	
	ConVar cvar = Cvars.GetWeaponCvar(defindex);
	if(!cvar) {
		XStats_DebugText(false, "weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.", weapon, defindex);
		return;
	}
	
	if(StrEqual(weapon, "weapon_knife", false)) {
		char clsname[][] = {"","","weapon_knife_t","weapon_knife_ct"};
		strcopy(weapon, sizeof(weapon), clsname[CS_GetClientTeam(client)]);
		//Make the knife to its respected team. T player with default knife -> weapon_knife_t. ct player with default knife -> weapon_knife_ct.
	}
	
	/* Make sure the midair is unchecked for grenade kills. */
	bool grenadekill = (StrEqual(weapon, "weapon_flashbang")
	|| StrEqual(weapon, "weapon_smokegrenade")
	|| StrEqual(weapon, "weapon_hegrenade"));
	
	int assist = GetClientOfUserId(GetLatestAssister(victim, client));
	event.SetInt("assister", assist);
	int points = cvar.IntValue;
	bool midair = IsClientMidAir(client);
	bool headshot = event.GetBool(EVENT_STR_HEADSHOT);
	bool dominated = event.GetBool(EVENT_STR_DOMINATED);
	bool revenge = event.GetBool(EVENT_STR_REVENGE);
	bool noscope = ((StrEqual(weapon, "weapon_sg550")
	|| StrEqual(weapon, "weapon_g3sg1")
	|| StrEqual(weapon, "weapon_scout")
	|| StrEqual(weapon, "weapon_awp")) && !CS_IsWeaponZoomedIn(GetClientActiveWeapon(client)));
	event.SetBool("noscope", noscope);
	bool thrusmoke = CS_IsClientInsideSmoke(victim);
	event.SetBool("thrusmoke", thrusmoke);
	bool attackerblind = m_bIsFlashed[client];
	event.SetBool("attackerblind", attackerblind);
	bool knifekill = (StrContains(weapon, "knife", false) != -1); /* Support custom plugins */
	bool bombkill = (StrContains(weapon, "c4", false) != -1);
	
	XStats_DebugText(false, "//===== XStats Debug Log: Player_Death_CSS =====//"
	... "\nClient: %s (index %i, userid %i)"
	... "\nVictim: %s (index %i, userid %i)"
	... "\nAssist: %s (index %i, userid %i)"
	... "\ndefindex: %i"
	... "\nweapon: \"%s\"\n"
	... "\nmidair: %s"
	... "\nheadshot: %s"
	... "\ndominated: %s"
	... "\nrevenge: %s"
	... "\nnoscope: %s"
	... "\nthrusmoke: %s"
	... "\nknifekill: %s"
	... "\ngrenadekill: %s"
	... "\nbombkill: %s\n"
	... "\nPoints: %i\n"
	, Player[client].Playername, client, Player[client].UserID
	, Player[victim].Playername, victim, Player[victim].UserID
	, Tklib_IsValidClient(assist) ? Player[assist].Playername : "no assister", assist, Player[assist].UserID
	, defindex
	, weapon
	, Bool[midair]
	, Bool[headshot]
	, Bool[dominated]
	, Bool[revenge]
	, Bool[noscope]
	, Bool[thrusmoke]
	, Bool[knifekill]
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
	
	Player[client].Session.Kills++;
	Format(query, sizeof(query), "update `%s` set Kills = Kills+1 where SteamID='%s' and ServerID = '%i'",
	Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
	
	Format(query, sizeof(query), "update `%s` set %s = %s+1 where SteamID='%s' and ServerID = '%i'",
	Global.weapons, weapon, weapon, Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
	
	if(headshot) {
		Player[client].Session.Headshots++;
		Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Headshot\n");
	}
	
	if(dominated) {
		Player[client].Session.Dominations++;
		Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Dominated\n");
	}
	
	if(revenge) {
		Player[client].Session.Revenges++;
		Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Revenge\n");
	}
	
	if(noscope) {
		Player[client].Session.Noscopes++;
		Format(query, sizeof(query), "update `%s` set Noscopes = Noscopes+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Noscope\n");
	}
	
	if(midair) {
		Player[client].Session.MidAirKills++;
		Format(query, sizeof(query), "update `%s` set MidAirKills = MidAirKills+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "MidAir Kill\n");
	}
	
	if(knifekill) {
		Player[client].Session.KnifeKills++;
		Format(query, sizeof(query), "update `%s` set KnifeKills = KnifeKills+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Knife Kill\n");
	}
	
	if(grenadekill) {
		Player[client].Session.GrenadeKills++;
		Format(query, sizeof(query), "update `%s` set GrenadeKills = GrenadeKills+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
	}
	
	if(bombkill) {
		Player[client].Session.BombKills++;
		Format(query, sizeof(query), "update `%s` set BombKills = BombKills+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
	}
	
	if(points > 0) {
		Player[client].Session.AddPoints(points);
		Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID = '%s' and ServerID = '%i'",
		Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		//PrepareKillMessage(client, victim, points); Will be updated very soon.
	}
	
	if(!IsFakeClient(victim)) {
		char log[2048];
		int len = 0;
		len += Format(log[len], sizeof(log)-len, "insert into `%s`", Global.kill_log);
		len += Format(log[len], sizeof(log)-len, "(ServerID, Time, Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope)");
		len += Format(log[len], sizeof(log)-len, "values");
		len += Format(log[len], sizeof(log)-len, "('%i', '%i', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i')",
		Cvars.ServerID.IntValue, GetTime(), Player[client].Playername, Player[client].SteamID, Player[victim].Playername, Player[victim].SteamID, Player[assist].Playername, Player[assist].SteamID, weapon, headshot, noscope);
		SQL.Query(DBQuery_Kill_Log, log);
	}
}