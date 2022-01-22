enum	XStats_SessionType	{
	SessionType_Time,
	SessionType_Points,
	SessionType_Kills,
	SessionType_Deaths,
	SessionType_Suicides,
	SessionType_Assists,
	SessionType_DamageDone,
	
	/* Generic */
	SessionType_Dominations,
	SessionType_Revenges,
	SessionType_Headshots,
	SessionType_Noscopes,
	SessionType_Collaterals,
	SessionType_MidAirKills,
	SessionType_GrenadeKills,
	
	/* TF2 */
	SessionType_ScoutsKilled,
	SessionType_SoldiersKilled,
	SessionType_PyrosKilled,
	SessionType_DemosKilled,
	SessionType_HeaviesKilled,
	SessionType_EngiesKilled,
	SessionType_MedicsKilled,
	SessionType_SnipersKilled,
	SessionType_SpiesKilled,
	SessionType_CiviliansKilled, /* TF2 Classic */
	SessionType_Airshots,
	SessionType_Backstabs,
	SessionType_TauntKills,
	SessionType_GibKills,
	SessionType_DeflectKills,
	SessionType_Ubercharged,
	SessionType_SandvichesStolen,
	SessionType_Coated,
	SessionType_Extinguished,
	SessionType_TeleFrags,
	SessionType_SentryKills,
	SessionType_MiniSentryKills,
	SessionType_MiniCritKills,
	SessionType_CritKills,
	SessionType_FlagsStolen,
	SessionType_FlagsPickedUp,
	SessionType_FlagsCaptured,
	SessionType_FlagsDefended,
	SessionType_FlagsDropped,
	SessionType_PassBallsGotten,
	SessionType_PassBallsScored,
	SessionType_PassBallsDropped,
	SessionType_PassBallsCatched,
	SessionType_PassBallsStolen,
	SessionType_PassBallsBlocked,
	SessionType_BuildingsBuilt,
	SessionType_SentryGunsBuilt,
	SessionType_DispensersBuilt,
	SessionType_MiniSentryGunsBuilt,
	SessionType_TeleporterEntrancesBuilt,
	SessionType_TeleporterExitsBuilt,
	SessionType_SappersPlaced,
	SessionType_BuildingsDestroyed,
	SessionType_SentryGunsDestroyed,
	SessionType_DispensersDestroyed,
	SessionType_MiniSentryGunsDestroyed,
	SessionType_TeleporterEntrancesDestroyed,
	SessionType_TeleporterExitsDestroyed,
	SessionType_SappersDestroyed,
	SessionType_KilledHHH,
	SessionType_KilledMonoculus,
	SessionType_KilledMerasmus,
	SessionType_KilledSkeletonKing,
	SessionType_StunnedMonoculus,
	SessionType_MadMilked,
	SessionType_Jarated,
	SessionType_Ignited,
	
	/* TF2 MvM */
	SessionType_TanksDestroyed,
	SessionType_SentryBustersKilled,
	SessionType_BombsResetted,
	
	/* CS:GO */
	SessionType_BlindKills,
	SessionType_SmokeKills,
	SessionType_Wipes,
	SessionType_ChickenKills,
	
	/* Counter-Strike Overall */
	SessionType_MVPs,
	SessionType_BombsPlanted,
	SessionType_BombsDefused,
	SessionType_BombsExploded,
	SessionType_BombKills,
	SessionType_MoneySpent,
	SessionType_FlashedOpponents,
	SessionType_KnifeKills,
	SessionType_HostagesRescued,
	SessionType_HostagesKilled,
}

enum struct	XStatsSession	{
	int Time;
	int Points;
	int Kills;
	int Deaths;
	int Suicides;
	int Assists;
	int DamageDone;
	
	/* Generic */
	int Dominations;
	int Revenges;
	int Airshots;
	int Headshots;
	int Noscopes;
	int Collaterals;
	int MidAirKills;
	int GrenadeKills;
	
