enum
{
	PassBall_GrabbingNeutralBall = 0,
	PassBall_ScoringBall = 1,
	PassBall_DroppingBall = 2,
	PassBall_CatchingBall = 3,
	PassBall_StealingBall = 4,
	PassBall_BlockingBall = 5,
	
	Boss_HHH = 0,
	Boss_Monoculus = 1,
	Boss_Merasmus = 2,
	Boss_Skeleton = 3,
	
	CTF_PickedUp = 0,
	CTF_Captured = 1,
	CTF_Defended = 2,
	CTF_Dropped = 3,
	
	MvM_DestroyTank = 0,
	MvM_FragSentryBuster = 1,
	MvM_FragRobot = 2,
	MvM_ResetBomb = 3,
}

/* ========== Convars ========= */
/* other */
ConVar g_TeleFrag;
ConVar g_SuicideAssisted;
ConVar g_Collateral;
ConVar g_PumpkinBomb;

/* capture point */
ConVar g_PointCaptured;
ConVar g_PointBlocked;

/* capture-the-flag */
ConVar g_FlagEvent[5];
ConVar g_FlagEvent_Stolen;

/* objects / buildings */
ConVar g_Object_Placed[6];
ConVar g_Object_Destroyed[6];

/* player */
ConVar g_Ubercharged;
ConVar g_Ubercharged_Spy;

ConVar g_Teleported;

ConVar g_SandvichStolen;

ConVar g_Jarated;
ConVar g_Milked;
ConVar g_GasPassed;

ConVar g_Extinguished;

ConVar g_Stunned;

/* pass ball mode */
ConVar g_PassBall[6];

/* bosses */
ConVar g_BossFragged[4];
ConVar g_BossStunned[4];

/* MvM related */
ConVar g_MvM[4];

//

/* same weapon, but different item definition indexes. */
int g_tf_weapon_knife[] = {
	194,  //Same as default Knife, used for australium, strange, renamed & skinned versions.
	665, //Festive Knife.
	15094, //Skinned Knife. Blue Mew.
	15095, //Skinned Knife. Brain Candy.
	15096, //Skinned Knife. Stabbed To Hell.
	15118, //Skinned Knife. Dressed To Kill.
	15119, //Skinned Knife. Top Shelf.
	15143, //Skinned Knife. Blitzkrieg.
	15144, //Skinned Knife. Airwolf.
}
, g_tf_weapon_wrench[] = {
	197, //The Wrench, used for australium, strange, renamed & skinned versions.
	662, //Festive Wrench.
	795, //The Wrench. Silver Botkiller Mk. I.
	804, //The Wrench. Gold Botkiller Mk. I.
	884, //The Wrench. Rust Botkiller Mk. I.
	893, //The Wrench. Blood Botkiller Mk. I.
	902, //The Wrench. Carbonado Botkiller Mk. I.
	911, //The Wrench. Diamond Botkiller Mk. I.
	960, //The Wrench. Silver Botkiller Mk. II.
	969, //The Wrench. Gold Botkiller Mk. II.
	15073, //Skinned Wrench. Nutcracker.
	15074, //Skinned Wrench. Autumn.
	15075, //Skinned Wrench. Boneyard.
	15114, //Skinned Wrench. Torqued To Hell.
	15139, //Skinned Wrench. Dressed To Kill.
	15140, //Skinned Wrench. Top Shelf.
	15156, //Skinned Wrench. Airwolf.
}
, g_tf_weapon_shotgun[] = {
	10,	//The Shotgun, Class: Soldier.
	11,	//The Shotgun, Class: Heavy.
	12, //The Shotgun, Class: Pyro.
	199, //The Shotgun, used for strange, renamed & skinned versions.
	1141, //Festive Shotgun.
	15003, //Skinned Shotgun. Backwoods Boomstick.
	15016, //Skinned Shotgun. Rustic Ruiner.
	15044, //Skinned Shotgun. Civic Duty.
	15047, //Skinned Shotgun. Lightning Rod.
	15085, //Skinned Shotgun. Autumn.
	15109, //Skinned Shotgun. Flower Power.
	15132, //Skinned Shotgun. Coffin Nail.
	15133, //Skinned Shotgun. Dressed To Kill.
	15152, //Skinned Shotgun. Red Bear.
	19011, //TF2Items Give Weapon: Beta Pocket Shotgun.
}
, g_tf_weapon_scattergun[] = {
	200,  //The Scattergun, used for australium, strange, renamed & skinned versions.
	669, //Festive Scattergun.
	799, //The Scattergun. Silver Botkiller Mk. I.
	808, //The Scattergun. Gold Botkiller Mk. I.
	888, //The Scattergun. Rust Botkiller Mk. I.
	897, //The Scattergun. Blood Botkiller Mk. I.
	906, //The Scattergun. Carbonado Botkiller Mk. I.
	915, //The Scattergun. Diamond Botkiller Mk. I.
	964, //The Scattergun. Silver Botkiller Mk. II.
	973, //The Scattergun. Gold Botkiller Mk. II.
	15002, //Skinned Scattergun. Night Terror.
	15015, //Skinned Scattergun. Tartan Torpedo.
	15021, //Skinned Scattergun. Country Crusher.
	15036, //Skinned Scattergun. Spruce Deuce.
	15053, //Skinned Scattergun. Current Event.
	15065, //Skinned Scattergun. Macabre Web.
	15069, //Skinned Scattergun. Nutcracker.
	15106, //Skinned Scattergun. Bluw Mew.
	15107, //Skinned Scattergun. Flower Power.
	15108, //Skinned Scattergun. Shot to Hell.
	15131, //Skinned Scattergun. Coffin Nail.
	15151, //Skinned Scattergun. Killer Bee.
	15157, //Skinned Scattergun. Corsair.
}
, g_tf_weapon_sniperrifle[] = {
	201, //The Sniper Rifle, used for australium, strange, renamed & skinned versions.
	664, //Festive Sniper Rifle.
	792, //The Sniper Rifle. Silver Botkiller Mk. I.
	801, //The Sniper Rifle. Gold Botkiller Mk. I.
	881, //The Sniper Rifle. Rust Botkiller Mk. I.
	899, //The Sniper Rifle. Carbonado Botkiller Mk. I.
	890, //The Sniper Rifle. Blood Botkiller Mk. I.
	908, //The Sniper Rifle. Diamond Botkiller Mk. I.
	957, //The Sniper Rifle. Silver Botkiller Mk. II.
	966, //The Sniper Rifle. Gold Botkiller Mk. II.
	15007, //Skinned Sniper Rifle. Purple Range.
	15023, //Skinned Sniper Rifle. Shot In The Dark.
	15033, //Skinned Sniper Rifle. Bogtrotter.
	15059, //Skinned Sniper Rifle. Thunderbolt.
	15070, //Skinned Sniper Rifle. Pumpkin Patch.
	15071, //Skinned Sniper Rifle. Boneyard.
	15072, //Skinned Sniper Rifle. Wildwood.
	15111, //Skinned Sniper Rifle. Balloonicorn.
	15112, //Skinned Sniper Rifle. Rainbow.
	15135, //Skinned Sniper Rifle. Coffin Nail.
	15136, //Skinned Sniper Rifle. Dressed To Kill.
	15154, //Skinned Sniper Rifle. Airwolf.
	19015, //TF2Items Give Weapon: Beta Sniper Rifle 1.
}
, g_tf_weapon_minigun[] = {
	202, //The Minigun, used for australium, strange, renamed & skinned versions.
	654, //Festive Minigun.
	793, //The Minigun. Silver Botkiller Mk. I.
	802, //The Minigun. Gold Botkiller Mk. I.
	850, //The Deflector. (MvM Minigun used by Giant Deflector Heavies.)
	882, //The Minigun. Rust Botkiller Mk. I.
	891, //The Minigun.	Blood Botkiller Mk. I.
	900, //The Minigun. Carbonado Botkiller Mk. I.
	909, //The Minigun. Diamond Botkiller Mk. I.
	958, //The Minigun. Silver Botkiller Mk. II.
	967, //The Minigun. Gold Botkiller Mk. II.
	15004, //Skinned Minigun. King of The Jungle.
	15020, //Skinned Minigun. Iron Wood.
	15026, //Skinned Minigun. Antique Annihilator.
	15031, //Skinned Minigun. War Room.
	15040, //Skinned Minigun. Citizen Pain.
	15055, //Skinned Minigun. Brick House.
	15086, //Skinned Minigun. Macabre Web.
	15087, //Skinned Minigun. Pumpkin Patch.
	15088, //Skinned Minigun. Nutcracker.
	15098, //Skinned Minigun. Brain Candy.
	15099, //Skinned Minigun. Mister Cuddles.
	15123, //Skinned Minigun. Coffin Nail.
	15124, //Skinned Minigun. Dressed To Kill.
	15125, //Skinned Minigun. Top Shelf.
	15147, //Skinned Minigun. Butcher Bird.
}
, g_tf_weapon_smg[] = {
	203,  //The SMG, used for australium, strange, renamed & skinned versions.
	1149, //Festive SMG.
	15001, //Skinned SMG. Woodsy Widowmaker.
	15022, //Skinned SMG. Plaid Potshotter.
	15032, //Skinned SMG. Treadplate Tormenter.
	15037, //Skinned SMG. Team Sprayer.
	15058, //Skinned SMG. Low Profile.
	15076, //Skinned SMG. Wildwood.
	15110, //Skinned SMG. Blue Mew.
	15134, //Skinned SMG. High Roller's.
	15153, //Skinned SMG. Blitzkrieg.
}
, g_tf_weapon_rocketlauncher[] = {
	205, //The Rocket Launcher, used for australium, strange, renamed & skinned versions.
	237, //Rocket Jumper.
	658, //Festive Rocket Launcher.
	800, //The Rocket Launcher. Silver Botkiller Mk. I.
	809, //The Rocket Launcher. Gold Botkiller Mk. I.
	889, //The Rocket Launcher. Rust Botkiller Mk. I.
	898, //The Rocket Launcher. Blood Botkiller Mk. I.
	907, //The Rocket Launcher. Carbonado Botkiller Mk. I.
	916, //The Rocket Launcher. Diamond Botkiller Mk. I.
	965, //The Rocket Launcher. Silver Botkiller Mk. II.
	974, //The Rocket Launcher. Gold Botkiller Mk. II.
	15006, //Skinned Rocket Launcher. Woodland Warrior.
	15014, //Skinned Rocket Launcher. Sand Cannon.
	15028, //Skinned Rocket Launcher. American Pastoral.
	15043, //Skinned Rocket Launcher. Smalltown Bringdown.
	15052, //Skinned Rocket Launcher. Shell Shocker.
	15057, //Skinned Rocket Launcher. Aqua Marine.
	15081, //Skinned Rocket Launcher. Autumn.
	15104, //Skinned Rocket Launcher. Blue Mew.
	15105, //Skinned Rocket Launcher. Brain Candy.
	15129, //Skinned Rocket Launcher. Coffin Nail.
	15130, //Skinned Rocket Launcher. High Roller's.
	15050, //Skinned Rocket Launcher. Warhawk.
	19010, //TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 1.
	19016, //TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 2.
	19017, //TF2Items Give Weapon: Beta Pocket Rocket Launcher Variant 3.
}
, g_tf_weapon_grenadelauncher[] = {
	206, //The Grenade Launcher, used for australium, strange, renamed & skinned versions.
	1007, //Festive Grenade Launcher.
	15077, //Skinned Grenade Launcher. Autumn.
	15079, //Skinned Grenade Launcher. Macabre Web.
	15091, //Skinned Grenade Launcher. Rainbow.
	15092, //Skinned Grenade Launcher. Sweet Dreams.
	15116, //Skinned Grenade Launcher. Coffin Nail.
	15117, //Skinned Grenade Launcher. Top Shelf.
	15142, //Skinned Grenade Launcher. Warhawk.
	15158, //Skinned Grenade Launcher. Butcher Bird.
}
, g_tf_weapon_stickybomblauncher[] = {
	207, //The Stickybomb Launcher, used for australium, strange, renamed & skinned versions.
	265, //Sticky Jumper.
	661, //Festive StickyBomb Launcher.
	797, //The Stickybomb Launcher.	Silver Botkiller Mk. I.
	806, //The Stickybomb Launcher. Gold Botkiller Mk. I.
	886, //The Stickybomb Launcher.	Rust Botkiller Mk. I.
	895, //The Stickybomb Launcher.	Blood Botkiller Mk. I.
	904, //The Stickybomb Launcher.	Carbonado Botkiller Mk. I.
	913, //The Stickybomb Launcher.	Diamond Botkiller Mk. I.
	962, //The Stickybomb Launcher.	Silver Botkiller Mk. II.
	971, //The Stickybomb Launcher. Gold Botkiller Mk. II.
	15009, //Skinned Stickybomb Launcher. Sudden Flurry.
	15012, //Skinned Stickybomb Launcher. Carpet Bomber.
	15024, //Skinned Grenade Launcher. Blasted Bombardier.
	15038, //Skinned Grenade Launcher. Rooftop Wrangler.
	15045, //Skinned Stickybomb Launcher. Liquid Asset.
	15048, //Skinned Stickybomb Launcher. Pink Elephant.
	15082, //Skinned Stickybomb Launcher. Autumn.
	15083, //Skinned Stickybomb Launcher. Pumpkin Patch.
	15084, //Skinned Stickybomb Launcher. Macabre Web.
	15113, //Skinned Stickybomb Launcher. Sweet Dreams.
	15137, //Skinned Stickybomb Launcher. Coffin Nail.
	15138, //Skinned Stickybomb Launcher. Dressed To Kill.
	15155, //Skinned Stickybomb Launcher. Blitzkrieg.
}
, g_tf_weapon_flamethrower[] = {
	208, //The Flamethrower, used for australium, strange, renamed & skinned versions.
	659, //Festive Flamethrower.
	798, //The Flame Thrower. Silver Botkiller Mk. I.
	807, //The Flame Thrower. Gold Botkiller Mk. I.
	887, //The Flame Thrower. Rust Botkiller Mk. I.
	896, //The Flame Thrower. Blood Botkiller Mk. I.
	905, //The Flame Thrower. Carbonado Botkiller Mk. I.
	914, //The Flame Thrower. Diamond Botkiller Mk. I.
	963, //The Flame Thrower. Silver Botkiller Mk. II.
	972, //The Flame Thrower. Gold Botkiller Mk. II.
	15005, //Skinned Flame Thrower. Forest Fire.
	15017, //Skinned Flame Thrower. Barn Burner.
	15030, //Skinned Flame Thrower. Bovine Blazemaker.
	15034, //Skinned Flame Thrower. Earth, Sky and Fire.
	15049, //Skinned Flame Thrower. Flash Fryer.
	15054, //Skinned Flame Thrower. Turbine Torcher.
	15066, //Skinned Flame Thrower. Autumn.
	15067, //Skinned Flame Thrower. Pumpkin Patch.
	15068, //Skinned Flame Thrower. Nutcracker.
	15089, //Skinned Flame Thrower. Balloonicorn.
	15090, //Skinned Flame Thrower. Rainbow.
	15115, //Skinned Flame Thrower. Coffin Nail.
	15141, //Skinned Flame Thrower. Warhawk.
}
, g_tf_weapon_pistol[] = {
	23, //The Pistol, Class: Engineer.
	209, //The Pistol, used for strange, renamed & skinned versions.
	15013, //Skinned Pistol. Red Rock Roscoe.
	15018, //Skinned Pistol. Homemade Heater.
	15035, //Skinned Pistol. Hickory Holepuncher.
	15041, //Skinned Pistol. Local Hero.
	15046, //Skinned Pistol. Black Dahlia.
	15056, //Skinned Pistol. Sandstone Special.
	15060, //Skinned Pistol. Macabre Web.
	15061, //Skinned Pistol. Nutcracker.
	15100, //Skinned Pistol. Blue Mew.
	15101, //Skinned Pistol. Brain Candy.
	15102, //Skinned Pistol. Shot To Hell.
	15126, //Skinned Pistol. Dressed To Kill.
	15148, //Skinned Pistol. Blitzkrieg.
}
, g_tf_weapon_revolver[] = {
	210, //The Revolver, used for strange, renamed & skinned versions.
	1142, //Festive Revolver.
	15011, //Skinned Revolver. Psychedeic Slugger.
	15027, //Skinned Revolver. Old Country.
	15042, //Skinned Revolver. Mayor.
	15051, //Skinned Revolver. Dead Reckoner.
	15062, //Skinned Revolver. Boneyard.
	15063, //Skinned Revolver. Wildwood.
	15064, //Skinned Revolver. Macabre Web.
	15103, //Skinned Revolver. Flower Power.
	15127, //Skinned Revolver. Top Shelf.
	15128, //Skinned Revolver. Top Shelf.
	15149, //Skinned Revolver. Blitzkrieg.
}
;

//

enum struct FragEventInfo
{
	int timestamp;
	int userid;
	int assister;
	int inflictor;
	int crit_type;
	TFClassType class;
	TFClassType class_attacker;
	ArrayList healers;
	
	int penetrated;
	
	bool suicide;
	bool suicide_assisted;
	bool headshot;
	bool backstab;
	bool noscope;
	bool bleedfrag;
	bool dominated;
	bool dominated_assister;
	bool revenge;
	bool revenge_assister;
	bool gibfrag;
	bool collateral;
	bool deflectfrag;
	bool tauntfrag;
	bool pumpkinbombfrag;
	bool telefrag;
	bool midair;
	bool airshot;
	
	char classname[64];
	int itemdef;
}

//

float g_Time_ObjectPlaced = 5.0;
float g_Time_ObjectDestroyed = 5.0;
float g_Time_Ubercharged = 5.0;
float g_Time_UsedTeleporter = 5.0;
float g_Time_PlayerUsedTeleporter = 5.0;
float g_Time_StolenSandvich = 5.0;
float g_Time_Stunned = 5.0;
float g_Time_PassBallEvent = 5.0;
float g_Time_PlayerJarated = 5.0;
float g_Time_PlayerMilked = 5.0;
float g_Time_PlayerGasPassed = 5.0;
float g_Time_ExtEvent = 5.0;

//

