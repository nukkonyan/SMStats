/**
 *	Prepare the natives.
 */
public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)	{
	RegPluginLibrary("XStats");
	
	CreateNative("XStats.GetPoints", Native_GetClientPoints);
	CreateNative("XStats.GetPlayTime", Native_GetClientPlayTime);
	CreateNative("XStats.GetSession", Native_GetClientSession);
	CreateNative("XStats.ClearSessions", Native_ClearSessions);
	CreateNative("XStats.GetPrefix", Native_GetPrefix);
	CreateNative("XStats.Enabled", Native_Enabled);
	CreateNative("XStats.Active", Native_Active);
	CreateNative("XStats.AllowBots", Native_AllowBots);
	CreateNative("XStats.Debug", Native_Debug);
}

any Native_GetClientPoints(Handle plugin, int params) {
	int maxlen; GetNativeStringLength(1, maxlen);
	char[] auth = new char[maxlen];
	GetNativeString(1, auth, maxlen);
	return GetClientPoints(auth);
}

any Native_GetClientPlayTime(Handle plugin, int params) {
	int maxlen = GetNativeStringLength(1, maxlen);
	char[] auth = new char[maxlen];
	GetNativeString(1, auth, maxlen);
	return GetClientPlayTime(auth);
}

any Native_GetClientSession(Handle plugin, int params) {
	int client = GetNativeCell(1);
	XStats_SessionType sessiontype = GetNativeCell(2);
	Function func = GetNativeFunction(3);
	
	if(!Tklib_IsValidClient(client, true)) ThrowNativeError(SP_ERROR_NATIVE, "[XStats] Client index %i is invalid", client);
	
	int stats = 0;
	switch(sessiontype)	{
		/* Stats */
		case SessionType_PlayTime: stats = Session[client].PlayTime;
		case SessionType_Points: stats = Session[client].Points;
		case SessionType_Kills: stats = Session[client].Kills;
		case SessionType_Deaths: stats = Session[client].Deaths;
		case SessionType_Suicides: stats = Session[client].Suicides;
		case SessionType_Assists: stats = Session[client].Assists;
		case SessionType_DamageDone: stats = Session[client].DamageDone;
		
		/* Generic */
		case SessionType_Dominations: stats = Session[client].Dominations;
		case SessionType_Revenges: stats = Session[client].Revenges;
		case SessionType_Headshots: stats = Session[client].Headshots;
		case SessionType_Noscopes: stats = Session[client].Noscopes;
		case SessionType_Collaterals: stats = Session[client].Collaterals;
		case SessionType_MidAirKills: stats = Session[client].MidAirKills;
		case SessionType_GrenadeKills: stats = Session[client].GrenadeKills;
		
		/* TF2 */
		case SessionType_ScoutKills: stats = Session[client].ScoutKills;
		case SessionType_SoldierKills: stats = Session[client].SoldierKills;
		case SessionType_PyroKills: stats = Session[client].PyroKills;
		case SessionType_DemoKills: stats = Session[client].DemoKills;
		case SessionType_HeavyKills: stats = Session[client].HeavyKills;
		case SessionType_EngieKills: stats = Session[client].EngieKills;
		case SessionType_MedicKills: stats = Session[client].MedicKills;
		case SessionType_SniperKills: stats = Session[client].SniperKills;
		case SessionType_SpyKills: stats = Session[client].SpyKills;
		case SessionType_CivilianKills: stats = Session[client].CivilianKills; /* TF2 Classic */
		case SessionType_ScoutDeaths: stats = Session[client].ScoutDeaths;
		case SessionType_SoldierDeaths: stats = Session[client].SoldierDeaths;
		case SessionType_PyroDeaths: stats = Session[client].PyroDeaths;
		case SessionType_DemoDeaths: stats = Session[client].DemoDeaths;
		case SessionType_HeavyDeaths: stats = Session[client].HeavyDeaths;
		case SessionType_EngieDeaths: stats = Session[client].EngieDeaths;
		case SessionType_MedicDeaths: stats = Session[client].MedicDeaths;
		case SessionType_SniperDeaths: stats = Session[client].SniperDeaths;
		case SessionType_SpyDeaths: stats = Session[client].SpyDeaths;
		case SessionType_CivilianDeaths: stats = Session[client].CivilianDeaths; /* TF2 Classic */
		case SessionType_Airshots: stats = Session[client].Airshots;
		case SessionType_Backstabs: stats = Session[client].Backstabs;
		case SessionType_Tauntkills: stats = Session[client].Tauntkills;
		case SessionType_Gibs: stats = Session[client].Gibs;
		case SessionType_Deflects: stats = Session[client].Deflects;
		case SessionType_Ubercharged: stats = Session[client].Ubercharged;
		case SessionType_SandvichesStolen: stats = Session[client].SandvichesStolen;
		case SessionType_Coated: stats = Session[client].Coated;
		case SessionType_Extinguished: stats = Session[client].Extinguished;
		case SessionType_Telefrags: stats = Session[client].Telefrags;
		case SessionType_Sentrykills: stats = Session[client].Sentrykills;
		case SessionType_MiniSentrykills: stats = Session[client].MiniSentrykills;
		case SessionType_MiniCritkills: stats = Session[client].MiniCritkills;
		case SessionType_Critkills: stats = Session[client].Critkills;
		case SessionType_FlagsStolen: stats = Session[client].FlagsStolen;
		case SessionType_FlagsPickedUp: stats = Session[client].FlagsPickedUp;
		case SessionType_FlagsCaptured: stats = Session[client].FlagsCaptured;
		case SessionType_FlagsDefended: stats = Session[client].FlagsDefended;
		case SessionType_FlagsDropped: stats = Session[client].FlagsDropped;
		case SessionType_PassBallsGotten: stats = Session[client].PassBallsGotten;
		case SessionType_PassBallsScored: stats = Session[client].PassBallsScored;
		case SessionType_PassBallsDropped: stats = Session[client].PassBallsDropped;
		case SessionType_PassBallsCatched: stats = Session[client].PassBallsCatched;
		case SessionType_PassBallsStolen: stats = Session[client].PassBallsStolen;
		case SessionType_PassBallsBlocked: stats = Session[client].PassBallsBlocked;
		case SessionType_BuildingsBuilt: stats = Session[client].BuildingsBuilt;
		case SessionType_SentryGunsBuilt: stats = Session[client].SentryGunsBuilt;
		case SessionType_DispensersBuilt: stats = Session[client].DispensersBuilt;
		case SessionType_MiniSentryGunsBuilt: stats = Session[client].MiniSentryGunsBuilt;
		case SessionType_TeleporterEntrancesBuilt: stats = Session[client].TeleporterEntrancesBuilt;
		case SessionType_TeleporterExitsBuilt: stats = Session[client].TeleporterExitsBuilt;
		case SessionType_SappersPlaced: stats = Session[client].SappersPlaced;
		case SessionType_BuildingsDestroyed: stats = Session[client].BuildingsDestroyed;
		case SessionType_SentryGunsDestroyed: stats = Session[client].SentryGunsDestroyed;
		case SessionType_DispensersDestroyed: stats = Session[client].DispensersDestroyed;
		case SessionType_MiniSentryGunsDestroyed: stats = Session[client].MiniSentryGunsDestroyed;
		case SessionType_TeleporterEntrancesDestroyed: stats = Session[client].TeleporterEntrancesDestroyed;
		case SessionType_TeleporterExitsDestroyed: stats = Session[client].TeleporterExitsDestroyed;
		case SessionType_SappersDestroyed: stats = Session[client].SappersDestroyed;
		case SessionType_KilledHHH: stats = Session[client].KilledHHH;
		case SessionType_KilledMonoculus: stats = Session[client].KilledMonoculus;
		case SessionType_KilledMerasmus: stats = Session[client].KilledMerasmus;
		case SessionType_KilledSkeletonKing: stats = Session[client].KilledSkeletonKing;
		case SessionType_StunnedMonoculus: stats = Session[client].StunnedMonoculus;
		case SessionType_MadMilked: stats = Session[client].MadMilked;
		case SessionType_Jarated: stats = Session[client].Jarated;
		case SessionType_Ignited: stats = Session[client].Ignited;
		
		/* TF2 MvM */
		case SessionType_TanksDestroyed: stats = Session[client].TanksDestroyed;
		case SessionType_SentryBustersKilled: stats = Session[client].SentryBustersKilled;
		case SessionType_BombsResetted: stats = Session[client].BombsResetted;
		
		/* CS:GO */
		case SessionType_BlindKills: stats = Session[client].BlindKills;
		case SessionType_SmokeKills: stats = Session[client].SmokeKills;
		case SessionType_Wipes: stats = Session[client].Wipes;
		case SessionType_ChickenKills: stats = Session[client].ChickenKills;
		
		/* Counter-Strike Overall */
		case SessionType_MVPs: stats = Session[client].MVPs;
		case SessionType_BombsPlanted: stats = Session[client].BombsPlanted;
		case SessionType_BombsDefused: stats = Session[client].BombsDefused;
		case SessionType_BombsExploded: stats = Session[client].BombsExploded;
		case SessionType_BombKills: stats = Session[client].BombKills;
		case SessionType_MoneySpent: stats = Session[client].MoneySpent;
		case SessionType_KnifeKills: stats = Session[client].KnifeKills;
	}
	
	Forward.GetStats.AddFunction(plugin, func);
	Call_StartForward(Forward.GetStats);
	Call_PushCell(sessiontype);
	Call_PushCell(client);
	Call_PushCell(stats);
	Call_Finish();
}

any Native_ClearSessions(Handle plugin, int params) { ClearSessions(GetNativeCell(1)); }
any Native_GetPrefix(Handle plugin, int params) { SetNativeString(1, Global.Prefix, GetNativeCell(2), GetNativeCell(3)); }
any Native_Enabled(Handle plugin, int params) { return Cvars.PluginActive.BoolValue; }
any Native_Active(Handle plugin, int params) { return Global.RankActive; }
any Native_AllowBots(Handle plugin, int params) { return Cvars.AllowBots.BoolValue; }
any Native_Debug(Handle plugin, int params) { return Cvars.Debug.BoolValue; }