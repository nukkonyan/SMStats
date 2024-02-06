#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0
#define Version "1.0.0@testing1"
#define VersionAlt "v" ... Version
#define MaxPlayers 65
#define GameType "css"
#define core_chattag "[SM Stats: CSS]"
#define core_chattag2 "SM Stats: CSS"

#define load_plugin_core
#define load_menus
#define load_forwards
#define load_players
#define updater_info
#define updater_gamestats

#define sql_loadtable_playerlist
#define sql_loadtable_weapons
#define sql_loadtable_kill_log
#define sql_loadtable_maps_log
//#define sql_loadtable_achievements
#define sql_loadtable_settings

#define query_error_uniqueid_OnUpdateDamageDone 79
#define query_error_uniqueid_UpdatePlayTime 80
#define query_error_uniqueid_UpdateMapTimeInserting 81
#define query_error_uniqueid_UpdateMapTimeUpdating 82
#define query_error_uniqueid_UpdateMapTimeUpdatingSeconds 83
#define query_error_uniqueid_OnPlayerNameUpdate 84
#define query_error_uniqueid_OnPlayerDisconnectUpdateLastConnected 85
#define query_error_uniqueid_OnPlayerDisconnectUpdatePlayTime 86
#define query_error_uniqueid_OnUpdatedMenuSettingValue 87
#define query_error_uniqueid_OnKillLogInsert 89

//SMStats_CSSGameInfo g_Game[MaxPlayers+1];

#include <sm_stats>
#include <sm_stats_core>
#include <cstrike>
#include <sdktools>

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
	CreateNative("_sm_stats_detect_ban_player_auth", Native_BanPlayer_Auth);
	CreateNative("_sm_stats_detect_ban_player_ip", Native_BanPlayer_IPAddress);
	
	return APLRes_Success;
}

public Plugin myinfo =
{
	name = "SM Stats: Counter-Strike Source",
	author = "teamkiller324",
	description = "Tracks frags, maps, events, achievements, etc.",
	version = Version,
	url = "https://github.com/Teamkiller324/SMStats"
}

#include "sm_stats_css/menus.sp"
#include "sm_stats_css/functions.sp"
#include "sm_stats_css/game.sp"

#include "sm_stats/functions.sp"
#include "sm_stats/damage_done.sp"
#include "sm_stats/natives.sp"
#include "sm_stats/assister.sp"
#include "sm_stats/forwards.sp"

// updater
#define UpdaterURL "https://raw.githubusercontent.com/Teamkiller324/SMStats/main/sm_updater/SMStats_CSS.txt"
#include "sm_stats/updater.sp"