void PrepareGame()
{
	/* other */
	g_TeleFrag = CreateConVar("sm_stats_points_telefrag", "5", "SM Stats: TF2 - Points earned when Telefragging an opponent.", _, true);
	g_SuicideAssisted = CreateConVar("sm_stats_points_assisted_suicide", "1", "SM Stats: TF2 - Points earned when assisted in an opponents suicide.", _, true);
	g_Collateral = CreateConVar("sm_stats_points_collateral", "2", "SM Stats: TF2 - Points earned when doing a collateral frag. Paired with frag event.", _, true);
	g_PumpkinBomb = CreateConVar("sm_stats_points_pumpkinbomb", "5", "SM Stats: TF2 - Points earned when fragging using Pumpkin Bomb.", _, true);
	
	/* capture point */
	g_PointCaptured = CreateConVar("sm_stats_points_point_captured", "5", "SM Stats: TF2 - Points earned when capturing a capture point.", _, true);
	g_PointBlocked = CreateConVar("sm_stats_points_point_blocked", "5", "SM Stats: TF2 - Points earned when blocking a capture point from being captured.", _, true);
	
	/* capture-the-flag */
	g_FlagEvent[CTF_PickedUp] = CreateConVar("sm_stats_points_flag_pickedup", "1", "SM Stats: TF2 - Points earned when picking up the flag.", _, true);
	g_FlagEvent[CTF_Captured] = CreateConVar("sm_stats_points_flag_captured", "2", "SM Stats: TF2 - Points earned when capturing the flag.", _, true);
	g_FlagEvent[CTF_Defended] = CreateConVar("sm_stats_points_flag_defended", "1", "SM Stats: TF2 - Points earned when defending the flag.", _, true);
	g_FlagEvent[CTF_Dropped] = CreateConVar("sm_stats_points_flag_dropped", "2", "SM Stats: TF2 - Points lost when dropping the flag.", _, true);
	g_FlagEvent_Stolen = CreateConVar("sm_stats_points_flag_stolen", "2", "SM Stats: TF2 - Points earned when stealing the flag. Paired with picking up.");
	
	/* objects / buildings */
	g_Object_Placed[TFBuilding_Sentrygun] = CreateConVar("sm_stats_points_object_sentrygun_built", "2", "SM Stats: TF2 - Points earned when a Sentrygun was built.", _, true);
	g_Object_Placed[TFBuilding_Dispenser] = CreateConVar("sm_stats_points_object_dispenser_built", "2", "SM Stats: TF2 - Points earned when a Dispenser was built.", _, true);
	g_Object_Placed[TFBuilding_Teleporter_Entrance] = CreateConVar("sm_stats_points_object_teleporter_entrance_built", "2", "SM Stats: TF2 - Points earned when Teleporter Entrance was built.", _, true);
	g_Object_Placed[TFBuilding_Teleporter_Exit] = CreateConVar("sm_stats_points_object_teleporter_exit_built", "2", "SM Stats: TF2 - Points earned when Teleporter Exit was built.", _, true);
	g_Object_Placed[TFBuilding_MiniSentry] = CreateConVar("sm_stats_points_object_minisentry_built", "2", "SM Stats: TF2 - Points earned when a Mini Sentrygun was built.", _, true);
	g_Object_Placed[TFBuilding_Sapper] = CreateConVar("sm_stats_points_sapper_built", "2", "SM Stats: TF2 - Points earned when a Sapper was placed.", _, true);
	
	g_Object_Destroyed[TFBuilding_Sentrygun] = CreateConVar("sm_stats_points_object_sentrygun_destroyed", "2", "SM Stats: TF2 - Points earned when a Sentrygun was destroyed.", _, true);
	g_Object_Destroyed[TFBuilding_Dispenser] = CreateConVar("sm_stats_points_object_dispenser_destroyed", "2", "SM Stats: TF2 - Points earned when a Dispenser was destroyed.", _, true);
	g_Object_Destroyed[TFBuilding_Teleporter_Entrance] = CreateConVar("sm_stats_points_object_teleporter_entrance_destroyed", "2", "SM Stats: TF2 - Points earned when Teleporter Entrance was destroyed.", _, true);
	g_Object_Destroyed[TFBuilding_Teleporter_Exit] = CreateConVar("sm_stats_points_object_teleporter_exit_destroyed", "2", "SM Stats: TF2 - Points earned when Teleporter Exit was destroyed.", _, true);
	g_Object_Destroyed[TFBuilding_MiniSentry] = CreateConVar("sm_stats_points_object_minisentry_destroyed", "2", "SM Stats: TF2 - Points earned when a Mini Sentrygun was destroyed.", _, true);
	g_Object_Destroyed[TFBuilding_Sapper] = CreateConVar("sm_stats_points_sapper_destroyed", "2", "SM Stats: TF2 - Points earned when a Sapper was destroyed.", _, true);
	
	/* player */
	g_Ubercharged = CreateConVar("sm_stats_points_ubercharged", "5", "SM Stats: TF2 - Points earned when ubercharging.", _, true);
	g_Ubercharged_Spy = CreateConVar("sm_stats_points_ubercharged_count_spy", "5", "SM Stats: TF2 - Points earned when ubercharging.", _, true);
	
	g_Teleported = CreateConVar("sm_stats_points_teleported", "2", "SM Stats: TF2 - Points the teleporter builder earns when teleporter was used.", _, true);
	
	g_SandvichStolen = CreateConVar("sm_stats_points_sandvich_stolen", "2", "SM Stats: TF2 - Points earned when stealing a sandvich.", _, true);
	
	g_Jarated = CreateConVar("sm_stats_points_jar_jarated", "2", "SM Stats: TF2 - Points earned when coating opponents with piss.", _, true);
	g_Milked = CreateConVar("sm_stats_points_jar_milked", "2", "SM Stats: TF2 - Points earned when coating opponents with milk.", _, true);
	g_GasPassed = CreateConVar("sm_stats_points_jar_gaspassed", "2", "SM Stats: TF2 - Points earned when coating opponents with flammable gas.", _, true);
	
	g_Extinguished = CreateConVar("sm_stats_points_extinguished", "3", "SM Stats: TF2 - Points earned when extinguishing a teammate.", _, true);
	
	g_Stunned = CreateConVar("sm_stats_points_stunned", "1", "SM Stats: TF2 - Points earned when stunning an opponent.", _, true);
	
	/* pass ball mode */
	g_PassBall[PassBall_GrabbingNeutralBall] = CreateConVar("sm_stats_points_pass_get", "1", "SM Stats: TF2 - Points earned when grabbing the neutral ball.", _, true);
	g_PassBall[PassBall_ScoringBall] = CreateConVar("sm_stats_points_pass_score", "2", "SM Stats: TF2 - Points earned when scoring the ball.", _, true);
	g_PassBall[PassBall_DroppingBall] = CreateConVar("sm_stats_points_pass_dropball", "1" , "SM Stats: TF2 - Points taken when dropping the ball", _, true);
	g_PassBall[PassBall_CatchingBall] = CreateConVar("sm_stats_points_pass_caught", "1", "SM Stats: TF2 - Points earned when catching the ball.", _, true);
	g_PassBall[PassBall_StealingBall] = CreateConVar("sm_stats_points_pass_steal", "2", "SM Stats: TF2 - Points earned when stealing the ball.", _, true);
	g_PassBall[PassBall_BlockingBall] = CreateConVar("sm_stats_points_pass_block", "1", "SM Stats: TF2 - Points earned when blocking the ball.", _, true);
	
	/* bosses */
	g_BossFragged[Boss_HHH] = CreateConVar("sm_stats_points_boss_hhh", "5", "SM Stats: TF2 - Points earned when fragging Headless Horseless Horsemann.", _, true);
	g_BossFragged[Boss_Monoculus] = CreateConVar("sm_stats_points_boss_monoculus", "5", "SM Stats: TF2 - Points earned when fragging Monoculus.", _, true);
	g_BossFragged[Boss_Merasmus] = CreateConVar("sm_stats_points_boss_merasmus", "5", "SM Stats: TF2 - Points earned when fragging Merasmus.", _, true);
	g_BossFragged[Boss_Skeleton] = CreateConVar("sm_stats_points_boss_skeleton", "5", "SM Stats: TF2 - Points earned when fragging Skeleton.", _, true);
	
	g_BossStunned[Boss_Monoculus] = CreateConVar("sm_stats_points_boss_monoculus_stunned", "5", "SM Stats: TF2 - Points earned when stunning Monoculus.", _, true);
	g_BossStunned[Boss_Merasmus] = CreateConVar("sm_stats_points_boss_merasmus_stunned", "5", "SM Stats: TF2 - Points earned when stunning Merasmus.", _, true);
	
	/* MvM related */
	g_MvM[MvM_DestroyTank] = CreateConVar("sm_stats_points_mvm_destroytank", "5", "SM Stats: TF2 - Points the RED team earns when tank is destroyed.", _, true);
	g_MvM[MvM_FragSentryBuster] = CreateConVar("sm_stats_points_mvm_fragsentrybuster", "5", "SM Stats: TF2 - Points earned when fragging the Sentry Buster.", _, true);
	g_MvM[MvM_FragRobot] = CreateConVar("sm_stats_points_mvm_fragrobot", "1", "SM Stats: TF2 - Points earned when fragging a robot.", _, true);
	g_MvM[MvM_ResetBomb] = CreateConVar("sm_stats_points_mvm_resetbomb", "5", "SM Stats: TF2 - Points earned when resetting the bomb.", _, true);
	
	
	/* ========================================================================================== */
	
	/* weapons */
	array_InitializeWeapons();
	array_AddWeapon(0, "sm_stats_points_weapon_bat", 10, "Bat");
	array_AddWeapon(1, "sm_stats_points_weapon_bottle", 10, "Bottle");
	array_AddWeapon(2, "sm_stats_points_weapon_fireaxe", 10, "Fire Axe");
	array_AddWeapon(3, "sm_stats_points_weapon_kukri", 10, "Kukri");
	array_AddWeapon(4, "sm_stats_points_weapon_knife", 10, "Knife");
	array_AddWeapon(5, "sm_stats_points_weapon_fists", 10, "Fists");
	array_AddWeapon(6, "sm_stats_points_weapon_shovel", 10, "Shovel");
	array_AddWeapon(7, "sm_stats_points_weapon_wrench", 10, "Wrench");
	array_AddWeapon(8, "sm_stats_points_weapon_bonesaw", 10, "Bonesaw");
	array_AddWeapon(9, "sm_stats_points_weapon_shotgun", 10, "Shotgun");
	array_AddWeapon(13, "sm_stats_points_weapon_scattergun", 10, "Scattergun");
	array_AddWeapon(14, "sm_stats_points_weapon_sniperrifle", 10, "Sniper Rifle");
	array_AddWeapon(15, "sm_stats_points_weapon_minigun", 10, "Minigun");
	array_AddWeapon(16, "sm_stats_points_weapon_smg", 10, "SMG");
	array_AddWeapon(17, "sm_stats_points_weapon_syringegun", 10, "Syringe Gun");
	array_AddWeapon(18, "sm_stats_points_weapon_rocketlauncher", 10, "Rocket Launcher");
	array_AddWeapon(19, "sm_stats_points_weapon_grenadelauncher", 10, "Grenade Launcher");
	array_AddWeapon(20, "sm_stats_points_weapon_stickybomblauncher", 10, "StickyBomb Launcher");
	array_AddWeapon(21, "sm_stats_points_weapon_flamethrower", 10, "Flamethrower");
	array_AddWeapon(22, "sm_stats_points_weapon_pistol", 10, "Pistol");
	array_AddWeapon(24, "sm_stats_points_weapon_revolver", 10, "Revolver");
	array_AddWeapon(36, "sm_stats_points_weapon_blutsauger", 10, "Blutsauger");
	array_AddWeapon(37, "sm_stats_points_weapon_ubersaw", 10, "Ubersaw");
	array_AddWeapon(38, "sm_stats_points_weapon_axtinguisher", 10, "Axtinguisher");
	array_AddWeapon(39, "sm_stats_points_weapon_flaregun", 10, "Flaregun");
	array_AddWeapon(40, "sm_stats_points_weapon_backburner", 10, "Backburner");
	array_AddWeapon(41, "sm_stats_points_weapon_natascha", 10, "Natascha");
	array_AddWeapon(43, "sm_stats_points_weapon_killerglovesofboxing", 10, "Killer Gloves Of Boxing");
	array_AddWeapon(44, "sm_stats_points_weapon_sandman", 10, "Sandman.");
	array_AddWeapon(45, "sm_stats_points_weapon_forceanature", 10, "Force-A-Nature");
	array_AddWeapon(56, "sm_stats_points_weapon_huntsman", 10, "Huntsman");
	array_AddWeapon(61, "sm_stats_points_weapon_ambassador", 10, "Ambassador");
	array_AddWeapon(127, "sm_stats_points_weapon_directhit", 10, "Direct-Hit");
	array_AddWeapon(128, "sm_stats_points_weapon_equalizer", 10, "Equalizer");
	array_AddWeapon(130, "sm_stats_points_weapon_scottishresistance", 10, "Scottish Resistance.");
	array_AddWeapon(131, "sm_stats_points_weapon_chargentarge", 10, "Charge n' Targe");
	array_AddWeapon(132, "sm_stats_points_weapon_eyelander", 10, "Eyelander");
	array_AddWeapon(140, "sm_stats_points_weapon_wrangler", 10, "Wrangler");
	array_AddWeapon(141, "sm_stats_points_weapon_frontierjustice", 10, "Frontier Justice");
	array_AddWeapon(142, "sm_stats_points_weapon_gunslinger", 10, "Gunslinger");
	array_AddWeapon(153, "sm_stats_points_weapon_homewrecker", 10, "Homewrecker");
	array_AddWeapon(154, "sm_stats_points_weapon_paintrain", 10, "Pain Train");
	array_AddWeapon(155, "sm_stats_points_weapon_southernhospitality", 10, "Southern Hospitality");
	array_AddWeapon(160, "sm_stats_points_weapon_lugermorph", 10, "Lugermorph");
	array_AddWeapon(161, "sm_stats_points_weapon_bigkill", 10, "Big Kill");
	array_AddWeapon(169, "sm_stats_points_weapon_wrench", 10, "Wrench");
	array_AddWeapon(171, "sm_stats_points_weapon_tribalmansshiv", 10, "Tribalman's Shiv");
	array_AddWeapon(172, "sm_stats_points_weapon_scotsmansskullcutter", 10, "Scotsman's Skullcutter");
	array_AddWeapon(173, "sm_stats_points_weapon_vitasaw", 10, "Vita-Saw");
	array_AddSameWeapon(190, 0); //Same as default Bat, used for strange, renamed & skinned versions.
	array_AddSameWeapon(191, 1); //Same as default Bottle, used for strange, renamed & skinned versions.
	array_AddSameWeapon(192, 2); //Same as default Fire Axe, used for strange, renamed & skinned versions.
	array_AddSameWeapon(193, 3); //Same as default Kukri, used for strange, renamed & skinned versions.
	array_AddSameWeapon(195, 5); //Same as default Fists, used for strange & renamed version.
	array_AddSameWeapon(196, 6); //Same as default Shovel, used for strange, renamed & skinned versions.
	array_AddSameWeapon(198, 8); //Same as default Bonesaw, used for strange, renamed & skinned versions.
	array_AddSameWeapon(204, 17); //Same as default Syringe gun, used for strange, renamed & skinned versions.	
	array_AddWeapon(214, "sm_stats_points_weapon_powerjack", 10, "Power Jack");
	array_AddWeapon(215, "sm_stats_points_weapon_degreaser", 10, "Degreaser");
	array_AddWeapon(220, "sm_stats_points_weapon_shortstop", 10, "Shortstop");
	array_AddWeapon(221, "sm_stats_points_weapon_holymackerel", 10, "Holy Mackerel");
	array_AddWeapon(224, "sm_stats_points_weapon_letranger", 10, "L'etranger");
	array_AddWeapon(225, "sm_stats_points_weapon_eternalreward", 10, "Eternal Reward");
	array_AddWeapon(228, "sm_stats_points_weapon_blackbox", 10, "Black Box");
	array_AddWeapon(230, "sm_stats_points_weapon_sydneysleeper", 10, "Sydney Sleeper");
	array_AddWeapon(232, "sm_stats_points_weapon_bushwacka", 10, "Bushwacka");
	array_AddWeapon(239, "sm_stats_points_weapon_goru", 10, "Gloves of Running Urgently");
	array_AddWeapon(264, "sm_stats_points_weapon_fryingpan", 10, "Frying Pan");
	array_AddWeapon(266, "sm_stats_points_weapon_hhhh", 10, "Horseless Headless Horsemann's Headtaker");
	array_AddSameWeapon(294, 160); //Same Lugermorph, different TFQuality type.
	array_AddWeapon(298, "sm_stats_points_weapon_ironcurtain", 10, "Iron Curtain");
	array_AddWeapon(304, "sm_stats_points_weapon_amputator", 10, "Amputator");
	array_AddWeapon(305, "sm_stats_points_weapon_crusaderscrossbow", 10, "Crusader's Crossbow");
	array_AddWeapon(307, "sm_stats_points_weapon_ullapoolcaber", 10, "Ullapool Caber");
	array_AddWeapon(308, "sm_stats_points_weapon_lochnload", 10, "Loch-n-Load");
	array_AddWeapon(310, "sm_stats_points_weapon_warriorsspirit", 10, "Warrior's Spirit");
	array_AddWeapon(312, "sm_stats_points_weapon_brassbeast", 10, "Brass Beast");
	array_AddWeapon(317, "sm_stats_points_weapon_candycane", 10, "Candy Cane");
	array_AddWeapon(325, "sm_stats_points_weapon_bostonbasher", 10, "Boston Basher");
	array_AddWeapon(326, "sm_stats_points_weapon_backscratcher", 10, "Back Scratcher");
	array_AddWeapon(327, "sm_stats_points_weapon_claidheamhmor", 10, "Claidheamh Mór");
	array_AddWeapon(329, "sm_stats_points_weapon_jag", 10, "Jag");
	array_AddWeapon(331, "sm_stats_points_weapon_fistsofsteel", 10, "Fists Of Steel");
	array_AddWeapon(348, "sm_stats_points_weapon_sharpenedvolcanofragment", 10, "Sharpened Volcano Fragment");
	array_AddWeapon(349, "sm_stats_points_weapon_sunonastick", 10, "Sun-On-A-Stick");
	array_AddWeapon(351, "sm_stats_points_weapon_detonator", 10, "Detonator");
	array_AddWeapon(355, "sm_stats_points_weapon_fanowar", 10, "Fan O' War");
	array_AddWeapon(356, "sm_stats_points_weapon_conniverskunai", 10, "Conniver's Kunai");
	array_AddWeapon(357, "sm_stats_points_weapon_halfzatoichi", 10, "Half-Zatoichi");
	array_AddWeapon(401, "sm_stats_points_weapon_shahanshah", 10, "Shahanshah");
	array_AddWeapon(402, "sm_stats_points_weapon_bazaarbargain", 10, "Bazaar Bargain");
	array_AddWeapon(404, "sm_stats_points_weapon_persainpersuader", 10, "Persain Pursuader");
	array_AddWeapon(406, "sm_stats_points_weapon_splendidscreen", 10, "Splendid Screen");
	array_AddWeapon(412, "sm_stats_points_weapon_overdose", 10, "Overdose");
	array_AddWeapon(413, "sm_stats_points_weapon_solemnvow", 10, "Solmen Wov");
	array_AddWeapon(414, "sm_stats_points_weapon_libertylauncher", 10, "Liberty Launcher");
	array_AddWeapon(415, "sm_stats_points_weapon_reserveshooter", 10, "Reserve Shooter");
	array_AddWeapon(416, "sm_stats_points_weapon_marketgardener", 10, "Market Gardener");
	array_AddWeapon(423, "sm_stats_points_weapon_saxxy", 10, "Saxxy");
	array_AddWeapon(424, "sm_stats_points_weapon_tomislav", 10, "Tomislav");
	array_AddWeapon(425, "sm_stats_points_weapon_familybusiness", 10, "Family Business");
	array_AddWeapon(426, "sm_stats_points_weapon_evictionnotice", 10, "Eviction Notice");
	array_AddWeapon(441, "sm_stats_points_weapon_cowmangler5000", 10, "Cow Mangler 5000");
	array_AddWeapon(442, "sm_stats_points_weapon_righteousbison", 10, "Righteous Bison");
	array_AddWeapon(444, "sm_stats_points_weapon_mantreads", 10, "Mantreads");
	array_AddWeapon(447, "sm_stats_points_weapon_disciplinaryaction", 10, "Disciplinary Action");
	array_AddWeapon(448, "sm_stats_points_weapon_sodapopper", 10, "Soda Popper");
	array_AddWeapon(449, "sm_stats_points_weapon_winger", 10, "Winger");
	array_AddWeapon(450, "sm_stats_points_weapon_atomizer", 10, "Atomizer");
	array_AddWeapon(452, "sm_stats_points_weapon_threeruneblade", 10, "Three Rune Blade");
	array_AddWeapon(457, "sm_stats_points_weapon_postalpummeler", 10, "Postal Pummeler");
	array_AddWeapon(460, "sm_stats_points_weapon_enforcer", 10, "Enforcer");
	array_AddWeapon(461, "sm_stats_points_weapon_bigearner", 10, "Big Earner");
	array_AddWeapon(466, "sm_stats_points_weapon_maul", 10, "Maul");
	array_AddWeapon(474, "sm_stats_points_weapon_conscentiousobjector", 10, "Conscentious Objector");
	array_AddWeapon(482, "sm_stats_points_weapon_nessiesnineiron", 10, "Nessie's Nine-Iron");
	array_AddWeapon(513, "sm_stats_points_weapon_original", 10, "Original");
	array_AddWeapon(525, "sm_stats_points_weapon_diamondback", 10, "Diamondback");
	array_AddWeapon(526, "sm_stats_points_weapon_machina", 10, "Machina");
	array_AddWeapon(527, "sm_stats_points_weapon_widowmaker", 10, "Widowmaker");
	array_AddWeapon(528, "sm_stats_points_weapon_shortcircuit", 10, "Short Circuit");
	array_AddWeapon(572, "sm_stats_points_weapon_unarmedcombat", 10, "Unarmed Combat");
	array_AddWeapon(574, "sm_stats_points_weapon_wangaprick", 10, "Wanga Prick");
	array_AddWeapon(587, "sm_stats_points_weapon_apocofists", 10, "Apoco Fists");
	array_AddWeapon(588, "sm_stats_points_weapon_pomson6000", 10, "Pomson 6000");
	array_AddWeapon(589, "sm_stats_points_weapon_eurekaeffect", 10, "Eureka Effect");
	array_AddWeapon(593, "sm_stats_points_weapon_thirddegree", 10, "Third Degree");
	array_AddWeapon(594, "sm_stats_points_weapon_phlogistinator", 10, "Phlogistinator.");
	array_AddWeapon(595, "sm_stats_points_weapon_manmelter", 10, "Man Melter");
	array_AddWeapon(609, "sm_stats_points_weapon_scottishhandshake", 10, "Scottish Handshake");
	array_AddWeapon(638, "sm_stats_points_weapon_sharpdresser", 10, "Sharp Dresser");
	array_AddWeapon(648, "sm_stats_points_weapon_wrapassassin", 10, "Wrap Assassin");
	array_AddWeapon(649, "sm_stats_points_weapon_spycicle", 10, "Spycicle");
	array_AddWeapon(656, "sm_stats_points_weapon_holidaypunch", 10, "Holiday Punch");
	array_AddSameWeapon(660, 0); //Festive Bat.
	array_AddWeapon(727, "sm_stats_points_weapon_blackrose", 10, "Blackrose");
	array_AddWeapon(730, "sm_stats_points_weapon_beggarsbazooka", 10, "Beggar's Bazooka");
	array_AddWeapon(739, "sm_stats_points_weapon_lollichop", 10, "Lollichop");
	array_AddWeapon(740, "sm_stats_points_weapon_scorchshot", 10, "Scorch Shot");
	array_AddWeapon(741, "sm_stats_points_weapon_rainblower", 10, "Rainblower");
	array_AddWeapon(751, "sm_stats_points_weapon_cleanerscarbine", 10, "Cleaner's Carbine");
	array_AddWeapon(752, "sm_stats_points_weapon_hitmansheatmaker", 10, "Hitman's Heatmaker");
	array_AddWeapon(772, "sm_stats_points_weapon_babyfacesblaster", 10, "Baby Face's Blaster");
	array_AddWeapon(773, "sm_stats_points_weapon_prettyboyspocketpistol", 10, "Pretty Boy's Pocket Pistol");
	array_AddWeapon(775, "sm_stats_points_weapon_escapeplan", 10, "Escape Plan");
	array_AddWeapon(811, "sm_stats_points_weapon_huolongheater", 10, "Huo-Long Heater");
	array_AddWeapon(812, "sm_stats_points_weapon_flyingguillotine", 10, "Flying Guillotine");
	array_AddWeapon(813, "sm_stats_points_weapon_neonannihilator", 10, "Neon Annihilator");
	array_AddSameWeapon(832, 811); //Genuine Huo-Long Heater.
	array_AddSameWeapon(833, 812); //Genuine Flying Guillotine.
	array_AddSameWeapon(834, 813); //Genuine Neon Annihilator.
	array_AddWeapon(851, "sm_stats_points_weapon_awperhand", 10, "AWPer Hand");
	array_AddWeapon(880, "sm_stats_points_weapon_freedomstaff", 10, "Freedom Staff");
	array_AddWeapon(939, "sm_stats_points_weapon_batouttahell", 10, "Bat Outta Hell");
	array_AddWeapon(954, "sm_stats_points_weapon_memorymaker",	10, "Memory Maker");
	array_AddWeapon(996, "sm_stats_points_weapon_loosecannon", 10, "Loose Cannon");
	array_AddWeapon(997, "sm_stats_points_weapon_rescueranger", 10, "Rescue Ranger");
	array_AddSameWeapon(999, 221); //Festive Holy Mackerel.
	array_AddSameWeapon(1000, 38); //Festive Axtinguisher.
	array_AddSameWeapon(1003, 37); //Festive Ubersaw.
	array_AddSameWeapon(1004, 141); //Festive Frontier Justice.
	array_AddSameWeapon(1005, 56); //Festive Huntsman.
	array_AddSameWeapon(1006, 61); //Festive Ambassador.
	array_AddWeapon(1013, "sm_stats_points_weapon_hamshank", 10, "Ham Shank");
	array_AddWeapon(1071, "sm_stats_points_weapon_fryingpan_golden", 10, "Golden Frying Pan"); //Golden Frying Pan.
	array_AddSameWeapon(1078, 45); //Festive Force-A-Nature.
	array_AddSameWeapon(1079, 305); //Festive Crusader's Crossbow.
	array_AddSameWeapon(1081, 39); //Festive Flare Gun.
	array_AddSameWeapon(1082, 132); //Festive Eyelander.
	array_AddSameWeapon(1084, 239); //Festive Gloves of Running Urgently.
	array_AddSameWeapon(1085, 228); //Festive Black Box.
	array_AddWeapon(1092, "sm_stats_points_weapon_fortifiedcompound", 10, "Fortified Compound");
	array_AddWeapon(1098, "sm_stats_points_weapon_classic", 10, "Classic");
	array_AddWeapon(1099, "sm_stats_points_weapon_tideturner", 10, "Tide Turner");
	array_AddWeapon(1100, "sm_stats_points_weapon_breadbite", 10, "Bread Bite");
	array_AddWeapon(1103, "sm_stats_points_weapon_backscatter", 10, "Back Scatter");
	array_AddWeapon(1104, "sm_stats_points_weapon_airstrike", 10, "Air Strike");
	array_AddWeapon(1123, "sm_stats_points_weapon_necrosmasher", 10, "Necro Smasher");
	array_AddWeapon(1127, "sm_stats_points_weapon_crossingguard", 10, "Crossing Guard");
	array_AddSameWeapon(1144, 131); //Festive Chargin' Targe.
	array_AddSameWeapon(1146, 40); //Festive Backburner.
	array_AddWeapon(1150, "sm_stats_points_weapon_quickebomblauncher",	10, "Quickiebomb Launcher");
	array_AddWeapon(1151, "sm_stats_points_weapon_ironbomber", 10, "Iron Bomber");
	array_AddWeapon(1153, "sm_stats_points_weapon_panicattack", 10, "Panic Attack");
	array_AddWeapon(1178, "sm_stats_points_weapon_dragonsfury", 10, "Dragon's Fury");
	array_AddWeapon(1179, "sm_stats_points_weapon_thermalthruster", 10, "Thermal Thruster");
	array_AddWeapon(1181, "sm_stats_points_weapon_hothand", 10, "Hot Hand");
	array_AddSameWeapon(1184, 239); //Gloves of Running Urgently. (Used by MvM Robots.)
	
	for(int i = 0; i < sizeof(g_tf_weapon_knife); i++) array_AddSameWeapon(g_tf_weapon_knife[i], 4);
	for(int i = 0; i < sizeof(g_tf_weapon_wrench); i++) array_AddSameWeapon(g_tf_weapon_wrench[i], 7);
	for(int i = 0; i < sizeof(g_tf_weapon_shotgun); i++) array_AddSameWeapon(g_tf_weapon_shotgun[i], 9);
	for(int i = 0; i < sizeof(g_tf_weapon_scattergun); i++) array_AddSameWeapon(g_tf_weapon_scattergun[i], 13);
	for(int i = 0; i < sizeof(g_tf_weapon_sniperrifle); i++) array_AddSameWeapon(g_tf_weapon_sniperrifle[i], 14);
	for(int i = 0; i < sizeof(g_tf_weapon_minigun); i++) array_AddSameWeapon(g_tf_weapon_minigun[i], 15);
	for(int i = 0; i < sizeof(g_tf_weapon_smg); i++) array_AddSameWeapon(g_tf_weapon_smg[i], 16);
	for(int i = 0; i < sizeof(g_tf_weapon_rocketlauncher); i++) array_AddSameWeapon(g_tf_weapon_rocketlauncher[i], 18);
	for(int i = 0; i < sizeof(g_tf_weapon_grenadelauncher); i++) array_AddSameWeapon(g_tf_weapon_grenadelauncher[i], 19);
	for(int i = 0; i < sizeof(g_tf_weapon_stickybomblauncher); i++) array_AddSameWeapon(g_tf_weapon_stickybomblauncher[i], 20);
	for(int i = 0; i < sizeof(g_tf_weapon_flamethrower); i++) array_AddSameWeapon(g_tf_weapon_flamethrower[i], 21);
	for(int i = 0; i < sizeof(g_tf_weapon_pistol); i++) array_AddSameWeapon(g_tf_weapon_pistol[i], 22);
	for(int i = 0; i < sizeof(g_tf_weapon_revolver); i++) array_AddSameWeapon(g_tf_weapon_revolver[i], 24);
	
	array_AddSameWeapon(19012, 129); //TF2Items Give Weapon: Beta Split Equalizer 1.
	array_AddSameWeapon(19013, 129); //TF2Items Give Weapon: Beta Split Equalizer 2.
	
	array_AddWeapon(30474, "sm_stats_points_weapon_nostromonapalmer", 10, "Nostromo Napalmer");
	array_AddWeapon(30665, "sm_stats_points_weapon_shootingstar", 10, "Shooting star");
	array_AddWeapon(30666, "sm_stats_points_weapon_capper", 10, "C.A.P.P.E.R");
	array_AddWeapon(30667, "sm_stats_points_weapon_batsaber", 10, "Batsaber");
	array_AddWeapon(30668, "sm_stats_points_weapon_gigarcounter", 10, "Gigar Counter");
	array_AddWeapon(30758, "sm_stats_points_weapon_prinnymachete", 10, "Prinny Machete");
	
	/* ========================================================================================== */
	
	/* events */
	
	/* core */
	HookEvent("player_death", OnPlayerDeath, EventHookMode_Pre);
	HookEvent("player_team", OnPlayerTeamChange, EventHookMode_Pre);
	
	/* Capture Point */
	HookEvent("teamplay_point_captured", OnCapturedPoint, EventHookMode_Pre);
	HookEvent("teamplay_capture_blocked", OnCaptureBlocked, EventHookMode_Pre);
	
	/* Capture-The-Flag */
	HookEvent("teamplay_flag_event", OnCTFEvent, EventHookMode_Pre);
	
	/* Objects / Buildings */
	HookEvent("player_builtobject", OnObjectPlaced, EventHookMode_Pre);
	HookEvent("object_destroyed", OnObjectDestroyed, EventHookMode_Pre);
	
	/* Player */
	HookEvent("player_invulned", OnPlayerUbercharged, EventHookMode_Pre);
	HookEvent("player_teleported", OnPlayerTeleported, EventHookMode_Pre);
	HookEvent("player_stealsandvich", OnPlayerStealSandvich, EventHookMode_Pre);
	HookEvent("player_stunned", OnPlayerStunned, EventHookMode_Pre);
	
	/* Halloween Bosses */
	HookEvent("halloween_boss_killed", OnHalloweenBossKill, EventHookMode_Pre);
	HookEvent("halloween_skeleton_killed", OnHalloweenSkeletonKingKilled, EventHookMode_Pre);
	HookEvent("eyeball_boss_stunned", OnHalloweenStunned, EventHookMode_Pre);
	HookEvent("merasmus_stunned", OnHalloweenStunned, EventHookMode_Pre);
	
	/* Pass Ball Mode */
	HookEvent("pass_get", OnPassBallEvent, EventHookMode_Pre);
	HookEvent("pass_score", OnPassBallEvent, EventHookMode_Pre);
	HookEvent("pass_free", OnPassBallEvent, EventHookMode_Pre);
	HookEvent("pass_pass_caught", OnPassBallEvent, EventHookMode_Pre);
	
	/* MvM related */
	HookEvent("mvm_tank_destroyed_by_players", MvM_OnTankDestroyed, EventHookMode_Pre);
	HookEvent("player_death", MvM_OnRobotDeath, EventHookMode_Pre); // duplicate of 'player_death' but only is read on MvM gamemode, the other isn't.
	HookEvent("mvm_bomb_reset_by_player", MvM_OnBombResetted, EventHookMode_Pre);
	
	/* User Messages */
	HookUserMessage(GetUserMessageId("PlayerJarated"), OnPlayerCoated);
	HookUserMessage(GetUserMessageId("PlayerExtinguished"), OnPlayerExtinguished);
	HookUserMessage(GetUserMessageId("PlayerIgnited"), OnPlayerIgnited);
	
	/* Rounds */
	
	/* Round started */
	HookEvent("teamplay_round_active", OnRoundStarted, EventHookMode_Pre);
	HookEvent("arena_round_start", OnRoundStarted, EventHookMode_Pre);
	
	/* Round ended */
	HookEvent("teamplay_round_win", OnRoundEnded, EventHookMode_Pre);
	
	AutoExecConfig(true);
	
	RegAdminCmd("sm_asdf1", asdf1Cmd, ADMFLAG_ROOT);
	RegAdminCmd("sm_asdf2", asdf2Cmd, ADMFLAG_ROOT);
}

