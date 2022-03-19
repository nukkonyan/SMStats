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
	Cvars.Weapon[0]	= CreateConVar("xstats_points_weapon_bat",					"10",	"Xstats: TF2 - Points given when killing with Bat.", _, true);
	Cvars.Weapon[1]	= CreateConVar("xstats_points_weapon_bottle",				"10",	"Xstats: TF2 - Points given when killing with Bottle.", _, true);
	Cvars.Weapon[2]	= CreateConVar("xstats_points_weapon_fireaxe",				"10",	"Xstats: TF2 - Points given when killing with Fire Axe.", _, true);
	Cvars.Weapon[3]	= CreateConVar("xstats_points_weapon_kukri",				"10",	"Xstats: TF2 - Points given when killing with Kukri.", _, true);
	Cvars.Weapon[4]	= CreateConVar("xstats_points_weapon_knife",				"10",	"Xstats: TF2 - Points given when killing with Knife.", _, true);
	Cvars.Weapon[5]	= CreateConVar("xstats_points_weapon_fists",				"10",	"Xstats: TF2 - Points given when killing with Fists", _, true);
	Cvars.Weapon[6]	= CreateConVar("xstats_points_weapon_shovel",				"10",	"Xstats: TF2 - Points given when killing with Shovel.", _, true);
	Cvars.Weapon[7]	= CreateConVar("xstats_points_weapon_wrench",				"10",	"Xstats: TF2 - Points given when killing with Wrench.", _, true);
	Cvars.Weapon[8]	= CreateConVar("xstats_points_weapon_bonesaw",				"10",	"Xstats: TF2 - Points given when killing with Bonesaw.", _, true);
	Cvars.Weapon[9]	= CreateConVar("xstats_points_weapon_shotgun",				"10",	"Xstats: TF2 - Points given when killing with Shotgun.", _, true);
	Cvars.Weapon[10]	= Cvars.Weapon[9];	//Same Shotgun, different TFClass type.
	Cvars.Weapon[11]	= Cvars.Weapon[9];	//Same Shotgun, different TFClass type.
	Cvars.Weapon[12]	= Cvars.Weapon[9];	//Same Shotgun, different TFClass type.
	Cvars.Weapon[13]	= CreateConVar("xstats_points_weapon_scattergun",			"10",	"Xstats: TF2 - Points given when killing with Scattergun.", _, true);
	Cvars.Weapon[14]	= CreateConVar("xstats_points_weapon_sniperrifle",			"10",	"Xstats: TF2 - Points given when killing with Sniper Rifle.", _, true);
	Cvars.Weapon[15]	= CreateConVar("xstats_points_weapon_minigun",				"10",	"Xstats: TF2 - Points given when killing with Minigun.", _, true);
	Cvars.Weapon[16]	= CreateConVar("xstats_points_weapon_smg",					"10",	"Xstats: TF2 - Points given when killing with SMG.", _, true);
	Cvars.Weapon[17]	= CreateConVar("xstats_points_weapon_syringegun",			"10",	"Xstats: TF2 - Points given when killing with Syringe Gun.", _, true);
	Cvars.Weapon[18]	= CreateConVar("xstats_points_weapon_rocketlauncher",		"10",	"Xstats: TF2 - Points given when killing with Rocket Launcher.", _, true);
	Cvars.Weapon[19]	= CreateConVar("xstats_points_weapon_grenadelauncher",		"10",	"Xstats: TF2 - Points given when killing with Grenade Launcher.", _, true);
	Cvars.Weapon[20]	= CreateConVar("xstats_points_weapon_stickybomblauncher",	"10",	"Xstats: TF2 - Points given when killing with StickyBomb Launcher", _, true);
	Cvars.Weapon[21]	= CreateConVar("xstats_points_weapon_flamethrower",			"10",	"Xstats: TF2 - Points given when killing with Flamethrower.", _, true);
	Cvars.Weapon[22]	= CreateConVar("xstats_points_weapon_pistol",				"10",	"Xstats: TF2 - Points given when killing with Pistol.", _, true);
	Cvars.Weapon[23]	= Cvars.Weapon[22];	//Same Pistol, different TFClass type.
	Cvars.Weapon[24]	= CreateConVar("xstats_points_weapon_revolver",				"10",	"Xstats: TF2 - Points given when killing with Revolver.", _, true);
	Cvars.Weapon[36]	= CreateConVar("xstats_points_weapon_blutsauger",			"10",	"Xstats: TF2 - Points given when killing with Blutsauger.", _, true);
	Cvars.Weapon[37]	= CreateConVar("xstats_points_weapon_ubersaw",				"10",	"Xstats: TF2 - Points given when killing with Ubersaw.", _, true);
	Cvars.Weapon[38]	= CreateConVar("xstats_points_weapon_axtinguisher",			"10",	"Xstats: TF2 - Points given when killing with Axtinguisher.", _, true);
	Cvars.Weapon[39]	= CreateConVar("xstats_points_weapon_flaregun",				"10",	"Xstats: TF2 - Points given when killing with Flaregun.", _, true);
	Cvars.Weapon[40]	= CreateConVar("xstats_points_weapon_backburner",			"10",	"Xstats: TF2 - Points given when killing with Backburner.", _, true);
	Cvars.Weapon[41]	= CreateConVar("xstats_points_weapon_natascha",				"10",	"Xstats: TF2 - Points given when killing with Natascha.", _, true);
	Cvars.Weapon[43]	= CreateConVar("xstats_points_weapon_killerglovesofboxing",	"10",	"Xstats: TF2 - Points given when killing with Killer Gloves Of Boxing", _, true);
	Cvars.Weapon[44]	= CreateConVar("xstats_points_weapon_sandman",				"10",	"Xstats: TF2 - Points given when killing with Sandman.", _, true);
	Cvars.Weapon[45]	= CreateConVar("xstats_points_weapon_forceanature",			"10",	"Xstats: TF2 - Points given when killing with Force-A-Nature", _, true);
	Cvars.Weapon[56]	= CreateConVar("xstats_points_weapon_huntsman",				"10",	"Xstats: TF2 - Points given when killing with Huntsman.", _, true);
	Cvars.Weapon[61]	= CreateConVar("xstats_points_weapon_ambassador",			"10",	"Xstats: TF2 - Points given when killing with Ambassador.", _, true);
	Cvars.Weapon[127]	= CreateConVar("xstats_points_weapon_directhit",			"10",	"Xstats: TF2 - Points given when killing with Direct-Hit.", _, true);
	Cvars.Weapon[128]	= CreateConVar("xstats_points_weapon_equalizer",			"10",	"Xstats: TF2 - Points given when killing with Equalizer.", _, true);
	Cvars.Weapon[130]	= CreateConVar("xstats_points_weapon_scottishresistance",	"10",	"Xstats: TF2 - Points given when killing with Scottish Resistance.", _, true);
	Cvars.Weapon[131]	= CreateConVar("xstats_points_weapon_chargentarge",			"10",	"Xstats: TF2 - Points given when killing with Charge n' Targe", _, true);
	Cvars.Weapon[132]	= CreateConVar("xstats_points_weapon_eyelander",			"10",	"Xstats: TF2 - Points given when killing with Eyelander.", _, true);
	Cvars.Weapon[140]	= CreateConVar("xstats_points_weapon_wrangler",				"10",	"Xstats: TF2 - Points given when killing with Wrangler.", _, true);
	Cvars.Weapon[141]	= CreateConVar("xstats_points_weapon_frontierjustice",		"10",	"Xstats: TF2 - Points given when killing with Frontier Justice.", _, true);
	Cvars.Weapon[142]	= CreateConVar("xstats_points_weapon_gunslinger",			"10",	"Xstats: TF2 - Points given when killing with gunslinger.", _, true);
	Cvars.Weapon[153]	= CreateConVar("xstats_points_weapon_homewrecker",			"10",	"Xstats: TF2 - Points given when killing with homewrecker.", _, true);
	Cvars.Weapon[154]	= CreateConVar("xstats_points_weapon_paintrain",			"10",	"Xstats: TF2 - Points given when killing with pain train.", _, true);
	Cvars.Weapon[155]	= CreateConVar("xstats_points_weapon_southernhospitality",	"10",	"Xstats: TF2 - Points given when killing with southern hospitality.", _, true);
	Cvars.Weapon[160]	= CreateConVar("xstats_points_weapon_lugermorph",			"10",	"Xstats: TF2 - Points given when killing with lugermorph", _, true);
	Cvars.Weapon[161]	= CreateConVar("xstats_points_weapon_bigkill",				"10",	"Xstats: TF2 - Points given when killing with big kill.", _, true);
	Cvars.Weapon[169]	= CreateConVar("xstats_points_weapon_wrench",				"10",	"Xstats: TF2 - Points given when killing with wrench.", _, true);
	Cvars.Weapon[171]	= CreateConVar("xstats_points_weapon_tribalmansshiv",		"10",	"Xstats: TF2 - Points given when killing with tribalman's shiv.", _, true);
	Cvars.Weapon[172]	= CreateConVar("xstats_points_weapon_scotsmansskullcutter","10",	"Xstats: TF2 - Points given when killing with scotsman's skullcutter.", _, true);
	Cvars.Weapon[173]	= CreateConVar("xstats_points_weapon_vitasaw",				"10",	"Xstats: TF2 - Points given when killing with vita saw.", _, true);
	Cvars.Weapon[190]	= Cvars.Weapon[0];	//Same as default Bat, used for strange, renamed & skinned versions.
	Cvars.Weapon[191]	= Cvars.Weapon[1];	//Same as default Bottle, used for strange, renamed & skinned versions.
	Cvars.Weapon[192]	= Cvars.Weapon[2];	//Same as default Fire Axe, used for strange, renamed & skinned versions.
	Cvars.Weapon[193]	= Cvars.Weapon[3];	//Same as default Kukri, used for strange, renamed & skinned versions.
	Cvars.Weapon[194]	= Cvars.Weapon[4];	//Same as default Knife, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[195]	= Cvars.Weapon[5];	//Same as default Fists, used for strange & renamed version.
	Cvars.Weapon[196]	= Cvars.Weapon[6];	//Same as default Shovel, used for strange, renamed & skinned versions.
	Cvars.Weapon[197]	= Cvars.Weapon[7];	//Same as default Wrench, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[198]	= Cvars.Weapon[8];	//Same as default Bonesaw, used for strange, renamed & skinned versions.
	Cvars.Weapon[199]	= Cvars.Weapon[9];	//Same as default Shotgun, used for strange, renamed & skinned versions.
	Cvars.Weapon[200]	= Cvars.Weapon[13];	//Same as default Scattergun, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[201]	= Cvars.Weapon[14];	//Same as default Sniper Rifle, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[202]	= Cvars.Weapon[15];	//Same as default Minigun, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[203]	= Cvars.Weapon[16];	//Same as default SMG, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[204]	= Cvars.Weapon[17];	//Same as default Syringe gun, used for strange, renamed & skinned versions.
	Cvars.Weapon[205]	= Cvars.Weapon[18];	//Same as default Rocket Launcher, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[206]	= Cvars.Weapon[19];	//Same as default Grenade Launcher, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[207]	= Cvars.Weapon[20];	//Same as default Stickybomb Launcher, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[208]	= Cvars.Weapon[21];	//Same as default Flamethrower, used for australium, strange, renamed & skinned versions.
	Cvars.Weapon[209]	= Cvars.Weapon[22];	//Same as default Pistol, used for strange, renamed & skinned versions.
	Cvars.Weapon[210]	= Cvars.Weapon[24];	//Same as default Revolver, used for strange, renamed & skinned versions.
	Cvars.Weapon[214]	= CreateConVar("xstats_points_weapon_powerjack",			"10",	"Xstats: TF2 - Points given when killing with Power Jack.", _, true);
	Cvars.Weapon[215]	= CreateConVar("xstats_points_weapon_degreaser",			"10",	"Xstats: TF2 - Points given when killing with Degreaser.", _, true);
	Cvars.Weapon[220]	= CreateConVar("xstats_points_weapon_shortstop",			"10",	"Xstats: TF2 - Points given when killing with Shortstop", _, true);
	Cvars.Weapon[221]	= CreateConVar("xstats_points_weapon_holymackerel",			"10",	"Xstats: TF2 - Points given when killing with Holy Mackerel.", _, true);
	Cvars.Weapon[224]	= CreateConVar("xstats_points_weapon_letranger",			"10",	"Xstats: TF2 - Points given when killing with L'etranger.", _, true);
	Cvars.Weapon[225]	= CreateConVar("xstats_points_weapon_eternalreward",		"10",	"Xstats: TF2 - Points given when killing with Eternal Reward.", _, true);
	Cvars.Weapon[228]	= CreateConVar("xstats_points_weapon_blackbox",				"10",	"Xstats: TF2 - Points given when killing with Black Box.", _, true);
	Cvars.Weapon[230]	= CreateConVar("xstats_points_weapon_sydneysleeper",		"10",	"Xstats: TF2 - Points given when killing with Sydney Sleeper.", _, true);
	Cvars.Weapon[232]	= CreateConVar("xstats_points_weapon_bushwacka",			"10",	"Xstats: TF2 - Points given when killing with Bushwacka.", _, true);
	Cvars.Weapon[237]	= Cvars.Weapon[18];	//Rocket Jumper.
	Cvars.Weapon[239]	= CreateConVar("xstats_points_weapon_goru",					"10",	"Xstats: TF2 - Points given when killing with Gloves of Running Urgently.", _, true);
	Cvars.Weapon[264]	= CreateConVar("xstats_points_weapon_fryingpan",			"10",	"Xstats: TF2 - Points given when killing with Frying Pan.", _, true);
	Cvars.Weapon[265]	= Cvars.Weapon[20];	//Sticky Jumper.
	Cvars.Weapon[266]	= CreateConVar("xstats_points_weapon_hhhh",					"10",	"Xstats: TF2 - Points given when killing with Horseless Headless Horsemann's Headtaker", _, true);
	Cvars.Weapon[294]	= Cvars.Weapon[160];	//Same Lugermorph, different TFClass type.
	Cvars.Weapon[298]	= CreateConVar("xstats_points_weapon_ironcurtain",			"10",	"Xstats: TF2 - Points given when killing with Iron Curtain.", _, true);
	Cvars.Weapon[304]	= CreateConVar("xstats_points_weapon_amputator",			"10",	"Xstats: TF2 - Points given when killing with Amputator.", _, true);
	Cvars.Weapon[305]	= CreateConVar("xstats_points_weapon_crusaderscrossbow",	"10",	"Xstats: TF2 - Points given when killing with Crusader's Crossbow.", _, true);
	Cvars.Weapon[307]	= CreateConVar("xstats_points_weapon_ullapoolcaber",		"10",	"Xstats: TF2 - Points given when killing with Ullapool Caber.", _, true);
	Cvars.Weapon[308]	= CreateConVar("xstats_points_weapon_lochnload",			"10",	"Xstats: TF2 - Points given when killing with Loch-n-Load.", _, true);
	Cvars.Weapon[310]	= CreateConVar("xstats_points_weapon_warriorsspirit",		"10",	"Xstats: TF2 - Points given when killing with Warrior's Spirit.", _, true);
	Cvars.Weapon[312]	= CreateConVar("xstats_points_weapon_brassbeast",			"10",	"Xstats: TF2 - Points given when killing with Brass Beast.", _, true);
	Cvars.Weapon[317]	= CreateConVar("xstats_points_weapon_candycane",			"10",	"Xstats: TF2 - Points given when killing with Candy Cane.", _, true);
	Cvars.Weapon[325]	= CreateConVar("xstats_points_weapon_bostonbasher",			"10",	"Xstats: TF2 - Points given when killing with Boston Basher.", _, true);
	Cvars.Weapon[326]	= CreateConVar("xstats_points_weapon_backscratcher",		"10",	"Xstats: TF2 - Points given when killing with Back Scratcher.", _, true);
	Cvars.Weapon[327]	= CreateConVar("xstats_points_weapon_claidheamhmor",		"10",	"Xstats: TF2 - Points given when killing with Claidheamh Mór.", _, true);
	Cvars.Weapon[329]	= CreateConVar("xstats_points_weapon_jag",					"10",	"Xstats: TF2 - Points given when killing with Jag.", _, true);
	Cvars.Weapon[331]	= CreateConVar("xstats_points_weapon_fistsofsteel",			"10",	"Xstats: TF2 - Points given when killing with Fists Of Steel.", _, true);
	Cvars.Weapon[348]	= CreateConVar("xstats_points_weapon_sharpenedvolcanofragment","10","Xstats: TF2 - Points given when killing with Sharpened Volcano Fragment.", _, true);
	Cvars.Weapon[349]	= CreateConVar("xstats_points_weapon_sunonastick",			"10",	"Xstats: TF2 - Points given when killing with Sun-On-A-Stick.", _, true);
	Cvars.Weapon[351]	= CreateConVar("xstats_points_weapon_detonator",			"10",	"Xstats: TF2 - Points given when killing with Detonator.", _, true);
	Cvars.Weapon[355]	= CreateConVar("xstats_points_weapon_fanowar",				"10",	"Xstats: TF2 - Points given when killing with Fan O' War.", _, true);
	Cvars.Weapon[356]	= CreateConVar("xstats_points_weapon_conniverskunai",		"10",	"Xstats: TF2 - Points given when killing with Conniver's Kunai.", _, true);
	Cvars.Weapon[357]	= CreateConVar("xstats_points_weapon_halfzatoichi",			"10",	"Xstats: TF2 - Points given when killing with Half-Zatoichi.", _, true);
	Cvars.Weapon[401]	= CreateConVar("xstats_points_weapon_shahanshah",			"10",	"Xstats: TF2 - Points given when killing with Shahanshah.", _, true);
	Cvars.Weapon[402]	= CreateConVar("xstats_points_weapon_bazaarbargain",		"10",	"Xstats: TF2 - Points given when killing with Bazaar Bargain.", _, true);
	Cvars.Weapon[404]	= CreateConVar("xstats_points_weapon_persainpersuader",		"10",	"Xstats: TF2 - Points given when killing with Persain Pursuader.", _, true);
	Cvars.Weapon[406]	= CreateConVar("xstats_points_weapon_splendidscreen",		"10",	"Xstats: TF2 - Points given when killing with Splendid Screen.", _, true);
	Cvars.Weapon[412]	= CreateConVar("xstats_points_weapon_overdose",				"10",	"Xstats: TF2 - Points given when killing with Overdose.", _, true);
	Cvars.Weapon[413]	= CreateConVar("xstats_points_weapon_solemnvow",			"10",	"Xstats: TF2 - Points given when killing with Solmen Wov.", _, true);
	Cvars.Weapon[414]	= CreateConVar("xstats_points_weapon_libertylauncher",		"10",	"Xstats: TF2 - Points given when killing with Liberty Launcher.", _, true);
	Cvars.Weapon[415]	= CreateConVar("xstats_points_weapon_reserveshooter",		"10",	"Xstats: TF2 - Points given when killing with Reserve Shooter.", _, true);
	Cvars.Weapon[416]	= CreateConVar("xstats_points_weapon_marketgardener",		"10",	"Xstats: TF2 - Points given when killing with Market Gardener.", _, true);
	Cvars.Weapon[423]	= CreateConVar("xstats_points_weapon_saxxy",				"10",	"Xstats: TF2 - Points given when killing with Saxxy.", _, true);
	Cvars.Weapon[424]	= CreateConVar("xstats_points_weapon_tomislav",				"10",	"Xstats: TF2 - Points given when killing with Tomislav.", _, true);
	Cvars.Weapon[425]	= CreateConVar("xstats_points_weapon_familybusiness",		"10",	"Xstats: TF2 - Points given when killing with Family Business.", _, true);
	Cvars.Weapon[426]	= CreateConVar("xstats_points_weapon_evictionnotice",		"10",	"Xstats: TF2 - Points given when killing with Eviction Notice.", _, true);
	Cvars.Weapon[441]	= CreateConVar("xstats_points_weapon_cowmangler5000",		"10",	"Xstats: TF2 - Points given when killing with Cow Mangler 5000", _, true);
	Cvars.Weapon[442]	= CreateConVar("xstats_points_weapon_righteousbison",		"10",	"Xstats: TF2 - Points given when killing with Righteous Bison.", _, true);
	Cvars.Weapon[444]	= CreateConVar("xstats_points_weapon_mantreads",			"10",	"Xstats: TF2 - Points given when killing with Mantreads.", _, true);
	Cvars.Weapon[447]	= CreateConVar("xstats_points_weapon_disciplinaryaction",	"10",	"Xstats: TF2 - Points given when killing with Disciplinary Action.", _, true);
	Cvars.Weapon[448]	= CreateConVar("xstats_points_weapon_sodapopper",			"10",	"Xstats: TF2 - Points given when killing with Soda Popper.", _, true);
	Cvars.Weapon[449]	= CreateConVar("xstats_points_weapon_winger",				"10",	"Xstats: TF2 - Points given when killing with Winger.", _, true);
	Cvars.Weapon[450]	= CreateConVar("xstats_points_weapon_atomizer",				"10",	"Xstats: TF2 - Points given when killing with Atomizer.", _, true);
	Cvars.Weapon[452]	= CreateConVar("xstats_points_weapon_threeruneblade",		"10",	"Xstats: TF2 - Points given when killing with Three Rune Blade.", _, true);
	Cvars.Weapon[457]	= CreateConVar("xstats_points_weapon_postalpummeler",		"10",	"Xstats: TF2 - Points given when killing with Postal Pummeler.", _, true);
	Cvars.Weapon[460]	= CreateConVar("xstats_points_weapon_enforcer",				"10",	"Xstats: TF2 - Points given when killing with Enforcer.", _, true);
	Cvars.Weapon[461]	= CreateConVar("xstats_points_weapon_bigearner",			"10",	"Xstats: TF2 - Points given when killing with Big Earner.", _, true);
	Cvars.Weapon[466]	= CreateConVar("xstats_points_weapon_maul",					"10",	"Xstats: TF2 - Points given when killing with Maul.", _, true);
	Cvars.Weapon[474]	= CreateConVar("xstats_points_weapon_conscentiousobjector",	"10",	"Xstats: TF2 - Points given when killing with Conscentious Objector.", _, true);
	Cvars.Weapon[482]	= CreateConVar("xstats_points_weapon_nessiesnineiron",		"10",	"Xstats: TF2 - Points given when killing with Nessie's Nine-Iron.", _, true);
	Cvars.Weapon[513]	= CreateConVar("xstats_points_weapon_original",				"10",	"Xstats: TF2 - Points given when killing with Original.", _, true);
	Cvars.Weapon[525]	= CreateConVar("xstats_points_weapon_diamondback",			"10",	"Xstats: TF2 - Points given when killing with Diamondback.", _, true);
	Cvars.Weapon[526]	= CreateConVar("xstats_points_weapon_machina",				"10",	"Xstats: TF2 - Points given when killing with Machina.", _, true);
	Cvars.Weapon[527]	= CreateConVar("xstats_points_weapon_widowmaker",			"10",	"Xstats: TF2 - Points given when killing with Widowmaker.", _, true);
	Cvars.Weapon[528]	= CreateConVar("xstats_points_weapon_shortcircuit",			"10",	"Xstats: TF2 - Points given when killing with Short Circuit.", _, true);
	Cvars.Weapon[572]	= CreateConVar("xstats_points_weapon_unarmedcombat",		"10",	"Xstats: TF2 - Points given when killing with Unarmed Combat.", _, true);
	Cvars.Weapon[574]	= CreateConVar("xstats_points_weapon_wangaprick",			"10",	"Xstats: TF2 - Points given when killing with Wanga Prick.", _, true);
	Cvars.Weapon[587]	= CreateConVar("xstats_points_weapon_apocofists",			"10",	"Xstats: TF2 - Points given when killing with Apoco Fists.", _, true);
	Cvars.Weapon[588]	= CreateConVar("xstats_points_weapon_pomson6000",			"10",	"Xstats: TF2 - Points given when killing with Pomson 6000.", _, true);
	Cvars.Weapon[589]	= CreateConVar("xstats_points_weapon_eurekaeffect",			"10",	"Xstats: TF2 - Points given when killing with Eureka Effect.", _, true);
	Cvars.Weapon[593]	= CreateConVar("xstats_points_weapon_thirddegree",			"10",	"Xstats: TF2 - Points given when killing with Third Degree", _, true);
	Cvars.Weapon[594]	= CreateConVar("xstats_points_weapon_phlogistinator",		"10",	"Xstats: TF2 - Points given when killing with Phlogistinator.", _, true);
	Cvars.Weapon[595]	= CreateConVar("xstats_points_weapon_manmelter",			"10",	"Xstats: TF2 - Points given when killing with Man Melter.", _, true);
	Cvars.Weapon[609]	= CreateConVar("xstats_points_weapon_scottishhandshake",	"10",	"Xstats: TF2 - Points given when killing with Scottish Handshake.", _, true);
	Cvars.Weapon[638]	= CreateConVar("xstats_points_weapon_sharpdresser",			"10",	"Xstats: TF2 - Points given when killing with Sharp Dresser.", _, true);
	Cvars.Weapon[648]	= CreateConVar("xstats_points_weapon_wrapassassin",			"10",	"Xstats: TF2 - Points given when killing with Wrap Assassin.", _, true);
	Cvars.Weapon[649]	= CreateConVar("xstats_points_weapon_spycicle",				"10",	"Xstats: TF2 - Points given when killing with Spycicle.", _, true);
	Cvars.Weapon[654]	= Cvars.Weapon[15];	//Festive Minigun.
	Cvars.Weapon[656]	= CreateConVar("xstats_points_weapon_holidaypunch",			"10",	"Xstats: TF2 - Points given when killing with Holiday Punch.", _, true);
	Cvars.Weapon[658]	= Cvars.Weapon[18];	//Festive Rocket Launcher.
	Cvars.Weapon[659]	= Cvars.Weapon[21];	//Festive Flamethrower.
	Cvars.Weapon[660]	= Cvars.Weapon[0];	//Festive Bat.
	Cvars.Weapon[661]	= Cvars.Weapon[20];	//Festive StickyBomb Launcher.
	Cvars.Weapon[662]	= Cvars.Weapon[7];	//Festive Wrench.
	Cvars.Weapon[664]	= Cvars.Weapon[14];	//Festive Sniper Rifle.
	Cvars.Weapon[665]	= Cvars.Weapon[4];	//Festive Knife.
	Cvars.Weapon[669]	= Cvars.Weapon[13];	//Festive Scattergun.
	Cvars.Weapon[727]	= CreateConVar("xstats_points_weapon_blackrose",				"10",	"Xstats: TF2 - Points given when killing with Blackrose.", _, true);
	Cvars.Weapon[739]	= CreateConVar("xstats_points_weapon_lollichop",				"10",	"Xstats: TF2 - Points given when killing with Lollichop.", _, true);
	Cvars.Weapon[740]	= CreateConVar("xstats_points_weapon_scorchshot",				"10",	"Xstats: TF2 - Points given when killing with Scorch Shot.", _, true);
	Cvars.Weapon[741]	= CreateConVar("xstats_points_weapon_rainblower",				"10",	"Xstats: TF2 - Points given when killing with Rainblower.", _, true);
	Cvars.Weapon[751]	= CreateConVar("xstats_points_weapon_cleanerscarbine",			"10",	"Xstats: TF2 - Points given when killing with Cleaner's Carbine.", _, true);
	Cvars.Weapon[752]	= CreateConVar("xstats_points_weapon_hitmansheatmaker",			"10",	"Xstats: TF2 - Points given when killing with Hitman's Heatmaker.", _, true);
	Cvars.Weapon[772]	= CreateConVar("xstats_points_weapon_babyfacesblaster",			"10",	"Xstats: TF2 - Points given when killing with Baby Face's Blaster.", _, true);
	Cvars.Weapon[773]	= CreateConVar("xstats_points_weapon_prettyboyspocketpistol",	"10",	"Xstats: TF2 - Points given when killing with Pretty Boy's Pocket Pistol.", _, true);
	Cvars.Weapon[775]	= CreateConVar("xstats_points_weapon_escapeplan",				"10",	"Xstats: TF2 - Points given when killing with Escape Plan.", _, true);
	Cvars.Weapon[792]	= Cvars.Weapon[14];	//Default Sniper Rifle.			Silver Botkiller Mk. I.
	Cvars.Weapon[793]	= Cvars.Weapon[15];	//Default Minigun.				Silver Botkiller Mk. I.
	Cvars.Weapon[795]	= Cvars.Weapon[7];	//Default Wrench.				Silver Botkiller Mk. I.
	Cvars.Weapon[797]	= Cvars.Weapon[20];	//Default Stickybomb Launcher.	Silver Botkiller Mk. I.
	Cvars.Weapon[798]	= Cvars.Weapon[21];	//Default Flamethrower.			Silver Botkiller Mk. I.
	Cvars.Weapon[799]	= Cvars.Weapon[13];	//Default Scattergun.			Silver Botkiller Mk. I.
	Cvars.Weapon[800]	= Cvars.Weapon[18];	//Default Rocket Launcher.		Silver Botkiller Mk. I.
	Cvars.Weapon[801]	= Cvars.Weapon[14];	//Default Sniper Rifle.			Gold Botkiller Mk. I.
	Cvars.Weapon[802]	= Cvars.Weapon[15];	//Default Minigun.				Gold Botkiller Mk. I.
	Cvars.Weapon[804]	= Cvars.Weapon[7];	//Default Wrench.				Gold Botkiller Mk. I.
	Cvars.Weapon[806]	= Cvars.Weapon[20];	//Default Stickybomb Launcher.	Gold Botkiller Mk. I.
	Cvars.Weapon[807]	= Cvars.Weapon[21];	//Default Flamethrower.			Gold Botkiller Mk. I.
	Cvars.Weapon[808]	= Cvars.Weapon[13];	//Default Scattergun.			Gold Botkiller Mk. I.
	Cvars.Weapon[809]	= Cvars.Weapon[18];	//Default Rocket Launcher.		Gold Botkiller Mk. I.
	Cvars.Weapon[811]	= CreateConVar("xstats_points_weapon_huolongheater",		"10",	"Xstats: TF2 - Points given when killing with Huo-Long Heater.", _, true);
	Cvars.Weapon[812]	= CreateConVar("xstats_points_weapon_flyingguillotine",		"10",	"Xstats: TF2 - Points given when killing with Flying Guillotine", _, true);
	Cvars.Weapon[813]	= CreateConVar("xstats_points_weapon_neonannihilator",		"10",	"Xstats: TF2 - Points given when killing with Neon Annihilator.", _, true);
	Cvars.Weapon[832]	= Cvars.Weapon[811];	//Genuine Huo-Long Heater.
	Cvars.Weapon[833]	= Cvars.Weapon[812];	//Genuine Flying Guillotine.
	Cvars.Weapon[834]	= Cvars.Weapon[813];	//Genuine Neon Annihilator.
	Cvars.Weapon[850]	= Cvars.Weapon[15];	//Deflector (MvM Minigun used by Giant Deflector Heavies.)
	Cvars.Weapon[851]	= CreateConVar("xstats_points_weapon_awperhand",			"10",	"Xstats: TF2 - Points given when killing with AWPer Hand.", _, true);
	Cvars.Weapon[880]	= CreateConVar("xstats_points_weapon_freedomstaff",			"10",	"Xstats: TF2 - Points given when killing with Freedom Staff.", _, true);
	Cvars.Weapon[881]	= Cvars.Weapon[14];	//Default Sniper Rifle.			Rust Botkiller Mk. I.
	Cvars.Weapon[882]	= Cvars.Weapon[15];	//Default Minigun.				Rust Botkiller Mk. I.
	Cvars.Weapon[884]	= Cvars.Weapon[7];	//Default Wrench.				Rust Botkiller Mk. I.
	Cvars.Weapon[886]	= Cvars.Weapon[20];	//Default Stickybomb Launcher.	Rust Botkiller Mk. I.
	Cvars.Weapon[887]	= Cvars.Weapon[21];	//Default Flamethrower.			Rust Botkiller Mk. I.
	Cvars.Weapon[888]	= Cvars.Weapon[13];	//Default Scattergun.			Rust Botkiller Mk. I.
	Cvars.Weapon[889]	= Cvars.Weapon[18];	//Default Rocket Launcher.		Rust Botkiller Mk. I.
	Cvars.Weapon[890]	= Cvars.Weapon[14];	//Default Sniper Rifle.			Blood Botkiller Mk. I.
	Cvars.Weapon[891]	= Cvars.Weapon[15];	//Default Minigun.				Blood Botkiller Mk. I.
	Cvars.Weapon[893]	= Cvars.Weapon[7];	//Default Wrench.				Blood Botkiller Mk. I.
	Cvars.Weapon[895]	= Cvars.Weapon[20];	//Default Stickybomb Launcher.	Blood Botkiller Mk. I.
	Cvars.Weapon[896]	= Cvars.Weapon[21];	//Default Flamethrower.			Blood Botkiller Mk. I.
	Cvars.Weapon[897]	= Cvars.Weapon[13];	//Default Scattergun.			Blood Botkiller Mk. I.
	Cvars.Weapon[898]	= Cvars.Weapon[18];	//Default Rocket Launcher.		Blood Botkiller Mk. I.
	Cvars.Weapon[899]	= Cvars.Weapon[14];	//Default Sniper Rifle.			Carbonado Botkiller Mk. I.
	Cvars.Weapon[900]	= Cvars.Weapon[15];	//Default Minigun.				Carbonado Botkiller Mk. I.
	Cvars.Weapon[902]	= Cvars.Weapon[7];	//Default Wrench.				Carbonado Botkiller Mk. I.
	Cvars.Weapon[904]	= Cvars.Weapon[20];	//Default Stickybomb Launcher.	Carbonado Botkiller Mk. I.
	Cvars.Weapon[905]	= Cvars.Weapon[21];	//Default Flamethrower.			Carbonado Botkiller Mk. I.
	Cvars.Weapon[906]	= Cvars.Weapon[13];	//Default Scattergun.			Carbonado Botkiller Mk. I.
	Cvars.Weapon[907]	= Cvars.Weapon[18];	//Default Rocket Launcher.		Carbonado Botkiller Mk. I.
	Cvars.Weapon[908]	= Cvars.Weapon[14];	//Default Sniper Rifle.			Diamond Botkiller Mk. I.
	Cvars.Weapon[909]	= Cvars.Weapon[15];	//Default Minigun.				Diamond Botkiller Mk. I.
	Cvars.Weapon[911]	= Cvars.Weapon[7];	//Default Wrench.				Diamond Botkiller Mk. I.
	Cvars.Weapon[913]	= Cvars.Weapon[20];	//Default Stickybomb Launcher.	Diamond Botkiller Mk. I.
	Cvars.Weapon[914]	= Cvars.Weapon[21];	//Default Flamethrower.			Diamond Botkiller Mk. I.
	Cvars.Weapon[915]	= Cvars.Weapon[13];	//Default Scattergun.			Diamond Botkiller Mk. I.
	Cvars.Weapon[916]	= Cvars.Weapon[18];	//Default Rocket Launcher.		Diamond Botkiller Mk. I.
	Cvars.Weapon[939]	= CreateConVar("xstats_points_weapon_batouttahell",	"10",	"Xstats: TF2 - Points given when killing with Bat Outta Hell.", _, true);
	Cvars.Weapon[954]	= CreateConVar("xstats_points_weapon_memorymaker",	"10",	"Xstats: TF2 - Points given when killing with Memory Maker.", _, true);
	Cvars.Weapon[957]	= Cvars.Weapon[14];	//Default Sniper Rifle.			Silver Botkiller Mk. II.
	Cvars.Weapon[958]	= Cvars.Weapon[15];	//Default Minigun.				Silver Botkiller Mk. II.
	Cvars.Weapon[960]	= Cvars.Weapon[7];	//Default Wrench.				Silver Botkiller Mk. II.
	Cvars.Weapon[962]	= Cvars.Weapon[20];	//Default Stickybomb Launcher.	Silver Botkiller Mk. II.
	Cvars.Weapon[963]	= Cvars.Weapon[21];	//Default Flamethrower.			Silver Botkiller Mk. II.
	Cvars.Weapon[964]	= Cvars.Weapon[13];	//Default Scattergun.			Silver Botkiller Mk. II.
	Cvars.Weapon[965]	= Cvars.Weapon[18];	//Default Rocket Launcher.		Silver Botkiller Mk. II.
	Cvars.Weapon[966]	= Cvars.Weapon[14];	//Default Sniper Rifle.			Gold Botkiller Mk. II.
	Cvars.Weapon[967]	= Cvars.Weapon[15];	//Default Minigun.				Gold Botkiller Mk. II.
	Cvars.Weapon[969]	= Cvars.Weapon[7];	//Default Wrench.				Gold Botkiller Mk. II.
	Cvars.Weapon[971]	= Cvars.Weapon[20];	//Default Stickybomb Launcher.	Gold Botkiller Mk. II.
	Cvars.Weapon[972]	= Cvars.Weapon[21];	//Default Flamethrower.			Gold Botkiller Mk. II.
	Cvars.Weapon[973]	= Cvars.Weapon[13];	//Default Scattergun.			Gold Botkiller Mk. II.
	Cvars.Weapon[974]	= Cvars.Weapon[18];	//Default Rocket Launcher.		Gold Botkiller Mk. II.
	Cvars.Weapon[996]	= CreateConVar("xstats_points_weapon_loosecannon",	"10",	"Xstats: TF2 - Points given when killing with Loose Cannon.", _, true);
	Cvars.Weapon[997]	= CreateConVar("xstats_points_weapon_rescueranger",	"10",	"Xstats: TF2 - Points given when killing with Rescue Ranger.", _, true);
	Cvars.Weapon[999]	= Cvars.Weapon[221];	//Festive Holy Mackerel.
	Cvars.Weapon[1000]	= Cvars.Weapon[38];	//Festive Axtinguisher.
	Cvars.Weapon[1003]	= Cvars.Weapon[37];	//Festive Ubersaw.
	Cvars.Weapon[1004]	= Cvars.Weapon[141];//Festive Frontier Justice.
	Cvars.Weapon[1005]	= Cvars.Weapon[56];	//Festive Huntsman.
	Cvars.Weapon[1006]	= Cvars.Weapon[61];	//Festive Ambassador.
	Cvars.Weapon[1007]	= Cvars.Weapon[19];	//Festive Grenade Launcher.
	Cvars.Weapon[1013]	= CreateConVar("xstats_points_weapon_hamshank",	"10",	"Xstats: TF2 - Points given when killing with Ham Shank.", _, true);
	Cvars.Weapon[1071]	= Cvars.Weapon[264];//Golden Frying Pan.
	Cvars.Weapon[1078]	= Cvars.Weapon[45];	//Festive Force-A-Nature.
	Cvars.Weapon[1079]	= Cvars.Weapon[305];//Festive Crusader's Crossbow.
	Cvars.Weapon[1081]	= Cvars.Weapon[39];	//Festive Flare Gun.
	Cvars.Weapon[1082]	= Cvars.Weapon[132];//Festive Eyelander.
	Cvars.Weapon[1084]	= Cvars.Weapon[239];//Festive Gloves of Running Urgently.
	Cvars.Weapon[1085]	= Cvars.Weapon[228];//Festive Black Box.
	Cvars.Weapon[1092]	= CreateConVar("xstats_points_weapon_fortifiedcompound",	"10",	"Xstats: TF2 - Points given when killing with Fortified Compound.", _, true);
	Cvars.Weapon[1098]	= CreateConVar("xstats_points_weapon_classic",				"10",	"Xstats: TF2 - Points given when killing with Classic.", _, true);
	Cvars.Weapon[1099]	= CreateConVar("xstats_points_weapon_tideturner",			"10",	"Xstats: TF2 - Points given when killing with Tide Turner.", _, true);
	Cvars.Weapon[1100]	= CreateConVar("xstats_points_weapon_breadbite",			"10",	"Xstats: TF2 - Points given when killing with Bread Bite.", _, true);
	Cvars.Weapon[1103]	= CreateConVar("xstats_points_weapon_backscatter",			"10",	"Xstats: TF2 - Points given when killing with Back Scatter.", _, true);
	Cvars.Weapon[1104]	= CreateConVar("xstats_points_weapon_airstrike",			"10",	"Xstats: TF2 - Points given when killing with Air Strike.", _, true);
	Cvars.Weapon[1123]	= CreateConVar("xstats_points_weapon_necrosmasher",			"10",	"Xstats: TF2 - Points given when killing with Necro Smasher.", _, true);
	Cvars.Weapon[1127]	= CreateConVar("xstats_points_weapon_crossingguard",		"10",	"Xstats: TF2 - Points given when killing with Crossing Guard.", _, true);
	Cvars.Weapon[1141]	= Cvars.Weapon[9];	//Festive Shotgun.
	Cvars.Weapon[1142]	= Cvars.Weapon[24];	//Festive Revolver.
	Cvars.Weapon[1144]	= Cvars.Weapon[131];//Festive Chargin' Targe.
	Cvars.Weapon[1146]	= Cvars.Weapon[40];	//Festive Backburner.
	Cvars.Weapon[1149]	= Cvars.Weapon[16];	//Festive SMG.
	Cvars.Weapon[1150]	= CreateConVar("xstats_points_weapon_quickebomblauncher",	"10",	"Xstats: TF2 - Points given when killing with Quickiebomb Launcher.", _, true);
	Cvars.Weapon[1151]	= CreateConVar("xstats_points_weapon_ironbomber",			"10",	"Xstats: TF2 - Points given when killing with Iron Bomber.", _, true);
	Cvars.Weapon[1153]	= CreateConVar("xstats_points_weapon_panicattack",			"10",	"Xstats: TF2 - Points given when killing with Panic Attack.", _, true);
	Cvars.Weapon[1178]	= CreateConVar("xstats_points_weapon_dragonsfury",			"10",	"Xstats: TF2 - Points given when killing with Dragon's Fury.", _, true);
	Cvars.Weapon[1179]	= CreateConVar("xstats_points_weapon_thermalthruster",		"10",	"Xstats: TF2 - Points given when killing with Thermal Thruster.", _, true);
	Cvars.Weapon[1181]	= CreateConVar("xstats_points_weapon_hothand",				"10",	"Xstats: TF2 - Points given when killing with Hot Hand.", _, true);
	Cvars.Weapon[1184]	= Cvars.Weapon[239];	//Gloves of Running Urgently. (Used by MvM Robots.)
	Cvars.Weapon[15000]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Night Owl.
	Cvars.Weapon[15001]	= Cvars.Weapon[16];	//Skinned SMG.					Woodsy Widowmaker.
	Cvars.Weapon[15002]	= Cvars.Weapon[13];	//Skinned Scattergun.			Night Terror.
	Cvars.Weapon[15003]	= Cvars.Weapon[9];	//Skinned Shotgun.				Backwoods Boomstick.
	Cvars.Weapon[15004]	= Cvars.Weapon[15];	//Skinned Minigun.				King of The Jungle.
	Cvars.Weapon[15005]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Forest Fire.
	Cvars.Weapon[15006]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Woodland Warrior.
	Cvars.Weapon[15007]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Purple Range.
	Cvars.Weapon[15009]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Sudden Flurry.
	Cvars.Weapon[15011]	= Cvars.Weapon[24];	//Skinned Revolver.				Psychedeic Slugger.
	Cvars.Weapon[15012]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Carpet Bomber.
	Cvars.Weapon[15013]	= Cvars.Weapon[22];	//Skinned Pistol.				Red Rock Roscoe.
	Cvars.Weapon[15014]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Sand Cannon.
	Cvars.Weapon[15015]	= Cvars.Weapon[13];	//Skinned Scattergun.			Tartan Torpedo.
	Cvars.Weapon[15016]	= Cvars.Weapon[9];	//Skinned Shotgun.				Rustic Ruiner.
	Cvars.Weapon[15017]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Barn Burner.
	Cvars.Weapon[15018]	= Cvars.Weapon[22];	//Skinned Pistol.				Homemade Heater.
	Cvars.Weapon[15019]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Lumber From Down Under.
	Cvars.Weapon[15020]	= Cvars.Weapon[15];	//Skinned Minigun.				Iron Wood.
	Cvars.Weapon[15021]	= Cvars.Weapon[13];	//Skinned Scattergun.			Country Crusher.
	Cvars.Weapon[15022]	= Cvars.Weapon[16];	//Skinned SMG.					Plaid Potshotter.
	Cvars.Weapon[15023]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Shot In The Dark.
	Cvars.Weapon[15024]	= Cvars.Weapon[20];	//Skinned Grenade Launcher.		Blasted Bombardier.
	Cvars.Weapon[15026]	= Cvars.Weapon[15];	//Skinned Minigun.				Antique Annihilator.
	Cvars.Weapon[15027]	= Cvars.Weapon[24];	//Skinned Revolver.				Old Country.
	Cvars.Weapon[15028]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		American Pastoral.
	Cvars.Weapon[15029]	= Cvars.Weapon[13];	//Skinned Scattergun.			Backcountry Blaster.
	Cvars.Weapon[15030]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Bovine Blazemaker.
	Cvars.Weapon[15031]	= Cvars.Weapon[15];	//Skinned Minigun.				War Room.
	Cvars.Weapon[15032]	= Cvars.Weapon[16];	//Skinned SMG.					Treadplate Tormenter.
	Cvars.Weapon[15033]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Bogtrotter.
	Cvars.Weapon[15034]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Earth, Sky and Fire.
	Cvars.Weapon[15035]	= Cvars.Weapon[22];	//Skinned Pistol.				Hickory Holepuncher.
	Cvars.Weapon[15036]	= Cvars.Weapon[13];	//Skinned Scattergun.			Spruce Deuce.
	Cvars.Weapon[15037]	= Cvars.Weapon[16];	//Skinned SMG.					Team Sprayer.
	Cvars.Weapon[15038]	= Cvars.Weapon[20];	//Skinned Grenade Launcher.		Rooftop Wrangler.
	Cvars.Weapon[15040]	= Cvars.Weapon[15];	//Skinned Minigun.				Citizen Pain.
	Cvars.Weapon[15041]	= Cvars.Weapon[22];	//Skinned Pistol.				Local Hero.
	Cvars.Weapon[15042]	= Cvars.Weapon[24];	//Skinned Revolver.				Mayor.
	Cvars.Weapon[15043]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Smalltown Bringdown.
	Cvars.Weapon[15044]	= Cvars.Weapon[9];	//Skinned Shotgun.				Civic Duty.
	Cvars.Weapon[15045]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Liquid Asset.
	Cvars.Weapon[15046]	= Cvars.Weapon[22];	//Skinned Pistol.				Black Dahlia.
	Cvars.Weapon[15047]	= Cvars.Weapon[9];	//Skinned Shotgun.				Lightning Rod.
	Cvars.Weapon[15048]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Pink Elephant.
	Cvars.Weapon[15049]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Flash Fryer.
	Cvars.Weapon[15051]	= Cvars.Weapon[24];	//Skinned Revolver.				Dead Reckoner.
	Cvars.Weapon[15052]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Shell Shocker.
	Cvars.Weapon[15053]	= Cvars.Weapon[13];	//Skinned Scattergun.			Current Event.
	Cvars.Weapon[15054]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Turbine Torcher.
	Cvars.Weapon[15055]	= Cvars.Weapon[15];	//Skinned Minigun.				Brick House.
	Cvars.Weapon[15056]	= Cvars.Weapon[22];	//Skinned Pistol.				Sandstone Special.
	Cvars.Weapon[15057]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Aqua Marine.
	Cvars.Weapon[15058]	= Cvars.Weapon[16];	//Skinned SMG.					Low Profile.
	Cvars.Weapon[15059]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Thunderbolt.
	Cvars.Weapon[15060]	= Cvars.Weapon[22];	//Skinned Pistol.				Macabre Web.
	Cvars.Weapon[15061]	= Cvars.Weapon[22];	//Skinned Pistol.				Nutcracker.
	Cvars.Weapon[15062]	= Cvars.Weapon[24];	//Skinned Revolver.				Boneyard.
	Cvars.Weapon[15063]	= Cvars.Weapon[24];	//Skinned Revolver.				Wildwood.
	Cvars.Weapon[15064]	= Cvars.Weapon[24];	//Skinned Revolver.				Macabre Web.
	Cvars.Weapon[15065]	= Cvars.Weapon[13];	//Skinned Scattergun.			Macabre Web.
	Cvars.Weapon[15066]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Autumn.
	Cvars.Weapon[15067]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Pumpkin Patch.
	Cvars.Weapon[15068]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Nutcracker.
	Cvars.Weapon[15069]	= Cvars.Weapon[13];	//Skinned Scattergun.			Nutcracker.
	Cvars.Weapon[15070]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Pumpkin Patch.
	Cvars.Weapon[15071]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Boneyard.
	Cvars.Weapon[15072]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Wildwood.
	Cvars.Weapon[15073]	= Cvars.Weapon[7];	//Skinned Wrench.				Nutcracker.
	Cvars.Weapon[15074]	= Cvars.Weapon[7];	//Skinned Wrench.				Autumn.
	Cvars.Weapon[15075]	= Cvars.Weapon[7];	//Skinned Wrench.				Boneyard.
	Cvars.Weapon[15076]	= Cvars.Weapon[16];	//Skinned SMG.					Wildwood.
	Cvars.Weapon[15077]	= Cvars.Weapon[19];	//Skinned Grenade Launcher.		Autumn.
	Cvars.Weapon[15079]	= Cvars.Weapon[19];	//Skinned Grenade Launcher.		Macabre Web.
	Cvars.Weapon[15081]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Autumn.
	Cvars.Weapon[15082]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Autumn.
	Cvars.Weapon[15083]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Pumpkin Patch.
	Cvars.Weapon[15084]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Macabre Web.
	Cvars.Weapon[15085]	= Cvars.Weapon[9];	//Skinned Shotgun.				Autumn.
	Cvars.Weapon[15086]	= Cvars.Weapon[15];	//Skinned Minigun.				Macabre Web.
	Cvars.Weapon[15087]	= Cvars.Weapon[15];	//Skinned Minigun.				Pumpkin Patch.
	Cvars.Weapon[15088]	= Cvars.Weapon[15];	//Skinned Minigun.				Nutcracker.
	Cvars.Weapon[15089]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Balloonicorn.
	Cvars.Weapon[15090]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Rainbow.
	Cvars.Weapon[15091]	= Cvars.Weapon[19];	//Skinned Grenade Launcher.		Rainbow.
	Cvars.Weapon[15092]	= Cvars.Weapon[19];	//Skinned Grenade Launcher.		Sweet Dreams.
	Cvars.Weapon[15094]	= Cvars.Weapon[4];	//Skinned Knife.				Blue Mew.
	Cvars.Weapon[15095]	= Cvars.Weapon[4];	//Skinned Knife.				Brain Candy.
	Cvars.Weapon[15096]	= Cvars.Weapon[4];	//Skinned Knife.				Stabbed To Hell.
	Cvars.Weapon[15098]	= Cvars.Weapon[15];	//Skinned Minigun.				Brain Candy.
	Cvars.Weapon[15099]	= Cvars.Weapon[15];	//Skinned Minigun.				Mister Cuddles.
	Cvars.Weapon[15100]	= Cvars.Weapon[22];	//Skinned Pistol.				Blue Mew.
	Cvars.Weapon[15101]	= Cvars.Weapon[22];	//Skinned Pistol.				Brain Candy.
	Cvars.Weapon[15102]	= Cvars.Weapon[22];	//Skinned Pistol.				Shot To Hell.
	Cvars.Weapon[15103]	= Cvars.Weapon[24];	//Skinned Revolver.				Flower Power.
	Cvars.Weapon[15104]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Blue Mew.
	Cvars.Weapon[15105]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Brain Candy.
	Cvars.Weapon[15106]	= Cvars.Weapon[13];	//Skinned Scattergun.			Bluw Mew.
	Cvars.Weapon[15107]	= Cvars.Weapon[13];	//Skinned Scattergun.			Flower Power.
	Cvars.Weapon[15108]	= Cvars.Weapon[13];	//Skinned Scattergun.			Shot to Hell.
	Cvars.Weapon[15109]	= Cvars.Weapon[9];	//Skinned Shotgun.				Flower Power.
	Cvars.Weapon[15110]	= Cvars.Weapon[15];	//Skinned SMG.					Blue Mew.
	Cvars.Weapon[15111]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Balloonicorn.
	Cvars.Weapon[15112]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Rainbow.
	Cvars.Weapon[15113]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Sweet Dreams.
	Cvars.Weapon[15114]	= Cvars.Weapon[7];	//Skinned Wrench.				Torqued To Hell.
	Cvars.Weapon[15115]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Coffin Nail.
	Cvars.Weapon[15116]	= Cvars.Weapon[19];	//Skinned Grenade Launcher.		Coffin Nail.
	Cvars.Weapon[15117]	= Cvars.Weapon[19];	//Skinned Grenade Launcher.		Top Shelf.
	Cvars.Weapon[15118]	= Cvars.Weapon[4];	//Skinned Knife.				Dressed To Kill.
	Cvars.Weapon[15119]	= Cvars.Weapon[4];	//Skinned Knife.				Top Shelf.
	Cvars.Weapon[15123]	= Cvars.Weapon[15];	//Skinned Minigun.				Coffin Nail.
	Cvars.Weapon[15124]	= Cvars.Weapon[15];	//Skinned Minigun.				Dressed To Kill.
	Cvars.Weapon[15125]	= Cvars.Weapon[15];	//Skinned Minigun.				Top Shelf.
	Cvars.Weapon[15126]	= Cvars.Weapon[22];	//Skinned Pistol.				Dressed To Kill.
	Cvars.Weapon[15127]	= Cvars.Weapon[24];	//Skinned Revolver.				Top Shelf.
	Cvars.Weapon[15128]	= Cvars.Weapon[24];	//Skinned Revolver.				Top Shelf.
	Cvars.Weapon[15129]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Coffin Nail.
	Cvars.Weapon[15130]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		High Roller's.
	Cvars.Weapon[15131]	= Cvars.Weapon[13];	//Skinned Scattergun.			Coffin Nail.
	Cvars.Weapon[15132]	= Cvars.Weapon[9];	//Skinned Shotgun.				Coffin Nail.
	Cvars.Weapon[15133]	= Cvars.Weapon[9];	//Skinned Shotgun.				Dressed To Kill.
	Cvars.Weapon[15134]	= Cvars.Weapon[16];	//Skinned SMG.					High Roller's.
	Cvars.Weapon[15135]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Coffin Nail.
	Cvars.Weapon[15136]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Dressed To Kill.
	Cvars.Weapon[15137]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Coffin Nail.
	Cvars.Weapon[15138]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Dressed To Kill.
	Cvars.Weapon[15139]	= Cvars.Weapon[7];	//Skinned Wrench.				Dressed To Kill.
	Cvars.Weapon[15140]	= Cvars.Weapon[7];	//Skinned Wrench.				Top Shelf.
	Cvars.Weapon[15141]	= Cvars.Weapon[21];	//Skinned Flame Thrower.		Warhawk.
	Cvars.Weapon[15142]	= Cvars.Weapon[19];	//Skinned Grenade Launcher.		Warhawk.
	Cvars.Weapon[15143]	= Cvars.Weapon[4];	//Skinned Knife.				Blitzkrieg.
	Cvars.Weapon[15144]	= Cvars.Weapon[4];	//Skinned Knife.				Airwolf.
	Cvars.Weapon[15147]	= Cvars.Weapon[15];	//Skinned Minigun.				Butcher Bird.
	Cvars.Weapon[15148]	= Cvars.Weapon[22];	//Skinned Pistol.				Blitzkrieg.
	Cvars.Weapon[15149]	= Cvars.Weapon[24];	//Skinned Revolver.				Blitzkrieg.
	Cvars.Weapon[15050]	= Cvars.Weapon[18];	//Skinned Rocket Launcher.		Warhawk.
	Cvars.Weapon[15151]	= Cvars.Weapon[13];	//Skinned Scattergun.			Killer Bee.
	Cvars.Weapon[15152]	= Cvars.Weapon[9];	//Skinned Shotgun.				Red Bear.
	Cvars.Weapon[15153]	= Cvars.Weapon[16];	//Skinned SMG.					Blitzkrieg.
	Cvars.Weapon[15154]	= Cvars.Weapon[14];	//Skinned Sniper Rifle.			Airwolf.
	Cvars.Weapon[15155]	= Cvars.Weapon[20];	//Skinned Stickybomb Launcher.	Blitzkrieg.
	Cvars.Weapon[15156]	= Cvars.Weapon[7];	//Skinned Wrench.				Airwolf.
	Cvars.Weapon[15157]	= Cvars.Weapon[13];	//Skinned Scattergun.			Corsair.
	Cvars.Weapon[15158]	= Cvars.Weapon[19];	//Skinned Grenade Launcher.		Butcher Bird.
	Cvars.Weapon[19010]	= Cvars.Weapon[18];	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 1.
	Cvars.Weapon[19011]	= Cvars.Weapon[9];	//TF2Items Give Weapon: Beta Pocket Shotgun.
	Cvars.Weapon[19012]	= Cvars.Weapon[129];	//TF2Items Give Weapon: Beta Split Equalizer 1.
	Cvars.Weapon[19013]	= Cvars.Weapon[129];	//TF2Items Give Weapon: Beta Split Equalizer 2.
	Cvars.Weapon[19015]	= Cvars.Weapon[14];	//TF2Items Give Weapon: Beta Sniper Rifle 1.
	Cvars.Weapon[19016]	= Cvars.Weapon[18];	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 2.
	Cvars.Weapon[19017]	= Cvars.Weapon[18];	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 3.
	Cvars.Weapon[30474]	= CreateConVar("xstats_points_weapon_nostromonapalmer","10",	"Xstats: TF2 - Points given when killing with Nostromo Napalmer.", _, true);
	Cvars.Weapon[30665]	= CreateConVar("xstats_points_weapon_shootingstar",		"10",	"Xstats: TF2 - Points given when killing with Shooting star.", _, true);
	Cvars.Weapon[30666]	= CreateConVar("xstats_points_weapon_capper",			"10",	"Xstats: TF2 - Points given when killing with C.A.P.P.E.R.", _, true);
	Cvars.Weapon[30667]	= CreateConVar("xstats_points_weapon_batsaber",			"10",	"Xstats: TF2 - Points given when killing with Batsaber.", _, true);
	Cvars.Weapon[30668]	= CreateConVar("xstats_points_weapon_gigarcounter",		"10",	"Xstats: TF2 - Points given when killing with Gigar Counter.", _, true);
	Cvars.Weapon[30758]	= CreateConVar("xstats_points_weapon_prinnymachete",	"10",	"Xstats: TF2 - Points given when killing with Prinny Machete.", _, true);	
	
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
			Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
		}
	}
	
	if(count < 1)
		return; /* Nothing happens after this if count is below 1 */
	
	CPrintToChatAll("%s %t", Global.Prefix, "MVM Team Destroyed Tank", TF2_GetTeamStringName[2], points);
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
	Player[client].Points = GetClientPoints(Player[client].SteamID);
	
	Session[client].SentryBustersKilled++;
	AddSessionPoints(client, points);
	CPrintToChat(client, "%s %t", Global.Prefix, "MvM Kill Sentry Buster", Player[client].Name, Player[client].Points, points);
	
	char query[512];
	Format(query, sizeof(query), "update `%s` set Points = Points+%i, SentryBustersKilled = SentryBustersKilled+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
	DB.Threaded.Query(DBQuery_Callback, query);
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
	Player[client].Points = GetClientPoints(Player[client].SteamID);
	
	Session[client].BombsResetted++;
	AddSessionPoints(client, points);
	CPrintToChat(client, "%s %t", Global.Prefix, "MvM Player Reset Bomb", Player[client].Name, Player[client].Points, points);
	
	char query[512];
	Format(query, sizeof(query), "update `%s` set Points = Points+%i, BombsResetted = BombsResetted+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
	DB.Threaded.Query(DBQuery_Callback, query);
}

/* Item found */
stock void Item_Found_TF2(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!Cvars.ServerID.IntValue)
		return;

	if(event.GetBool("isfake"))	//Item is fake
		return; //This event bool doesn't exist in the game in general but you can force this event and use this.
	
	int client = event.GetInt(EVENT_STR_PLAYER);
	if(!Tklib_IsValidClient(client, true))
		return;
	
	int quality = event.GetInt(EVENT_STR_QUALITY);
	int method = event.GetInt(EVENT_STR_METHOD);
	int defindex = event.GetInt(EVENT_STR_ITEMDEF);
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
	len += Format(query[len], sizeof(query)-len, "insert into `%s`", Global.item_found);
	len += Format(query[len], sizeof(query)-len, "(ServerID, Playername, SteamID, QualityID, Quality, MethodID, Method, DefinitionIndex, Wear)");
	len += Format(query[len], sizeof(query)-len, "values");
	len += Format(query[len], sizeof(query)-len, "('%i', '%s', '%s', '%i', '%s', '%i', '%s', '%i', '%f')",
	Cvars.ServerID.IntValue, Player[client].Playername, Player[client].SteamID, quality, quality_name, method, method_name[method], defindex, wear);
	DB.Threaded.Query(DBQuery_Callback, query);
	
	XStats_DebugText(false, "Inserting (ServerID, Playername, SteamID, QualityID, Quality, MethodID, Method, DefinitionIndex, Wear) with values ('%i', '%s', '%s', '%i', '%s', '%i', '%s', '%i', '%f') onto %s",
	Cvars.ServerID.IntValue, Player[client].Playername, Player[client].SteamID, quality, quality_name, method, method_name[method], defindex, wear, Global.item_found);
}

