char TF2_ClassTypeNameLC[][] = {
	"unknown",
	"scout",
	"sniper",
	"soldier",
	"demoman",
	"medic",
	"heavy",
	"pyro",
	"spy",
	"engineer",
	"civilian"		
};

void GetPlayerName(int client, char[] name, int maxlen)
{
	switch(IsValidDeveloperType(client))
	{
		case 1: Format(name, maxlen, "{unusual}%N{default}", client);
		case 2: Format(name, maxlen, "{cyan}%N{default}", client);
		case 3: Format(name, maxlen, "{orange}%N{default}", client);
		case 4: Format(name, maxlen, "{lightgreen}%N{default}", client);
		default:
		{
			if(!IsClientInGame(client))
			{
				Format(name, maxlen, "{grey}%N{default}", client);
				return;
			}
			//int team = GetEntProp(client, Prop_Send, "m_iTeamNum");
			int team = GetClientTeam(client);
			
			switch(team)
			{
				case 2: Format(name, maxlen, "{red}%N{default}", client);
				case 3: Format(name, maxlen, "{blue}%N{default}", client);
				case 4: Format(name, maxlen, "{green}%N{default}", client);
				case 5: Format(name, maxlen, "{yellow}%N{default}", client);
				default: Format(name, maxlen, "{grey}%N{default}", client);
			}
		}
	}
}

/**
 *	Fix the classnames & definition indexes to be correct. It's a mess.. So many weapons.. Please don't mind.
 *
 *	@param	client		The users index, used for defining the weapon's class if upgraded version was used.
 *	@param	weapon		The string to copy to.
 *	@param	maxlen		The maximum length of the string.
 *	@param	itemdef		The weapon definition index to read.
 *	@param	classname	The weapon classname to read.
 */
