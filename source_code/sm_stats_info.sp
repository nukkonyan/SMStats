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
	description = "Tracks frags, maps, events, achievements, etc.",
	version = Version,
	url = "https://github.com/Teamkiller324"
}

#define UpdaterURL "https://raw.githubusercontent.com/Teamkiller324/SMStats/main/updater/SMStats_Info.txt"
#include "sm_stats/updater.sp"

SMStats_PlayerInfo g_Player[MAXPLAYERS+1];

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	RegPluginLibrary("SMStatsInfo");
	
	CreateNative("SMStatsInfo.Get", Native_Get);
	CreateNative("SMStatsInfo.Save", Native_Save);
	
	return APLRes_Success;
}

int Native_Get(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	SetNativeArray(2, g_Player[client], sizeof(g_Player[]));
	return -69;
}

int Native_Save(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	GetNativeArray(2, g_Player[client], sizeof(g_Player[]));
	return -69;
}