/* Deaths */
stock void Player_Death_TF2(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats() || TF2_IsMvMGameMode())
		return;
	
	//It's a fake death.
	bool fakedeath = (event.GetInt(EVENT_STR_DEATH_FLAGS) == 32);
	event.SetBool("fakedeath", fakedeath);
	if(fakedeath)	{
		XStats_DebugText(false, "//===== Player_Death_TF2 =====//");
		XStats_DebugText(false, "Detected fake death, ignoring.");
		return;
	}
	
	char weapon[96];
	event.GetString(EVENT_STR_WEAPON_LOGCLASSNAME, weapon, sizeof(weapon));

	if(StrEqual(weapon, "player")
	|| StrEqual(weapon, "world"))
		return;	
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(client, true) || !Tklib_IsValidClient(victim))
		return;
	
	if(IsValidAbuse(client) || IsSamePlayers(client, victim) || IsSameTeam(client, victim) || IsFakeClient(victim) && !Cvars.AllowBots.BoolValue)
		return;
	
	OnDeathRankPanel(client);
	
	/* Get the values early for lowest delay. */
	
	int assist = GetClientOfUserId(event.GetInt(EVENT_STR_ASSISTER));
	int inflictor = event.GetInt(EVENT_STR_INFLICTOR_ENTINDEX);
	int defindex = event.GetInt(EVENT_STR_WEAPON_DEF_INDEX);
	int customkill = event.GetInt(EVENT_STR_CUSTOMKILL);
	int deathflags = event.GetInt(EVENT_STR_DEATH_FLAGS);
	int penetrated = event.GetInt(EVENT_STR_PLAYERPENETRATECOUNT);
	TFCritType crits = TFCritType(event.GetInt(EVENT_STR_CRIT_TYPE));
	int points = 0;
	
	/* Kill event stuff */
	bool headshot = (customkill == 1 || customkill == 51);
	event.SetBool("headshot", headshot);
	bool backstab = (customkill == 2);
	event.SetBool("backstab", backstab);
	bool noscope = (TF2_GetPlayerClass(client) == TFClass_Sniper && defindex != 56 && defindex != 1005 && defindex != 1092 && !TF2_IsPlayerInCondition(client, TFCond_Zoomed));
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
		XStats_DebugText(false, "Killer dominated");
	}
	event.SetBool("dominated", dominated);
	if(deathflags & 2)	{
		dominated_assister = true;
		XStats_DebugText(false, "Assister dominated");
	}
	event.SetBool("dominated_assister", dominated_assister);
	if(deathflags & 4)	{
		revenge = true;
		XStats_DebugText(false, "Killer revenged");
	}
	event.SetBool("revenge", revenge);
	if(deathflags & 8)	{
		revenge_assister = true;
		XStats_DebugText(false, "Assister revenged");
	}
	event.SetBool("revenge_assister", revenge);
	if(deathflags & 128 || deathflags & 129)	{
		gibkill = true;
		XStats_DebugText(false, "Gibkill");
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
	if(StrEqual(weapon, "ball", false)) {
		int getindex = 0;
		switch(TF2_GetPlayerClass(client)) {
			case TFClass_Scout:	getindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Melee)).DefinitionIndex;
			case TFClass_Pyro: {
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
	
	/* Make sure the weapon definition index exists on the array */
	if(Cvars.Weapon[defindex] == null)	{
		XStats_DebugText(false, "weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.", weapon, defindex);
		return;
	}
	
	/* Make sure to continue if the points are valid. */
	switch(TF2_GetBuildingType(inflictor))	{
		case TFBuilding_Sentrygun:	{
			if((points = TF2_SentryKill.IntValue) < 1)
				return;
		}
		case TFBuilding_MiniSentry:	{
			if((points = TF2_MiniSentryKill.IntValue) < 1)
				return;
		}
		default: {
			if((points = Cvars.Weapon[defindex].IntValue) < 1)
				return;
		}
	}
	
	/* The database query upload ("bat" -> "weapon_bat") */
	char fix_weapon[96];
	if(!telefrag)
		TF2_FixWeaponClassname(fix_weapon, sizeof(fix_weapon), defindex, weapon);
	
	/* Debug */
	XStats_DebugText(false, "//===== Player_Death_TF2 =====//");
	XStats_DebugText(false, "client %N (%i)", client, client);
	XStats_DebugText(false, "victim %N (%i)", victim, client);
	XStats_DebugText(false, "assist %N (%i)", Tklib_IsValidClient(assist) ? assist : 0, client);
	XStats_DebugText(false, "inflictor %i", inflictor);
	XStats_DebugText(false, " ");
	XStats_DebugText(false, "weapon \"%s\"", weapon);
	XStats_DebugText(false, "defindex %i", defindex);
	XStats_DebugText(false, "customkill %i", customkill);
	XStats_DebugText(false, "deathflags %i", deathflags);
	XStats_DebugText(false, "penetrated %i", penetrated);
	XStats_DebugText(false, " ");
	XStats_DebugText(false, "crit type \"%s\"", TF2_GetCritTypeName[crits]);
	XStats_DebugText(false, " ");
	XStats_DebugText(false, "Midair %s", Bool[midair]);
	XStats_DebugText(false, " ");
	XStats_DebugText(false, "Points %i", points);
	
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
	
	char query[1024];
	TF2_ClientKillVictim(client, victim);
	PrepareOnDeathForward(client, victim, assist, weapon, defindex);
	
	//There was an assist.
	if(AssistedKill(assist, client, victim))	{
		if(dominated_assister)	{
			Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID='%i'",
			Global.playerlist, Player[assist].SteamID, Cvars.ServerID.IntValue);
			DB.Threaded.Query(DBQuery_Callback, query);
		}
		
		if(revenge_assister)	{
			Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID='%i'",
			Global.playerlist, Player[assist].SteamID, Cvars.ServerID.IntValue);
			DB.Threaded.Query(DBQuery_Callback, query);
		}
	}
		
	//Make sure to not query updates on a bot, the database wouldn't be happy about that.
	VictimDied(victim);
		
	Session[client].Kills++;
	Format(query, sizeof(query), "update `%s` set Kills = Kills+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	DB.Threaded.Query(DBQuery_Callback, query);
		
	//If the inflictor entity is a building.
	switch(TF2_IsEntityBuilding(inflictor))	{
		case true:	{
			switch(TF2_GetBuildingType(inflictor))	{
				case TFBuilding_Dispenser:	{
					XStats_DebugText(false, " ");
					XStats_DebugText(false, "Building: Dispenser (?!)");
				}
				case TFBuilding_Sentrygun:	{
					Session[client].MiniSentryKills++;
					Format(query, sizeof(query), "update `%s` set SentryKills = SentryKills+1 where SteamID='%s' and ServerID='%i'",
					Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
					DB.Threaded.Query(DBQuery_Callback, query);
					XStats_DebugText(false, " ");
					XStats_DebugText(false, "Building: Sentry");
				}
				case TFBuilding_MiniSentry:	{
					Session[client].SentryKills++;
					Format(query, sizeof(query), "update `%s` set MiniSentryKills = MiniSentryKills+1 where SteamID='%s' and ServerID='%i'",
					Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
					DB.Threaded.Query(DBQuery_Callback, query);
					XStats_DebugText(false, " ");
					XStats_DebugText(false, "Building: Mini-Sentry");
				}
			}
		}
		case false:	{
			switch(telefrag)	{
				case true:	{
					Session[client].TeleFrags++;
					points += TF2_TeleFrag.IntValue;
					AddSessionPoints(client, TF2_TeleFrag.IntValue);
					Format(query, sizeof(query), "update `%s` set TeleFrags = TeleFrags+1 where SteamID='%s' and ServerID='%i'",
					Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
					DB.Threaded.Query(DBQuery_Callback, query);
					XStats_DebugText(false, " ");
					XStats_DebugText(false, "Telefrag");
				}
				case false:	{
					Format(query, sizeof(query), "update `%s` set Kills_%s = Kills_%s+1 where SteamID='%s' and ServerID='%i'",
					Global.playerlist, fix_weapon, fix_weapon, Player[client].SteamID, Cvars.ServerID.IntValue);
					DB.Threaded.Query(DBQuery_Callback, query);
					XStats_DebugText(false, "Updating kill for weapon \"%s\" (Definition index %i) for %s", fix_weapon, defindex, Player[client].Playername);
				}
			}
		}
	}
	
	if(headshot)	{
		Session[client].Headshots++;
		Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Headshot");
	}
		
	if(backstab)	{
		Session[client].Backstabs++;
		Format(query, sizeof(query), "update `%s` set Backstabs = Backstabs+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Backstab");
	}
		
	if(dominated)	{
		Session[client].Dominations++;
		Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Dominated");
	}
		
	if(revenge)	{
		Session[client].Revenges++;
		Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Revenge");
	}
		
	if(noscope)	{
		Session[client].Noscopes++;
		Format(query, sizeof(query), "update `%s` set Noscopes = Noscopes+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Noscope");
	}
		
	if(tauntkill)	{
		Session[client].TauntKills++;
		Format(query, sizeof(query), "update `%s` set TauntKills = TauntKills+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Tauntkill");
	}
	
	if(deflectkill)	{
		Session[client].DeflectKills++;
		Format(query, sizeof(query), "update `%s` set DeflectKills = DeflectKills+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Deflectkill");
	}
	
	if(gibkill)	{
		Session[client].GibKills++;
		Format(query, sizeof(query), "update `%s` set GibKills = GibKills+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Gibkill");
	}
	
	if(airshot)	{
		Session[client].Airshots++;
		Format(query, sizeof(query), "update `%s` set Airshots = Airshots+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Airshot");
	}
	
	if(collateral)	{
		Session[client].Collaterals++;
		Format(query, sizeof(query), "update `%s` set Collaterals = Collaterals+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		
		if(TF2_Collat.IntValue > 0)
			points += TF2_Collat.IntValue;
		
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Collateral");
	}
	
	if(midair)	{
		Session[client].MidAirKills++;
		Format(query, sizeof(query), "update `%s` set MidAirKills = MidAirKills+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "MidAir Kill");
	}
		
	switch(crits)	{
		case	TFCritType_Minicrit:	{
			Session[client].MiniCritKills++;
			Format(query, sizeof(query), "update `%s` set MiniCritKills = MiniCritKills+1 where SteamID='%s' and ServerID='%i'",
			Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
			DB.Threaded.Query(DBQuery_Callback, query);
			XStats_DebugText(false, " ");
			XStats_DebugText(false, "Mini-Crit");
		}
		case	TFCritType_Crit:	{
			Session[client].CritKills++;
			Format(query, sizeof(query), "update `%s` set CritKills = CritKills+1 where SteamID='%s' and ServerID='%i'",
			Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
			DB.Threaded.Query(DBQuery_Callback, query);
			XStats_DebugText(false, " ");
			XStats_DebugText(false, "Crit");
		}
	}
	
	if(points > 0)	{
		AddSessionPoints(client, points);
		XStats_DebugText(false, " ");
		XStats_DebugText(false, "Processing kill message..");
		
		Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s' and ServerID='%i'",
		Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
		DB.Threaded.Query(DBQuery_Callback, query);
		
		PrepareKillMessage(client, victim, points);
	}
		
	if(!IsFakeClient(victim))	{
		char log[2048];
		int len = 0;
		len += Format(log[len], sizeof(log)-len, "insert into `%s`", Global.kill_log);
		len += Format(log[len], sizeof(log)-len, "(ServerID, Time, Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, Midair, CritType)");
		len += Format(log[len], sizeof(log)-len, "values");
		len += Format(log[len], sizeof(log)-len, "('%i', '%i', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', '%i', '%i')",
		Cvars.ServerID.IntValue, GetTime(), Player[client].Playername, Player[client].SteamID, Player[victim].Playername, Player[victim].SteamID, Player[assist].Playername, Player[assist].SteamID, fix_weapon, headshot, noscope, midair, crits);
		DB.Threaded.Query(DBQuery_Kill_Log, log);
		
		XStats_DebugText(false, "Inserting (ServerID, Time, Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, Midair, CritType) values ('%i', '%i', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', '%i', '%i') into %s",
		Cvars.ServerID.IntValue, GetTime(), Player[client].Playername, Player[client].SteamID, Player[victim].Playername, Player[victim].SteamID, Player[assist].Playername, Player[assist].SteamID, fix_weapon, headshot, noscope, midair, crits, Global.kill_log);
	}
}