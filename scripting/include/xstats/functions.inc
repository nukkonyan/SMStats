enum XStats_SessionType {
	SessionType_PlayTime,
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

enum struct XStatsSession {
	/* Core */
	int PlayTime;
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
	int PointsCaptured;
	int PointsDefended;
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
	int TotalBuildingsDestroyed;
	int BuildingsDestroyed;
	int SentryGunsDestroyed;
	int DispensersDestroyed;
	int MiniSentryGunsDestroyed;
	int TeleporterEntrancesDestroyed;
	int TeleporterExitsDestroyed;
	int SappersDestroyed;
	int PlayerTeleported;
	int PlayersTeleported;
	int StunnedPlayers;
	int MoonShotStunnedPlayers;
	int KilledHHH;
	int KilledMonoculus;
	int KilledMerasmus;
	int KilledSkeletonKing;
	int StunnedMonoculus;
	int StunnedMerasmus;
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

enum struct XStatsKillMsg {
	bool Domination;
	bool Revenge;
	bool MidAirKill;
	bool SmokeKill;
	bool HeadshotKill;
	bool NoscopeKill;
	bool BackstabKill;
	bool AirshotKill;
	bool DeflectKill;
	bool TeleFragKill;
	bool TauntKill;
	bool CollateralKill;
	bool GrenadeKill;
	bool BombKill;
	bool BlindedKill;
}

enum struct XStatsPlayer {
	char SteamID[64];
	char Playername[64];
	char Name[64];
	char IP[16];
	char Country[96];
	
	int Points;
	int Position;
}

enum struct XStatsPanel {
	bool Main;
	bool Session;
	int TotalPage;
}

enum struct XStatsGlobal {
	GameIdentifier Game;
	char GameTitle[64];
	
	bool RoundActive;
	bool WarmupActive;
	bool RankActive;
	
	char Prefix[96];
	char logprefix[64];
	char playerlist[64];
	char kill_log[64];
	char item_found[64];
	char maps_log[64];
	char achievements[64];
	char CurrentMap[64];
	
	Handle UpdateTimer;
}

enum struct XStatsCvars {
	ConVar PluginActive;
	ConVar Debug;
	ConVar AllowBots;
	ConVar AllowWarmup;
	ConVar PrefixCvar;
	ConVar Death;
	ConVar AssistKill;
	ConVar ServerID;
	ConVar MinimumPlayers;
	ConVar DisableAfterWin;
	ConVar ConnectMsg;
	ConVar AntiAbuse;
	ConVar RemoveOldPlayers;
	ConVar Weapon[40000];
}

enum struct XStatsConnectSound {
	ConVar cvar;
	char path[64];
}

enum struct XStatsForwards {
	GlobalForward Prefix;
	GlobalForward Death;
	GlobalForward Suicide;	
	GlobalForward TF2_FlagEvent;
	
	PrivateForward GetStats;
}

enum struct XStatsDatabase {
	Database Threaded;
	Database Direct;
}

/**
 *	Kill scenario | Used for translations.
 *	The kill events will be merged together automatically.
 *	Example: Headshot whilst Mid-Air or Headshot Through Smoke whilst Mid-Air, etc.. (You get it)
 */
stock char Kill_Type[][] = {
	"Kill Event Type 0",	//Mid-Air.
	"Kill Event Type 1",	//Through Smoke.
	"Kill Event Type 2",	//Noscope Headshot.
	"Kill Event Type 3",	//Headshot.
	"Kill Event Type 4",	//Noscope.
	"Kill Event Type 5",	//Backstab.
	"Kill Event Type 6",	//Airshot.
	"Kill Event Type 7",	//Deflect Kill.
	"Kill Event Type 8",	//Telefrag.
	"Kill Event Type 9",	//Taunt Kill.
	"Kill Event Type 10",	//Collateral.
	"Kill Event Type 11",	//Grenade Kill.
	"Kill Event Type 12",	//Bomb Kill.
	"Kill Event Type 13",	//Blinded Kill.
};

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
		VFormat(buffer, sizeof(buffer), text, 3); /* 1 is the panel, 2 is the input, 3 is the parameters */
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