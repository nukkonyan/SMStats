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
void PrepareGame_TF2() {
	//Weapon cvars
	Cvars.CreateTF2Weapon(0, "xstats_points_weapon_bat", 10, "Bat");
	Cvars.CreateTF2Weapon(1, "xstats_points_weapon_bottle", 10, "Bottle");
	Cvars.CreateTF2Weapon(2, "xstats_points_weapon_fireaxe", 10, "Fire Axe");
	Cvars.CreateTF2Weapon(3, "xstats_points_weapon_kukri", 10, "Kukri");
	Cvars.CreateTF2Weapon(4, "xstats_points_weapon_knife", 10, "Knife");
	Cvars.CreateTF2Weapon(5, "xstats_points_weapon_fists", 10, "Fists");
	Cvars.CreateTF2Weapon(6, "xstats_points_weapon_shovel", 10, "Shovel");
	Cvars.CreateTF2Weapon(7, "xstats_points_weapon_wrench", 10, "Wrench");
	Cvars.CreateTF2Weapon(8, "xstats_points_weapon_bonesaw", 10, "Bonesaw");
	Cvars.CreateTF2Weapon(9, "xstats_points_weapon_shotgun", 10, "Shotgun");
	Cvars.SameWeapon(10, 9); //Same Shotgun, different TFClass type.
	Cvars.SameWeapon(11, 9); //Same Shotgun, different TFClass type.
	Cvars.SameWeapon(12, 9); //Same Shotgun, different TFClass type.
	Cvars.CreateTF2Weapon(13, "xstats_points_weapon_scattergun", 10, "Scattergun");
	Cvars.CreateTF2Weapon(14, "xstats_points_weapon_sniperrifle", 10, "Sniper Rifle");
	Cvars.CreateTF2Weapon(15, "xstats_points_weapon_minigun", 10, "Minigun");
	Cvars.CreateTF2Weapon(16, "xstats_points_weapon_smg", 10, "SMG");
	Cvars.CreateTF2Weapon(17, "xstats_points_weapon_syringegun", 10, "Syringe Gun");
	Cvars.CreateTF2Weapon(18, "xstats_points_weapon_rocketlauncher", 10, "Rocket Launcher");
	Cvars.CreateTF2Weapon(19, "xstats_points_weapon_grenadelauncher", 10, "Grenade Launcher");
	Cvars.CreateTF2Weapon(20, "xstats_points_weapon_stickybomblauncher", 10, "StickyBomb Launcher");
	Cvars.CreateTF2Weapon(21, "xstats_points_weapon_flamethrower", 10, "Flamethrower");
	Cvars.CreateTF2Weapon(22, "xstats_points_weapon_pistol", 10, "Pistol");
	Cvars.SameWeapon(23, 22); //Same Pistol, different TFWeaponType type.
	Cvars.CreateTF2Weapon(24, "xstats_points_weapon_revolver", 10, "Revolver");
	Cvars.CreateTF2Weapon(36, "xstats_points_weapon_blutsauger", 10, "Blutsauger");
	Cvars.CreateTF2Weapon(37, "xstats_points_weapon_ubersaw", 10, "Ubersaw");
	Cvars.CreateTF2Weapon(38, "xstats_points_weapon_axtinguisher", 10, "Axtinguisher");
	Cvars.CreateTF2Weapon(39, "xstats_points_weapon_flaregun", 10, "Flaregun");
	Cvars.CreateTF2Weapon(40, "xstats_points_weapon_backburner", 10, "Backburner");
	Cvars.CreateTF2Weapon(41, "xstats_points_weapon_natascha", 10, "Natascha");
	Cvars.CreateTF2Weapon(43, "xstats_points_weapon_killerglovesofboxing", 10, "Killer Gloves Of Boxing");
	Cvars.CreateTF2Weapon(44, "xstats_points_weapon_sandman", 10, "Sandman.");
	Cvars.CreateTF2Weapon(45, "xstats_points_weapon_forceanature", 10, "Force-A-Nature");
	Cvars.CreateTF2Weapon(56, "xstats_points_weapon_huntsman", 10, "Huntsman");
	Cvars.CreateTF2Weapon(61, "xstats_points_weapon_ambassador", 10, "Ambassador");
	Cvars.CreateTF2Weapon(127, "xstats_points_weapon_directhit", 10, "Direct-Hit");
	Cvars.CreateTF2Weapon(128, "xstats_points_weapon_equalizer", 10, "Equalizer");
	Cvars.CreateTF2Weapon(130, "xstats_points_weapon_scottishresistance", 10, "Scottish Resistance.");
	Cvars.CreateTF2Weapon(131, "xstats_points_weapon_chargentarge", 10, "Charge n' Targe");
	Cvars.CreateTF2Weapon(132, "xstats_points_weapon_eyelander", 10, "Eyelander");
	Cvars.CreateTF2Weapon(140, "xstats_points_weapon_wrangler", 10, "Wrangler");
	Cvars.CreateTF2Weapon(141, "xstats_points_weapon_frontierjustice", 10, "Frontier Justice");
	Cvars.CreateTF2Weapon(142, "xstats_points_weapon_gunslinger", 10, "Gunslinger");
	Cvars.CreateTF2Weapon(153, "xstats_points_weapon_homewrecker", 10, "Homewrecker");
	Cvars.CreateTF2Weapon(154, "xstats_points_weapon_paintrain", 10, "Pain Train");
	Cvars.CreateTF2Weapon(155, "xstats_points_weapon_southernhospitality", 10, "Southern Hospitality");
	Cvars.CreateTF2Weapon(160, "xstats_points_weapon_lugermorph", 10, "Lugermorph");
	Cvars.CreateTF2Weapon(161, "xstats_points_weapon_bigkill", 10, "Big Kill");
	Cvars.CreateTF2Weapon(169, "xstats_points_weapon_wrench", 10, "Wrench");
	Cvars.CreateTF2Weapon(171, "xstats_points_weapon_tribalmansshiv", 10, "Tribalman's Shiv");
	Cvars.CreateTF2Weapon(172, "xstats_points_weapon_scotsmansskullcutter", 10, "Scotsman's Skullcutter");
	Cvars.CreateTF2Weapon(173, "xstats_points_weapon_vitasaw", 10, "Vita-Saw");
	Cvars.SameWeapon(190, 0); //Same as default Bat, used for strange, renamed & skinned versions.
	Cvars.SameWeapon(191, 1); //Same as default Bottle, used for strange, renamed & skinned versions.
	Cvars.SameWeapon(192, 2); //Same as default Fire Axe, used for strange, renamed & skinned versions.
	Cvars.SameWeapon(193, 3); //Same as default Kukri, used for strange, renamed & skinned versions.
	Cvars.SameWeapon(194, 4); //Same as default Knife, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(195, 5); //Same as default Fists, used for strange & renamed version.
	Cvars.SameWeapon(196, 6); //Same as default Shovel, used for strange, renamed & skinned versions.
	Cvars.SameWeapon(197, 7); //Same as default Wrench, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(198, 8); //Same as default Bonesaw, used for strange, renamed & skinned versions.
	Cvars.SameWeapon(199, 9); //Same as default Shotgun, used for strange, renamed & skinned versions.
	Cvars.SameWeapon(200, 13); //Same as default Scattergun, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(201, 14); //Same as default Sniper Rifle, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(202, 15); //Same as default Minigun, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(203, 16); //Same as default SMG, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(204, 17); //Same as default Syringe gun, used for strange, renamed & skinned versions.
	Cvars.SameWeapon(205, 18); //Same as default Rocket Launcher, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(206, 19); //Same as default Grenade Launcher, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(207, 20); //Same as default Stickybomb Launcher, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(208, 21); //Same as default Flamethrower, used for australium, strange, renamed & skinned versions.
	Cvars.SameWeapon(209, 22); //Same as default Pistol, used for strange, renamed & skinned versions.
	Cvars.SameWeapon(210, 24); //Same as default Revolver, used for strange, renamed & skinned versions.
	Cvars.CreateTF2Weapon(214, "xstats_points_weapon_powerjack", 10, "Power Jack");
	Cvars.CreateTF2Weapon(215, "xstats_points_weapon_degreaser", 10, "Degreaser");
	Cvars.CreateTF2Weapon(220, "xstats_points_weapon_shortstop", 10, "Shortstop");
	Cvars.CreateTF2Weapon(221, "xstats_points_weapon_holymackerel", 10, "Holy Mackerel");
	Cvars.CreateTF2Weapon(224, "xstats_points_weapon_letranger", 10, "L'etranger");
	Cvars.CreateTF2Weapon(225, "xstats_points_weapon_eternalreward", 10, "Eternal Reward");
	Cvars.CreateTF2Weapon(228, "xstats_points_weapon_blackbox", 10, "Black Box");
	Cvars.CreateTF2Weapon(230, "xstats_points_weapon_sydneysleeper", 10, "Sydney Sleeper");
	Cvars.CreateTF2Weapon(232, "xstats_points_weapon_bushwacka", 10, "Bushwacka");
	Cvars.SameWeapon(237, 18); //Rocket Jumper.
	Cvars.CreateTF2Weapon(239, "xstats_points_weapon_goru", 10, "Gloves of Running Urgently");
	Cvars.CreateTF2Weapon(264, "xstats_points_weapon_fryingpan", 10, "Frying Pan");
	Cvars.SameWeapon(265, 20);	//Sticky Jumper.
	Cvars.CreateTF2Weapon(266, "xstats_points_weapon_hhhh", 10, "Horseless Headless Horsemann's Headtaker");
	Cvars.SameWeapon(294, 160);	//Same Lugermorph, different TFQuality type.
	Cvars.CreateTF2Weapon(298, "xstats_points_weapon_ironcurtain", 10, "Iron Curtain");
	Cvars.CreateTF2Weapon(304, "xstats_points_weapon_amputator", 10, "Amputator");
	Cvars.CreateTF2Weapon(305, "xstats_points_weapon_crusaderscrossbow", 10, "Crusader's Crossbow");
	Cvars.CreateTF2Weapon(307, "xstats_points_weapon_ullapoolcaber", 10, "Ullapool Caber");
	Cvars.CreateTF2Weapon(308, "xstats_points_weapon_lochnload", 10, "Loch-n-Load");
	Cvars.CreateTF2Weapon(310, "xstats_points_weapon_warriorsspirit", 10, "Warrior's Spirit");
	Cvars.CreateTF2Weapon(312, "xstats_points_weapon_brassbeast", 10, "Brass Beast");
	Cvars.CreateTF2Weapon(317, "xstats_points_weapon_candycane", 10, "Candy Cane");
	Cvars.CreateTF2Weapon(325, "xstats_points_weapon_bostonbasher", 10, "Boston Basher");
	Cvars.CreateTF2Weapon(326, "xstats_points_weapon_backscratcher", 10, "Back Scratcher");
	Cvars.CreateTF2Weapon(327, "xstats_points_weapon_claidheamhmor", 10, "Claidheamh Mór");
	Cvars.CreateTF2Weapon(329, "xstats_points_weapon_jag", 10, "Jag");
	Cvars.CreateTF2Weapon(331, "xstats_points_weapon_fistsofsteel", 10, "Fists Of Steel");
	Cvars.CreateTF2Weapon(348, "xstats_points_weapon_sharpenedvolcanofragment", 10, "Sharpened Volcano Fragment");
	Cvars.CreateTF2Weapon(349, "xstats_points_weapon_sunonastick", 10, "Sun-On-A-Stick");
	Cvars.CreateTF2Weapon(351, "xstats_points_weapon_detonator", 10, "Detonator");
	Cvars.CreateTF2Weapon(355, "xstats_points_weapon_fanowar", 10, "Fan O' War");
	Cvars.CreateTF2Weapon(356, "xstats_points_weapon_conniverskunai", 10, "Conniver's Kunai");
	Cvars.CreateTF2Weapon(357, "xstats_points_weapon_halfzatoichi", 10, "Half-Zatoichi");
	Cvars.CreateTF2Weapon(401, "xstats_points_weapon_shahanshah", 10, "Shahanshah");
	Cvars.CreateTF2Weapon(402, "xstats_points_weapon_bazaarbargain", 10, "Bazaar Bargain");
	Cvars.CreateTF2Weapon(404, "xstats_points_weapon_persainpersuader", 10, "Persain Pursuader");
	Cvars.CreateTF2Weapon(406, "xstats_points_weapon_splendidscreen", 10, "Splendid Screen");
	Cvars.CreateTF2Weapon(412, "xstats_points_weapon_overdose", 10, "Overdose");
	Cvars.CreateTF2Weapon(413, "xstats_points_weapon_solemnvow", 10, "Solmen Wov");
	Cvars.CreateTF2Weapon(414, "xstats_points_weapon_libertylauncher", 10, "Liberty Launcher");
	Cvars.CreateTF2Weapon(415, "xstats_points_weapon_reserveshooter", 10, "Reserve Shooter");
	Cvars.CreateTF2Weapon(416, "xstats_points_weapon_marketgardener", 10, "Market Gardener");
	Cvars.CreateTF2Weapon(423, "xstats_points_weapon_saxxy", 10, "Saxxy");
	Cvars.CreateTF2Weapon(424, "xstats_points_weapon_tomislav", 10, "Tomislav");
	Cvars.CreateTF2Weapon(425, "xstats_points_weapon_familybusiness", 10, "Family Business");
	Cvars.CreateTF2Weapon(426, "xstats_points_weapon_evictionnotice", 10, "Eviction Notice");
	Cvars.CreateTF2Weapon(441, "xstats_points_weapon_cowmangler5000", 10, "Cow Mangler 5000");
	Cvars.CreateTF2Weapon(442, "xstats_points_weapon_righteousbison", 10, "Righteous Bison");
	Cvars.CreateTF2Weapon(444, "xstats_points_weapon_mantreads", 10, "Mantreads");
	Cvars.CreateTF2Weapon(447, "xstats_points_weapon_disciplinaryaction", 10, "Disciplinary Action");
	Cvars.CreateTF2Weapon(448, "xstats_points_weapon_sodapopper", 10, "Soda Popper");
	Cvars.CreateTF2Weapon(449, "xstats_points_weapon_winger", 10, "Winger");
	Cvars.CreateTF2Weapon(450, "xstats_points_weapon_atomizer", 10, "Atomizer");
	Cvars.CreateTF2Weapon(452, "xstats_points_weapon_threeruneblade", 10, "Three Rune Blade");
	Cvars.CreateTF2Weapon(457, "xstats_points_weapon_postalpummeler", 10, "Postal Pummeler");
	Cvars.CreateTF2Weapon(460, "xstats_points_weapon_enforcer", 10, "Enforcer");
	Cvars.CreateTF2Weapon(461, "xstats_points_weapon_bigearner", 10, "Big Earner");
	Cvars.CreateTF2Weapon(466, "xstats_points_weapon_maul", 10, "Maul");
	Cvars.CreateTF2Weapon(474, "xstats_points_weapon_conscentiousobjector", 10, "Conscentious Objector");
	Cvars.CreateTF2Weapon(482, "xstats_points_weapon_nessiesnineiron", 10, "Nessie's Nine-Iron");
	Cvars.CreateTF2Weapon(513, "xstats_points_weapon_original", 10, "Original");
	Cvars.CreateTF2Weapon(525, "xstats_points_weapon_diamondback", 10, "Diamondback");
	Cvars.CreateTF2Weapon(526, "xstats_points_weapon_machina", 10, "Machina");
	Cvars.CreateTF2Weapon(527, "xstats_points_weapon_widowmaker", 10, "Widowmaker");
	Cvars.CreateTF2Weapon(528, "xstats_points_weapon_shortcircuit", 10, "Short Circuit");
	Cvars.CreateTF2Weapon(572, "xstats_points_weapon_unarmedcombat", 10, "Unarmed Combat");
	Cvars.CreateTF2Weapon(574, "xstats_points_weapon_wangaprick", 10, "Wanga Prick");
	Cvars.CreateTF2Weapon(587, "xstats_points_weapon_apocofists", 10, "Apoco Fists");
	Cvars.CreateTF2Weapon(588, "xstats_points_weapon_pomson6000", 10, "Pomson 6000");
	Cvars.CreateTF2Weapon(589, "xstats_points_weapon_eurekaeffect", 10, "Eureka Effect");
	Cvars.CreateTF2Weapon(593, "xstats_points_weapon_thirddegree", 10, "Third Degree");
	Cvars.CreateTF2Weapon(594, "xstats_points_weapon_phlogistinator", 10, "Phlogistinator.");
	Cvars.CreateTF2Weapon(595, "xstats_points_weapon_manmelter", 10, "Man Melter");
	Cvars.CreateTF2Weapon(609, "xstats_points_weapon_scottishhandshake", 10, "Scottish Handshake");
	Cvars.CreateTF2Weapon(638, "xstats_points_weapon_sharpdresser", 10, "Sharp Dresser");
	Cvars.CreateTF2Weapon(648, "xstats_points_weapon_wrapassassin", 10, "Wrap Assassin");
	Cvars.CreateTF2Weapon(649, "xstats_points_weapon_spycicle", 10, "Spycicle");
	Cvars.SameWeapon(654, 15); //Festive Minigun.
	Cvars.CreateTF2Weapon(656, "xstats_points_weapon_holidaypunch", 10, "Holiday Punch");
	Cvars.SameWeapon(658, 18); //Festive Rocket Launcher.
	Cvars.SameWeapon(659, 21); //Festive Flamethrower.
	Cvars.SameWeapon(660, 0); //Festive Bat.
	Cvars.SameWeapon(661, 20); //Festive StickyBomb Launcher.
	Cvars.SameWeapon(662, 7); //Festive Wrench.
	Cvars.SameWeapon(664, 14); //Festive Sniper Rifle.
	Cvars.SameWeapon(665, 4); //Festive Knife.
	Cvars.SameWeapon(669, 13); //Festive Scattergun.
	Cvars.CreateTF2Weapon(727, "xstats_points_weapon_blackrose", 10, "Blackrose");
	Cvars.CreateTF2Weapon(739, "xstats_points_weapon_lollichop", 10, "Lollichop");
	Cvars.CreateTF2Weapon(740, "xstats_points_weapon_scorchshot", 10, "Scorch Shot");
	Cvars.CreateTF2Weapon(741, "xstats_points_weapon_rainblower", 10, "Rainblower");
	Cvars.CreateTF2Weapon(751, "xstats_points_weapon_cleanerscarbine", 10, "Cleaner's Carbine");
	Cvars.CreateTF2Weapon(752, "xstats_points_weapon_hitmansheatmaker", 10, "Hitman's Heatmaker");
	Cvars.CreateTF2Weapon(772, "xstats_points_weapon_babyfacesblaster", 10, "Baby Face's Blaster");
	Cvars.CreateTF2Weapon(773, "xstats_points_weapon_prettyboyspocketpistol", 10, "Pretty Boy's Pocket Pistol");
	Cvars.CreateTF2Weapon(775, "xstats_points_weapon_escapeplan", 10, "Escape Plan");
	Cvars.SameWeapon(792, 14); //Default Sniper Rifle.			Silver Botkiller Mk. I.
	Cvars.SameWeapon(793, 15); //Default Minigun.				Silver Botkiller Mk. I.
	Cvars.SameWeapon(795, 7); //Default Wrench.					Silver Botkiller Mk. I.
	Cvars.SameWeapon(797, 20); //Default Stickybomb Launcher.	Silver Botkiller Mk. I.
	Cvars.SameWeapon(798, 21); //Default Flamethrower.			Silver Botkiller Mk. I.
	Cvars.SameWeapon(799, 13); //Default Scattergun.			Silver Botkiller Mk. I.
	Cvars.SameWeapon(800, 18); //Default Rocket Launcher.		Silver Botkiller Mk. I.
	Cvars.SameWeapon(801, 14); //Default Sniper Rifle.			Gold Botkiller Mk. I.
	Cvars.SameWeapon(802, 15); //Default Minigun.				Gold Botkiller Mk. I.
	Cvars.SameWeapon(804, 7); //Default Wrench.					Gold Botkiller Mk. I.
	Cvars.SameWeapon(806, 20); //Default Stickybomb Launcher.	Gold Botkiller Mk. I.
	Cvars.SameWeapon(807, 21); //Default Flamethrower.			Gold Botkiller Mk. I.
	Cvars.SameWeapon(808, 13); //Default Scattergun.			Gold Botkiller Mk. I.
	Cvars.SameWeapon(809, 18); //Default Rocket Launcher.		Gold Botkiller Mk. I.
	Cvars.CreateTF2Weapon(811, "xstats_points_weapon_huolongheater", 10, "Huo-Long Heater");
	Cvars.CreateTF2Weapon(812, "xstats_points_weapon_flyingguillotine", 10, "Flying Guillotine");
	Cvars.CreateTF2Weapon(813, "xstats_points_weapon_neonannihilator", 10, "Neon Annihilator");
	Cvars.SameWeapon(832, 811); //Genuine Huo-Long Heater.
	Cvars.SameWeapon(833, 812); //Genuine Flying Guillotine.
	Cvars.SameWeapon(834, 813); //Genuine Neon Annihilator.
	Cvars.SameWeapon(850, 15); //Deflector (MvM Minigun used by Giant Deflector Heavies.)
	Cvars.CreateTF2Weapon(851, "xstats_points_weapon_awperhand", 10, "AWPer Hand");
	Cvars.CreateTF2Weapon(880, "xstats_points_weapon_freedomstaff", 10, "Freedom Staff");
	Cvars.SameWeapon(881, 14); //Default Sniper Rifle.			Rust Botkiller Mk. I.
	Cvars.SameWeapon(882, 15); //Default Minigun.				Rust Botkiller Mk. I.
	Cvars.SameWeapon(884, 7); //Default Wrench.					Rust Botkiller Mk. I.
	Cvars.SameWeapon(886, 20); //Default Stickybomb Launcher.	Rust Botkiller Mk. I.
	Cvars.SameWeapon(887, 21); //Default Flamethrower.			Rust Botkiller Mk. I.
	Cvars.SameWeapon(888, 13); //Default Scattergun.			Rust Botkiller Mk. I.
	Cvars.SameWeapon(889, 18); //Default Rocket Launcher.		Rust Botkiller Mk. I.
	Cvars.SameWeapon(890, 14); //Default Sniper Rifle.			Blood Botkiller Mk. I.
	Cvars.SameWeapon(891, 15); //Default Minigun.				Blood Botkiller Mk. I.
	Cvars.SameWeapon(893, 7); //Default Wrench.					Blood Botkiller Mk. I.
	Cvars.SameWeapon(895, 20); //Default Stickybomb Launcher.	Blood Botkiller Mk. I.
	Cvars.SameWeapon(896, 21); //Default Flamethrower.			Blood Botkiller Mk. I.
	Cvars.SameWeapon(897, 13); //Default Scattergun.			Blood Botkiller Mk. I.
	Cvars.SameWeapon(898, 18); //Default Rocket Launcher.		Blood Botkiller Mk. I.
	Cvars.SameWeapon(899, 14); //Default Sniper Rifle.			Carbonado Botkiller Mk. I.
	Cvars.SameWeapon(900, 15); //Default Minigun.				Carbonado Botkiller Mk. I.
	Cvars.SameWeapon(902, 7); //Default Wrench.					Carbonado Botkiller Mk. I.
	Cvars.SameWeapon(904, 20); //Default Stickybomb Launcher.	Carbonado Botkiller Mk. I.
	Cvars.SameWeapon(905, 21); //Default Flamethrower.			Carbonado Botkiller Mk. I.
	Cvars.SameWeapon(906, 13); //Default Scattergun.			Carbonado Botkiller Mk. I.
	Cvars.SameWeapon(907, 18); //Default Rocket Launcher.		Carbonado Botkiller Mk. I.
	Cvars.SameWeapon(908, 14); //Default Sniper Rifle.			Diamond Botkiller Mk. I.
	Cvars.SameWeapon(909, 15); //Default Minigun.				Diamond Botkiller Mk. I.
	Cvars.SameWeapon(911, 7); //Default Wrench.					Diamond Botkiller Mk. I.
	Cvars.SameWeapon(913, 20); //Default Stickybomb Launcher.	Diamond Botkiller Mk. I.
	Cvars.SameWeapon(914, 21); //Default Flamethrower.			Diamond Botkiller Mk. I.
	Cvars.SameWeapon(915, 13); //Default Scattergun.			Diamond Botkiller Mk. I.
	Cvars.SameWeapon(916, 18); //Default Rocket Launcher.		Diamond Botkiller Mk. I.
	Cvars.CreateTF2Weapon(939, "xstats_points_weapon_batouttahell", 10, "Bat Outta Hell");
	Cvars.CreateTF2Weapon(954, "xstats_points_weapon_memorymaker",	10, "Memory Maker");
	Cvars.SameWeapon(957, 14); //Default Sniper Rifle.			Silver Botkiller Mk. II.
	Cvars.SameWeapon(958, 15); //Default Minigun.				Silver Botkiller Mk. II.
	Cvars.SameWeapon(960, 7); //Default Wrench.					Silver Botkiller Mk. II.
	Cvars.SameWeapon(962, 20); //Default Stickybomb Launcher.	Silver Botkiller Mk. II.
	Cvars.SameWeapon(963, 21); //Default Flamethrower.			Silver Botkiller Mk. II.
	Cvars.SameWeapon(964, 13); //Default Scattergun.			Silver Botkiller Mk. II.
	Cvars.SameWeapon(965, 18); //Default Rocket Launcher.		Silver Botkiller Mk. II.
	Cvars.SameWeapon(966, 14); //Default Sniper Rifle.			Gold Botkiller Mk. II.
	Cvars.SameWeapon(967, 15); //Default Minigun.				Gold Botkiller Mk. II.
	Cvars.SameWeapon(969, 7); //Default Wrench.					Gold Botkiller Mk. II.
	Cvars.SameWeapon(971, 20); //Default Stickybomb Launcher.	Gold Botkiller Mk. II.
	Cvars.SameWeapon(972, 21); //Default Flamethrower.			Gold Botkiller Mk. II.
	Cvars.SameWeapon(973, 13); //Default Scattergun.			Gold Botkiller Mk. II.
	Cvars.SameWeapon(974, 18); //Default Rocket Launcher.		Gold Botkiller Mk. II.
	Cvars.CreateTF2Weapon(996, "xstats_points_weapon_loosecannon", 10, "Loose Cannon");
	Cvars.CreateTF2Weapon(997, "xstats_points_weapon_rescueranger", 10, "Rescue Ranger");
	Cvars.SameWeapon(999, 221); //Festive Holy Mackerel.
	Cvars.SameWeapon(1000, 38); //Festive Axtinguisher.
	Cvars.SameWeapon(1003, 37); //Festive Ubersaw.
	Cvars.SameWeapon(1004, 141); //Festive Frontier Justice.
	Cvars.SameWeapon(1005, 56); //Festive Huntsman.
	Cvars.SameWeapon(1006, 61); //Festive Ambassador.
	Cvars.SameWeapon(1007, 19); //Festive Grenade Launcher.
	Cvars.CreateTF2Weapon(1013, "xstats_points_weapon_hamshank", 10, "Ham Shank");
	Cvars.SameWeapon(1071, 264);//Golden Frying Pan.
	Cvars.SameWeapon(1078, 45);	//Festive Force-A-Nature.
	Cvars.SameWeapon(1079, 305);//Festive Crusader's Crossbow.
	Cvars.SameWeapon(1081, 39);	//Festive Flare Gun.
	Cvars.SameWeapon(1082, 132);//Festive Eyelander.
	Cvars.SameWeapon(1084, 239);//Festive Gloves of Running Urgently.
	Cvars.SameWeapon(1085, 228);//Festive Black Box.
	Cvars.CreateTF2Weapon(1092, "xstats_points_weapon_fortifiedcompound", 10, "Fortified Compound");
	Cvars.CreateTF2Weapon(1098, "xstats_points_weapon_classic", 10, "Classic");
	Cvars.CreateTF2Weapon(1099, "xstats_points_weapon_tideturner", 10, "Tide Turner");
	Cvars.CreateTF2Weapon(1100, "xstats_points_weapon_breadbite", 10, "Bread Bite");
	Cvars.CreateTF2Weapon(1103, "xstats_points_weapon_backscatter", 10, "Back Scatter");
	Cvars.CreateTF2Weapon(1104, "xstats_points_weapon_airstrike", 10, "Air Strike");
	Cvars.CreateTF2Weapon(1123, "xstats_points_weapon_necrosmasher", 10, "Necro Smasher");
	Cvars.CreateTF2Weapon(1127, "xstats_points_weapon_crossingguard", 10, "Crossing Guard");
	Cvars.SameWeapon(1141, 9); //Festive Shotgun.
	Cvars.SameWeapon(1142, 24); //Festive Revolver.
	Cvars.SameWeapon(1144, 131); //Festive Chargin' Targe.
	Cvars.SameWeapon(1146, 40); //Festive Backburner.
	Cvars.SameWeapon(1149, 16); //Festive SMG.
	Cvars.CreateTF2Weapon(1150, "xstats_points_weapon_quickebomblauncher",	10, "Quickiebomb Launcher");
	Cvars.CreateTF2Weapon(1151, "xstats_points_weapon_ironbomber", 10, "Iron Bomber");
	Cvars.CreateTF2Weapon(1153, "xstats_points_weapon_panicattack", 10, "Panic Attack");
	Cvars.CreateTF2Weapon(1178, "xstats_points_weapon_dragonsfury", 10, "Dragon's Fury");
	Cvars.CreateTF2Weapon(1179, "xstats_points_weapon_thermalthruster", 10, "Thermal Thruster");
	Cvars.CreateTF2Weapon(1181, "xstats_points_weapon_hothand", 10, "Hot Hand");
	Cvars.SameWeapon(1184, 239);	//Gloves of Running Urgently. (Used by MvM Robots.)
	Cvars.SameWeapon(15000, 14);	//Skinned Sniper Rifle.			Night Owl.
	Cvars.SameWeapon(15001, 16);	//Skinned SMG.					Woodsy Widowmaker.
	Cvars.SameWeapon(15002, 13);	//Skinned Scattergun.			Night Terror.
	Cvars.SameWeapon(15003, 9);		//Skinned Shotgun.				Backwoods Boomstick.
	Cvars.SameWeapon(15004, 15);	//Skinned Minigun.				King of The Jungle.
	Cvars.SameWeapon(15005, 21);	//Skinned Flame Thrower.		Forest Fire.
	Cvars.SameWeapon(15006, 18);	//Skinned Rocket Launcher.		Woodland Warrior.
	Cvars.SameWeapon(15007, 14);	//Skinned Sniper Rifle.			Purple Range.
	Cvars.SameWeapon(15009, 20);	//Skinned Stickybomb Launcher.	Sudden Flurry.
	Cvars.SameWeapon(15011, 24);	//Skinned Revolver.				Psychedeic Slugger.
	Cvars.SameWeapon(15012, 20);	//Skinned Stickybomb Launcher.	Carpet Bomber.
	Cvars.SameWeapon(15013, 22);	//Skinned Pistol.				Red Rock Roscoe.
	Cvars.SameWeapon(15014, 18);	//Skinned Rocket Launcher.		Sand Cannon.
	Cvars.SameWeapon(15015, 13);	//Skinned Scattergun.			Tartan Torpedo.
	Cvars.SameWeapon(15016, 9);		//Skinned Shotgun.				Rustic Ruiner.
	Cvars.SameWeapon(15017, 21);	//Skinned Flame Thrower.		Barn Burner.
	Cvars.SameWeapon(15018, 22);	//Skinned Pistol.				Homemade Heater.
	Cvars.SameWeapon(15019, 14);	//Skinned Sniper Rifle.			Lumber From Down Under.
	Cvars.SameWeapon(15020, 15);	//Skinned Minigun.				Iron Wood.
	Cvars.SameWeapon(15021, 13);	//Skinned Scattergun.			Country Crusher.
	Cvars.SameWeapon(15022, 16);	//Skinned SMG.					Plaid Potshotter.
	Cvars.SameWeapon(15023, 14);	//Skinned Sniper Rifle.			Shot In The Dark.
	Cvars.SameWeapon(15024, 20);	//Skinned Grenade Launcher.		Blasted Bombardier.
	Cvars.SameWeapon(15026, 15);	//Skinned Minigun.				Antique Annihilator.
	Cvars.SameWeapon(15027, 24);	//Skinned Revolver.				Old Country.
	Cvars.SameWeapon(15028, 18);	//Skinned Rocket Launcher.		American Pastoral.
	Cvars.SameWeapon(15029, 13);	//Skinned Scattergun.			Backcountry Blaster.
	Cvars.SameWeapon(15030, 21);	//Skinned Flame Thrower.		Bovine Blazemaker.
	Cvars.SameWeapon(15031, 15);	//Skinned Minigun.				War Room.
	Cvars.SameWeapon(15032, 16);	//Skinned SMG.					Treadplate Tormenter.
	Cvars.SameWeapon(15033, 14);	//Skinned Sniper Rifle.			Bogtrotter.
	Cvars.SameWeapon(15034, 21);	//Skinned Flame Thrower.		Earth, Sky and Fire.
	Cvars.SameWeapon(15035, 22);	//Skinned Pistol.				Hickory Holepuncher.
	Cvars.SameWeapon(15036, 13);	//Skinned Scattergun.			Spruce Deuce.
	Cvars.SameWeapon(15037, 16);	//Skinned SMG.					Team Sprayer.
	Cvars.SameWeapon(15038, 20);	//Skinned Grenade Launcher.		Rooftop Wrangler.
	Cvars.SameWeapon(15040, 15);	//Skinned Minigun.				Citizen Pain.
	Cvars.SameWeapon(15041, 22);	//Skinned Pistol.				Local Hero.
	Cvars.SameWeapon(15042, 24);	//Skinned Revolver.				Mayor.
	Cvars.SameWeapon(15043, 18);	//Skinned Rocket Launcher.		Smalltown Bringdown.
	Cvars.SameWeapon(15044, 9);		//Skinned Shotgun.				Civic Duty.
	Cvars.SameWeapon(15045, 20);	//Skinned Stickybomb Launcher.	Liquid Asset.
	Cvars.SameWeapon(15046, 22);	//Skinned Pistol.				Black Dahlia.
	Cvars.SameWeapon(15047, 9);		//Skinned Shotgun.				Lightning Rod.
	Cvars.SameWeapon(15048, 20);	//Skinned Stickybomb Launcher.	Pink Elephant.
	Cvars.SameWeapon(15049, 21);	//Skinned Flame Thrower.		Flash Fryer.
	Cvars.SameWeapon(15051, 24);	//Skinned Revolver.				Dead Reckoner.
	Cvars.SameWeapon(15052, 18);	//Skinned Rocket Launcher.		Shell Shocker.
	Cvars.SameWeapon(15053, 13);	//Skinned Scattergun.			Current Event.
	Cvars.SameWeapon(15054, 21);	//Skinned Flame Thrower.		Turbine Torcher.
	Cvars.SameWeapon(15055, 15);	//Skinned Minigun.				Brick House.
	Cvars.SameWeapon(15056, 22);	//Skinned Pistol.				Sandstone Special.
	Cvars.SameWeapon(15057, 18);	//Skinned Rocket Launcher.		Aqua Marine.
	Cvars.SameWeapon(15058, 16);	//Skinned SMG.					Low Profile.
	Cvars.SameWeapon(15059, 14);	//Skinned Sniper Rifle.			Thunderbolt.
	Cvars.SameWeapon(15060, 22);	//Skinned Pistol.				Macabre Web.
	Cvars.SameWeapon(15061, 22);	//Skinned Pistol.				Nutcracker.
	Cvars.SameWeapon(15062, 24);	//Skinned Revolver.				Boneyard.
	Cvars.SameWeapon(15063, 24);	//Skinned Revolver.				Wildwood.
	Cvars.SameWeapon(15064, 24);	//Skinned Revolver.				Macabre Web.
	Cvars.SameWeapon(15065, 13);	//Skinned Scattergun.			Macabre Web.
	Cvars.SameWeapon(15066, 21);	//Skinned Flame Thrower.		Autumn.
	Cvars.SameWeapon(15067, 21);	//Skinned Flame Thrower.		Pumpkin Patch.
	Cvars.SameWeapon(15068, 21);	//Skinned Flame Thrower.		Nutcracker.
	Cvars.SameWeapon(15069, 13);	//Skinned Scattergun.			Nutcracker.
	Cvars.SameWeapon(15070, 14);	//Skinned Sniper Rifle.			Pumpkin Patch.
	Cvars.SameWeapon(15071, 14);	//Skinned Sniper Rifle.			Boneyard.
	Cvars.SameWeapon(15072, 14);	//Skinned Sniper Rifle.			Wildwood.
	Cvars.SameWeapon(15073, 7);		//Skinned Wrench.				Nutcracker.
	Cvars.SameWeapon(15074, 7);		//Skinned Wrench.				Autumn.
	Cvars.SameWeapon(15075, 7);		//Skinned Wrench.				Boneyard.
	Cvars.SameWeapon(15076, 16);	//Skinned SMG.					Wildwood.
	Cvars.SameWeapon(15077, 19);	//Skinned Grenade Launcher.		Autumn.
	Cvars.SameWeapon(15079, 19);	//Skinned Grenade Launcher.		Macabre Web.
	Cvars.SameWeapon(15081, 18);	//Skinned Rocket Launcher.		Autumn.
	Cvars.SameWeapon(15082, 20);	//Skinned Stickybomb Launcher.	Autumn.
	Cvars.SameWeapon(15083, 20);	//Skinned Stickybomb Launcher.	Pumpkin Patch.
	Cvars.SameWeapon(15084, 20);	//Skinned Stickybomb Launcher.	Macabre Web.
	Cvars.SameWeapon(15085, 9);		//Skinned Shotgun.				Autumn.
	Cvars.SameWeapon(15086, 15);	//Skinned Minigun.				Macabre Web.
	Cvars.SameWeapon(15087, 15);	//Skinned Minigun.				Pumpkin Patch.
	Cvars.SameWeapon(15088, 15);	//Skinned Minigun.				Nutcracker.
	Cvars.SameWeapon(15089, 21);	//Skinned Flame Thrower.		Balloonicorn.
	Cvars.SameWeapon(15090, 21);	//Skinned Flame Thrower.		Rainbow.
	Cvars.SameWeapon(15091, 19);	//Skinned Grenade Launcher.		Rainbow.
	Cvars.SameWeapon(15092, 19);	//Skinned Grenade Launcher.		Sweet Dreams.
	Cvars.SameWeapon(15094, 4);		//Skinned Knife.				Blue Mew.
	Cvars.SameWeapon(15095, 4);		//Skinned Knife.				Brain Candy.
	Cvars.SameWeapon(15096, 4);		//Skinned Knife.				Stabbed To Hell.
	Cvars.SameWeapon(15098, 15);	//Skinned Minigun.				Brain Candy.
	Cvars.SameWeapon(15099, 15);	//Skinned Minigun.				Mister Cuddles.
	Cvars.SameWeapon(15100, 22);	//Skinned Pistol.				Blue Mew.
	Cvars.SameWeapon(15101, 22);	//Skinned Pistol.				Brain Candy.
	Cvars.SameWeapon(15102, 22);	//Skinned Pistol.				Shot To Hell.
	Cvars.SameWeapon(15103, 24);	//Skinned Revolver.				Flower Power.
	Cvars.SameWeapon(15104, 18);	//Skinned Rocket Launcher.		Blue Mew.
	Cvars.SameWeapon(15105, 18);	//Skinned Rocket Launcher.		Brain Candy.
	Cvars.SameWeapon(15106, 13);	//Skinned Scattergun.			Bluw Mew.
	Cvars.SameWeapon(15107, 13);	//Skinned Scattergun.			Flower Power.
	Cvars.SameWeapon(15108, 13);	//Skinned Scattergun.			Shot to Hell.
	Cvars.SameWeapon(15109, 9);		//Skinned Shotgun.				Flower Power.
	Cvars.SameWeapon(15110, 15);	//Skinned SMG.					Blue Mew.
	Cvars.SameWeapon(15111, 14);	//Skinned Sniper Rifle.			Balloonicorn.
	Cvars.SameWeapon(15112, 14);	//Skinned Sniper Rifle.			Rainbow.
	Cvars.SameWeapon(15113, 20);	//Skinned Stickybomb Launcher.	Sweet Dreams.
	Cvars.SameWeapon(15114, 7);		//Skinned Wrench.				Torqued To Hell.
	Cvars.SameWeapon(15115, 21);	//Skinned Flame Thrower.		Coffin Nail.
	Cvars.SameWeapon(15116, 19);	//Skinned Grenade Launcher.		Coffin Nail.
	Cvars.SameWeapon(15117, 19);	//Skinned Grenade Launcher.		Top Shelf.
	Cvars.SameWeapon(15118, 4);		//Skinned Knife.				Dressed To Kill.
	Cvars.SameWeapon(15119, 4);		//Skinned Knife.				Top Shelf.
	Cvars.SameWeapon(15123, 15);	//Skinned Minigun.				Coffin Nail.
	Cvars.SameWeapon(15124, 15);	//Skinned Minigun.				Dressed To Kill.
	Cvars.SameWeapon(15125, 15);	//Skinned Minigun.				Top Shelf.
	Cvars.SameWeapon(15126, 22);	//Skinned Pistol.				Dressed To Kill.
	Cvars.SameWeapon(15127, 24);	//Skinned Revolver.				Top Shelf.
	Cvars.SameWeapon(15128, 24);	//Skinned Revolver.				Top Shelf.
	Cvars.SameWeapon(15129, 18);	//Skinned Rocket Launcher.		Coffin Nail.
	Cvars.SameWeapon(15130, 18);	//Skinned Rocket Launcher.		High Roller's.
	Cvars.SameWeapon(15131, 13);	//Skinned Scattergun.			Coffin Nail.
	Cvars.SameWeapon(15132, 9);		//Skinned Shotgun.				Coffin Nail.
	Cvars.SameWeapon(15133, 9);		//Skinned Shotgun.				Dressed To Kill.
	Cvars.SameWeapon(15134, 16);	//Skinned SMG.					High Roller's.
	Cvars.SameWeapon(15135, 14);	//Skinned Sniper Rifle.			Coffin Nail.
	Cvars.SameWeapon(15136, 14);	//Skinned Sniper Rifle.			Dressed To Kill.
	Cvars.SameWeapon(15137, 20);	//Skinned Stickybomb Launcher.	Coffin Nail.
	Cvars.SameWeapon(15138, 20);	//Skinned Stickybomb Launcher.	Dressed To Kill.
	Cvars.SameWeapon(15139, 7);		//Skinned Wrench.				Dressed To Kill.
	Cvars.SameWeapon(15140, 7);		//Skinned Wrench.				Top Shelf.
	Cvars.SameWeapon(15141, 21);	//Skinned Flame Thrower.		Warhawk.
	Cvars.SameWeapon(15142, 19);	//Skinned Grenade Launcher.		Warhawk.
	Cvars.SameWeapon(15143, 4);		//Skinned Knife.				Blitzkrieg.
	Cvars.SameWeapon(15144, 4);		//Skinned Knife.				Airwolf.
	Cvars.SameWeapon(15147, 15);	//Skinned Minigun.				Butcher Bird.
	Cvars.SameWeapon(15148, 22);	//Skinned Pistol.				Blitzkrieg.
	Cvars.SameWeapon(15149, 24);	//Skinned Revolver.				Blitzkrieg.
	Cvars.SameWeapon(15050, 18);	//Skinned Rocket Launcher.		Warhawk.
	Cvars.SameWeapon(15151, 13);	//Skinned Scattergun.			Killer Bee.
	Cvars.SameWeapon(15152, 9);		//Skinned Shotgun.				Red Bear.
	Cvars.SameWeapon(15153, 16);	//Skinned SMG.					Blitzkrieg.
	Cvars.SameWeapon(15154, 14);	//Skinned Sniper Rifle.			Airwolf.
	Cvars.SameWeapon(15155, 20);	//Skinned Stickybomb Launcher.	Blitzkrieg.
	Cvars.SameWeapon(15156, 7);		//Skinned Wrench.				Airwolf.
	Cvars.SameWeapon(15157, 13);	//Skinned Scattergun.			Corsair.
	Cvars.SameWeapon(15158, 19);	//Skinned Grenade Launcher.		Butcher Bird.
	Cvars.SameWeapon(19010, 18);	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 1.
	Cvars.SameWeapon(19011, 9);		//TF2Items Give Weapon: Beta Pocket Shotgun.
	Cvars.SameWeapon(19012, 129);	//TF2Items Give Weapon: Beta Split Equalizer 1.
	Cvars.SameWeapon(19013, 129);	//TF2Items Give Weapon: Beta Split Equalizer 2.
	Cvars.SameWeapon(19015, 14);	//TF2Items Give Weapon: Beta Sniper Rifle 1.
	Cvars.SameWeapon(19016, 18);	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 2.
	Cvars.SameWeapon(19017, 18);	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 3.
	Cvars.CreateTF2Weapon(30474, "xstats_points_weapon_nostromonapalmer", 10, "Nostromo Napalmer");
	Cvars.CreateTF2Weapon(30665, "xstats_points_weapon_shootingstar", 10, "Shooting star");
	Cvars.CreateTF2Weapon(30666, "xstats_points_weapon_capper", 10, "C.A.P.P.E.R");
	Cvars.CreateTF2Weapon(30667, "xstats_points_weapon_batsaber", 10, "Batsaber");
	Cvars.CreateTF2Weapon(30668, "xstats_points_weapon_gigarcounter", 10, "Gigar Counter");
	Cvars.CreateTF2Weapon(30758, "xstats_points_weapon_prinnymachete", 10, "Prinny Machete");	
	
	/* Other */
	TF2_Collat = CreateConVarInt("xstats_points_collateralkill", 2, "XStats: TF2 - Extra points given when pulling a collateral kill.", _, true);
	
	/* MvM - Arrayed to make it way easier to handle due to long event names */
	TF2_MvM[0] = CreateConVarInt("xstats_points_mvm_destroytank", 5, "XStats: TF2 - Points given to red team when tank is destroyed.", _, true);
	TF2_MvM[1] = CreateConVarInt("xstats_points_mvm_killsentrybuster", 5, "XStats: TF2 - Points given when killing Sentry Buster.", _, true);
	TF2_MvM[2] = CreateConVarInt("xstats_points_mvm_resetbomb", 5, "XStats: TF2 - Points given when bomb is reset.", _, true);
	
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
stock void MvM_Tank_Destroyed_By_Players(Event event, const char[] event_name, bool dontBroadcast) {
	if(!IsValidStats() || !TF2_IsMvMGameMode() || TF2_MvM[0].IntValue < 1) return;
	
	int points = TF2_MvM[0].IntValue;
	int count = 0;
	
	TargetLoopEx(client) {
		if(Tklib_IsValidClient(client, true) && !IsValidAbuse(client) && TF2_GetClientTeam(client) == TFTeam_Red)	{
			count++;
			
			Session[client].AddPoints(points);
			Session[client].TanksDestroyed++;
			
			char query[512];
			Format(query, sizeof(query), "update `%s` set Points = Points+%i, TanksDestroyed = TanksDestroyed+1 where SteamID='%s' and ServerID='%i'",
			Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
		}
	}
	
	if(count < 1) return; /* Nothing happens after this if count is below 1 */
	CPrintToChatAll("%s %t", Global.Prefix, "MVM Team Destroyed Tank", TF2_TeamNameEx[2], points);
}

/*	Need to use "player_death" event since "mvm_sentrybuster_killed"
	doesn't offer a killer userid/entity index
	but the sentry buster entity itself only. */
stock void MvM_Sentrybuster_Killed(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats() || !TF2_IsMvMGameMode() || TF2_MvM[1].IntValue < 1) return;
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	if(!Tklib_IsValidClient(client, true)) return;
	if(IsValidAbuse(client)) return;
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(client)) return;
	if(!(IsFakeClient(victim) && TF2_GetClientTeam(victim) == TFTeam_Blue)) return; /* Make sure it's a TFBot and is on blue team. */
	
	char sentry_buster[64];
	Format(sentry_buster, sizeof(sentry_buster), "%N", victim);
	
	int defindex = Ent(TF2_GetPlayerWeaponSlot(victim, TFSlot_Melee)).DefinitionIndex;
	if(!(StrContainsEx(sentry_buster, "Sentry Buster") && defindex == 307)) return; /* Make sure the TFBot has the correct name and Ullapool Caber. */
	
	int points = TF2_MvM[1].IntValue;
	Player[client].Points = GetClientPoints(Player[client].SteamID);
	
	Session[client].SentryBustersKilled++;
	Session[client].AddPoints(points);
	CPrintToChat(client, "%s %t", Global.Prefix, "MvM Kill Sentry Buster", Player[client].Name, Player[client].Points, points);
	
	char query[512];
	Format(query, sizeof(query), "update `%s` set Points = Points+%i, SentryBustersKilled = SentryBustersKilled+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
}

stock void MvM_Bomb_Reset_By_Player(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats() || !TF2_IsMvMGameMode() || TF2_MvM[2].IntValue < 1) return;
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_PLAYER));
	if(!Tklib_IsValidClient(client, true)) return;
	if(IsValidAbuse(client)) return;
	
	int points = TF2_MvM[2].IntValue;
	Player[client].Points = GetClientPoints(Player[client].SteamID);
	
	Session[client].BombsResetted++;
	Session[client].AddPoints(points);
	CPrintToChat(client, "%s %t", Global.Prefix, "MvM Player Reset Bomb", Player[client].Name, Player[client].Points, points);
	
	char query[512];
	Format(query, sizeof(query), "update `%s` set Points = Points+%i, BombsResetted = BombsResetted+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
}