stock void CorrectWeaponClassname(TFClassType class, char[] weapon, int maxlen, int itemdef, const char[] classname)
{
	switch(itemdef)
	{
		// tf_weapon_bat
		case
		  0		//The Bat.
		, 190	//The Bat. Used for strange, renamed & skinned versions.
		, 660	//The Festive Bat.
		: strcopy(weapon, maxlen, "tf_weapon_bat");
		
		// tf_weapon_bottle
		case
		  1		//The Bottle.
		, 191	//The Bottle. Used for strange, renamed & skinned versions.
		: strcopy(weapon, maxlen, "tf_weapon_bottle");
		
		// tf_weapon_fireaxe
		case 
		  2		//The Fire Axe.
		, 192	//The Fire Axe. Used for strange, renamed & skinned versions.
		: strcopy(weapon, maxlen, "tf_weapon_fireaxe");
		
		// tf_weapon_kukri
		case
		  3		//The Kukri.
		, 193	//The Kukri. Used for strange, renamed & skinned versions.
		: strcopy(weapon, maxlen, "tf_weapon_kukri");
		
		// tf_weapon_knife
		case
		  4		//The Knife. (Butterfly knife for Spy.)
		, 194	//The Knife. Used for australium, strange, renamed & skinned versions.
		, 665 	//The Festive Knife.
		, 15094	//Skinned Knife. Blue Mew.
		, 15095	//Skinned Knife. Brain Candy.
		, 15096	//Skinned Knife. Stabbed To Hell.
		, 15118	//Skinned Knife. Dressed To Kill.
		, 15119	//Skinned Knife. Top Shelf.
		, 15143	//Skinned Knife. Blitzkrieg.
		, 15144	//Skinned Knife. Airwolf.
		: strcopy(weapon, maxlen, "tf_weapon_knife");
		
		// tf_weapon_fists
		case
		  5		//The Fists.
		, 195	//The Fists. Used for strange, renamed & skinned versions.
		: strcopy(weapon, maxlen, "tf_weapon_fists");
		
		// tf_weapon_shovel
		case
		  6		//The Shovel.
		, 196	//The Shovel. Used for strange, renamed & skinned versions.
		: strcopy(weapon, maxlen, "tf_weapon_shovel");
		
		// tf_weapon_wrench
		case
		  7		//The Wrench.
		, 197	//The Wrench. Used for australium, strange, renamed & skinned versions.
		, 662	//The Festive Wrench.
		, 795	//The Silver Botkiller Mk. I Wrench.
		, 804	//The Gold Botkiller Mk. I Wrench.
		, 807	//The Gold Botkiller Mk. I Flamethrower.
		, 884	//The Rust Botkiller Mk. I Wrench.
		, 893	//The Blood Botkiller Mk. I Wrench.
		, 902	//The Carbonado Botkiller Mk. I Wrench.
		, 911	//The Diamond Botkiller Mk. I Wrench.
		, 960	//The Silver Botkiller Mk. II Wrench.
		, 969	//The Gold Botkiller Mk. II Wrench.
		, 15073	//Skinned Wrench. Nutcracker.
		, 15074	//Skinned Wrench. Autumn.
		, 15075	//Skinned Wrench. Boneyard.
		, 15114	//Skinned Wrench. Torqued To Hell.
		, 15139	//Skinned Wrench. Dressed To Kill.
		, 15140	//Skinned Wrench. Top Shelf.
		, 15156	//Skinned Wrench. Airwolf.
		: strcopy(weapon, maxlen, "tf_weapon_wrench");
		
		// tf_weapon_bonesaw
		case
		  8		//The Bonesaw.
		, 198	//The Bonesaw. Used for strange, renamed & skinned versions.
		: strcopy(weapon, maxlen, "tf_weapon_bonesaw");
		
		// tf_weapon_shotgun
		case
		  9		//The Shotgun, Class: Engineer.
		, 10	//The Shotgun, Class: Soldier.
		, 11	//The Shotgun, Class: Heavy.
		, 12	//The Shotgun, Class: Pyro.
		, 199	//The Shotgun. Used for strange, renamed & skinned versions.
		, 1141	//The Festive Shotgun.
		, 15003	//Skinned Shotgun. Backwoods Boomstick.
		, 15016	//Skinned Shotgun.  Rustic Ruiner.
		, 15044	//Skinned Shotgun.  Civic Duty.
		, 15047	//Skinned Shotgun.  Lightning Rod.
		, 15085	//Skinned Shotgun.  Autumn.
		, 15109	//Skinned Shotgun.  Flower Power.
		, 15132	//Skinned Shotgun.  Coffin Nail.
		, 15133	//Skinned Shotgun.  Dressed To Kill.
		, 15152	//Skinned Shotgun.  Red Bear.
		, 19011	//TF2Items Give Weapon: Beta Pocket Shotgun.
		: Format(weapon, maxlen, "tf_weapon_shotgun_%s", TF2_ClassTypeNameLC[class]);
		
		// tf_weapon_scattergun
		case
		  13	//The Scattergun.
		, 200	//The Scattergun. Used for strange, renamed & skinned versions.
		, 799	//The Silver Botkiller Mk. I Scattergun.
		, 669	//The Festive Scattergun.
		, 808	//The Gold Botkiller Mk. I Scattergun.
		, 888	//The Rust Botkiller Mk. I Scattergun.
		, 897	//The Blood Botkiller Mk. I Scattergun.
		, 906	//The Carbonado Botkiller Mk. I Scattergun.
		, 915	//The Diamond Botkiller Mk. I Scattergun.
		, 964	//The Silver Botkiller Mk. II Scattergun.
		, 973	//The Gold Botkiller Mk. II Scattergun.
		, 15002	//Skinned Scattergun. Night Terror.
		, 15015	//Skinned Scattergun. Tartan Torpedo.
		, 15021	//Skinned Scattergun. Country Crusher.
		, 15029	//Skinned Scattergun. Backcountry Blaster.
		, 15036	//Skinned Scattergun. Spruce Deuce.
		, 15053	//Skinned Scattergun. Current Event.
		, 15065	//Skinned Scattergun. Macabre Web.
		, 15069	//Skinned Scattergun. Nutcracker.
		, 15106	//Skinned Scattergun. Bluw Mew.
		, 15107	//Skinned Scattergun. Flower Power.
		, 15108	//Skinned Scattergun. Shot to Hell.
		, 15131	//Skinned Scattergun. Coffin Nail.
		, 15151	//Skinned Scattergun. Killer Bee.
		, 15157	//Skinned Scattergun. Corsair.
		: strcopy(weapon, maxlen, "tf_weapon_scattergun");
		
		// tf_weapon_sniperrifle
		case
		  14	//The Sniper Rifle.
		, 201	//The Sniper Rifle. Used for australium, strange, renamed & skinned versions.
		, 664	//The Festive Sniper Rifle.
		, 792	//The Silver Botkiller Mk. I Sniper Rifle.
		, 801	//The Gold Botkiller Mk. I Sniper Rifle.
		, 881	//The Rust Botkiller Mk. I Sniper Rifle.
		, 890	//The Blood Botkiller Mk. I Sniper Rifle.
		, 899	//The Carbonado Botkiller Mk. I Sniper Rifle.
		, 908	//The Diamond Botkiller Mk. I Sniper Rifle.
		, 957	//The Silver Botkiller Mk. II Sniper Rifle.
		, 966	//The Gold Botkiller Mk. II Sniper Rifle.
		, 15000	//Skinned Sniper Rifle. Night Owl.
		, 15007	//Skinned Sniper Rifle. Purple Range.
		, 15019	//Skinned Sniper Rifle. Lumber From Down Under.
		, 15023	//Skinned Sniper Rifle. Shot In The Dark.
		, 15033	//Skinned Sniper Rifle. Bogtrotter.
		, 15059	//Skinned Sniper Rifle. Thunderbolt.
		, 15070	//Skinned Sniper Rifle. Pumpkin Patch.
		, 15071	//Skinned Sniper Rifle. Boneyard.
		, 15072	//Skinned Sniper Rifle. Wildwood.
		, 15111	//Skinned Sniper Rifle. Balloonicorn.
		, 15112	//Skinned Sniper Rifle. Rainbow.
		, 15135	//Skinned Sniper Rifle. Coffin Nail.
		, 15136	//Skinned Sniper Rifle. Dressed To Kill.
		, 15154	//Skinned Sniper Rifle. Airwolf.
		, 19015	//TF2Items Give Weapon: Beta Sniper Rifle 1.
		: strcopy(weapon, maxlen, "tf_weapon_sniperrifle");	
		
		// tf_weapon_minigun
		case
		  15	//The Minigun.
		, 202	//The Minigun. Used for australium, strange, renamed & skinned versions.
		, 654	//The Festive Minigun.
		, 793	//The Silver Botkiller Mk. I Minigun.
		, 802	//The Gold Botkiller Mk. I Minigun.
		, 850	//The MvM Minigun Deflector.
		, 882	//The Rust Botkiller Mk. I Minigun.
		, 891	//The Blood Botkiller Mk. I Minigun.
		, 900	//The Carbonado Botkiller Mk. I Minigun.
		, 909	//The Diamond Botkiller Mk. I Minigun.
		, 958	//The Silver Botkiller Mk. II Minigun.
		, 967	//The Gold Botkiller Mk. II Minigun.
		, 15004	//Skinned Minigun. King of The Jungle.
		, 15020	//Skinned Minigun. Iron Wood.
		, 15026	//Skinned Minigun. Antique Annihilator.
		, 15040	//Skinned Minigun. Citizen Pain.
		, 15055	//Skinned Minigun. Brick House.
		, 15086	//Skinned Minigun. Macabre Web.
		, 15087	//Skinned Minigun. Pumpkin Patch.
		, 15088	//Skinned Minigun. Nutcracker.
		, 15031	//Skinned Minigun. War Room.
		, 15098	//Skinned Minigun. Brain Candy.
		, 15099	//Skinned Minigun. Mister Cuddles.
		, 15123	//Skinned Minigun. Coffin Nail.
		, 15124	//Skinned Minigun. Dressed To Kill.
		, 15125	//Skinned Minigun. Top Shelf.
		, 15147	//Skinned Minigun. Butcher Bird.
		: strcopy(weapon, maxlen, "tf_weapon_minigun");
		
		// tf_weapon_smg
		case
		  16	//The SMG.
		, 203	//The SMG. Used for australium, strange, renamed & skinned versions.
		, 1149	//The Festive SMG.
		, 15001	//Skinned SMG. Woodsy Widowmaker.
		, 15022	//Skinned SMG. Plaid Potshotter.
		, 15032	//Skinned SMG. Treadplate Tormenter.
		, 15037	//Skinned SMG. Team Sprayer.
		, 15058	//Skinned SMG. Low Profile.
		, 15076	//Skinned SMG. Wildwood.
		, 15110	//Skinned SMG. Blue Mew.
		, 15134	//Skinned SMG. High Roller's.
		, 15153	//Skinned SMG. Blitzkrieg.
		: strcopy(weapon, maxlen, "tf_weapon_smg");		
		
		// tf_weapon_syringegun
		case
		  17	//The Syringe Gun.
		, 204	//The Syringe Gun. Used for strange, renamed & skinned versions.
		: strcopy(weapon, maxlen, "tf_weapon_syringegun");
		
		// tf_weapon_rocketlauncher
		case
		  18	//The Rocket Launcher.
		, 205	//The Rocket Launcher. Used for australium, strange, renamed & skinned versions.
		, 237	//The Rocket Jumper (Just because why not.)
		, 658	//The Festive Rocket Launcher.
		, 800	//The Silver Botkiller Mk. I Rocket Launcher.
		, 809	//The Gold Botkiller Mk. I Rocket Launcher.
		, 889	//The Rust Botkiller Mk. I Rocket Launcher.
		, 898	//The Blood Botkiller Mk. I Rocket Launcher.
		, 907	//The Carbonado Botkiller Mk. I Rocket Launcher.
		, 916	//The Diamond Botkiller Mk. I Rocket Launcher.
		, 965	//The Silver Botkiller Mk. II Rocket Launcher.
		, 974	//The Gold Botkiller Mk. II Rocket Launcher.
		, 15006	//Skinned Rocket Launcher. Woodland Warrior.
		, 15014	//Skinned Rocket Launcher. Sand Cannon.
		, 15028	//Skinned Rocket Launcher. American Pastoral.
		, 15043	//Skinned Rocket Launcher. Smalltown Bringdown.
		, 15052	//Skinned Rocket Launcher. Shell Shocker.
		, 15057	//Skinned Rocket Launcher. Aqua Marine.
		, 15081	//Skinned Rocket Launcher. Autumn.
		, 15104	//Skinned Rocket Launcher. Blue Mew.
		, 15105	//Skinned Rocket Launcher. Brain Candy.
		, 15129	//Skinned Rocket Launcher. Coffin Nail.
		, 15130	//Skinned Rocket Launcher. High Roller's.
		, 15050	//Skinned Rocket Launcher. Warhawk.
		, 19010	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 1.
		, 19016	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 2.
		, 19017	//TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 3.
		: strcopy(weapon, maxlen, "tf_weapon_rocketlauncher");
		
		// tf_weapon_grenadelauncher
		case
		  19	//The Grenade Launcher.
		, 206	//The Grenade Launcher. Used for australium, strange, renamed & skinned versions.
		, 1007	//The Festive Grenade Launcher.
		, 15024	//Skinned Grenade Launcher. Blasted Bombardier.		
		, 15038	//Skinned Grenade Launcher. Rooftop Wrangler.
		, 15077	//Skinned Grenade Launcher. Autumn.
		, 15079	//Skinned Grenade Launcher. Macabre Web.
		, 15091	//Skinned Grenade Launcher. Rainbow.
		, 15092	//Skinned Grenade Launcher. Sweet Dreams.
		, 15116	//Skinned Grenade Launcher. Coffin Nail.
		, 15117	//Skinned Grenade Launcher. Top Shelf.
		, 15158	//Skinned Grenade Launcher. Butcher Bird.
		, 15142	//Skinned Grenade Launcher. Warhawk.
		: strcopy(weapon, maxlen, "tf_weapon_grenadelauncher");
		
		// tf_weapon_stickybomblauncher
		case
		  20	//The StickyBomb Launcher.
		, 207	//The StickyBomb Launcher. Used for australium, strange, renamed & skinned versions.
		, 265	//The Sticky Jumper (I mean.. why? not? i guess?.)
		, 661	//The Festive StickyBomb Launcher.
		, 797	//The Silver Botkiller Mk. I StickyBomb Launcher.
		, 806	//The Gold Botkiller Mk. I StickyBomb Launcher.
		, 886	//The Rust Botkiller Mk. I StickyBomb Launcher.
		, 895	//The Blood Botkiller Mk. I StickyBomb Launcher.
		, 904	//The Carbonado Botkiller Mk. I StickyBomb Launcher.
		, 913	//The Diamond Botkiller Mk. I StickyBomb Launcher.
		, 962	//The Silver Botkiller Mk. II StickyBomb Launcher.
		, 971	//The Gold Botkiller Mk. II StickyBomb Launcher.
		, 15009	//Skinned Stickybomb Launcher. Sudden Flurry.
		, 15012	//Skinned Stickybomb Launcher. Carpet Bomber.
		, 15045	//Skinned Stickybomb Launcher. Liquid Asset.
		, 15048	//Skinned Stickybomb Launcher. Pink Elephant.
		, 15082	//Skinned Stickybomb Launcher. Autumn.
		, 15083	//Skinned Stickybomb Launcher. Pumpkin Patch.
		, 15084	//Skinned Stickybomb Launcher. Macabre Web.
		, 15113	//Skinned Stickybomb Launcher. Sweet Dreams.
		, 15137	//Skinned Stickybomb Launcher. Coffin Nail.
		, 15138	//Skinned Stickybomb Launcher. Dressed To Kill.
		, 15155	//Skinned Stickybomb Launcher. Blitzkrieg.
		: strcopy(weapon, maxlen, "tf_weapon_stickybomblauncher");
		
		// tf_weapon_flamethrower
		case
		  21	//The Flame Thrower.
		, 208	//The Flame Thrower. Used for australium, strange, renamed & skinned versions.
		, 659	//The Festive Flamethrower.
		, 798	//The Silver Botkiller Mk. I Flamethrower.
		, 887	//The Rust Botkiller Mk. I Flame Thrower.
		, 896	//The Blood Botkiller Mk. I Flame Thrower.
		, 905	//The Carbonado Botkiller Mk. I Flame Thrower.
		, 914	//The Diamond Botkiller Mk. I Flame Thrower.
		, 963	//The Silver Botkiller Mk. II Flame Thrower.
		, 972	//The Gold Botkiller Mk. II Flame Thrower.
		, 15005	//Skinned Flame Thrower. Forest Fire.
		, 15017	//Skinned Flame Thrower. Barn Burner.
		, 15034	//Skinned Flame Thrower. Earth, Sky and Fire.
		, 15049	//Skinned Flame Thrower. Flash Fryer.
		, 15054	//Skinned Flame Thrower. Turbine Torcher.
		, 15066	//Skinned Flame Thrower. Autumn.
		, 15067	//Skinned Flame Thrower. Pumpkin Patch.
		, 15068	//Skinned Flame Thrower. Nutcracker.
		, 15030	//Skinned Flame Thrower. Bovine Blazemaker.
		, 15089	//Skinned Flame Thrower. Balloonicorn.
		, 15090	//Skinned Flame Thrower. Rainbow.
		, 15115	//Skinned Flame Thrower. Coffin Nail.
		, 15141	//Skinned Flame Thrower. Warhawk.
		: strcopy(weapon, maxlen, "tf_weapon_flamethrower");			
		
		// tf_weapon_pistol
		case
		  22	//The Pistol, Class: Scout.
		, 23	//The Pistol, Class: Engineer.
		, 209	//The Pistol. Used for strange, renamed & skinned versions.
		, 15013	//Skinned Pistol. Red Rock Roscoe.
		, 15018	//Skinned Pistol. Homemade Heater.
		, 15035	//Skinned Pistol. Hickory Holepuncher.
		, 15100	//Skinned Pistol. Blue Mew.
		, 15101	//Skinned Pistol. Brain Candy.
		, 15102	//Skinned Pistol. Shot To Hell.
		, 15041	//Skinned Pistol. Local Hero.
		, 15046	//Skinned Pistol. Black Dahlia.
		, 15056	//Skinned Pistol. Sandstone Special.
		, 15060	//Skinned Pistol. Macabre Web.
		, 15061	//Skinned Pistol. Nutcracker.
		, 15126	//Skinned Pistol. Dressed To Kill.
		, 15148	//Skinned Pistol. Blitzkrieg.
		: Format(weapon, maxlen, "tf_weapon_pistol_%s", TF2_ClassTypeNameLC[class]);
		
		// tf_weapon_revolver
		case
		  24	//The Revolver.
		, 210	//The Revolver. Used for strange, renamed &  skinned versions.
		, 1142	//The Festive Revolver.
		, 15011	//Skinned Revolver. Psychedeic Slugger.
		, 15027	//Skinned Revolver. Old Country.
		, 15042	//Skinned Revolver. Mayor.
		, 15051	//Skinned Revolver. Dead Reckoner.
		, 15062	//Skinned Revolver. Boneyard.
		, 15063	//Skinned Revolver. Wildwood.
		, 15064	//Skinned Revolver. Macabre Web.
		, 15103	//Skinned Revolver. Flower Power.
		, 15127	//Skinned Revolver. Top Shelf.
		, 15128	//Skinned Revolver. Top Shelf.
		, 15149	//Skinned Revolver. Blitzkrieg.
		: strcopy(weapon, maxlen, "tf_weapon_revolver");
		
		// tf_weapon_ubersaw
		case
		  37	//The Ubersaw.
		, 1003	//The Festive Ubersaw.
		: strcopy(weapon, maxlen, "tf_weapon_ubersaw");
		
		// tf_weapon_axtinguisher
		case
		 38		//The Axtinguisher.	
		, 1000	//The Festive Axtinguisher.
		: strcopy(weapon, maxlen, "tf_weapon_axtinguisher");
		
		// tf_weapon_flaregun
		case
		  39	//The Flaregun.
		, 1081	//The Festive Flare Gun.
		: strcopy(weapon, maxlen, "tf_weapon_flaregun");
		
		// tf_weapon_backburner
		case
		  40	//The Backburner.
		, 1446	//The Festive Backburner.
		: strcopy(weapon, maxlen, "tf_weapon_backburner");
		
		// tf_weapon_forceanature
		case
		  45	//The Force-A-Nature.
		, 1078	//The Festive Force-A-Nature.
		: strcopy(weapon, maxlen, "tf_weapon_forceanature");
		
		// tf_weapon_huntsman
		case
		  56	//The Huntsman.
		, 1005	//The Festive Huntsman.
		: strcopy(weapon, maxlen, "tf_weapon_huntsman");
		
		// tf_weapon_ambassador
		case
		  61	//The Ambassador.
		, 1006	//The Festive Ambassador.
		: strcopy(weapon, maxlen, "tf_weapon_ambassador");
		
		// tf_weapon_equalizer
		case
		  128	//The Equalizer
		, 19012	//TF2Items Give Weapon: Beta Split Equalizer 1.			
		, 19013	//TF2Items Give Weapon: Beta Split Equalizer 2.
		: strcopy(weapon, maxlen, "tf_weapon_equalizer");
		
		// tf_weapon_chargintarge
		case
		  131	//The Chargin' Targe.
		, 1144	//The Festive Chargin' Targe.
		: strcopy(weapon, maxlen, "tf_weapon_chargintarge");	
		
		// tf_weapon_eyelander
		case
		  132	//The Eyelander.
		, 1082	//The Festive Eyelander.
		: strcopy(weapon, maxlen, "tf_weapon_eyelander");
		
		// tf_weapon_frontierjustice
		case
		  141	//The Frontier Justice.
		, 1004	//The Festive Frontier Justice.
		: strcopy(weapon, maxlen, "tf_weapon_frontierjustice");
		
		// tf_weapon_lugermorph
		case
		  160	//The Lugermorph.
		, 294	//The Lugermorph. (Vintage.)
		: Format(weapon, maxlen, "tf_weapon_lugermorph_%s", TF2_ClassTypeNameLC[class]);
		
		// tf_weapon_holymackerel
		case
		  221	//The Holy Mackerel.
		, 999	//The Festive Holy Mackerel.
		: strcopy(weapon, maxlen, "tf_weapon_holymackerel");	
		
		// tf_weapon_blackbox
		case
		  228	//The Black Box.
		, 1085	//The Festive Black Box.
		: strcopy(weapon, maxlen, "tf_weapon_blackbox");
		
		// tf_weapon_goru
		case
		  239	//The Gloves of Running Urgently.
		, 1084	//The Festive Gloves Of Running Urgently.
		, 1184	//The MvM Gloves Of Running Urgently.
		: strcopy(weapon, maxlen, "tf_weapon_goru");
		
		// tf_weapon_huolongheater
		case
		  811	//The Huo-Long Heater.
		, 832	//The Huo-Long Heater. (Genuine.)
		: strcopy(weapon, maxlen, "tf_weapon_huolongheater");	
		
		// tf_weapon_flyingguillotine
		case
		  812	//The Flying Guillotine.
		, 833	//The Guillotine. (Genuine.)
		: strcopy(weapon, maxlen, "tf_weapon_flyingguillotine");		
		
		// tf_weapon_neonannihilator
		case
		  813	//The Neon Annhiliator.
		, 834	//The Neon Annihilator. (Genuine.)
		: strcopy(weapon, maxlen, "tf_weapon_neonannihilator");
		
		// tf_weapon_crusaderscrossbow
		case
		  305	//The Crusader's Crossbow.
		, 1079	//The Festive Crusader's Crossbow.
		: strcopy(weapon, maxlen, "tf_weapon_crusaderscrossbow");		
		
		//

		case 36: strcopy(weapon, maxlen, "tf_weapon_blutsauger");				//The Blutsauger.
		case 41: strcopy(weapon, maxlen, "tf_weapon_natascha");					//The Natascha.
		case 43: strcopy(weapon, maxlen, "tf_weapon_kgob");						//The Killer Gloves Of Boxing.
		case 44: strcopy(weapon, maxlen, "tf_weapon_sandman");					//The Sandman.
		case 127: strcopy(weapon, maxlen, "tf_weapon_directhit");				//The Direct-Hit.
		case 130: strcopy(weapon, maxlen, "tf_weapon_scottishresistance");		//The Scottish Resistance.
		case 140: strcopy(weapon, maxlen, "tf_weapon_wrangler");				//The Wrangler.
		case 142: strcopy(weapon, maxlen, "tf_weapon_gunslinger");				//The Gunslinger.
		case 153: strcopy(weapon, maxlen, "tf_weapon_homewrecker");				//The Homewrecker.
		case 154: strcopy(weapon, maxlen, "tf_weapon_paintrain");				//The Pain Train.
		case 155: strcopy(weapon, maxlen, "tf_weapon_southernhospitality");		//The Southern Hospitality.
		case 161: strcopy(weapon, maxlen, "tf_weapon_bigkill");					//The Big Kill.
		case 169: strcopy(weapon, maxlen, "tf_weapon_goldenwrench");			//The Golden Wrench.
		case 171: strcopy(weapon, maxlen, "tf_weapon_tribalmansshiv");			//The Tribalman's Shiv.
		case 172: strcopy(weapon, maxlen, "tf_weapon_scotmansskullcutter");		//The Scotman's Skullcutter.
		case 173: strcopy(weapon, maxlen, "tf_weapon_vitasaw");					//The Vita-Saw.
		case 214: strcopy(weapon, maxlen, "tf_weapon_powerjack");				//The Powerjack.
		case 215: strcopy(weapon, maxlen, "tf_weapon_degreaser");				//The Degreaser.
		case 220: strcopy(weapon, maxlen, "tf_weapon_shortstop");				//The Shortstop.
		case 224: strcopy(weapon, maxlen, "tf_weapon_letranger");				//The L'etranger.
		case 225: strcopy(weapon, maxlen, "tf_weapon_eternalreward");			//The Eternal Reward.
		case 230: strcopy(weapon, maxlen, "tf_weapon_sydneysleeper");			//The Sydney Sleeper.
		case 232: strcopy(weapon, maxlen, "tf_weapon_bushwacka");				//The Bushwacka.
		case 264: Format(weapon, maxlen, "tf_weapon_fryingpan_%s", TF2_ClassTypeNameLC[class]); //The Frying Pan.
		case 266: strcopy(weapon, maxlen, "tf_weapon_hhhh");					//The Horseless Headless Horsemann's Headtaker. (That's a long name, whew.)
		case 298: strcopy(weapon, maxlen, "tf_weapon_ironcurtain");				//The Iron Curtain.
		case 304: strcopy(weapon, maxlen, "tf_weapon_amputator");				//The Amputator.
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
		case 656: strcopy(weapon, maxlen, "tf_weapon_holidaypunch");			//The Holiday Punch.
		case 727: strcopy(weapon, maxlen, "tf_weapon_blackrose");				//The Blackrose.
		case 730: strcopy(weapon, maxlen, "tf_weapon_beggarsbazooka");			//The Beggars Bazooka.
		case 739: strcopy(weapon, maxlen, "tf_weapon_lollichop");				//The Lollichop.
		case 740: strcopy(weapon, maxlen, "tf_weapon_scorchshot");				//The Shorch Shot.
		case 741: strcopy(weapon, maxlen, "tf_weapon_rainblower");				//The Rainblower.
		case 751: strcopy(weapon, maxlen, "tf_weapon_cleanerscarbine");			//The Cleaner's Carbine.
		case 752: strcopy(weapon, maxlen, "tf_weapon_hitmansheatmaker");		//The Hitman's Heatmaker.
		case 772: strcopy(weapon, maxlen, "tf_weapon_babyfacesblaster");		//The Baby Face's Blaster.
		case 773: strcopy(weapon, maxlen, "tf_weapon_prettyboyspocketpistol");	//The Pretty Boy's Pocket Pistol.
		case 775: strcopy(weapon, maxlen, "tf_weapon_escapeplan");				//The Escape Plan.
		case 851: strcopy(weapon, maxlen, "tf_weapon_awperhand");				//The AWPer Hand.
		case 880: Format(weapon, maxlen, "tf_weapon_freedomstaff_%s", TF2_ClassTypeNameLC[class]); //The Freedom Staff.
		case 939: Format(weapon, maxlen, "tf_weapon_batouttahell_%s", TF2_ClassTypeNameLC[class]); //The Bat Outta Hell.
		case 954: Format(weapon, maxlen, "tf_weapon_memorymaker_%s", TF2_ClassTypeNameLC[class]); //The Memory Maker.
		case 996: strcopy(weapon, maxlen, "tf_weapon_loosecannon");				//The Loose Cannon.
		case 997: strcopy(weapon, maxlen, "tf_weapon_rescueranger");			//The Rescue Ranger.
		case 1013: Format(weapon, maxlen, "tf_weapon_hamshank_%s", TF2_ClassTypeNameLC[class]); //The Ham Shank.
		case 1071: Format(weapon, maxlen, "tf_weapon_goldenfryingpan_%s", TF2_ClassTypeNameLC[class]); //The Golden Frying Pan.
		case 1092: strcopy(weapon, maxlen, "tf_weapon_fortifiedcompound");		//The Fortified Compound.
		case 1098: strcopy(weapon, maxlen, "tf_weapon_classic");				//The Classic.
		case 1099: strcopy(weapon, maxlen, "tf_weapon_tideturner");				//The Tide Turner.
		case 1100: strcopy(weapon, maxlen, "tf_weapon_breadbite");				//The Bread Bite.
		case 1103: strcopy(weapon, maxlen, "tf_weapon_backscatter");			//The Back Scatter.
		case 1104: strcopy(weapon, maxlen, "tf_weapon_airstrike");				//The Air Strike.
		case 1123: Format(weapon, maxlen, "tf_weapon_necrosmasher_%s", TF2_ClassTypeNameLC[class]); //The Necro Smasher.
		case 1127: Format(weapon, maxlen, "tf_weapon_crossingguard_%s", TF2_ClassTypeNameLC[class]); //The Crossing Guard.
		case 1150: strcopy(weapon, maxlen, "tf_weapon_quickiebomblauncher");	//The QuickieBomb Launcher.
		case 1151: strcopy(weapon, maxlen, "tf_weapon_ironbomber");				//The Iron Bomber.
		case 1153: strcopy(weapon, maxlen, "tf_weapon_panicattack");			//The Panic Attack.
		case 1178: strcopy(weapon, maxlen, "tf_weapon_dragonsfury");			//The Dragon's Fury.
		case 1179: strcopy(weapon, maxlen, "tf_weapon_thermalthruster");		//The Thermal Thruster.
		case 1181: strcopy(weapon, maxlen, "tf_weapon_hothand");				//The Hot Hand.
		case 30474: strcopy(weapon, maxlen, "tf_weapon_nostromonapalmer");		//The Nostromo Napalmer.
		case 30665: strcopy(weapon, maxlen, "tf_weapon_shootingstar");			//The Shooting Star.
		case 30666: Format(weapon, maxlen, "tf_weapon_capper_%s", TF2_ClassTypeNameLC[class]); //The C.A.P.P.E.R.
		case 30667: strcopy(weapon, maxlen, "tf_weapon_batsaber");				//The Batsaber.
		case 30668: strcopy(weapon, maxlen, "tf_weapon_gigarcounter");			//The Gigarcounter.
		case 30758: Format(weapon, maxlen, "tf_weapon_prinnymachete_%s", TF2_ClassTypeNameLC[class]); //The Prinny Machete.		
		default:
		{
			if(StrEqual(classname, "obj_sentrygun1", false))
			{
				strcopy(weapon, maxlen, "tf_sentrygun_lvl1");
			}
			else if(StrEqual(classname, "obj_sentrygun2", false))
			{
				strcopy(weapon, maxlen, "tf_sentrygun_lvl2");
			}
			else if(StrEqual(classname, "obj_sentrygun3", false))
			{
				strcopy(weapon, maxlen, "tf_sentrygun_lvl3");
			}
			else
			{
				strcopy(weapon, maxlen, classname);
			}
		}
	}
}