Action asdf1Cmd(int client, int args)
{
	char penalty_time[128], points_plural[32];
	GetTimeFormat(client, g_PenaltySeconds, penalty_time, sizeof(penalty_time));
	PointsPluralSplitter(client, g_Player[client].points, points_plural, sizeof(points_plural));
	
	CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_Player_Penalty", client
	, g_Player[client].name
	, g_Player[client].position
	, points_plural
	, penalty_time
	, 69);
	return Plugin_Continue;
}

Action asdf2Cmd(int client, int args)
{
	char points_plural[32];
	PointsPluralSplitter(client, g_Player[client].points, points_plural, sizeof(points_plural));
	
	CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_Player_Banned", client
	, g_Player[client].name
	, g_Player[client].position
	, points_plural);
	return Plugin_Continue;
}

/* Called as soon as a player is killed. */
void OnPlayerDeath(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	if(TF2_IsMvMGameMode())
	{
		return;
	}
	
	int death_flags = event.GetInt("death_flags");
	if(death_flags & TF_DEATHFLAG_DEADRINGER)
	{
		return;
	}
	
	int userid = event.GetInt("userid");
	int attacker = event.GetInt("attacker");
	if(userid < 1
	|| attacker < 1)
	{
		return;
	}
	
	if(!sql)
	{
		LogError("%s OnPlayerDeath error: No database connection available.", core_chattag);
		return;
	}
	
	//
	
	int client = GetClientOfUserId(attacker);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	int victim = GetClientOfUserId(userid);
	if(!IsValidClient(victim, !bAllowBots))
	{
		return;
	}
	
	if(client == victim)
	{
		g_Player[client].session[Stats_Suicides]++;
		return;
	}
	
	if(GetClientTeam(client) == GetClientTeam(victim))
	{
		return;
	}
	
	int assister = event.GetInt("assister");
	
	char classname[64];
	event.GetString("weapon_logclassname", classname, sizeof(classname));
	
	if(StrContains(classname, "world") != -1 && assister < 1)
	{
		return;
	}
	
	TFClassType class = TF2_GetPlayerClass(client);
	
	int customkill = event.GetInt("customkill");
	int itemdef = event.GetInt("weapon_def_index");
	bool bleedkill = (customkill == TF_CUSTOM_BLEEDING);
	bool assisted_suicide = false;
	
	/*
	 * The 'weapon_def_index' on the player_death is same as if you're gathering the killers
	 * current active weapon definition index and is NOT gathering the correct definition index at the time of the event.
	 * So we need to manually correct them.
	 * This happens when example throwing out a grenade launcher pill and then switch to your stickybomb launcher or melee, it'll pull the definition index out of that weapon instead.
	 * This also just happens on certain weapons. Just dumb. tf2 team pls fix this bug.
	 *
	 * Lets fix these since when you swap weapons just before the kill on some weapons,
	 * it'll pick definition index out of that weapon instead of the actual weapon that were used.
	 */
	
	/* Boston Basher / Tribalman's Shiv. */
	if(bleedkill)
	{
		itemdef = GetPlayerWeaponSlotItemdef(client, 2);
	}
	/* Rocket Launcher. */
	else if(StrEqual(classname, "tf_projectile_rocket", false))
	{
		itemdef = GetPlayerWeaponSlotItemdef(client, 0);
	}
	/* Grenade Launcher. */
	else if(StrEqual(classname, "tf_projectile_pipe", false))
	{
		itemdef = GetPlayerWeaponSlotItemdef(client, 0);
	}
	/* Stickybomb Launcher. */
	else if(StrEqual(classname, "tf_projectile_pipe_remote", false))
	{
		itemdef = GetPlayerWeaponSlotItemdef(client, 1);
	}
	/* Sandman. */
	else if(StrEqual(classname, "ball", false))
	{
		switch(class)
		{
			// obtain the melee sandman / wrapper's assassin.
			case TFClass_Scout:
			{
				itemdef = GetPlayerWeaponSlotItemdef(client, 2);
			}
			
			// obtain the primary flame thrower.
			case TFClass_Pyro:
			{
				itemdef = GetPlayerWeaponSlotItemdef(client, 0);
			}
		}
	}
	/* Scottish Resistance. */
	else if(StrEqual(classname, "sticky_resistance", false))
	{
		itemdef = GetPlayerWeaponSlotItemdef(client, 1);
	}
	/* Loch-N-Load. */
	else if(StrEqual(classname, "loch_n_load", false))
	{
		itemdef = GetPlayerWeaponSlotItemdef(client, 0)
	}
	/* QuickeBomb Launcher. */
	else if(StrEqual(classname, "quickiebomb_launcher", false))
	{
		itemdef = GetPlayerWeaponSlotItemdef(client, 1);
	}
	/* Iron Bomber. */
	else if(StrEqual(classname, "iron_bomber", false))
	{
		itemdef = GetPlayerWeaponSlotItemdef(client, 0);
	}
	/* Assisted suicide. */
	// this will get re-done.
	else if(StrEqual(classname, "world", false))
	{
		assisted_suicide = (assister > 0);
		itemdef = ITEMDEF_ASSIST_SUICIDE;
	}
	else if(StrEqual(classname, "player", false))
	{
		assisted_suicide = (assister > 0);
		itemdef = ITEMDEF_ASSIST_SUICIDE;
	}
	
	//
	
	if(itemdef != ITEMDEF_ASSIST_SUICIDE)
	{
		if(itemdef > MaxItemDef)
		{
			LogError("%s An error has occured, itemdef %i (classname '%s') seems to be new to the current version (%s) and needs to be updated."
			, core_chattag, itemdef, classname, Version);
			CPrintToChat(client, "%s %T"
			, g_ChatTag, "#SMStats_FragEventError_NewItem", client, itemdef, classname, Version);
			return;
		}
		else if(itemdef < 0)
		{
			LogError("%s An error has occured, itemdef %i (classname '%s') is invalid."
			, core_chattag, itemdef, classname);
			CPrintToChat(client, "%s %T"
			, g_ChatTag, "#SMStats_FragEventError_InvalidItem", client, itemdef, classname);
			return;
		}
		else if(!array_GetWeapon(itemdef))
		{
			LogError("%s An error has occured, itemdef %i (classname '%s') seems to have invalid convar handle! (New item perhaps?)"
			, core_chattag, itemdef, classname);
			CPrintToChat(client, "%s %T"
			, g_ChatTag, "#SMStats_FragEventError_InvalidItemCvar", client, itemdef, classname);
			return;
		}
		else if(array_GetWeapon(itemdef).IntValue < 1)
		{
			return;
		}
	}
	
	//
	
	//int inflictor = event.GetInt("inflictor");
	int playerpenetratedcount = event.GetInt("playerpenetratedcount");
	
	FragEventInfo frag;
	frag.timestamp = GetTime();
	frag.userid = userid;
	frag.assister = assister;
	frag.inflictor = event.GetInt("inflictor");
	frag.crit_type = event.GetInt("crit_type");
	frag.class = TF2_GetPlayerClass(victim);
	frag.class_attacker = class;
	frag.healers = GetHealers(client);
	
	frag.suicide = (userid == attacker);
	frag.suicide_assisted = assisted_suicide;
	frag.headshot = (customkill == TF_CUSTOM_HEADSHOT || customkill == TF_CUSTOM_HEADSHOT_DECAPITATION);
	frag.backstab = (customkill == TF_CUSTOM_BACKSTAB);
	frag.noscope = ((customkill == 11 || itemdef == 1098) && !TF2_IsPlayerInCondition(client, TFCond_Zoomed));
	frag.bleedfrag = bleedkill;
	
	if(death_flags & TF_DEATHFLAG_KILLERDOMINATION)
	{
		frag.dominated = true;
	}
	if(death_flags & TF_DEATHFLAG_ASSISTERDOMINATION)
	{
		frag.dominated_assister = true;
	}
	if(death_flags & TF_DEATHFLAG_KILLERREVENGE)
	{
		frag.revenge = true;
	}
	if(death_flags & TF_DEATHFLAG_ASSISTERREVENGE)
	{
		frag.revenge_assister = true;
	}
	if(death_flags & TF_DEATHFLAG_GIBBED)
	{
		frag.gibfrag = true;
	}
	
	frag.collateral = (playerpenetratedcount > 0);
	frag.deflectfrag = StrContains(classname, "eflect", false) != -1;
	
	frag.tauntfrag
	= (StrContains(classname, "taunt", false) != -1
	|| StrContains(classname, "armageddon", false) != -1
	|| StrContains(classname, "gas_blast", false) != -1
	|| customkill == 13);
	
	frag.pumpkinbombfrag = (StrEqual(classname, "tf_pumpkin_bomb", false));
	frag.telefrag = (StrEqual(classname, "telefrag", false));
	frag.midair = IsClientMidAir(client);
	frag.airshot = (GetClientFlags(victim) == 258);
	
	strcopy(frag.classname, sizeof(frag.classname), classname);
	frag.itemdef = itemdef;
	
	if(!g_Game[client].aFragEvent)
	{
		g_Game[client].aFragEvent = new ArrayList(sizeof(FragEventInfo));
	}
	
	g_Game[client].aFragEvent.PushArray(frag, sizeof(frag));
}

