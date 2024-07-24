#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0
#define Version "1.0@beta1"
#define VersionAlt "v" ... Version
#define MaxPlayers 65
#define MaxItemDef 527 // will later be updated to use indexes instead of itemdef
char GameType[11];
#define core_chattag "[SMStats: CSGO]"
#define core_chattag2 "SMStats: CSGO"

#define load_plugin_core
#define load_cstrike
//#define load_menus
#define load_forwards
#define load_players
#define updater_info
#define updater_gamestats

#define sql_loadtable_playerlist
#define sql_loadtable_weapons
#define sql_loadtable_kill_log
//#define sql_loadtable_item_log
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
#define query_error_uniqueid_OnItemEventInsert 88
#define query_error_uniqueid_OnKillLogInsert 89

SMStats_CSGOGameInfo g_Game[MaxPlayers+1];

#include <sm_stats>
#include <sm_stats_core>
#include <cstrike>
#include <sdktools>

stock SMStats_CSGOType g_CSGOType;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	switch(GetEngineVersion())
	{
		case Engine_CSGO:
		{
			char gamefolder[16];
			GetGameFolderName(gamefolder, sizeof(gamefolder));
			
			if(StrEqual(gamefolder, "csgo", false))
			{
				g_CSGOType = CSGOType_CSGO;
				GameType = "csgo";
			}
			else if(StrEqual(gamefolder, "cscomod", false))
			{
				g_CSGOType = CSGOType_CSCO;
				GameType = "csco";
			}
		}
		default:
		{
			SetFailState("This SMStats game addon may only be running in:"
			... "\nCounter-Strike: Global Offensive."
			... "\nCounter-Strike: Classic Offensive."
			... "\nLegacy Strike."
			);
		}
	}
	
	PostAskPluginLoad();
	
	return APLRes_Success;
}

public Plugin myinfo =
{
	name = "SMStats: CSGO",
	author = "nukkonyan",
	description = "Tracks kills, maps, events, achievements, etc.",
	version = Version,
	url = "https://github.com/nukkonyan/SMStats"
}

//#include "sm_stats_csgo/menus.sp"
#include "sm_stats_csgo/functions.sp"
#include "sm_stats_cstrike/functions.sp"
#include "sm_stats_cstrike/game.sp"
#include "sm_stats_csgo/game.sp"

#include "sm_stats/functions.sp"
#include "sm_stats/damage_done.sp"
#include "sm_stats/natives.sp"
#include "sm_stats/assister.sp"
#include "sm_stats/forwards.sp"

// updater
#define UpdaterURL "https://raw.githubusercontent.com/nukkonyan/SMStats/main/sm_updater/SMStats_CSGO.txt"
//#include "sm_stats/updater.sp"