/* Item found */
stock void Item_Found_TF2(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!Cvars.ServerID.IntValue) return;
	if(event.GetBool("isfake"))	return; //Item is fake, this event bool doesn't exist in the game in general but you can force this event and use this.
	
	int client = event.GetInt(EVENT_STR_PLAYER)
	, quality = event.GetInt(EVENT_STR_QUALITY)
	, method = event.GetInt(EVENT_STR_METHOD)
	, defindex = event.GetInt(EVENT_STR_ITEMDEF);
	float wear = event.GetFloat(EVENT_STR_WEAR);
	if(!Tklib_IsValidClient(client, true)) return;
	
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
		"Collector's"
	};
	
	SQL.QueryEx(DBQuery_Callback, "insert into `%s` ("
	... "ServerID,"
	... "SteamID,"
	... "QualityID,"
	... "Quality,"
	... "MethodID,"
	... "Method,"
	... "DefinitionIndex,"
	... "Wear"
	... ") values ("
	... "'%i',"
	... "'%s',"
	... "'%i',"
	... "'%s',"
	... "'%i',"
	... "'%s',"
	... "'%i',"
	... "'%f')"
	, Global.item_found
	, Cvars.ServerID.IntValue
	, Player[client].SteamID
	, quality
	, quality_name
	, method
	, method_name[method]
	, defindex
	, wear
	, Player[client].Playername);
	
	XStats_DebugText(false, "// ===== Item_Found_TF2 ===== \\"
	... "\nInserting (ServerID, SteamID, QualityID, Quality, MethodID, Method, DefinitionIndex, Wear)"
	... "\nWith values ('%i', '%s', '%i', '%s', '%i', '%s', '%i', '%f')"
	... "\nonto %s"
	, Cvars.ServerID.IntValue
	, Player[client].SteamID
	, quality
	, quality_name
	, method
	, method_name[method]
	, defindex
	, wear
	, Global.item_found);
}

