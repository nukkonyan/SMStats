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
	char why[64];
	
	TFClassType class = TF2_GetPlayerClass(client);
	
	switch(weapon_defindex)	{
		case 0: why = "weapon_bat";						//The Bat.
		case 1: why = "weapon_bottle";					//The Bottle.
		case 2: why = "weapon_fireaxe";					//The Fire Axe.
		case 3: why = "weapon_kukri";					//The Kukri.
		case 4: why = "weapon_knife";					//The Knife. (Butterfly knife for Spy.)
		case 5: why = "weapon_fists";					//The Fists.
		case 6: why = "weapon_shovel";					//The Shovel.
		case 7: why = "weapon_wrench";					//The Wrench.
		case 8: why = "weapon_bonesaw";					//The Bonesaw.
		case 9: why = "weapon_shotgun_engineer";		//The Shotgun, Class: Engineer.
		case 10: why = "weapon_shotgun_soldier";		//The Shotgun, Class: Soldier.
		case 11: why = "weapon_shotgun_hwg";			//The Shotgun, Class: Heavy.
		case 12: why = "weapon_shotgun_pyro";			//The Shotgun, Class: Pyro.
		case 13: why = "weapon_scattergun";				//The Scattergun.
		case 14: why = "weapon_sniperrifle";			//The Sniper Rifle.
		case 15: why = "weapon_minigun";				//The Minigun.
		case 16: why = "weapon_smg";					//The SMG;
		case 17: why = "weapon_syringegun";				//The Syringe Gun.
		case 18: why = "weapon_rocketlauncher";			//The Rocket Launcher.
		case 19: why = "weapon_grenadelauncher";		//The Grenade Launcher.
		case 20: why = "weapon_stickybomblauncher";		//The StickyBomb Launcher.
		case 21: why = "weapon_flamethrower";			//The Flamethrower.
		case 22: why = "weapon_pistol_engineer";		//The Pistol, Class: Engineer.
		case 23: why = "weapon_pistol_scout";			//The Pistol, Class: Scout.
		case 24: why = "weapon_revolver";				//The Revolver.
		case 36: why = "weapon_blutsauger";				//The Blutsauger.
		case 37: why = "weapon_ubersaw";				//The Ubersaw.
		case 38: why = "weapon_axtinguisher";			//The Axtinguisher.
		case 39: why = "weapon_flaregun";				//The Flaregun.
		case 40: why = "weapon_backburner";				//The Backburner.
		case 41: why = "weapon_natascha";				//The Natascha.
		case 43: why = "weapon_kgob";					//The Killer Gloves Of Boxing.
		case 44: why = "weapon_sandman";				//The Sandman.
		case 45: why = "weapon_forceanature";			//The Force-A-Nature.
		case 56: why = "weapon_huntsman";				//The Huntsman.
		case 61: why = "weapon_ambassador";				//The Ambassador.
		case 127: why = "weapon_directhit";				//The Direct-Hit.
		case 128: why = "weapon_equalizer";				//The Equalizer.
		case 130: why = "weapon_scottishresistance";	//The Scottish Resistance.
		case 131: why = "weapon_chargentarge";			//The Chargin' Targe.
		case 132: why = "weapon_eyelander";				//The Eyelander.
		case 140: why = "weapon_wrangler";				//The Wrangler.
		case 141: why = "weapon_frontierjustice";		//The Frontier Justice.
		case 142: why = "weapon_gunslinger";			//The Gunslinger.
		case 153: why = "weapon_homewrecker";			//The Homewrecker.
		case 154: why = "weapon_paintrain";				//The Pain Train.
		case 155: why = "weapon_southernhospitality";	//The Southern Hospitality.
		case 160: {										//The Lugermorph.
			why = "weapon_lugermorph";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 161: why = "weapon_bigkill";				//The Big Kill.
		case 169: why = "weapon_goldenwrench";			//The Golden Wrench.
		case 171: why = "weapon_tribalmansshiv";		//The Tribalman's Shiv.
		case 172: why = "weapon_scotmansskullcutter";	//The Scotman's Skullcutter.
		case 173: why = "weapon_vitasaw";				//The Vita-Saw.
		case 190: why = "weapon_bat";					//Same as default Bat, used for strange, renamed & skinned versions.
		case 191: why = "weapon_bottle";				//Same as default Bottle, used for strange, renamed & skinned versions.
		case 192: why = "weapon_fireaxe";				//Same as default Fire Axe, used for strange, renamed & skinned versions.
		case 193: why = "weapon_kukri";					//Same as default Kukri, used for strange, renamed & skinned versions.
		case 194: why = "weapon_knife";					//Same as default Knife, used for australium, strange, renamed & skinned versions.
		case 195: why = "weapon_fists";					//Same as default Fists, used for strange, renamed & skinned versions.
		case 196: why = "weapon_shovel";				//Same as default Shovel, used for strange, renamed & skinned versions.
		case 197: why = "weapon_wrench";				//Same as default Wrench, used for australium, strange, renamed & skinned versions.
		case 198: why = "weapon_bonesaw";				//Same as default Bonesaw, used for strange, renamed & skinned versions.
		case 199: {										//Same as default Shotgun, used for strange, renamed & skinned versions.
			why = "weapon_shotgun";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 200: why = "weapon_scattergun";			//Same as default Scattergun, used for strange, renamed & skinned versions.
		case 201: why = "weapon_sniperrifle";			//Same as default Sniper Rifle, used for australium, strange, renamed & skinned versions.
		case 202: why = "weapon_minigun";				//Same as default Minigun, used for australium, strange, renamed & skinned versions.
		case 203: why = "weapon_smg";					//Same as default SMG, used for australium, strange, renamed & skinned versions.
		case 204: why = "weapon_syringegun";			//Same as default Syringe gun, used for strange, renamed & skinned versions.
		case 205: why = "weapon_rocketlauncher";		//Same as default Rocket Launcher, used for australium, strange, renamed & skinned versions.
		case 206: why = "weapon_grenadelauncher";		//Same as default Grenade Launcher, used for australium, strange, renamed & skinned versions.
		case 207: why = "weapon_stickybomblauncher";	//Same as default Stickybomb Launcher, used for australium, strange, renamed & skinned versions.
		case 208: why = "weapon_flamethrower";			//Same as default Flamethrower, used for australium, strange, renamed & skinned versions.
		case 209: {										//Same as default Pistol, used for strange, renamed & skinned versions.
			why = "weapon_pistol";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 210: why = "weapon_revolver";				//Same as default Revolver, used for strange, renamed &  skinned versions.
		case 214: why = "weapon_powerjack";				//The Powerjack.
		case 215: why = "weapon_degreaser";				//The Degreaser.
		case 220: why = "weapon_shortstop";				//The Shortstop.
		case 221: why = "weapon_holymackerel";			//The Holy Mackerel.
		case 224: why = "weapon_letranger";				//The L'etranger.
		case 225: why = "weapon_eternalreward";			//The Eternal Reward.
		case 228: why = "weapon_blackbox";				//The Black Box.
		case 230: why = "weapon_sydneysleeper";			//The Sydney Sleeper.
		case 232: why = "weapon_bushwacka";				//The Bushwacka.
		case 237: why = "weapon_rocketlauncher";		//The Rocket Jumper (Just because why not.)
		case 239: why = "weapon_goru";					//The Gloves of Running Urgently.
		case 264: {										//The Frying Pan.
			why = "weapon_fryingpan";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 265: why = "weapon_stickybomblauncher";	//The Sticky Jumper (I mean.. why? not? i guess?.)
		case 266: why = "weapon_hhhh";					//The Horseless Headless Horsemann's Headtaker. (That's a long name, whew.)
		case 294: {										//Same as the other Lugermorph.
			why = "weapon_lugermorph";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 298: why = "weapon_ironcurtain";			//The Iron Curtain.
		case 304: why = "weapon_amputator";				//The Amputator.
		case 305: why = "weapon_crusaderscrossbow";		//The Crusader's Crossbow.
		case 307: why = "weapon_ullapoolcaber";			//The Ullapool Caber.
		case 308: why = "weapon_lochnload";				//The Loch-n-Load.
		case 310: why = "weapon_warriorsspirit";		//The Warriors Spirit.
		case 312: why = "weapon_brassbeast";			//The Brass Beast.
		case 317: why = "weapon_candycane";				//The Candy Cane.
		case 325: why = "weapon_bostonbasher";			//The Boston Basher.
		case 326: why = "weapon_backscratcher";			//The Back Scratcher. (Isn't this one too harsh to be one?. /s)
		case 327: why = "weapon_claidheamhmor";			//The Claidheamh Mór.
		case 329: why = "weapon_jag";					//The Jag ('Jag' literally means 'me' in swedish).
		case 331: why = "weapon_fistsofsteel";			//The Fists Of Steel.
		case 348: why = "weapon_sharpenedvolcanofragment";//The Sharpened Volcano Fragment.
		case 349: why = "weapon_sunonastick";			//The Sun-On-A-Stick (Does anybody really use this weapon?.)
		case 351: why = "weapon_detonator";				//The Detonator.
		case 355: why = "weapon_fanowar";				//The Fan O' War.
		case 356: why = "weapon_conniverskunai";		//The Conniver's Kunai.
		case 357: why = "weapon_halfzatoichi";			//The Half-Zatoichi.
		case 401: why = "weapon_shahanshah";			//The Shahanshah.
		case 402: why = "weapon_bazaarbargain";			//The Bazaar Bargain.
		case 404: why = "weapon_persainpersuader";		//The Persain Persuader.
		case 406: why = "weapon_splendidscreen";		//The Splendid Screen.
		case 412: why = "weapon_overdose";				//The Overdose.
		case 413: why = "weapon_solemnvow";				//The Solemn Vow.
		case 414: why = "weapon_libertylauncher";		//The Liberty Launcher.
		case 415: why = "weapon_reserveshooter";		//The Reserve Shooter.
		case 416: why = "weapon_marketgardener";		//The Market Gardener.
		case 423: {										//The Saxxy.
			why = "weapon_saxxy";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 424: why = "weapon_tomislav";				//The Tomislav.
		case 425: why = "weapon_familybusiness";		//The Family Business.
		case 426: why = "weapon_evictionnotice";		//The Eviction Notice.
		case 441: why = "weapon_cowmangler5000";		//The Cow Mangler 5000.
		case 442: why = "weapon_righteousbison";		//The Righeous Bison.
		case 444: why = "weapon_mantreads";				//The Mantreads.
		case 447: why = "weapon_disciplinaryaction";	//The Disciplinary Action.
		case 448: why = "weapon_sodapopper";			//The Soda Popper.
		case 449: why = "weapon_winger";				//The Winger.
		case 450: why = "weapon_atomizer";				//The Atomizer.
		case 452: why = "weapon_threeruneblade";		//The Three-Rune-Blade.
		case 457: why = "weapon_postalpummeler";		//The Postal Pummeler.
		case 460: why = "weapon_enforcer";				//The Enforcer.
		case 461: why = "weapon_bigearner";				//The Big Earner.
		case 466: why = "weapon_maul";					//The Maul.
		case 474: why = "weapon_conscentiousobjector";	//The Conscentious Objector.
		case 482: why = "weapon_nessiesnineiron";		//The Nessie's Nine Iron.
		case 513: why = "weapon_original";				//The Original.
		case 525: why = "weapon_diamondback";			//The Diamond Back.
		case 526: why = "weapon_machina";				//The Machine.
		case 527: why = "weapon_widowmaker";			//The Widowmaker.
		case 528: why = "weapon_shortcircuit";			//The Short Circuit.
		case 572: {										//The Unarmed Combat.
			why = "weapon_unarmedcombat";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 574: why = "weapon_wangaprick";			//The Wanga Prick.
		case 587: why = "weapon_apocofists";			//The Apoco Fists.
		case 588: why = "weapon_pomson6000";			//The Pomson 6000.
		case 589: why = "weapon_eurekaeffect";			//The Eureka Effect.
		case 593: why = "weapon_thirddegree";			//The Third Degree.
		case 594: why = "weapon_phlogistinator";		//The Phlogistinator.
		case 595: why = "weapon_manmelter";				//The Man Melter.
		case 609: why = "weapon_scottishhandshake";		//The Scottish Handshake.
		case 638: why = "weapon_sharpdresser";			//The Sharp Dresser.
		case 648: why = "weapon_wrapassassin";			//The Wrap Assassin.
		case 649: why = "weapon_spycicle";				//The Spycicle.
		case 654: why = "weapon_minigun";				//The Festive Minigun.
		case 656: why = "weapon_holidaypunch";			//The Holiday Punch.
		case 658: why = "weapon_rocketlauncher";		//The Festive Rocket Launcher.
		case 659: why = "weapon_flamethrower";			//The Festive Flamethrower.
		case 660: why = "weapon_bat";					//The Festive Bat.
		case 661: why = "weapon_stickybomblauncher";	//The Festive StickyBomb Launcher.
		case 662: why = "weapon_wrench";				//The Festive Wrench.
		case 664: why = "weapon_sniperrifle";			//The Festive Sniper Rifle.
		case 665: why = "weapon_knife";					//The Festive Knife.
		case 669: why = "weapon_scattergun";			//The Festive Scattergun.
		case 727: why = "weapon_blackrose";				//The Blackrose.
		case 739: why = "weapon_lollichop";				//The Lollichop.
		case 740: why = "weapon_scorchshot";			//The Shorch Shot.
		case 741: why = "weapon_rainblower";			//The Rainblower.
		case 751: why = "weapon_cleanerscarbine";		//The Cleaner's Carbine.
		case 752: why = "weapon_hitmansheatmaker";		//The Hitman's Heatmaker.
		case 772: why = "weapon_babyfacesblaster";		//The Baby Face's Blaster.
		case 773: why = "weapon_prettyboyspocketpistol";//The Pretty Boy's Pocket Pistol.
		case 775: why = "weapon_escapeplan";			//The Escape Plan.
		case 792: why = "weapon_sniperrifle";			//The Silver Botkiller Mk. I Sniper Rifle.
		case 793: why = "weapon_minigun";				//The Silver Botkiller Mk. I Minigun.
		case 795: why = "weapon_wrench";				//The Silver Botkiller Mk. I Wrench.
		case 797: why = "weapon_stickybomblauncher";	//The Silver Botkiller Mk. I StickyBomb Launcher.
		case 798: why = "weapon_flamethrower";			//The Silver Botkiller Mk. I Flamethrower.
		case 799: why = "weapon_scattergun";			//The Silver Botkiller Mk. I Scattergun.
		case 800: why = "weapon_rocketlauncher";		//The Silver Botkiller Mk. I Rocket Launcher.
		case 801: why = "weapon_sniperrifle";			//The Gold Botkiller Mk. I Sniper Rifle.
		case 802: why = "weapon_minigun";				//The Gold Botkiller Mk. I Minigun.
		case 804: why = "weapon_wrench";				//The Gold Botkiller Mk. I Wrench.
		case 806: why = "weapon_stickybomblauncher";	//The Gold Botkiller Mk. I StickyBomb Launcher.
		case 807: why = "weapon_flamethrower";			//The Gold Botkiller Mk. I Flamethrower.
		case 808: why = "weapon_scattergun";			//The Gold Botkiller Mk. I Scattergun.
		case 809: why = "weapon_rocketlauncher";		//The Gold Botkiller Mk. I Rocket Launcher.
		case 811: why = "weapon_huolongheater";			//The Huo-Long Heater.
		case 812: why = "weapon_flyingguillotine";		//The Flying Guillotine.
		case 813: why = "weapon_neonannihilator";		//The Neon Annhiliator.
		case 832: why = "weapon_huolongheater";			//The Genuine Huo-Long Heater.
		case 833: why = "weapon_flyingguillotine";		//The Genuine Guillotine.
		case 834: why = "weapon_neonannihilator";		//The Genuine Neon Annihilator.
		case 850: why = "weapon_minigun";				//The MvM Minigun Deflector.
		case 851: why = "weapon_awperhand";				//The AWPer Hand.
		case 880: {										//The Freedom Staff.
			why = "weapon_freedomstaff";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 881: why = "weapon_sniperrifle";			//The Rust Botkiller Mk. I Sniper Rifle.
		case 882: why = "weapon_minigun";				//The Rust Botkiller Mk. I Minigun.
		case 884: why = "weapon_wrench";				//The Rust Botkiller Mk. I Wrench.
		case 886: why = "weapon_stickybomblauncher";	//The Rust Botkiller Mk. I StickyBomb Launcher.
		case 887: why = "weapon_flamethrower";			//The Rust Botkiller Mk. I Flamethrower
		case 888: why = "weapon_scattergun";			//The Rust Botkiller Mk. I Scattergun.
		case 889: why = "weapon_rocketlauncher";		//The Rust Botkiller Mk. I Rocket Launcher.
		case 890: why = "weapon_sniperrifle";			//The Blood Botkiller Mk. I Sniper Rifle.
		case 891: why = "weapon_minigun";				//The Blood Botkiller Mk. I Minigun.
		case 893: why = "weapon_wrench";				//The Blood Botkiller Mk. I Wrench.
		case 895: why = "weapon_stickybomblauncher";	//The Blood Botkiller Mk. I StickyBomb Launcher.
		case 896: why = "weapon_flamethrower";			//The Blood Botkiller Mk. I Flamethrower
		case 897: why = "weapon_scattergun";			//The Blood Botkiller Mk. I Scattergun.
		case 898: why = "weapon_rocketlauncher";		//The Blood Botkiller Mk. I Rocket Launcher.
		case 899: why = "weapon_sniperrifle";			//The Carbonado Botkiller Mk. I Sniper Rifle.
		case 900: why = "weapon_minigun";				//The Carbonado Botkiller Mk. I Minigun.
		case 902: why = "weapon_wrench";				//The Carbonado Botkiller Mk. I Wrench.
		case 904: why = "weapon_stickybomblauncher";	//The Carbonado Botkiller Mk. I StickyBomb Launcher.
		case 905: why = "weapon_flamethrower";			//The Carbonado Botkiller Mk. I Flamethrower
		case 906: why = "weapon_scattergun";			//The Carbonado Botkiller Mk. I Scattergun.
		case 907: why = "weapon_rocketlauncher";		//The Carbonado Botkiller Mk. I Rocket Launcher.
		case 908: why = "weapon_sniperrifle";			//The Diamond Botkiller Mk. I Sniper Rifle.
		case 909: why = "weapon_minigun";				//The Diamond Botkiller Mk. I Minigun.
		case 911: why = "weapon_wrench";				//The Diamond Botkiller Mk. I Wrench.
		case 913: why = "weapon_stickybomblauncher";	//The Diamond Botkiller Mk. I StickyBomb Launcher.
		case 914: why = "weapon_flamethrower";			//The Diamond Botkiller Mk. I Flamethrower
		case 915: why = "weapon_scattergun";			//The Diamond Botkiller Mk. I Scattergun.
		case 916: why = "weapon_rocketlauncher";		//The Diamond Botkiller Mk. I Rocket Launcher.
		case 939: {										//The Bat Outta Hell.
			why = "weapon_batouttahell";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 954: { 									//The Memory Maker.
			why = "weapon_memorymaker";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 957: why = "weapon_sniperrifle";			//The Silver Botkiller Mk. II Sniper Rifle.
		case 958: why = "weapon_minigun";				//The Silver Botkiller Mk. II Minigun.
		case 960: why = "weapon_wrench";				//The Silver Botkiller Mk. II Wrench.
		case 962: why = "weapon_stickybomblauncher";	//The Silver Botkiller Mk. II StickyBomb Launcher.
		case 963: why = "weapon_flamethrower";			//The Silver Botkiller Mk. II Flamethrower
		case 964: why = "weapon_scattergun";			//The Silver Botkiller Mk. II Scattergun.
		case 965: why = "weapon_rocketlauncher";		//The Silver Botkiller Mk. II Rocket Launcher.
		case 966: why = "weapon_sniperrifle";			//The Gold Botkiller Mk. II Sniper Rifle.
		case 967: why = "weapon_minigun";				//The Gold Botkiller Mk. II Minigun.
		case 969: why = "weapon_wrench";				//The Gold Botkiller Mk. II Wrench.
		case 971: why = "weapon_stickybomblauncher";	//The Gold Botkiller Mk. II StickyBomb Launcher.
		case 972: why = "weapon_flamethrower";			//The Gold Botkiller Mk. II Flamethrower
		case 973: why = "weapon_scattergun";			//The Gold Botkiller Mk. II Scattergun.
		case 974: why = "weapon_rocketlauncher";		//The Gold Botkiller Mk. II Rocket Launcher.
		case 996: why = "weapon_loosecannon";			//The Loose Cannon.
		case 997: why = "weapon_rescueranger";			//The Rescue Ranger.
		case 999: why = "weapon_holymackerel";			//The Festive Holy Mackerel.
		case 1000: why = "weapon_axtinguisher";			//The Festive Axtinguisher.
		case 1003: why = "weapon_ubersaw";				//The Festive Ubersaw.
		case 1004: why = "weapon_frontierjustice";		//The Festive Frontier Justice.
		case 1005: why = "weapon_huntsman";				//The Festive Huntsman.
		case 1006: why = "weapon_ambassador";			//The Festive Ambassador.
		case 1007: why = "weapon_grenadelauncher";		//The Festive Grenade Launcher.
		case 1013: {									//The Ham Shank.
			why = "weapon_hamshank";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 1071: {									//The Golden Frying Pan.
			why = "weapon_goldenfryingpan";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 1078: why = "weapon_forceanature";			//The Festive Force-A-Nature.
		case 1079: why = "weapon_crusaderscrossbow";	//The Festive Crusader's Crossbow.
		case 1081: why = "weapon_flaregun";				//The Festive Flare Gun.
		case 1082: why = "weapon_eyelander";			//The Festive Eyelander.
		case 1084: why = "weapon_goru";					//The Festive Gloves Of Running Urgently.
		case 1085: why = "weapon_blackbox";				//The Festive Black Box.
		case 1092: why = "weapon_fortifiedcompound";	//The Fortified Compound.
		case 1098: why = "weapon_classic";				//The Classic.
		case 1099: why = "weapon_tideturner";			//The Tide Turner.
		case 1100: why = "weapon_breadbite";			//The Bread Bite.
		case 1103: why = "weapon_backscatter";			//The Back Scatter.
		case 1104: why = "weapon_airstrike";			//The Air Strike.
		case 1123: {									//The Necro Smasher.
			why = "weapon_necrosmasher";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 1127: {									//The Crossing Guard.
			why = "weapon_crossingguard";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 1141: {									//The Festive Shotgun.
			why = "weapon_shotgun";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 1142: why = "weapon_revolver";				//The Festive Revolver.
		case 1144: why = "weapon_chargintarge";			//The Festive Chargin' Targe.
		case 1446: why = "weapon_backburner";			//The Festive Backburner.
		case 1149: why = "weapon_smg";					//The Festive SMG.
		case 1150: why = "weapon_quickiebomblauncher";	//The QuickieBomb Launcher.
		case 1151: why = "weapon_ironbomber";			//The Iron Bomber.
		case 1153: why = "weapon_panicattack";			//The Panic Attack.
		case 1178: why = "weapon_dragonsfury";			//The Dragon's Fury.
		case 1179: why = "weapon_thermalthruster";		//The Thermal Thruster.
		case 1181: why = "weapon_hothand";				//The Hot Hand.
		case 1184: why = "weapon_goru";					//The MvM Gloves Of Running Urgently.
		case 15000: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Night Owl.
		case 15001: why = "weapon_smg";					//Skinned SMG.					Woodsy Widowmaker.
		case 15002: why = "weapon_scattergun";			//Skinned Scattergun.			Night Terror.
		case 15004: why = "weapon_minigun";				//Skinned Minigun.				King of The Jungle.
		case 15005: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Forest Fire.
		case 15006: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Woodland Warrior.
		case 15007: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Purple Range.
		case 15009: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Sudden Flurry.
		case 15011: why = "weapon_revolver";			//Skinned Revolver.				Psychedeic Slugger.
		case 15012: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Carpet Bomber.
		case 15014: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Sand Cannon.
		case 15015: why = "weapon_scattergun";			//Skinned Scattergun.			Tartan Torpedo.
		case 15017: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Barn Burner.
		case 15019: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Lumber From Down Under.
		case 15020: why = "weapon_minigun";				//Skinned Minigun.				Iron Wood.
		case 15021: why = "weapon_scattergun";			//Skinned Scattergun.			Country Crusher.
		case 15022: why = "weapon_smg";					//Skinned SMG.					Plaid Potshotter.
		case 15023: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Shot In The Dark.
		case 15024: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Blasted Bombardier.
		case 15026: why = "weapon_minigun";				//Skinned Minigun.				Antique Annihilator.
		case 15027: why = "weapon_revolver";			//Skinned Revolver.				Old Country.
		case 15028: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		American Pastoral.
		case 15029: why = "weapon_scattergun";			//Skinned Scattergun.			Backcountry Blaster.
		case 15030: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Bovine Blazemaker.
		case 15031: why = "weapon_minigun";				//Skinned Minigun.				War Room.
		case 15032: why = "weapon_smg";					//Skinned SMG.					Treadplate Tormenter.
		case 15033: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Bogtrotter.
		case 15034: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Earth, Sky and Fire.
		case 15036: why = "weapon_scattergun";			//Skinned Scattergun.			Spruce Deuce.
		case 15037: why = "weapon_smg";					//Skinned SMG.					Team Sprayer.
		case 15038: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Rooftop Wrangler.
		case 15040: why = "weapon_minigun";				//Skinned Minigun.				Citizen Pain.
		case 15042: why = "weapon_revolver";			//Skinned Revolver.				Mayor.
		case 15043: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Smalltown Bringdown.
		case 15045: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Liquid Asset.
		case 15048: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Pink Elephant.
		case 15049: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Flash Fryer.
		case 15051: why = "weapon_revolver";			//Skinned Revolver.				Dead Reckoner.
		case 15052: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Shell Shocker.
		case 15053: why = "weapon_rocketlauncher";		//Skinned Scattergun.			Current Event.
		case 15054: why = "weapon_rocketlauncher";		//Skinned Flame Thrower.		Turbine Torcher.
		case 15055: why = "weapon_minigun";				//Skinned Minigun.				Brick House.
		case 15057: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Aqua Marine.
		case 15058: why = "weapon_smg";					//Skinned SMG.					Low Profile.
		case 15059: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Thunderbolt.
		case 15062: why = "weapon_revolver";			//Skinned Revolver.				Boneyard.
		case 15063: why = "weapon_revolver";			//Skinned Revolver.				Wildwood.
		case 15064: why = "weapon_revolver";			//Skinned Revolver.				Macabre Web.
		case 15065: why = "weapon_scattergun";			//Skinned Scattergun.			Macabre Web.
		case 15066: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Autumn.
		case 15067: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Pumpkin Patch.
		case 15068: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Nutcracker.
		case 15069: why = "weapon_scattergun";			//Skinned Scattergun.			Nutcracker.
		case 15070: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Pumpkin Patch.
		case 15071: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Boneyard.
		case 15072: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Wildwood.
		case 15073: why = "weapon_wrench";				//Skinned Wrench.				Nutcracker.
		case 15074: why = "weapon_wrench";				//Skinned Wrench.				Autumn.
		case 15075: why = "weapon_wrench";				//Skinned Wrench.				Boneyard.
		case 15076: why = "weapon_smg";					//Skinned SMG.					Wildwood.
		case 15077: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Autumn.
		case 15079: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Macabre Web.
		case 15081: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Autumn.
		case 15082: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Autumn.
		case 15083: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Pumpkin Patch.
		case 15084: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Macabre Web.
		case 15086: why = "weapon_minigun";				//Skinned Minigun.				Macabre Web.
		case 15087: why = "weapon_minigun";				//Skinned Minigun.				Pumpkin Patch.
		case 15088: why = "weapon_minigun";				//Skinned Minigun.				Nutcracker.
		case 15089: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Balloonicorn.
		case 15090: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Rainbow.
		case 15091: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Rainbow.
		case 15092: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Sweet Dreams.
		case 15094: why = "weapon_knife";				//Skinned Knife.				Blue Mew.
		case 15095: why = "weapon_knife";				//Skinned Knife.				Brain Candy.
		case 15096: why = "weapon_knife";				//Skinned Knife.				Stabbed To Hell.
		case 15098: why = "weapon_minigun";				//Skinned Minigun.				Brain Candy.
		case 15099: why = "weapon_minigun";				//Skinned Minigun.				Mister Cuddles.
		case 15103: why = "weapon_revolver";			//Skinned Revolver.				Flower Power.
		case 15104: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Blue Mew.
		case 15105: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Brain Candy.
		case 15106: why = "weapon_scattergun";			//Skinned Scattergun.			Bluw Mew.
		case 15107: why = "weapon_scattergun";			//Skinned Scattergun.			Flower Power.
		case 15108: why = "weapon_scattergun";			//Skinned Scattergun.			Shot to Hell.
		case 15110: why = "weapon_smg";					//Skinned SMG.					Blue Mew.
		case 15111: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Balloonicorn.
		case 15112: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Rainbow.
		case 15113: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Sweet Dreams.
		case 15114: why = "weapon_wrench";				//Skinned Wrench.				Torqued To Hell.
		case 15115: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Coffin Nail.
		case 15116: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Coffin Nail.
		case 15117: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Top Shelf.
		case 15118: why = "weapon_knife";				//Skinned Knife.				Dressed To Kill.
		case 15119: why = "weapon_knife";				//Skinned Knife.				Top Shelf.
		case 15123: why = "weapon_minigun";				//Skinned Minigun.				Coffin Nail.
		case 15124: why = "weapon_minigun";				//Skinned Minigun.				Dressed To Kill.
		case 15125: why = "weapon_minigun";				//Skinned Minigun.				Top Shelf.
		case 15127: why = "weapon_revolver";			//Skinned Revolver.				Top Shelf.
		case 15128: why = "weapon_revolver";			//Skinned Revolver.				Top Shelf.
		case 15129: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Coffin Nail.
		case 15130: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		High Roller's.
		case 15131: why = "weapon_scattergun";			//Skinned Scattergun.			Coffin Nail.
		case 15134: why = "weapon_smg";					//Skinned SMG.					High Roller's.
		case 15135: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Coffin Nail.
		case 15136: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Dressed To Kill.
		case 15137: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Coffin Nail.
		case 15138: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Dressed To Kill.
		case 15139: why = "weapon_wrench";				//Skinned Wrench.				Dressed To Kill.
		case 15140: why = "weapon_wrench";				//Skinned Wrench.				Top Shelf.
		case 15141: why = "weapon_flamethrower";		//Skinned Flame Thrower.		Warhawk.
		case 15142: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Warhawk.
		case 15143: why = "weapon_knife";				//Skinned Knife.				Blitzkrieg.
		case 15144: why = "weapon_knife";				//Skinned Knife.				Airwolf.
		case 15147: why = "weapon_minigun";				//Skinned Minigun.				Butcher Bird.
		case 15149: why = "weapon_revolver";			//Skinned Revolver.				Blitzkrieg.
		case 15050: why = "weapon_rocketlauncher";		//Skinned Rocket Launcher.		Warhawk.
		case 15151: why = "weapon_scattergun";			//Skinned Scattergun.			Killer Bee.
		case 15153: why = "weapon_smg";					//Skinned SMG.					Blitzkrieg.
		case 15154: why = "weapon_sniperrifle";			//Skinned Sniper Rifle.			Airwolf.
		case 15155: why = "weapon_stickybomblauncher";	//Skinned Stickybomb Launcher.	Blitzkrieg.
		case 15156: why = "weapon_wrench";				//Skinned Wrench.				Airwolf.
		case 15157: why = "weapon_scattergun";			//Skinned Scattergun.			Corsair.
		case 15158: why = "weapon_grenadelauncher";		//Skinned Grenade Launcher.		Butcher Bird.
		case 19010: why = "weapon_rocketlauncher";		//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 1.
		case 19011: why = "weapon_shotgun";				//TF2Items Give Weapon: Beta Pocket Shotgun.
		case 19012: why = "weapon_equalizer";			//TF2Items Give Weapon: Beta Split Equalizer 1.
		case 19013: why = "weapon_equalizer";			//TF2Items Give Weapon: Beta Split Equalizer 2.
		case 19015: why = "weapon_sniperrifle";			//TF2Items Give Weapon: Beta Sniper Rifle 1.
		case 19016: why = "weapon_rocketlauncher";		//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 2.
		case 19017: why = "weapon_rocketlauncher";		//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 3.
		case 30474: why = "weapon_nostromonapalmer";	//The Nostromo Napalmer.
		case 30665: why = "weapon_shootingstar";		//The Shooting Star.
		case 30666: {									//The C.A.P.P.E.R.
			why = "weapon_capper";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		case 30667: why = "weapon_batsaber";			//The Batsaber.
		case 30668: why = "weapon_gigarcounter";		//The Gigarcounter.
		case 30758: {									//The Prinny Machete.
			why = "weapon_prinnymachete";
			Format(why, sizeof(why), "%s_%s", why, TF2_GetClassTypeNameLC[class]);
		}
		default: Format(why, sizeof(why), format);
	}
	
	// Separating the weapon skins with classes.
	
	switch(weapon_defindex) {
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
				case TFClass_Scout: why = "weapon_pistol_scout";
				case TFClass_Engineer: why = "weapon_pistol_engineer";
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
				case TFClass_Soldier: why = "weapon_shotgun_soldier";
				case TFClass_Pyro: why = "weapon_shotgun_pyro";
				case TFClass_Heavy: why = "weapon_shotgun_heavy";
				case TFClass_Engineer: why = "weapon_shotgun_engineer";
			}
		}
	}
	
	strcopy(weapon, maxlen, why);
}