stock bool AssistedKills(Transaction txn
					, const int[] list
					, const int[] list_assister
					, const bool[] list_assister_dominate
					, const bool[] list_assister_revenge
					, int frags
					, int client
					, const int[] list_healercount
					, const int[][] list_healer
					, char[] list_steamid_assister)
{
	// spaghetti code
	
	ArrayList assisters;
	for(int i = 0; i < frags; i++)
	{
		int assist = list_assister[i];
		if(assist > 0)
		{
			if(assisters == null)
			{
				assisters = new ArrayList();
			}
			
			if(assisters.FindValue(assist) == -1)
			{
				assisters.Push(assist);
			}
		}
		
		int healers = list_healercount[i];
		if(healers > 0)
		{
			for(int x = 0; x < healers; x++)
			{
				int healer = list_healer[x][i];
				
				if(assisters.FindValue(healer) == -1)
				{
					assisters.Push(healer);
				}
			}
		}
	}
	
	if(assisters != null)
	{
		// create arrays per assisters domination and revenge count.
		int[] assister_count = new int[assisters.Length];
		int[] assister_dominations = new int[assisters.Length];
		int[] assister_revenges = new int[assisters.Length];
		
		for(int i = 0; i < frags; i++)
		{
			int assist = list_assister[i];
			if(assist > 0)
			{
				for(int x = 0; x < assisters.Length; x++)
				{
					if(assisters.Get(x) == assist)
					{
						assister_count[x]++;
						
						if(list_assister_dominate[i])
						{
							assister_dominations[x]++;
						}
						if(list_assister_revenge[i])
						{
							assister_revenges[x]++;
						}
					}
				}
			}
			
			int healers = list_healercount[i];
			if(healers > 0)
			{
				for(int x = 0; x < healers; x++)
				{
					int healer = list_healer[x][i];
					if(healer != assist)
					{
						for(int y = 0; y < assisters.Length; y++)
						{
							if(assisters.Get(y) == healer)
							{
								assister_count[y]++;
							}
						}
					}
				}
			}
		}
		
		// loop information and obtain if the assister did dominate or revenge somebody.
		for(int i = 0; i < assisters.Length; i++)
		{
			int assist = GetClientOfUserId(assisters.Get(i));
			if(IsValidClient(assist))
			{
				g_Player[assist].session[Stats_Assists]++;
				
				char dummy[256];
				GetMultipleTargets(assist, list, frags, dummy, sizeof(dummy));
				
				switch(strlen(list_steamid_assister) < 1)
				{
					case false: Format(list_steamid_assister, 28*assisters.Length, "%s;%s", list_steamid_assister, g_Player[assist].auth);
					case true: Format(list_steamid_assister, 28*assisters.Length, g_Player[assist].auth);
				}
				
				char query[1024];
				int len = 0;
				len += Format(query[len], sizeof(query)-len, "update `%s` set Assists = Assists+%i", sql_table_playerlist, assister_count[i]);
				if(assister_dominations[i] > 0)
				{
					len += Format(query[len], sizeof(query)-len, ", Dominations = Dominations+%i", assister_dominations[i]);
				}
				if(assister_revenges[i] > 0)
				{
					len += Format(query[len], sizeof(query)-len, ", Revenges = Revenges+%i", assister_revenges[i]);
				}
				if(g_AssistPoints > 0)
				{
					len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", g_AssistPoints*assister_count[i]);
				}
				len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[assist].auth, g_ServerID);
				txn.AddQuery(query, queryId_frag_assister);
				
				if(g_AssistPoints > 0)
				{
					g_Player[assist].session[Stats_Points] += g_AssistPoints*assister_count[i];
					g_Player[assist].points += g_AssistPoints*assister_count[i];
					
					char points_plural[32];
					PointsPluralSplitter(assist, g_AssistPoints*assister_count[i], points_plural, sizeof(points_plural));
					
					if(g_Player[assist].bShowAssistMsg)
					{
						CPrintToChat(assist, "%s %T"
						, g_ChatTag
						, "#SMStats_FragEvent_Assisted", assist
						, g_Player[assist].name
						, g_Player[assist].points
						, points_plural
						, g_Player[client].name
						, dummy);
					}
				}
			}
		}
		
		delete assisters;
	}
	
	return true;
}

