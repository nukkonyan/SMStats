#if defined _sm_stats_included
	pragma error SM Stats already included
#endif

#define _sm_stats_included

#define _sm_stats_db "sm_stats"
#define _sm_stats_default_points 1000

enum SMStats_Type
{
	Stats_PlayTime = 0,
	Stats_Points = 1,
	Stats_Frags = 2,
	Stats_Deaths = 3,
	Stats_Suicides = 4,
	Stats_Assists = 5,
	Stats_DamageDone = 6,
	Stats_Achievements = 7,
	
	/* generic */
	Stats_Dominations = 8,
	Stats_Revenges = 9,
	Stats_Headshots = 10,
	Stats_Noscopes = 11,
	Stats_Collaterals = 12,
	Stats_MidAirFrags = 13,
	Stats_GrenadeFrags = 14,
	
	/* TF2 */
	Stats_ScoutFrags = 15,
	Stats_SoldierFrags = 16,
	Stats_PyroFrags = 17,
	Stats_DemoFrags = 18,
	Stats_HeavyFrags = 19,
	Stats_EngieFrags = 20,
	Stats_MedicFrags = 21,
	Stats_SniperFrags = 22,
	Stats_SpyFrags = 23,
	Stats_CivilianFrags = 24, /* TF2 classic */
	
	Stats_ScoutDeaths = 25,
	Stats_SoldierDeaths = 26,
	Stats_PyroDeaths = 27,
	Stats_DemoDeaths = 28,
	Stats_HeavyDeaths = 29,
	Stats_EngieDeaths = 30,
	Stats_MedicDeaths = 31,
	Stats_SniperDeaths = 32,
	Stats_SpyDeaths = 33,
	Stats_CivilianDeaths = 34, /* TF2 classic */
	
	Stats_Airshots = 35,
	Stats_Backstabs = 36,
	Stats_TauntFrags = 37,
	Stats_GibFrags = 38,
	Stats_Deflects = 39,
	Stats_Ubercharged = 40,
	Stats_SandvichesStolen = 41,
	Stats_Coated = 42,
	Stats_Extinguished = 43,
	Stats_TeleFrags = 44,
	
	Stats_SentryFrags = 45,
	Stats_MiniSentryFrags = 46,
	Stats_SentryLVL1Frags = 47,
	Stats_SentryLVL2Frags = 48,
	Stats_SentryLVL3Frags = 49,
	
	Stats_MiniCritFrags = 50,
	Stats_CritFrags = 51,
	
	Stats_PointsCaptured = 52,
	Stats_PointsDefended = 53,
	
	Stats_FlagsStolen = 54,
	Stats_FlagsPickedUp = 55,
	Stats_FlagsCaptured = 56,
	Stats_FlagsDefended = 57,
	Stats_FlagsDropped = 58,
	
	Stats_PassBallsGotten = 59,
	Stats_PassBallsScored = 60,
	Stats_PassBallsDropped = 61,
	Stats_PassBallsCatched = 62,
	Stats_PassBallsStolen = 63,
	Stats_PassBallsBlocked = 64,
	
	Stats_BuildingsPlaced = 65,
	Stats_SentryGunsPlaced = 66,
	Stats_DispensersPlaced = 67,
	Stats_MiniSentryGunsPlaced = 68,
	Stats_TeleporterEntrancesPlaced = 69,
	Stats_TeleporterExitsPlaced = 70,
	Stats_TeleportersPlaced = 71,
	Stats_SappersPlaced = 72,
	
	Stats_BuildingsDestroyed = 73,
	Stats_SentryGunsDestroyed = 74,
	Stats_DispensersDestroyed = 75,
	Stats_MiniSentryGunsDestroyed = 76,
	Stats_TeleporterEntrancesDestroyed = 77,
	Stats_TeleporterExitsDestroyed = 78,
	Stats_TeleportersDestroyed = 79,
	Stats_SappersDestroyed = 80,
	