/* Called as soon a player changes their team. */
void OnPlayerTeamChange(Event event, const char[] event_name, bool dontBroadcast)
{
	if(bLoaded)
	{
		// too early to gather info, delay has to be added..
		CreateTimer(0.2, Timer_OnPlayerUpdated, event.GetInt("userid"));
	}
}

/* Called as soon as a player captures a capture point. */
void OnCapturedPoint(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	if(TF2_IsMvMGameMode())
	{
		return;
	}
	
	char cappers[MaxPlayers+1], cpname[64];
	event.GetString("cappers", cappers, sizeof(cappers));
	event.GetString("cpname", cpname, sizeof(cpname));
	
	Transaction txn = new Transaction();
	
	for(int i = 0; i < strlen(cappers); i++)
	{
		int client = cappers[i];
		if(!IsValidClient(client))
		{
			continue;
		}
		
		if(IsValidAbuse(client))
		{
			continue;
		}
		
		g_Player[client].session[Stats_PointsCaptured]++;
		
		int points = 0;
		int len = 0;
		char query[256];
		len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set");
		len += Format(query[len], sizeof(query)-len, " PointsCaptured = PointsCaptured+1");
		if((points = g_PointCaptured.IntValue) > 0 && !g_Player[client].bPenalty)
		{
			len += Format(query[len], sizeof(query)-len, " set Points = Points+%i", points);
			
			char phrase[64], points_plural[32];
			Format(phrase, sizeof(phrase), "%T{default}", "#SMStats_CaptureEvent_Type0", client, cpname);
			PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_CaptureEvent_Default", client
			, g_Player[client].name
			, g_Player[client].points
			, points_plural
			, phrase);
			
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
		}
		
		len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
		txn.AddQuery(query, query_error_uniqueid_CP_OnCapturedPoint);
	}
	
	sql.Execute(txn, _, TXN_Callback_Failure);
}

/* Called as soon as a player blocks a capture point from being captured. */
void OnCaptureBlocked(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	if(TF2_IsMvMGameMode())
	{
		return;
	}
	
	int client = event.GetInt("blocker");
	if(!IsValidClient(client))
	{
		return;
	}
	
	int victim = event.GetInt("victim");
	if(!IsValidClient(victim, !bAllowBots ? true : false))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	g_Player[client].session[Stats_PointsDefended]++;
	
	int points = 0;
	int len = 0;
	char query[256];
	len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set PointsDefended = PointsDefended+1");
	if((points = g_PointBlocked.IntValue) > 0 && !g_Player[client].bPenalty)
	{
		len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
	}
	len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
	sql.Query(DBQuery_Callback, query, query_error_uniqueid_CP_OnCapturedPoint);
	
	if(points > 0 && !g_Player[client].bPenalty)
	{
		char cpname[64], phrase[64], points_plural[32];
		event.GetString("cpname", cpname, sizeof(cpname));
		Format(phrase, sizeof(phrase), "%T{default}", "#SMStats_CaptureEvent_Type1", client, cpname);
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		CPrintToChat(client, "%s %T"
		, g_ChatTag
		, "#SMStats_CaptureEvent_Default", client
		, g_Player[client].name
		, g_Player[client].points
		, points_plural
		, phrase);
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].points += points;
	}
}

/* Called as soon the flag is picked up, captured, stolen, etc. */
void OnCTFEvent(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	if(TF2_IsMvMGameMode())
	{
		return;
	}
	
	int client = event.GetInt("player");
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	int points = 0;
	int event_type = event.GetInt("eventtype");
	if(!g_FlagEvent[event_type-1])
	{
		LogError("%s OnCTFEvent error: Flag event type %i has invalid convar handle! Please report to the dev!", core_chattag, event_type);
		return;
	}
	else if((points = g_FlagEvent[event_type-1].IntValue) < 1)
	{
		return;
	}
	else if(g_Player[client].bPenalty)
	{
		return;
	}
	
	bool home = event.GetBool("home");
	char event_phrase[64];
	
	switch(event_type)
	{
		/* Picked up */
		case 1:
		{			
			switch(home)
			{
				/* flag was not stolen (phew, that was close *heavy voice*) */
				case false:
				{
					Format(event_phrase, sizeof(event_phrase), "%T{default}", "#SMStats_FlagEvent_Type0", client);
				}
				
				/* flag was stolen */
				case true:
				{
					g_Player[client].session[Stats_FlagsStolen]++;
					points += g_FlagEvent_Stolen.IntValue;
					
					Format(event_phrase, sizeof(event_phrase), "%T{default}", "#SMStats_FlagEvent_Type1", client);
				}
			}
			
			char points_plural[32];
			PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_FlagEvent0", client
			, g_Player[client].name
			, g_Player[client].points
			, points_plural
			, event_phrase);
			
			g_Player[client].session[Stats_FlagsPickedUp]++;
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
			
			switch(home)
			{
				case false:
				{
					CallbackQuery("update `%s` set Points = Points+%i, FlagsPickedUp = FlagsPickedUp+1 where SteamID = '%s' and ServerID = %i"
					, query_error_uniqueid_CTF_OnFlagPickedUp
					, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
				}
				
				case true:
				{
					CallbackQuery("update `%s` set Points = Points+%i, FlagsPickedUp = FlagsPickedUp+1, FlagsStolen = FlagsStolen+1 where SteamID = '%s' and ServerID = %i"
					, query_error_uniqueid_CTF_OnFlagStolen
					, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
				}
			}
		}
		
		/* Captured */
		case 2:
		{
			char points_plural[32];
			PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
			Format(event_phrase, sizeof(event_phrase), "%T{default}", "#SMStats_FlagEvent_Type2", client);
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_FlagEvent0", client
			, g_Player[client].name
			, g_Player[client].points
			, points_plural
			, event_phrase);
			
			g_Player[client].session[Stats_FlagsCaptured]++;
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
			
			CallbackQuery("update `%s` set Points = Points+%i, FlagsCaptured = FlagsCaptured+1 where SteamID = '%s' and ServerID = %i"
			, query_error_uniqueid_CTF_OnFlagCaptured
			, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
		}
		
		/* Defended */
		case 3:
		{
			char points_plural[32];
			PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
			Format(event_phrase, sizeof(event_phrase), "%T{default}", "#SMStats_FlagEvent_Type3", client);
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_FlagEvent0", client
			, g_Player[client].name
			, g_Player[client].points
			, points_plural
			, event_phrase);
			
			g_Player[client].session[Stats_FlagsDefended]++;
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
			
			CallbackQuery("update `%s` set Points = Points+%i, FlagsDefended = FlagsDefended+1 where SteamID = '%s' and ServerID = %i"
			, query_error_uniqueid_CTF_OnFlagDefended
			, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
		}
		
		/* Dropped */
		case 4:
		{
			char points_plural[32];
			PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
			Format(event_phrase, sizeof(event_phrase), "%T{default}", "#SMStats_FlagEvent_Type4", client);
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_FlagEvent1", client
			, g_Player[client].name
			, g_Player[client].points
			, points_plural
			, event_phrase);
			
			g_Player[client].session[Stats_FlagsDropped]++;
			g_Player[client].session[Stats_Points] -= points;
			g_Player[client].points -= points;
			
			CallbackQuery("update `%s` set Points = Points-%i where SteamID = '%s' and ServerID = %i"
			, query_error_uniqueid_CTF_OnFlagDropped
			, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
		}
		
		/* Carrier */
		case 5:
		{
			
		}
	}
}

/* Called as soon a player places an object like a Sapper or Dispenser. */
void OnObjectPlaced(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int userid = event.GetInt("userid");
	if(userid < 1)
	{
		return;
	}
	
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	int index = event.GetInt("index");
	TFBuilding obj = TFBuilding_Invalid;
	if((obj = TF2_GetBuildingType(index)) == TFBuilding_Invalid)
	{
		LogError("[SM Stats: TF2] OnObjectPlaced error: Failed obtaining object type of object entity index %i!", index);
		return;
	}
	else if(!g_Object_Placed[obj])
	{
		LogError("[SM Stats: TF2] OnObjectPlaced error: Building type index %i has invalid convar handle!", obj);
		return;
	}
	else if(g_Game[client].bObjectPlaced[obj])
	{
		return;
	}
	
	if(!g_Game[client].aObjectPlaced)
	{
		g_Game[client].aObjectPlaced = new ArrayList(1);
	}
	
	g_Game[client].aObjectPlaced.Push(obj);
}

/* Called as soon a player destroys an object like a Sapper or Dispenser. */
void OnObjectDestroyed(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int userid = event.GetInt("attacker");
	if(userid < 1)
	{
		return;
	}
	
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	int index = event.GetInt("index");
	TFBuilding obj = TFBuilding_Invalid;
	if((obj = TF2_GetBuildingType(index)) == TFBuilding_Invalid)
	{
		LogError("%s OnObjectDestroyed error: Failed obtaining object type of object entity index %i!", core_chattag, index);
		return;
	}
	else if(!g_Object_Destroyed[obj])
	{
		LogError("%s OnObjectDestroyed error: Building type index %i has invalid convar handle!", core_chattag, obj);
		return;
	}
	else if(g_Game[client].bObjectDestroyed[obj])
	{
		return;
	}
	
	if(!g_Game[client].aObjectDestroyed)
	{
		g_Game[client].aObjectDestroyed = new ArrayList(1);
	}
	
	g_Game[client].aObjectDestroyed.Push(obj);
}

/* Called as soon as a player ubercharges. */
void OnPlayerUbercharged(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int medic_userid = event.GetInt("medic_userid");
	int userid = event.GetInt("userid");
	if(medic_userid < 1
	|| userid < 1
	|| medic_userid == userid)
	{
		return;
	}
	
	int client = GetClientOfUserId(medic_userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	if(g_Game[client].bUbercharged)
	{
		return;
	}
	
	int victim;
	if(!IsValidClient((victim = GetClientOfUserId(userid)), !bAllowBots ? true : false))
	{
		return;
	}
	
	if(!g_Ubercharged_Spy.BoolValue)
	{
		if(GetClientTeam(victim) != GetClientTeam(client))
		{
			return;
		}
	}
	
	int points = 0;
	int len;
	char query[256];
	len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set Ubercharged = Ubercharged+1");
	if((points = g_Ubercharged.IntValue) > 0 && !g_Player[client].bPenalty)
	{
		len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
	}
	len += Format(query[len], sizeof(query)-len, "where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
	sql.Query(DBQuery_Callback, query, query_error_uniqueid_OnPlayerUbercharged);
	
	g_Game[client].bUbercharged = true;
	CreateTimer(g_Time_Ubercharged, Timer_bUbercharged, GetClientUserId(client));
	
	if(points > 0 && !g_Player[client].bPenalty)
	{
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		CPrintToChat(client, "%s %T"
		, g_ChatTag
		, "#SMStats_Player_Ubercharged", client
		, g_Player[client].name
		, g_Player[client].points
		, points_plural
		, g_Player[victim].name);
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].points += points;
	}
}

/* Called as soon as a player enters a teleporter. */
void OnPlayerTeleported(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int builderid = event.GetInt("builderid");
	int userid = event.GetInt("userid");
	if(builderid < 1
	|| userid < 1
	|| builderid == userid)
	{
		return;
	}
	
	int client = GetClientOfUserId(builderid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	int victim = GetClientOfUserId(userid);
	if(!IsValidClient(victim, false))
	{
		return;
	}
	
	if(!bAllowBots)
	{
		if(IsFakeClient(victim))
		{
			return;
		}
	}
	
	g_Player[client].session[Stats_TeleportersUsed]++;
	
	// only create the handle if either points are valid or victim ain't a bot, to reserve memory space as it would otherwise serve no use and cause error.
	Transaction txn;
	
	if(!g_Game[client].bUsedTeleporter)
	{
		txn = new Transaction();
		
		int len;
		int points = 0;
		char query[256];
		len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set TeleportersUsed = TeleportersUsed+1");
		if((points = g_Teleported.IntValue) > 0 && !g_Player[client].bPenalty)
		{
			g_Player[client].session[Stats_Points] += points;
			len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
		}
		len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
		txn.AddQuery(query, query_error_uniqueid_OnPlayerUsedTeleporter);
		
		g_Game[client].bUsedTeleporter = true;
		CreateTimer(g_Time_UsedTeleporter, Timer_bUsedTeleporter, GetClientUserId(client));
	}
	
	if(!IsFakeClient(victim))
	{
		g_Player[victim].session[Stats_PlayersTeleported]++;
		
		if(!g_Game[client].bPlayerUsedTeleporter)
		{
			if(!txn)
			{
				txn = new Transaction();
			}
			
			char query[256];
			Format(query, sizeof(query), "update `%s` set PlayersTeleported = PlayersTeleported+1 where SteamID = '%s' and ServerID = %i"
			, sql_table_playerlist, g_Player[victim].auth, g_ServerID);
			txn.AddQuery(query, query_error_uniqueid_OnPlayerTeleported);
			
			g_Game[client].bPlayerUsedTeleporter = true;
			CreateTimer(g_Time_PlayerUsedTeleporter, Timer_bPlayerUsedTeleporter, GetClientUserId(client));
		}
	}
	
	if(!!txn)
	{
		sql.Execute(txn, _, TXN_Callback_Failure);
	}
}

/* Called as soon as a player steals a sandvich. */
void OnPlayerStealSandvich(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int target = event.GetInt("target");
	int owner = event.GetInt("owner");
	if(target < 1
	|| target == owner)
	{
		return;
	}
	
	int client = GetClientOfUserId(target);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	if(g_Game[client].bStolenSandvich)
	{
		return;
	}
	
	g_Player[client].session[Stats_SandvichesStolen]++;
	
	int len;
	char query[256];
	int points = 0;
	len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set SandvichesStolen = SandvichesStolen+1");
	if((points = g_SandvichStolen.IntValue) > 0 && !g_Player[client].bPenalty)
	{
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].points += points;
		len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
	}
	len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
	sql.Query(DBQuery_Callback, query, query_error_uniqueid_OnPlayerStealSandvich);
	
	g_Game[client].bStolenSandvich = true;
	CreateTimer(g_Time_StolenSandvich, Timer_bStolenSandvich, GetClientUserId(client));
	
	if(points > 0 && !g_Player[client].bPenalty)
	{
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		int victim = GetClientOfUserId(owner);
		switch(IsValidClient(victim, !bAllowBots ? true : false))
		{
			case false:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_Player_StealSandvich_Scenario1", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural);
			}
			
			case true:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_Player_StealSandvich_Scenario0", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural
				, g_Player[victim].name);
			}
		}
	}
}

