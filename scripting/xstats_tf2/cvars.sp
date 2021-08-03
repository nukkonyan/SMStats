//Points decieved from the victim that died.
ConVar	Kill_Class[10];

//Points you recieve for a kill event.
ConVar	Kill_Event[10];

//Points you recieve for killing with a weapon. (The number is the weapon index.)
ConVar	Kill_Weapon[40000];

//Points to recieve/decieve on ctf flag event.
ConVar	CTF_Event[10];

//Points to recieve/decieve on control point event.
ConVar	CP_Event[10];

//Points to recieve/decieve on mvm event.
ConVar	MvM_Event[10];

//Points for coating the enemy.
ConVar	OnPlayerJarated[15000];

//Points for extinguishing the teammate.
ConVar	OnPlayerExtinguished[35000];

//Points for ubercharging the teammate/enemy spy.
ConVar	OnPlayerUbercharged[35000], OnPlayerUbercharged_Spy;

//Points for stealing a sandvich.
ConVar	SandvichStolen;

//Points related to buildings and/or objects.
ConVar	Building_Event[10];

//Other features.
ConVar	Feature[10], CritTexts[3];

//================================================================================================//
// Better to use convar arrays than separate, cleaner code & faster responsivness.
//================================================================================================//

void LoadCvars()	{
	//Class death points.
	Kill_Class[1]		=	CreateConVar("xstats_death_scout",					"15",	"Xstats - Points taken when killed as a Scout. 0 Disables this.",		_,	true,	0.0);
	Kill_Class[3]		=	CreateConVar("xstats_death_soldier",				"15",	"Xstats - Points taken when killed as a Soldier. 0 Disables this.",		_,	true,	0.0);
	Kill_Class[7]		=	CreateConVar("xstats_death_pyro",					"15",	"Xstats - Points taken when killed as a Pyro. 0 Disables this.",		_,	true,	0.0);
	Kill_Class[4]		=	CreateConVar("xstats_death_demoman",				"15",	"Xstats - Points taken when killed as a Demoman. 0 Disables this.",		_,	true,	0.0);
	Kill_Class[6]		=	CreateConVar("xstats_death_heavy",					"15",	"Xstats - Points taken when killed as a Heavy. 0 Disables this.",		_,	true,	0.0);
	Kill_Class[9]		=	CreateConVar("xstats_death_engineer",				"15",	"Xstats - Points taken when killed as a Engineer. 0 Disables this.",	_,	true,	0.0);
	Kill_Class[5]		=	CreateConVar("xstats_death_medic",					"15",	"Xstats - Points taken when killed as a Medic. 0 Disables this.",		_,	true,	0.0);
	Kill_Class[2]		=	CreateConVar("xstats_death_sniper",					"15",	"Xstats - Points taken when killed as a Sniper. 0 Disables this",		_,	true,	0.0);
	Kill_Class[8]		=	CreateConVar("xstats_death_spy",					"15",	"Xstats - Points taken when killed as a Spy. 0 Disables this.",			_,	true,	0.0);
	
	//Kill event points.
	Kill_Event[1]		=	CreateConVar("xstats_kill_assist",					"5",	"Xstats - Points given upon an assist. 0 Disables this.",				_,	true,	0.0);
	Kill_Event[2]		=	CreateConVar("xstats_kill_headshot",				"10",	"Xstats - Points given upon a headshot. 0 Disable this.",				_,	true,	0.0);
	Kill_Event[3]		=	CreateConVar("xstats_kill_backstab",				"10",	"Xstats - Points given upon a backstab. 0 Disables this.",				_,	true,	0.0);
	Kill_Event[4]		=	CreateConVar("xstats_kill_noscope",					"5",	"Xstats - Points given upon a noscope. 0 Disables this.",				_,	true,	0.0);
	Kill_Event[5]		=	CreateConVar("xstats_kill_domination",				"2",	"Xstats - Points given upon a domination on target. 0 Disables this.",	_,	true,	0.0);
	Kill_Event[6]		=	CreateConVar("xstats_kill_revenge",					"2",	"Xstats - Points given upon a revenge on target. 0 Disables this.",		_,	true,	0.0);
	Kill_Event[7]		=	CreateConVar("xstats_kill_suicide",					"5",	"Xstats - Points taken upon suiciding. 0 Disables this.",				_,	true,	0.0);
	Kill_Event[8]		=	CreateConVar("xstats_kill_tauntkilling",			"2",	"Xstats - Points given upon a tauntkill. 0 Disables this.",				_,	true,	0.0);
	Kill_Event[9]		=	CreateConVar("xstats_kill_airshot",					"0",	"Xstats - Points given upon an airshot. 0 Disables this.",				_,	true,	0.0);
	
	//Weapon kill points.
	Kill_Weapon[0]		=	CreateConVar("xstats_points_bat",					"10",	"Xstats - Points given upon killing with the bat.",						_,	true,	0.0);
	Kill_Weapon[1]		=	CreateConVar("xstats_points_bottle",				"10",	"Xstats - Points given upon killing with the bottle.",					_,	true,	0.0);
	Kill_Weapon[2]		=	CreateConVar("xstats_points_fireaxe",				"10",	"Xstats - Points given upon killing with the fire axe.",				_,	true,	0.0);
	Kill_Weapon[3]		=	CreateConVar("xstats_points_kukri",					"10",	"Xstats - Points given upon killing with the kukri.",					_,	true,	0.0);
	Kill_Weapon[4]		=	CreateConVar("xstats_points_knife",					"10",	"Xstats - Points given upon killing with the knife.",					_,	true,	0.0);
	Kill_Weapon[5]		=	CreateConVar("xstats_points_fists",					"10",	"Xstats - Points given upon killing with the fists",					_,	true,	0.0);
	Kill_Weapon[6]		=	CreateConVar("xstats_points_shovel",				"10",	"Xstats - Points given upon killing with the shovel.",					_,	true,	0.0);
	Kill_Weapon[7]		=	CreateConVar("xstats_points_wrench",				"10",	"Xstats - Points given upon killing with the wrench.",					_,	true,	0.0);
	Kill_Weapon[8]		=	CreateConVar("xstats_points_bonesaw",				"10",	"Xstats - Points given upon killing with the bonesaw.",					_,	true,	0.0);
	Kill_Weapon[9]		=	CreateConVar("xstats_points_shotgun",				"10",	"Xstats - Points given upon killing with the shotgun.",					_,	true,	0.0);
	Kill_Weapon[10]		=	Kill_Weapon[9];		//Same Shotgun, different TFClass type.
	Kill_Weapon[11]		=	Kill_Weapon[9];		//Same Shotgun, different TFClass type.
	Kill_Weapon[12]		=	Kill_Weapon[9];		//Same Shotgun, different TFClass type.
	Kill_Weapon[13]		=	CreateConVar("xstats_points_scattergun",			"10",	"Xstats - Points given upon killing with the scattergun.",				_,	true,	0.0);
	Kill_Weapon[14]		=	CreateConVar("xstats_points_sniperrifle",			"10",	"Xstats - Points given upon killing with the sniper rifle.",			_,	true,	0.0);
	Kill_Weapon[15]		=	CreateConVar("xstats_points_minigun",				"10",	"Xstats - Points given upon killing with the minigun.",					_,	true,	0.0);
	Kill_Weapon[16]		=	CreateConVar("xstats_points_smg",					"10",	"Xstats - Points given upon killing with the smg.",						_,	true,	0.0);
	Kill_Weapon[17]		=	CreateConVar("xstats_points_syringegun",			"10",	"Xstats - Points given upon killing with the syringe gun.",				_,	true,	0.0);
	Kill_Weapon[18]		=	CreateConVar("xstats_points_rocketlauncher",		"10",	"Xstats - Points given upon killing with the rocket launcher.",			_,	true,	0.0);
	Kill_Weapon[19]		=	CreateConVar("xstats_points_grenadelauncher",		"10",	"Xstats - Points given upon killing with the grenade launcher.",		_,	true,	0.0);
	Kill_Weapon[20]		=	CreateConVar("xstats_points_stickybomblauncher",	"10",	"Xstats - Points given upon killing with the stickybomb launcher",		_,	true,	0.0);
	Kill_Weapon[21]		=	CreateConVar("xstats_points_flamethrower",			"10",	"Xstats - Points given upon killing with the flamethrower.",			_,	true,	0.0);
	Kill_Weapon[22]		=	CreateConVar("xstats_points_pistol",				"10",	"Xstats - Points given upon killing with the pistol.",					_,	true,	0.0);
	Kill_Weapon[23]		=	Kill_Weapon[22];	//Same Pistol, different TFClass type.
	Kill_Weapon[24]		=	CreateConVar("xstats_points_revolver",				"10",	"Xstats - Points given upon killing with the revolver.",				_,	true,	0.0);
	Kill_Weapon[36]		=	CreateConVar("xstats_points_blutsauger",			"10",	"Xstats - Points given upon killing with the blutsauger.",				_,	true,	0.0);
	Kill_Weapon[37]		=	CreateConVar("xstats_points_ubersaw",				"10",	"Xstats - Points given upon killing with the ubersaw.",					_,	true,	0.0);
	Kill_Weapon[38]		=	CreateConVar("xstats_points_axtinguisher",			"10",	"Xstats - Points given upon killing with the axtinguisher.",			_,	true,	0.0);
	Kill_Weapon[39]		=	CreateConVar("xstats_points_flaregun",				"10",	"Xstats - Points given upon killing with the flaregun.",				_,	true,	0.0);
	Kill_Weapon[40]		=	CreateConVar("xstats_points_backburner",			"10",	"Xstats - Points given upon killing with the backburner.",				_,	true,	0.0);
	Kill_Weapon[41]		=	CreateConVar("xstats_points_natascha",				"10",	"Xstats - Points given upon killing with the natascha.",				_,	true,	0.0);
	Kill_Weapon[43]		=	CreateConVar("xstats_points_killerglovesofboxing",	"10",	"Xstats - Points given upon killing with the killer gloves of boxing",	_,	true,	0.0);
	Kill_Weapon[44]		=	CreateConVar("xstats_points_sandman",				"10",	"Xstats - Points given upon killing with the sandman.",					_,	true,	0.0);
	Kill_Weapon[45]		=	CreateConVar("xstats_points_forceanature",			"10",	"Xstats - Points given upon killing with the force-a-nature",			_,	true,	0.0);
	Kill_Weapon[56]		=	CreateConVar("xstats_points_huntsman",				"10",	"Xstats - Points given upon killing with the huntsman.",				_,	true,	0.0);
	Kill_Weapon[61]		=	CreateConVar("xstats_points_ambassador",			"10",	"Xstats - Points given upon killing with the ambassador.",				_,	true,	0.0);
	Kill_Weapon[127]	=	CreateConVar("xstats_points_directhit",				"10",	"Xstats - Points given upon killing with the direct hit.",				_,	true,	0.0);
	Kill_Weapon[128]	=	CreateConVar("xstats_points_equalizer",				"10",	"Xstats - Points given upon killing with the equalizer.",				_,	true,	0.0);
	Kill_Weapon[130]	=	CreateConVar("xstats_points_scottishresistance",	"10",	"Xstats - Points given upon killing with the scottish resistance.",		_,	true,	0.0);
	Kill_Weapon[131]	=	CreateConVar("xstats_points_chargentarge",			"10",	"Xstats - Points given upon killing with the charge n' targe",			_,	true,	0.0);
	Kill_Weapon[132]	=	CreateConVar("xstats_points_eyelander",				"10",	"Xstats - Points given upon killing with the eyelander.",				_,	true,	0.0);
	Kill_Weapon[140]	=	CreateConVar("xstats_points_wrangler",				"10",	"Xstats - Points given upon killing with the wrangler.",				_,	true,	0.0);
	Kill_Weapon[141]	=	CreateConVar("xstats_points_frontierjustice",		"10",	"Xstats - Points given upon killing with the wrangler.",				_,	true,	0.0);
	Kill_Weapon[142]	=	CreateConVar("xstats_points_gunslinger",			"10",	"Xstats - Points given upon killing with the gunslinger.",				_,	true,	0.0);
	Kill_Weapon[153]	=	CreateConVar("xstats_points_homewrecker",			"10",	"Xstats - Points given upon killing with the homewrecker.",				_,	true,	0.0);
	Kill_Weapon[154]	=	CreateConVar("xstats_points_paintrain",				"10",	"Xstats - Points given upon killing with the pain train.",				_,	true,	0.0);
	Kill_Weapon[155]	=	CreateConVar("xstats_points_southernhospitality",	"10",	"Xstats - Points given upon killing with the southern hospitality.",	_,	true,	0.0);
	Kill_Weapon[160]	=	CreateConVar("xstats_points_lugermorph",			"10",	"Xstats - Points given upon killing with the lugermorph",				_,	true,	0.0);
	Kill_Weapon[161]	=	CreateConVar("xstats_points_bigkill",				"10",	"Xstats - Points given upon killing with the big kill.",				_,	true,	0.0);
	Kill_Weapon[169]	=	CreateConVar("xstats_points_wrench",				"10",	"Xstats - Points given upon killing with the wrench.",					_,	true,	0.0);
	Kill_Weapon[171]	=	CreateConVar("xstats_points_tribalmansshiv",		"10",	"Xstats - Points given upon killing with the tribalman's shiv.",		_,	true,	0.0);
	Kill_Weapon[172]	=	CreateConVar("xstats_points_scotsmansskullcutter",	"10",	"Xstats - Points given upon killing with the scotsman's skullcutter.",	_,	true,	0.0);
	Kill_Weapon[173]	=	CreateConVar("xstats_points_vitasaw",				"10",	"Xstats - Points given upon killing with the vita saw.",				_,	true,	0.0);
	Kill_Weapon[190]	=	Kill_Weapon[0];		//Same as default Bat, used for strange, renamed & skinned versions.
	Kill_Weapon[191]	=	Kill_Weapon[1];		//Same as default Bottle, used for strange, renamed & skinned versions.
	Kill_Weapon[192]	=	Kill_Weapon[2];		//Same as default Fire Axe, used for strange, renamed & skinned versions.
	Kill_Weapon[193]	=	Kill_Weapon[3];		//Same as default Kukri, used for strange, renamed & skinned versions.
	Kill_Weapon[194]	=	Kill_Weapon[4];		//Same as default Knife, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[195]	=	Kill_Weapon[5];		//Same as default Fists, used for strange & renamed version.
	Kill_Weapon[196]	=	Kill_Weapon[6];		//Same as default Shovel, used for strange, renamed & skinned versions.
	Kill_Weapon[197]	=	Kill_Weapon[7];		//Same as default Wrench, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[198]	=	Kill_Weapon[8];		//Same as default Bonesaw, used for strange, renamed & skinned versions.
	Kill_Weapon[199]	=	Kill_Weapon[9];		//Same as default Shotgun, used for strange, renamed & skinned versions.
	Kill_Weapon[200]	=	Kill_Weapon[13];	//Same as default Scattergun, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[201]	=	Kill_Weapon[14];	//Same as default Sniper Rifle, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[202]	=	Kill_Weapon[15];	//Same as default Minigun, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[203]	=	Kill_Weapon[16];	//Same as default SMG, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[204]	=	Kill_Weapon[17];	//Same as default Syringe gun, used for strange, renamed & skinned versions.
	Kill_Weapon[205]	=	Kill_Weapon[18];	//Same as default Rocket Launcher, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[206]	=	Kill_Weapon[19];	//Same as default Grenade Launcher, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[207]	=	Kill_Weapon[20];	//Same as default Stickybomb Launcher, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[208]	=	Kill_Weapon[21];	//Same as default Flamethrower, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[209]	=	Kill_Weapon[22];	//Same as default Pistol, used for strange, renamed & skinned versions.
	Kill_Weapon[210]	=	Kill_Weapon[24];	//Same as default Revolver, used for strange, renamed & skinned versions.
	Kill_Weapon[211]	=	Kill_Weapon[29];	//Same as default Medigun, used for australium, strange, renamed & skinned versions.
	Kill_Weapon[214]	=	CreateConVar("xstats_points_powerjack",				"10",	"Xstats - Points given upon killing with the Power Jack.",				_,	true,	0.0);
	Kill_Weapon[215]	=	CreateConVar("xstats_points_degreaser",				"10",	"Xstats - Points given upon killing with the Degreaser.",				_,	true,	0.0);
	Kill_Weapon[220]	=	CreateConVar("xstats_points_shortstop",				"10",	"Xstats - Points given upon killing with the Shortstop",				_,	true,	0.0);
	Kill_Weapon[221]	=	CreateConVar("xstats_points_holymackerel",			"10",	"Xstats - Points given upon killing with the Holy Mackerel.",			_,	true,	0.0);
	Kill_Weapon[224]	=	CreateConVar("xstats_points_letranger",				"10",	"Xstats - Points given upon killing with the L'etranger.",				_,	true,	0.0);
	Kill_Weapon[225]	=	CreateConVar("xstats_points_eternalreward",			"10",	"Xstats - Points given upon killing with the Eternal Reward.",			_,	true,	0.0);
	Kill_Weapon[228]	=	CreateConVar("xstats_points_blackbox",				"10",	"Xstats - Points given upon killing with the Black Box.",				_,	true,	0.0);
	Kill_Weapon[230]	=	CreateConVar("xstats_points_sydneysleeper",			"10",	"Xstats - Points given upon killing with the Sydney Sleeper.",			_,	true,	0.0);
	Kill_Weapon[232]	=	CreateConVar("xstats_points_bushwacka",				"10",	"Xstats - Points given upon killing with the Bushwacka.",				_,	true,	0.0);
	Kill_Weapon[237]	=	Kill_Weapon[18];	//Rocket Jumper.
	Kill_Weapon[239]	=	CreateConVar("xstats_points_goru",					"10",	"Xstats - Points given upon killing with the Gloves of Running Urgently.",	_,	true,	0.0);
	Kill_Weapon[264]	=	CreateConVar("xstats_points_fryingpan",				"10",	"Xstats - Points given upon killing with the Frying Pan.",				_,	true,	0.0);
	Kill_Weapon[265]	=	Kill_Weapon[20];	//Sticky Jumper.
	Kill_Weapon[266]	=	CreateConVar("xstats_points_hhhh",					"10",	"Xstats - Points given upon killing with the Horseless Headless Horsemann's Headtaker",		_,	true,	0.0);
	Kill_Weapon[294]	=	Kill_Weapon[160];	//Same Lugermorph, different TFClass type.
	Kill_Weapon[298]	=	CreateConVar("xstats_points_ironcurtain",			"10",	"Xstats - Points given upon killing with the Iron Curtain.",			_,	true,	0.0);
	Kill_Weapon[304]	=	CreateConVar("xstats_points_amputator",				"10",	"Xstats - Points given upon killing with the Amputator.",				_,	true,	0.0);
	Kill_Weapon[305]	=	CreateConVar("xstats_points_crusaderscrossbow",		"10",	"Xstats - Points given upon killing with the Crusader's Crossbow.",		_,	true,	0.0);
	Kill_Weapon[307]	=	CreateConVar("xstats_points_ullapoolcaber",			"10",	"Xstats - Points given upon killing with the Ullapool Caber.",			_,	true,	0.0);
	Kill_Weapon[308]	=	CreateConVar("xstats_points_lochnload",				"10",	"Xstats - Points given upon killing with the Loch-n-Load.",				_,	true,	0.0);
	Kill_Weapon[310]	=	CreateConVar("xstats_points_warriorsspirit",		"10",	"Xstats - Points given upon killing with the Warrior's Spirit.",		_,	true,	0.0);
	Kill_Weapon[312]	=	CreateConVar("xstats_points_brassbeast",			"10",	"Xstats - Points given upon killing with the Brass Beast.",				_,	true,	0.0);
	Kill_Weapon[317]	=	CreateConVar("xstats_points_candycane",				"10",	"Xstats - Points given upon killing with the Candy Cane.",				_,	true,	0.0);
	Kill_Weapon[325]	=	CreateConVar("xstats_points_bostonbasher",			"10",	"Xstats - Points given upon killing with the Boston Basher.",			_,	true,	0.0);
	Kill_Weapon[326]	=	CreateConVar("xstats_points_backscratcher",			"10",	"Xstats - Points given upon killing with the Back Scratcher.",			_,	true,	0.0);
	Kill_Weapon[327]	=	CreateConVar("xstats_points_claidheamhmor",			"10",	"Xstats - Points given upon killing with the Claidheamh Mór.",			_,	true,	0.0);
	Kill_Weapon[329]	=	CreateConVar("xstats_points_jag",					"10",	"Xstats - Points given upon killing with the Jag.",						_,	true,	0.0);
	Kill_Weapon[331]	=	CreateConVar("xstats_points_fistsofsteel",			"10",	"Xstats - Points given upon killing with the Fists Of Steel.",			_,	true,	0.0);
	Kill_Weapon[348]	=	CreateConVar("xstats_points_sharpenedvolcanofragment",	"10",	"Xstats - Points given upon killing with the Sharpened Volcano Fragment.",	_,	true,	0.0);
	Kill_Weapon[349]	=	CreateConVar("xstats_points_sunonastick",			"10",	"Xstats - Points given upon killing with the Sun-On-A-Stick.",			_,	true,	0.0);
	Kill_Weapon[351]	=	CreateConVar("xstats_points_detonator",				"10",	"Xstats - Points given upon killing with the Detonator.",				_,	true,	0.0);
	Kill_Weapon[355]	=	CreateConVar("xstats_points_fanowar",				"10",	"Xstats - Points given upon killing with the Fan O' War.",				_,	true,	0.0);
	Kill_Weapon[356]	=	CreateConVar("xstats_points_conniverskunai",		"10",	"Xstats - Points given upon killing with the Conniver's Kunai.",		_,	true,	0.0);
	Kill_Weapon[357]	=	CreateConVar("xstats_points_halfzatoichi",			"10",	"Xstats - Points given upon killing with the Half-Zatoichi.",			_,	true,	0.0);
	Kill_Weapon[401]	=	CreateConVar("xstats_points_shahanshah",			"10",	"Xstats - Points given upon killing with the Shahanshah.",				_,	true,	0.0);
	Kill_Weapon[402]	=	CreateConVar("xstats_points_bazaarbargain",			"10",	"Xstats - Points given upon killing with the Bazaar Bargain.",			_,	true,	0.0);
	Kill_Weapon[404]	=	CreateConVar("xstats_points_persainpersuader",		"10",	"Xstats - Points given upon killing with the Persain Pursuader.",		_,	true,	0.0);
	Kill_Weapon[406]	=	CreateConVar("xstats_points_splendidscreen",		"10",	"Xstats - Points given upon killing with the Splendid Screen.",			_,	true,	0.0);
	Kill_Weapon[412]	=	CreateConVar("xstats_points_overdose",				"10",	"Xstats - Points given upon killing with the Overdose.",				_,	true,	0.0);
	Kill_Weapon[413]	=	CreateConVar("xstats_points_solemnvow",				"10",	"Xstats - Points given upon killing with the Solmen Wov.",				_,	true,	0.0);
	Kill_Weapon[414]	=	CreateConVar("xstats_points_libertylauncher",		"10",	"Xstats - Points given upon killing with the Liberty Launcher.",		_,	true,	0.0);
	Kill_Weapon[415]	=	CreateConVar("xstats_points_reserveshooter",		"10",	"Xstats - Points given upon killing with the Reserve Shooter.",			_,	true,	0.0);
	Kill_Weapon[416]	=	CreateConVar("xstats_points_marketgardener",		"10",	"Xstats - Points given upon killing with the Market Gardener.",			_,	true,	0.0);
	Kill_Weapon[423]	=	CreateConVar("xstats_points_saxxy",					"10",	"Xstats - Points given upon killing with the Saxxy.",					_,	true,	0.0);
	Kill_Weapon[424]	=	CreateConVar("xstats_points_tomislav",				"10",	"Xstats - Points given upon killing with the Tomislav.",				_,	true,	0.0);
	Kill_Weapon[425]	=	CreateConVar("xstats_points_familybusiness",		"10",	"Xstats - Points given upon killing with the Family Business.",			_,	true,	0.0);
	Kill_Weapon[426]	=	CreateConVar("xstats_points_evictionnotice",		"10",	"Xstats - Points given upon killing with the Eviction Notice.",			_,	true,	0.0);
	Kill_Weapon[441]	=	CreateConVar("xstats_points_cowmangler5000",		"10",	"Xstats - Points given upon killing with the Cow Mangler 5000",			_,	true,	0.0);
	Kill_Weapon[442]	=	CreateConVar("xstats_points_righteousbison",		"10",	"Xstats - Points given upon killing with the Righteous Bison.",			_,	true,	0.0);
	Kill_Weapon[444]	=	CreateConVar("xstats_points_mantreads",				"10",	"Xstats - Points given upon killing with the Mantreads.",				_,	true,	0.0);
	Kill_Weapon[447]	=	CreateConVar("xstats_points_disciplinaryaction",	"10",	"Xstats - Points given upon killing with the Disciplinary Action.",		_,	true,	0.0);
	Kill_Weapon[448]	=	CreateConVar("xstats_points_sodapopper",			"10",	"Xstats - Points given upon killing with the Soda Popper.",				_,	true,	0.0);
	Kill_Weapon[449]	=	CreateConVar("xstats_points_winger",				"10",	"Xstats - Points given upon killing with the Winger.",					_,	true,	0.0);
	Kill_Weapon[450]	=	CreateConVar("xstats_points_atomizer",				"10",	"Xstats - Points given upon killing with the Atomizer.",				_,	true,	0.0);
	Kill_Weapon[452]	=	CreateConVar("xstats_points_threeruneblade",		"10",	"Xstats - Points given upon killing with the Three Rune Blade.",		_,	true,	0.0);
	Kill_Weapon[457]	=	CreateConVar("xstats_points_postalpummeler",		"10",	"Xstats - Points given upon killing with the Postal Pummeler.",			_,	true,	0.0);
	Kill_Weapon[460]	=	CreateConVar("xstats_points_enforcer",				"10",	"Xstats - Points given upon killing with the Enforcer.",				_,	true,	0.0);
	Kill_Weapon[461]	=	CreateConVar("xstats_points_bigearner",				"10",	"Xstats - Points given upon killing with the Big Earner.",				_,	true,	0.0);
	Kill_Weapon[466]	=	CreateConVar("xstats_points_maul",					"10",	"Xstats - Points given upon killing with the Maul.",					_,	true,	0.0);
	Kill_Weapon[474]	=	CreateConVar("xstats_points_conscentiousobjector",	"10",	"Xstats - Points given upon killing with the Conscentious Objector.",	_,	true,	0.0);
	Kill_Weapon[482]	=	CreateConVar("xstats_points_nessiesnineiron",		"10",	"Xstats - Points given upon killing with the Nessie's Nine-Iron.",		_,	true,	0.0);
	Kill_Weapon[513]	=	CreateConVar("xstats_points_original",				"10",	"Xstats - Points given upon killing with the Original.",				_,	true,	0.0);
	Kill_Weapon[525]	=	CreateConVar("xstats_points_diamondback",			"10",	"Xstats - Points given upon killing with the Diamondback.",				_,	true,	0.0);
	Kill_Weapon[526]	=	CreateConVar("xstats_points_machina",				"10",	"Xstats - Points given upon killing with the Machina.",					_,	true,	0.0);
	Kill_Weapon[527]	=	CreateConVar("xstats_points_widowmaker",			"10",	"Xstats - Points given upon killing with the Widowmaker.",				_,	true,	0.0);
	Kill_Weapon[528]	=	CreateConVar("xstats_points_shortcircuit",			"10",	"Xstats - Points given upon killing with the Short Circuit.",			_,	true,	0.0);
	Kill_Weapon[572]	=	CreateConVar("xstats_points_unarmedcombat",			"10",	"Xstats - Points given upon killing with the Unarmed Combat.",			_,	true,	0.0);
	Kill_Weapon[574]	=	CreateConVar("xstats_points_wangaprick",			"10",	"Xstats - Points given upon killing with the Wanga Prick.",				_,	true,	0.0);
	Kill_Weapon[587]	=	CreateConVar("xstats_points_apocofists",			"10",	"Xstats - Points given upon killing with the Apoco Fists.",				_,	true,	0.0);
	Kill_Weapon[588]	=	CreateConVar("xstats_points_pomson6000",			"10",	"Xstats - Points given upon killing with the Pomson 6000.",				_,	true,	0.0);
	Kill_Weapon[589]	=	CreateConVar("xstats_points_eurekaeffect",			"10",	"Xstats - Points given upon killing with the Eureka Effect.",			_,	true,	0.0);
	Kill_Weapon[593]	=	CreateConVar("xstats_points_thirddegree",			"10",	"Xstats - Points given upon killing with the Third Degree",				_,	true,	0.0);
	Kill_Weapon[594]	=	CreateConVar("xstats_points_phlogistinator",		"10",	"Xstats - Points given upon killing with the Phlogistinator.",			_,	true,	0.0);
	Kill_Weapon[595]	=	CreateConVar("xstats_points_manmelter",				"10",	"Xstats - Points given upon killing with the Man Melter.",				_,	true,	0.0);
	Kill_Weapon[609]	=	CreateConVar("xstats_points_scottishhandshake",		"10",	"Xstats - Points given upon killing with the Scottish Handshake.",		_,	true,	0.0);
	Kill_Weapon[638]	=	CreateConVar("xstats_points_sharpdresser",			"10",	"Xstats - Points given upon killing with the Sharp Dresser.",			_,	true,	0.0);
	Kill_Weapon[648]	=	CreateConVar("xstats_points_wrapassassin",			"10",	"Xstats - Points given upon killing with the Wrap Assassin.",			_,	true,	0.0);
	Kill_Weapon[649]	=	CreateConVar("xstats_points_spycicle",				"10",	"Xstats - Points given upon killing with the Spycicle.",				_,	true,	0.0);
	Kill_Weapon[654]	=	Kill_Weapon[15];	//Festive Minigun.
	Kill_Weapon[656]	=	CreateConVar("xstats_points_holidaypunch",			"10",	"Xstats - Points given upon killing with the Holiday Punch.",			_,	true,	0.0);
	Kill_Weapon[658]	=	Kill_Weapon[18];	//Festive Rocket Launcher.
	Kill_Weapon[659]	=	Kill_Weapon[21];	//Festive Flamethrower.
	Kill_Weapon[660]	=	Kill_Weapon[0];		//Festive Bat.
	Kill_Weapon[661]	=	Kill_Weapon[20];	//Festive stickybomb Launcher.
	Kill_Weapon[662]	=	Kill_Weapon[7];		//Festive Wrench.
	Kill_Weapon[664]	=	Kill_Weapon[14];	//Festive Sniper Rifle.
	Kill_Weapon[665]	=	Kill_Weapon[4];		//Festive Knife.
	Kill_Weapon[669]	=	Kill_Weapon[13];	//Festive Scattergun.
	Kill_Weapon[727]	=	CreateConVar("xstats_points_blackrose",				"10",	"Xstats - Points given upon killing with the Blackrose.",					_,	true,	0.0);
	Kill_Weapon[739]	=	CreateConVar("xstats_points_lollichop",				"10",	"Xstats - Points given upon killing with the Lollichop.",					_,	true,	0.0);
	Kill_Weapon[740]	=	CreateConVar("xstats_points_scorchshot",			"10",	"Xstats - Points given upon killing with the Scorch Shot.",					_,	true,	0.0);
	Kill_Weapon[741]	=	CreateConVar("xstats_points_rainblower",			"10",	"Xstats - Points given upon killing with the Rainblower.",					_,	true,	0.0);
	Kill_Weapon[751]	=	CreateConVar("xstats_points_cleanerscarbine",		"10",	"Xstats - Points given upon killing with the Cleaner's Carbine.",			_,	true,	0.0);
	Kill_Weapon[752]	=	CreateConVar("xstats_points_hitmansheatmaker",		"10",	"Xstats - Points given upon killing with the Hitman's Heatmaker.",			_,	true,	0.0);
	Kill_Weapon[772]	=	CreateConVar("xstats_points_babyfacesblaster",		"10",	"Xstats - Points given upon killing with the Baby Face's Blaster.",			_,	true,	0.0);
	Kill_Weapon[773]	=	CreateConVar("xstats_points_prettyboyspocketpistol",	"10",	"Xstats - Points given upon killing with the Pretty Boy's Pocket Pistol.",	_,	true,	0.0);
	Kill_Weapon[775]	=	CreateConVar("xstats_points_escapeplan",			"10",	"Xstats - Points given upon killing with the Escape Plan.",				_,	true,	0.0);
	Kill_Weapon[792]	=	Kill_Weapon[14];	//Default Sniper Rifle.			Silver Botkiller Mk. I.
	Kill_Weapon[793]	=	Kill_Weapon[15];	//Default Minigun.				Silver Botkiller Mk. I.
	Kill_Weapon[795]	=	Kill_Weapon[7];		//Default Wrench.				Silver Botkiller Mk. I.
	Kill_Weapon[797]	=	Kill_Weapon[20];	//Default Stickybomb Launcher.	Silver Botkiller Mk. I.
	Kill_Weapon[798]	=	Kill_Weapon[21];	//Default Flamethrower.			Silver Botkiller Mk. I.
	Kill_Weapon[799]	=	Kill_Weapon[13];	//Default Scattergun.			Silver Botkiller Mk. I.
	Kill_Weapon[800]	=	Kill_Weapon[18];	//Default Rocket Launcher.		Silver Botkiller Mk. I.
	Kill_Weapon[801]	=	Kill_Weapon[14];	//Default Sniper Rifle.			Gold Botkiller Mk. I.
	Kill_Weapon[802]	=	Kill_Weapon[15];	//Default Minigun.				Gold Botkiller Mk. I.
	Kill_Weapon[804]	=	Kill_Weapon[7];		//Default Wrench.				Gold Botkiller Mk. I.
	Kill_Weapon[806]	=	Kill_Weapon[20];	//Default Stickybomb Launcher.	Gold Botkiller Mk. I.
	Kill_Weapon[807]	=	Kill_Weapon[21];	//Default Flamethrower.			Gold Botkiller Mk. I.
	Kill_Weapon[808]	=	Kill_Weapon[13];	//Default Scattergun.			Gold Botkiller Mk. I.
	Kill_Weapon[809]	=	Kill_Weapon[18];	//Default Rocket Launcher.		Gold Botkiller Mk. I.
	Kill_Weapon[811]	=	CreateConVar("xstats_points_huolongheater",			"10",	"Xstats - Points given upon killing with the Huo-Long Heater.",			_,	true,	0.0);
	Kill_Weapon[812]	=	CreateConVar("xstats_points_flyingguillotine",		"10",	"Xstats - Points given upon killing with the Flying Guillotine",		_,	true,	0.0);
	Kill_Weapon[813]	=	CreateConVar("xstats_points_neonannihilator",		"10",	"Xstats - Points given upon killing with the Neon Annihilator.",		_,	true,	0.0);
	Kill_Weapon[832]	=	Kill_Weapon[811];	//Genuine Huo-Long Heater.
	Kill_Weapon[833]	=	Kill_Weapon[812];	//Genuine Flying Guillotine.
	Kill_Weapon[834]	=	Kill_Weapon[813];	//Genuine Neon Annihilator.
	Kill_Weapon[850]	=	Kill_Weapon[15];	//Deflector (MvM Minigun used by Giant Deflector Heavies.)
	Kill_Weapon[851]	=	CreateConVar("xstats_points_awperhand",				"10",	"Xstats - Points given upon killing with the AWPer Hand.",				_,	true,	0.0);
	Kill_Weapon[880]	=	CreateConVar("xstats_points_freedomstaff",			"10",	"Xstats - Points given upon killing with the Freedom Staff.",			_,	true,	0.0);
	Kill_Weapon[881]	=	Kill_Weapon[14];	//Default Sniper Rifle.			Rust Botkiller Mk. I.
	Kill_Weapon[882]	=	Kill_Weapon[15];	//Default Minigun.				Rust Botkiller Mk. I.
	Kill_Weapon[884]	=	Kill_Weapon[7];		//Default Wrench.				Rust Botkiller Mk. I.
	Kill_Weapon[886]	=	Kill_Weapon[20];	//Default Stickybomb Launcher.	Rust Botkiller Mk. I.
	Kill_Weapon[887]	=	Kill_Weapon[21];	//Default Flamethrower.			Rust Botkiller Mk. I.
	Kill_Weapon[888]	=	Kill_Weapon[13];	//Default Scattergun.			Rust Botkiller Mk. I.
	Kill_Weapon[889]	=	Kill_Weapon[18];	//Default Rocket Launcher.		Rust Botkiller Mk. I.
	Kill_Weapon[890]	=	Kill_Weapon[14];	//Default Sniper Rifle.			Blood Botkiller Mk. I.
	Kill_Weapon[891]	=	Kill_Weapon[15];	//Default Minigun.				Blood Botkiller Mk. I.
	Kill_Weapon[893]	=	Kill_Weapon[7];		//Default Wrench.				Blood Botkiller Mk. I.
	Kill_Weapon[895]	=	Kill_Weapon[20];	//Default Stickybomb Launcher.	Blood Botkiller Mk. I.
	Kill_Weapon[896]	=	Kill_Weapon[21];	//Default Flamethrower.			Blood Botkiller Mk. I.
	Kill_Weapon[897]	=	Kill_Weapon[13];	//Default Scattergun.			Blood Botkiller Mk. I.
	Kill_Weapon[898]	=	Kill_Weapon[18];	//Default Rocket Launcher.		Blood Botkiller Mk. I.
	Kill_Weapon[899]	=	Kill_Weapon[14];	//Default Sniper Rifle.			Carbonado Botkiller Mk. I.
	Kill_Weapon[900]	=	Kill_Weapon[15];	//Default Minigun.				Carbonado Botkiller Mk. I.
	Kill_Weapon[902]	=	Kill_Weapon[7];		//Default Wrench.				Carbonado Botkiller Mk. I.
	Kill_Weapon[904]	=	Kill_Weapon[20];	//Default Stickybomb Launcher.	Carbonado Botkiller Mk. I.
	Kill_Weapon[905]	=	Kill_Weapon[21];	//Default Flamethrower.			Carbonado Botkiller Mk. I.
	Kill_Weapon[906]	=	Kill_Weapon[13];	//Default Scattergun.			Carbonado Botkiller Mk. I.
	Kill_Weapon[907]	=	Kill_Weapon[18];	//Default Rocket Launcher.		Carbonado Botkiller Mk. I.
	Kill_Weapon[908]	=	Kill_Weapon[14];	//Default Sniper Rifle.			Diamond Botkiller Mk. I.
	Kill_Weapon[909]	=	Kill_Weapon[15];	//Default Minigun.				Diamond Botkiller Mk. I.
	Kill_Weapon[911]	=	Kill_Weapon[7];		//Default Wrench.				Diamond Botkiller Mk. I.
	Kill_Weapon[913]	=	Kill_Weapon[20];	//Default Stickybomb Launcher.	Diamond Botkiller Mk. I.
	Kill_Weapon[914]	=	Kill_Weapon[21];	//Default Flamethrower.			Diamond Botkiller Mk. I.
	Kill_Weapon[915]	=	Kill_Weapon[13];	//Default Scattergun.			Diamond Botkiller Mk. I.
	Kill_Weapon[916]	=	Kill_Weapon[18];	//Default Rocket Launcher.		Diamond Botkiller Mk. I.
	Kill_Weapon[954]	=	CreateConVar("xstats_points_memorymaker",			"10",	"Xstats - Points given upon killing with the Memory Maker.",			_,	true,	0.0);
	Kill_Weapon[957]	=	Kill_Weapon[14];	//Default Sniper Rifle.			Silver Botkiller Mk. II.
	Kill_Weapon[958]	=	Kill_Weapon[15];	//Default Minigun.				Silver Botkiller Mk. II.
	Kill_Weapon[960]	=	Kill_Weapon[7];		//Default Wrench.				Silver Botkiller Mk. II.
	Kill_Weapon[962]	=	Kill_Weapon[20];	//Default Stickybomb Launcher.	Silver Botkiller Mk. II.
	Kill_Weapon[963]	=	Kill_Weapon[21];	//Default Flamethrower.			Silver Botkiller Mk. II.
	Kill_Weapon[964]	=	Kill_Weapon[13];	//Default Scattergun.			Silver Botkiller Mk. II.
	Kill_Weapon[965]	=	Kill_Weapon[18];	//Default Rocket Launcher.		Silver Botkiller Mk. II.
	Kill_Weapon[966]	=	Kill_Weapon[14];	//Default Sniper Rifle.			Gold Botkiller Mk. II.
	Kill_Weapon[967]	=	Kill_Weapon[15];	//Default Minigun.				Gold Botkiller Mk. II.
	Kill_Weapon[969]	=	Kill_Weapon[7];		//Default Wrench.				Gold Botkiller Mk. II.
	Kill_Weapon[971]	=	Kill_Weapon[20];	//Default Stickybomb Launcher.	Gold Botkiller Mk. II.
	Kill_Weapon[972]	=	Kill_Weapon[21];	//Default Flamethrower.			Gold Botkiller Mk. II.
	Kill_Weapon[973]	=	Kill_Weapon[13];	//Default Scattergun.			Gold Botkiller Mk. II.
	Kill_Weapon[974]	=	Kill_Weapon[18];	//Default Rocket Launcher.		Gold Botkiller Mk. II.
	Kill_Weapon[939]	=	CreateConVar("xstats_points_batouttahell",			"10",	"Xstats - Points given upon killing with the Bat Outta Hell.",			_,	true,	0.0);
	Kill_Weapon[996]	=	CreateConVar("xstats_points_loosecannon",			"10",	"Xstats - Points given upon killing with the Loose Cannon.",			_,	true,	0.0);
	Kill_Weapon[997]	=	CreateConVar("xstats_points_rescueranger",			"10",	"Xstats - Points given upon killing with the Rescue Ranger.",			_,	true,	0.0);
	Kill_Weapon[999]	=	Kill_Weapon[221];	//Festive Holy Mackerel.
	Kill_Weapon[1000]	=	Kill_Weapon[38];	//Festive Axtinguisher.
	Kill_Weapon[1003]	=	Kill_Weapon[37];	//Festive Ubersaw.
	Kill_Weapon[1004]	=	Kill_Weapon[141];	//Festive Frontier Justice.
	Kill_Weapon[1005]	=	Kill_Weapon[56];	//Festive Huntsman.
	Kill_Weapon[1006]	=	Kill_Weapon[61];	//Festive Ambassador.
	Kill_Weapon[1007]	=	Kill_Weapon[19];	//Festive Grenade Launcher.
	Kill_Weapon[1013]	=	CreateConVar("xstats_points_hamshank",				"10",	"Xstats - Points given upon killing with the Ham Shank.",				_,	true,	0.0);
	Kill_Weapon[1071]	=	Kill_Weapon[264];	//Golden Frying Pan.
	Kill_Weapon[1078]	=	Kill_Weapon[45];	//Festive Force-A-Nature.
	Kill_Weapon[1079]	=	Kill_Weapon[305];	//Festive Crusader's Crossbow.
	Kill_Weapon[1081]	=	Kill_Weapon[39];	//Festive Flare Gun.
	Kill_Weapon[1082]	=	Kill_Weapon[132];	//Festive Eyelander.
	Kill_Weapon[1084]	=	Kill_Weapon[239];	//Festive Gloves of Running Urgently.
	Kill_Weapon[1085]	=	Kill_Weapon[228];	//Festive Black Box.
	Kill_Weapon[1092]	=	CreateConVar("xstats_points_fortifiedcompound",		"10",	"Xstats - Points given upon killing with the Fortified Compound.",		_,	true,	0.0);
	Kill_Weapon[1098]	=	CreateConVar("xstats_points_classic",				"10",	"Xstats - Points given upon killing with the Classic.",					_,	true,	0.0);
	Kill_Weapon[1099]	=	CreateConVar("xstats_points_tideturner",			"10",	"Xstats - Points given upon killing with the Tide Turner.",				_,	true,	0.0);
	Kill_Weapon[1100]	=	CreateConVar("xstats_points_breadbite",				"10",	"Xstats - Points given upon killing with the Bread Bite.",				_,	true,	0.0);
	Kill_Weapon[1103]	=	CreateConVar("xstats_points_backscatter",			"10",	"Xstats - Points given upon killing with the Back Scatter.",			_,	true,	0.0);
	Kill_Weapon[1104]	=	CreateConVar("xstats_points_airstrike",				"10",	"Xstats - Points given upon killing with the Air Strike.",				_,	true,	0.0);
	Kill_Weapon[1123]	=	CreateConVar("xstats_points_necrosmasher",			"10",	"Xstats - Points given upon killing with the Necro Smasher.",			_,	true,	0.0);
	Kill_Weapon[1127]	=	CreateConVar("xstats_points_crossingguard",			"10",	"Xstats - Points given upon killing with the Crossing Guard.",			_,	true,	0.0);
	Kill_Weapon[1141]	=	Kill_Weapon[9];		//Festive Shotgun.
	Kill_Weapon[1142]	=	Kill_Weapon[24];	//Festive Revolver.
	Kill_Weapon[1144]	=	Kill_Weapon[131];	//Festive Chargin' Targe.
	Kill_Weapon[1146]	=	Kill_Weapon[40];	//Festive Backburner.
	Kill_Weapon[1149]	=	Kill_Weapon[16];	//Festive SMG.
	Kill_Weapon[1150]	=	CreateConVar("xstats_points_quickebomblauncher",	"10",	"Xstats - Points given upon killing with the Quickiebomb Launcher.",	_,	true,	0.0);
	Kill_Weapon[1151]	=	CreateConVar("xstats_points_ironbomber",			"10",	"Xstats - Points given upon killing with the Iron Bomber.",				_,	true,	0.0);
	Kill_Weapon[1153]	=	CreateConVar("xstats_points_panicattack",			"10",	"Xstats - Points given upon killing with the Panic Attack.",			_,	true,	0.0);
	Kill_Weapon[1178]	=	CreateConVar("xstats_points_dragonsfury",			"10",	"Xstats - Points given upon killing with the Dragon's Fury.",			_,	true,	0.0);
	Kill_Weapon[1179]	=	CreateConVar("xstats_points_thermalthruster",		"10",	"Xstats - Points given upon killing with the Thermal Thruster.",		_,	true,	0.0);
	Kill_Weapon[1181]	=	CreateConVar("xstats_points_hothand",				"10",	"Xstats - Points given upon killing with the Hot Hand.",				_,	true,	0.0);
	Kill_Weapon[1184]	=	Kill_Weapon[239];	//Gloves of Running Urgently. (Used by MvM Robots.)
	Kill_Weapon[15000]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Night Owl.
	Kill_Weapon[15001]	=	Kill_Weapon[16];	//Skinned SMG.					Woodsy Widowmaker.
	Kill_Weapon[15002]	=	Kill_Weapon[13];	//Skinned Scattergun.			Night Terror.
	Kill_Weapon[15003]	=	Kill_Weapon[9];		//Skinned Shotgun.				Backwoods Boomstick.
	Kill_Weapon[15004]	=	Kill_Weapon[15];	//Skinned Minigun.				King of The Jungle.
	Kill_Weapon[15005]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Forest Fire.
	Kill_Weapon[15006]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Woodland Warrior.
	Kill_Weapon[15007]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Purple Range.
	Kill_Weapon[15009]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Sudden Flurry.
	Kill_Weapon[15011]	=	Kill_Weapon[24];	//Skinned Revolver.				Psychedeic Slugger.
	Kill_Weapon[15012]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Carpet Bomber.
	Kill_Weapon[15013]	=	Kill_Weapon[22];	//Skinned Pistol.				Red Rock Roscoe.
	Kill_Weapon[15014]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Sand Cannon.
	Kill_Weapon[15015]	=	Kill_Weapon[13];	//Skinned Scattergun.			Tartan Torpedo.
	Kill_Weapon[15016]	=	Kill_Weapon[9];		//Skinned Shotgun.				Rustic Ruiner.
	Kill_Weapon[15017]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Barn Burner.
	Kill_Weapon[15018]	=	Kill_Weapon[22];	//Skinned Pistol.				Homemade Heater.
	Kill_Weapon[15019]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Lumber From Down Under.
	Kill_Weapon[15020]	=	Kill_Weapon[15];	//Skinned Minigun.				Iron Wood.
	Kill_Weapon[15021]	=	Kill_Weapon[13];	//Skinned Scattergun.			Country Crusher.
	Kill_Weapon[15022]	=	Kill_Weapon[16];	//Skinned SMG.					Plaid Potshotter.
	Kill_Weapon[15023]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Shot In The Dark.
	Kill_Weapon[15024]	=	Kill_Weapon[20];	//Skinned Grenade Launcher.		Blasted Bombardier.
	Kill_Weapon[15026]	=	Kill_Weapon[15];	//Skinned Minigun.				Antique Annihilator.
	Kill_Weapon[15027]	=	Kill_Weapon[24];	//Skinned Revolver.				Old Country.
	Kill_Weapon[15028]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		American Pastoral.
	Kill_Weapon[15029]	=	Kill_Weapon[13];	//Skinned Scattergun.			Backcountry Blaster.
	Kill_Weapon[15030]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Bovine Blazemaker.
	Kill_Weapon[15031]	=	Kill_Weapon[15];	//Skinned Minigun.				War Room.
	Kill_Weapon[15032]	=	Kill_Weapon[16];	//Skinned SMG.					Treadplate Tormenter.
	Kill_Weapon[15033]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Bogtrotter.
	Kill_Weapon[15034]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Earth, Sky and Fire.
	Kill_Weapon[15035]	=	Kill_Weapon[22];	//Skinned Pistol.				Hickory Holepuncher.
	Kill_Weapon[15036]	=	Kill_Weapon[13];	//Skinned Scattergun.			Spruce Deuce.
	Kill_Weapon[15037]	=	Kill_Weapon[16];	//Skinned SMG.					Team Sprayer.
	Kill_Weapon[15038]	=	Kill_Weapon[20];	//Skinned Grenade Launcher.		Rooftop Wrangler.
	Kill_Weapon[15040]	=	Kill_Weapon[15];	//Skinned Minigun.				Citizen Pain.
	Kill_Weapon[15041]	=	Kill_Weapon[22];	//Skinned Pistol.				Local Hero.
	Kill_Weapon[15042]	=	Kill_Weapon[24];	//Skinned Revolver.				Mayor.
	Kill_Weapon[15043]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Smalltown Bringdown.
	Kill_Weapon[15044]	=	Kill_Weapon[9];		//Skinned Shotgun.				Civic Duty.
	Kill_Weapon[15045]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Liquid Asset.
	Kill_Weapon[15046]	=	Kill_Weapon[22];	//Skinned Pistol.				Black Dahlia.
	Kill_Weapon[15047]	=	Kill_Weapon[9];		//Skinned Shotgun.				Lightning Rod.
	Kill_Weapon[15048]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Pink Elephant.
	Kill_Weapon[15049]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Flash Fryer.
	Kill_Weapon[15051]	=	Kill_Weapon[24];	//Skinned Revolver.				Dead Reckoner.
	Kill_Weapon[15052]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Shell Shocker.
	Kill_Weapon[15053]	=	Kill_Weapon[13];	//Skinned Scattergun.			Current Event.
	Kill_Weapon[15054]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Turbine Torcher.
	Kill_Weapon[15055]	=	Kill_Weapon[15];	//Skinned Minigun.				Brick House.
	Kill_Weapon[15056]	=	Kill_Weapon[22];	//Skinned Pistol.				Sandstone Special.
	Kill_Weapon[15057]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Aqua Marine.
	Kill_Weapon[15058]	=	Kill_Weapon[16];	//Skinned SMG.					Low Profile.
	Kill_Weapon[15059]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Thunderbolt.
	Kill_Weapon[15060]	=	Kill_Weapon[22];	//Skinned Pistol.				Macabre Web.
	Kill_Weapon[15061]	=	Kill_Weapon[22];	//Skinned Pistol.				Nutcracker.
	Kill_Weapon[15062]	=	Kill_Weapon[24];	//Skinned Revolver.				Boneyard.
	Kill_Weapon[15063]	=	Kill_Weapon[24];	//Skinned Revolver.				Wildwood.
	Kill_Weapon[15064]	=	Kill_Weapon[24];	//Skinned Revolver.				Macabre Web.
	Kill_Weapon[15065]	=	Kill_Weapon[13];	//Skinned Scattergun.			Macabre Web.
	Kill_Weapon[15066]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Autumn.
	Kill_Weapon[15067]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Pumpkin Patch.
	Kill_Weapon[15068]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Nutcracker.
	Kill_Weapon[15069]	=	Kill_Weapon[13];	//Skinned Scattergun.			Nutcracker.
	Kill_Weapon[15070]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Pumpkin Patch.
	Kill_Weapon[15071]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Boneyard.
	Kill_Weapon[15072]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Wildwood.
	Kill_Weapon[15073]	=	Kill_Weapon[7];		//Skinned Wrench.				Nutcracker.
	Kill_Weapon[15074]	=	Kill_Weapon[7];		//Skinned Wrench.				Autumn.
	Kill_Weapon[15075]	=	Kill_Weapon[7];		//Skinned Wrench.				Boneyard.
	Kill_Weapon[15076]	=	Kill_Weapon[16];	//Skinned SMG.					Wildwood.
	Kill_Weapon[15077]	=	Kill_Weapon[19];	//Skinned Grenade Launcher.		Autumn.
	Kill_Weapon[15079]	=	Kill_Weapon[19];	//Skinned Grenade Launcher.		Macabre Web.
	Kill_Weapon[15081]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Autumn.
	Kill_Weapon[15082]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Autumn.
	Kill_Weapon[15083]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Pumpkin Patch.
	Kill_Weapon[15084]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Macabre Web.
	Kill_Weapon[15085]	=	Kill_Weapon[9];		//Skinned Shotgun.				Autumn.
	Kill_Weapon[15086]	=	Kill_Weapon[15];	//Skinned Minigun.				Macabre Web.
	Kill_Weapon[15087]	=	Kill_Weapon[15];	//Skinned Minigun.				Pumpkin Patch.
	Kill_Weapon[15088]	=	Kill_Weapon[15];	//Skinned Minigun.				Nutcracker.
	Kill_Weapon[15089]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Balloonicorn.
	Kill_Weapon[15090]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Rainbow.
	Kill_Weapon[15091]	=	Kill_Weapon[19];	//Skinned Grenade Launcher.		Rainbow.
	Kill_Weapon[15092]	=	Kill_Weapon[19];	//Skinned Grenade Launcher.		Sweet Dreams.
	Kill_Weapon[15094]	=	Kill_Weapon[4];		//Skinned Knife.				Blue Mew.
	Kill_Weapon[15095]	=	Kill_Weapon[4];		//Skinned Knife.				Brain Candy.
	Kill_Weapon[15096]	=	Kill_Weapon[4];		//Skinned Knife.				Stabbed To Hell.
	Kill_Weapon[15098]	=	Kill_Weapon[15];	//Skinned Minigun.				Brain Candy.
	Kill_Weapon[15099]	=	Kill_Weapon[15];	//Skinned Minigun.				Mister Cuddles.
	Kill_Weapon[15100]	=	Kill_Weapon[22];	//Skinned Pistol.				Blue Mew.
	Kill_Weapon[15101]	=	Kill_Weapon[22];	//Skinned Pistol.				Brain Candy.
	Kill_Weapon[15102]	=	Kill_Weapon[22];	//Skinned Pistol.				Shot To Hell.
	Kill_Weapon[15103]	=	Kill_Weapon[24];	//Skinned Revolver.				Flower Power.
	Kill_Weapon[15104]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Blue Mew.
	Kill_Weapon[15105]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Brain Candy.
	Kill_Weapon[15106]	=	Kill_Weapon[13];	//Skinned Scattergun.			Bluw Mew.
	Kill_Weapon[15107]	=	Kill_Weapon[13];	//Skinned Scattergun.			Flower Power.
	Kill_Weapon[15108]	=	Kill_Weapon[13];	//Skinned Scattergun.			Shot to Hell.
	Kill_Weapon[15109]	=	Kill_Weapon[9];		//Skinned Shotgun.				Flower Power.
	Kill_Weapon[15110]	=	Kill_Weapon[15];	//Skinned SMG.					Blue Mew.
	Kill_Weapon[15111]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Balloonicorn.
	Kill_Weapon[15112]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Rainbow.
	Kill_Weapon[15113]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Sweet Dreams.
	Kill_Weapon[15114]	=	Kill_Weapon[7];		//Skinned Wrench.				Torqued To Hell.
	Kill_Weapon[15115]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Coffin Nail.
	Kill_Weapon[15116]	=	Kill_Weapon[19];	//Skinned Grenade Launcher.		Coffin Nail.
	Kill_Weapon[15117]	=	Kill_Weapon[19];	//Skinned Grenade Launcher.		Top Shelf.
	Kill_Weapon[15118]	=	Kill_Weapon[4];		//Skinned Knife.				Dressed To Kill.
	Kill_Weapon[15119]	=	Kill_Weapon[4];		//Skinned Knife.				Top Shelf.
	Kill_Weapon[15123]	=	Kill_Weapon[15];	//Skinned Minigun.				Coffin Nail.
	Kill_Weapon[15124]	=	Kill_Weapon[15];	//Skinned Minigun.				Dressed To Kill.
	Kill_Weapon[15125]	=	Kill_Weapon[15];	//Skinned Minigun.				Top Shelf.
	Kill_Weapon[15126]	=	Kill_Weapon[22];	//Skinned Pistol.				Dressed To Kill.
	Kill_Weapon[15127]	=	Kill_Weapon[24];	//Skinned Revolver.				Top Shelf.
	Kill_Weapon[15128]	=	Kill_Weapon[24];	//Skinned Revolver.				Top Shelf.
	Kill_Weapon[15129]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Coffin Nail.
	Kill_Weapon[15130]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		High Roller's.
	Kill_Weapon[15131]	=	Kill_Weapon[13];	//Skinned Scattergun.			Coffin Nail.
	Kill_Weapon[15132]	=	Kill_Weapon[9];		//Skinned Shotgun.				Coffin Nail.
	Kill_Weapon[15133]	=	Kill_Weapon[9];		//Skinned Shotgun.				Dressed To Kill.
	Kill_Weapon[15134]	=	Kill_Weapon[16];	//Skinned SMG.					High Roller's.
	Kill_Weapon[15135]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Coffin Nail.
	Kill_Weapon[15136]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Dressed To Kill.
	Kill_Weapon[15137]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Coffin Nail.
	Kill_Weapon[15138]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Dressed To Kill.
	Kill_Weapon[15139]	=	Kill_Weapon[7];		//Skinned Wrench.				Dressed To Kill.
	Kill_Weapon[15140]	=	Kill_Weapon[7];		//Skinned Wrench.				Top Shelf.
	Kill_Weapon[15141]	=	Kill_Weapon[21];	//Skinned Flame Thrower.		Warhawk.
	Kill_Weapon[15142]	=	Kill_Weapon[19];	//Skinned Grenade Launcher.		Warhawk.
	Kill_Weapon[15143]	=	Kill_Weapon[4];		//Skinned Knife.				Blitzkrieg.
	Kill_Weapon[15144]	=	Kill_Weapon[4];		//Skinned Knife.				Airwolf.
	Kill_Weapon[15147]	=	Kill_Weapon[15];	//Skinned Minigun.				Butcher Bird.
	Kill_Weapon[15148]	=	Kill_Weapon[22];	//Skinned Pistol.				Blitzkrieg.
	Kill_Weapon[15149]	=	Kill_Weapon[24];	//Skinned Revolver.				Blitzkrieg.
	Kill_Weapon[15050]	=	Kill_Weapon[18];	//Skinned Rocket Launcher.		Warhawk.
	Kill_Weapon[15151]	=	Kill_Weapon[13];	//Skinned Scattergun.			Killer Bee.
	Kill_Weapon[15152]	=	Kill_Weapon[9];		//Skinned Shotgun.				Red Bear.
	Kill_Weapon[15153]	=	Kill_Weapon[16];	//Skinned SMG.					Blitzkrieg.
	Kill_Weapon[15154]	=	Kill_Weapon[14];	//Skinned Sniper Rifle.			Airwolf.
	Kill_Weapon[15155]	=	Kill_Weapon[20];	//Skinned Stickybomb Launcher.	Blitzkrieg.
	Kill_Weapon[15156]	=	Kill_Weapon[7];		//Skinned Wrench.				Airwolf.
	Kill_Weapon[15157]	=	Kill_Weapon[13];	//Skinned Scattergun.			Corsair.
	Kill_Weapon[15158]	=	Kill_Weapon[19];	//Skinned Grenade Launcher.		Butcher Bird.
	Kill_Weapon[19010]	=	Kill_Weapon[18];	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 1.
	Kill_Weapon[19011]	=	Kill_Weapon[9];		//TF2Items Give Weapon: Beta Pocket Shotgun.
	Kill_Weapon[19012]	=	Kill_Weapon[129];	//TF2Items Give Weapon: Beta Split Equalizer 1.
	Kill_Weapon[19013]	=	Kill_Weapon[129];	//TF2Items Give Weapon: Beta Split Equalizer 2.
	Kill_Weapon[19015]	=	Kill_Weapon[14];	//TF2Items Give Weapon: Beta Sniper Rifle 1.
	Kill_Weapon[19016]	=	Kill_Weapon[18];	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 2.
	Kill_Weapon[19017]	=	Kill_Weapon[18];	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 3.
	Kill_Weapon[30474]	=	CreateConVar("xstats_points_nostromonapalmer",		"10",	"Xstats - Points given upon killing with the Nostromo Napalmer.",		_,	true,	0.0);
	Kill_Weapon[30665]	=	CreateConVar("xstats_points_shootingstar",			"10",	"Xstats - Points given upon killing with the Shooting star.",			_,	true,	0.0);
	Kill_Weapon[30666]	=	CreateConVar("xstats_points_capper",				"10",	"Xstats - Points given upon killing with the C.A.P.P.E.R.",				_,	true,	0.0);
	Kill_Weapon[30667]	=	CreateConVar("xstats_points_batsaber",				"10",	"Xstats - Points given upon killing with the Batsaber.",				_,	true,	0.0);
	Kill_Weapon[30668]	=	CreateConVar("xstats_points_gigarcounter",			"10",	"Xstats - Points given upon killing with the Gigar Counter.",			_,	true,	0.0);
	Kill_Weapon[30758]	=	CreateConVar("xstats_points_prinnymachete",			"10",	"Xstats - Points given upon killing with the Prinny Machete.",			_,	true,	0.0);
	
	//CTF Event points.
	CTF_Event[1]		=	CreateConVar("xstats_points_ctf_pickup",			"10",	"Xstats - Points given upon picking up a flag. 0 Disables this.",		_,	true,	0.0);
	CTF_Event[2]		=	CreateConVar("xstats_points_ctf_capture",			"10",	"Xstats - Points given upon capturing a flag. 0 Disables this.",		_,	true,	0.0);
	CTF_Event[3]		=	CreateConVar("xstats_points_ctf_defend",			"10",	"Xstats - Points given upon defending the flag. 0 Disables this.",		_,	true,	0.0);
	
	//CP Event Points.
	CP_Event[1]			=	CreateConVar("xstats_points_cp_blocked",			"10",	"Xstats - Points given upon blocking oppont from capturing a point. 0 Disables this.",			_,	true,	0.0);
	CP_Event[2]			=	CreateConVar("xstats_points_cp_capture",			"10",	"Xstats - Points given upon capturing a point. 0 Disables this.",								_,	true,	0.0);
	
	//MvM Event Points.
	MvM_Event[1]		=	CreateConVar("xstats_points_mvm_defend",			"10",	"Xstats - Points given upon defending the bomb from the robot.",		_,	true,	0.0);
	
	//When a player coats someones.
	OnPlayerJarated[58]			=	CreateConVar("xstats_points_coated_jarate",			"5",	"Xstats - Points given upon coating an enemy with the Jarate.",							_,	true,	0.0);
	OnPlayerJarated[222]		=	CreateConVar("xstats_points_coated_madmilk",		"5",	"Xstats - Points given upon coating an enemy with the Mad Milk.",						_,	true,	0.0);
	OnPlayerJarated[1105]		=	CreateConVar("xstats_points_coated_sabm",			"5",	"Xstats - Points given upon coating an enemy with the Self-Aware Beauty Mark.",			_,	true,	0.0);
	//OnPlayerJarated[1105]		=	OnPlayerJarated[58];	//Unused.
	OnPlayerJarated[1121]		=	CreateConVar("xstats_points_coated_mutatedmilk",	"5",	"Xstats - Points given upon coating an enemy with the Mutated Milk.",					_,	true,	0.0);
	//OnPlayerJarated[1121]		=	OnPlayerJarated[222];	//Unused.
	
	
	//When a player extinguishes their teammate(s).
	OnPlayerExtinguished[21]	=	CreateConVar("xstats_poinst_extinguished_flamethrower",			"5",	"Xstats - Points given upon extinguishing with the Flame Thrower.",			_,	true,	0.0);
	OnPlayerExtinguished[29]	=	CreateConVar("xstats_points_extinguished_medigun",				"5",	"Xstats - Points given upon extinguishing with the Medigun.",				_,	true,	0.0);
	OnPlayerExtinguished[35]	=	CreateConVar("xstats_points_extinguished_kritzkrieg",			"5",	"Xstats - Points given upon extinguishing with the KritzKrieg",				_,	true,	0.0);
	OnPlayerExtinguished[40]	=	CreateConVar("xstats_points_extinguished_backburner",			"5",	"Xstats - Points given upon extinguishing with the Back Burner.",			_,	true,	0.0);
	OnPlayerExtinguished[58]	=	CreateConVar("xstats_points_extinguished_jarate",				"5",	"Xstats - Points given upon extinguishing with the Jarate",					_,	true,	0.0);
	OnPlayerExtinguished[208]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.
	OnPlayerExtinguished[211]	=	OnPlayerExtinguished[29];	//Skinned medigun.
	OnPlayerExtinguished[215]	=	CreateConVar("xstats_points_extinguished_degreaser",			"5",	"Xstats - Points given upon extinguishing with the Degreaser.",				_,	true,	0.0);
	OnPlayerExtinguished[222]	=	CreateConVar("xstats_points_extinguished_madmilk",				"5",	"Xstats - Points given upon extinguishing with the Mad Milk.",				_,	true,	0.0);
	OnPlayerExtinguished[305]	=	CreateConVar("xstats_points_extinguished_crusaderscrossbow",	"5",	"Xstats - Points given upon extinguishing with the Crusader's Crossbow.",	_,	true,	0.0);
	OnPlayerExtinguished[411]	=	CreateConVar("xstats_points_extinguished_quickfix",				"5",	"Xstats - Points given upon extinguishing with the Quick-Fix.",				_,	true,	0.0);
	OnPlayerExtinguished[663]	=	OnPlayerExtinguished[29];	//Festive medigun
	OnPlayerExtinguished[741]	=	CreateConVar("xstats_points_extinguished_rainblower",			"5",	"Xstats - Points given upon extinguishing with the Rainblower.",			_,	true,	0.0);
	OnPlayerExtinguished[796]	=	OnPlayerExtinguished[29];	//Botkiller medigun.
	OnPlayerExtinguished[798]	=	OnPlayerExtinguished[21];	//Botkiller flame thrower.
	OnPlayerExtinguished[805]	=	OnPlayerExtinguished[29];	//Botkiller medigun.
	OnPlayerExtinguished[807]	=	OnPlayerExtinguished[21];	//Botkiller flame thrower.
	OnPlayerExtinguished[885]	=	OnPlayerExtinguished[29];	//Botkiller medigun.
	OnPlayerExtinguished[887]	=	OnPlayerExtinguished[21];	//Botkiller flame thrower.
	OnPlayerExtinguished[894]	=	OnPlayerExtinguished[29];	//Botkiller medigun.
	OnPlayerExtinguished[896]	=	OnPlayerExtinguished[21];	//Botkiller flame thrower.
	OnPlayerExtinguished[903]	=	OnPlayerExtinguished[29];	//Botkiller medigun.
	OnPlayerExtinguished[905]	=	OnPlayerExtinguished[21];	//Botkiller flame thrower.
	OnPlayerExtinguished[912]	=	OnPlayerExtinguished[29];	//Botkiller medigun.
	OnPlayerExtinguished[914]	=	OnPlayerExtinguished[21];	//Botkiller flame thrower.
	OnPlayerExtinguished[961]	=	OnPlayerExtinguished[29];	//Botkiller medigun.
	OnPlayerExtinguished[963]	=	OnPlayerExtinguished[21];	//Botkiller flame thrower.
	OnPlayerExtinguished[970]	=	OnPlayerExtinguished[29];	//Botkiller medigun.
	OnPlayerExtinguished[972]	=	OnPlayerExtinguished[21];	//Botkiller flame thrower.
	OnPlayerExtinguished[998]	=	OnPlayerExtinguished[29];	//Vaccinator.
	OnPlayerExtinguished[1079]	=	OnPlayerExtinguished[305];	//Festive Crusader's Crossbow.
	OnPlayerExtinguished[1105]	=	CreateConVar("xstats_points_extinguished_sabm",					"5",	"Xstats - Points given upon extinguishing with the Self-Aware Beauty Mark.",_,	true,	0.0);
	OnPlayerExtinguished[1121]	=	CreateConVar("xstats_points_extinguished_mutatedmilk",			"5",	"Xstats - Points given upon extinguishing with the Mutated Milk.",			_,	true,	0.0);
	OnPlayerExtinguished[1146]	=	OnPlayerExtinguished[40];
	OnPlayerExtinguished[1178]	=	CreateConVar("xstats_points_extinguished_dragonsfury",			"5",	"Xstats - Points given upon extinguishing with the Dragon's Fury.",			_,	true,	0.0);
	OnPlayerExtinguished[15005]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Forest Fire.
	OnPlayerExtinguished[15008]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Masked Mender.
	OnPlayerExtinguished[15010]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Wrapped Reviver.
	OnPlayerExtinguished[15017]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Barn Burner.
	OnPlayerExtinguished[15025]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Reclaimed Reanimator.
	OnPlayerExtinguished[15030]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Bovine Blazemaker.
	OnPlayerExtinguished[15034]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Earth, Sky & Fire.
	OnPlayerExtinguished[15039]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Civil Servant.
	OnPlayerExtinguished[15049]	=	OnPlayerExtinguished[29];	//Skinned flame thrower.	Flash Fryer.
	OnPlayerExtinguished[15050]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Spark of Life.
	OnPlayerExtinguished[15054]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Turbine Torcher.
	OnPlayerExtinguished[15066]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Autumn.
	OnPlayerExtinguished[15067]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Pumpkin Patch.
	OnPlayerExtinguished[15068]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Nutcracker.
	OnPlayerExtinguished[15078]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Wildwood.
	OnPlayerExtinguished[15089]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Balloonicorn.
	OnPlayerExtinguished[15090]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Rainbow.
	OnPlayerExtinguished[15097]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Flower Power.
	OnPlayerExtinguished[15115]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Coffin Nail.
	OnPlayerExtinguished[15121]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Dressed To Kill.
	OnPlayerExtinguished[15122]	=	OnPlayerExtinguished[29];	//Skinned medigun.			High Roller's.
	OnPlayerExtinguished[15123]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Coffin Nail.
	OnPlayerExtinguished[15141]	=	OnPlayerExtinguished[21];	//Skinned flame thrower.	Warhawk.
	OnPlayerExtinguished[15145]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Blitzkrieg.
	OnPlayerExtinguished[15146]	=	OnPlayerExtinguished[29];	//Skinned medigun.			Corsair.
	OnPlayerExtinguished[30474]	=	CreateConVar("xstats_points_extinguished_nostromonapalmer",		"5",	"Xstats - Points given upon extinguishing with the Nostromo Napalmer.",		_,	true,	0.0);
	
	//When medic übercharges their teammate/enemy spy.
	OnPlayerUbercharged[29]		=	CreateConVar("xstats_points_ubercharged_medigun",		"5",	"Xstats - Points given upon ubercharging teammate with a Medi Gun",			_,	true,	0.0);
	OnPlayerUbercharged[35]		=	CreateConVar("xstats_points_ubercharged_kritzkrieg",	"5",	"Xstats - Points given upon ubercharging teammate with a Kritzkrieg",		_,	true,	0.0);
	OnPlayerUbercharged[211]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[663]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[796]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[805]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[885]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[894]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[903]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[912]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[961]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[970]	=	OnPlayerUbercharged[29];
	OnPlayerUbercharged[998]	=	CreateConVar("xstats_points_ubercharged_vaccinator",	"5",	"Xstats - Points given upon ubercharging teammate with a Vaccinator.",		_,	true,	0.0);
	OnPlayerUbercharged_Spy		=	CreateConVar("xstats_points_ubercharged_spy",			"0",	"Xstats - Should ubercharging an enemy spy be counted as a 'teammate'?",	_,	true,	0.0, true,	1.0);
	
	//When sandvich is stolen.
	SandvichStolen	=	CreateConVar("xstats_points_stealsandvich",	"5",	"Xstats - Points given upon stealing a sandvich. 0 Disables this.",									_,	true,	0.0);
	
	//Building events.
	Building_Event[1]	=	CreateConVar("xstats_points_building_destroyed",			"2",	"Xstats - Points given upon destroying a building. 0 Disables this.",			_,	true,	0.0);
	Building_Event[2]	=	CreateConVar("xstats_points_building_sentrygun",			"2",	"Xstats - Points given upon building a Sentrygun. 0 Disables this.",			_,	true,	0.0);
	Building_Event[3]	=	CreateConVar("xstats_points_building_dispenser",			"2",	"Xstats - Points given upon building a Dispenser. 0 Disables this.",			_,	true,	0.0);
	Building_Event[4]	=	CreateConVar("xstats_points_building_teleporter_entrance",	"2",	"Xstats - Points given upon building a Teleporter Entrance. 0 Disables this.",	_,	true,	0.0);
	Building_Event[5]	=	CreateConVar("xstats_points_building_teleporter_exit",		"2",	"Xstats - Points given upon building a Teleporter Exit. 0 Disables this.",		_,	true,	0.0);
	Building_Event[6]	=	CreateConVar("xstats_points_building_minisentry",			"2",	"Xstats - Points given upon building a Mini-Sentry. 0 Disables this.",			_,	true,	0.0);
	
	//Other.
	Feature[1]	=	CreateConVar("xstats_feature_weapon_crits",		"1",	"Xstats - Should weapon name be coloured by type of kill? (minicrit & critical). 0 Disables this.",	_, true, 0.0, true,	1.0);
	Feature[2]	=	CreateConVar("xstats_feature_maps_restrict",	"1",	"Xstats - Should the events be restricted to the correct map?. 0 Disables this.",					_, true, 0.0, true, 1.0);
	Feature[3]	=	CreateConVar("xstats_feature_antiabuse",		"1",	"Xstats - Should the kill event to be made sure to be fair? (Blocks from noclip, etc. 2 Also includes sv_cheats). 0 Disables this.", _, true, 0.0, true, 2.0);
	
	CritTexts[1]	=	CreateConVar("xstats_feature_weapon_crits_minicrit",	"{yellow}",	"Xstats - The colour code the the minicrit kill type.");
	CritTexts[2]	=	CreateConVar("xstats_feature_weapon_crits_critical",	"{orange}",	"Xstats - The colour code for the critical kill type.");	
}