#pragma semicolon 1
#pragma newdecls required
#define Version "1.0.0"
#define core_chattag "[SM Stats: Core]"

#include <sm_stats>
#include <sdktools>
#include <multicolors>

public Plugin myinfo = {
	name = "SM Stats: Core",
	author = "teamkiller324",
	description = "Tracks frags, maps, events, achievements, etc.",
	version = Version,
	url = "https://github.com/Teamkiller324"
}

#define UpdaterURL "https://raw.githubusercontent.com/Teamkiller324/SMStats/main/updater/SMStats_Core.txt"
#include "sm_stats/updater.sp"

Database sql; // internal database.

GlobalForward g_fwdLoaded; // internal call to start addons.
GlobalForward g_fwdDBLoaded; // internal database connection.

GlobalForward g_fwdChatTagUpdated; // chat tag was updated.
GlobalForward g_fwdServerIDUpdated; // server id was updated.
GlobalForward g_fwdAllowBotsUpdated; // allow bots was updated.
GlobalForward g_fwdMinPlayersUpdated; // min players was updated.
GlobalForward g_fwdAllowAbuseUpdated; // allow abuse was updated.

GlobalForward g_fwdPlayerDeath; // built in player_death event based forward.

char g_ChatTag[96]; // global chat tag prefix
ConVar g_ServerID; // server id
ConVar g_AllowBots; // allow bots
ConVar g_MinPlayers; // minimum required players for statistical tracking.
ConVar g_AllowAbuse; // allow abuse of commands during events.
ConVar g_AllowWarmup; // allow tracking during warmup.
ConVar g_DisableAfterRoundEnd; // disable tracking after round end.
ConVar g_DeathPoints; // death points

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	RegPluginLibrary("SMStats");
	
	// forwards
	g_fwdLoaded = new GlobalForward("_sm_stats_core_loaded", ET_Ignore);
	g_fwdDBLoaded = new GlobalForward("_sm_stats_sql_loaded", ET_Ignore, Param_Cell, Param_Cell);
	
	g_fwdChatTagUpdated = new GlobalForward("_sm_stats_chattag_updated", ET_Ignore, Param_String);
	g_fwdServerIDUpdated = new GlobalForward("_sm_stats_serverid_updated", ET_Ignore, Param_Cell);
	g_fwdAllowBotsUpdated = new GlobalForward("_sm_stats_allowbots_updated", ET_Ignore, Param_Cell);
	g_fwdMinPlayersUpdated = new GlobalForward("_sm_stats_minplayers_updated", ET_Ignore, Param_Cell);
	g_fwdAllowAbuseUpdated = new GlobalForward("sm_stats_allowabuse_updated", ET_Ignore, Param_Cell);
	
	g_fwdPlayerDeath = new GlobalForward("SMStats_OnPlayerDeath", ET_Ignore, Param_Cell, Param_Cell, Param_Array, Param_Array, Param_String, Param_Array);
	
	// internal
	CreateNative("_sm_stats_get_chattag", Native_GetChatTag);
	CreateNative("_sm_stats_get_serverid", Native_GetServerID);
	CreateNative("_sm_stats_get_sql", Native_GetSQL);
	CreateNative("_sm_stats_get_allowbots", Native_GetAllowBots);
	CreateNative("_sm_stats_get_minplayers", Native_GetMinPlayers);
	CreateNative("_sm_stats_get_deathpoints", Native_GetDeathPoints);
	CreateNative("_sm_stats_get_allowabuse", Native_GetAllowAbuse);
	CreateNative("_sm_stats_get_allowwarmup", Native_GetAllowWarmup);
	CreateNative("_sm_stats_get_disableafterroundend", Native_GetDisableAfterRoundEnd);
	CreateNative("_sm_stats_player_death_fwd", Native_PlayerDeathFwd);
	
	// translations
	LoadTranslations("sm_stats.phrases");
	
	return APLRes_Success;
}

public void OnPluginStart()
{
	CheckDatabase(true);
	
	ConVar cvar = CreateConVar("sm_stats_chattag", "{green}[SM Stats]", "SM Stats - Chat tag prefix.");
	cvar.AddChangeHook(OnChatTagUpdated);
	cvar.GetString(g_ChatTag, sizeof(g_ChatTag));
	Format(g_ChatTag, sizeof(g_ChatTag), "%s{default}", g_ChatTag);
	
	//
	
	g_ServerID = CreateConVar("sm_stats_serverid", "1", "SM Stats - Server ID.", _, true, 1.0);
	g_ServerID.AddChangeHook(OnServerIDUpdated);
	
	g_AllowBots = CreateConVar("sm_stats_allow_bots", "1", "SM Stats - Allow bots.", _, true, _, true, 1.0);
	g_AllowBots.AddChangeHook(OnAllowBotsUpdated);
	
	g_MinPlayers = CreateConVar("sm_stats_min_players", "4", "SM Stats - Minimum players required for statistical tracking.", _, true, 1.0);
	g_MinPlayers.AddChangeHook(OnMinPlayersUpdated);
	
	g_AllowAbuse = CreateConVar("sm_stats_allow_abuse", "0", "SM Stats - Allow abuse of commands during events such as Noclip or sv_cheats 1.", _, true, _, true, 1.0);
	g_AllowAbuse.AddChangeHook(OnAllowAbuseUpdated);
	
	g_AllowWarmup = CreateConVar("sm_stats_allow_warmup", "0", "SM Stats - Allow tracking during warmup.", _, true, _, true, 1.0);
	
	g_DisableAfterRoundEnd = CreateConVar("sm_stats_disable_after_round_end", "1", "SM Stats - Disable after round end.", _, true, _, true, 1.0);
	
	g_DeathPoints = CreateConVar("sm_stats_points_death", "10", "SM Stats - Points taken when dying.", _, true);
	
	AutoExecConfig(true);
}

