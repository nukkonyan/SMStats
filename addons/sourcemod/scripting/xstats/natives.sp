/**
 *	Prepare the natives.
 */
public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max) {
	RegPluginLibrary("XStats");
	
	CreateNative("XStats.GetPoints", Native_GetPoints);
	CreateNative("XStats.GetPlayTime", Native_GetPlayTime);
	CreateNative("XStats.GetSession", Native_GetSession);
	CreateNative("XStats.ClearSessions", Native_ClearSessions);
	CreateNative("XStats.GetPrefix", Native_GetPrefix);
	CreateNative("XStats.Enabled", Native_Enabled);
	CreateNative("XStats.Active", Native_Active);
	CreateNative("XStats.AllowBots", Native_AllowBots);
	CreateNative("XStats.Debug", Native_Debug);
}

// XStats.GetPoints(const char[] auth)
any Native_GetPoints(Handle plugin, int params) {
	int maxlen; GetNativeStringLength(1, maxlen);
	char[] auth = new char[maxlen];
	GetNativeString(1, auth, maxlen);
	return GetClientPoints(auth);
}

// XStats.GetPlayTime(const char[] auth)
any Native_GetPlayTime(Handle plugin, int params) {
	int maxlen = GetNativeStringLength(1, maxlen);
	char[] auth = new char[maxlen];
	GetNativeString(1, auth, maxlen);
	return GetClientPlayTime(auth);
}

