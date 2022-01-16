/**
 *	Prepare the natives.
 */
void PrepareNatives()
{
	CreateNative("Xstats_GetClientPoints", Native_GetClientPoints);
	CreateNative("Xstats.GetPoints", Public_GetClientPoints);
	
	CreateNative("Xstats_GetClientPlayTime", Native_GetClientPlayTime);
	CreateNative("Xstats.GetPlayTime", Public_GetClientPlayTime);
	
	CreateNative("Xstats_GetClientSession", Native_GetClientSession);
	CreateNative("Xstats.GetSession", Public_GetClientSession);
	
	CreateNative("Xstats_GetPrefix", Native_GetPrefix);
	CreateNative("Xstats.GetPrefix", Public_GetPrefix);
}

any Native_GetClientPoints(Handle plugin, int params)
{
	char auth[64];
	GetNativeString(1, auth, sizeof(auth));
	return GetClientPoints(auth);
}
any Public_GetClientPoints(Handle plugin, int params)
{
	char auth[64];
	GetNativeString(2, auth, sizeof(auth));
	return GetClientPoints(auth);
}

any Native_GetClientPlayTime(Handle plugin, int params)
{
	char auth[64];
	GetNativeString(1, auth, sizeof(auth));
	return GetClientPlayTime(auth);
}
any Public_GetClientPlayTime(Handle plugin, int params)
{
	char auth[64];
	GetNativeString(2, auth, sizeof(auth));
	return GetClientPlayTime(auth);
}

any Native_GetClientSession(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	
	if(!Tklib_IsValidClient(client, true))
		ThrowNativeError(SP_ERROR_NATIVE, "[Xstats] Client index %i is invalid", client);
	
	GetStats(plugin, client, GetNativeCell(2), GetNativeFunction(3));
}
any Public_GetClientSession(Handle plugin, int params)
{
	int client = GetNativeCell(2);
	
	if(!Tklib_IsValidClient(client, true))
		ThrowNativeError(SP_ERROR_NATIVE, "[Xstats] Client index %i is invalid", client);
	
	GetStats(plugin, client, GetNativeCell(3), GetNativeFunction(4));
}

any Native_GetPrefix(Handle plugin, int params)	{	SetNativeString(1, Prefix, GetNativeCell(2), GetNativeCell(3));	}
any Public_GetPrefix(Handle plugin, int params)	{	SetNativeString(2, Prefix, GetNativeCell(3), GetNativeCell(4));	}