/* Called as soon as a player stuns an opponent. */
void OnPlayerStunned(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int userid = event.GetInt("stunner");
	int userid_victim = event.GetInt("victim");
	if(userid < 1
	|| userid_victim < 1
	|| userid == userid_victim)
	{
		return;
	}
	
	int client;
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	if(g_Game[client].bStunned)
	{
		return;
	}
	
	int victim = GetClientOfUserId(userid_victim);
	if(!IsValidClient(userid_victim, bAllowBots ? true : false))
	{
		return;
	}
	
	int weapon;
	char weapon_classname[64];
	bool big_stun = false;
	if(IsValidEntity((weapon = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon"))))
	{
		GetEntityClassname(weapon, weapon_classname, sizeof(weapon_classname));
	}
	if(StrEqual(weapon_classname, ""))
	{
		if(IsValidEntity((weapon = GetPlayerWeaponSlot(client, 2))))
		{
			GetEntityClassname(weapon, weapon_classname, sizeof(weapon_classname));
		}
	}
	
	// Sandman used by the class Scout.
	if(StrEqual(weapon_classname, "tf_weapon_bat_wood", false))
	{
		// Moon shot stun with The Sandman used by class Scout.
		big_stun = event.GetBool("big_stun");
	}
	
	g_Player[client].session[Stats_StunnedPlayers]++;
	
	int points = 0;
	int len = 0;
	char query[256];
	len += Format(query[len], sizeof(query)-len, "update `%s` set", sql_table_playerlist);
	if((points = g_Stunned.IntValue) > 0 && !g_Player[client].bPenalty)
	{
		g_Player[client].points += points;
		g_Player[client].session[Stats_Points] += points;
		len += Format(query[len], sizeof(query)-len, " Points = Points+%i", points);
	}
	if(big_stun)
	{
		g_Player[client].session[Stats_MoonShotStunnedPlayers]++;
		len += Format(query[len], sizeof(query)-len, ", MoonShotStunnedPlayers = MoonShotStunnedPlayers+1");
	}
	len += Format(query[len], sizeof(query)-len, ", StunnedPlayers = StunnedPlayers+1");
	len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
	sql.Query(DBQuery_Callback, query, query_error_uniqueid_OnPlayerStunned);
	
	g_Game[client].bStunned = true;
	CreateTimer(g_Time_Stunned, Timer_bStunned, GetClientUserId(client));
	
	if(points > 0 && !g_Player[client].bPenalty)
	{
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		switch(big_stun)
		{
			// Stunned
			case false:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_Player_StunScenario0", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural
				, g_Player[victim].name);
			}
			
			// Stunned with a Moon shot using a baseball bat
			case true:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_Player_StunScenario1", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural
				, g_Player[victim].name);
			}
		}
	}
}

/* Called as soon as a player kills an halloween boss. */
void OnHalloweenBossKill(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	/*
	Halloween boss id in this event.
	1 - Horseless Headless Horsemann / HHH.
	2 - Monoculus.
	3 - Merasmus.
	*/
	
	int killer = event.GetInt("killer");
	int boss = event.GetInt("boss");
	if(killer < 1
	|| boss < 1)
	{
		return;
	}
	
	int client = GetClientOfUserId(killer);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	switch(boss)
	{
		case 1: g_Player[client].session[Stats_HHHFragged]++;
		case 2: g_Player[client].session[Stats_MonoculusFragged]++;
		case 3: g_Player[client].session[Stats_MerasmusFragged]++;
	}
	
	int points = 0;
	char phrase[64];
	Format(phrase, sizeof(phrase), "SMStats_HalloweenBoss_Type%i", boss);
	Format(phrase, sizeof(phrase), "%T", phrase, client);
	
	if((points = g_BossFragged[boss-1].IntValue) > 0)
	{
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		CPrintToChat(client, "%s %T"
		, g_ChatTag
		, "#SMStats_FragEvent_HalloweenBoss", client
		, g_Player[client].name
		, g_Player[client].points
		, points_plural
		, phrase);
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].points += points;
		
		switch(boss)
		{
			case 1:
			{
				CallbackQuery("update `%s` set Points = Points+%i, HHHFragged = HHHFragged+1 where SteamID = '%s' and ServerID = %i"
				, query_error_uniqueid_Halloween_OnHHHFragged
				, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
			}
			
			case 2:
			{
				CallbackQuery("update `%s` set Points = Points+%i, MonoculusFragged = MonoculusFragged+1 where SteamID = '%s' and ServerID = %i"
				, query_error_uniqueid_Halloween_OnMonoculusFragged
				, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
			}
			
			case 3:
			{
				CallbackQuery("update `%s` set Points = Points+%i, MerasmusFragged = MerasmusFragged+1 where SteamID = '%s' and ServerID = %i"
				, query_error_uniqueid_Halloween_OnMerasmusFragged
				, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
			}
		}
	}
}

/* Called as soon as a player kills the Skeleton King. */
void OnHalloweenSkeletonKingKilled(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int userid = event.GetInt("player");
	if(userid < 1)
	{
		return;
	}
	
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	g_Player[client].session[Stats_SkeletonKingsFragged]++;
	
	int points = 0;
	if((points = g_BossFragged[Boss_Skeleton].IntValue) > 0)
	{
		char phrase[64], points_plural[32];
		Format(phrase, sizeof(phrase), "%T", "#SMStats_HalloweenBoss_Type4", client);
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		CPrintToChat(client, "%s %T"
		, g_ChatTag
		, "#SMStats_FragEvent_HalloweenBoss", client
		, g_Player[client].name
		, g_Player[client].points
		, points_plural
		, phrase);
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].points += points;
		
		CallbackQuery("update `%s` set Points = Points+%i, SkeletonKingsFragged = SkeletonKingsFragged+1 where SteamID = '%s' and ServerID = %i"
		, query_error_uniqueid_Halloween_OnSkeletonKingFragged
		, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
	}
}

/* Called as soon as a player stuns the halloween boss. */
void OnHalloweenStunned(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int client = event.GetInt("player_entindex");
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	if(StrEqual(event_name, "eyeball_boss_stunned"))
	{
		g_Player[client].session[Stats_MonoculusStunned]++;
		
		int points = 0;
		if((points = g_BossStunned[Boss_Monoculus].IntValue) > 0)
		{
			char phrase[64], points_plural[32];
			Format(phrase, sizeof(phrase), "%T", "#SMStats_HalloweenBoss_Type2", client);
			PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_HalloweenBoss_StunEvent", client
			, g_Player[client].name
			, g_Player[client].points
			, points_plural
			, phrase);
			
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
			
			CallbackQuery("update `%s` set Points = Points+%i, MonoculusStunned = MonoculusStunned+1 where SteamID = '%s' and ServerID = %i"
			, query_error_uniqueid_Halloween_OnMonoculusStunned
			, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
		}
	} else
	if(StrEqual(event_name, "merasmus_stunned"))
	{
		g_Player[client].session[Stats_MerasmusStunned]++;
		
		int points = 0;
		if((points = g_BossStunned[Boss_Merasmus].IntValue) > 0)
		{
			char phrase[64], points_plural[32];
			Format(phrase, sizeof(phrase), "%T", "#SMStats_HalloweenBoss_Type2", client);
			PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_HalloweenBoss_StunEvent", client
			, g_Player[client].name
			, g_Player[client].points
			, points
			, points_plural
			, phrase);
			
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
			
			CallbackQuery("update `%s` set Points = Points+%i, MerasmusStunned = MerasmusStunned+1 where SteamID = '%s' and ServerID = %i"
			, query_error_uniqueid_Halloween_OnMerasmusStunned
			, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
		}
	}
}

/* Called as soon the Pass Ball is caught, stolen, picked up, scored, etc. */
void OnPassBallEvent(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int client = -1;
	int points = 0;
	int type = -1;
	
	if(StrEqual(event_name, "pass_get") && (client = event.GetInt("owner")) > 0 && (points = g_PassBall[(type = PassBall_GrabbingNeutralBall)].IntValue) > 0)
	{
		if(!IsValidClient(client))
		{
			return;
		}
		
		if(IsValidAbuse(client))
		{
			return;
		}
		
		if(g_Game[client].bPassBallEvent[type])
		{
			return;
		}
		
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].session[Stats_PassBallsGotten]++;
		
		CPrintToChat(client, "%s %T"
		, g_ChatTag
		, "#SMStats_PassBall_GrabNeutralBall", client
		, g_Player[client].name
		, g_Player[client].points
		, points_plural);
		
		g_Player[client].points += points;
		
		CallbackQuery("update `%s` set Points = Points+%i, PassBallsGotten = PassBallsGotten+1 where SteamID = '%s' and ServerID = %i"
		, query_error_uniqueid_PassBall_Get
		, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
	} else
	if(StrEqual(event_name, "pass_score") && (client = event.GetInt("scorer")) > 0 && (points = g_PassBall[(type = PassBall_ScoringBall)].IntValue) > 0)
	{
		if(!IsValidClient(client))
		{
			return;
		}
		
		if(IsValidAbuse(client))
		{
			return;
		}
		
		if(g_Game[client].bPassBallEvent[type])
		{
			return;
		}
		
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].session[Stats_PassBallsScored]++;
		
		CPrintToChat(client, "%s %T"
		, g_ChatTag
		, "#SMStats_PassBall_ScoreBall", client
		, g_Player[client].name
		, g_Player[client].points
		, points_plural);
		
		g_Player[client].points += points;
		
		CallbackQuery("update `%s` set Points = Points+%i, PassBallsScored = PassBallsScored+1 where SteamID = '%s' and ServerID = %i"
		, query_error_uniqueid_PassBall_Score
		, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
	} else
	if(StrEqual(event_name, "pass_free") && (client = event.GetInt("owner")) > 0 && (points = g_PassBall[(type = PassBall_DroppingBall)].IntValue) > 0)
	{
		if(!IsValidClient(client))
		{
			return;
		}
		
		if(IsValidAbuse(client))
		{
			return;
		}
		
		if(g_Game[client].bPassBallEvent[type])
		{
			return;
		}
		
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		g_Player[client].session[Stats_Points] -= points;
		g_Player[client].session[Stats_PassBallsDropped]++;
		
		CPrintToChat(client, "%s %T"
		, g_ChatTag
		, "#SMStats_PassBall_DropBall", client
		, g_Player[client].name
		, g_Player[client].points
		, points_plural);
		
		g_Player[client].points -= points;
		
		CallbackQuery("update `%s` set Points = Points+%i, PassBallsDropped = PassBallsDropped+1 where SteamID = '%s' and ServerID = %i"
		, query_error_uniqueid_PassBall_Dropped
		, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
	} else
	if(StrEqual(event_name, "pass_pass_caught") && (client = event.GetInt("catcher")) > 0 && (points = g_PassBall[(type = PassBall_CatchingBall)].IntValue) > 0)
	{
		if(!IsValidClient(client))
		{
			return;
		}
		
		if(IsValidAbuse(client))
		{
			return;
		}
		
		if(g_Game[client].bPassBallEvent[type])
		{
			return;
		}
		
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].session[Stats_PassBallsCatched]++;
		
		int victim = event.GetInt("victim");
		switch(IsValidClient(victim, bAllowBots ? true : false))
		{
			case false:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_PassBall_CatchBall_Scenario0", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural);
			}
			
			case true:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_PassBall_CatchBall_Scenario1", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural
				, g_Player[victim].name);
			}
		}
		
		g_Player[client].points += points;
		
		CallbackQuery("update `%s` set Points = Points+%i, PassBallsCatched = PassBallsCatched+1 where SteamID = '%s' and ServerID = %i"
		, query_error_uniqueid_PassBall_Catched
		, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
	} else
	if(StrEqual(event_name, "pass_pass_stolen") && (client = event.GetInt("attacker")) > 0 && (points = g_PassBall[(type = PassBall_StealingBall)].IntValue) > 0)
	{
		if(!IsValidClient(client))
		{
			return;
		}
		
		if(IsValidAbuse(client))
		{
			return;
		}
		
		if(g_Game[client].bPassBallEvent[type])
		{
			return;
		}
		
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].session[Stats_PassBallsStolen]++;
		
		int victim = event.GetInt("victim");	
		switch(IsValidClient(victim, bAllowBots ? true : false))
		{
			case false:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_PassBall_StealBall_Scenario0", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural);
			}
			
			case true:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_PassBall_StealBall_Scenario1", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural
				, g_Player[victim].name);
			}
		}
		
		g_Player[client].points += points;
		
		CallbackQuery("update `%s` set Points = Points+%i, PassBallsStolen = PassBallsStolen+1 where SteamID = '%s' and ServerID = %i"
		, query_error_uniqueid_PassBall_Stolen
		, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
	} else
	if(StrEqual(event_name, "pass_pass_blocked") && (client = event.GetInt("blocker")) > 0 && (points = g_PassBall[(type = PassBall_BlockingBall)].IntValue) > 0)
	{
		if(!IsValidClient(client))
		{
			return;
		}
		
		if(IsValidAbuse(client))
		{
			return;
		}
		
		if(g_Game[client].bPassBallEvent[type])
		{
			return;
		}
		
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].session[Stats_PassBallsBlocked]++;
		
		int victim = event.GetInt("victim");
		switch(IsValidClient(victim, !bAllowBots ? true : false))
		{
			case false:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_PassBall_BlockBall_Scenario0", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural);
			}
			
			case true:
			{
				CPrintToChat(client, "%s %T"
				, g_ChatTag
				, "#SMStats_PassBall_BlockBall_Scenario1", client
				, g_Player[client].name
				, g_Player[client].points
				, points_plural
				, g_Player[victim].name);
			}
		}
		
		g_Player[client].points += points;
		
		CallbackQuery("update `%s` set Points = Points+%i, PassBallsBlocked = PassBallsBlocked+1 where SteamID = '%s' and ServerID = %i"
		, query_error_uniqueid_PassBall_Blocked
		, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
	}
	
	if(client > 0 && type != -1)
	{
		g_Game[client].bPassBallEvent[type] = true;
		
		DataPack pack;
		CreateTimer(g_Time_PassBallEvent, Timer_bPassBallEvent, pack);
		pack.WriteCell(GetClientUserId(client));
		pack.WriteCell(PassBall_GrabbingNeutralBall);
		pack.Reset();
	}
}

