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
	author = "teamkiller324",
	description = "Tracks player statistics. Keeps the stats when SMStats is updated.",
	version = Version,
	url = "https://github.com/Teamkiller324"
}

#define UpdaterURL "https://raw.githubusercontent.com/Teamkiller324/SMStats/main/updater/SMStats_Info.txt"
#include "sm_stats/updater.sp"

SMStats_PlayerInfo g_Player[MAXPLAYERS+1];

SMStats_TF2GameInfo g_TF2GameStats[MAXPLAYERS+1];

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	RegPluginLibrary("SMStatsInfo");
	
	CreateNative("SMStatsInfo.GetStats", Native_GetStats);
	CreateNative("SMStatsInfo.SaveStats", Native_SaveStats);
	CreateNative("SMStatsInfo.ResetStats", Native_ResetStats);
	
	CreateNative("SMStatsInfo.GetGameStats", Native_GetGameStats);
	CreateNative("SMStatsInfo.SaveGameStats", Native_SaveGameStats);
	CreateNative("SMStatsInfo.ResetGameStats", Native_ResetGameStats);
	
	return APLRes_Success;
}

int Native_GetStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	SetNativeArray(2, g_Player[client], sizeof(g_Player[]));
	return -69;
}
int Native_SaveStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	GetNativeArray(2, g_Player[client], sizeof(g_Player[]));
	return -69;
}
int Native_ResetStats(Handle plugin, int params)
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
	}
	return -69;
}
int Native_SaveGameStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	switch(GetEngineVersion())
	{
		case Engine_TF2: GetNativeArray(2, g_TF2GameStats[client], sizeof(g_TF2GameStats[]));
	}
	return -69;
}
int Native_ResetGameStats(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	switch(GetEngineVersion())
	{
		case Engine_TF2: g_TF2GameStats[client].Reset();
	}
	return -69;
}