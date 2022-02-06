/**
 *	Prepare database.
 */
void PrepareDB_TF2()	{
	char query[16177];
	int len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `playerlist_tf2`");
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
	len += Format(query[len], sizeof(query)-len, "`ScoutsKilled`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SoldiersKilled`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PyrosKilled`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`DemosKilled`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`HeaviesKilled`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`EngiesKilled`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MedicsKilled`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SnipersKilled`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SpiesKilled`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`DeflectKills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`GibKills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`CritKills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TauntKills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`CollatKills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MidAirKills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Headshots`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Backstabs`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscopes`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Dominations`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Revenges`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TeleFrags`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MiniSentryKills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryKills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryLVL1Kills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryLVL2Kills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryLVL3Kills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalBuildingsBuilt`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MiniSentryGunsBuilt`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryGunsBuilt`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`DispensersBuilt`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TeleporterExitsBuilt`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TeleporterEntrancesBuilt`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SappersPlaced`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalBuildingsDestroyed`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MiniSentryGunsDestroyed`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryGunDestroyed`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`DispenserDestroyed`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SappersDestroyed`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PointsCaptured`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PointsDefended`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`FlagsPickedUp`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`FlagsCaptured`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`FlagsStolen`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`FlagsDefended`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Ubercharged`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SandvichesStolen`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PlayerTeleported`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalPlayersTeleported`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`StunnedPlayers`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MoonShotStunnedPlayers`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalMonoculusStunned`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalMonoculusKilled`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalMerasmusStunned`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalMerasmusKilled`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalKilledHHH`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsGotten`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsScored`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsDropped`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsCatched`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsStolen`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsBlocked`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Coated`								int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Jarated`								int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MadMilked`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Extinguished`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TanksDestroyed`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryBustersKilled`					int(32) not null default '0',");
	/* Will add more mvm events later here */
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bat`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bottle`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_fireaxe`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_kukri`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_knife`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_fists`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_shovel`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_wrench`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bonesaw`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_shotgun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scattergun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sniperrifle`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_minigun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_smg`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_syringegun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_rocketlauncher`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_grenadelauncher`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_stickybomblauncher`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_flamethrower`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_pistol`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_revolver`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_blutsauger`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ubersaw`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_axtinguisher`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_flaregun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_backburner`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_natascha`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_kgob`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sandman`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_forceanature`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_huntsman`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ambassador`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_directhit`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_equalizer`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scottishresistance`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_chargentarge`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_eyelander`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_wrangler`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_frontierjustice`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_gunslinger`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_homewrecker`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_paintrain`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_southernhospitality`	int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bigkill`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_goldenwrench`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_tribalmansshiv`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scotmansskullcutter`	int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_vitasaw`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_powerjack`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_degreaser`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_shortstop`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_holymackerel`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_letranger`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_eternalreward`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_blackbox`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sydneysleeper`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bushwacka`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_goru`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_fryingpan`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_hhhh`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_lugermorph`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ironcurtain`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_amputator`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_crusaderscrossbow`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ullapoolcaber`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_lochnload`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_warriorsspirit`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_brassbeast`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_candycane`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bostonbasher`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_backscratcher`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_claidheamhmor`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_jag`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_fistsofsteel`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sharpenedvolcanofragment`	int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sunonastick`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_detonator`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_fanowar`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_conniverskunai`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_halfzatoichi`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_shahanshah`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bazaarbargain`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_persainpersuader`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_splendidscreen`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_overdose`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_solemnvow`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_libertylauncher`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_reserveshooter`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_marketgardener`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_saxxy`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_tomislav`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_familybusiness`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_evictionnotice`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_cowmangler5000`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_righteousbison`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_mantreads`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_disciplinaryaction`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sodapopper`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_winger`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_atomizer`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_threeruneblade`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_postalpummeler`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_enforcer`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bigearner`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_maul`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_conscentiousobjector`	int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_nessiesnineiron`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_original`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_diamondback`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_machina`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_widowmaker`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_shortcircuit`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_unarmedcombat`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_wangaprick`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_apocofists`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_pomson6000`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_eurekaeffect`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_thirddegree`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_phlogistinator`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_manmelter`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scottishhandshake`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sharpdresser`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_wrapassassin`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_spycicle`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_holidaypunch`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_blackrose`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_lollipop`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scorchshot`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_rainblower`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_cleanerscarbine`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_hitmansheatmaker`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_babyfacesblaster`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_prettyboyspocketpistol`	int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_escapeplan`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_huolongheater`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_flyingguillotine`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_neonannihilator`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_awperhand`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_freedomstaff`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_batouttahell`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_memorymaker`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_hamshank`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_goldenfryingpan`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_fortifiedcompound`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_classic`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_tideturner`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_breadbite`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_backscatter`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_airstrike`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_necrosmasher`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_crossingguard`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_quickiebomblauncher`	int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ironbomber`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_panicattack`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_dragonsfury`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_thermalthruster`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_hothand`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_nostromonapalmer`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_shootingstar`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_capper`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_batsaber`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_gigarcounter`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_prinnymachete`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`SteamID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 1);
	
	//Reset for new query.
	query = NULL_STRING;
	len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `kill_log_tf2`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ID`							int(32)			not null auto_increment,");
	len += Format(query[len], sizeof(query)-len, "`ServerID`					int(16)			not null default '0' comment 'Servers unique ID',");
	len += Format(query[len], sizeof(query)-len, "`Time`						int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Playername`					varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`SteamID`						varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Victim_Playername`			varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Victim_SteamID`				varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Assister_Playername`			varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Assister_SteamID`			varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Weapon`						varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Headshot`					bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscope`						bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Collateral`					bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MidAir`						bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`CritType`					int(2)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`ID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 2);
	
	query = NULL_STRING;
	len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `item_found_tf2`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ID`							int(32)			not null auto_increment,");
	len += Format(query[len], sizeof(query)-len, "`ServerID`					int(32)			not null default '1',");
	len += Format(query[len], sizeof(query)-len, "`Time`						int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Playername`					varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`SteamID`						varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`QualityID`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Quality`						varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`MethodID`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Method`						varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`DefinitionIndex`				int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Wear`						float			not null default '0.0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`ID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 3);
	
	query = NULL_STRING;
	len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `maps_log_tf2`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ServerID`						int(32) not null default '1',");
	len += Format(query[len], sizeof(query)-len, "`MapName`						varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`PlayTime`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Deaths`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Assists`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Suicides`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Headshots`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Backstabs`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MidAirKills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`GibKills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`CritKills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TauntKills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscopes`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Dominations`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Revenges`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TeleFrags`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MiniSentryKills`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryKills`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryLVL1Kills`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryLVL2Kills`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryLVL3Kills`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalBuildingsBuilt`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MiniSentryGunsBuilt`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryGunsBuilt`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`DispensersBuilt`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TeleporterExitsBuilt`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TeleporterEntrancesBuilt`		int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SappersPlaced`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalBuildingsDestroyed`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MiniSentryGunsDestroyed`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryGunDestroyed`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`DispenserDestroyed`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SappersDestroyed`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PointsCaptured`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PointsDefended`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`FlagsPickedUp`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`FlagsCaptured`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`FlagsStolen`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`FlagsDefended`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Ubercharged`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SandvichesStolen`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PlayerTeleported`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalPlayersTeleported`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`StunnedPlayers`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MoonShotStunnedPlayers`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalMonoculusStunned`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalMonoculusKilled`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalMerasmusStunned`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalMerasmusKilled`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TotalKilledHHH`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsGotten`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsScored`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsDropped`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsCatched`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsStolen`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`PassBallsBlocked`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Coated`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Jarated`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MadMilked`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Extinguished`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`ServerID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 4);
}

/**
 *	Functions
 */
ConVar TF2_MvM[25];

/**
 * 	Other.
 */
ConVar TF2_Collat;

/**
 *	Initialize: Team Fortress 2.
 */
void PrepareGame_TF2()	{
	//Weapon cvars
	Weapon[0]	= CreateConVar("xstats_points_weapon_bat",					"10",	"Xstats: TF2 - Points given when killing with Bat.", _, true);
	Weapon[1]	= CreateConVar("xstats_points_weapon_bottle",				"10",	"Xstats: TF2 - Points given when killing with Bottle.", _, true);
	Weapon[2]	= CreateConVar("xstats_points_weapon_fireaxe",				"10",	"Xstats: TF2 - Points given when killing with Fire Axe.", _, true);
	Weapon[3]	= CreateConVar("xstats_points_weapon_kukri",				"10",	"Xstats: TF2 - Points given when killing with Kukri.", _, true);
	Weapon[4]	= CreateConVar("xstats_points_weapon_knife",				"10",	"Xstats: TF2 - Points given when killing with Knife.", _, true);
	Weapon[5]	= CreateConVar("xstats_points_weapon_fists",				"10",	"Xstats: TF2 - Points given when killing with Fists", _, true);
	Weapon[6]	= CreateConVar("xstats_points_weapon_shovel",				"10",	"Xstats: TF2 - Points given when killing with Shovel.", _, true);
	Weapon[7]	= CreateConVar("xstats_points_weapon_wrench",				"10",	"Xstats: TF2 - Points given when killing with Wrench.", _, true);
	Weapon[8]	= CreateConVar("xstats_points_weapon_bonesaw",				"10",	"Xstats: TF2 - Points given when killing with Bonesaw.", _, true);
	Weapon[9]	= CreateConVar("xstats_points_weapon_shotgun",				"10",	"Xstats: TF2 - Points given when killing with Shotgun.", _, true);
	Weapon[10]	= Weapon[9];	//Same Shotgun, different TFClass type.
	Weapon[11]	= Weapon[9];	//Same Shotgun, different TFClass type.
	Weapon[12]	= Weapon[9];	//Same Shotgun, different TFClass type.
	Weapon[13]	= CreateConVar("xstats_points_weapon_scattergun",			"10",	"Xstats: TF2 - Points given when killing with Scattergun.", _, true);
	Weapon[14]	= CreateConVar("xstats_points_weapon_sniperrifle",			"10",	"Xstats: TF2 - Points given when killing with Sniper Rifle.", _, true);
	Weapon[15]	= CreateConVar("xstats_points_weapon_minigun",				"10",	"Xstats: TF2 - Points given when killing with Minigun.", _, true);
	Weapon[16]	= CreateConVar("xstats_points_weapon_smg",					"10",	"Xstats: TF2 - Points given when killing with SMG.", _, true);
	Weapon[17]	= CreateConVar("xstats_points_weapon_syringegun",			"10",	"Xstats: TF2 - Points given when killing with Syringe Gun.", _, true);
	Weapon[18]	= CreateConVar("xstats_points_weapon_rocketlauncher",		"10",	"Xstats: TF2 - Points given when killing with Rocket Launcher.", _, true);
	Weapon[19]	= CreateConVar("xstats_points_weapon_grenadelauncher",		"10",	"Xstats: TF2 - Points given when killing with Grenade Launcher.", _, true);
	Weapon[20]	= CreateConVar("xstats_points_weapon_stickybomblauncher",	"10",	"Xstats: TF2 - Points given when killing with StickyBomb Launcher", _, true);
	Weapon[21]	= CreateConVar("xstats_points_weapon_flamethrower",			"10",	"Xstats: TF2 - Points given when killing with Flamethrower.", _, true);
	Weapon[22]	= CreateConVar("xstats_points_weapon_pistol",				"10",	"Xstats: TF2 - Points given when killing with Pistol.", _, true);
	Weapon[23]	= Weapon[22];	//Same Pistol, different TFClass type.
	Weapon[24]	= CreateConVar("xstats_points_weapon_revolver",				"10",	"Xstats: TF2 - Points given when killing with Revolver.", _, true);
	Weapon[36]	= CreateConVar("xstats_points_weapon_blutsauger",			"10",	"Xstats: TF2 - Points given when killing with Blutsauger.", _, true);
	Weapon[37]	= CreateConVar("xstats_points_weapon_ubersaw",				"10",	"Xstats: TF2 - Points given when killing with Ubersaw.", _, true);
	Weapon[38]	= CreateConVar("xstats_points_weapon_axtinguisher",			"10",	"Xstats: TF2 - Points given when killing with Axtinguisher.", _, true);
	Weapon[39]	= CreateConVar("xstats_points_weapon_flaregun",				"10",	"Xstats: TF2 - Points given when killing with Flaregun.", _, true);
	Weapon[40]	= CreateConVar("xstats_points_weapon_backburner",			"10",	"Xstats: TF2 - Points given when killing with Backburner.", _, true);
	Weapon[41]	= CreateConVar("xstats_points_weapon_natascha",				"10",	"Xstats: TF2 - Points given when killing with Natascha.", _, true);
	Weapon[43]	= CreateConVar("xstats_points_weapon_killerglovesofboxing",	"10",	"Xstats: TF2 - Points given when killing with Killer Gloves Of Boxing", _, true);
	Weapon[44]	= CreateConVar("xstats_points_weapon_sandman",				"10",	"Xstats: TF2 - Points given when killing with Sandman.", _, true);
	Weapon[45]	= CreateConVar("xstats_points_weapon_forceanature",			"10",	"Xstats: TF2 - Points given when killing with Force-A-Nature", _, true);
	Weapon[56]	= CreateConVar("xstats_points_weapon_huntsman",				"10",	"Xstats: TF2 - Points given when killing with Huntsman.", _, true);
	Weapon[61]	= CreateConVar("xstats_points_weapon_ambassador",			"10",	"Xstats: TF2 - Points given when killing with Ambassador.", _, true);
	Weapon[127]	= CreateConVar("xstats_points_weapon_directhit",			"10",	"Xstats: TF2 - Points given when killing with Direct-Hit.", _, true);
	Weapon[128]	= CreateConVar("xstats_points_weapon_equalizer",			"10",	"Xstats: TF2 - Points given when killing with Equalizer.", _, true);
	Weapon[130]	= CreateConVar("xstats_points_weapon_scottishresistance",	"10",	"Xstats: TF2 - Points given when killing with Scottish Resistance.", _, true);
	Weapon[131]	= CreateConVar("xstats_points_weapon_chargentarge",			"10",	"Xstats: TF2 - Points given when killing with Charge n' Targe", _, true);
	Weapon[132]	= CreateConVar("xstats_points_weapon_eyelander",			"10",	"Xstats: TF2 - Points given when killing with Eyelander.", _, true);
	Weapon[140]	= CreateConVar("xstats_points_weapon_wrangler",				"10",	"Xstats: TF2 - Points given when killing with Wrangler.", _, true);
	Weapon[141]	= CreateConVar("xstats_points_weapon_frontierjustice",		"10",	"Xstats: TF2 - Points given when killing with Frontier Justice.", _, true);
	Weapon[142]	= CreateConVar("xstats_points_weapon_gunslinger",			"10",	"Xstats: TF2 - Points given when killing with gunslinger.", _, true);
	Weapon[153]	= CreateConVar("xstats_points_weapon_homewrecker",			"10",	"Xstats: TF2 - Points given when killing with homewrecker.", _, true);
	Weapon[154]	= CreateConVar("xstats_points_weapon_paintrain",			"10",	"Xstats: TF2 - Points given when killing with pain train.", _, true);
	Weapon[155]	= CreateConVar("xstats_points_weapon_southernhospitality",	"10",	"Xstats: TF2 - Points given when killing with southern hospitality.", _, true);
	Weapon[160]	= CreateConVar("xstats_points_weapon_lugermorph",			"10",	"Xstats: TF2 - Points given when killing with lugermorph", _, true);
	Weapon[161]	= CreateConVar("xstats_points_weapon_bigkill",				"10",	"Xstats: TF2 - Points given when killing with big kill.", _, true);
	Weapon[169]	= CreateConVar("xstats_points_weapon_wrench",				"10",	"Xstats: TF2 - Points given when killing with wrench.", _, true);
	Weapon[171]	= CreateConVar("xstats_points_weapon_tribalmansshiv",		"10",	"Xstats: TF2 - Points given when killing with tribalman's shiv.", _, true);
	Weapon[172]	= CreateConVar("xstats_points_weapon_scotsmansskullcutter","10",	"Xstats: TF2 - Points given when killing with scotsman's skullcutter.", _, true);
	Weapon[173]	= CreateConVar("xstats_points_weapon_vitasaw",				"10",	"Xstats: TF2 - Points given when killing with vita saw.", _, true);
	Weapon[190]	= Weapon[0];	//Same as default Bat, used for strange, renamed & skinned versions.
	Weapon[191]	= Weapon[1];	//Same as default Bottle, used for strange, renamed & skinned versions.
	Weapon[192]	= Weapon[2];	//Same as default Fire Axe, used for strange, renamed & skinned versions.
	Weapon[193]	= Weapon[3];	//Same as default Kukri, used for strange, renamed & skinned versions.
	Weapon[194]	= Weapon[4];	//Same as default Knife, used for australium, strange, renamed & skinned versions.
	Weapon[195]	= Weapon[5];	//Same as default Fists, used for strange & renamed version.
	Weapon[196]	= Weapon[6];	//Same as default Shovel, used for strange, renamed & skinned versions.
	Weapon[197]	= Weapon[7];	//Same as default Wrench, used for australium, strange, renamed & skinned versions.
	Weapon[198]	= Weapon[8];	//Same as default Bonesaw, used for strange, renamed & skinned versions.
	Weapon[199]	= Weapon[9];	//Same as default Shotgun, used for strange, renamed & skinned versions.
	Weapon[200]	= Weapon[13];	//Same as default Scattergun, used for australium, strange, renamed & skinned versions.
	Weapon[201]	= Weapon[14];	//Same as default Sniper Rifle, used for australium, strange, renamed & skinned versions.
	Weapon[202]	= Weapon[15];	//Same as default Minigun, used for australium, strange, renamed & skinned versions.
	Weapon[203]	= Weapon[16];	//Same as default SMG, used for australium, strange, renamed & skinned versions.
	Weapon[204]	= Weapon[17];	//Same as default Syringe gun, used for strange, renamed & skinned versions.
	Weapon[205]	= Weapon[18];	//Same as default Rocket Launcher, used for australium, strange, renamed & skinned versions.
	Weapon[206]	= Weapon[19];	//Same as default Grenade Launcher, used for australium, strange, renamed & skinned versions.
	Weapon[207]	= Weapon[20];	//Same as default Stickybomb Launcher, used for australium, strange, renamed & skinned versions.
	Weapon[208]	= Weapon[21];	//Same as default Flamethrower, used for australium, strange, renamed & skinned versions.
	Weapon[209]	= Weapon[22];	//Same as default Pistol, used for strange, renamed & skinned versions.
	Weapon[210]	= Weapon[24];	//Same as default Revolver, used for strange, renamed & skinned versions.
	Weapon[214]	= CreateConVar("xstats_points_weapon_powerjack",			"10",	"Xstats: TF2 - Points given when killing with Power Jack.", _, true);
	Weapon[215]	= CreateConVar("xstats_points_weapon_degreaser",			"10",	"Xstats: TF2 - Points given when killing with Degreaser.", _, true);
	Weapon[220]	= CreateConVar("xstats_points_weapon_shortstop",			"10",	"Xstats: TF2 - Points given when killing with Shortstop", _, true);
	Weapon[221]	= CreateConVar("xstats_points_weapon_holymackerel",			"10",	"Xstats: TF2 - Points given when killing with Holy Mackerel.", _, true);
	Weapon[224]	= CreateConVar("xstats_points_weapon_letranger",			"10",	"Xstats: TF2 - Points given when killing with L'etranger.", _, true);
	Weapon[225]	= CreateConVar("xstats_points_weapon_eternalreward",		"10",	"Xstats: TF2 - Points given when killing with Eternal Reward.", _, true);
	Weapon[228]	= CreateConVar("xstats_points_weapon_blackbox",				"10",	"Xstats: TF2 - Points given when killing with Black Box.", _, true);
	Weapon[230]	= CreateConVar("xstats_points_weapon_sydneysleeper",		"10",	"Xstats: TF2 - Points given when killing with Sydney Sleeper.", _, true);
	Weapon[232]	= CreateConVar("xstats_points_weapon_bushwacka",			"10",	"Xstats: TF2 - Points given when killing with Bushwacka.", _, true);
	Weapon[237]	= Weapon[18];	//Rocket Jumper.
	Weapon[239]	= CreateConVar("xstats_points_weapon_goru",					"10",	"Xstats: TF2 - Points given when killing with Gloves of Running Urgently.", _, true);
	Weapon[264]	= CreateConVar("xstats_points_weapon_fryingpan",			"10",	"Xstats: TF2 - Points given when killing with Frying Pan.", _, true);
	Weapon[265]	= Weapon[20];	//Sticky Jumper.
	Weapon[266]	= CreateConVar("xstats_points_weapon_hhhh",					"10",	"Xstats: TF2 - Points given when killing with Horseless Headless Horsemann's Headtaker", _, true);
	Weapon[294]	= Weapon[160];	//Same Lugermorph, different TFClass type.
	Weapon[298]	= CreateConVar("xstats_points_weapon_ironcurtain",			"10",	"Xstats: TF2 - Points given when killing with Iron Curtain.", _, true);
	Weapon[304]	= CreateConVar("xstats_points_weapon_amputator",			"10",	"Xstats: TF2 - Points given when killing with Amputator.", _, true);
	Weapon[305]	= CreateConVar("xstats_points_weapon_crusaderscrossbow",	"10",	"Xstats: TF2 - Points given when killing with Crusader's Crossbow.", _, true);
	Weapon[307]	= CreateConVar("xstats_points_weapon_ullapoolcaber",		"10",	"Xstats: TF2 - Points given when killing with Ullapool Caber.", _, true);
	Weapon[308]	= CreateConVar("xstats_points_weapon_lochnload",			"10",	"Xstats: TF2 - Points given when killing with Loch-n-Load.", _, true);
	Weapon[310]	= CreateConVar("xstats_points_weapon_warriorsspirit",		"10",	"Xstats: TF2 - Points given when killing with Warrior's Spirit.", _, true);
	Weapon[312]	= CreateConVar("xstats_points_weapon_brassbeast",			"10",	"Xstats: TF2 - Points given when killing with Brass Beast.", _, true);
	Weapon[317]	= CreateConVar("xstats_points_weapon_candycane",			"10",	"Xstats: TF2 - Points given when killing with Candy Cane.", _, true);
	Weapon[325]	= CreateConVar("xstats_points_weapon_bostonbasher",			"10",	"Xstats: TF2 - Points given when killing with Boston Basher.", _, true);
	Weapon[326]	= CreateConVar("xstats_points_weapon_backscratcher",		"10",	"Xstats: TF2 - Points given when killing with Back Scratcher.", _, true);
	Weapon[327]	= CreateConVar("xstats_points_weapon_claidheamhmor",		"10",	"Xstats: TF2 - Points given when killing with Claidheamh Mór.", _, true);
	Weapon[329]	= CreateConVar("xstats_points_weapon_jag",					"10",	"Xstats: TF2 - Points given when killing with Jag.", _, true);
	Weapon[331]	= CreateConVar("xstats_points_weapon_fistsofsteel",			"10",	"Xstats: TF2 - Points given when killing with Fists Of Steel.", _, true);
	Weapon[348]	= CreateConVar("xstats_points_weapon_sharpenedvolcanofragment","10","Xstats: TF2 - Points given when killing with Sharpened Volcano Fragment.", _, true);
	Weapon[349]	= CreateConVar("xstats_points_weapon_sunonastick",			"10",	"Xstats: TF2 - Points given when killing with Sun-On-A-Stick.", _, true);
	Weapon[351]	= CreateConVar("xstats_points_weapon_detonator",			"10",	"Xstats: TF2 - Points given when killing with Detonator.", _, true);
	Weapon[355]	= CreateConVar("xstats_points_weapon_fanowar",				"10",	"Xstats: TF2 - Points given when killing with Fan O' War.", _, true);
	Weapon[356]	= CreateConVar("xstats_points_weapon_conniverskunai",		"10",	"Xstats: TF2 - Points given when killing with Conniver's Kunai.", _, true);
	Weapon[357]	= CreateConVar("xstats_points_weapon_halfzatoichi",			"10",	"Xstats: TF2 - Points given when killing with Half-Zatoichi.", _, true);
	Weapon[401]	= CreateConVar("xstats_points_weapon_shahanshah",			"10",	"Xstats: TF2 - Points given when killing with Shahanshah.", _, true);
	Weapon[402]	= CreateConVar("xstats_points_weapon_bazaarbargain",		"10",	"Xstats: TF2 - Points given when killing with Bazaar Bargain.", _, true);
	Weapon[404]	= CreateConVar("xstats_points_weapon_persainpersuader",		"10",	"Xstats: TF2 - Points given when killing with Persain Pursuader.", _, true);
	Weapon[406]	= CreateConVar("xstats_points_weapon_splendidscreen",		"10",	"Xstats: TF2 - Points given when killing with Splendid Screen.", _, true);
	Weapon[412]	= CreateConVar("xstats_points_weapon_overdose",				"10",	"Xstats: TF2 - Points given when killing with Overdose.", _, true);
	Weapon[413]	= CreateConVar("xstats_points_weapon_solemnvow",			"10",	"Xstats: TF2 - Points given when killing with Solmen Wov.", _, true);
	Weapon[414]	= CreateConVar("xstats_points_weapon_libertylauncher",		"10",	"Xstats: TF2 - Points given when killing with Liberty Launcher.", _, true);
	Weapon[415]	= CreateConVar("xstats_points_weapon_reserveshooter",		"10",	"Xstats: TF2 - Points given when killing with Reserve Shooter.", _, true);
	Weapon[416]	= CreateConVar("xstats_points_weapon_marketgardener",		"10",	"Xstats: TF2 - Points given when killing with Market Gardener.", _, true);
	Weapon[423]	= CreateConVar("xstats_points_weapon_saxxy",				"10",	"Xstats: TF2 - Points given when killing with Saxxy.", _, true);
	Weapon[424]	= CreateConVar("xstats_points_weapon_tomislav",				"10",	"Xstats: TF2 - Points given when killing with Tomislav.", _, true);
	Weapon[425]	= CreateConVar("xstats_points_weapon_familybusiness",		"10",	"Xstats: TF2 - Points given when killing with Family Business.", _, true);
	Weapon[426]	= CreateConVar("xstats_points_weapon_evictionnotice",		"10",	"Xstats: TF2 - Points given when killing with Eviction Notice.", _, true);
	Weapon[441]	= CreateConVar("xstats_points_weapon_cowmangler5000",		"10",	"Xstats: TF2 - Points given when killing with Cow Mangler 5000", _, true);
	Weapon[442]	= CreateConVar("xstats_points_weapon_righteousbison",		"10",	"Xstats: TF2 - Points given when killing with Righteous Bison.", _, true);
	Weapon[444]	= CreateConVar("xstats_points_weapon_mantreads",			"10",	"Xstats: TF2 - Points given when killing with Mantreads.", _, true);
	Weapon[447]	= CreateConVar("xstats_points_weapon_disciplinaryaction",	"10",	"Xstats: TF2 - Points given when killing with Disciplinary Action.", _, true);
	Weapon[448]	= CreateConVar("xstats_points_weapon_sodapopper",			"10",	"Xstats: TF2 - Points given when killing with Soda Popper.", _, true);
	Weapon[449]	= CreateConVar("xstats_points_weapon_winger",				"10",	"Xstats: TF2 - Points given when killing with Winger.", _, true);
	Weapon[450]	= CreateConVar("xstats_points_weapon_atomizer",				"10",	"Xstats: TF2 - Points given when killing with Atomizer.", _, true);
	Weapon[452]	= CreateConVar("xstats_points_weapon_threeruneblade",		"10",	"Xstats: TF2 - Points given when killing with Three Rune Blade.", _, true);
	Weapon[457]	= CreateConVar("xstats_points_weapon_postalpummeler",		"10",	"Xstats: TF2 - Points given when killing with Postal Pummeler.", _, true);
	Weapon[460]	= CreateConVar("xstats_points_weapon_enforcer",				"10",	"Xstats: TF2 - Points given when killing with Enforcer.", _, true);
	Weapon[461]	= CreateConVar("xstats_points_weapon_bigearner",			"10",	"Xstats: TF2 - Points given when killing with Big Earner.", _, true);
	Weapon[466]	= CreateConVar("xstats_points_weapon_maul",					"10",	"Xstats: TF2 - Points given when killing with Maul.", _, true);
	Weapon[474]	= CreateConVar("xstats_points_weapon_conscentiousobjector",	"10",	"Xstats: TF2 - Points given when killing with Conscentious Objector.", _, true);
	Weapon[482]	= CreateConVar("xstats_points_weapon_nessiesnineiron",		"10",	"Xstats: TF2 - Points given when killing with Nessie's Nine-Iron.", _, true);
	Weapon[513]	= CreateConVar("xstats_points_weapon_original",				"10",	"Xstats: TF2 - Points given when killing with Original.", _, true);
	Weapon[525]	= CreateConVar("xstats_points_weapon_diamondback",			"10",	"Xstats: TF2 - Points given when killing with Diamondback.", _, true);
	Weapon[526]	= CreateConVar("xstats_points_weapon_machina",				"10",	"Xstats: TF2 - Points given when killing with Machina.", _, true);
	Weapon[527]	= CreateConVar("xstats_points_weapon_widowmaker",			"10",	"Xstats: TF2 - Points given when killing with Widowmaker.", _, true);
	Weapon[528]	= CreateConVar("xstats_points_weapon_shortcircuit",			"10",	"Xstats: TF2 - Points given when killing with Short Circuit.", _, true);
	Weapon[572]	= CreateConVar("xstats_points_weapon_unarmedcombat",		"10",	"Xstats: TF2 - Points given when killing with Unarmed Combat.", _, true);
	Weapon[574]	= CreateConVar("xstats_points_weapon_wangaprick",			"10",	"Xstats: TF2 - Points given when killing with Wanga Prick.", _, true);
	Weapon[587]	= CreateConVar("xstats_points_weapon_apocofists",			"10",	"Xstats: TF2 - Points given when killing with Apoco Fists.", _, true);
	Weapon[588]	= CreateConVar("xstats_points_weapon_pomson6000",			"10",	"Xstats: TF2 - Points given when killing with Pomson 6000.", _, true);
	Weapon[589]	= CreateConVar("xstats_points_weapon_eurekaeffect",			"10",	"Xstats: TF2 - Points given when killing with Eureka Effect.", _, true);
	Weapon[593]	= CreateConVar("xstats_points_weapon_thirddegree",			"10",	"Xstats: TF2 - Points given when killing with Third Degree", _, true);
	Weapon[594]	= CreateConVar("xstats_points_weapon_phlogistinator",		"10",	"Xstats: TF2 - Points given when killing with Phlogistinator.", _, true);
	Weapon[595]	= CreateConVar("xstats_points_weapon_manmelter",			"10",	"Xstats: TF2 - Points given when killing with Man Melter.", _, true);
	Weapon[609]	= CreateConVar("xstats_points_weapon_scottishhandshake",	"10",	"Xstats: TF2 - Points given when killing with Scottish Handshake.", _, true);
	Weapon[638]	= CreateConVar("xstats_points_weapon_sharpdresser",			"10",	"Xstats: TF2 - Points given when killing with Sharp Dresser.", _, true);
	Weapon[648]	= CreateConVar("xstats_points_weapon_wrapassassin",			"10",	"Xstats: TF2 - Points given when killing with Wrap Assassin.", _, true);
	Weapon[649]	= CreateConVar("xstats_points_weapon_spycicle",				"10",	"Xstats: TF2 - Points given when killing with Spycicle.", _, true);
	Weapon[654]	= Weapon[15];	//Festive Minigun.
	Weapon[656]	= CreateConVar("xstats_points_weapon_holidaypunch",			"10",	"Xstats: TF2 - Points given when killing with Holiday Punch.", _, true);
	Weapon[658]	= Weapon[18];	//Festive Rocket Launcher.
	Weapon[659]	= Weapon[21];	//Festive Flamethrower.
	Weapon[660]	= Weapon[0];	//Festive Bat.
	Weapon[661]	= Weapon[20];	//Festive StickyBomb Launcher.
	Weapon[662]	= Weapon[7];	//Festive Wrench.
	Weapon[664]	= Weapon[14];	//Festive Sniper Rifle.
	Weapon[665]	= Weapon[4];	//Festive Knife.
	Weapon[669]	= Weapon[13];	//Festive Scattergun.
	Weapon[727]	= CreateConVar("xstats_points_weapon_blackrose",				"10",	"Xstats: TF2 - Points given when killing with Blackrose.", _, true);
	Weapon[739]	= CreateConVar("xstats_points_weapon_lollichop",				"10",	"Xstats: TF2 - Points given when killing with Lollichop.", _, true);
	Weapon[740]	= CreateConVar("xstats_points_weapon_scorchshot",				"10",	"Xstats: TF2 - Points given when killing with Scorch Shot.", _, true);
	Weapon[741]	= CreateConVar("xstats_points_weapon_rainblower",				"10",	"Xstats: TF2 - Points given when killing with Rainblower.", _, true);
	Weapon[751]	= CreateConVar("xstats_points_weapon_cleanerscarbine",			"10",	"Xstats: TF2 - Points given when killing with Cleaner's Carbine.", _, true);
	Weapon[752]	= CreateConVar("xstats_points_weapon_hitmansheatmaker",			"10",	"Xstats: TF2 - Points given when killing with Hitman's Heatmaker.", _, true);
	Weapon[772]	= CreateConVar("xstats_points_weapon_babyfacesblaster",			"10",	"Xstats: TF2 - Points given when killing with Baby Face's Blaster.", _, true);
	Weapon[773]	= CreateConVar("xstats_points_weapon_prettyboyspocketpistol",	"10",	"Xstats: TF2 - Points given when killing with Pretty Boy's Pocket Pistol.", _, true);
	Weapon[775]	= CreateConVar("xstats_points_weapon_escapeplan",				"10",	"Xstats: TF2 - Points given when killing with Escape Plan.", _, true);
	Weapon[792]	= Weapon[14];	//Default Sniper Rifle.			Silver Botkiller Mk. I.
	Weapon[793]	= Weapon[15];	//Default Minigun.				Silver Botkiller Mk. I.
	Weapon[795]	= Weapon[7];	//Default Wrench.				Silver Botkiller Mk. I.
	Weapon[797]	= Weapon[20];	//Default Stickybomb Launcher.	Silver Botkiller Mk. I.
	Weapon[798]	= Weapon[21];	//Default Flamethrower.			Silver Botkiller Mk. I.
	Weapon[799]	= Weapon[13];	//Default Scattergun.			Silver Botkiller Mk. I.
	Weapon[800]	= Weapon[18];	//Default Rocket Launcher.		Silver Botkiller Mk. I.
	Weapon[801]	= Weapon[14];	//Default Sniper Rifle.			Gold Botkiller Mk. I.
	Weapon[802]	= Weapon[15];	//Default Minigun.				Gold Botkiller Mk. I.
	Weapon[804]	= Weapon[7];	//Default Wrench.				Gold Botkiller Mk. I.
	Weapon[806]	= Weapon[20];	//Default Stickybomb Launcher.	Gold Botkiller Mk. I.
	Weapon[807]	= Weapon[21];	//Default Flamethrower.			Gold Botkiller Mk. I.
	Weapon[808]	= Weapon[13];	//Default Scattergun.			Gold Botkiller Mk. I.
	Weapon[809]	= Weapon[18];	//Default Rocket Launcher.		Gold Botkiller Mk. I.
	Weapon[811]	= CreateConVar("xstats_points_weapon_huolongheater",		"10",	"Xstats: TF2 - Points given when killing with Huo-Long Heater.", _, true);
	Weapon[812]	= CreateConVar("xstats_points_weapon_flyingguillotine",		"10",	"Xstats: TF2 - Points given when killing with Flying Guillotine", _, true);
	Weapon[813]	= CreateConVar("xstats_points_weapon_neonannihilator",		"10",	"Xstats: TF2 - Points given when killing with Neon Annihilator.", _, true);
	Weapon[832]	= Weapon[811];	//Genuine Huo-Long Heater.
	Weapon[833]	= Weapon[812];	//Genuine Flying Guillotine.
	Weapon[834]	= Weapon[813];	//Genuine Neon Annihilator.
	Weapon[850]	= Weapon[15];	//Deflector (MvM Minigun used by Giant Deflector Heavies.)
	Weapon[851]	= CreateConVar("xstats_points_weapon_awperhand",			"10",	"Xstats: TF2 - Points given when killing with AWPer Hand.", _, true);
	Weapon[880]	= CreateConVar("xstats_points_weapon_freedomstaff",			"10",	"Xstats: TF2 - Points given when killing with Freedom Staff.", _, true);
	Weapon[881]	= Weapon[14];	//Default Sniper Rifle.			Rust Botkiller Mk. I.
	Weapon[882]	= Weapon[15];	//Default Minigun.				Rust Botkiller Mk. I.
	Weapon[884]	= Weapon[7];	//Default Wrench.				Rust Botkiller Mk. I.
	Weapon[886]	= Weapon[20];	//Default Stickybomb Launcher.	Rust Botkiller Mk. I.
	Weapon[887]	= Weapon[21];	//Default Flamethrower.			Rust Botkiller Mk. I.
	Weapon[888]	= Weapon[13];	//Default Scattergun.			Rust Botkiller Mk. I.
	Weapon[889]	= Weapon[18];	//Default Rocket Launcher.		Rust Botkiller Mk. I.
	Weapon[890]	= Weapon[14];	//Default Sniper Rifle.			Blood Botkiller Mk. I.
	Weapon[891]	= Weapon[15];	//Default Minigun.				Blood Botkiller Mk. I.
	Weapon[893]	= Weapon[7];	//Default Wrench.				Blood Botkiller Mk. I.
	Weapon[895]	= Weapon[20];	//Default Stickybomb Launcher.	Blood Botkiller Mk. I.
	Weapon[896]	= Weapon[21];	//Default Flamethrower.			Blood Botkiller Mk. I.
	Weapon[897]	= Weapon[13];	//Default Scattergun.			Blood Botkiller Mk. I.
	Weapon[898]	= Weapon[18];	//Default Rocket Launcher.		Blood Botkiller Mk. I.
	Weapon[899]	= Weapon[14];	//Default Sniper Rifle.			Carbonado Botkiller Mk. I.
	Weapon[900]	= Weapon[15];	//Default Minigun.				Carbonado Botkiller Mk. I.
	Weapon[902]	= Weapon[7];	//Default Wrench.				Carbonado Botkiller Mk. I.
	Weapon[904]	= Weapon[20];	//Default Stickybomb Launcher.	Carbonado Botkiller Mk. I.
	Weapon[905]	= Weapon[21];	//Default Flamethrower.			Carbonado Botkiller Mk. I.
	Weapon[906]	= Weapon[13];	//Default Scattergun.			Carbonado Botkiller Mk. I.
	Weapon[907]	= Weapon[18];	//Default Rocket Launcher.		Carbonado Botkiller Mk. I.
	Weapon[908]	= Weapon[14];	//Default Sniper Rifle.			Diamond Botkiller Mk. I.
	Weapon[909]	= Weapon[15];	//Default Minigun.				Diamond Botkiller Mk. I.
	Weapon[911]	= Weapon[7];	//Default Wrench.				Diamond Botkiller Mk. I.
	Weapon[913]	= Weapon[20];	//Default Stickybomb Launcher.	Diamond Botkiller Mk. I.
	Weapon[914]	= Weapon[21];	//Default Flamethrower.			Diamond Botkiller Mk. I.
	Weapon[915]	= Weapon[13];	//Default Scattergun.			Diamond Botkiller Mk. I.
	Weapon[916]	= Weapon[18];	//Default Rocket Launcher.		Diamond Botkiller Mk. I.
	Weapon[939]	= CreateConVar("xstats_points_weapon_batouttahell",	"10",	"Xstats: TF2 - Points given when killing with Bat Outta Hell.", _, true);
	Weapon[954]	= CreateConVar("xstats_points_weapon_memorymaker",	"10",	"Xstats: TF2 - Points given when killing with Memory Maker.", _, true);
	Weapon[957]	= Weapon[14];	//Default Sniper Rifle.			Silver Botkiller Mk. II.
	Weapon[958]	= Weapon[15];	//Default Minigun.				Silver Botkiller Mk. II.
	Weapon[960]	= Weapon[7];	//Default Wrench.				Silver Botkiller Mk. II.
	Weapon[962]	= Weapon[20];	//Default Stickybomb Launcher.	Silver Botkiller Mk. II.
	Weapon[963]	= Weapon[21];	//Default Flamethrower.			Silver Botkiller Mk. II.
	Weapon[964]	= Weapon[13];	//Default Scattergun.			Silver Botkiller Mk. II.
	Weapon[965]	= Weapon[18];	//Default Rocket Launcher.		Silver Botkiller Mk. II.
	Weapon[966]	= Weapon[14];	//Default Sniper Rifle.			Gold Botkiller Mk. II.
	Weapon[967]	= Weapon[15];	//Default Minigun.				Gold Botkiller Mk. II.
	Weapon[969]	= Weapon[7];	//Default Wrench.				Gold Botkiller Mk. II.
	Weapon[971]	= Weapon[20];	//Default Stickybomb Launcher.	Gold Botkiller Mk. II.
	Weapon[972]	= Weapon[21];	//Default Flamethrower.			Gold Botkiller Mk. II.
	Weapon[973]	= Weapon[13];	//Default Scattergun.			Gold Botkiller Mk. II.
	Weapon[974]	= Weapon[18];	//Default Rocket Launcher.		Gold Botkiller Mk. II.
	Weapon[996]	= CreateConVar("xstats_points_weapon_loosecannon",	"10",	"Xstats: TF2 - Points given when killing with Loose Cannon.", _, true);
	Weapon[997]	= CreateConVar("xstats_points_weapon_rescueranger",	"10",	"Xstats: TF2 - Points given when killing with Rescue Ranger.", _, true);
	Weapon[999]	= Weapon[221];	//Festive Holy Mackerel.
	Weapon[1000]	= Weapon[38];	//Festive Axtinguisher.
	Weapon[1003]	= Weapon[37];	//Festive Ubersaw.
	Weapon[1004]	= Weapon[141];//Festive Frontier Justice.
	Weapon[1005]	= Weapon[56];	//Festive Huntsman.
	Weapon[1006]	= Weapon[61];	//Festive Ambassador.
	Weapon[1007]	= Weapon[19];	//Festive Grenade Launcher.
	Weapon[1013]	= CreateConVar("xstats_points_weapon_hamshank",	"10",	"Xstats: TF2 - Points given when killing with Ham Shank.", _, true);
	Weapon[1071]	= Weapon[264];//Golden Frying Pan.
	Weapon[1078]	= Weapon[45];	//Festive Force-A-Nature.
	Weapon[1079]	= Weapon[305];//Festive Crusader's Crossbow.
	Weapon[1081]	= Weapon[39];	//Festive Flare Gun.
	Weapon[1082]	= Weapon[132];//Festive Eyelander.
	Weapon[1084]	= Weapon[239];//Festive Gloves of Running Urgently.
	Weapon[1085]	= Weapon[228];//Festive Black Box.
	Weapon[1092]	= CreateConVar("xstats_points_weapon_fortifiedcompound",	"10",	"Xstats: TF2 - Points given when killing with Fortified Compound.", _, true);
	Weapon[1098]	= CreateConVar("xstats_points_weapon_classic",				"10",	"Xstats: TF2 - Points given when killing with Classic.", _, true);
	Weapon[1099]	= CreateConVar("xstats_points_weapon_tideturner",			"10",	"Xstats: TF2 - Points given when killing with Tide Turner.", _, true);
	Weapon[1100]	= CreateConVar("xstats_points_weapon_breadbite",			"10",	"Xstats: TF2 - Points given when killing with Bread Bite.", _, true);
	Weapon[1103]	= CreateConVar("xstats_points_weapon_backscatter",			"10",	"Xstats: TF2 - Points given when killing with Back Scatter.", _, true);
	Weapon[1104]	= CreateConVar("xstats_points_weapon_airstrike",			"10",	"Xstats: TF2 - Points given when killing with Air Strike.", _, true);
	Weapon[1123]	= CreateConVar("xstats_points_weapon_necrosmasher",			"10",	"Xstats: TF2 - Points given when killing with Necro Smasher.", _, true);
	Weapon[1127]	= CreateConVar("xstats_points_weapon_crossingguard",		"10",	"Xstats: TF2 - Points given when killing with Crossing Guard.", _, true);
	Weapon[1141]	= Weapon[9];	//Festive Shotgun.
	Weapon[1142]	= Weapon[24];	//Festive Revolver.
	Weapon[1144]	= Weapon[131];//Festive Chargin' Targe.
	Weapon[1146]	= Weapon[40];	//Festive Backburner.
	Weapon[1149]	= Weapon[16];	//Festive SMG.
	Weapon[1150]	= CreateConVar("xstats_points_weapon_quickebomblauncher",	"10",	"Xstats: TF2 - Points given when killing with Quickiebomb Launcher.", _, true);
	Weapon[1151]	= CreateConVar("xstats_points_weapon_ironbomber",			"10",	"Xstats: TF2 - Points given when killing with Iron Bomber.", _, true);
	Weapon[1153]	= CreateConVar("xstats_points_weapon_panicattack",			"10",	"Xstats: TF2 - Points given when killing with Panic Attack.", _, true);
	Weapon[1178]	= CreateConVar("xstats_points_weapon_dragonsfury",			"10",	"Xstats: TF2 - Points given when killing with Dragon's Fury.", _, true);
	Weapon[1179]	= CreateConVar("xstats_points_weapon_thermalthruster",		"10",	"Xstats: TF2 - Points given when killing with Thermal Thruster.", _, true);
	Weapon[1181]	= CreateConVar("xstats_points_weapon_hothand",				"10",	"Xstats: TF2 - Points given when killing with Hot Hand.", _, true);
	Weapon[1184]	= Weapon[239];	//Gloves of Running Urgently. (Used by MvM Robots.)
	Weapon[15000]	= Weapon[14];	//Skinned Sniper Rifle.			Night Owl.
	Weapon[15001]	= Weapon[16];	//Skinned SMG.					Woodsy Widowmaker.
	Weapon[15002]	= Weapon[13];	//Skinned Scattergun.			Night Terror.
	Weapon[15003]	= Weapon[9];	//Skinned Shotgun.				Backwoods Boomstick.
	Weapon[15004]	= Weapon[15];	//Skinned Minigun.				King of The Jungle.
	Weapon[15005]	= Weapon[21];	//Skinned Flame Thrower.		Forest Fire.
	Weapon[15006]	= Weapon[18];	//Skinned Rocket Launcher.		Woodland Warrior.
	Weapon[15007]	= Weapon[14];	//Skinned Sniper Rifle.			Purple Range.
	Weapon[15009]	= Weapon[20];	//Skinned Stickybomb Launcher.	Sudden Flurry.
	Weapon[15011]	= Weapon[24];	//Skinned Revolver.				Psychedeic Slugger.
	Weapon[15012]	= Weapon[20];	//Skinned Stickybomb Launcher.	Carpet Bomber.
	Weapon[15013]	= Weapon[22];	//Skinned Pistol.				Red Rock Roscoe.
	Weapon[15014]	= Weapon[18];	//Skinned Rocket Launcher.		Sand Cannon.
	Weapon[15015]	= Weapon[13];	//Skinned Scattergun.			Tartan Torpedo.
	Weapon[15016]	= Weapon[9];	//Skinned Shotgun.				Rustic Ruiner.
	Weapon[15017]	= Weapon[21];	//Skinned Flame Thrower.		Barn Burner.
	Weapon[15018]	= Weapon[22];	//Skinned Pistol.				Homemade Heater.
	Weapon[15019]	= Weapon[14];	//Skinned Sniper Rifle.			Lumber From Down Under.
	Weapon[15020]	= Weapon[15];	//Skinned Minigun.				Iron Wood.
	Weapon[15021]	= Weapon[13];	//Skinned Scattergun.			Country Crusher.
	Weapon[15022]	= Weapon[16];	//Skinned SMG.					Plaid Potshotter.
	Weapon[15023]	= Weapon[14];	//Skinned Sniper Rifle.			Shot In The Dark.
	Weapon[15024]	= Weapon[20];	//Skinned Grenade Launcher.		Blasted Bombardier.
	Weapon[15026]	= Weapon[15];	//Skinned Minigun.				Antique Annihilator.
	Weapon[15027]	= Weapon[24];	//Skinned Revolver.				Old Country.
	Weapon[15028]	= Weapon[18];	//Skinned Rocket Launcher.		American Pastoral.
	Weapon[15029]	= Weapon[13];	//Skinned Scattergun.			Backcountry Blaster.
	Weapon[15030]	= Weapon[21];	//Skinned Flame Thrower.		Bovine Blazemaker.
	Weapon[15031]	= Weapon[15];	//Skinned Minigun.				War Room.
	Weapon[15032]	= Weapon[16];	//Skinned SMG.					Treadplate Tormenter.
	Weapon[15033]	= Weapon[14];	//Skinned Sniper Rifle.			Bogtrotter.
	Weapon[15034]	= Weapon[21];	//Skinned Flame Thrower.		Earth, Sky and Fire.
	Weapon[15035]	= Weapon[22];	//Skinned Pistol.				Hickory Holepuncher.
	Weapon[15036]	= Weapon[13];	//Skinned Scattergun.			Spruce Deuce.
	Weapon[15037]	= Weapon[16];	//Skinned SMG.					Team Sprayer.
	Weapon[15038]	= Weapon[20];	//Skinned Grenade Launcher.		Rooftop Wrangler.
	Weapon[15040]	= Weapon[15];	//Skinned Minigun.				Citizen Pain.
	Weapon[15041]	= Weapon[22];	//Skinned Pistol.				Local Hero.
	Weapon[15042]	= Weapon[24];	//Skinned Revolver.				Mayor.
	Weapon[15043]	= Weapon[18];	//Skinned Rocket Launcher.		Smalltown Bringdown.
	Weapon[15044]	= Weapon[9];	//Skinned Shotgun.				Civic Duty.
	Weapon[15045]	= Weapon[20];	//Skinned Stickybomb Launcher.	Liquid Asset.
	Weapon[15046]	= Weapon[22];	//Skinned Pistol.				Black Dahlia.
	Weapon[15047]	= Weapon[9];	//Skinned Shotgun.				Lightning Rod.
	Weapon[15048]	= Weapon[20];	//Skinned Stickybomb Launcher.	Pink Elephant.
	Weapon[15049]	= Weapon[21];	//Skinned Flame Thrower.		Flash Fryer.
	Weapon[15051]	= Weapon[24];	//Skinned Revolver.				Dead Reckoner.
	Weapon[15052]	= Weapon[18];	//Skinned Rocket Launcher.		Shell Shocker.
	Weapon[15053]	= Weapon[13];	//Skinned Scattergun.			Current Event.
	Weapon[15054]	= Weapon[21];	//Skinned Flame Thrower.		Turbine Torcher.
	Weapon[15055]	= Weapon[15];	//Skinned Minigun.				Brick House.
	Weapon[15056]	= Weapon[22];	//Skinned Pistol.				Sandstone Special.
	Weapon[15057]	= Weapon[18];	//Skinned Rocket Launcher.		Aqua Marine.
	Weapon[15058]	= Weapon[16];	//Skinned SMG.					Low Profile.
	Weapon[15059]	= Weapon[14];	//Skinned Sniper Rifle.			Thunderbolt.
	Weapon[15060]	= Weapon[22];	//Skinned Pistol.				Macabre Web.
	Weapon[15061]	= Weapon[22];	//Skinned Pistol.				Nutcracker.
	Weapon[15062]	= Weapon[24];	//Skinned Revolver.				Boneyard.
	Weapon[15063]	= Weapon[24];	//Skinned Revolver.				Wildwood.
	Weapon[15064]	= Weapon[24];	//Skinned Revolver.				Macabre Web.
	Weapon[15065]	= Weapon[13];	//Skinned Scattergun.			Macabre Web.
	Weapon[15066]	= Weapon[21];	//Skinned Flame Thrower.		Autumn.
	Weapon[15067]	= Weapon[21];	//Skinned Flame Thrower.		Pumpkin Patch.
	Weapon[15068]	= Weapon[21];	//Skinned Flame Thrower.		Nutcracker.
	Weapon[15069]	= Weapon[13];	//Skinned Scattergun.			Nutcracker.
	Weapon[15070]	= Weapon[14];	//Skinned Sniper Rifle.			Pumpkin Patch.
	Weapon[15071]	= Weapon[14];	//Skinned Sniper Rifle.			Boneyard.
	Weapon[15072]	= Weapon[14];	//Skinned Sniper Rifle.			Wildwood.
	Weapon[15073]	= Weapon[7];	//Skinned Wrench.				Nutcracker.
	Weapon[15074]	= Weapon[7];	//Skinned Wrench.				Autumn.
	Weapon[15075]	= Weapon[7];	//Skinned Wrench.				Boneyard.
	Weapon[15076]	= Weapon[16];	//Skinned SMG.					Wildwood.
	Weapon[15077]	= Weapon[19];	//Skinned Grenade Launcher.		Autumn.
	Weapon[15079]	= Weapon[19];	//Skinned Grenade Launcher.		Macabre Web.
	Weapon[15081]	= Weapon[18];	//Skinned Rocket Launcher.		Autumn.
	Weapon[15082]	= Weapon[20];	//Skinned Stickybomb Launcher.	Autumn.
	Weapon[15083]	= Weapon[20];	//Skinned Stickybomb Launcher.	Pumpkin Patch.
	Weapon[15084]	= Weapon[20];	//Skinned Stickybomb Launcher.	Macabre Web.
	Weapon[15085]	= Weapon[9];	//Skinned Shotgun.				Autumn.
	Weapon[15086]	= Weapon[15];	//Skinned Minigun.				Macabre Web.
	Weapon[15087]	= Weapon[15];	//Skinned Minigun.				Pumpkin Patch.
	Weapon[15088]	= Weapon[15];	//Skinned Minigun.				Nutcracker.
	Weapon[15089]	= Weapon[21];	//Skinned Flame Thrower.		Balloonicorn.
	Weapon[15090]	= Weapon[21];	//Skinned Flame Thrower.		Rainbow.
	Weapon[15091]	= Weapon[19];	//Skinned Grenade Launcher.		Rainbow.
	Weapon[15092]	= Weapon[19];	//Skinned Grenade Launcher.		Sweet Dreams.
	Weapon[15094]	= Weapon[4];	//Skinned Knife.				Blue Mew.
	Weapon[15095]	= Weapon[4];	//Skinned Knife.				Brain Candy.
	Weapon[15096]	= Weapon[4];	//Skinned Knife.				Stabbed To Hell.
	Weapon[15098]	= Weapon[15];	//Skinned Minigun.				Brain Candy.
	Weapon[15099]	= Weapon[15];	//Skinned Minigun.				Mister Cuddles.
	Weapon[15100]	= Weapon[22];	//Skinned Pistol.				Blue Mew.
	Weapon[15101]	= Weapon[22];	//Skinned Pistol.				Brain Candy.
	Weapon[15102]	= Weapon[22];	//Skinned Pistol.				Shot To Hell.
	Weapon[15103]	= Weapon[24];	//Skinned Revolver.				Flower Power.
	Weapon[15104]	= Weapon[18];	//Skinned Rocket Launcher.		Blue Mew.
	Weapon[15105]	= Weapon[18];	//Skinned Rocket Launcher.		Brain Candy.
	Weapon[15106]	= Weapon[13];	//Skinned Scattergun.			Bluw Mew.
	Weapon[15107]	= Weapon[13];	//Skinned Scattergun.			Flower Power.
	Weapon[15108]	= Weapon[13];	//Skinned Scattergun.			Shot to Hell.
	Weapon[15109]	= Weapon[9];	//Skinned Shotgun.				Flower Power.
	Weapon[15110]	= Weapon[15];	//Skinned SMG.					Blue Mew.
	Weapon[15111]	= Weapon[14];	//Skinned Sniper Rifle.			Balloonicorn.
	Weapon[15112]	= Weapon[14];	//Skinned Sniper Rifle.			Rainbow.
	Weapon[15113]	= Weapon[20];	//Skinned Stickybomb Launcher.	Sweet Dreams.
	Weapon[15114]	= Weapon[7];	//Skinned Wrench.				Torqued To Hell.
	Weapon[15115]	= Weapon[21];	//Skinned Flame Thrower.		Coffin Nail.
	Weapon[15116]	= Weapon[19];	//Skinned Grenade Launcher.		Coffin Nail.
	Weapon[15117]	= Weapon[19];	//Skinned Grenade Launcher.		Top Shelf.
	Weapon[15118]	= Weapon[4];	//Skinned Knife.				Dressed To Kill.
	Weapon[15119]	= Weapon[4];	//Skinned Knife.				Top Shelf.
	Weapon[15123]	= Weapon[15];	//Skinned Minigun.				Coffin Nail.
	Weapon[15124]	= Weapon[15];	//Skinned Minigun.				Dressed To Kill.
	Weapon[15125]	= Weapon[15];	//Skinned Minigun.				Top Shelf.
	Weapon[15126]	= Weapon[22];	//Skinned Pistol.				Dressed To Kill.
	Weapon[15127]	= Weapon[24];	//Skinned Revolver.				Top Shelf.
	Weapon[15128]	= Weapon[24];	//Skinned Revolver.				Top Shelf.
	Weapon[15129]	= Weapon[18];	//Skinned Rocket Launcher.		Coffin Nail.
	Weapon[15130]	= Weapon[18];	//Skinned Rocket Launcher.		High Roller's.
	Weapon[15131]	= Weapon[13];	//Skinned Scattergun.			Coffin Nail.
	Weapon[15132]	= Weapon[9];	//Skinned Shotgun.				Coffin Nail.
	Weapon[15133]	= Weapon[9];	//Skinned Shotgun.				Dressed To Kill.
	Weapon[15134]	= Weapon[16];	//Skinned SMG.					High Roller's.
	Weapon[15135]	= Weapon[14];	//Skinned Sniper Rifle.			Coffin Nail.
	Weapon[15136]	= Weapon[14];	//Skinned Sniper Rifle.			Dressed To Kill.
	Weapon[15137]	= Weapon[20];	//Skinned Stickybomb Launcher.	Coffin Nail.
	Weapon[15138]	= Weapon[20];	//Skinned Stickybomb Launcher.	Dressed To Kill.
	Weapon[15139]	= Weapon[7];	//Skinned Wrench.				Dressed To Kill.
	Weapon[15140]	= Weapon[7];	//Skinned Wrench.				Top Shelf.
	Weapon[15141]	= Weapon[21];	//Skinned Flame Thrower.		Warhawk.
	Weapon[15142]	= Weapon[19];	//Skinned Grenade Launcher.		Warhawk.
	Weapon[15143]	= Weapon[4];	//Skinned Knife.				Blitzkrieg.
	Weapon[15144]	= Weapon[4];	//Skinned Knife.				Airwolf.
	Weapon[15147]	= Weapon[15];	//Skinned Minigun.				Butcher Bird.
	Weapon[15148]	= Weapon[22];	//Skinned Pistol.				Blitzkrieg.
	Weapon[15149]	= Weapon[24];	//Skinned Revolver.				Blitzkrieg.
	Weapon[15050]	= Weapon[18];	//Skinned Rocket Launcher.		Warhawk.
	Weapon[15151]	= Weapon[13];	//Skinned Scattergun.			Killer Bee.
	Weapon[15152]	= Weapon[9];	//Skinned Shotgun.				Red Bear.
	Weapon[15153]	= Weapon[16];	//Skinned SMG.					Blitzkrieg.
	Weapon[15154]	= Weapon[14];	//Skinned Sniper Rifle.			Airwolf.
	Weapon[15155]	= Weapon[20];	//Skinned Stickybomb Launcher.	Blitzkrieg.
	Weapon[15156]	= Weapon[7];	//Skinned Wrench.				Airwolf.
	Weapon[15157]	= Weapon[13];	//Skinned Scattergun.			Corsair.
	Weapon[15158]	= Weapon[19];	//Skinned Grenade Launcher.		Butcher Bird.
	Weapon[19010]	= Weapon[18];	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 1.
	Weapon[19011]	= Weapon[9];	//TF2Items Give Weapon: Beta Pocket Shotgun.
	Weapon[19012]	= Weapon[129];	//TF2Items Give Weapon: Beta Split Equalizer 1.
	Weapon[19013]	= Weapon[129];	//TF2Items Give Weapon: Beta Split Equalizer 2.
	Weapon[19015]	= Weapon[14];	//TF2Items Give Weapon: Beta Sniper Rifle 1.
	Weapon[19016]	= Weapon[18];	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 2.
	Weapon[19017]	= Weapon[18];	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 3.
	Weapon[30474]	= CreateConVar("xstats_points_weapon_nostromonapalmer","10",	"Xstats: TF2 - Points given when killing with Nostromo Napalmer.", _, true);
	Weapon[30665]	= CreateConVar("xstats_points_weapon_shootingstar",		"10",	"Xstats: TF2 - Points given when killing with Shooting star.", _, true);
	Weapon[30666]	= CreateConVar("xstats_points_weapon_capper",			"10",	"Xstats: TF2 - Points given when killing with C.A.P.P.E.R.", _, true);
	Weapon[30667]	= CreateConVar("xstats_points_weapon_batsaber",			"10",	"Xstats: TF2 - Points given when killing with Batsaber.", _, true);
	Weapon[30668]	= CreateConVar("xstats_points_weapon_gigarcounter",		"10",	"Xstats: TF2 - Points given when killing with Gigar Counter.", _, true);
	Weapon[30758]	= CreateConVar("xstats_points_weapon_prinnymachete",	"10",	"Xstats: TF2 - Points given when killing with Prinny Machete.", _, true);	
	
	/* Other */
	TF2_Collat		= CreateConVar("xstats_points_collateralkill",	"2",	"Xstats: TF2 - Extra points given when pulling a collateral kill.", _, true);
	
	/* MvM - Arrayed to make it way easier to handle due to long event names */
	TF2_MvM[0] = CreateConVar("xstats_points_mvm_destroytank",		"5",	"Xstats: TF2 - Points given to red team when tank is destroyed.", _, true);
	TF2_MvM[1] = CreateConVar("xstats_points_mvm_killsentrybuster",	"5",	"Xstats: TF2 - Points given when killing Sentry Buster.", _, true);
	TF2_MvM[2] = CreateConVar("xstats_points_mvm_resetbomb",		"5",	"Xstats: TF2 - Points given when bomb is reset.", _, true);
	
	/* Events */
	
	/* MvM */
	HookEventEx(EVENT_MVM_TANK_DESTROYED_BY_PLAYERS, MvM_Tank_Destroyed_By_Players, EventHookMode_Pre);
	HookEventEx(EVENT_PLAYER_DEATH, MvM_Sentrybuster_Killed, EventHookMode_Pre);
	HookEventEx(EVENT_MVM_BOMB_RESET_BY_PLAYER, MvM_Bomb_Reset_By_Player, EventHookMode_Pre);
	
	/* Item found, achieved, gained or traded */
	HookEventEx(EVENT_ITEM_FOUND, Item_Found_TF2, EventHookMode_Pre);
	
	/* Deaths */
	HookEventEx(EVENT_PLAYER_DEATH, Player_Death_TF2, EventHookMode_Pre);
	
	/* Config file */
	AutoExecConfig(true, "tf2.xstats.plugin");
}

/* MvM */
stock void MvM_Tank_Destroyed_By_Players(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats() || !TF2_IsMvMGameMode() || TF2_MvM[0].IntValue < 1)
		return;
	
	int points = TF2_MvM[0].IntValue;
	int count = 0;
	
	for(int client = 1; client < MaxClients; client++)	{
		if(Tklib_IsValidClient(client, true) && !IsValidAbuse(client) && TF2_GetClientTeam(client) == TFTeam_Red)	{
			count++;
			
			AddSessionPoints(client, points);
			Session[client].TanksDestroyed++;
			
			char query[512];
			Format(query, sizeof(query), "update `%s` set Points = Points+%i, TanksDestroyed = TanksDestroyed+1 where SteamID='%s' and ServerID='%i'",
			playerlist, points, SteamID[client], ServerID.IntValue);
		}
	}
	
	if(count < 1)
		return; /* Nothing happens after this if count is below 1 */
	
	CPrintToChatAll("%s %t", Prefix, "MVM Team Destroyed Tank", TF2_GetTeamStringName[2], points);
}

/*	Need to use "player_death" event since "mvm_sentrybuster_killed"
	doesn't offer a killer userid/entity index
	but the sentry buster entity itself only. */
stock void MvM_Sentrybuster_Killed(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats() || !TF2_IsMvMGameMode() || TF2_MvM[1].IntValue < 1)
		return;
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	if(!Tklib_IsValidClient(client, true))
		return;
		
	if(IsValidAbuse(client))
		return;
	
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(client))
		return;
	
	if(!(IsFakeClient(victim) && TF2_GetClientTeam(victim) == TFTeam_Blue))
		return; /* Make sure it's a TFBot and is on blue team. */
	
	char sentry_buster[64];
	GetClientNameEx(victim, sentry_buster, sizeof(sentry_buster));
	
	int defindex = Ent(TF2_GetPlayerWeaponSlot(victim, TFSlot_Melee)).DefinitionIndex;
	if(!(StrContains(sentry_buster, "Sentry Buster") != -1 && defindex == 307))
		return; /* Make sure the TFBot has the correct name and Ullapool Caber. */
	
	int points = TF2_MvM[1].IntValue;
	int points_client = GetClientPoints(SteamID[client]);
	
	Session[client].SentryBustersKilled++;
	AddSessionPoints(client, points);
	CPrintToChat(client, "%s %t", Prefix, "MvM Kill Sentry Buster", Name[client], points_client, points);
	
	char query[512];
	Format(query, sizeof(query), "update `%s` set Points = Points+%i, SentryBustersKilled = SentryBustersKilled+1 where SteamID='%s' and ServerID='%i'",
	playerlist, points, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
}

stock void MvM_Bomb_Reset_By_Player(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats() || !TF2_IsMvMGameMode() || TF2_MvM[2].IntValue < 1)
		return;
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_PLAYER));
	if(!Tklib_IsValidClient(client, true))
		return;
		
	if(IsValidAbuse(client))
		return;
	
	int points = TF2_MvM[2].IntValue;
	int points_client = GetClientPoints(SteamID[client]);
	
	Session[client].BombsResetted++;
	AddSessionPoints(client, points);
	CPrintToChat(client, "%s %t", Prefix, "MvM Player Reset Bomb", Name[client], points_client, points);
	
	char query[512];
	Format(query, sizeof(query), "update `%s` set Points = Points+%i, BombsResetted = BombsResetted+1 where SteamID='%s' and ServerID='%i'",
	playerlist, points, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
}

/* Item found */
stock void Item_Found_TF2(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!PluginActive.BoolValue)
		return;

	if(event.GetBool("isfake"))	//Item is fake
		return; //This event bool doesn't exist in the game in general but you can force this event and use this.
	
	int client = event.GetInt(EVENT_STR_PLAYER);
	if(!Tklib_IsValidClient(client, true))
		return;
	
	int quality = event.GetInt(EVENT_STR_QUALITY);
	int method = event.GetInt(EVENT_STR_METHOD);
	int defindex = event.GetInt(EVENT_STR_ITEMDEF);
	bool isstrange = event.GetBool(EVENT_STR_ISSTRANGE);
	bool isunusual = event.GetBool(EVENT_STR_ISUNUSUAL);
	float wear = event.GetFloat(EVENT_STR_WEAR);
	
	char method_name[][] = {
		"Achieved",
		"Found",
		"Crafted",
		"Traded",
		"Unboxed",
		"Gifted",
		"Earned",
		"Refunded",
		"WrappedGift"
	}, quality_name[][] = {
		"Normal",
		"Genuine",
		"Vintage",
		"Unusual",
		"Unique",
		"Community",
		"Valve",
		"Self-Made",
		"Strange",
		"Unusual",
		"Haunted",
		"Colletor's"
	};
	
	char query[512];
	int len = 0;
	len += Format(query[len], sizeof(query)-len, "insert into `%s`", item_found);
	len += Format(query[len], sizeof(query)-len, "(ServerID, Playername, SteamID, QualityID, Quality, MethodID, Method, DefinitionIndex, IsStrange, IsUnusual, Wear)");
	len += Format(query[len], sizeof(query)-len, "values");
	len += Format(query[len], sizeof(query)-len, "('%i', '%s', '%s', '%i', '%s', '%i', '%s', '%i', '%i', '%i', '%f')",
	ServerID.IntValue, Playername[client], SteamID[client], quality, quality_name, method, method_name[method], defindex, isstrange, isunusual, wear);
	db.Query(DBQuery_Callback, query);
}

/* Deaths */
stock void Player_Death_TF2(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats() || TF2_IsMvMGameMode())
		return;
	
	//It's a fake death.
	bool fakedeath = (event.GetInt(EVENT_STR_DEATH_FLAGS) == 32);
	event.SetBool("fakedeath", fakedeath);
	if(fakedeath)	{
		if(Debug.BoolValue)	{
			PrintToServer("//===== Player_Death_TF2 =====//");
			PrintToServer("Detected fake death, ignoring.");
		}
		return;
	}
	
	char weapon[96];
	event.GetString(EVENT_STR_WEAPON_LOGCLASSNAME, weapon, sizeof(weapon));

	if(StrEqual(weapon, "player")
	|| StrEqual(weapon, "world"))
		return;	
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	if(!Tklib_IsValidClient(client, true))
		return;
		
	if(IsValidAbuse(client))
		return;
	
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(victim))
		return;
		
	if(IsFakeClient(victim) && !AllowBots.BoolValue)
		return;
	
	if(IsSamePlayers(client, victim) || IsSameTeam(client, victim))
		return;
	
	/* Get the values early for lowest delay. */
	
	int assist = GetClientOfUserId(event.GetInt(EVENT_STR_ASSISTER));
	int inflictor = event.GetInt(EVENT_STR_INFLICTOR_ENTINDEX);
	int defindex = event.GetInt(EVENT_STR_WEAPON_DEF_INDEX);
	int customkill = event.GetInt(EVENT_STR_CUSTOMKILL);
	int deathflags = event.GetInt(EVENT_STR_DEATH_FLAGS);
	int penetrated = event.GetInt(EVENT_STR_PLAYERPENETRATECOUNT);
	TFCritType crits = TFCritType(event.GetInt(EVENT_STR_CRIT_TYPE));
	int points = 0;
	
	switch(TF2_GetBuildingType(inflictor))	{
		case	TFBuilding_Sentrygun:	points = TF2_SentryKill.IntValue;
		case	TFBuilding_MiniSentry:	points = TF2_MiniSentryKill.IntValue;
		case	TFBuilding_Invalid:		points = Weapon[defindex].IntValue;
	}
	
	/* Kill event stuff */
	bool headshot = (customkill == 1 || customkill == 51);
	event.SetBool("headshot", headshot);
	bool backstab = (customkill == 2);
	event.SetBool("backstab", backstab);
	bool noscope = (customkill == 11);
	event.SetBool("noscope", noscope);
	bool bleedkill = (customkill == 34);
	event.SetBool("bleedkill", bleedkill);
	
	bool dominated = (deathflags == 1);
	bool dominated_assister = (deathflags == 2);
	bool revenge = (deathflags == 4);
	bool revenge_assister = (deathflags == 8);
	bool gibkill = (deathflags == 128 || deathflags == 129);
	bool collateral = (penetrated > 0);
	
	/*	Backup death flags checks incase example attacker
		and assister gets domination or revenge at the same time. */
	if(deathflags & 1)	{
		dominated = true;
		if(Debug.BoolValue)
			PrintToServer("Killer dominated");
	}
	event.SetBool("dominated", dominated);
	if(deathflags & 2)	{
		dominated_assister = true;
		if(Debug.BoolValue)
			PrintToServer("Assister dominated");
	}
	event.SetBool("dominated_assister", dominated_assister);
	if(deathflags & 4)	{
		revenge = true;
		if(Debug.BoolValue)
			PrintToServer("Killer revenged");
	}
	event.SetBool("revenge", revenge);
	if(deathflags & 8)	{
		revenge_assister = true;
		if(Debug.BoolValue)
			PrintToServer("Assister revenged");
	}
	event.SetBool("revenge_assister", revenge);
	if(deathflags & 128 || deathflags & 129)	{
		gibkill = true;
		if(Debug.BoolValue)
			PrintToServer("Gibkill");
	}
	event.SetBool("gibkill", gibkill);
	
	bool deflectkill = ((StrContains(weapon, "deflect", false) != -1)
	|| StrContains(weapon, "reflect") != -1);
	event.SetBool("deflectkill", deflectkill);
	bool tauntkill = ((StrContains(weapon, "taunt", false) != -1)
	/* Rainblower tauntkill */
	|| (StrEqual(weapon, "armageddon", false))
	/* Thermal thruster taunt kill */
	|| (StrEqual(weapon, "gas_blast", false))
	/* Spy knife taunt kill */
	|| customkill == 13);
	event.SetBool("tauntkill", tauntkill);
	bool telefrag = StrEqual(weapon, "telefrag");
	event.SetBool("telefrag", telefrag);
	bool midair = IsClientMidAir(client);
	event.SetBool("midair", midair);
	bool airshot = (GetClientFlags(victim) == 258);
	event.SetBool("airshot", airshot);
		
	// The 'weapon_def_index' on the player_death is same as if you're gathering the killers
	// current active weapon definition index and is NOT gathering the correct definition index at the time of the event.
	// So we need to manually correct them.
	// This happens when example throwing out a grenade launcher pill and then switch to your stickybomb launcher or melee, it'll pull the definition index out of that weapon instead.
	// This also just happens on certain weapons. Just dumb. tf2 team pls fix this bug.
	
	// PrintToServer("weaponid: %d", event.GetInt("weaponid"));
	
	if(bleedkill)
		defindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Melee)).DefinitionIndex;	//Only part of melee weapons.
	
	// Lets fix these since when you swap weapons just before the kill on some weapons,
	// it'll pick definition index out of that weapon instead of the actual weapon that were used.
	
	/* Rocket Launcher. */
	if(StrEqual(weapon, "tf_projectile_rocket", false))	{
		int getindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Primary)).DefinitionIndex;
		/* If the gathered index is invalid (left or died during process), this returns 18 for safety. */
		defindex = getindex != -1 ? getindex : 18;
	}
	
	/* Grenade Launcher. */
	if(StrEqual(weapon, "tf_projectile_pipe", false))
		defindex = 19;
	
	/* StickyBomb Launcher. */
	if(StrEqual(weapon, "tf_projectile_pipe_remote", false))
		defindex = 20;
	
	/* Sandman. */
	if(StrEqual(weapon, "ball", false))	{
		int getindex = 0;
		switch(TF2_GetPlayerClass(client))	{
			case	TFClass_Scout:	getindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Melee)).DefinitionIndex;
			case	TFClass_Pyro:	{
				getindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Primary)).DefinitionIndex;	//Pyro deflected the ball.
				deflectkill = true;
			}
		}
		
		/* If the returned index is -1, return 44 for safety. */
		defindex = getindex != -1 ? getindex : 44;
	}
	
	/* Scottish Resistance. */
	if(StrEqual(weapon, "sticky_resistance", false))
		defindex = 130;
	
	/* Loch-N-Load. */
	if(StrEqual(weapon, "loch_n_load", false))
		defindex = 308;
	
	/* QuickieBomb Launcher. */
	if(StrEqual(weapon, "quickiebomb_launcher", false))
		defindex = 1150;
	
	/* Iron Bomber. */
	if(StrEqual(weapon, "iron_bomber", false))
		defindex = 1151;
	
	/* Correct the event's weapon definition index. */
	event.SetInt(EVENT_STR_WEAPON_DEF_INDEX, defindex);
	
	/* Classic - since you can noscope headshot. */
	if(defindex == 1098 && !TF2_IsPlayerInCondition(client, TFCond_Zoomed))
		noscope = true;
	
	/* The database query upload ("bat" -> "weapon_bat") */
	char fix_weapon[96];
	if(!telefrag)
		TF2_FixWeaponClassname(fix_weapon, sizeof(fix_weapon), defindex, weapon);
	
	/* Debug */
	if(Debug.BoolValue)	{
		PrintToServer("//===== Player_Death_TF2 =====//");
		PrintToServer("client %i", client);
		PrintToServer("victim %i", victim);
		PrintToServer("assist %i", assist);
		PrintToServer("inflictor %i", inflictor);
		PrintToServer(" ");
		PrintToServer("weapon \"%s\"", weapon);
		PrintToServer("defindex %i", defindex);
		PrintToServer("customkill %i", customkill);
		PrintToServer("deathflags %i", deathflags);
		PrintToServer("penetrated %i", penetrated);
		PrintToServer(" ");
		PrintToServer("crit type \"%s\"", TF2_GetCritTypeName[crits]);
		PrintToServer(" ");
		PrintToServer("Midair %s", Bool[midair]);
		PrintToServer(" ");
		PrintToServer("Points %i", points);
	}
	
	/* Kill msg stuff */
	KillMsg[client].MidAirKill = midair;
	KillMsg[client].HeadshotKill = headshot;
	KillMsg[client].NoscopeKill = noscope;
	KillMsg[client].BackstabKill = backstab;
	KillMsg[client].AirshotKill = airshot;
	KillMsg[client].DeflectKill = deflectkill;
	KillMsg[client].TeleFragKill = telefrag;
	KillMsg[client].CollateralKill = collateral;
	KillMsg[client].TauntKill = tauntkill;
	
	/* Make sure the weapon definition index exists on the array */
	if(Weapon[defindex] == null)	{
		PrintToServer("%s weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.", logprefix, weapon, defindex);
		return;
	}
	
	char query[1024];
	TF2_ClientKillVictim(client, victim);
	PrepareOnDeathForward(client, victim, assist, weapon, defindex);
	
	//There was an assist.
	if(AssistedKill(assist, client, victim))	{
		if(dominated_assister)	{
			Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[assist], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
		}
		
		if(revenge_assister)	{
			Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[assist], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
		}
	}
		
	//Make sure to not query updates on a bot, the database wouldn't be happy about that.
	VictimDied(victim);
		
	Session[client].Kills++;
	Format(query, sizeof(query), "update `%s` set Kills = Kills+1 where SteamID='%s' and ServerID='%i'",
	playerlist, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
		
	//If the inflictor entity is a building.
	switch(TF2_IsEntityBuilding(inflictor))	{
		case	true:	{
			switch(TF2_GetBuildingType(inflictor))	{
				case	TFBuilding_Dispenser:	{
					if(Debug.BoolValue)	{
						PrintToServer(" ");
						PrintToServer("Building: Dispenser (?!)");
					}
				}
				case	TFBuilding_Sentrygun:	{
					Session[client].MiniSentryKills++;
					Format(query, sizeof(query), "update `%s` set SentryKills = SentryKills+1 where SteamID='%s' and ServerID='%i'",
					playerlist, SteamID[client], ServerID.IntValue);
					db.Query(DBQuery_Callback, query);
				
					if(Debug.BoolValue)	{
						PrintToServer(" ");
						PrintToServer("Building: Sentry");
					}
				}
				case	TFBuilding_MiniSentry:	{
					Session[client].SentryKills++;
					Format(query, sizeof(query), "update `%s` set MiniSentryKills = MiniSentryKills+1 where SteamID='%s' and ServerID='%i'",
					playerlist, SteamID[client], ServerID.IntValue);
					db.Query(DBQuery_Callback, query);
					
					if(Debug.BoolValue)	{
						PrintToServer(" ");
						PrintToServer("Building: Mini-Sentry");
					}
				}
			}
		}
		case	false:	{
			switch(telefrag)	{
				case	true:	{
					Session[client].TeleFrags++;
					points += TF2_TeleFrag.IntValue;
					AddSessionPoints(client, TF2_TeleFrag.IntValue);
					Format(query, sizeof(query), "update `%s` set TeleFrags = TeleFrags+1 where SteamID='%s' and ServerID='%i'",
					playerlist, SteamID[client], ServerID.IntValue);
					db.Query(DBQuery_Callback, query);
					
					if(Debug.BoolValue)	{
						PrintToServer(" ");
						PrintToServer("Telefrag");
					}
				}
				case	false:	{
					Format(query, sizeof(query), "update `%s` set Kills_%s = Kills_%s+1 where SteamID='%s' and ServerID='%i'",
					playerlist, fix_weapon, fix_weapon, SteamID[client], ServerID.IntValue);
					db.Query(DBQuery_Callback, query);
				}
			}
		}
	}
	
	if(headshot)	{
		Session[client].Headshots++;
		Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Headshot");
		}
	}
		
	if(backstab)	{
		Session[client].Backstabs++;
		Format(query, sizeof(query), "update `%s` set Backstabs = Backstabs+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Backstab");
		}
	}
		
	if(dominated)	{
		Session[client].Dominations++;
		Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Dominated");
		}
	}
		
	if(revenge)	{
		Session[client].Revenges++;
		Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Revenge");
		}
	}
		
	if(noscope)	{
		Session[client].Noscopes++;
		Format(query, sizeof(query), "update `%s` set Noscopes = Noscopes+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Noscope");
		}
	}
		
	if(tauntkill)	{
		Session[client].TauntKills++;
		Format(query, sizeof(query), "update `%s` set TauntKills = TauntKills+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Tauntkill");
		}
	}
	
	if(deflectkill)	{
		Session[client].DeflectKills++;
		Format(query, sizeof(query), "update `%s` set DeflectKills = DeflectKills+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Deflectkill");
		}
	}
	
	if(gibkill)	{
		Session[client].GibKills++;
		Format(query, sizeof(query), "update `%s` set GibKills = GibKills+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Gibkill");
		}
	}
	
	if(airshot)	{
		Session[client].Airshots++;
		Format(query, sizeof(query), "update `%s` set Airshots = Airshots+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Airshot");
		}
	}
	
	if(collateral)	{
		Session[client].Collaterals++;
		Format(query, sizeof(query), "update `%s` set Collaterals = Collaterals+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(TF2_Collat.IntValue > 0)
			points += TF2_Collat.IntValue;
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Collateral");
		}
	}
	
	if(midair)	{
		Session[client].MidAirKills++;
		Format(query, sizeof(query), "update `%s` set MidAirKills = MidAirKills+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("MidAir Kill");
		}
	}
		
	switch(crits)	{
		case	TFCritType_Minicrit:	{
			Session[client].MiniCritKills++;
			Format(query, sizeof(query), "update `%s` set MiniCritKills = MiniCritKills+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Mini-Crit");
			}
		}
		case	TFCritType_Crit:	{
			Session[client].CritKills++;
			Format(query, sizeof(query), "update `%s` set CritKills = CritKills+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Crit");
			}
		}
	}
	
	if(points > 0)	{
		AddSessionPoints(client, points);
		
		if(Debug.BoolValue)	{
			PrintToServer(" ");
			PrintToServer("Processing kill message..");
		}
		
		Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s' and ServerID='%i'",
		playerlist, points, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		PrepareKillMessage(client, victim, points);
	}
		
	if(!IsFakeClient(victim))	{
		char log[2048];
		int len = 0;
		len += Format(log[len], sizeof(log)-len, "insert into `%s`", kill_log);
		len += Format(log[len], sizeof(log)-len, "(ServerID, Time, Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, Midair, CritType)");
		len += Format(log[len], sizeof(log)-len, "values");
		len += Format(log[len], sizeof(log)-len, "('%i', '%i', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', '%i', '%i')",
		ServerID.IntValue, GetTime(), Playername[client], SteamID[client], Playername[victim], SteamID[victim], Playername[assist], SteamID[assist], fix_weapon, headshot, noscope, midair, crits);
		db.Query(DBQuery_Kill_Log, log);
	}
}