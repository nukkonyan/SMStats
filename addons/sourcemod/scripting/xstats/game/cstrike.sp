/**
 *	Initialize: Counter-Strike Source.
 */
void PrepareGame_CSS()	{
	//Weapon cvars
	Cvars.Weapon[CSS_Weapon_Deagle]	= CreateConVar("xstats_points_weapon_deagle",	"5", "XStats: CSS - Points given when killing with Deagle.", _, true);
	Cvars.Weapon[CSS_Weapon_Glock]	= CreateConVar("xstats_points_weapon_glock",	"5", "XStats: CSS - Points given when killing with Glock.", _, true);
	Cvars.Weapon[CSS_Weapon_Ak47]	= CreateConVar("xstats_points_weapon_ak47",		"5", "XStats: CSS - Points given when killing with Ak47.", _, true);
	Cvars.Weapon[CSS_Weapon_Aug]	= CreateConVar("xstats_points_weapon_aug",		"5", "XStats: CSS - Points given when killing with Aug.", _, true);
	Cvars.Weapon[CSS_Weapon_AWP]	= CreateConVar("xstats_points_weapon_awp",		"5", "XStats: CSS - Points given when killing with Awp.", _, true);
	Cvars.Weapon[CSS_Weapon_Famas]	= CreateConVar("xstats_points_weapon_famas",	"5", "XStats: CSS - Points given when killing with Famas.", _, true);
	Cvars.Weapon[CSS_Weapon_G3SG1]	= CreateConVar("xstats_points_weapon_g3sg1",	"5", "XStats: CSS - Points given when killing with G3SG1.", _, true);
	Cvars.Weapon[CSS_Weapon_Galil]	= CreateConVar("xstats_points_weapon_galil",	"5", "XStats: CSS - Points given when killing with Galil.", _, true);
	Cvars.Weapon[CSS_Weapon_M249]	= CreateConVar("xstats_points_weapon_m249",		"5", "XStats: CSS - Points given when killing with M249.", _, true);
	Cvars.Weapon[CSS_Weapon_M4A1]	= CreateConVar("xstats_points_weapon_m4a1",		"5", "XStats: CSS - Points given when killing with M4a1.", _, true);
	Cvars.Weapon[CSS_Weapon_Mac10]	= CreateConVar("xstats_points_weapon_mac10",	"5", "XStats: CSS - Points given when killing with Mac10.", _, true);
	Cvars.Weapon[CSS_Weapon_P90]	= CreateConVar("xstats_points_weapon_p90",		"5", "XStats: CSS - Points given when killing with P90.", _, true);
	Cvars.Weapon[CSS_Weapon_MP5]	= CreateConVar("xstats_points_weapon_mp5",		"5", "XStats: CSS - Points given when killing with MP5.", _, true);
	Cvars.Weapon[CSS_Weapon_UMP45]	= CreateConVar("xstats_points_weapon_ump45",	"5", "XStats: CSS - Points given when killing with UMP45.", _, true);
	Cvars.Weapon[CSS_Weapon_XM1014]	= CreateConVar("xstats_points_weapon_xm1014",	"5", "XStats: CSS - Points given when killing with XM1014.", _, true);
	Cvars.Weapon[CSS_Weapon_M3]		= CreateConVar("xstats_points_weapon_m3",		"5", "XStats: CSS - Points given when killing with M3.", _, true);
	Cvars.Weapon[CSS_Weapon_USP]	= CreateConVar("xstats_points_weapon_usp",		"5", "XStats: CSS - Points given when killing with P2000.", _, true);
	Cvars.Weapon[CSS_Weapon_P228]	= CreateConVar("xstats_points_weapon_p250",		"5", "XStats: CSS - Points given when killing with P250.", _, true);
	Cvars.Weapon[CSS_Weapon_SG550]	= CreateConVar("xstats_points_weapon_sg550",	"5", "XStats: CSS - Points given when killing with SG550.", _, true);
	Cvars.Weapon[CSS_Weapon_SG552]	= CreateConVar("xstats_points_weapon_sg552",	"5", "XStats: CSS - Points given when killing with SG552.", _, true);
	Cvars.Weapon[CSS_Weapon_Scout]	= CreateConVar("xstats_points_weapon_scout",	"5", "XStats: CSS - Points given when killing with Scout.", _, true);
	Cvars.Weapon[CSS_Weapon_Knife]	= CreateConVar("xstats_points_weapon_knife",	"5", "XStats: CSS - Points given when killing with Knife.", _, true);
	
	/* Events */
	HookEventEx(EVENT_PLAYER_DEATH, Player_Death_CSS, EventHookMode_Pre);
}

