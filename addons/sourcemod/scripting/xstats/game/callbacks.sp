/**
 *	Fix the classnames & definition indexes to be correct. It's a mess.. So many weapons.. Please don't mind.
 *
 *	@param	client			The users index, used for defining the weapon's class if upgraded version was used.
 *	@param	weapon			The string to copy to.
 *	@param	maxlen			The maximum length of the string.
 *	@param	weapon_defindex	The weapon definition index to read.
 *	@param	format			The weapon classname to read.
 */
int TF2_FixWeaponClassname(int client, char[] weapon, int maxlen, int weapon_defindex, const char[] format)	{
	TFClassType class = TF2_GetPlayerClass(client);
	
	switch(weapon_defindex)	{
		case 0: strcopy(weapon, maxlen, "tf_weapon_bat");					//The Bat.
		case 1: strcopy(weapon, maxlen, "tf_weapon_bottle");				//The Bottle.
		case 2: strcopy(weapon, maxlen, "tf_weapon_fireaxe");				//The Fire Axe.
		case 3: strcopy(weapon, maxlen, "tf_weapon_kukri");					//The Kukri.
		case 4: strcopy(weapon, maxlen, "tf_weapon_knife");					//The Knife. (Butterfly knife for Spy.)
		case 5: strcopy(weapon, maxlen, "tf_weapon_fists");					//The Fists.
		case 6: strcopy(weapon, maxlen, "tf_weapon_shovel");				//The Shovel.
		case 7: strcopy(weapon, maxlen, "tf_weapon_wrench");				//The Wrench.
		case 8: strcopy(weapon, maxlen, "tf_weapon_bonesaw");				//The Bonesaw.
		case 9: strcopy(weapon, maxlen, "tf_weapon_shotgun_engineer");		//The Shotgun, Class: Engineer.
		case 10: strcopy(weapon, maxlen, "tf_weapon_shotgun_soldier");		//The Shotgun, Class: Soldier.
		case 11: strcopy(weapon, maxlen, "tf_weapon_shotgun_hwg");			//The Shotgun, Class: Heavy.
		case 12: strcopy(weapon, maxlen, "tf_weapon_shotgun_pyro");			//The Shotgun, Class: Pyro.
		case 13: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//The Scattergun.
		case 14: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//The Sniper Rifle.
		case 15: strcopy(weapon, maxlen, "tf_weapon_minigun");				//The Minigun.
		case 16: strcopy(weapon, maxlen, "tf_weapon_smg");					//The SMG;
		case 17: strcopy(weapon, maxlen, "tf_weapon_syringegun");			//The Syringe Gun.
		case 18: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//The Rocket Launcher.
		case 19: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//The Grenade Launcher.
		case 20: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//The StickyBomb Launcher.
		case 21: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Flamethrower.
		case 22: strcopy(weapon, maxlen, "tf_weapon_pistol_engineer");		//The Pistol, Class: Engineer.
		case 23: strcopy(weapon, maxlen, "tf_weapon_pistol_scout");			//The Pistol, Class: Scout.
		case 24: strcopy(weapon, maxlen, "tf_weapon_revolver");				//The Revolver.
		case 36: strcopy(weapon, maxlen, "tf_weapon_blutsauger");			//The Blutsauger.
		case 37: strcopy(weapon, maxlen, "tf_weapon_ubersaw");				//The Ubersaw.
		case 38: strcopy(weapon, maxlen, "tf_weapon_axtinguisher");			//The Axtinguisher.
		case 39: strcopy(weapon, maxlen, "tf_weapon_flaregun");				//The Flaregun.
		case 40: strcopy(weapon, maxlen, "tf_weapon_backburner");			//The Backburner.
		case 41: strcopy(weapon, maxlen, "tf_weapon_natascha");				//The Natascha.
		case 43: strcopy(weapon, maxlen, "tf_weapon_kgob");					//The Killer Gloves Of Boxing.
		case 44: strcopy(weapon, maxlen, "tf_weapon_sandman");				//The Sandman.
		case 45: strcopy(weapon, maxlen, "tf_weapon_forceanature");			//The Force-A-Nature.
		case 56: strcopy(weapon, maxlen, "tf_weapon_huntsman");				//The Huntsman.
		case 61: strcopy(weapon, maxlen, "tf_weapon_ambassador");			//The Ambassador.
		case 127: strcopy(weapon, maxlen, "tf_weapon_directhit");			//The Direct-Hit.
		case 128: strcopy(weapon, maxlen, "tf_weapon_equalizer");			//The Equalizer.
		case 130: strcopy(weapon, maxlen, "tf_weapon_scottishresistance");	//The Scottish Resistance.
		case 131: strcopy(weapon, maxlen, "tf_weapon_chargentarge");		//The Chargin' Targe.
		case 132: strcopy(weapon, maxlen, "tf_weapon_eyelander");			//The Eyelander.
		case 140: strcopy(weapon, maxlen, "tf_weapon_wrangler");			//The Wrangler.
		case 141: strcopy(weapon, maxlen, "tf_weapon_frontierjustice");		//The Frontier Justice.
		case 142: strcopy(weapon, maxlen, "tf_weapon_gunslinger");			//The Gunslinger.
		case 153: strcopy(weapon, maxlen, "tf_weapon_homewrecker");			//The Homewrecker.
		case 154: strcopy(weapon, maxlen, "tf_weapon_paintrain");			//The Pain Train.
		case 155: strcopy(weapon, maxlen, "tf_weapon_southernhospitality");		//The Southern Hospitality.
		case 160: Format(weapon, maxlen, "tf_weapon_lugermorph_%s", TF2_ClassTypeNameLC[class]); //The Lugermorph.
		case 161: strcopy(weapon, maxlen, "tf_weapon_bigkill");					//The Big Kill.
		case 169: strcopy(weapon, maxlen, "tf_weapon_goldenwrench");			//The Golden Wrench.
		case 171: strcopy(weapon, maxlen, "tf_weapon_tribalmansshiv");			//The Tribalman's Shiv.
		case 172: strcopy(weapon, maxlen, "tf_weapon_scotmansskullcutter");		//The Scotman's Skullcutter.
		case 173: strcopy(weapon, maxlen, "tf_weapon_vitasaw");					//The Vita-Saw.
		case 190: strcopy(weapon, maxlen, "tf_weapon_bat");						//Same as default Bat, used for strange, renamed & skinned versions.
		case 191: strcopy(weapon, maxlen, "tf_weapon_bottle");					//Same as default Bottle, used for strange, renamed & skinned versions.
		case 192: strcopy(weapon, maxlen, "tf_weapon_fireaxe");					//Same as default Fire Axe, used for strange, renamed & skinned versions.
		case 193: strcopy(weapon, maxlen, "tf_weapon_kukri");					//Same as default Kukri, used for strange, renamed & skinned versions.
		case 194: strcopy(weapon, maxlen, "tf_weapon_knife");					//Same as default Knife, used for australium, strange, renamed & skinned versions.
		case 195: strcopy(weapon, maxlen, "tf_weapon_fists");					//Same as default Fists, used for strange, renamed & skinned versions.
		case 196: strcopy(weapon, maxlen, "tf_weapon_shovel");					//Same as default Shovel, used for strange, renamed & skinned versions.
		case 197: strcopy(weapon, maxlen, "tf_weapon_wrench");					//Same as default Wrench, used for australium, strange, renamed & skinned versions.
		case 198: strcopy(weapon, maxlen, "tf_weapon_bonesaw");					//Same as default Bonesaw, used for strange, renamed & skinned versions.
		case 199: Format(weapon, maxlen, "tf_weapon_shotgun_%s", TF2_ClassTypeNameLC[class]); //Same as default Shotgun, used for strange, renamed & skinned versions.
		case 200: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//Same as default Scattergun, used for strange, renamed & skinned versions.
		case 201: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//Same as default Sniper Rifle, used for australium, strange, renamed & skinned versions.
		case 202: strcopy(weapon, maxlen, "tf_weapon_minigun");					//Same as default Minigun, used for australium, strange, renamed & skinned versions.
		case 203: strcopy(weapon, maxlen, "tf_weapon_smg");						//Same as default SMG, used for australium, strange, renamed & skinned versions.
		case 204: strcopy(weapon, maxlen, "tf_weapon_syringegun");				//Same as default Syringe gun, used for strange, renamed & skinned versions.
		case 205: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//Same as default Rocket Launcher, used for australium, strange, renamed & skinned versions.
		case 206: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");			//Same as default Grenade Launcher, used for australium, strange, renamed & skinned versions.
		case 207: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//Same as default Stickybomb Launcher, used for australium, strange, renamed & skinned versions.
		case 208: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Same as default Flamethrower, used for australium, strange, renamed & skinned versions.
		case 209: Format(weapon, maxlen, "tf_weapon_pistol_%s", TF2_ClassTypeNameLC[class]); //Same as default Pistol, used for strange, renamed & skinned versions.
		case 210: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Same as default Revolver, used for strange, renamed &  skinned versions.
		case 214: strcopy(weapon, maxlen, "tf_weapon_powerjack");				//The Powerjack.
		case 215: strcopy(weapon, maxlen, "tf_weapon_degreaser");				//The Degreaser.
		case 220: strcopy(weapon, maxlen, "tf_weapon_shortstop");				//The Shortstop.
		case 221: strcopy(weapon, maxlen, "tf_weapon_holymackerel");			//The Holy Mackerel.
		case 224: strcopy(weapon, maxlen, "tf_weapon_letranger");				//The L'etranger.
		case 225: strcopy(weapon, maxlen, "tf_weapon_eternalreward");			//The Eternal Reward.
		case 228: strcopy(weapon, maxlen, "tf_weapon_blackbox");				//The Black Box.
		case 230: strcopy(weapon, maxlen, "tf_weapon_sydneysleeper");			//The Sydney Sleeper.
		case 232: strcopy(weapon, maxlen, "tf_weapon_bushwacka");				//The Bushwacka.
		case 237: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Rocket Jumper (Just because why not.)
		case 239: strcopy(weapon, maxlen, "tf_weapon_goru");					//The Gloves of Running Urgently.
		case 264: Format(weapon, maxlen, "tf_weapon_fryingpan_%s", TF2_ClassTypeNameLC[class]); //The Frying Pan.
		case 265: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Sticky Jumper (I mean.. why? not? i guess?.)
		case 266: strcopy(weapon, maxlen, "tf_weapon_hhhh");					//The Horseless Headless Horsemann's Headtaker. (That's a long name, whew.)
		case 294: Format(weapon, maxlen, "tf_weapon_lugermorph_%s", TF2_ClassTypeNameLC[class]); //Same as the other Lugermorph.
		case 298: strcopy(weapon, maxlen, "tf_weapon_ironcurtain");				//The Iron Curtain.
		case 304: strcopy(weapon, maxlen, "tf_weapon_amputator");				//The Amputator.
		case 305: strcopy(weapon, maxlen, "tf_weapon_crusaderscrossbow");		//The Crusader's Crossbow.
		case 307: strcopy(weapon, maxlen, "tf_weapon_ullapoolcaber");			//The Ullapool Caber.
		case 308: strcopy(weapon, maxlen, "tf_weapon_lochnload");				//The Loch-n-Load.
		case 310: strcopy(weapon, maxlen, "tf_weapon_warriorsspirit");			//The Warriors Spirit.
		case 312: strcopy(weapon, maxlen, "tf_weapon_brassbeast");				//The Brass Beast.
		case 317: strcopy(weapon, maxlen, "tf_weapon_candycane");				//The Candy Cane.
		case 325: strcopy(weapon, maxlen, "tf_weapon_bostonbasher");			//The Boston Basher.
		case 326: strcopy(weapon, maxlen, "tf_weapon_backscratcher");			//The Back Scratcher. (Isn't this one too harsh to be one?. /s)
		case 327: strcopy(weapon, maxlen, "tf_weapon_claidheamhmor");			//The Claidheamh Mór.
		case 329: strcopy(weapon, maxlen, "tf_weapon_jag");						//The Jag ('Jag' literally means 'me' in swedish).
		case 331: strcopy(weapon, maxlen, "tf_weapon_fistsofsteel");			//The Fists Of Steel.
		case 348: strcopy(weapon, maxlen, "tf_weapon_sharpenedvolcanofragment");//The Sharpened Volcano Fragment.
		case 349: strcopy(weapon, maxlen, "tf_weapon_sunonastick");				//The Sun-On-A-Stick (Does anybody really use this weapon?.)
		case 351: strcopy(weapon, maxlen, "tf_weapon_detonator");				//The Detonator.
		case 355: strcopy(weapon, maxlen, "tf_weapon_fanowar");					//The Fan O' War.
		case 356: strcopy(weapon, maxlen, "tf_weapon_conniverskunai");			//The Conniver's Kunai.
		case 357: strcopy(weapon, maxlen, "tf_weapon_halfzatoichi");			//The Half-Zatoichi.
		case 401: strcopy(weapon, maxlen, "tf_weapon_shahanshah");				//The Shahanshah.
		case 402: strcopy(weapon, maxlen, "tf_weapon_bazaarbargain");			//The Bazaar Bargain.
		case 404: strcopy(weapon, maxlen, "tf_weapon_persainpersuader");		//The Persain Persuader.
		case 406: strcopy(weapon, maxlen, "tf_weapon_splendidscreen");			//The Splendid Screen.
		case 412: strcopy(weapon, maxlen, "tf_weapon_overdose");				//The Overdose.
		case 413: strcopy(weapon, maxlen, "tf_weapon_solemnvow");				//The Solemn Vow.
		case 414: strcopy(weapon, maxlen, "tf_weapon_libertylauncher");			//The Liberty Launcher.
		case 415: strcopy(weapon, maxlen, "tf_weapon_reserveshooter");			//The Reserve Shooter.
		case 416: strcopy(weapon, maxlen, "tf_weapon_marketgardener");			//The Market Gardener.
		case 423: Format(weapon, maxlen, "tf_weapon_saxxy_%s", TF2_ClassTypeNameLC[class]); //The Saxxy.
		case 424: strcopy(weapon, maxlen, "tf_weapon_tomislav");				//The Tomislav.
		case 425: strcopy(weapon, maxlen, "tf_weapon_familybusiness");			//The Family Business.
		case 426: strcopy(weapon, maxlen, "tf_weapon_evictionnotice");			//The Eviction Notice.
		case 441: strcopy(weapon, maxlen, "tf_weapon_cowmangler5000");			//The Cow Mangler 5000.
		case 442: strcopy(weapon, maxlen, "tf_weapon_righteousbison");			//The Righeous Bison.
		case 444: strcopy(weapon, maxlen, "tf_weapon_mantreads");				//The Mantreads.
		case 447: strcopy(weapon, maxlen, "tf_weapon_disciplinaryaction");		//The Disciplinary Action.
		case 448: strcopy(weapon, maxlen, "tf_weapon_sodapopper");				//The Soda Popper.
		case 449: strcopy(weapon, maxlen, "tf_weapon_winger");					//The Winger.
		case 450: strcopy(weapon, maxlen, "tf_weapon_atomizer");				//The Atomizer.
		case 452: strcopy(weapon, maxlen, "tf_weapon_threeruneblade");			//The Three-Rune-Blade.
		case 457: strcopy(weapon, maxlen, "tf_weapon_postalpummeler");			//The Postal Pummeler.
		case 460: strcopy(weapon, maxlen, "tf_weapon_enforcer");				//The Enforcer.
		case 461: strcopy(weapon, maxlen, "tf_weapon_bigearner");				//The Big Earner.
		case 466: strcopy(weapon, maxlen, "tf_weapon_maul");					//The Maul.
		case 474: strcopy(weapon, maxlen, "tf_weapon_conscentiousobjector");	//The Conscentious Objector.
		case 482: strcopy(weapon, maxlen, "tf_weapon_nessiesnineiron");			//The Nessie's Nine Iron.
		case 513: strcopy(weapon, maxlen, "tf_weapon_original");				//The Original.
		case 525: strcopy(weapon, maxlen, "tf_weapon_diamondback");				//The Diamond Back.
		case 526: strcopy(weapon, maxlen, "tf_weapon_machina");					//The Machine.
		case 527: strcopy(weapon, maxlen, "tf_weapon_widowmaker");				//The Widowmaker.
		case 528: strcopy(weapon, maxlen, "tf_weapon_shortcircuit");			//The Short Circuit.
		case 572: Format(weapon, maxlen, "tf_weapon_unarmedcombat_%s", TF2_ClassTypeNameLC[class]); //The Unarmed Combat.
		case 574: strcopy(weapon, maxlen, "tf_weapon_wangaprick");				//The Wanga Prick.
		case 587: strcopy(weapon, maxlen, "tf_weapon_apocofists");				//The Apoco Fists.
		case 588: strcopy(weapon, maxlen, "tf_weapon_pomson6000");				//The Pomson 6000.
		case 589: strcopy(weapon, maxlen, "tf_weapon_eurekaeffect");			//The Eureka Effect.
		case 593: strcopy(weapon, maxlen, "tf_weapon_thirddegree");				//The Third Degree.
		case 594: strcopy(weapon, maxlen, "tf_weapon_phlogistinator");			//The Phlogistinator.
		case 595: strcopy(weapon, maxlen, "tf_weapon_manmelter");				//The Man Melter.
		case 609: strcopy(weapon, maxlen, "tf_weapon_scottishhandshake");		//The Scottish Handshake.
		case 638: strcopy(weapon, maxlen, "tf_weapon_sharpdresser");			//The Sharp Dresser.
		case 648: strcopy(weapon, maxlen, "tf_weapon_wrapassassin");			//The Wrap Assassin.
		case 649: strcopy(weapon, maxlen, "tf_weapon_spycicle");				//The Spycicle.
		case 654: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The Festive Minigun.
		case 656: strcopy(weapon, maxlen, "tf_weapon_holidaypunch");			//The Holiday Punch.
		case 658: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Festive Rocket Launcher.
		case 659: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Festive Flamethrower.
		case 660: strcopy(weapon, maxlen, "tf_weapon_bat");						//The Festive Bat.
		case 661: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Festive StickyBomb Launcher.
		case 662: strcopy(weapon, maxlen, "tf_weapon_wrench");					//The Festive Wrench.
		case 664: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//The Festive Sniper Rifle.
		case 665: strcopy(weapon, maxlen, "tf_weapon_knife");					//The Festive Knife.
		case 669: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//The Festive Scattergun.
		case 727: strcopy(weapon, maxlen, "tf_weapon_blackrose");				//The Blackrose.
		case 739: strcopy(weapon, maxlen, "tf_weapon_lollichop");				//The Lollichop.
		case 740: strcopy(weapon, maxlen, "tf_weapon_scorchshot");				//The Shorch Shot.
		case 741: strcopy(weapon, maxlen, "tf_weapon_rainblower");				//The Rainblower.
		case 751: strcopy(weapon, maxlen, "tf_weapon_cleanerscarbine");			//The Cleaner's Carbine.
		case 752: strcopy(weapon, maxlen, "tf_weapon_hitmansheatmaker");		//The Hitman's Heatmaker.
		case 772: strcopy(weapon, maxlen, "tf_weapon_babyfacesblaster");		//The Baby Face's Blaster.
		case 773: strcopy(weapon, maxlen, "tf_weapon_prettyboyspocketpistol");	//The Pretty Boy's Pocket Pistol.
		case 775: strcopy(weapon, maxlen, "tf_weapon_escapeplan");				//The Escape Plan.
		case 792: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//The Silver Botkiller Mk. I Sniper Rifle.
		case 793: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The Silver Botkiller Mk. I Minigun.
		case 795: strcopy(weapon, maxlen, "tf_weapon_wrench");					//The Silver Botkiller Mk. I Wrench.
		case 797: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Silver Botkiller Mk. I StickyBomb Launcher.
		case 798: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Silver Botkiller Mk. I Flamethrower.
		case 799: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//The Silver Botkiller Mk. I Scattergun.
		case 800: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Silver Botkiller Mk. I Rocket Launcher.
		case 801: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//The Gold Botkiller Mk. I Sniper Rifle.
		case 802: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The Gold Botkiller Mk. I Minigun.
		case 804: strcopy(weapon, maxlen, "tf_weapon_wrench");					//The Gold Botkiller Mk. I Wrench.
		case 806: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Gold Botkiller Mk. I StickyBomb Launcher.
		case 807: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Gold Botkiller Mk. I Flamethrower.
		case 808: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//The Gold Botkiller Mk. I Scattergun.
		case 809: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Gold Botkiller Mk. I Rocket Launcher.
		case 811: strcopy(weapon, maxlen, "tf_weapon_huolongheater");			//The Huo-Long Heater.
		case 812: strcopy(weapon, maxlen, "tf_weapon_flyingguillotine");		//The Flying Guillotine.
		case 813: strcopy(weapon, maxlen, "tf_weapon_neonannihilator");			//The Neon Annhiliator.
		case 832: strcopy(weapon, maxlen, "tf_weapon_huolongheater");			//The Genuine Huo-Long Heater.
		case 833: strcopy(weapon, maxlen, "tf_weapon_flyingguillotine");		//The Genuine Guillotine.
		case 834: strcopy(weapon, maxlen, "tf_weapon_neonannihilator");			//The Genuine Neon Annihilator.
		case 850: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The MvM Minigun Deflector.
		case 851: strcopy(weapon, maxlen, "tf_weapon_awperhand");				//The AWPer Hand.
		case 880: Format(weapon, maxlen, "tf_weapon_freedomstaff_%s", TF2_ClassTypeNameLC[class]); //The Freedom Staff.
		case 881: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//The Rust Botkiller Mk. I Sniper Rifle.
		case 882: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The Rust Botkiller Mk. I Minigun.
		case 884: strcopy(weapon, maxlen, "tf_weapon_wrench");					//The Rust Botkiller Mk. I Wrench.
		case 886: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Rust Botkiller Mk. I StickyBomb Launcher.
		case 887: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Rust Botkiller Mk. I Flamethrower
		case 888: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//The Rust Botkiller Mk. I Scattergun.
		case 889: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Rust Botkiller Mk. I Rocket Launcher.
		case 890: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//The Blood Botkiller Mk. I Sniper Rifle.
		case 891: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The Blood Botkiller Mk. I Minigun.
		case 893: strcopy(weapon, maxlen, "tf_weapon_wrench");					//The Blood Botkiller Mk. I Wrench.
		case 895: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Blood Botkiller Mk. I StickyBomb Launcher.
		case 896: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Blood Botkiller Mk. I Flamethrower
		case 897: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//The Blood Botkiller Mk. I Scattergun.
		case 898: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Blood Botkiller Mk. I Rocket Launcher.
		case 899: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//The Carbonado Botkiller Mk. I Sniper Rifle.
		case 900: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The Carbonado Botkiller Mk. I Minigun.
		case 902: strcopy(weapon, maxlen, "tf_weapon_wrench");					//The Carbonado Botkiller Mk. I Wrench.
		case 904: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Carbonado Botkiller Mk. I StickyBomb Launcher.
		case 905: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Carbonado Botkiller Mk. I Flamethrower
		case 906: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//The Carbonado Botkiller Mk. I Scattergun.
		case 907: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Carbonado Botkiller Mk. I Rocket Launcher.
		case 908: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//The Diamond Botkiller Mk. I Sniper Rifle.
		case 909: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The Diamond Botkiller Mk. I Minigun.
		case 911: strcopy(weapon, maxlen, "tf_weapon_wrench");					//The Diamond Botkiller Mk. I Wrench.
		case 913: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Diamond Botkiller Mk. I StickyBomb Launcher.
		case 914: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Diamond Botkiller Mk. I Flamethrower
		case 915: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//The Diamond Botkiller Mk. I Scattergun.
		case 916: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Diamond Botkiller Mk. I Rocket Launcher.
		case 939: Format(weapon, maxlen, "tf_weapon_batouttahell_%s", TF2_ClassTypeNameLC[class]); //The Bat Outta Hell.
		case 954: Format(weapon, maxlen, "tf_weapon_memorymaker_%s", TF2_ClassTypeNameLC[class]); //The Memory Maker.
		case 957: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//The Silver Botkiller Mk. II Sniper Rifle.
		case 958: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The Silver Botkiller Mk. II Minigun.
		case 960: strcopy(weapon, maxlen, "tf_weapon_wrench");					//The Silver Botkiller Mk. II Wrench.
		case 962: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Silver Botkiller Mk. II StickyBomb Launcher.
		case 963: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Silver Botkiller Mk. II Flamethrower
		case 964: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//The Silver Botkiller Mk. II Scattergun.
		case 965: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Silver Botkiller Mk. II Rocket Launcher.
		case 966: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");				//The Gold Botkiller Mk. II Sniper Rifle.
		case 967: strcopy(weapon, maxlen, "tf_weapon_minigun");					//The Gold Botkiller Mk. II Minigun.
		case 969: strcopy(weapon, maxlen, "tf_weapon_wrench");					//The Gold Botkiller Mk. II Wrench.
		case 971: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");		//The Gold Botkiller Mk. II StickyBomb Launcher.
		case 972: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//The Gold Botkiller Mk. II Flamethrower
		case 973: strcopy(weapon, maxlen, "tf_weapon_scattergun");				//The Gold Botkiller Mk. II Scattergun.
		case 974: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");			//The Gold Botkiller Mk. II Rocket Launcher.
		case 996: strcopy(weapon, maxlen, "tf_weapon_loosecannon");				//The Loose Cannon.
		case 997: strcopy(weapon, maxlen, "tf_weapon_rescueranger");			//The Rescue Ranger.
		case 999: strcopy(weapon, maxlen, "tf_weapon_holymackerel");			//The Festive Holy Mackerel.
		case 1000: strcopy(weapon, maxlen, "tf_weapon_axtinguisher");			//The Festive Axtinguisher.
		case 1003: strcopy(weapon, maxlen, "tf_weapon_ubersaw");				//The Festive Ubersaw.
		case 1004: strcopy(weapon, maxlen, "tf_weapon_frontierjustice");		//The Festive Frontier Justice.
		case 1005: strcopy(weapon, maxlen, "tf_weapon_huntsman");				//The Festive Huntsman.
		case 1006: strcopy(weapon, maxlen, "tf_weapon_ambassador");				//The Festive Ambassador.
		case 1007: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//The Festive Grenade Launcher.
		case 1013: Format(weapon, maxlen, "tf_weapon_hamshank_%s", TF2_ClassTypeNameLC[class]); //The Ham Shank.
		case 1071: Format(weapon, maxlen, "tf_weapon_goldenfryingpan_%s", TF2_ClassTypeNameLC[class]); //The Golden Frying Pan.
		case 1078: strcopy(weapon, maxlen, "tf_weapon_forceanature");			//The Festive Force-A-Nature.
		case 1079: strcopy(weapon, maxlen, "tf_weapon_crusaderscrossbow");		//The Festive Crusader's Crossbow.
		case 1081: strcopy(weapon, maxlen, "tf_weapon_flaregun");				//The Festive Flare Gun.
		case 1082: strcopy(weapon, maxlen, "tf_weapon_eyelander");				//The Festive Eyelander.
		case 1084: strcopy(weapon, maxlen, "tf_weapon_goru");					//The Festive Gloves Of Running Urgently.
		case 1085: strcopy(weapon, maxlen, "tf_weapon_blackbox");				//The Festive Black Box.
		case 1092: strcopy(weapon, maxlen, "tf_weapon_fortifiedcompound");		//The Fortified Compound.
		case 1098: strcopy(weapon, maxlen, "tf_weapon_classic");				//The Classic.
		case 1099: strcopy(weapon, maxlen, "tf_weapon_tideturner");				//The Tide Turner.
		case 1100: strcopy(weapon, maxlen, "tf_weapon_breadbite");				//The Bread Bite.
		case 1103: strcopy(weapon, maxlen, "tf_weapon_backscatter");			//The Back Scatter.
		case 1104: strcopy(weapon, maxlen, "tf_weapon_airstrike");				//The Air Strike.
		case 1123: Format(weapon, maxlen, "tf_weapon_necrosmasher_%s", TF2_ClassTypeNameLC[class]); //The Necro Smasher.
		case 1127: Format(weapon, maxlen, "tf_weapon_crossingguard_%s", TF2_ClassTypeNameLC[class]); //The Crossing Guard.
		case 1141: Format(weapon, maxlen, "tf_weapon_shotgun_%s", TF2_ClassTypeNameLC[class]); //The Festive Shotgun.
		case 1142: strcopy(weapon, maxlen, "tf_weapon_revolver");				//The Festive Revolver.
		case 1144: strcopy(weapon, maxlen, "tf_weapon_chargintarge");			//The Festive Chargin' Targe.
		case 1446: strcopy(weapon, maxlen, "tf_weapon_backburner");				//The Festive Backburner.
		case 1149: strcopy(weapon, maxlen, "tf_weapon_smg");					//The Festive SMG.
		case 1150: strcopy(weapon, maxlen, "tf_weapon_quickiebomblauncher");	//The QuickieBomb Launcher.
		case 1151: strcopy(weapon, maxlen, "tf_weapon_ironbomber");				//The Iron Bomber.
		case 1153: strcopy(weapon, maxlen, "tf_weapon_panicattack");			//The Panic Attack.
		case 1178: strcopy(weapon, maxlen, "tf_weapon_dragonsfury");			//The Dragon's Fury.
		case 1179: strcopy(weapon, maxlen, "tf_weapon_thermalthruster");		//The Thermal Thruster.
		case 1181: strcopy(weapon, maxlen, "tf_weapon_hothand");				//The Hot Hand.
		case 1184: strcopy(weapon, maxlen, "tf_weapon_goru");					//The MvM Gloves Of Running Urgently.
		case 15000: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Night Owl.
		case 15001: strcopy(weapon, maxlen, "tf_weapon_smg");					//Skinned SMG.					Woodsy Widowmaker.
		case 15002: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Night Terror.
		case 15004: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				King of The Jungle.
		case 15005: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Forest Fire.
		case 15006: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Woodland Warrior.
		case 15007: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Purple Range.
		case 15009: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Sudden Flurry.
		case 15011: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Psychedeic Slugger.
		case 15012: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Carpet Bomber.
		case 15014: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Sand Cannon.
		case 15015: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Tartan Torpedo.
		case 15017: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Barn Burner.
		case 15019: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Lumber From Down Under.
		case 15020: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Iron Wood.
		case 15021: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Country Crusher.
		case 15022: strcopy(weapon, maxlen, "tf_weapon_smg");					//Skinned SMG.					Plaid Potshotter.
		case 15023: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Shot In The Dark.
		case 15024: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Blasted Bombardier.
		case 15026: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Antique Annihilator.
		case 15027: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Old Country.
		case 15028: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		American Pastoral.
		case 15029: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Backcountry Blaster.
		case 15030: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Bovine Blazemaker.
		case 15031: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				War Room.
		case 15032: strcopy(weapon, maxlen, "tf_weapon_smg");					//Skinned SMG.					Treadplate Tormenter.
		case 15033: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Bogtrotter.
		case 15034: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Earth, Sky and Fire.
		case 15036: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Spruce Deuce.
		case 15037: strcopy(weapon, maxlen, "tf_weapon_smg");					//Skinned SMG.					Team Sprayer.
		case 15038: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Rooftop Wrangler.
		case 15040: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Citizen Pain.
		case 15042: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Mayor.
		case 15043: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Smalltown Bringdown.
		case 15045: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Liquid Asset.
		case 15048: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Pink Elephant.
		case 15049: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Flash Fryer.
		case 15051: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Dead Reckoner.
		case 15052: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Shell Shocker.
		case 15053: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Scattergun.			Current Event.
		case 15054: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Flame Thrower.		Turbine Torcher.
		case 15055: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Brick House.
		case 15057: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Aqua Marine.
		case 15058: strcopy(weapon, maxlen, "tf_weapon_smg");					//Skinned SMG.					Low Profile.
		case 15059: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Thunderbolt.
		case 15062: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Boneyard.
		case 15063: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Wildwood.
		case 15064: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Macabre Web.
		case 15065: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Macabre Web.
		case 15066: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Autumn.
		case 15067: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Pumpkin Patch.
		case 15068: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Nutcracker.
		case 15069: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Nutcracker.
		case 15070: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Pumpkin Patch.
		case 15071: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Boneyard.
		case 15072: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Wildwood.
		case 15073: strcopy(weapon, maxlen, "tf_weapon_wrench");				//Skinned Wrench.				Nutcracker.
		case 15074: strcopy(weapon, maxlen, "tf_weapon_wrench");				//Skinned Wrench.				Autumn.
		case 15075: strcopy(weapon, maxlen, "tf_weapon_wrench");				//Skinned Wrench.				Boneyard.
		case 15076: strcopy(weapon, maxlen, "tf_weapon_smg");					//Skinned SMG.					Wildwood.
		case 15077: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Autumn.
		case 15079: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Macabre Web.
		case 15081: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Autumn.
		case 15082: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Autumn.
		case 15083: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Pumpkin Patch.
		case 15084: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Macabre Web.
		case 15086: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Macabre Web.
		case 15087: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Pumpkin Patch.
		case 15088: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Nutcracker.
		case 15089: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Balloonicorn.
		case 15090: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Rainbow.
		case 15091: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Rainbow.
		case 15092: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Sweet Dreams.
		case 15094: strcopy(weapon, maxlen, "tf_weapon_knife");					//Skinned Knife.				Blue Mew.
		case 15095: strcopy(weapon, maxlen, "tf_weapon_knife");					//Skinned Knife.				Brain Candy.
		case 15096: strcopy(weapon, maxlen, "tf_weapon_knife");					//Skinned Knife.				Stabbed To Hell.
		case 15098: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Brain Candy.
		case 15099: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Mister Cuddles.
		case 15103: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Flower Power.
		case 15104: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Blue Mew.
		case 15105: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Brain Candy.
		case 15106: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Bluw Mew.
		case 15107: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Flower Power.
		case 15108: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Shot to Hell.
		case 15110: strcopy(weapon, maxlen, "tf_weapon_smg");					//Skinned SMG.					Blue Mew.
		case 15111: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Balloonicorn.
		case 15112: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Rainbow.
		case 15113: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Sweet Dreams.
		case 15114: strcopy(weapon, maxlen, "tf_weapon_wrench");				//Skinned Wrench.				Torqued To Hell.
		case 15115: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Coffin Nail.
		case 15116: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Coffin Nail.
		case 15117: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Top Shelf.
		case 15118: strcopy(weapon, maxlen, "tf_weapon_knife");					//Skinned Knife.				Dressed To Kill.
		case 15119: strcopy(weapon, maxlen, "tf_weapon_knife");					//Skinned Knife.				Top Shelf.
		case 15123: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Coffin Nail.
		case 15124: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Dressed To Kill.
		case 15125: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Top Shelf.
		case 15127: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Top Shelf.
		case 15128: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Top Shelf.
		case 15129: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Coffin Nail.
		case 15130: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		High Roller's.
		case 15131: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Coffin Nail.
		case 15134: strcopy(weapon, maxlen, "tf_weapon_smg");					//Skinned SMG.					High Roller's.
		case 15135: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Coffin Nail.
		case 15136: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Dressed To Kill.
		case 15137: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Coffin Nail.
		case 15138: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Dressed To Kill.
		case 15139: strcopy(weapon, maxlen, "tf_weapon_wrench");				//Skinned Wrench.				Dressed To Kill.
		case 15140: strcopy(weapon, maxlen, "tf_weapon_wrench");				//Skinned Wrench.				Top Shelf.
		case 15141: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			//Skinned Flame Thrower.		Warhawk.
		case 15142: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Warhawk.
		case 15143: strcopy(weapon, maxlen, "tf_weapon_knife");					//Skinned Knife.				Blitzkrieg.
		case 15144: strcopy(weapon, maxlen, "tf_weapon_knife");					//Skinned Knife.				Airwolf.
		case 15147: strcopy(weapon, maxlen, "tf_weapon_minigun");				//Skinned Minigun.				Butcher Bird.
		case 15149: strcopy(weapon, maxlen, "tf_weapon_revolver");				//Skinned Revolver.				Blitzkrieg.
		case 15050: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//Skinned Rocket Launcher.		Warhawk.
		case 15151: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Killer Bee.
		case 15153: strcopy(weapon, maxlen, "tf_weapon_smg");					//Skinned SMG.					Blitzkrieg.
		case 15154: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//Skinned Sniper Rifle.			Airwolf.
		case 15155: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");	//Skinned Stickybomb Launcher.	Blitzkrieg.
		case 15156: strcopy(weapon, maxlen, "tf_weapon_wrench");				//Skinned Wrench.				Airwolf.
		case 15157: strcopy(weapon, maxlen, "tf_weapon_scattergun");			//Skinned Scattergun.			Corsair.
		case 15158: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");		//Skinned Grenade Launcher.		Butcher Bird.
		case 19010: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 1.
		case 19011: strcopy(weapon, maxlen, "tf_weapon_shotgun");				//TF2Items Give Weapon: Beta Pocket Shotgun.
		case 19012: strcopy(weapon, maxlen, "tf_weapon_equalizer");				//TF2Items Give Weapon: Beta Split Equalizer 1.
		case 19013: strcopy(weapon, maxlen, "tf_weapon_equalizer");				//TF2Items Give Weapon: Beta Split Equalizer 2.
		case 19015: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");			//TF2Items Give Weapon: Beta Sniper Rifle 1.
		case 19016: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 2.
		case 19017: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");		//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 3.
		case 30474: strcopy(weapon, maxlen, "tf_weapon_nostromonapalmer");		//The Nostromo Napalmer.
		case 30665: strcopy(weapon, maxlen, "tf_weapon_shootingstar");			//The Shooting Star.
		case 30666: Format(weapon, maxlen, "tf_weapon_capper_%s", TF2_ClassTypeNameLC[class]); //The C.A.P.P.E.R.
		case 30667: strcopy(weapon, maxlen, "tf_weapon_batsaber");				//The Batsaber.
		case 30668: strcopy(weapon, maxlen, "tf_weapon_gigarcounter");			//The Gigarcounter.
		case 30758: Format(weapon, maxlen, "tf_weapon_prinnymachete_%s", TF2_ClassTypeNameLC[class]); //The Prinny Machete.
		
		// Separating the weapon skins with classes.
		
		// Skins By Order:
		// Red Rock Roscoe.
		// Homemade Heater.
		// Hickory Holepuncher.
		// Blue Mew.
		// Brain Candy.
		// Shot To Hell.
		// Local Hero.
		// Black Dahlia.
		// Sandstone Special.
		// Macabre Web.
		// Nutcracker.
		// Dressed To Kill.
		// Blitzkrieg.
		case 15013, 15018, 15035, 15100, 15101, 15102, 15041, 15046, 15056, 15060, 15061, 15126, 15148: {
			switch(class) {
				case TFClass_Scout: strcopy(weapon, maxlen, "tf_weapon_pistol_scout");
				case TFClass_Engineer: strcopy(weapon, maxlen, "tf_weapon_pistol_engineer");
			}
		}
		
		// Skins By Order:
		// Backwoods Boomstick.
		// Rustic Ruiner.
		// Civic Duty.
		// Lightning Rod.
		// Autumn.
		// Flower Power.
		// Coffin Nail.
		// Dressed To Kill.
		// Red Bear.
		case 15003, 15016, 15044, 15047, 15085, 15109, 15132, 15133, 15152: {
			switch(class) {
				case TFClass_Soldier: strcopy(weapon, maxlen, "tf_weapon_shotgun_soldier");
				case TFClass_Pyro: strcopy(weapon, maxlen, "tf_weapon_shotgun_pyro");
				case TFClass_Heavy: strcopy(weapon, maxlen, "tf_weapon_shotgun_heavy");
				case TFClass_Engineer: strcopy(weapon, maxlen, "tf_weapon_shotgun_engineer");
			}
		}
		
		default: Format(weapon, maxlen, format);
	}
}