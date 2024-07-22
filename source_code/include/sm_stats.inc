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
	
	Stats_HealPoints = 35,
	
	Stats_Airshots = 36,
	Stats_Backstabs = 37,
	Stats_TauntFrags = 38,
	Stats_GibFrags = 39,
	Stats_Deflects = 40,
	Stats_Ubercharged = 41,
	Stats_SandvichesStolen = 42,
	Stats_Coated = 43,
	Stats_Extinguished = 44,
	Stats_TeleFrags = 45,
	
	Stats_SentryFrags = 46,
	Stats_MiniSentryFrags = 47,
	Stats_SentryLVL1Frags = 48,
	Stats_SentryLVL2Frags = 49,
	Stats_SentryLVL3Frags = 50,
	
	Stats_MiniCritFrags = 51,
	Stats_CritFrags = 52,
	
	Stats_PointsCaptured = 53,
	Stats_PointsDefended = 54,
	
	Stats_FlagsStolen = 55,
	Stats_FlagsPickedUp = 56,
	Stats_FlagsCaptured = 57,
	Stats_FlagsDefended = 58,
	Stats_FlagsDropped = 59,
	
	Stats_PassBallsGotten = 60,
	Stats_PassBallsScored = 61,
	Stats_PassBallsDropped = 62,
	Stats_PassBallsCatched = 63,
	Stats_PassBallsStolen = 64,
	Stats_PassBallsBlocked = 65,
	
	Stats_BuildingsPlaced = 66,
	Stats_SentryGunsPlaced = 67,
	Stats_DispensersPlaced = 68,
	Stats_MiniSentryGunsPlaced = 69,
	Stats_TeleporterEntrancesPlaced = 70,
	Stats_TeleporterExitsPlaced = 71,
	Stats_TeleportersPlaced = 72,
	Stats_SappersPlaced = 73,
	
	Stats_BuildingsDestroyed = 74,
	Stats_SentryGunsDestroyed = 75,
	Stats_DispensersDestroyed = 76,
	Stats_MiniSentryGunsDestroyed = 77,
	Stats_TeleporterEntrancesDestroyed = 78,
	Stats_TeleporterExitsDestroyed = 79,
	Stats_TeleportersDestroyed = 80,
	Stats_SappersDestroyed = 81,
	
	Stats_TeleportersUsed = 82,
	Stats_PlayersTeleported = 83,
	
	Stats_StunnedPlayers = 84,
	Stats_MoonShotStunnedPlayers = 85,
	
	Stats_MonoculusFragged = 86,
	Stats_MerasmusFragged = 87,
	Stats_HHHFragged = 88,
	Stats_SkeletonKingsFragged = 89,
	Stats_MonoculusStunned = 90,
	Stats_MerasmusStunned = 91,
	
	Stats_CoatedPiss = 92,
	Stats_CoatedMilk = 93,
	Stats_CoatedGasoline = 94,
	Stats_Ignited = 95,
	
	/* TF2 MvM */
	Stats_PumpkinBombFrags = 96,
	Stats_TanksDestroyed = 97,
	Stats_RobotsFragged = 98,
	Stats_SentryBustersFragged = 99,
	Stats_BombsResetted = 100,
	
	/* CS:GO */
	Stats_ThroughSmokeFrags = 101,
	Stats_Wipes = 102,
	Stats_ChickenFrags = 103,
	
	/* Counter-Strike overall */
	Stats_MVPs = 104,
	Stats_BombsPlanted = 105,
	Stats_BombsDefused = 106,
	Stats_BombsExploded = 107,
	Stats_BombFrags = 108,
	Stats_MoneySpent = 109,
	Stats_Blinded = 110,
	Stats_BlindedFrags = 111,
	Stats_BlindedOpponents = 112,
	Stats_KnifeFrags = 113,
	Stats_HostagesRescued = 114,
	Stats_HostagesFragged = 115,
	
	/* Other */
	Stats_BurnedFrags = 116,
	Stats_Hit_Head = 130,
	Stats_Hit_Shoulder = 131,
	Stats_Hit_LeftArm = 132,
	Stats_Hit_RightArm = 133,
	Stats_Hit_LeftHand = 134,
	Stats_Hit_RightHand = 135,
	Stats_Hit_LeftLeg = 136,
	Stats_Hit_RightLeg = 137,
	Stats_Hit_LeftKnee = 138,
	Stats_Hit_RightKnee = 139,
	Stats_Hit_LeftFeet = 140,
	Stats_Hit_RightFeet = 141,
}
#define SMStats_StatsSize 142
enum SMStatsUpdatedFwdType
{
	SMStatsUpdated_ChatTag = 0,
	SMStatsUpdated_StatsID = 1,
	SMStatsUpdated_AllowBots = 2,
	SMStatsUpdated_AllowAbuse = 3,
	SMStatsUpdated_AllowWarmup = 4,
	SMStatsUpdated_AllowTeamFrag = 5,
	SMStatsUpdated_DisableAfterRoundEnd = 6,
	SMStatsUpdated_MinPlayers = 7,
	SMStatsUpdated_DeathPoints = 8,
	SMStatsUpdated_TeamFragPoints = 9,
	SMStatsUpdated_AssistPoints = 10,
	SMStatsUpdated_PenaltySeconds = 11,
	SMStatsUpdated_SndConnectedTop10 = 12,
	SMStatsUpdated_SndConnectedTop1 = 13,
	SMStatsUpdated_SndConnectedGeneric = 14,
	SMStatsUpdated_Debug = 15,
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
 *	SourceMod Statistics.
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