// XStats.GetSession(int client, XStats_SessionType type, XStatsSessionCallback callback)
any Native_GetSession(Handle plugin, int params) {
	int client = GetNativeCell(1);
	XStats_SessionType type = GetNativeCell(2);
	Function func = GetNativeFunction(3);
	
	if(!Tklib_IsValidClient(client, true)) ThrowNativeError(SP_ERROR_NATIVE, "[XStats] Client index %i is invalid", client);
	
	int stats = 0;
	switch(type) {
		/* Stats */
		case SessionType_PlayTime: stats = Player[client].Session.PlayTime;
		case SessionType_Points: stats = Player[client].Session.Points;
		case SessionType_Kills: stats = Player[client].Session.Kills;
		case SessionType_Deaths: stats = Player[client].Session.Deaths;
		case SessionType_Suicides: stats = Player[client].Session.Suicides;
		case SessionType_Assists: stats = Player[client].Session.Assists;
		case SessionType_DamageDone: stats = Player[client].Session.DamageDone;
		
		/* Generic */
		case SessionType_Dominations: stats = Player[client].Session.Dominations;
		case SessionType_Revenges: stats = Player[client].Session.Revenges;
		case SessionType_Headshots: stats = Player[client].Session.Headshots;
		case SessionType_Noscopes: stats = Player[client].Session.Noscopes;
		case SessionType_Collaterals: stats = Player[client].Session.Collaterals;
		case SessionType_MidAirKills: stats = Player[client].Session.MidAirKills;
		case SessionType_GrenadeKills: stats = Player[client].Session.GrenadeKills;
		
		/* TF2 */
		case SessionType_ScoutKills: stats = Player[client].Session.ScoutKills;
		case SessionType_SoldierKills: stats = Player[client].Session.SoldierKills;
		case SessionType_PyroKills: stats = Player[client].Session.PyroKills;
		case SessionType_DemoKills: stats = Player[client].Session.DemoKills;
		case SessionType_HeavyKills: stats = Player[client].Session.HeavyKills;
		case SessionType_EngieKills: stats = Player[client].Session.EngieKills;
		case SessionType_MedicKills: stats = Player[client].Session.MedicKills;
		case SessionType_SniperKills: stats = Player[client].Session.SniperKills;
		case SessionType_SpyKills: stats = Player[client].Session.SpyKills;
		case SessionType_CivilianKills: stats = Player[client].Session.CivilianKills; /* TF2 Classic */
		
		case SessionType_ScoutDeaths: stats = Player[client].Session.ScoutDeaths;
		case SessionType_SoldierDeaths: stats = Player[client].Session.SoldierDeaths;
		case SessionType_PyroDeaths: stats = Player[client].Session.PyroDeaths;
		case SessionType_DemoDeaths: stats = Player[client].Session.DemoDeaths;
		case SessionType_HeavyDeaths: stats = Player[client].Session.HeavyDeaths;
		case SessionType_EngieDeaths: stats = Player[client].Session.EngieDeaths;
		case SessionType_MedicDeaths: stats = Player[client].Session.MedicDeaths;
		case SessionType_SniperDeaths: stats = Player[client].Session.SniperDeaths;
		case SessionType_SpyDeaths: stats = Player[client].Session.SpyDeaths;
		case SessionType_CivilianDeaths: stats = Player[client].Session.CivilianDeaths; /* TF2 Classic */
		
		case SessionType_Airshots: stats = Player[client].Session.Airshots;
		case SessionType_Backstabs: stats = Player[client].Session.Backstabs;
		case SessionType_Tauntkills: stats = Player[client].Session.Tauntkills;
		case SessionType_Gibs: stats = Player[client].Session.Gibs;
		case SessionType_Deflects: stats = Player[client].Session.Deflects;
		case SessionType_Ubercharged: stats = Player[client].Session.Ubercharged;
		case SessionType_SandvichesStolen: stats = Player[client].Session.SandvichesStolen;
		case SessionType_Coated: stats = Player[client].Session.Coated;
		case SessionType_Extinguished: stats = Player[client].Session.Extinguished;
		case SessionType_Telefrags: stats = Player[client].Session.Telefrags;
		
		case SessionType_Sentrykills: stats = Player[client].Session.Sentrykills;
		case SessionType_MiniSentrykills: stats = Player[client].Session.MiniSentrykills;
		case SessionType_SentryLVL1Kills: stats = Player[client].Session.SentryLVL1Kills;
		case SessionType_SentryLVL2Kills: stats = Player[client].Session.SentryLVL2Kills;
		case SessionType_SentryLVL3Kills: stats = Player[client].Session.SentryLVL3Kills;
		
		case SessionType_MiniCritkills: stats = Player[client].Session.MiniCritkills;
		case SessionType_Critkills: stats = Player[client].Session.Critkills;
		
		case SessionType_FlagsStolen: stats = Player[client].Session.FlagsStolen;
		case SessionType_FlagsPickedUp: stats = Player[client].Session.FlagsPickedUp;
		case SessionType_FlagsCaptured: stats = Player[client].Session.FlagsCaptured;
		case SessionType_FlagsDefended: stats = Player[client].Session.FlagsDefended;
		case SessionType_FlagsDropped: stats = Player[client].Session.FlagsDropped;
		
		case SessionType_PassBallsGotten: stats = Player[client].Session.PassBallsGotten;
		case SessionType_PassBallsScored: stats = Player[client].Session.PassBallsScored;
		case SessionType_PassBallsDropped: stats = Player[client].Session.PassBallsDropped;
		case SessionType_PassBallsCatched: stats = Player[client].Session.PassBallsCatched;
		case SessionType_PassBallsStolen: stats = Player[client].Session.PassBallsStolen;
		case SessionType_PassBallsBlocked: stats = Player[client].Session.PassBallsBlocked;
		
		case SessionType_BuildingsBuilt: stats = Player[client].Session.BuildingsBuilt;
		case SessionType_SentryGunsBuilt: stats = Player[client].Session.SentryGunsBuilt;
		case SessionType_DispensersBuilt: stats = Player[client].Session.DispensersBuilt;
		case SessionType_MiniSentryGunsBuilt: stats = Player[client].Session.MiniSentryGunsBuilt;
		case SessionType_TeleporterEntrancesBuilt: stats = Player[client].Session.TeleporterEntrancesBuilt;
		case SessionType_TeleporterExitsBuilt: stats = Player[client].Session.TeleporterExitsBuilt;
		case SessionType_TeleportersBuilt: stats = Player[client].Session.TeleportersBuilt;
		case SessionType_SappersPlaced: stats = Player[client].Session.SappersPlaced;
		
		case SessionType_BuildingsDestroyed: stats = Player[client].Session.BuildingsDestroyed;
		case SessionType_SentryGunsDestroyed: stats = Player[client].Session.SentryGunsDestroyed;
		case SessionType_DispensersDestroyed: stats = Player[client].Session.DispensersDestroyed;
		case SessionType_MiniSentryGunsDestroyed: stats = Player[client].Session.MiniSentryGunsDestroyed;
		case SessionType_TeleporterEntrancesDestroyed: stats = Player[client].Session.TeleporterEntrancesDestroyed;
		case SessionType_TeleporterExitsDestroyed: stats = Player[client].Session.TeleporterExitsDestroyed;
		case SessionType_TeleportersDestroyed: stats = Player[client].Session.TeleportersDestroyed;
		case SessionType_SappersDestroyed: stats = Player[client].Session.SappersDestroyed;
		
		case SessionType_KilledHHH: stats = Player[client].Session.KilledHHH;
		case SessionType_KilledMonoculus: stats = Player[client].Session.KilledMonoculus;
		case SessionType_KilledMerasmus: stats = Player[client].Session.KilledMerasmus;
		case SessionType_KilledSkeletonKing: stats = Player[client].Session.KilledSkeletonKing;
		case SessionType_StunnedMonoculus: stats = Player[client].Session.StunnedMonoculus;
		
		case SessionType_MadMilked: stats = Player[client].Session.MadMilked;
		case SessionType_Jarated: stats = Player[client].Session.Jarated;
		case SessionType_Ignited: stats = Player[client].Session.Ignited;
		
		/* TF2 MvM */
		case SessionType_TanksDestroyed: stats = Player[client].Session.TanksDestroyed;
		case SessionType_SentryBustersKilled: stats = Player[client].Session.SentryBustersKilled;
		case SessionType_BombsResetted: stats = Player[client].Session.BombsResetted;
		
		/* CS:GO */
		case SessionType_BlindKills: stats = Player[client].Session.BlindKills;
		case SessionType_SmokeKills: stats = Player[client].Session.SmokeKills;
		case SessionType_Wipes: stats = Player[client].Session.Wipes;
		case SessionType_ChickenKills: stats = Player[client].Session.ChickenKills;
		
		/* Counter-Strike Overall */
		case SessionType_MVPs: stats = Player[client].Session.MVPs;
		case SessionType_BombsPlanted: stats = Player[client].Session.BombsPlanted;
		case SessionType_BombsDefused: stats = Player[client].Session.BombsDefused;
		case SessionType_BombsExploded: stats = Player[client].Session.BombsExploded;
		case SessionType_BombKills: stats = Player[client].Session.BombKills;
		case SessionType_MoneySpent: stats = Player[client].Session.MoneySpent;
		case SessionType_KnifeKills: stats = Player[client].Session.KnifeKills;
	}
	
	Forward.GetStats.AddFunction(plugin, func);
	Call_StartForward(Forward.GetStats);
	Call_PushCell(type);
	Call_PushCell(client);
	Call_PushCell(stats);
	Call_Finish();
}

any Native_ClearSessions(Handle plugin, int params) {
	int client = GetNativeCell(1);
	Player[client].Session.Clear();
}
any Native_GetPrefix(Handle plugin, int params) {
	SetNativeString(1, Global.Prefix, GetNativeCell(2), GetNativeCell(3));
}
any Native_Enabled(Handle plugin, int params) { return Cvars.PluginActive.BoolValue; }
any Native_Active(Handle plugin, int params) { return Global.RankActive; }
any Native_AllowBots(Handle plugin, int params) { return Cvars.AllowBots.BoolValue; }
any Native_Debug(Handle plugin, int params) { return Cvars.Debug.BoolValue; }