	Stats_TeleportersUsed = 81,
	Stats_PlayersTeleported = 82,
	
	Stats_StunnedPlayers = 83,
	Stats_MoonShotStunnedPlayers = 84,
	
	Stats_MonoculusFragged = 85,
	Stats_MerasmusFragged = 86,
	Stats_HHHFragged = 87,
	Stats_SkeletonKingsFragged = 88,
	Stats_MonoculusStunned = 89,
	Stats_MerasmusStunned = 90,
	
	Stats_CoatedMilk = 91,
	Stats_CoatedPiss = 92,
	Stats_Ignited = 93,
	
	/* TF2 MvM */
	Stats_PumpkinBombFrags = 94,
	Stats_TanksDestroyed = 95,
	Stats_RobotsFragged = 96,
	Stats_SentryBustersFragged = 97,
	Stats_BombsResetted = 98,
	
	/* CS:GO */
	Stats_BlindedFrags = 99,
	Stats_ThroughSmokeFrags = 100,
	Stats_Wipes = 101,
	Stats_ChickenFrags = 102,
	
	/* counter-strike overall */
	Stats_MVPs = 103,
	Stats_BombsPlanted = 104,
	Stats_BombsDefused = 105,
	Stats_BombsExploded = 106,
	Stats_BombFrags = 107,
	Stats_MoneySpent = 108,
	Stats_FlashedOpponents = 109,
	Stats_KnifeFrags = 110,
	Stats_HostagesRescued = 111,
	Stats_HostagesFragged = 112,
}
#define SMStats_StatsSize 113
enum SMStatsUpdatedFwdType
{
	SMStatsUpdated_ChatTag = 0,
	SMStatsUpdated_ServerID = 1,
	SMStatsUpdated_AllowBots = 2,
	SMStatsUpdated_AllowAbuse = 3,
	SMStatsUpdated_AllowWarmup = 4,
	SMStatsUpdated_DisableAfterRoundEnd = 5,
	SMStatsUpdated_MinPlayers = 6,
	SMStatsUpdated_DeathPoints = 7,
	SMStatsUpdated_AssistPoints = 8,
	SMStatsUpdated_PenaltySeconds = 9,
}

typeset SMStats_Callback
{
	function void (int client, int value, SMStats_Type type);
	function void (int client, bool value, SMStats_Type type);
	function void (int client, int value);
	function void (int client, bool value);
	function void (int client);
	function void ();
}

methodmap SMStats __nullable__
{
	/*
	 * Returns the players session
	 *
	 * native bound to SMStats game addon (sm_stats_tf2, sm_stats_csgo, etc)
	 */
	public static native void GetPlayerSessionInfo(int client, SMStats_Type type, SMStats_Callback callback);
	
	public static bool IsLoaded()
	{
		return LibraryExists("SMStats");
	}
}

/*
 *	SourceMod Stats
 *	Called as soon as player frags enemies.
 *
 *	@param	attacker	The userid of the attacking player.
 *	@param	frags		The frag count.
 *	@param	userids		An array of userids that died by the attacking player.
 *	@param	assisters	An array of userids that assisted the attacking player.
 *	@param	classname	The classname of the weapon used by the attacking player. 
 *	@param	itemdef		An array of item definition index of the weapon used by the attacking player. By default -1 if not supported by game mod.
 *
 *	@return;
 */
forward void SMStats_OnPlayerDeath(int attacker, int frags, int[] userids, int[] assisters, const char[] classname, int[] itemdef);

/* ====================================================== */

public SharedPlugin __pl_sm_stats =
{
	name = "SMStats",
	file = "sm_stats.smx",
#if defined REQUIRE_PLUGIN
	required = 1
#else
	required = 0
#endif
}

#if !defined REQUIRE_PLUGIN
public void __pl_sm_stats_SetNTVOptional()
{
	MarkNativeAsOptional("SMStats.GetPlayerSessionInfo");
}
#endif