// will be re-done and optimized.
stock void VictimDied(Transaction txn, const int[] list, const TFClassType[] list_class, int frags)
{
	for(int i = 0; i < frags; i++)
	{
		int victim;
		if(IsValidClient((victim = GetClientOfUserId(list[i]))))
		{
			TFClassType class = list_class[i];
			if(class < TFClass_Scout || class > TFClass_Engineer)
			{
				PrintToServer("%s VictimDied() UserId %i has an invalid class id of %i", core_chattag, list[i], class);
				continue;
			}
			
			int len = 0;
			char query[1024];
			len += Format(query[len], sizeof(query)-len, "update `" ... sql_table_playerlist ... "` set Deaths = Deaths+1");
			
			g_Player[victim].session[Stats_Deaths]++;
			switch(class)
			{
				case TFClass_Scout:
				{
					g_Player[victim].session[Stats_ScoutDeaths]++;
					len += Format(query[len], sizeof(query)-len, ", ScoutDeaths = ScoutDeaths+1");
				}
				case TFClass_Soldier:
				{
					g_Player[victim].session[Stats_SoldierDeaths]++;
					len += Format(query[len], sizeof(query)-len, ", SoldierDeaths = SoldierDeaths+1");
				}
				case TFClass_Pyro:
				{
					g_Player[victim].session[Stats_PyroDeaths]++;
					len += Format(query[len], sizeof(query)-len, ", PyroDeaths = PyroDeaths+1");
				}
				case TFClass_DemoMan:
				{
					g_Player[victim].session[Stats_DemoDeaths]++;
					len += Format(query[len], sizeof(query)-len, ", DemoDeaths = DemoDeaths+1");
				}
				case TFClass_Heavy:
				{
					g_Player[victim].session[Stats_HeavyDeaths]++;
					len += Format(query[len], sizeof(query)-len, ", HeavyDeaths = HeavyDeaths+1");
				}
				case TFClass_Engineer:
				{
					g_Player[victim].session[Stats_EngieDeaths]++;
					len += Format(query[len], sizeof(query)-len, ", EngieDeaths = EngieDeaths+1");
				}
				case TFClass_Medic:
				{
					g_Player[victim].session[Stats_MedicDeaths]++;
					len += Format(query[len], sizeof(query)-len, ", MedicDeaths = MedicDeaths+1");
				}
				case TFClass_Sniper:
				{
					g_Player[victim].session[Stats_SniperDeaths]++;
					len += Format(query[len], sizeof(query)-len, ", SniperDeaths = SniperDeaths+1");
				}
				case TFClass_Spy:
				{
					g_Player[victim].session[Stats_SpyDeaths]++;
					len += Format(query[len], sizeof(query)-len, ", SpyDeaths = SpyDeaths+1");
				}
			}
			
			if(g_DeathPoints >= 1)
			{
				len += Format(query[len], sizeof(query)-len, ", Points = Points-%i", g_DeathPoints);
				
				g_Player[victim].session[Stats_Points] -= g_DeathPoints;
				g_Player[victim].points -= g_DeathPoints;
			}
			
			len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[victim].auth, g_ServerID);
			txn.AddQuery(query, queryId_frag_victim_death);
			
			if(g_DeathPoints >= 1 && g_Player[victim].bShowDeathMsg)
			{
				char points_plural[32];
				PointsPluralSplitter(victim, g_DeathPoints, points_plural, sizeof(points_plural));
				
				CPrintToChat(victim, "%s %T"
				, g_ChatTag
				, "#SMStats_FragEvent_Death", victim
				, g_Player[victim].name
				, g_Player[victim].points
				, points_plural);
			}
		}
	}
}