	/* TF2 */
	int ScoutsKilled;
	int SoldiersKilled;
	int PyrosKilled;
	int DemosKilled;
	int HeaviesKilled;
	int EngiesKilled;
	int MedicsKilled;
	int SnipersKilled;
	int SpiesKilled;
	int CiviliansKilled; /* TF2 Classic */
	int Backstabs;
	int TauntKills;
	int GibKills;
	int DeflectKills;
	int Ubercharged;
	int SandvichesStolen;
	int Coated;
	int Extinguished;
	int TeleFrags;
	int SentryKills;
	int MiniSentryKills;
	int MiniCritKills;
	int CritKills;
	int FlagsStolen;
	int FlagsPickedUp;
	int FlagsCaptured;
	int FlagsDefended;
	int FlagsDropped;
	int PassBallsGotten;
	int PassBallsScored;
	int PassBallsDropped;
	int PassBallsCatched;
	int PassBallsStolen;
	int PassBallsBlocked;
	int BuildingsBuilt;
	int SentryGunsBuilt;
	int DispensersBuilt;
	int MiniSentryGunsBuilt;
	int TeleporterEntrancesBuilt;
	int TeleporterExitsBuilt;
	int SappersPlaced;
	int BuildingsDestroyed;
	int SentryGunsDestroyed;
	int DispensersDestroyed;
	int MiniSentryGunsDestroyed;
	int TeleporterEntrancesDestroyed;
	int TeleporterExitsDestroyed;
	int SappersDestroyed;
	int KilledHHH;
	int KilledMonoculus;
	int KilledMerasmus;
	int KilledSkeletonKing;
	int StunnedMonoculus;
	int MadMilked;
	int Jarated;
	int Ignited;
	
	/* TF2 MvM */
	int TanksDestroyed;
	int SentryBustersKilled;
	int BombsResetted;
	
	/* CS:GO */
	int BlindKills;
	int SmokeKills;
	int Wipes;
	int ChickenKills;
	
	/* Counter-Strike Overall */
	int MVPs;
	int BombsPlanted;
	int BombsDefused;
	int BombsExploded;
	int BombKills;
	int MoneySpent;
	int FlashedOpponents;
	int KnifeKills;
	int HostagesRescued;
	int HostagesKilled;
}

enum struct XStatsKillMsg	{
	//bool Domination;
	//bool Revenge;
	
	bool MidAirKill;
	bool SmokeKill;
	bool HeadshotKill;
	bool NoscopeKill;
	bool BackstabKill;
	bool AirshotKill;
	bool DeflectKill;
	bool TeleFragKill;
	bool CollateralKill;
	bool GrenadeKill;
	bool BombKill;
	bool BlindedKill;
}

typeset XStatsSessionCallback
{
	function void (XStats_SessionType type, int client, int count);
	function void (XStats_SessionType type, int client);
}

/**
 *	Simplify the panel additions.
 */
enum	XStatsRankPanel	{
	XStatsRankPanel_Invalid = -1
}

methodmap XStatsRankPanel < Panel	{
	public XStatsRankPanel(Handle hStyle=null)	{
		return view_as<XStatsRankPanel>(new Panel(hStyle));
	}
	
	public bool SetTitle(const char[] text, any ...)	{
		char buffer[96];
		VFormat(buffer, sizeof(buffer), text, 3); /* 1 is the handle, 2 is the caller, 3 is the parameters */
		view_as<Panel>(this).SetTitle(buffer);
	}
	
	public bool DrawText(const char[] text, any ...)	{
		char buffer[96];
		VFormat(buffer, sizeof(buffer), text, 3);
		return view_as<Panel>(this).DrawText(buffer);
	}
	
	public int DrawItem(const char[] text, any ...)	{
		char buffer[96];
		VFormat(buffer, sizeof(buffer), text, 3);
		return view_as<Panel>(this).DrawItem(buffer);
	}
	
	public void Send(int client, MenuHandler handler, int time)	{
		view_as<Panel>(this).Send(client, handler, time);
	}
}