int GetStats(Handle plugin, int client, XStats_SessionType sessiontype, Function func)	{
	int stats = 0;
	switch(sessiontype)	{
		/* Stats */
		case	SessionType_Time: stats = Session[client].Time;
		case	SessionType_Points: stats = Session[client].Points;
		case	SessionType_Kills: stats = Session[client].Kills;
		case	SessionType_Deaths: stats = Session[client].Deaths;
		case	SessionType_Suicides: stats = Session[client].Suicides;
		case	SessionType_Assists: stats = Session[client].Assists;
		case	SessionType_DamageDone: stats = Session[client].DamageDone;
		
		/* Generic */
		case	SessionType_Dominations: stats = Session[client].Dominations;
		case	SessionType_Revenges: stats = Session[client].Revenges;
		case	SessionType_Headshots: stats = Session[client].Headshots;
		case	SessionType_Noscopes: stats = Session[client].Noscopes;
		case	SessionType_Collaterals: stats = Session[client].Collaterals;
		case	SessionType_MidAirKills: stats = Session[client].MidAirKills;
		case	SessionType_GrenadeKills: stats = Session[client].GrenadeKills;
		
		/* TF2 */
		case	SessionType_ScoutsKilled: stats = Session[client].ScoutsKilled;
		case	SessionType_SoldiersKilled: stats = Session[client].SoldiersKilled;
		case	SessionType_PyrosKilled: stats = Session[client].PyrosKilled;
		case	SessionType_DemosKilled: stats = Session[client].DemosKilled;
		case	SessionType_HeaviesKilled: stats = Session[client].HeaviesKilled;
		case	SessionType_EngiesKilled: stats = Session[client].EngiesKilled;
		case	SessionType_MedicsKilled: stats = Session[client].MedicsKilled;
		case	SessionType_SnipersKilled: stats = Session[client].SnipersKilled;
		case	SessionType_SpiesKilled: stats = Session[client].SpiesKilled;
		case	SessionType_CiviliansKilled: stats = Session[client].CiviliansKilled; /* TF2 Classic */
		case	SessionType_Airshots: stats = Session[client].Airshots;
		case	SessionType_Backstabs: stats = Session[client].Backstabs;
		case	SessionType_TauntKills: stats = Session[client].TauntKills;
		case	SessionType_GibKills: stats = Session[client].GibKills;
		case	SessionType_DeflectKills: stats = Session[client].DeflectKills;
		case	SessionType_Ubercharged: stats = Session[client].Ubercharged;
		case	SessionType_SandvichesStolen: stats = Session[client].SandvichesStolen;
		case	SessionType_Coated: stats = Session[client].Coated;
		case	SessionType_Extinguished: stats = Session[client].Extinguished;
		case	SessionType_TeleFrags: stats = Session[client].TeleFrags;
		case	SessionType_SentryKills: stats = Session[client].SentryKills;
		case	SessionType_MiniSentryKills: stats = Session[client].MiniSentryKills;
		case	SessionType_MiniCritKills: stats = Session[client].MiniCritKills;
		case	SessionType_CritKills: stats = Session[client].CritKills;
		case	SessionType_FlagsStolen: stats = Session[client].FlagsStolen;
		case	SessionType_FlagsPickedUp: stats = Session[client].FlagsPickedUp;
		case	SessionType_FlagsCaptured: stats = Session[client].FlagsCaptured;
		case	SessionType_FlagsDefended: stats = Session[client].FlagsDefended;
		case	SessionType_FlagsDropped: stats = Session[client].FlagsDropped;
		case	SessionType_PassBallsGotten: stats = Session[client].PassBallsGotten;
		case	SessionType_PassBallsScored: stats = Session[client].PassBallsScored;
		case	SessionType_PassBallsDropped: stats = Session[client].PassBallsDropped;
		case	SessionType_PassBallsCatched: stats = Session[client].PassBallsCatched;
		case	SessionType_PassBallsStolen: stats = Session[client].PassBallsStolen;
		case	SessionType_PassBallsBlocked: stats = Session[client].PassBallsBlocked;
		case	SessionType_BuildingsBuilt: stats = Session[client].BuildingsBuilt;
		case	SessionType_SentryGunsBuilt: stats = Session[client].SentryGunsBuilt;
		case	SessionType_DispensersBuilt: stats = Session[client].DispensersBuilt;
		case	SessionType_MiniSentryGunsBuilt: stats = Session[client].MiniSentryGunsBuilt;
		case	SessionType_TeleporterEntrancesBuilt: stats = Session[client].TeleporterEntrancesBuilt;
		case	SessionType_TeleporterExitsBuilt: stats = Session[client].TeleporterExitsBuilt;
		case	SessionType_SappersPlaced: stats = Session[client].SappersPlaced;
		case	SessionType_BuildingsDestroyed: stats = Session[client].BuildingsDestroyed;
		case	SessionType_SentryGunsDestroyed: stats = Session[client].SentryGunsDestroyed;
		case	SessionType_DispensersDestroyed: stats = Session[client].DispensersDestroyed;
		case	SessionType_MiniSentryGunsDestroyed: stats = Session[client].MiniSentryGunsDestroyed;
		case	SessionType_TeleporterEntrancesDestroyed: stats = Session[client].TeleporterEntrancesDestroyed;
		case	SessionType_TeleporterExitsDestroyed: stats = Session[client].TeleporterExitsDestroyed;
		case	SessionType_SappersDestroyed: stats = Session[client].SappersDestroyed;
		case	SessionType_KilledHHH: stats = Session[client].KilledHHH;
		case	SessionType_KilledMonoculus: stats = Session[client].KilledMonoculus;
		case	SessionType_KilledMerasmus: stats = Session[client].KilledMerasmus;
		case	SessionType_KilledSkeletonKing: stats = Session[client].KilledSkeletonKing;
		case	SessionType_StunnedMonoculus: stats = Session[client].StunnedMonoculus;
		case	SessionType_MadMilked: stats = Session[client].MadMilked;
		case	SessionType_Jarated: stats = Session[client].Jarated;
		case	SessionType_Ignited: stats = Session[client].Ignited;
		
		/* TF2 MvM */
		case	SessionType_TanksDestroyed: stats = Session[client].TanksDestroyed;
		case	SessionType_SentryBustersKilled: stats = Session[client].SentryBustersKilled;
		case	SessionType_BombsResetted: stats = Session[client].BombsResetted;
		
		/* CS:GO */
		case	SessionType_BlindKills: stats = Session[client].BlindKills;
		case	SessionType_SmokeKills: stats = Session[client].SmokeKills;
		case	SessionType_Wipes: stats = Session[client].Wipes;
		
		/* Counter-Strike Overall */
		case	SessionType_MVPs: stats = Session[client].MVPs;
		case	SessionType_BombsPlanted: stats = Session[client].BombsPlanted;
		case	SessionType_BombsDefused: stats = Session[client].BombsDefused;
		case	SessionType_BombsExploded: stats = Session[client].BombsExploded;
		case	SessionType_BombKills: stats = Session[client].BombKills;
		case	SessionType_MoneySpent: stats = Session[client].MoneySpent;
		case	SessionType_KnifeKills: stats = Session[client].KnifeKills;
	}
	
	Fwd_GetStats.AddFunction(plugin, func);
	Call_StartForward(Fwd_GetStats);
	Call_PushCell(sessiontype);
	Call_PushCell(client);
	Call_PushCell(stats);
	Call_Finish();
}