/**
 *	Returns if MvM (Mann-Vs-Machine) mode is active.
 */
bool TF2_IsMvMGameMode()
{
	return view_as<bool>(GameRules_GetProp("m_bPlayingMannVsMachine"));
}

/**
 *	Returns if the entity is a building.
 *
 *	@param	entity	The building entity index.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool TF2_IsEntityBuilding(int building)
{
	return !IsValidEntity(building) ? false : HasEntProp(building, Prop_Send, "m_bBuilding");
}

/**
 *	Returns the buildings upgrade level.
 *
 *	@param	entity	The building entity index.
 *	@error	If the entity is invalid, this returns -1.
 */
stock int TF2_GetBuildingLevel(int building)
{
	return !IsValidEntity(building) ? -1 : GetEntProp(building, Prop_Send, "m_iUpgradeLevel");
}

/**
 *	Returns the TFBuilding type.
 *
 *	@param	entity	The building to get TFBuilding type from.
 *
 *	@error	If the building is invalid, this returns TFBuilding_Invalid.
 */
stock TFBuilding TF2_GetBuildingType(int entity)
{
	char classname[64];
	GetEntityClassname(entity, classname, sizeof(classname));
	
	if(StrEqual(classname, "obj_dispenser"))
	{
		return TFBuilding_Dispenser;
	}
	else if(StrEqual(classname, "obj_sentrygun"))
	{
		return TFBuilding_Sentrygun;
	}
	else if(StrEqual(classname, "obj_teleporter"))
	{
		switch(TF2_GetObjectMode(entity))
		{
			case TFObjectMode_Entrance: return TFBuilding_Teleporter_Entrance;
			case TFObjectMode_Exit: return TFBuilding_Teleporter_Exit;
		}
	}
	else if(StrEqual(classname, "obj_minisentry"))
	{
		return TFBuilding_MiniSentry;
	}
	else if(StrContains(classname, "sapper", false) != -1)
	{
		return TFBuilding_Sapper;
	}
	
	return TFBuilding_Invalid;
}

