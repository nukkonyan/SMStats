/**
 *	Prepare database.
 */
void PrepareDB_CSGO()	{
	char query[8192];
	int len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `playerlist_csgo`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ServerID`							int(16) not null default '1' comment 'Servers unique ID',");
	len += Format(query[len], sizeof(query)-len, "`Points`								int(32) not null default '1000',");
	len += Format(query[len], sizeof(query)-len, "`LastConnected`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`LastConnectedServerID`				int(32) not null default '1' comment 'Last server id player were on.',");
	len += Format(query[len], sizeof(query)-len, "`PlayTime`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Playername`						varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`SteamID`							varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`IPAddress`						varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Kills`								int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Deaths`								int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Assists`								int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Suicides`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`DamageDone`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Headshots`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`ThruSmokes`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`KnifeKills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscopes`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Dominations`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Revenges`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MoneySpent`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`FlashedOpponents`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`GrenadeKills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`BombsPlanted`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`BombsDefused`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`BombsExploded`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`BombKills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_hegrenade`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_frag`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_flashbang`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_smokegrenade`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_decoygrenade`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_molotov`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_incendiary`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_tagrenade`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_snowball`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_breachcharge`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_c4`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_deagle`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_glock`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ak47`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_aug`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_awp`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_famas`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_g3sg1`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_galilar`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_m249`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_m4a1`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_mac10`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_p90`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_mp5sd`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ump45`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_xm1014`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bizon`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_mag7`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_negev`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sawedoff`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_tec9`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_taser`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_hkp2000`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_mp7`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_mp9`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_nova`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_p250`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scar20`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sg556`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ssg08`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_m4a1_silencer`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_usp_silencer`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_cz75a`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_revolver`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_knife`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_knife_t`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`SteamID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 1);
	
	//Reset for new query.
	query = NULL_STRING;
	len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `kill_log_csgo`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ID`							int(32)			not null auto_increment,");
	len += Format(query[len], sizeof(query)-len, "`Playername`					varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`SteamID`						varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Victim_Playername`			varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Victim_SteamID`				varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Assister_Playername`			varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Assister_SteamID`			varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Timestamp`					timestamp		not null default current_timestamp,");
	len += Format(query[len], sizeof(query)-len, "`Weapon`						varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Headshot`					bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscope`						bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`ThruSmoke`					bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`BlindedKill`					bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`ID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 2);
	
	query = NULL_STRING;
	len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `item_found_csgo`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ID`								int(32) not null auto_increment,");
	len += Format(query[len], sizeof(query)-len, "`ServerID`						int(32) not null default '1',");
	len += Format(query[len], sizeof(query)-len, "`Time`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Playername`					varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`SteamID`						varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`QualityID`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Quality`						varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`MethodID`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Method`						varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`DefinitionIndex`				varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`ItemID`							int(32) not null default '0.0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`ID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 3);
	
	query = NULL_STRING;
	len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `maps_log_csgo`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ServerID`					int(32) not null default '1',");
	len += Format(query[len], sizeof(query)-len, "`MapName`					varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`PlayTime`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Deaths`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Assists`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Suicides`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Headshots`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscopes`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Dominations`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Revenges`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MidAirKills`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`ThruSmokes`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`BlindedKills`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`ServerID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 4);
}

/**
 *	Initialize: Counter-Strike Global Offensive.
 */