/* Called as soon the tank is destroyed. */
void MvM_OnTankDestroyed(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	if(!TF2_IsMvMGameMode())
	{
		return;
	}
	
	int points = 0;
	if((points = g_MvM[MvM_DestroyTank].IntValue) < 1)
	{
		return;
	}
	
	// will be updated to correctly target whose players gave damage to the 'tank_boss' entity.
	
	int client = 0;
	while((client = FindEntityByClassname(client, "player")) > 0)
	{
		if(!IsValidClient(client))
		{
			continue;
		}
		
		if(IsValidAbuse(client))
		{
			continue;
		}
		
		if(TF2_GetClientTeam(client) == TFTeam_Red)
		{
			char points_plural[32];
			PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_MvM_TeamDestroyedTank", client
			, g_Player[client].name
			, g_Player[client].points
			, points_plural);
			
			g_Player[client].session[Stats_TanksDestroyed]++;
			g_Player[client].session[Stats_Points] += points;
			g_Player[client].points += points;
			
			CallbackQuery("update `%s` set Points = Points+%i, TanksDestroyed = TanksDestroyed+1 where SteamID = '%s' and ServerID = %i"
			, query_error_uniqueid_MvM_OnTankDestroyed
			, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
		}
	}
}

/* Called as soon as a robot was fragged. */
void MvM_OnRobotDeath(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	if(!TF2_IsMvMGameMode())
	{
		return;
	}
	
	int userid = event.GetInt("attacker");
	int userid_victim = event.GetInt("userid");
	if(userid < 1
	|| userid_victim < 1
	|| userid == userid_victim)
	{
		return;
	}
	
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	int victim = GetClientOfUserId(userid_victim);
	if(!IsValidClient(victim))
	{
		return;
	}
	
	bool bSentryBuster = false;
	
	char sentry_buster[64];
	Format(sentry_buster, sizeof(sentry_buster), "%N", victim);
	
	if(strlen(sentry_buster) < 1)
	{
		return;
	} else
	if(StrContains(sentry_buster, "Sentry Buster") >= 0)
	{
		int weapon = GetPlayerWeaponSlot(victim, 2);
		
		if(IsValidEntity(weapon))
		{
			int itemdef = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");
			
			switch(itemdef)
			{
				case 307: bSentryBuster = true;
			}
		}
	}
	
	int points = 0;
	
	if(bSentryBuster)
	{
		g_Player[client].session[Stats_SentryBustersFragged]++;
		g_Player[client].session[Stats_RobotsFragged]++;
		
		if((points = g_MvM[MvM_FragSentryBuster].IntValue) < 1)
		{
			return;
		}
		
		char points_plural[32];
		PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
		
		CPrintToChat(client, "%s %T"
		, g_ChatTag
		, "#SMStats_MvM_Player_FragSentryBuster", client 
		, g_Player[client].name
		, g_Player[client].points
		, points_plural);
		
		g_Player[client].session[Stats_Points] += points;
		g_Player[client].points += points;
		
		CallbackQuery("update `%s` set Points = Points+%i, SentryBustersFragged = SentryBustersFragged+1 where SteamID = '%s' and ServerID = %i"
		, query_error_uniqueid_MvM_OnSentryBusterFragged
		, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
		
		return;
	}
	
	g_Game[client].iRobotFragEvent++;
}

/* Called as soon as the bomb was resetted. */
void MvM_OnBombResetted(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	if(!TF2_IsMvMGameMode())
	{
		return;
	}
	
	int userid = event.GetInt("player");
	if(userid < 1)
	{
		return;
	}
	
	int client = GetClientOfUserId(userid);
	if(!IsValidClient(client))
	{
		return;
	}
	
	if(IsValidAbuse(client))
	{
		return;
	}
	
	int points = 0;
	if((points = g_MvM[MvM_ResetBomb].IntValue) < 1)
	{
		return;
	}
	
	char points_plural[32];
	PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
	
	CPrintToChat(client, "%s %T"
	, "#SMStats_MvM_Player_ResetBomb", client
	, g_Player[client].name
	, g_Player[client].points
	, points_plural);
	
	g_Player[client].session[Stats_BombsResetted]++;
	g_Player[client].session[Stats_Points] += points;
	g_Player[client].points += points;
	
	CallbackQuery("update `%s` set Points = Points+%i, BombsResetted = BombsResetted+1 where SteamID = '%s' and ServerID = %i"
	, query_error_uniqueid_MvM_OnBombResetted
	, sql_table_playerlist, points, g_Player[client].auth, g_ServerID);
}

/* ===================================================================================== */

/* Called as soon as a player coats an opponent. */
Action OnPlayerCoated(UserMsg msg_id, BfRead bf, const int[] players, int playersNum, bool reliable, bool init)
{
	int client = bf.ReadByte();
	int victim = bf.ReadByte();
	int itemdef = -1;
	
	char item_class[64];
	int jar = GetPlayerWeaponSlot(client, 1);
	if(IsValidEntity(jar))
	{
		itemdef = GetEntProp(jar, Prop_Send, "m_iItemDefinitionIndex");
		GetEntityClassname(jar, item_class, sizeof(item_class));
	}
	
	if(!IsValidClient(client))
	{
		return Plugin_Handled;
	}
	
	bool bProceed = true;
	int iType = -1;
	
	// Coated with piss
	if(StrEqual(item_class, "tf_weapon_jar", false))
	{
		if(g_Game[client].bPlayerJarated)
		{
			bProceed = false;
		}
		
		iType = 1;
	}
	// Coated with milk
	else if(StrEqual(item_class, "tf_weapon_jar_milk", false))
	{
		if(g_Game[client].bPlayerMilked)
		{
			bProceed = false;
		}
		
		iType = 2;
	}
	// Coated with flammable gasoline
	else if(StrEqual(item_class, "tf_weapon_jar_gas", false))
	{
		if(g_Game[client].bPlayerGasPassed)
		{
			bProceed = false;
		}
		
		iType = 3;
	}
	else
	{
		PrintToServer("%s OnPlayerCoated() Invalid jar detected!\nInformation: Item classname '%s'\nItem definition index %i", core_chattag, item_class, itemdef);
		bProceed = false;
	}
	
	/* Manually fire a broken event */
	Event event = CreateEvent("player_jarated", true);
	event.SetInt("thrower_entindex", client);
	event.SetInt("victim_entindex", victim);
	event.SetInt("itemdefindex", itemdef);
	event.Fire();
	
	if(!IsValidStats())
	{
		return Plugin_Handled;
	}
	
	if(!bProceed)
	{
		return Plugin_Handled;
	}
	
	if(IsValidAbuse(client))
	{
		return Plugin_Handled;
	}
	
	if(!IsValidClient(victim, !bAllowBots ? true : false))
	{
		return Plugin_Handled;
	}
	
	if(!g_Game[client].aJarEvent)
	{
		g_Game[client].aJarEvent = new ArrayList(2);
	}
	
	int array[2];
	array[0] = GetClientUserId(victim);
	array[1] = iType;
	
	g_Game[client].aJarEvent.PushArray(array, sizeof(array));
	
	return Plugin_Continue;
}

/* Called as soon as a player extinguishes a teammate. */
Action OnPlayerExtinguished(UserMsg msg_id, BfRead bf, const int[] players, int playersNum, bool reliable, bool init)
{
	int client = bf.ReadByte();
	int victim = bf.ReadByte();
	int itemdef = bf.ReadByte();
	
	/* Because event "player_extinguished" is broken, we can manually force the event to be fired. */
	Event event = CreateEvent("player_extinguished", true);
	event.SetInt("healer", client);
	event.SetInt("itemdefindex", itemdef);
	event.Fire();
	
	if(!bLoaded)
	{
		return Plugin_Handled;
	}
	
	if(!IsValidClient(client))
	{
		return Plugin_Handled;
	}
	
	if(IsValidAbuse(client))
	{
		return Plugin_Handled;
	}
	
	if(g_Game[client].bExtEvent)
	{
		return Plugin_Handled;
	}
	
	if(!IsValidClient(victim, !bAllowBots ? true : false))
	{
		return Plugin_Handled;
	}
	
	if(!g_Game[client].aExtEvent)
	{
		g_Game[client].aExtEvent = new ArrayList();
	}
	
	g_Game[client].aExtEvent.Push(GetClientUserId(victim));
	
	return Plugin_Handled;
}

/* Called as soon as a player ignites an opponnent. */
Action OnPlayerIgnited(UserMsg msg_id, BfRead bf, const int[] players, int playersNum, bool reliable, bool init)
{
	int client = bf.ReadByte();
	int victim = bf.ReadByte();
	
	/* Lets manually force the event to be fired, since it's broken. */
	Event event = CreateEvent("player_ignited", true);
	event.SetInt("pyro_entindex", client);
	event.SetInt("victim_entindex", victim);
	event.Fire();
	
	if(!bLoaded)
	{
		return Plugin_Handled;
	}
	
	if(!IsValidClient(client))
	{
		return Plugin_Handled;
	}
	
	if(IsValidAbuse(client))
	{
		return Plugin_Handled;
	}
	
	if(!IsValidClient(victim, !bAllowBots ? true : false))
	{
		return Plugin_Handled;
	}
	
	g_Player[client].session[Stats_Ignited]++;
	
	return Plugin_Handled;
}

/* ===================================================================================== */

// instead of OnGameFrame, we have custom delayed game timer.
// For optimization purposes.
// Workaround with OnGameFrame possible would be greatly appreciated.
Action MapTimer_GameTimer(Handle timer)
{
	if(bLoaded)
	{
		// alternative over a for() loop.
		int client = 0;
		while((client = FindEntityByClassname(client, "player")) > 0)
		{
			if(!IsValidClient(client))
			{
				continue;
			}
			
			char str_playtime[11];
			FloatToString(GetClientTime(client), str_playtime, sizeof(str_playtime));
			g_Player[client].session[Stats_PlayTime] = StringToInt(str_playtime);
			if(g_Player[client].active_page_mainmenu >= 1)
			{
				StatsMenu.Main(client, g_Player[client].active_page_mainmenu);
			}
			else if(g_Player[client].active_page_session == 1)
			{
				StatsMenu.Session(client, g_Player[client].active_page_session);
			}
			
			if(!!g_Game[client].aFragEvent)
			{
				int frags;
				if((frags = g_Game[client].aFragEvent.Length) > 0)
				{
					FragEventInfo event;
					int[] list = new int[frags];
					int[] list_assister = new int[frags];
					bool[] list_assister_dominate = new bool[frags];
					bool[] list_assister_revenge = new bool[frags];
					int[] list_healercount = new int[frags];
					int[][] list_healer = new int[MaxPlayers+1][frags];
					int[] list_inflictor = new int[frags];
					int[] list_itemdef = new int[frags];
					any[] list_class = new any[frags];
					bool[] list_wepfrag = new bool[frags];
					char[][] list_classname = new char[frags][64];
					char[][] list_classname_backup = new char[frags][64];
					
					// kill log
					
					bool[] bBotFrag = new bool[frags];
					char[][] list_steamid_victim = new char[frags][28];
					char list_steamid_assister[448];
					int[] list_timestamp = new int[frags];
					int[] list_weaponitemdef = new int[frags];
					
					bool[] list_domination = new bool[frags];
					bool[] list_revenge = new bool[frags];
					bool[] list_airshot = new bool[frags];
					bool[] list_headshot = new bool[frags];
					bool[] list_noscope = new bool[frags];
					bool[] list_backstab = new bool[frags];
					bool[] list_tauntfrag = new bool[frags];
					bool[] list_gibfrag = new bool[frags];
					bool[] list_deflectfrag = new bool[frags];
					bool[] list_telefrag = new bool[frags];
					bool[] list_collateral = new bool[frags];
					bool[] list_midairfrag = new bool[frags];
					bool[] list_critfrag = new bool[frags];
					bool[] list_minicritfrag = new bool[frags];
					bool[] list_pumpkinbombfrag = new bool[frags];
					
					bool[] list_minisentryfrag = new bool[frags];
					bool[] list_sentryfrag = new bool[frags];
					int[] list_sentrylvlfrag = new int[frags];
					
					bool[] list_ubercharged = new bool[frags];
					bool[] list_vaccinatortypeused = new bool[frags];
					
					int[] list_stunnedtype = new int[frags];
					int[] list_coatedtype = new int[frags];
					
					//
					
					int iHeadshots;
					int iBackstabs;
					int iDominated;
					int iRevenges;
					int iNoscopes;
					int iTauntFrags;
					int iPumpkinBombFrags;
					int iDeflectFrags;
					int iGibFrags;
					int iAirshots;
					int iCollaterals;
					int iMidAirFrags;
					int iMiniCrits;
					int iCrits;
					
					int iScouts;
					int iSoldiers;
					int iPyros;
					int iDemos;
					int iHeavies;
					int iEngies;
					int iMedics;
					int iSnipers;
					int iSpies;
					
					int iTeleFrags;
					int iWepFrags;
					
					int iDispensers;
					int iSentries;
					int iSentriesLVL1;
					int iSentriesLVL2;
					int iSentriesLVL3;
					int iMiniSentries;
					
					int points = 0;
					
					// store temporary info for frag message
					
					bool bPrev_headshot;
					bool bPrev_backstab;
					bool bPrev_domination;
					bool bPrev_revenge;
					bool bPrev_noscope;
					bool bPrev_tauntfrag;
					bool bPrev_pumpkinbombfrag;
					bool bPrev_deflectfrag;
					bool bPrev_gibfrag;
					bool bPrev_airshot;
					bool bPrev_collateral;
					bool bPrev_midair;
					
					//
					
					for(int i = 0; i < frags; i++)
					{
						g_Game[client].aFragEvent.GetArray(i, event, sizeof(event));
						list_timestamp[i] = event.timestamp;
						int userid_victim = (list[i] = event.userid);
						list_assister[i] = event.assister;
						list_assister_dominate[i] = event.dominated_assister;
						list_assister_revenge[i] = event.revenge_assister;
						list_inflictor[i] = event.inflictor;
						list_itemdef[i] = event.itemdef;
						list_class[i] = event.class;
						strcopy(list_classname_backup[i], sizeof(event.classname), event.classname);
						
						// kill log
						int victim;
						if(IsValidClient((victim = GetClientOfUserId(userid_victim))))
						{
							strcopy(list_steamid_victim[i], sizeof(g_Player[].auth), g_Player[victim].auth);
						}
						
						// override medic assister, count all healers as assisters.
						if(!!event.healers)
						{
							for(int x = 0; x < event.healers.Length; x++)
							{
								list_healer[x][i] = event.healers.Get(x);
								list_healercount[i] = event.healers.Length;
							}
							
							delete event.healers;
						}
						
						switch(event.suicide_assisted)
						{
							case false:
							{
								if(event.telefrag)
								{
									points += g_TeleFrag.IntValue;
								}
								else if(event.pumpkinbombfrag)
								{
									points += g_PumpkinBomb.IntValue;
								}
							}
							case true: points += g_SuicideAssisted.IntValue;
						}
						switch((g_Player[client].fragmsg.Headshot = event.headshot))
						{
							case false: bPrev_headshot = false;
							case true:
							{
								iHeadshots++;
								if(frags > 1 && !bPrev_headshot)
								{
									g_Player[client].fragmsg.Headshot = false;
								}
								bPrev_headshot = true;
								list_headshot[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.Backstab = event.backstab))
						{
							case false: bPrev_backstab = false;
							case true:
							{
								iBackstabs++;
								if(frags > 1 && !bPrev_backstab)
								{
									g_Player[client].fragmsg.Backstab = false;
								}
								bPrev_backstab = true;
								list_backstab[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.Domination = event.dominated))
						{
							case false: bPrev_domination = false;
							case true:
							{
								iDominated++;
								if(frags > 1 && !bPrev_domination)
								{
									g_Player[client].fragmsg.Domination = false;
								}
								bPrev_domination = true;
								list_domination[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.Revenge = event.revenge))
						{
							case false: bPrev_revenge = false;
							case true:
							{
								iRevenges++;
								if(frags > 1 && bPrev_revenge)
								{
									g_Player[client].fragmsg.Revenge = false;
								}
								bPrev_revenge = true;
								list_revenge[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.Noscope = event.noscope))
						{
							case false: bPrev_noscope = false;
							case true:
							{
								iNoscopes++;
								if(frags > 1 && !bPrev_noscope)
								{
									g_Player[client].fragmsg.Noscope = false;
								}
								bPrev_noscope = true;
								list_noscope[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.Taunt = event.tauntfrag))
						{
							case false: bPrev_tauntfrag = false;
							case true:
							{
								iTauntFrags++;
								if(frags > 1 && !bPrev_tauntfrag)
								{
									g_Player[client].fragmsg.Taunt = false;
								}
								bPrev_tauntfrag = true;
								list_tauntfrag[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.PumpkinBomb = event.pumpkinbombfrag))
						{
							case false: bPrev_tauntfrag = false;
							case true:
							{
								iPumpkinBombFrags++;
								if(frags > 1 && !bPrev_pumpkinbombfrag)
								{
									g_Player[client].fragmsg.PumpkinBomb = false;
								}
								bPrev_pumpkinbombfrag = true;
								list_pumpkinbombfrag[i] = true
							}
						}
						switch((g_Player[client].fragmsg.Deflected = event.deflectfrag))
						{
							case false: bPrev_deflectfrag = false;
							case true:
							{
								iDeflectFrags++;
								if(frags > 1 && !bPrev_deflectfrag)
								{
									g_Player[client].fragmsg.Deflected = false;
								}
								bPrev_deflectfrag = true;
								list_deflectfrag[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.Gibbed = event.gibfrag))
						{
							case false: bPrev_gibfrag = false;
							case true:
							{
								iGibFrags++;
								if(frags > 1 && !bPrev_gibfrag)
								{
									g_Player[client].fragmsg.Gibbed = false;
								}
								bPrev_gibfrag = true;
								list_gibfrag[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.Airshot = event.airshot))
						{
							case false: bPrev_airshot = false;
							case true:
							{
								iAirshots++;
								if(frags > 1 && !bPrev_airshot)
								{
									g_Player[client].fragmsg.Airshot = false;
								}
								bPrev_airshot = true;
								list_airshot[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.Collateral = event.collateral))
						{
							case false: bPrev_collateral = false;
							case true:
							{
								iCollaterals++;
								if(frags > 1 && !bPrev_collateral)
								{
									g_Player[client].fragmsg.Collateral = false;
								}
								bPrev_collateral = true;
								list_collateral[i] = true;
							}
						}
						switch((g_Player[client].fragmsg.MidAir = event.midair))
						{
							case false: bPrev_midair = false;
							case true:
							{
								iMidAirFrags++;
								if(frags > 1 && !bPrev_midair)
								{
									g_Player[client].fragmsg.MidAir = false;
								}
								bPrev_midair = true;
								list_midairfrag[i] = true;
							}
						}
						switch(event.crit_type)
						{
							case 1:
							{
								iMiniCrits++;
								list_minicritfrag[i] = true;
							}
							case 2:
							{
								iCrits++;
								list_critfrag[i] = true;
							}
						}
						
						switch(event.class)
						{
							case TFClass_Scout: iScouts++;
							case TFClass_Soldier: iSoldiers++;
							case TFClass_Pyro: iPyros++;
							case TFClass_DemoMan: iDemos++;
							case TFClass_Heavy: iHeavies++;
							case TFClass_Engineer: iEngies++;
							case TFClass_Medic: iMedics++;
							case TFClass_Sniper: iSnipers++;
							case TFClass_Spy: iSpies++;
						}
						
						switch(TF2_IsEntityBuilding(event.inflictor))
						{
							case false:
							{
								switch(event.telefrag)
								{
									case false:
									{
										if(!event.pumpkinbombfrag)
										{
											iWepFrags++;
											list_wepfrag[i] = true;
											
											int itemdef = (list_weaponitemdef[i] = event.itemdef);
											ConVar cvar_points;
											switch((cvar_points = array_GetWeapon(itemdef)) == null)
											{
												case false: points += cvar_points.IntValue;
												case true:
												{
													PrintToServer("%s itemdef %i has invalid convar!"
													... "\nattacker userid : %i"
													... "\nvictim userid : %i"
													... "\nvictim class : %i"
													... "\n "
													, core_chattag, itemdef
													, GetClientUserId(client)
													, list[i]
													, list_class[i]);
													continue;
												}
											}
										}
									}
									case true:
									{
										iTeleFrags++;
										list_telefrag[i] = true;
									}
								}
							}
							
							case true:
							{
								switch(TF2_GetBuildingType(event.inflictor))
								{
									case TFBuilding_Dispenser: iDispensers++;
									case TFBuilding_Sentrygun:
									{
										iSentries++;
										int level = TF2_GetBuildingLevel(event.inflictor);
										list_sentryfrag[i] = true;
										list_sentrylvlfrag[i] = level;
										
										switch(level)
										{
											case 1: iSentriesLVL1++;
											case 2: iSentriesLVL2++;
											case 3: iSentriesLVL3++;
										}
									}
									
									case TFBuilding_MiniSentry:
									{
										iMiniSentries++;
										list_minisentryfrag[i] = true;
									}
								}
							}
						}
						
						//
					}
					
					g_Game[client].aFragEvent.Clear();
					
					int attacker = GetClientUserId(client); // native string arrays needs to be added (・`ω´・)
					_sm_stats_player_death_fwd(attacker, frags, list, list_assister, event.classname, list_itemdef);
					
					char dummy[256];
					GetMultipleTargets(client, list, frags, dummy, sizeof(dummy));
					
					Transaction txn = new Transaction();
					AssistedKills(txn, list, list_assister, list_assister_dominate, list_assister_revenge, frags, client, list_healercount, list_healer, list_steamid_assister);
					VictimDied(txn, list, list_class, frags);
					
					char query[4096], query_map[4096];
					int len = 0, len_map = 0;
					len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set Frags = Frags+%i", frags);
					len_map += Format(query_map[len_map], sizeof(query_map)-len_map, "update `"...sql_table_maps_log..."` set Frags = Frags+%i", frags);
					
					if(iWepFrags > 0)
					{
						for(int i = 0; i < frags; i++)
						{
							if(list_wepfrag[i])
							{
								char fix_weapon[64], query_wep[256];
								CorrectWeaponClassname(event.class_attacker, list_classname[i], sizeof(fix_weapon), list_itemdef[i], list_classname_backup[i]);
								Format(query_wep, sizeof(query_wep), "update `"...sql_table_weapons..."` set %s = %s+1 where SteamID = '%s' and ServerID = %i"
								, list_classname[i], list_classname[i], g_Player[client].auth, g_ServerID);
								txn.AddQuery(query_wep, queryId_frag_weapon);
							}
						}
					}
					if(iTeleFrags > 0)
					{
						g_Player[client].session[Stats_TeleFrags] += iTeleFrags;
						points = g_TeleFrag.IntValue * iTeleFrags;
						len += Format(query[len], sizeof(query)-len, ", TeleFrags = TeleFrags+%i", iTeleFrags);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", TeleFrags = TeleFrags+%i", iTeleFrags);
					}
					if(iDispensers > 0)
					{
						PrintToServer("%s frag event (user index %i, userid %i) caught a dispenser somehow"
						, core_chattag
						, client, GetClientUserId(client), core_chattag);
					}
					if(iSentries > 0)
					{
						g_Player[client].session[Stats_SentryFrags] += iSentries;
						len += Format(query[len], sizeof(query)-len, ", SentryFrags = SentryFrags+%i", iSentries);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SentryFrags = SentryFrags+%i", iSentries);
						
						if(iSentriesLVL1 > 0)
						{
							len += Format(query[len], sizeof(query)-len, ", SentryLVL1Frags = SentryLVL1Frags+%i", iSentriesLVL1);
							len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SentryLVL1Frags = SentryLVL1Frags+%i", iSentriesLVL1);
						}
						if(iSentriesLVL2 > 0)
						{
							len += Format(query[len], sizeof(query)-len, ", SentryLVL2Frags = SentryLVL2Frags+%i", iSentriesLVL2);
							len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SentryLVL2Frags = SentryLVL2Frags+%i", iSentriesLVL2);
						}
						if(iSentriesLVL3 > 0)
						{
							len += Format(query[len], sizeof(query)-len, ", SentryLVL3Frags = SentryLVL3Frags+%i", iSentriesLVL3);
							len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SentryLVL3Frags = SentryLVL3Frags+%i", iSentriesLVL3);
						}
					}
					if(iMiniSentries > 0)
					{
						g_Player[client].session[Stats_MiniSentryFrags] += iMiniSentries;
						len += Format(query[len], sizeof(query)-len, ", MiniSentryFrags = MiniSentryFrags+%i", iMiniSentries);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", MiniSentryFrags = MiniSentryFrags+%i", iMiniSentries);
					}
					if(iHeadshots > 0)
					{
						g_Player[client].session[Stats_Headshots] += iHeadshots;
						len += Format(query[len], sizeof(query)-len, ", Headshots = Headshots+%i", iHeadshots);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", Headshots = Headshots+%i", iHeadshots);
					}
					if(iBackstabs > 0)
					{
						g_Player[client].session[Stats_Backstabs] += iBackstabs;
						len += Format(query[len], sizeof(query)-len, ", Backstabs = Backstabs+%i", iBackstabs);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", Backstabs = Backstabs+%i", iBackstabs);
					}
					if(iDominated > 0)
					{
						g_Player[client].session[Stats_Dominations] += iDominated;
						len += Format(query[len], sizeof(query)-len, ", Dominations = Dominations+%i", iDominated);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", Dominations = Dominations+%i", iDominated);
					}
					if(iRevenges > 0)
					{
						g_Player[client].session[Stats_Revenges] += iRevenges;
						len += Format(query[len], sizeof(query)-len, ", Revenges = Revenges+%i", iRevenges);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", Revenges = Revenges+%i", iRevenges);
					}
					if(iNoscopes > 0)
					{
						g_Player[client].session[Stats_Noscopes] += iNoscopes;
						len += Format(query[len], sizeof(query)-len, ", Noscopes = Noscopes+%i", iNoscopes);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", Noscopes = Noscopes+%i", iNoscopes);
					}
					if(iTauntFrags > 0)
					{
						g_Player[client].session[Stats_TauntFrags] += iTauntFrags;
						len += Format(query[len], sizeof(query)-len, ", TauntFrags = TauntFrags+%i", iTauntFrags);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", TauntFrags = TauntFrags+%i", iTauntFrags);
					}
					if(iPumpkinBombFrags > 0)
					{
						g_Player[client].session[Stats_PumpkinBombFrags] += iPumpkinBombFrags;
						len += Format(query[len], sizeof(query)-len, ", PumpkinBombFrags = PumpkinBombFrags+%i", iPumpkinBombFrags);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", PumpkinBombFrags = PumpkinBombFrags+%i", iPumpkinBombFrags);
					}
					if(iDeflectFrags > 0)
					{
						g_Player[client].session[Stats_Deflects] += iDeflectFrags;
						len += Format(query[len], sizeof(query)-len, ", DeflectFrags = DeflectFrags+%i", iDeflectFrags);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", DeflectFrags = DeflectFrags+%i", iDeflectFrags);
					}
					if(iGibFrags > 0)
					{
						g_Player[client].session[Stats_GibFrags] += iGibFrags;
						len += Format(query[len], sizeof(query)-len, ", GibFrags = GibFrags+%i", iGibFrags);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", GibFrags = GibFrags+%i", iGibFrags);
					}
					if(iAirshots > 0)
					{
						g_Player[client].session[Stats_Airshots] += iAirshots;
						len += Format(query[len], sizeof(query)-len, ", Airshots = Airshots+%i", iAirshots);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", Airshots = Airshots+%i", iAirshots);
					}
					if(iCollaterals > 0)
					{
						g_Player[client].session[Stats_Collaterals] += iCollaterals;
						len += Format(query[len], sizeof(query)-len, ", Collaterals = Collaterals+%i", iCollaterals);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", Collaterals = Collaterals+%i", iCollaterals);
						
						if(g_Collateral.IntValue)
						{
							points += g_Collateral.IntValue;
						}
					}
					if(iMidAirFrags > 0)
					{
						g_Player[client].session[Stats_MidAirFrags] += iMidAirFrags;
						len += Format(query[len], sizeof(query)-len, ", MidAirFrags = MidAirFrags+%i", iMidAirFrags);
						len_map += Format(query[len_map], sizeof(query_map)-len_map, ", MidAirFrags = MidAirFrags+%i", iMidAirFrags);
					}
					// mini-crit
					if(iMiniCrits > 0)
					{
						g_Player[client].session[Stats_MiniCritFrags] += frags;
						len += Format(query[len], sizeof(query)-len, ", MiniCritFrags = MiniCritFrags+%i", frags);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", MiniCritFrags = MiniCritFrags+%i", frags);
					}
					// crit 
					if(iCrits > 0)
					{
						g_Player[client].session[Stats_CritFrags] += frags;
						len += Format(query[len], sizeof(query)-len, ", CritFrags = CritFrags+%i", frags);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", CritFrags = CritFrags+%i", frags);
					}
					// classes
					if(iScouts > 0)
					{
						g_Player[client].session[Stats_ScoutFrags] += iScouts;
						len += Format(query[len], sizeof(query)-len, ", ScoutFrags = ScoutFrags+%i", iScouts);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", ScoutFrags = ScoutFrags+%i", iScouts);
					}
					if(iSoldiers > 0)
					{
						g_Player[client].session[Stats_SoldierFrags] += iSoldiers;
						len += Format(query[len], sizeof(query)-len, ", SoldierFrags = SoldierFrags+%i", iSoldiers);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SoldierFrags = SoldierFrags+%i", iSoldiers);
					}
					if(iPyros > 0)
					{
						g_Player[client].session[Stats_PyroFrags] += iPyros;
						len += Format(query[len], sizeof(query)-len, ", PyroFrags = PyroFrags+%i", iPyros);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", PyroFrags = PyroFrags+%i", iPyros);
					}
					if(iDemos > 0)
					{
						g_Player[client].session[Stats_DemoFrags] += iDemos;
						len += Format(query[len], sizeof(query)-len, ", DemoFrags = DemoFrags+%i", iDemos);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", DemoFrags = DemoFrags+%i", iDemos);
					}
					if(iHeavies > 0)
					{
						g_Player[client].session[Stats_HeavyFrags] += iHeavies;
						len += Format(query[len], sizeof(query)-len, ", HeavyFrags = HeavyFrags+%i", iHeavies);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", HeavyFrags = HeavyFrags+%i", iHeavies);
					}
					if(iEngies > 0)
					{
						g_Player[client].session[Stats_EngieFrags] += iEngies;
						len += Format(query[len], sizeof(query)-len, ", EngieFrags = EngieFrags+%i", iEngies);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", EngieFrags = EngieFrags+%i", iEngies);
					}
					if(iMedics > 0)
					{
						g_Player[client].session[Stats_MedicFrags] += iMedics;
						len += Format(query[len], sizeof(query)-len, ", MedicFrags = MedicFrags+%i", iMedics);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", MedicFrags = MedicFrags+%i", iMedics);
					}
					if(iSnipers > 0)
					{
						g_Player[client].session[Stats_SniperFrags] += iSnipers;
						len += Format(query[len], sizeof(query)-len, ", SniperFrags = SniperFrags+%i", iSnipers);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SniperFrags = SniperFrags+%i", iSnipers);
					}
					if(iSpies > 0)
					{
						g_Player[client].session[Stats_SpyFrags] += iSpies;
						len += Format(query[len], sizeof(query)-len, ", SpyFrags = SpyFrags+%i", iSpies);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SpyFrags = SpyFrags+%i", iSpies);
					}
					
					//
					
					g_Player[client].session[Stats_Frags] += frags;
					
					if(points >= 1 && !g_Player[client].bPenalty)
					{
						g_Player[client].session[Stats_Points] += points;
						g_Player[client].points += points;
						len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
					}
					
					len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
					len_map += Format(query_map[len_map], sizeof(query_map)-len_map, " where ServerID = %i", g_ServerID);
					txn.AddQuery(query, queryId_frag_playerlist);
					txn.AddQuery(query_map, queryId_frag_playerlist_MapUpdate);
					
					
					// kill log
					
					for(int i = 0; i < frags; i++)
					{
						if(!bBotFrag[i])
						{
							int lenk;
							char queryk[4096];
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "insert into `"...sql_table_kill_log..."`");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "(");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "ServerID");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",SteamID_Attacker");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",SteamID_Victim");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",SteamID_Assister");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Timestamp");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",WeaponItemdef");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",WeaponClassname");
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Domination");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Revenge");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Airshot");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Headshot");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Noscope");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Backstab");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",TauntFrag");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",GibFrag");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",DeflectFrag");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",TeleFrag");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Collateral");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",MidAirFrag");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",CritFrag");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",MiniCritFrag");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",PumpkinBombFrag");
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",MiniSentryFrag");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",SentryFrag");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",SentryLVLFrag");
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",Ubercharged");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",VaccinatorTypeUsed");
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",StunnedType");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",CoatedType");
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ")");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "values");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "(");
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, "%i", g_ServerID);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%s'", g_Player[client].auth);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%s'", list_steamid_victim[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%s'", list_steamid_assister);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_timestamp[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_weaponitemdef[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%s'", list_classname[i]);
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_domination[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_revenge[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_airshot[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_headshot[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_noscope[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_backstab[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_tauntfrag[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_gibfrag[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_deflectfrag[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_telefrag[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_collateral[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_midairfrag[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_critfrag[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_minicritfrag[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_pumpkinbombfrag[i]);
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_minisentryfrag[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_sentryfrag[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_sentrylvlfrag[i]);
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_ubercharged[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_vaccinatortypeused[i]);
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_stunnedtype[i]);
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ",'%i'", list_coatedtype[i]);
							
							lenk += Format(queryk[lenk], sizeof(queryk)-lenk, ")");
							
							txn.AddQuery(queryk);
						}
					}
					
					//
					
					sql.Execute(txn, _, TXNEvent_OnFailed, attacker);
					
					//
					
					// translation, separated instead.
					if(points >= 1 && g_Player[client].bShowFragMsg)
					{
						PrepareFragMessage(client, dummy, points, frags);
					}
					
					if(g_Player[client].active_page_session > 0)
					{
						StatsMenu.Session(client, g_Player[client].active_page_session);
					}
				}
			}
			
			if(!!g_Game[client].aObjectPlaced)
			{
				int objects = 0;
				if((objects = g_Game[client].aObjectPlaced.Length) > 0)
				{
					int points = 0;
					int buildings;
					int sentryguns;
					int dispensers;
					int minisentryguns;
					int teleporterentrances;
					int teleporterexits;
					int sappers;
					any[] list = new any[objects];
					for(int i = 0; i < objects; i++)
					{
						TFBuilding obj = g_Game[client].aObjectPlaced.Get(i);
						list[i++] = obj;
						
						switch(obj)
						{
							case TFBuilding_Sentrygun:
							{
								g_Player[client].session[Stats_SentryGunsPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								sentryguns++;
								buildings++;
							}
							
							case TFBuilding_Dispenser:
							{
								g_Player[client].session[Stats_DispensersPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								dispensers++;
								buildings++;
							}
							
							case TFBuilding_MiniSentry:
							{
								g_Player[client].session[Stats_MiniSentryGunsPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								minisentryguns++;
								buildings++;
							}
							
							case TFBuilding_Teleporter_Entrance:
							{
								g_Player[client].session[Stats_TeleporterEntrancesPlaced] += objects;
								g_Player[client].session[Stats_TeleportersPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								teleporterentrances++;
								buildings++;
							}
							
							case TFBuilding_Teleporter_Exit:
							{
								g_Player[client].session[Stats_TeleporterExitsPlaced] += objects;
								g_Player[client].session[Stats_TeleportersPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								teleporterexits++;
								buildings++;
							}
							
							case TFBuilding_Sapper:
							{
								g_Player[client].session[Stats_SappersPlaced] += objects;
								sappers++;
							}
						}
						
						g_Game[client].bObjectPlaced[obj] = true;
						
						int _points;
						if((_points = g_Object_Placed[obj].IntValue) > 0)
						{
							points += _points;
						}
					}
					
					g_Game[client].aObjectPlaced.Clear();
					Transaction txn = new Transaction();
					
					char query[4096], query_map[4096];
					int len = 0, len_map = 0;
					len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set BuildingsPlaced = BuildingsPlaced+%i", buildings);
					len_map += Format(query_map[len_map], sizeof(query_map)-len_map, "update `"...sql_table_maps_log..."` set BuildingsPlaced = BuildingsPlaced+%i", buildings);
					if(sentryguns > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", SentryGunsPlaced = SentryGunsPlaced+%i", sentryguns);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SentryGunsPlaced = SentryGunsPlaced+%i", sentryguns);
					}
					if(dispensers > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", DispensersPlaced = DispensersPlaced+%i", dispensers);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", DispensersPlaced = DispensersPlaced+%i", dispensers);
					}
					if(minisentryguns > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", MiniSentryGunsPlaced = MiniSentryGunsPlaced+%i", minisentryguns);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", MiniSentryGunsPlaced = MiniSentryGunsPlaced+%i", minisentryguns);
					}
					if(teleporterentrances > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", TeleporterEntrancesPlaced = TeleporterEntrancesPlaced+%i", teleporterentrances);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", TeleporterEntrancesPlaced = TeleporterEntrancesPlaced+%i", teleporterentrances);
					}
					if(teleporterexits > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", TeleporterExitsPlaced = TeleporterExitsPlaced+%i", teleporterexits);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", TeleporterExitsPlaced = TeleporterExitsPlaced+%i", teleporterexits);
					}
					if(sappers > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", SappersPlaced = SappersPlaced+%i", sappers);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SappersPlaced = SappersPlaced+%i", sappers);
					}
					if(points > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
						
						g_Player[client].session[Stats_Points] += points;
						g_Player[client].points += points;
					}
					
					len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
					len_map += Format(query_map[len_map], sizeof(query_map)-len_map, " where ServerID = %i", g_ServerID);
					txn.AddQuery(query, queryId_object_placed);
					txn.AddQuery(query_map, queryId_object_placed_MapUpdate);
					sql.Execute(txn, _, TXNEvent_OnFailed, GetClientUserId(client));
					
					DataPack pack;
					CreateDataTimer(g_Time_ObjectPlaced, Timer_bObjectPlaced, pack);
					pack.WriteCell(GetClientUserId(client));
					pack.WriteCell(objects);
					pack.WriteCellArray(list, objects);
					pack.Reset();
					
					// if translation is invalid, it wont stop middle of query, breaking the plugin.
					if(points > 0 && !g_Player[client].bPenalty)
					{
						char dummy[255], phrase[64], points_plural[32];
						GetMultipleObjects(client, list, objects, dummy, sizeof(dummy));
						Format(phrase, sizeof(phrase), "%T{default}", "#SMStats_ObjectEvent_Type0", client);
						PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
						
						CPrintToChat(client, "%s %T"
						, g_ChatTag
						, "#SMStats_ObjectEvent_Default", client
						, g_Player[client].name
						, g_Player[client].points-points
						, points_plural
						, phrase
						, dummy);
					}
				}
			}
			
			if(!!g_Game[client].aObjectDestroyed)
			{
				int objects = 0;
				if((objects = g_Game[client].aObjectDestroyed.Length) > 0)
				{
					int points = 0;
					int buildings;
					int sentryguns;
					int dispensers;
					int minisentryguns;
					int teleporterentrances;
					int teleporterexits;
					int sappers;
					any[] list = new any[objects];
					for(int i = 0; i < objects; i++)
					{
						TFBuilding obj = g_Game[client].aObjectDestroyed.Get(i);
						list[i++] = obj;
						
						switch(obj)
						{
							case TFBuilding_Sentrygun:
							{
								g_Player[client].session[Stats_SentryGunsPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								sentryguns++;
								buildings++;
							}
							
							case TFBuilding_Dispenser:
							{
								g_Player[client].session[Stats_DispensersPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								dispensers++;
								buildings++;
							}
							
							case TFBuilding_MiniSentry:
							{
								g_Player[client].session[Stats_MiniSentryGunsPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								minisentryguns++;
								buildings++;
							}
							
							case TFBuilding_Teleporter_Entrance:
							{
								g_Player[client].session[Stats_TeleporterEntrancesPlaced] += objects;
								g_Player[client].session[Stats_TeleportersPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								teleporterentrances++;
								buildings++;
							}
							
							case TFBuilding_Teleporter_Exit:
							{
								g_Player[client].session[Stats_TeleporterExitsPlaced] += objects;
								g_Player[client].session[Stats_TeleportersPlaced] += objects;
								g_Player[client].session[Stats_BuildingsPlaced] += objects;
								teleporterexits++;
								buildings++;
							}
							
							case TFBuilding_Sapper:
							{
								g_Player[client].session[Stats_SappersPlaced] += objects;
								sappers++;
							}
						}
						
						g_Game[client].bObjectDestroyed[obj] = true;
						
						int _points;
						if((_points = g_Object_Destroyed[obj].IntValue) > 0)
						{
							points += _points;
						}
					}
					
					g_Game[client].aObjectDestroyed.Clear();
					Transaction txn = new Transaction();
					
					char query[4096], query_map[4096];
					int len = 0, len_map = 0;
					len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set BuildingsDestroyed = BuildingsDestroyed+%i", buildings);
					len_map += Format(query_map[len_map], sizeof(query_map)-len_map, "update `"...sql_table_maps_log..."` set BuildingsDestroyed = BuildingsDestroyed+%i", buildings);
					if(sentryguns > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", SentryGunsDestroyed = SentryGunsDestroyed+%i", sentryguns);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SentryGunsDestroyed = SentryGunsDestroyed+%i", sentryguns);
					}
					if(dispensers > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", DispensersDestroyed = DispensersDestroyed+%i", dispensers);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", DispensersDestroyed = DispensersDestroyed+%i", dispensers);
					}
					if(minisentryguns > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", MiniSentryGunsDestroyed = MiniSentryGunsDestroyed+%i", minisentryguns);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", MiniSentryGunsDestroyed = MiniSentryGunsDestroyed+%i", minisentryguns);
					}
					if(teleporterentrances > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", TeleporterEntrancesDestroyed = TeleporterEntrancesDestroyed+%i", teleporterentrances);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", TeleporterEntrancesDestroyed = TeleporterEntrancesDestroyed+%i", teleporterentrances);
					}
					if(teleporterexits > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", TeleporterExitsDestroyed = TeleporterExitsDestroyed+%i", teleporterexits);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", TeleporterExitsDestroyed = TeleporterExitsDestroyed+%i", teleporterexits);
					}
					if(sappers > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", SappersDestroyed = SappersDestroyed+%i", sappers);
						len_map += Format(query_map[len_map], sizeof(query_map)-len_map, ", SappersDestroyed = SappersDestroyed+%i", sappers);
					}
					if(points > 0)
					{
						len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
						
						g_Player[client].session[Stats_Points] += points;
						g_Player[client].points += points;
					}
					
					len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
					len_map += Format(query_map[len_map], sizeof(query_map)-len_map, " where ServerID = %i", g_ServerID);
					txn.AddQuery(query, queryId_object_destroyed);
					txn.AddQuery(query_map, queryId_object_destroyed_MapUpdate);
					sql.Execute(txn, _, TXNEvent_OnFailed, GetClientUserId(client));
					
					DataPack pack;
					CreateDataTimer(g_Time_ObjectDestroyed, Timer_bObjectDestroyed, pack);
					pack.WriteCell(GetClientUserId(client));
					pack.WriteCell(objects);
					pack.WriteCellArray(list, objects);
					pack.Reset();
					
					if(points > 0 && !g_Player[client].bPenalty)
					{
						char dummy[256], phrase[64], points_plural[32];
						GetMultipleObjects(client, list, objects, dummy, sizeof(dummy));
						Format(phrase, sizeof(phrase), "%T{default}", "#SMStats_ObjectEvent_Type1", client);
						PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
						
						CPrintToChat(client, "%s %T"
						, g_ChatTag
						, "#SMStats_ObjectEvent_Default", client
						, g_Player[client].name
						, g_Player[client].points-points
						, points_plural
						, phrase
						, dummy);
					}
				}
			}
			
			if(!!g_Game[client].aJarEvent)
			{
				int jars = 0;
				if((jars = g_Game[client].aJarEvent.Length) > 0)
				{
					int[] list = new int[jars];
					int iType;
					for(int i = 0; i < jars; i++)
					{
						int array[2];
						g_Game[client].aJarEvent.GetArray(i, array, sizeof(array));
						list[i++] = array[0];
						iType = array[1];
					}
					
					g_Game[client].aJarEvent.Clear();
					
					char dummy[255];
					GetMultipleTargets(client, list, jars, dummy, sizeof(dummy));
					
					g_Player[client].session[Stats_Coated] += jars;
					
					int points = 0;
					switch(iType)
					{
						// Coated with piss
						case 1:
						{
							g_Player[client].session[Stats_CoatedPiss] += jars;
							
							if(!g_Game[client].bPlayerJarated)
							{
								int len;
								char query[256];
								len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set Coated = Coated+%i", jars);
								if((points = g_Jarated.IntValue * jars) > 0 && !g_Player[client].bPenalty)
								{
									len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
									g_Player[client].session[Stats_Points] += points;
									g_Player[client].points += points;
								}
								len += Format(query[len], sizeof(query)-len, ", CoatedPiss = CoatedPiss+%i", jars);
								len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
								sql.Query(DBQuery_Callback, query, query_error_uniqueid_OnPlayerJarated);
								
								g_Game[client].bPlayerJarated = true;
								CreateTimer(g_Time_PlayerJarated, Timer_bPlayerJarated, g_Player[client].userid);
								
								if(points > 0 && !g_Player[client].bPenalty)
								{
									char points_plural[32];
									PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
									
									CPrintToChat(client, "%s %T"
									, g_ChatTag
									, "#SMStats_Player_CoatedPiss", client
									, g_Player[client].name
									, g_Player[client].points-points
									, points_plural
									, dummy);
								}
							}
						}
						// Coated with milk
						case 2:
						{
							g_Player[client].session[Stats_CoatedMilk] += jars;
							
							if(!g_Game[client].bPlayerMilked)
							{
								int len;
								char query[256];
								len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set Coated = Coated+%i", jars);
								if((points = g_Milked.IntValue * jars) > 0 && !g_Player[client].bPenalty)
								{
									len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
									g_Player[client].session[Stats_Points] += points;
									g_Player[client].points += points;
								}
								len += Format(query[len], sizeof(query)-len, ", CoatedMilk = CoatedMilk+%i", jars);
								len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
								sql.Query(DBQuery_Callback, query, query_error_uniqueid_OnPlayerMilked);
								
								g_Game[client].bPlayerMilked = true;
								CreateTimer(g_Time_PlayerMilked, Timer_bPlayerMilked, g_Player[client].userid);
								
								if(points > 0 && !g_Player[client].bPenalty)
								{
									char points_plural[32];
									PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
									
									CPrintToChat(client, "%s %T"
									, g_ChatTag
									, "#SMStats_Player_CoatedMilk", client
									, g_Player[client].name
									, g_Player[client].points-points
									, points_plural
									, dummy);
								}
							}
						}
						// Coated with gasoline
						case 3:
						{
							g_Player[client].session[Stats_CoatedGasoline] += jars;
							
							if(!g_Game[client].bPlayerGasPassed)
							{
								int len;
								char query[256];
								len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set Coated = Coated+%i", jars);
								if((points = g_GasPassed.IntValue * jars) > 0 && !g_Player[client].bPenalty)
								{
									len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
									g_Player[client].session[Stats_Points] += points;
									g_Player[client].points += points;
								}
								len += Format(query[len], sizeof(query)-len, ", CoatedGasoline = CoatedGasoline+%i", jars);
								len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
								sql.Query(DBQuery_Callback, query, query_error_uniqueid_OnPlayerGasPassed);
								
								g_Game[client].bPlayerGasPassed = true;
								CreateTimer(g_Time_PlayerGasPassed, Timer_bPlayerGasPassed, g_Player[client].userid);
								
								if(points > 0 && !g_Player[client].bPenalty)
								{
									char points_plural[32];
									PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
									
									CPrintToChat(client, "%s %T"
									, g_ChatTag
									, "#SMStats_Player_CoatedGasoline", client
									, g_Player[client].name
									, g_Player[client].points-points
									, points_plural
									, dummy);
								}
							}
						}
					}
				}
			}
			
			if(!!g_Game[client].aExtEvent)
			{
				int exts = 0;
				if((exts = g_Game[client].aExtEvent.Length) > 0)
				{
					int[] list = new int[exts];
					for(int i = 0; i < exts; i++)
					{
						int userid = g_Game[client].aExtEvent.Get(i);
						list[i++] = userid;
					}
					
					g_Game[client].aExtEvent.Clear();
					
					char dummy[255];
					GetMultipleTargets(client, list, exts, dummy, sizeof(dummy));
					
					g_Player[client].session[Stats_Extinguished] += exts;
					
					if(!g_Game[client].bExtEvent)
					{
						int points;
						int len;
						char query[256];
						len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set Extinguished = Extinguished+%i", exts);
						if((points = g_Extinguished.IntValue * exts) > 0 && !g_Player[client].bPenalty)
						{
							len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
							g_Player[client].session[Stats_Points] += points;
							g_Player[client].points += points;
						}
						len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
						sql.Query(DBQuery_Callback, query, query_error_uniqueid_OnPlayerExtinguished);
						
						g_Game[client].bExtEvent = true;
						CreateTimer(g_Time_ExtEvent, Timer_bExtEvent, GetClientUserId(client));
						
						if(points > 0 && !g_Player[client].bPenalty)
						{
							char points_plural[32];
							PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
							
							CPrintToChat(client, "%s %T"
							, g_ChatTag
							, "#SMStats_Player_Extinguished", client
							, g_Player[client].name
							, g_Player[client].points-points
							, points_plural
							, dummy);
						}
					}
				}
			}
			
			int robots = 0;
			if((robots = g_Game[client].iRobotFragEvent) > 0)
			{
				g_Game[client].iRobotFragEvent = -1;
				
				g_Player[client].session[Stats_RobotsFragged] += robots;
				
				int points;
				int len;
				char query[256];
				len += Format(query[len], sizeof(query)-len, "update `"...sql_table_playerlist..."` set RobotsFragged = RobotsFragged+%i", robots);
				if((points = g_MvM[MvM_FragRobot].IntValue * robots) > 0 && !g_Player[client].bPenalty)
				{
					len += Format(query[len], sizeof(query)-len, ", Points = Points+%i", points);
					g_Player[client].session[Stats_Points] += points;
					g_Player[client].points += points;
				}
				len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[client].auth, g_ServerID);
				sql.Query(DBQuery_Callback, query, query_error_uniqueid_OnRobotsFragged);
				
				if(points > 0 && !g_Player[client].bPenalty)
				{
					char points_plural[32], counter[12];
					PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
					if(robots >= 2)
					{
						Format(counter, sizeof(counter), " %T", "#SMStats_FragCounter", client, robots);
					}
					
					CPrintToChat(client, "%s %T%s"
					, g_ChatTag
					, "#SMStats_MvM_Player_FragRobot", client
					, g_Player[client].name
					, g_Player[client].points
					, points_plural
					, counter);
				}
			}
		}
	}
	
	return Plugin_Continue;
}

