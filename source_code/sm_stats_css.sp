#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0
#define Version "1.0.0"
#define VersionAlt "v" ... Version
#define MaxPlayers 33
#define GameTag "css"
#define core_chattag "[SM Stats: CSS]"
#define core_chattag2 "SM Stats: CSS"
#define assister_func
#define load_menus
#define load_forwards

#define query_error_uniqueid_OnPlayerDeath 1
#define query_error_uniqueid_OnUpdateDamageDone 79
#define query_error_uniqueid_UpdatePlayTime 80
#define query_error_uniqueid_UpdateMapTimeInserting 81
#define query_error_uniqueid_UpdateMapTimeUpdating 82
#define query_error_uniqueid_OnPlayerDeath_MapUpdate 83

#include <sm_stats>
#include <sm_stats_core>
#include <sdktools>
#include <cstrike>

// updater
#define UpdaterURL "https://raw.githubusercontent.com/Teamkiller324/SMStats/main/sm_updater/SMStats_CSS.txt"
#include "sm_stats/updater.sp"

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	char gamefolder[16];
	GetGameFolderName(gamefolder, sizeof(gamefolder));
	
	if(!StrEqual(gamefolder, "cstrike"))
	{
		SetFailState("This SM Stats game addon may only be running in:"
		... "\nCounter-Strike: Source."
		);
	}
	
	CreateNative("SMStats.Native_GetPlayerSessionInfo", Native_GetPlayerSessionInfo);
	
	return APLRes_Success;
}

public Plugin myinfo =
{
	name = "SM Stats: Counter-Strike: Source",
	author = "teamkiller324",
	description = "Tracks frags, maps, events, achievements, etc.",
	version = Version,
	url = "https://github.com/Teamkiller324"
}

#include "sm_stats_css/menus.sp"

#include "sm_stats/functions.sp"
#include "sm_stats/damage_done.sp"
#include "sm_stats/natives.sp"
#include "sm_stats/assister.sp"
#include "sm_stats/forwards.sp"

#include "sm_stats_css/functions.sp"
#include "sm_stats_css/game.sp"
#include "sm_stats_css/forwards.sp"