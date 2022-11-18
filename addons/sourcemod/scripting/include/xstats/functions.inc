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
	SessionType_ScoutKills,
	SessionType_SoldierKills,
	SessionType_PyroKills,
	SessionType_DemoKills,
	SessionType_HeavyKills,
	SessionType_EngieKills,
	SessionType_MedicKills,
	SessionType_SniperKills,
	SessionType_SpyKills,
	SessionType_CivilianKills, /* TF2 Classic */
	SessionType_ScoutDeaths,
	SessionType_SoldierDeaths,
	SessionType_PyroDeaths,
	SessionType_DemoDeaths,
	SessionType_HeavyDeaths,
	SessionType_EngieDeaths,
	SessionType_MedicDeaths,
	SessionType_SniperDeaths,
	SessionType_SpyDeaths,
	SessionType_CivilianDeaths, /* TF2 Classic */
	SessionType_Airshots,
	SessionType_Backstabs,
	SessionType_Tauntkills,
	SessionType_Gibs,
	SessionType_Deflects,
	SessionType_Ubercharged,
	SessionType_SandvichesStolen,
	SessionType_Coated,
	SessionType_Extinguished,
	SessionType_Telefrags,
	SessionType_Sentrykills,
	SessionType_MiniSentrykills,
	SessionType_MiniCritkills,
	SessionType_Critkills,
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
	
	/*	Add and remove session points. Just to make it easier :) */
	void AddPoints(int value) { this.Points += value; }
	void RemovePoints(int value) { this.Points -= value; }
	
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
	int ScoutKills;
	int SoldierKills;
	int PyroKills;
	int DemoKills;
	int HeavyKills;
	int EngieKills;
	int MedicKills;
	int SniperKills;
	int SpyKills;
	int CivilianKills; /* TF2 Classic */
	
	int ScoutDeaths;
	int SoldierDeaths;
	int PyroDeaths;
	int DemoDeaths;
	int HeavyDeaths;
	int EngieDeaths;
	int MedicDeaths;
	int SniperDeaths;
	int SpyDeaths;
	int CivilianDeaths; /* TF2 Classic */
	
	int Backstabs;
	int Tauntkills;
	int Gibs;
	int Deflects;
	int Ubercharged;
	int SandvichesStolen;
	int Coated;
	int Extinguished;
	int Telefrags;
	
	int Sentrykills;
	int MiniSentrykills;
	int SentryLVL1Kills;
	int SentryLVL2Kills;
	int SentryLVL3Kills;
	
	int MiniCritkills;
	int Critkills;
	
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
	int TeleportersBuilt;
	int SappersPlaced;
	
	int TotalBuildingsDestroyed;
	int BuildingsDestroyed;
	int SentryGunsDestroyed;
	int DispensersDestroyed;
	int MiniSentryGunsDestroyed;
	int TeleporterEntrancesDestroyed;
	int TeleporterExitsDestroyed;
	int TeleportersDestroyed;
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
	int UserID;
	int AccountID;
	
	int Points;
	int Position;
	
	StringMapEx InvCallback;
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
	char weapons[64];
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
	ConVar Update;
	ConVar RemoveOldPlayers;
	ConVar Weapon[MaxTF2WeaponDefinitionIndex+1000]; //Temporary
	//ArrayList Weapons;
	
	void CreateTF2Weapon(int defindex, const char[] cvarname, int points, const char[] description)
	{
		int maxlen = StrLen(description)+96;
		char[] desc = new char[maxlen];
		Format(desc, maxlen, "XStats: TF2 - Points given when killing with %s.", desc);
		
		//I use constructed cvar instead of ArrayList or StringMap due to errors about invalid indexes.
		//ConVar cvar = CreateConVar(cvarname, dummy, description, _, true);
		//this.Weapons.Set(defindex, cvar);
		this.Weapon[defindex] = CreateConVarInt(cvarname, points, desc, _, true);
	}
	
	void CreateCSSWeapon(int defindex, const char[] cvarname, int points, char[] description)
	{
		int maxlen = StrLen(description)+96;
		char[] desc = new char[maxlen];
		Format(desc, maxlen, "XStats: CSS - Points given when killing with %s.", desc);
		
		this.Weapon[defindex] = CreateConVarInt(cvarname, points, desc, _, true);
	}
	
	void CreateCSGOWeapon(int defindex, const char[] cvarname, int points, char[] description)
	{
		int maxlen = StrLen(description)+96;
		char[] desc = new char[maxlen];
		Format(desc, maxlen, "XStats: CS:GO - Points given when killing with %s.", desc);
		
		this.Weapon[defindex] = CreateConVarInt(cvarname, points, desc, _, true);
	}
	
	void SameWeapon(int defindex1, int defindex2)
	{
		this.Weapon[defindex1] = this.Weapon[defindex2];
	}
	
	ConVar GetWeaponCvar(int defindex)
	{
		return this.Weapon[defindex];
	}
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