//

stock void GetMultipleObjects(int client, TFBuilding[] list, int objects, char[] dummy, int maxlen)
{
	TFBuilding obj_prev;
	int obj_count[6];
	for(int i = 0; i < objects; i++)
	{
		TFBuilding obj = list[i];
		
		if(obj != obj_prev)
		{
			obj_count[obj]++;
		}
		else
		{
			obj_count[obj_prev]++;
		}
		
		obj_prev = obj;
	}
	
	int obj_types;
	for(int i = 0; i < objects; i++)
	{
		TFBuilding obj = list[i];
		if(obj_count[obj] > 0)
		{
			obj_types++;
		}
	}
	
	switch(obj_types)
	{
		case 1:
		{
			TFBuilding obj = list[0];
			GetObjectName(client, obj, dummy, maxlen);
			
			if(objects > 1)
			{
				Format(dummy, maxlen, "%s%T", dummy, "#MStats_Counter", client, objects);
			}
		}
		
		case 2:
		{
			char name1[64], name2[64];
			GetObjectName(client, list[0], name1, sizeof(name1));
			GetObjectName(client, list[1], name2, sizeof(name2));
			
			Format(dummy, maxlen, "%s%T%s%T"
			, name1
			, "#SMStats_And", client
			, name2
			, "#SMStats_Counter", client, objects);
		}
		
		case 3:
		{
			char name1[64], name2[64], name3[64];
			GetObjectName(client, list[0], name1, sizeof(name1));
			GetObjectName(client, list[1], name2, sizeof(name2));
			GetObjectName(client, list[2], name3, sizeof(name3));
			
			TFBuilding obj = list[objects-1];
			char object_name[64];
			GetObjectName(client, obj, object_name, sizeof(object_name));
			Format(dummy, maxlen, "%s%T%s%T%s%T"
			, name1
			, "#SMStats_Comma", client
			, name2
			, "#SMStats_And", client
			, name3
			, "#SMStats_Counter", client, objects);
		}
		
		default:
		{
			Format(dummy, maxlen, "%T %T", "#SMStats_MultipleObjects", client, "#SMStats_Counter", client, objects);
		}
	}
}

stock void GetObjectName(int client, TFBuilding obj, char[] name, int maxlen)
{
	Format(name, maxlen, "#SMStats_Object_Type%i", obj);
	Format(name, maxlen, "%T{default}", name, client);
}

stock ArrayList GetHealers(int client)
{
	ArrayList array;
	int player;
	while((player = FindEntityByClassname(player, "player")) != -1)
	{
		if(IsValidClient(player, !bAllowBots ? true : false))
		{
			int medigun = GetPlayerWeaponSlot(player, 1);
			if(IsValidEdict(medigun))
			{
				char classname[64];
				GetEntityClassname(medigun, classname, sizeof(classname));
				if(StrContains(classname, "tf_weapon_medigun", false) != -1)
				{
					if(GetEntProp(medigun, Prop_Send, "m_bHealing"))
					{
						if(GetEntPropEnt(medigun, Prop_Send, "m_hHealingTarget") == client)
						{
							if(array == null)
							{
								array = new ArrayList();
							}
							array.Push(GetClientUserId(player));
						}
					}
				}
			}
		}
	}
	
	return array;
}

//