public void OnAllPluginsLoaded()
{
	Call_StartForward(g_fwdLoaded);
	Call_Finish();
}

void OnChatTagUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	Format(g_ChatTag, sizeof(g_ChatTag), "%s{default}", newvalue);
	Call_StartForward(g_fwdChatTagUpdated);
	Call_PushString(g_ChatTag);
	Call_Finish();
}

void OnServerIDUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	Call_StartForward(g_fwdServerIDUpdated);
	Call_PushCell(cvar.IntValue);
	Call_Finish();
}

void OnAllowBotsUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	Call_StartForward(g_fwdAllowBotsUpdated);
	Call_PushCell(cvar.IntValue);
	Call_Finish();
}

void OnMinPlayersUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	Call_StartForward(g_fwdMinPlayersUpdated);
	Call_PushCell(cvar.IntValue);
	Call_Finish();
}

void OnAllowAbuseUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	Call_StartForward(g_fwdAllowAbuseUpdated);
	Call_PushCell(cvar.IntValue);
	Call_Finish();
}

public void OnMapStart()
{
	CheckDatabase();
}

/* ================================================================ */
// sql

void CheckDatabase(bool bOnPluginStart=false)
{
	if(!!sql)
	{
		return;
	}
	
	if(!SQL_CheckConfig(_sm_stats_db))
	{
		SetFailState("%s Database entry '%s' wasn't found in \\configs\\databases.cfg, make sure you've entered it correctly.", core_chattag, _sm_stats_db);
	}
	
	// avoid double connection try, because we only want to pull table insertions on plugin start.
	CreateTimer(bOnPluginStart ? 0.0 : 0.5, Timer_CheckDatabase, bOnPluginStart);
}

Action Timer_CheckDatabase(Handle timer, bool bOnPluginStart)
{
	if(!sql)
	{
		Database.Connect(DBConnect, _sm_stats_db, bOnPluginStart);
	}
	
	return Plugin_Continue;
}

void DBConnect(Database database, const char[] error, bool bOnPluginStart)
{
	if(!database)
	{
		SetFailState("%s Database connection failed! (%s)", core_chattag, error);
	}
	
	sql = database;
	sql.SetCharset("utf8mb4");
	PrintToServer("%s Database connected", core_chattag);
	
	Call_StartForward(g_fwdDBLoaded);
	Call_PushCell(sql);
	Call_PushCell(bOnPluginStart);
	Call_Finish();
}

/* ================================================================ */
// natives

any Native_GetChatTag(Handle plugin, int params)
{
	return SetNativeString(1, g_ChatTag, GetNativeCell(2));
}

any Native_GetServerID(Handle plugin, int params)
{
	return g_ServerID.IntValue;
}

any Native_GetSQL(Handle plugin, int params)
{
	return sql;
}

any Native_GetAllowBots(Handle plugin, int params)
{
	return g_AllowBots.BoolValue;
}

any Native_GetMinPlayers(Handle plugin, int params)
{
	return g_MinPlayers.IntValue;
}

any Native_GetDeathPoints(Handle plugin, int params)
{
	return g_DeathPoints.IntValue;
}

any Native_GetAllowAbuse(Handle plugin, int params)
{
	return g_AllowAbuse.BoolValue;
}

any Native_GetAllowWarmup(Handle plugin, int params)
{
	return g_AllowWarmup.BoolValue;
}

any Native_GetDisableAfterRoundEnd(Handle plugin, int params)
{
	return g_DisableAfterRoundEnd.BoolValue;
}

any Native_PlayerDeathFwd(Handle plugin, int params)
{
	int attacker = GetNativeCell(1);
	int frags = GetNativeCell(2);
	
	int[] userids = new int[frags];
	GetNativeArray(3, userids, frags);
	
	int[] assisters = new int[frags];
	GetNativeArray(4, assisters, frags);
	
	int maxlen = GetNativeStrLen(5);
	char[] classname = new char[maxlen];
	GetNativeString(5, classname, maxlen);
	
	int[] itemdef = new int[frags];
	GetNativeArray(6, itemdef, frags);
	
	Call_StartForward(g_fwdPlayerDeath);
	Call_PushCell(attacker);
	Call_PushCell(frags);
	Call_PushArray(userids, frags);
	Call_PushArray(assisters, frags);
	Call_PushString(classname);
	Call_PushArray(itemdef, frags);
	Call_Finish();
	
	return 0;
}

/**
 *	Retrieves the actual string length from a native parameter string.
 *	This is useful for fetching the entire string using dynamic arrays.
 *
 *	@note	If this function succeeds, Get/SetNativeString will also succeed.
 *
 *	@param	param	Parameter number, starting from 1.
 *	
 *	@error	Invalid parameter number or calling from a non-native function.
 */
int GetNativeStrLen(int param)
{
	int length;
	GetNativeStringLength(param, length);
	return length+1;
}