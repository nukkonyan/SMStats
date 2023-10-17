#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0
#define Version "1.0.0"
#define VersionAlt "v" ... Version
#define MaxPlayers 33 // 101 cuz -unrestricted_maxplayers ?
#define MaxItemDef 30758 // will later be updated to use indexes instead of itemdef
#define GameTag "tf2"
#define core_chattag "[SM Stats: TF2]"
#define core_chattag2 "SM Stats: TF2"
#define load_menus
#define load_forwards

#define query_error_uniqueid_CP_OnCapturedPoint 1
#define query_error_uniqueid_CP_OnCaptureBlocked 2
#define query_error_uniqueid_CTF_OnFlagPickedUp 3
#define query_error_uniqueid_CTF_OnFlagStolen 4
#define query_error_uniqueid_CTF_OnFlagCaptured 5
#define query_error_uniqueid_CTF_OnFlagDefended 6
#define query_error_uniqueid_CTF_OnFlagDropped 7
#define query_error_uniqueid_OnPlayerUbercharged 8
#define query_error_uniqueid_OnPlayerUsedTeleporter 9
#define query_error_uniqueid_OnPlayerTeleported 10
#define query_error_uniqueid_OnPlayerStealSandvich 11
#define query_error_uniqueid_OnPlayerStunned 12
#define query_error_uniqueid_Halloween_OnHHHFragged 13
#define query_error_uniqueid_Halloween_OnMonoculusFragged 14
#define query_error_uniqueid_Halloween_OnMerasmusFragged 15
#define query_error_uniqueid_Halloween_OnSkeletonKingFragged 16
#define query_error_uniqueid_Halloween_OnMonoculusStunned 17
#define query_error_uniqueid_Halloween_OnMerasmusStunned 18
#define query_error_uniqueid_OnRobotsFragged 52
#define query_error_uniqueid_OnPlayerExtinguished 54
#define query_error_uniqueid_OnPlayerJarated 57
#define query_error_uniqueid_OnPlayerMilked 58
#define query_error_uniqueid_MvM_OnBombResetted 59
#define query_error_uniqueid_MvM_OnSentryBusterFragged 61
#define query_error_uniqueid_MvM_OnTankDestroyed 62
#define query_error_uniqueid_PassBall_Get 71
#define query_error_uniqueid_PassBall_Score 72
#define query_error_uniqueid_PassBall_Dropped 73
#define query_error_uniqueid_PassBall_Catched 74
#define query_error_uniqueid_PassBall_Stolen 75
#define query_error_uniqueid_PassBall_Blocked 76
#define query_error_uniqueid_OnUpdateDamageDone 79
#define query_error_uniqueid_UpdatePlayTime 80
#define query_error_uniqueid_UpdateMapTimeInserting 81
#define query_error_uniqueid_UpdateMapTimeUpdating 82
#define query_error_uniqueid_OnPlayerNameUpdate 83

#include <sm_stats>
#include <sm_stats_core>
#include <tf2_stocks>

// updater
#define UpdaterURL "https://raw.githubusercontent.com/Teamkiller324/SMStats/main/sm_updater/SMStats_TF2.txt"
#include "sm_stats/updater.sp"

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	char gamefolder[16];
	GetGameFolderName(gamefolder, sizeof(gamefolder));
	
	if(!StrEqual(gamefolder, "tf"))
	{
		SetFailState("This SM Stats game addon may only be running in:"
		... "\nTeam Fortress 2."
		);
	}
	
	CreateNative("SMStats.Native_GetPlayerSessionInfo", Native_GetPlayerSessionInfo);
	
	return APLRes_Success;
}

public Plugin myinfo =
{
	name = "SM Stats: Team Fortress 2",
	author = "teamkiller324",
	description = "Tracks frags, maps, events, achievements, etc.",
	version = Version,
	url = "https://github.com/Teamkiller324/SMStats"
}

#include "sm_stats_tf2/menus.sp"

#include "sm_stats/functions.sp"
#include "sm_stats/damage_done.sp"
#include "sm_stats/natives.sp"
#include "sm_stats/assister.sp"
#include "sm_stats/forwards.sp"

#include "sm_stats_tf2/functions.sp"
#include "sm_stats_tf2/game.sp"
//#include "sm_stats_tf2/forwards.sp"