stock void Player_Death_CSS(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats())
		return;
	
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
	if(!Tklib_IsValidClient(client))
		return;
	
	if(IsFakeClient(victim) && !Cvars.AllowBots.BoolValue)
		return;
	
	if(IsSamePlayers(client, victim) || IsSameTeam(client, victim))
		return;
	
	Format(weapon, sizeof(weapon), "weapon_%s", weapon);
	int defindex = CSS_GetWeaponDefindex(weapon);
	
	if(Cvars.Weapon[defindex] == null)	{
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
	int points = Cvars.Weapon[defindex].IntValue;
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
	
	XStats_DebugText(false, "//===== XStats Debug Log: Player_Death_CSS =====//");
	XStats_DebugText(false, "client: %s (index %i, userid %i)", Player[client].Playername, client, Player[client].UserID);
	XStats_DebugText(false, "victim: %s (index %i, userid %i)", Player[victim].Playername, victim, Player[victim].UserID);
	XStats_DebugText(false, "assist: %s (index %i, userid %i)", Tklib_IsValidClient(assist) ? Player[assist].Playername : "no assister", assist, Player[assist].UserID);
	XStats_DebugText(false, "defindex: %i", defindex);
	XStats_DebugText(false, "weapon: \"%s\"\n", weapon);
	XStats_DebugText(false, "midair: %s", Bool[midair]),
	XStats_DebugText(false, "headshot: %s", Bool[headshot]);
	XStats_DebugText(false, "dominated: %s", Bool[dominated]);
	XStats_DebugText(false, "revenge: %s", Bool[revenge]);
	XStats_DebugText(false, "noscope: %s", Bool[noscope]);
	XStats_DebugText(false, "thrusmoke: %s", Bool[thrusmoke]);
	XStats_DebugText(false, "knifekill: %s", Bool[knifekill]);
	XStats_DebugText(false, "grenadekill: %s", Bool[grenadekill]);
	XStats_DebugText(false, "bombkill: %s\n", Bool[bombkill]);
	XStats_DebugText(false, "Points: %i\n", points);
	
	/* Kill msg stuff */
	KillMsg[client].MidAirKill = midair;
	KillMsg[client].SmokeKill = thrusmoke;
	KillMsg[client].HeadshotKill = headshot;
	KillMsg[client].NoscopeKill = noscope;
	KillMsg[client].GrenadeKill = grenadekill;
	KillMsg[client].BombKill = bombkill;
	KillMsg[client].BlindedKill = attackerblind;
	
	PrepareOnDeathForward(client, victim, assist, weapon, defindex);
	AssistedKill(assist, client, victim);
	VictimDied(victim);
	
	char query[1024];
	
	Session[client].Kills++;
	Format(query, sizeof(query), "update `%s` set Kills = Kills+1 where SteamID='%s' and ServerID = '%i'",
	Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	DB.Threaded.Query(DBQuery_Callback, query);
	
	Format(query, sizeof(query), "update `%s` set %s = %s+1 where SteamID='%s' and ServerID = '%i'",
	Global.weapons, weapon, weapon, Player[client].SteamID, Cvars.ServerID.IntValue);
	DB.Threaded.Query(DBQuery_Callback, query);
	
	if(headshot) {
		Session[client].Headshots++;
		Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Headshot\n");
	}
	
	if(dominated) {
		Session[client].Dominations++;
		Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Dominated\n");
	}
	
	if(revenge) {
		Session[client].Revenges++;
		Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Revenge\n");
	}
	
	if(noscope) {
		Session[client].Noscopes++;
		Format(query, sizeof(query), "update `%s` set Noscopes = Noscopes+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Noscope\n");
	}
	
	if(midair) {
		Session[client].MidAirKills++;
		Format(query, sizeof(query), "update `%s` set MidAirKills = MidAirKills+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "MidAir Kill\n");
	}
	
	if(knifekill) {
		Session[client].KnifeKills++;
		Format(query, sizeof(query), "update `%s` set KnifeKills = KnifeKills+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		
		XStats_DebugText(false, "Knife Kill\n");
	}
	
	if(grenadekill) {
		Session[client].GrenadeKills++;
		Format(query, sizeof(query), "update `%s` set GrenadeKills = GrenadeKills+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
	}
	
	if(bombkill) {
		Session[client].BombKills++;
		Format(query, sizeof(query), "update `%s` set BombKills = BombKills+1 where SteamID='%s' and ServerID = '%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
	}
	
	if(points > 0) {
		AddSessionPoints(client, points);
		Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID = '%s' and ServerID = '%i'",
		Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		
		PrepareKillMessage(client, victim, points);
	}
	
	if(!IsFakeClient(victim)) {
		char log[2048];
		int len = 0;
		len += Format(log[len], sizeof(log)-len, "insert into `%s`", Global.kill_log);
		len += Format(log[len], sizeof(log)-len, "(ServerID, Time, Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope)");
		len += Format(log[len], sizeof(log)-len, "values");
		len += Format(log[len], sizeof(log)-len, "('%i', '%i', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i')",
		Cvars.ServerID.IntValue, GetTime(), Player[client].Playername, Player[client].SteamID, Player[victim].Playername, Player[victim].SteamID, Player[assist].Playername, Player[assist].SteamID, weapon, headshot, noscope);
		DB.Threaded.Query(DBQuery_Kill_Log, log);
	}
}