// timers

Action Timer_bObjectPlaced(Handle timer, DataPack pack)
{
	int userid = pack.ReadCell();
	int objects = pack.ReadCell();
	any[] list = new any[objects];
	pack.ReadCellArray(list, objects);
	
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		for(int i = 0; i < objects; i++)
		{
			TFBuilding obj = list[i];
			g_Game[client].bObjectPlaced[obj] = false;
		}
	}
	
	return Plugin_Continue;
}
Action Timer_bObjectDestroyed(Handle timer, DataPack pack)
{
	int userid = pack.ReadCell();
	int objects = pack.ReadCell();
	any[] list = new any[objects];
	pack.ReadCellArray(list, objects);
	
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		for(int i = 0; i < objects; i++)
		{
			TFBuilding obj = list[i];
			g_Game[client].bObjectDestroyed[obj] = false;
		}
	}
	
	return Plugin_Continue;
}
Action Timer_bUbercharged(Handle timer, int userid)
{
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		g_Game[client].bUbercharged = false;
	}
	
	return Plugin_Continue;
}
Action Timer_bUsedTeleporter(Handle timer, int userid)
{
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		g_Game[client].bUsedTeleporter = false;
	}
	
	return Plugin_Continue;
}
Action Timer_bPlayerUsedTeleporter(Handle timer, int userid)
{
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		g_Game[client].bPlayerUsedTeleporter = false;
	}
	
	return Plugin_Continue;
}
Action Timer_bStolenSandvich(Handle timer, int userid)
{
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		g_Game[client].bStunned = false;
	}
	
	return Plugin_Continue;
}
Action Timer_bStunned(Handle timer, int userid)
{
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		g_Game[client].bStunned = false;
	}
	
	return Plugin_Continue;
}
Action Timer_bPassBallEvent(Handle timer, DataPack pack)
{
	int userid = pack.ReadCell();
	int type = pack.ReadCell();
	
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		g_Game[client].bPassBallEvent[type] = false;
	}
	
	return Plugin_Continue;
}
Action Timer_bPlayerJarated(Handle timer, int userid)
{
	int client = 0;
	if((IsValidClient((client = GetClientOfUserId(userid)))))
	{
		g_Game[client].bPlayerJarated = false;
	}
	
	return Plugin_Continue;
}
Action Timer_bPlayerMilked(Handle timer, int userid)
{
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		g_Game[client].bPlayerMilked = false;
	}
	
	return Plugin_Continue;
}
Action Timer_bPlayerGasPassed(Handle timer, int userid)
{
	int client = 0;
	if((IsValidClient((client = GetClientOfUserId(userid)))))
	{
		g_Game[client].bPlayerGasPassed = false;
	}
	
	return Plugin_Continue;
}
Action Timer_bExtEvent(Handle timer, int userid)
{
	int client = 0;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		g_Game[client].bExtEvent = false;
	}
	
	return Plugin_Continue;
}

//

void OnClientDisconnect_Post_Game(int client)
{
	SMStatsInfo.ResetGameStats(client);
	g_Game[client].Reset();
}