void PrepareGame_CSGO()	{
	//Weapon cvars
	Weapon[CSGO_Weapon_Deagle]		= CreateConVar("xstats_points_weapon_deagle",	"5", "XStats: CS:GO - Points given when killing with Deagle.", _, true);
	Weapon[CSGO_Weapon_Glock]		= CreateConVar("xstats_points_weapon_glock",	"5", "XStats: CS:GO - Points given when killing with Glock.", _, true);
	Weapon[CSGO_Weapon_Ak47]		= CreateConVar("xstats_points_weapon_ak47",		"5", "XStats: CS:GO - Points given when killing with Ak47.", _, true);
	Weapon[CSGO_Weapon_Aug]			= CreateConVar("xstats_points_weapon_aug",		"5", "XStats: CS:GO - Points given when killing with Aug.", _, true);
	Weapon[CSGO_Weapon_AWP]			= CreateConVar("xstats_points_weapon_awp",		"5", "XStats: CS:GO - Points given when killing with Awp.", _,true, 0.0);
	Weapon[CSGO_Weapon_Famas]		= CreateConVar("xstats_points_weapon_famas",	"5", "XStats: CS:GO - Points given when killing with Famas.", _, true);
	Weapon[CSGO_Weapon_G3SG1]		= CreateConVar("xstats_points_weapon_g3sg1",	"5", "XStats: CS:GO - Points given when killing with G3sg1.", _, true);
	Weapon[CSGO_Weapon_GalilAR]		= CreateConVar("xstats_points_weapon_galilar",	"5", "XStats: CS:GO - Points given when killing with Galilar.", _, true);
	Weapon[CSGO_Weapon_M249]		= CreateConVar("xstats_points_weapon_m249",		"5", "XStats: CS:GO - Points given when killing with M249.", _, true);
	Weapon[CSGO_Weapon_M4A4]		= CreateConVar("xstats_points_weapon_m4a4",		"5", "XStats: CS:GO - Points given when killing with M4a4.", _, true);
	Weapon[CSGO_Weapon_Mac10]		= CreateConVar("xstats_points_weapon_mac10",	"5", "XStats: CS:GO - Points given when killing with Mac10.", _, true);
	Weapon[CSGO_Weapon_P90]			= CreateConVar("xstats_points_weapon_p90",		"5", "XStats: CS:GO - Points given when killing with P90.", _, true);
	Weapon[CSGO_Weapon_MP5]			= CreateConVar("xstats_points_weapon_mp5",		"5", "XStats: CS:GO - Points given when killing with MP5.", _, true);
	Weapon[CSGO_Weapon_UMP45]		= CreateConVar("xstats_points_weapon_ump45",	"5", "XStats: CS:GO - Points given when killing with UMP45.", _, true);
	Weapon[CSGO_Weapon_XM1014]		= CreateConVar("xstats_points_weapon_xm1014",	"5", "XStats: CS:GO - Points given when killing with XM1014.", _, true);
	Weapon[CSGO_Weapon_Bizon]		= CreateConVar("xstats_points_weapon_bizon",	"5", "XStats: CS:GO - Points given when killing with Bizon.", _, true);
	Weapon[CSGO_Weapon_MAG7]		= CreateConVar("xstats_points_weapon_mag7",		"5", "XStats: CS:GO - Points given when killing with MAG-7", _, true);
	Weapon[CSGO_Weapon_Negev]		= CreateConVar("xstats_points_weapon_negev",	"5", "XStats: CS:GO - Points given when killing with Negev.", _, true);
	Weapon[CSGO_Weapon_SawedOff]	= CreateConVar("xstats_points_weapon_sawedoff",	"5", "XStats: CS:GO - Points given when killing with Sawed-Off.", _, true);
	Weapon[CSGO_Weapon_Tec9]		= CreateConVar("xstats_points_weapon_tec9",		"5", "XStats: CS:GO - Points given when killing with Tec9.", _, true);
	Weapon[CSGO_Weapon_Taser]		= CreateConVar("xstats_points_weapon_taser",	"5", "XStats: CS:GO - Points given when killing with Taser.", _, true);
	Weapon[CSGO_Weapon_P2000]		= CreateConVar("xstats_points_weapon_hkp2000",	"5", "XStats: CS:GO - Points given when killing with P2000.", _, true);
	Weapon[CSGO_Weapon_MP7]			= CreateConVar("xstats_points_weapon_mp7",		"5", "XStats: CS:GO - Points given when killing with MP7.", _, true);
	Weapon[CSGO_Weapon_MP9]			= CreateConVar("xstats_points_weapon_mp9",		"5", "XStats: CS:GO - Points given when killing with MP9.", _, true);
	Weapon[CSGO_Weapon_Nova]		= CreateConVar("xstats_points_weapon_nova",		"5", "XStats: CS:GO - Points given when killing with Nova.", _, true);
	Weapon[CSGO_Weapon_P250]		= CreateConVar("xstats_points_weapon_p250",		"5", "XStats: CS:GO - Points given when killing with P250.", _, true);
	Weapon[CSGO_Weapon_Scar20]		= CreateConVar("xstats_points_weapon_scar20",	"5", "XStats: CS:GO - Points given when killing with Scar-20.", _, true);
	Weapon[CSGO_Weapon_SG556]		= CreateConVar("xstats_points_weapon_sg556",	"5", "XStats: CS:GO - Points given when killing with SG556.", _, true);
	Weapon[CSGO_Weapon_SSG08]		= CreateConVar("xstats_points_weapon_ssg08",	"5", "XStats: CS:GO - Points given when killing with Scout.", _, true);
	Weapon[CSGO_Knife_CT]			= CreateConVar("xstats_points_weapon_knife",	"5", "XStats: CS:GO - Points given when killing with Knife.", _, true);
	Weapon[CSGO_Knife_Gold]			= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Grenade_Flashbang]		= CreateConVar("xstats_points_weapon_flashbang",	"5", "XStats: CS:GO - Points given when killing with Flashbang.", _, true);
	Weapon[CSGO_Grenade_HEGrenade]		= CreateConVar("xstats_points_weapon_hegrenade",	"5", "XStats: CS:GO - Points given when killing with HE Grenade.", _, true);
	Weapon[CSGO_Grenade_SmokeGrenade]	= CreateConVar("xstats_points_weapon_smokegrenade",	"5", "XStats: CS:GO - Points given when killing with Smokegrenade", _, true);
	Weapon[CSGO_Grenade_Molotov]		= CreateConVar("xstats_points_weapon_molotov",		"5", "XStats: CS:GO - Points given when killing with Molotov.", _, true);
	Weapon[CSGO_Grenade_Decoy]			= CreateConVar("xstats_points_weapon_decoy",		"5", "XStats: CS:GO - Points given when killing with Decoy.", _, true);
	Weapon[CSGO_Grenade_Incendiary]		= CreateConVar("xstats_points_weapon_incendiary",	"5", "XStats: CS:GO - Points given when killing with Incendiary.", _, true);
	Weapon[CSGO_Grenade_TAGrenade]		= CreateConVar("xstats_points_weapon_tagrenade",	"5", "XStats: CS:GO - Points given when killing with Tactical Awareness Grenade. (lol)", _, true);
	Weapon[CSGO_Grenade_BreachCharge]	= CreateConVar("xstats_points_weapon_breachcharge",	"5", "XStats: CS:GO - Points given when killing with Breach Charge. (:D)", _, true);
	Weapon[CSGO_Weapon_C4]			= CreateConVar("xstats_points_weapon_c4",		"5", "Xstats: CS:GO - Points given when killing with C4.", _, true);
	Weapon[CSGO_Knife_T]			= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Weapon_M4A1_S]		= CreateConVar("xstats_points_weapon_m4a1_silencer",	"5", "XStats: CS:GO - Points given when killing with M4A1-S.", _, true);
	Weapon[CSGO_Weapon_USP_S]		= CreateConVar("xstats_points_weapon_usp_silencer",		"5", "XStats: CS:GO - Points given when killing with USP-S", _, true);
	Weapon[CSGO_Weapon_CZ75_A]		= CreateConVar("xstats_points_weapon_cz75a",			"5", "XStats: CS:GO - Points given when killing with CZ75-A", _, true);
	Weapon[CSGO_Weapon_Revolver]	= CreateConVar("xstats_points_weapon_revolver",			"5", "XStats: CS:GO - Points given when killing with Revolver.", _, true);
	Weapon[CSGO_Knife_Ghost]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Bayonet]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Classic]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Flip]			= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Gut]			= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Karambit]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_M9_Bayonet]	= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Huntsman]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Falchion]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Bowie]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Butterfly]	= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_ButtPlugs]	= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Paracord]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Survival]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Ursus]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Navaja]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Nomad]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Stiletto]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Talon]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Skeleton]		= Weapon[CSGO_Knife_CT];
	
	/* Events */
	HookEvent(EVENT_PLAYER_DEATH, Player_Death_CSGO, EventHookMode_Pre);
}

