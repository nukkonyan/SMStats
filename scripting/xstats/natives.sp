/**
 *	Prepare the natives.
 */
void PrepareNatives()
{
	CreateNative("Xstats_GetClientPoints", Native_GetClientPoints);
	CreateNative("Xstats.GetPoints", Public_GetClientPoints);
	
	CreateNative("Xstats_GetClientPlayTime", Native_GetClientPlayTime);
	CreateNative("Xstats.GetPlayTime", Public_GetClientPlayTime);
	
	CreateNative("Xstats_GetClientSessionTypeStats", Native_GetClientSessionTypeStats);
	CreateNative("Xstats.GetStats", Public_GetClientSessionTypeStats);
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

any Native_GetClientSessionTypeStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	
	if(!Tklib_IsValidClient(client, true))
		ThrowNativeError(SP_ERROR_NATIVE, "[Xstats] Client index %i is invalid", client);
	
	return GetStats(client, GetNativeCell(2));
}
any Public_GetClientSessionTypeStats(Handle plugin, int params)
{
	int client = GetNativeCell(2);
	
	if(!Tklib_IsValidClient(client, true))
		ThrowNativeError(SP_ERROR_NATIVE, "[Xstats] Client index %i is invalid", client);
	
	return GetStats(client, GetNativeCell(3));
}

int GetStats(int client, XStats_SessionType sessiontype)
{
	int stats = 0;
	switch(sessiontype)
	{
		/* Stats */
		case	SessionType_Time:		stats = Session[client].Time;
		case	SessionType_Points:		stats = Session[client].Points;
		case	SessionType_Kills:		stats = Session[client].Kills;
		case	SessionType_Deaths:		stats = Session[client].Deaths;
		case	SessionType_Suicides:	stats = Session[client].Suicides;
		case	SessionType_Assists:	stats = Session[client].Assists;
		
		/* Generic */
		case	SessionType_Dominations:	stats = Session[client].Dominations;
		case	SessionType_Revenges:		stats = Session[client].Revenges;
		case	SessionType_Airshots:		stats = Session[client].Airshots;
		case	SessionType_Headshots:		stats = Session[client].Headshots;
		case	SessionType_Noscopes:		stats = Session[client].Noscopes;
		
		/* TF2 */
		case	SessionType_Backstabs:			stats = Session[client].Backstabs;
		case	SessionType_TauntKills:			stats = Session[client].TauntKills;
		case	SessionType_GibKills:			stats = Session[client].GibKills;
		case	SessionType_DeflectKills:		stats = Session[client].DeflectKills;
		case	SessionType_Ubercharged:		stats = Session[client].Ubercharged;
		case	SessionType_SandvichesStolen:	stats = Session[client].SandvichesStolen;
		case	SessionType_Coated:				stats = Session[client].Coated;
		case	SessionType_Extinguished:		stats = Session[client].Extinguished;
		case	SessionType_TeleFrags:			stats = Session[client].TeleFrags;
		case	SessionType_SentryKills:		stats = Session[client].SentryKills;
		case	SessionType_MiniSentryKills:	stats = Session[client].MiniSentryKills;
		case	SessionType_MiniCritKills:		stats = Session[client].MiniCritKills;
		case	SessionType_CritKills:			stats = Session[client].CritKills;
		case	SessionType_FlagsStolen:		stats = Session[client].FlagsStolen;
		case	SessionType_FlagsPickedUp:		stats = Session[client].FlagsPickedUp;
		case	SessionType_FlagsCaptured:		stats = Session[client].FlagsCaptured;
		case	SessionType_FlagsDefended:		stats = Session[client].FlagsDefended;
		case	SessionType_FlagsDropped:		stats = Session[client].FlagsDropped;
		
		/* CS:GO */
		case	SessionType_BlindKills:		stats = Session[client].BlindKills;
		case	SessionType_SmokeKills:		stats = Session[client].SmokeKills;
		case	SessionType_Wipes:			stats = Session[client].Wipes;
		
		/* Counter-Strike Overall */
		case	SessionType_MVPs:			stats = Session[client].MVPs;
		case	SessionType_BombsPlanted:	stats = Session[client].BombsPlanted;
		case	SessionType_BombsDefused:	stats = Session[client].BombsDefused;
		case	SessionType_BombsExploded:	stats = Session[client].BombsExploded;
	}
	
	return stats;
}