/* Deaths */
stock void Player_Death_TF2(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats() || TF2_IsMvMGameMode()) return;
	
	//It's a fake death.
	if(event.GetInt(EVENT_STR_DEATH_FLAGS) & TF_DEATHFLAG_DEADRINGER) {
		event.SetBool("fakedeath", true);
		XStats_DebugText(false, "//===== XStats Debug Log: Player_Death_TF2 =====//" ... "\nDetected fake death, ignoring.");
		return;
	}
	
	/* Get the values early for lowest delay. */
	
	char weapon[96];
	event.GetString(EVENT_STR_WEAPON_LOGCLASSNAME, weapon, sizeof(weapon));
	
	if(StrEqual(weapon, "player") || StrEqual(weapon, "world")) {
	//if(customkill & TF_CUSTOM_SUICIDE) { TF_CUSTOM_SUICIDE is broken, applied on any kill event :|
		XStats_DebugText(false, "//===== XStats Debug Log: Player_Death_TF2 =====//" ... "\nDetected invalid killer (suicide), ignoring to prevent issues..\n");
		return;	
	}
	
	int points = 0
	, client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER))
	, victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID))
	, assist = GetClientOfUserId(event.GetInt(EVENT_STR_ASSISTER))
	, inflictor = event.GetInt(EVENT_STR_INFLICTOR_ENTINDEX)
	, defindex = event.GetInt(EVENT_STR_WEAPON_DEF_INDEX)
	, customkill = event.GetInt(EVENT_STR_CUSTOMKILL)
	, deathflags = event.GetInt(EVENT_STR_DEATH_FLAGS)
	, penetrated = event.GetInt(EVENT_STR_PENETRATED)
	, crits = event.GetInt(EVENT_STR_CRIT_TYPE)
	, time = GetTime();
	
	if(!Tklib_IsValidClient(client, true) || !Tklib_IsValidClient(victim)) return;
	if(IsValidAbuse(client) || IsSamePlayers(client, victim) || IsSameTeam(client, victim) || IsFakeClient(victim) && !Cvars.AllowBots.BoolValue) return;
	
	/* Kill event stuff */
	bool headshot = (customkill == TF_CUSTOM_HEADSHOT || customkill == TF_CUSTOM_HEADSHOT_DECAPITATION)
	, backstab = (customkill == TF_CUSTOM_BACKSTAB)
	, noscope = ((customkill == 11 || defindex == 1098) && !TF2_IsPlayerInCondition(client, TFCond_Zoomed))
	, bleedkill = (customkill == TF_CUSTOM_BLEEDING)
	, dominated = false
	, dominated_assister = false
	, revenge = false
	, revenge_assister = false
	, gibkill = false
	, collateral = (penetrated > 0)
	, deflectkill = (StrContainsEx(weapon, "deflect", false) || StrContainsEx(weapon, "reflect"))
	, tauntkill = (StrContainsEx(weapon, "taunt", false)
	/* Rainblower tauntkill */
	|| (StrEqual(weapon, "armageddon", false))
	/* Thermal thruster taunt kill */
	|| (StrEqual(weapon, "gas_blast", false))
	/* Spy knife taunt kill */
	|| customkill == 13)
	, telefrag = StrEqual(weapon, "telefrag")
	, midair = IsClientMidAir(client)
	, airshot = (GetClientFlags(victim) == 258);
	
	/*
	if(GetEntityFlags(victim) & FL_FLY) {
		airshot = true;
		XStats_DebugText(false, "Airshot");
	}
	*/
	
	/*	Backup death flags checks incase example attacker
		and assister gets domination or revenge at the same time. */
	if(deathflags & TF_DEATHFLAG_KILLERDOMINATION) {
		dominated = true;
		XStats_DebugText(false, "Killer dominated");
	}
	if(deathflags & TF_DEATHFLAG_ASSISTERDOMINATION) {
		dominated_assister = true;
		XStats_DebugText(false, "Assister dominated");
	}
	if(deathflags & TF_DEATHFLAG_KILLERREVENGE) {
		revenge = true;
		XStats_DebugText(false, "Killer revenged");
	}
	if(deathflags & TF_DEATHFLAG_ASSISTERREVENGE) {
		revenge_assister = true;
		XStats_DebugText(false, "Assister revenged");
	}
	if(deathflags & TF_DEATHFLAG_GIBBED/* || deathflags & TF_DEATHFLAG_PURGATORY*/) {
		gibkill = true;
		XStats_DebugText(false, "Gibkill");
	}
	//if(customkill & TF_CUSTOM_TELEFRAG) telefrag = true;
	//if(customkill & TF_CUSTOM_PENETRATE_MY_TEAM) XStats_DebugText(false, "Penetrated through teammate.");
	//if(customkill & TF_CUSTOM_PENETRATE_HEADSHOT) XStats_DebugText(false, "Penetrated headshot.");
	//if(customkill & TF_CUSTOM_PENETRATE_ALL_PLAYERS) XStats_DebugText(false, "Penetrated through all players.");
	
	event.SetBool("dominated", dominated);
	event.SetBool("dominated_assister", dominated_assister);
	event.SetBool("revenge", revenge);
	event.SetBool("revenge_assister", revenge);
	event.SetBool("gibkill", gibkill);
	event.SetBool("headshot", headshot);
	event.SetBool("backstab", backstab);
	event.SetBool("noscope", noscope);
	event.SetBool("bleedkill", bleedkill);
	event.SetBool("deflectkill", deflectkill);
	event.SetBool("tauntkill", tauntkill);
	event.SetBool("telefrag", telefrag);
	event.SetBool("midair", midair);
	event.SetBool("airshot", airshot);
		
	// The 'weapon_def_index' on the player_death is same as if you're gathering the killers
	// current active weapon definition index and is NOT gathering the correct definition index at the time of the event.
	// So we need to manually correct them.
	// This happens when example throwing out a grenade launcher pill and then switch to your stickybomb launcher or melee, it'll pull the definition index out of that weapon instead.
	// This also just happens on certain weapons. Just dumb. tf2 team pls fix this bug.
	
	// PrintToServer("weaponid: %d", event.GetInt("weaponid"));
	
	if(bleedkill) defindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Melee)).DefinitionIndex; //Only part of melee weapons.
	
	// Lets fix these since when you swap weapons just before the kill on some weapons,
	// it'll pick definition index out of that weapon instead of the actual weapon that were used.
	
	/* Rocket Launcher. */
	if(StrEqual(weapon, "tf_projectile_rocket", false))	{
		int getindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Primary)).DefinitionIndex;
		/* If the gathered index is invalid (left or died during process), this returns 18 for safety. */
		defindex = getindex != -1 ? getindex : 18;
	}
	
	/* Grenade Launcher. */
	if(StrEqual(weapon, "tf_projectile_pipe", false)) defindex = 19;
	
	/* StickyBomb Launcher. */
	if(StrEqual(weapon, "tf_projectile_pipe_remote", false)) defindex = 20;
	
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
	
	
	if(StrEqual(weapon, "sticky_resistance", false)) defindex = 130; /* Scottish Resistance. */
	if(StrEqual(weapon, "loch_n_load", false)) defindex = 308; /* Loch-N-Load. */
	if(StrEqual(weapon, "quickiebomb_launcher", false)) defindex = 1150; /* QuickieBomb Launcher. */
	if(StrEqual(weapon, "iron_bomber", false)) defindex = 1151; /* Iron Bomber. */
	
	/* Correct the event's weapon definition index. */
	event.SetInt(EVENT_STR_WEAPON_DEF_INDEX, defindex);
	
	/* Make sure the weapon definition index exists on the array */
	ConVar cvar = Cvars.GetWeaponCvar(defindex);
	if(!cvar) {
		PrintToServer("[XStats: TF2] Weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.", weapon, defindex);
		return;
	}
	
	/* Make sure to continue if the points are valid. */
	switch(TF2_GetBuildingType(inflictor)) {
		case TFBuilding_Sentrygun: if((points = TF2_SentryKill.IntValue) < 1) return;
		case TFBuilding_MiniSentry:	if((points = TF2_MiniSentryKill.IntValue) < 1) return;
		default: if((points = cvar.IntValue) < 1) return;
	}
	
	/* The database query upload ("bat" -> "tf_weapon_bat") */
	char fix_weapon[96];
	if(!telefrag) TF2_FixWeaponClassname(client, fix_weapon, sizeof(fix_weapon), defindex, weapon);
	
	/* Debug */
	XStats_DebugText(false, "//===== Player_Death_TF2 =====//"
	... "\nClient %s (index %i)"
	... "\nVictim %s (index %i)"
	... "\nAssist %s (index %i)"
	... "\ninflictor %i"
	... "\nweapon \"%s\""
	... "\ndefindex %i"
	... "\ncustomkill %i"
	... "\ndeathflags %i"
	... "\npenetrated %i"
	... "\ncrit type %i [%s]"
	... "\nMidair %s"
	... "\nPoints %i\n"
	, Player[client].Playername, client
	, Player[victim].Playername, victim
	, Tklib_IsValidClient(assist) ? Player[assist].Playername : "no assister", assist
	, inflictor
	, fix_weapon
	, defindex
	, customkill
	, deathflags
	, penetrated
	, crits, TF2_CritTypeName[crits]
	, Bool[midair]
	, points);
	
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
	
	TF2_ClientKillVictim(client, victim);
	PrepareOnDeathForward(client, victim, assist, weapon, defindex);
	
	//There was an assist.
	if(AssistedKill(assist, client, victim)) {
		if(dominated_assister) {
			Session[assist].Dominations++;
			SQL.QueryEx(DBQuery_Callback, "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID = %i", Global.playerlist, Player[assist].SteamID, Cvars.ServerID.IntValue);
		}
		if(revenge_assister) {
			Session[assist].Revenges++;
			SQL.QueryEx(DBQuery_Callback, "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID = %i", Global.playerlist, Player[assist].SteamID, Cvars.ServerID.IntValue);
		}
	}
	
	//Make sure to not query updates on a bot, the database wouldn't be happy about that.
	VictimDied(victim);
	
	//Smarter system.
	char query[512];
	int len = 0;
	
	Session[client].Kills++;
	len += Format(query[len], sizeof(query)-len, "update `%s` set Kills = Kills+1", Global.playerlist);
	
	//If the inflictor entity is a building.
	switch(TF2_IsEntityBuilding(inflictor))	{
		case true: {
			switch(TF2_GetBuildingType(inflictor)) {
				case TFBuilding_Dispenser: XStats_DebugText(false, "Building: Dispenser lvl %i (?!)", TF2_GetBuildingLevel(inflictor));
				case TFBuilding_Sentrygun:	{
					Session[client].Sentrykills++;
					len += Format(query[len], sizeof(query)-len, ", SentryKills = SentryKills+1");
					
					int level = TF2_GetBuildingLevel(inflictor);
					switch(level) {
						case 1: {
							Session[client].SentryLVL1Kills++;
							len += Format(query[len], sizeof(query)-len, ", SentryLVL1Kills = SentryLVL1Kills+1");
						}
						
						case 2: {
							Session[client].SentryLVL2Kills++;
							len += Format(query[len], sizeof(query)-len, ", SentryLVL2Kills = SentryLVL2Kills+1");
						}
						
						case 3: {
							Session[client].SentryLVL3Kills++;
							len += Format(query[len], sizeof(query)-len, ", SentryLVL3Kills = SentryLVL3Kills+1");
						}
					}
					
					XStats_DebugText(false, "Building: Sentry lvl %i", level);
				}
				case TFBuilding_MiniSentry:	{
					Session[client].MiniSentrykills++;
					len += Format(query[len], sizeof(query)-len, ", MiniSentryKills = MiniSentryKills+1");
					XStats_DebugText(false, "Building: Mini-Sentry");
				}
			}
		}
		case false: {
			switch(telefrag) {
				case true: {
					Session[client].Telefrags++;
					points += TF2_TeleFrag.IntValue;
					Session[client].AddPoints(TF2_TeleFrag.IntValue);
					len += Format(query[len], sizeof(query)-len, ", Telefrags = Telefrags+1");
					XStats_DebugText(false, "Telefrag");
				}
				case false: SQL.QueryEx(DBQuery_Callback, "update `%s` set %s = %s+1 where SteamID='%s' and ServerID='%i'", Global.weapons, fix_weapon, fix_weapon, Player[client].SteamID, Cvars.ServerID.IntValue);
			}
		}
	}
	
	if(headshot) {
		Session[client].Headshots++;
		len += Format(query[len], sizeof(query)-len, ", Headshots = Headshots+1");
		XStats_DebugText(false, "Headshot");
	}
		
	if(backstab) {
		Session[client].Backstabs++;
		len += Format(query[len], sizeof(query)-len, ", Backstabs = Backstab+1");
		XStats_DebugText(false, "Backstab");
	}
		
	if(dominated) {
		Session[client].Dominations++;
		len += Format(query[len], sizeof(query)-len, ", Dominations = Dominations+1");
		XStats_DebugText(false, "Dominated");
	}
		
	if(revenge) {
		Session[client].Revenges++;
		len += Format(query[len], sizeof(query)-len, ", Revenges = Revenges+1");
		XStats_DebugText(false, "Revenge");
	}
		
	if(noscope) {
		Session[client].Noscopes++;
		len += Format(query[len], sizeof(query)-len, ", Noscopes = Noscopes+1");
		XStats_DebugText(false, "Noscope");
	}
		
	if(tauntkill) {
		Session[client].Tauntkills++;
		len += Format(query[len], sizeof(query)-len, ", TauntKills = TauntKills+1");
		XStats_DebugText(false, "Tauntkill");
	}
	
	if(deflectkill) {
		Session[client].Deflects++;
		len += Format(query[len], sizeof(query)-len, ", Deflects = Deflects+1");
		XStats_DebugText(false, "Deflectkill");
	}
	
	if(gibkill) {
		Session[client].Gibs++;
		len += Format(query[len], sizeof(query)-len, ", Gibs = Gibs+1");
		XStats_DebugText(false, "Gibkill");
	}
	
	if(airshot) {
		Session[client].Airshots++;
		len += Format(query[len], sizeof(query)-len, ", Airshots = Airshots+1");
		XStats_DebugText(false, "Airshot");
	}
	
	if(collateral) {
		Session[client].Collaterals++;
		len += Format(query[len], sizeof(query)-len, ", Collaterals = Collaterlas+1");
		if(TF2_Collat.IntValue > 0) points += TF2_Collat.IntValue;
		XStats_DebugText(false, "Collateral");
	}
	
	if(midair) {
		Session[client].MidAirKills++;
		len += Format(query[len], sizeof(query)-len, ", MidAirKills = MidAirKills+1");
		XStats_DebugText(false, "MidAir Kill");
	}
		
	switch(view_as<TFCritType>(crits)) {
		case TFCritType_Minicrit: {
			Session[client].MiniCritkills++;
			len += Format(query[len], sizeof(query)-len, ", MiniCritKills = MiniCritKills+1");
			XStats_DebugText(false, "Mini-Crit");
		}
		case TFCritType_Crit: {
			Session[client].Critkills++;
			len += Format(query[len], sizeof(query)-len, ", CritKills = CritKills+1");
			XStats_DebugText(false, "Crit");
		}
	}
	
	if(points > 0) {
		Session[client].AddPoints(points);
		XStats_DebugText(false, "Processing kill message..\n");
		
		len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
		PrepareKillMessage(client, victim, points);
	}
	
	len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
	
	OnDeathRankPanel(client);
	
	if(!IsFakeClient(victim)) {
		char log[320];
		Format(log, sizeof(log), "insert into `%s`"
		... "(ServerID, Time, SteamID, SteamID_Victim, SteamID_Assist, Weapon, Headshot, Backstab, Noscope, Midair, CritType)"
		... "values"
		... "(%i, %i, '%s', '%s', '%s', '%s', %i, %i, %i, %i, %i)"
		, Global.kill_log
		, Cvars.ServerID.IntValue
		, time
		, Player[client].SteamID
		, Player[victim].SteamID
		, Player[assist].SteamID
		, fix_weapon
		, headshot
		, backstab
		, noscope
		, midair
		, crits);
		SQL.Query(DBQuery_Kill_Log, log);
		
		// Testing the string length, no need for unneccessarily big amount of memory bytes, just a waste of memory usage otherwise.
		// Hangs around 259-270-ish
		//PrintToServer("String length log : %i", StrLen(log)); 
		
		XStats_DebugText(false, "//===== Kill Log TF2 =====\\"
		... "\nInserting kill log onto table %s ..."
		... "\nServerID: %i"
		... "\nTime: %i"
		... "\nSteamID: %s"
		... "\nSteamID_Victim: %s"
		... "\nSteamID_Assist: %s"
		... "\nWeapon: %s"
		... "\nHeadshot: %s"
		... "\nBackstab: %s"
		... "\nNoscope: %s"
		... "\nMidair: %s"
		... "\nCritType: %s\n"
		, Global.kill_log
		, Cvars.ServerID.IntValue
		, time
		, Player[client].SteamID
		, Player[victim].SteamID
		, !Tklib_IsValidClient(assist) ? "No assister" : Player[assist].SteamID
		, fix_weapon
		, Bool[headshot]
		, Bool[backstab]
		, Bool[noscope]
		, Bool[midair]
		, TF2_CritTypeName[crits]);
	}
}