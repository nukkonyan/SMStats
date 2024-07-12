#pragma semicolon 1
#pragma newdecls required
#define Version "1.0.0"
#define core_chattag "[SM Stats: Info]"

#include <sm_stats>
#include <sm_stats_info>
#include <sdktools>
#include <multicolors>

public Plugin myinfo = {
	name = "SM Stats: Info",
	author = "nukkonyan",
	description = "Tracks player statistics. Keeps the stats when SMStats is updated.",
	version = Version,
	url = "https://github.com/nukkonyan"
}

#define UpdaterURL "https://raw.githubusercontent.com/nukkonyan/SMStats/main/updater/SMStats_Info.txt"
#include "sm_stats/updater.sp"

// game related
SMStats_PlayerInfo g_Player[MAXPLAYERS+1];
SMStats_TF2GameInfo g_TF2GameStats[MAXPLAYERS+1];
SMStats_CSGOGameInfo g_CSGOGameStats[MAXPLAYERS+1];

// crucial stuff
bool bLoaded;
bool bStatsActive;
bool bRoundActive;
int iMapTimerSeconds;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	RegPluginLibrary("SMStatsInfo");
	
	CreateNative("SMStatsInfo.GetPlayerStats", Native_GetPlayerStats);
	CreateNative("SMStatsInfo.SavePlayerStats", Native_SavePlayerStats);
	CreateNative("SMStatsInfo.ResetPlayerStats", Native_ResetPlayerStats);
	
	CreateNative("SMStatsInfo.GetGameStats", Native_GetGameStats);
	CreateNative("SMStatsInfo.SaveGameStats", Native_SaveGameStats);
	CreateNative("SMStatsInfo.ResetGameStats", Native_ResetGameStats);
	
	CreateNative("_sm_stats_info_update_stats_active", Native_UpdateStatsActive);
	CreateNative("_sm_stats_info_update_round_active", Native_UpdateRoundActive);
	CreateNative("_sm_stats_info_update_maptimer", Native_UpdateMapTimer);
	CreateNative("_sm_stats_info_get_crucial_stuff", Native_GetCrucialStuff);
	CreateNative("_sm_stats_info_save_crucial_stuff", Native_SaveCrucialStuff);
	
	return APLRes_Success;
}

public void _sm_stats_loaded_core()
{
	bLoaded = true;
}

any Native_GetPlayerStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	SetNativeArray(2, g_Player[client], sizeof(g_Player[]));
	return -69;
}
any Native_SavePlayerStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	GetNativeArray(2, g_Player[client], sizeof(g_Player[]));
	return -69;
}
any Native_ResetPlayerStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	g_Player[client].Reset();
	return -69;
}

int Native_GetGameStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	switch(GetEngineVersion())
	{
		case Engine_TF2: SetNativeArray(2, g_TF2GameStats[client], sizeof(g_TF2GameStats[]));
		case Engine_CSGO: SetNativeArray(2, g_CSGOGameStats[client], sizeof(g_CSGOGameStats[]));
	}
	return -69;
}
int Native_SaveGameStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	switch(GetEngineVersion())
	{
		case Engine_TF2: GetNativeArray(2, g_TF2GameStats[client], sizeof(g_TF2GameStats[]));
		case Engine_CSGO: GetNativeArray(2, g_CSGOGameStats[client], sizeof(g_CSGOGameStats[]));
	}
	return -69;
}
int Native_ResetGameStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	switch(GetEngineVersion())
	{
		case Engine_TF2: g_TF2GameStats[client].Reset();
		case Engine_CSGO: g_CSGOGameStats[client].Reset();
	}
	return -69;
}

any Native_UpdateStatsActive(Handle plugin, int params)
{
	bStatsActive = view_as<bool>(GetNativeCell(1));
	return 0;
}
any Native_UpdateRoundActive(Handle plugin, int params)
{
	bRoundActive = view_as<bool>(GetNativeCell(1));
	return 0;
}
any Native_UpdateMapTimer(Handle plugin, int params)
{
	iMapTimerSeconds = view_as<bool>(GetNativeCell(1));
	return 0;
}
any Native_GetCrucialStuff(Handle plugin, int params)
{
	SMStatsInfo_CrucialStuff stuff;
	stuff.bLoaded = bLoaded;
	stuff.bStatsActive = bStatsActive;
	stuff.bRoundActive = bRoundActive;
	stuff.iMapTimerSeconds = iMapTimerSeconds;
	SetNativeArray(1, stuff, sizeof(stuff));
	return 0;
}
any Native_SaveCrucialStuff(Handle plugin, int params)
{
	bLoaded = view_as<bool>(GetNativeCell(1));
	bStatsActive = view_as<bool>(GetNativeCell(2));
	bRoundActive = view_as<bool>(GetNativeCell(3));
	iMapTimerSeconds = GetNativeCell(3);
	return 0;
}