stock void Player_Death_CSGO(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats())
		return;

	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	if(!Tklib_IsValidClient(client, true))
		return;

	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(victim))
		return;
	
	if(IsFakeClient(victim) && !AllowBots.BoolValue)
		return;
	
	if(IsSamePlayers(client, victim) || IsSameTeam(client, victim))
		return;
	
	if(IsValidAbuse(client))
		return;
	
	char weapon[64];
	event.GetString(EVENT_STR_WEAPON, weapon, sizeof(weapon));
	if(StrEqual(weapon, "world")
	|| StrEqual(weapon, "player"))
		return; //Since it's not a valid killer, lets end here.
	
	/* Fix the weapon entity prefix */
	Format(weapon, sizeof(weapon), "weapon_%s", weapon);
	
	if(StrEqual(weapon, "weapon_breachcharge_projectile"))
		weapon = "weapon_breachcharge";
	if(StrEqual(weapon, "weapon_planted_c4_survival"))
		weapon = "weapon_c4";
	if(StrEqual(weapon, "weapon_planted_c4"))
		weapon = "weapon_c4";
	
	/* Since 'inferno' applies for Incendiary and Molotov. */
	if(StrEqual(weapon, "weapon_inferno"))	{
		switch(m_hLastFirebombGrenade[client])	{
			case	CSGO_Grenade_Molotov:
				weapon = "weapon_molotov";
			case	CSGO_Grenade_Incendiary:
				weapon = "weapon_incendiary";
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
	|| StrEqual(weapon, "weapon_snowball")
	|| StrEqual(weapon, "weapon_breachcharge")
	|| StrEqual(weapon, "weapon_c4")); /* Not really a grenade but whatever, just for some specific stuff */
	
	int assist = GetClientOfUserId(event.GetInt(EVENT_STR_ASSISTER));
	int defindex = CSGO_GetWeaponDefindex(weapon);
	//int penetrated = event.GetInt(EVENT_STR_PENETRATED);
	bool midair = (!grenadekill && IsClientMidAir(client));
	bool headshot = event.GetBool(EVENT_STR_HEADSHOT);
	bool dominated = event.GetBool(EVENT_STR_DOMINATED);
	bool revenge = event.GetBool(EVENT_STR_REVENGE);
	bool noscope = event.GetBool(EVENT_STR_NOSCOPE);
	bool thrusmoke = event.GetBool(EVENT_STR_THRUSMOKE);
	bool attackerblind = event.GetBool(EVENT_STR_ATTACKERBLIND);
	bool knifekill = (StrContains(weapon, "knife", false) != -1); /* Support custom plugins */
	bool c4kill = (StrContains(weapon, "c4", false) != -1);
	//bool collateral = (penetrated > 0);
	
	if(Weapon[defindex] == null)	{
		PrintToServer("%s weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.", logprefix, weapon, defindex);
		return;
	}
	
	int points = Weapon[defindex].IntValue;
	
	/* Debug */
	if(Debug.BoolValue)	{
		PrintToServer("//===== Player_Death_CSGO =====//");
		PrintToServer("client: %i", client);
		PrintToServer("victim: %i", victim);
		PrintToServer("assist: %i", assist);
		PrintToServer("defindex: %i", defindex);
		PrintToServer("weapon: \"%s\"", weapon);
		PrintToServer(" ");
		PrintToServer("midair: %s", Bool[midair]);
		PrintToServer("headshot: %s", Bool[headshot]);
		PrintToServer("dominated: %s", Bool[dominated]);
		PrintToServer("revenge: %s", Bool[revenge]);
		PrintToServer("noscope: %s", Bool[noscope]);
		PrintToServer("thrusmoke: %s", Bool[thrusmoke]);
		PrintToServer("attackerblind: %s", Bool[attackerblind]);
		PrintToServer("grenadekill: %s", Bool[grenadekill]);
		PrintToServer("c4kill: %s", Bool[c4kill]);
		PrintToServer(" ");
		PrintToServer("Points %i", points);
	}
	
	AssistedKill(assist, client, victim);
	VictimDied(victim);
	
	char query[1024];
	
	Session[client].Kills++;
	Format(query, sizeof(query), "update `%s` set Kills = Kills+1 where SteamID='%s' and ServerID='%i'",
	playerlist, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
	
	Format(query, sizeof(query), "update `%s` set Kills_%s = Kills_%s+1 where SteamID='%s' and ServerID='%i'",
	playerlist, weapon, weapon, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
	
	if(headshot)	{
		Session[client].Headshots++;
		Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	if(dominated)	{
		Session[client].Dominations++;
		Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
		
	if(revenge)	{
		Session[client].Revenges++;
		Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	if(noscope)	{
		Session[client].Noscopes++;
		Format(query, sizeof(query), "update `%s` set Noscopes = Noscopes+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	if(thrusmoke)	{
		Session[client].SmokeKills++;
		Format(query, sizeof(query), "update `%s` set ThruSmokes = ThruSmokes+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	if(knifekill)	{
		Session[client].KnifeKills++;
		Format(query, sizeof(query), "update `%s` set KnifeKills = KnifeKills+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Knife Kill");
		}
	}
	
	if(grenadekill)	{
		Session[client].GrenadeKills++;
		Format(query, sizeof(query), "update `%s` set GrenadeKills = GrenadeKills+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	if(c4kill)	{
		Session[client].BombKills++;
		Format(query, sizeof(query), "update `%s` set BombKills = BombKills+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	if(points > 0)	{
		AddSessionPoints(client, points);
		Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s' and ServerID='%i'",
		playerlist, points, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		int points_client = GetClientPoints(SteamID[client]);
		
		char buffer[256];
		if(midair && noscope && headshot)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "{default}%t {default}%t {default}%t{default}", Kill_Type[2], Kill_Type[0], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "{default}%t {default}%t{default}", Kill_Type[2], Kill_Type[0]);
			}
		}
		else if(midair && noscope)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "{default}%t {default}%t {default}%t{default}", Kill_Type[4], Kill_Type[0], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "{default}%t {default}%t{default}", Kill_Type[4], Kill_Type[0]);
			}
		}
		else if(midair && headshot)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "{default}%t {default}%t {default}%t{default}", Kill_Type[3], Kill_Type[0], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "{default}%t {default}%t{default}", Kill_Type[3], Kill_Type[0]);
			}
		}
		else if(midair)
		{
			Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[0]);
		}
		/*
		else if(collateral)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "{default}%t {default}%t{default}", Kill_Type[10], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "{default}%t{default}", Kill_Type[10]);
			}
		}
		*/
		else if(noscope && headshot)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "{default}%t {default}%t{default}", Kill_Type[2], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "{default}%t{default}", Kill_Type[2]);
			}
		}
		else if(headshot)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "{default}%t {default}%t{default}", Kill_Type[3], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "{default}%t{default}", Kill_Type[3]);
			}
		}
		else if(grenadekill)
		{
			Format(buffer, sizeof(buffer), "{default}%t{default}", Kill_Type[11]);
		}
		else if(c4kill)
		{
			Format(buffer, sizeof(buffer), "{default}%t{default}", Kill_Type[12]);
		}
		
		switch(IsValidString(buffer))	{
			case	true:	CPrintToChat(client, "%s %t", Prefix, "Special Kill Event", Name[client], points_client, points, Name[victim], buffer);
			case	false:	CPrintToChat(client, "%s %t", Prefix, "Default Kill Event", Name[client], points_client, points, Name[victim]);
		}
		
		if(!IsFakeClient(victim))	{
			char log[2048];
			int len = 0;
			len += Format(log[len], sizeof(log)-len, "insert into `%s`", kill_log);
			len += Format(log[len], sizeof(log)-len, "(ServerID, Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, ThruSmoke, BlindedKill)");
			len += Format(log[len], sizeof(log)-len, "values");
			len += Format(log[len], sizeof(log)-len, "('%i', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', '%i', '%i')",
			Playername[client], SteamID[client], Playername[victim], SteamID[victim], Playername[assist], SteamID[assist], weapon, headshot, noscope, thrusmoke, attackerblind);
			db.Query(DBQuery_Kill_Log, log);
		}
	}
}