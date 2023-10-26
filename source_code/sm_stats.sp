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
GlobalForward g_fwdDBLoaded; // internal call to initialize database connection.
GlobalForward g_fwdTypeUpdated; // internal call to forward updated values.

GlobalForward g_fwdPlayerDeath; // built in player_death event based forward.

char g_ChatTag[96]; // global chat tag prefix.
char g_sndConnectedTop10[96]; // play a sound when a top 10 player connects.
char g_sndConnectedTop1[96]; // play a sound when the top 1 player connects.
bool bCachedSndConTop10;
bool bCachedSndConTop1;
ConVar g_ServerID; // server id.
ConVar g_MinPlayers; // minimum required players for statistical tracking.
ConVar g_AllowBots; // allow bots.
ConVar g_AllowAbuse; // allow abuse of commands during events.
ConVar g_AllowWarmup; // allow tracking during warmup.
ConVar g_DisableAfterRoundEnd; // disable tracking after round end.
ConVar g_DeathPoints; // death points.
ConVar g_AssistPoints; // assist points.
ConVar g_PenaltySeconds; // seconds for the penalty.
ConVar g_ConSndTop10; // Top 10 player connected.
ConVar g_ConSndTop1; // Top 1 player connected.

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	RegPluginLibrary("SMStats");
	
	// forwards
	g_fwdLoaded = new GlobalForward("_sm_stats_loaded_core", ET_Ignore);
	g_fwdDBLoaded = new GlobalForward("_sm_stats_loaded_sql", ET_Ignore, Param_Cell, Param_Cell);
	
	g_fwdTypeUpdated = new GlobalForward("_sm_stats_updatedfwd", ET_Ignore, Param_Cell, Param_String);
	
	g_fwdPlayerDeath = new GlobalForward("SMStats_OnPlayerDeath", ET_Ignore, Param_Cell, Param_Cell, Param_Array, Param_Array, Param_String, Param_Array);
	
	// internal
	CreateNative("_sm_stats_get_chattag", Native_GetChatTag);
	CreateNative("_sm_stats_get_serverid", Native_GetServerID);
	CreateNative("_sm_stats_get_sql", Native_GetSQL);
	CreateNative("_sm_stats_get_minplayers", Native_GetMinPlayers);
	CreateNative("_sm_stats_get_deathpoints", Native_GetDeathPoints);
	CreateNative("_sm_stats_get_assistpoints", Native_GetAssistPoints);
	CreateNative("_sm_stats_get_penaltyseconds", Native_GetPenaltySeconds);
	CreateNative("_sm_stats_get_allowbots", Native_GetAllowBots);
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
	cvar.AddChangeHook(OnUpdatedChatTag);
	cvar.GetString(g_ChatTag, sizeof(g_ChatTag));
	Format(g_ChatTag, sizeof(g_ChatTag), "%s{default}", g_ChatTag);
	
	//
	
	g_ServerID = CreateConVar("sm_stats_serverid", "1", "SM Stats - Server ID.", _, true, 1.0);
	g_ServerID.AddChangeHook(OnUpdatedServerID);
	
	g_AllowBots = CreateConVar("sm_stats_allow_bots", "1", "SM Stats - Allow bots.", _, true, _, true, 1.0);
	g_AllowBots.AddChangeHook(OnUpdatedAllowBots);
	
	g_MinPlayers = CreateConVar("sm_stats_min_players", "4", "SM Stats - Minimum players required for statistical tracking.", _, true, 1.0);
	g_MinPlayers.AddChangeHook(OnUpdatedMinPlayers);
	
	g_AllowAbuse = CreateConVar("sm_stats_allow_abuse", "0", "SM Stats - Allow abuse of commands during events such as Noclip or sv_cheats 1.", _, true, _, true, 1.0);
	g_AllowAbuse.AddChangeHook(OnUpdatedAllowAbuse);
	
	g_AllowWarmup = CreateConVar("sm_stats_allow_warmup", "0", "SM Stats - Allow tracking during warmup.", _, true, _, true, 1.0);
	g_AllowWarmup.AddChangeHook(OnUpdatedAllowWarmup);
	
	g_DisableAfterRoundEnd = CreateConVar("sm_stats_disable_after_round_end", "1", "SM Stats - Disable after round end.", _, true, _, true, 1.0);
	g_AllowWarmup.AddChangeHook(OnUpdatedDisableAfterRoundEnd);
	
	g_DeathPoints = CreateConVar("sm_stats_points_death", "10", "SM Stats - Points taken when dying.", _, true);
	g_DeathPoints.AddChangeHook(OnUpdatedDeathPoints);
	
	g_AssistPoints = CreateConVar("sm_stats_points_assist", "5", "SM Stats - Points given when assisting.", _, true);
	g_DeathPoints.AddChangeHook(OnUpdatedAssistPoints);
	
	g_PenaltySeconds = CreateConVar("sm_stats_penalty_seconds", "3600", "SM Stats - Seconds of the points-spam penalty.", _, true);
	g_PenaltySeconds.AddChangeHook(OnUpdatedPenaltySeconds);
	
	g_ConSndTop10 = CreateConVar("sm_stats_connectsound_top10", "sm_stats/connect_top10.wav", "SM Stats - Sound from game/sound/ directory to play to players when a top 10 player has connected.");
	g_ConSndTop10.AddChangeHook(OnUpdatedConSndTop10);
	g_ConSndTop10.GetString(g_sndConnectedTop10, sizeof(g_sndConnectedTop10));
	CacheConnectSound(g_sndConnectedTop10, true, true);

	g_ConSndTop1 = CreateConVar("sm_stats_connectsound_top1", "sm_stats/connect_top10.wav", "SM Stats - Sound from game/sound/ directory to play to players when the top 1 player has connected. ");
	g_ConSndTop1.AddChangeHook(OnUpdatedConSndTop1);
	g_ConSndTop1.GetString(g_sndConnectedTop1, sizeof(g_sndConnectedTop1));
	CacheConnectSound(g_sndConnectedTop1, false, true);

	AutoExecConfig(true);
	
	RegAdminCmd("sm_stats_reload", SMStatsReloadCmd, ADMFLAG_ROOT, "SM Stats - Reload core plugin.");
}

Action SMStatsReloadCmd(int client, int args)
{
	ReplyToCommand(client, "[SM Stats: Core] Forced reloading SMStats core plugin, expect SQL errors..");
	
	char plugin_name[64];
	GetPluginFilename(null, plugin_name, sizeof(plugin_name));
	ServerCommand("sm plugins reload \"%s\"", plugin_name);
	return Plugin_Continue;
}

public void OnConfigsExecuted()
{
	Call_StartForward(g_fwdLoaded);
	Call_Finish();
}

void OnUpdatedChatTag(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	cvar.GetString(g_ChatTag, sizeof(g_ChatTag));
	Format(g_ChatTag, sizeof(g_ChatTag), "%s{default}", newvalue);
	SendUpdatedFwdValue(SMStatsUpdated_ChatTag, g_ChatTag);
}
void OnUpdatedServerID(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	char str_value[11];
	IntToString(cvar.IntValue, str_value, sizeof(str_value));
	SendUpdatedFwdValue(SMStatsUpdated_ServerID, str_value);
}
void OnUpdatedAllowBots(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	char str_value[2];
	IntToString(view_as<int>(cvar.BoolValue), str_value, sizeof(str_value));
	SendUpdatedFwdValue(SMStatsUpdated_AllowBots, str_value);
}
void OnUpdatedMinPlayers(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	char str_value[11];
	IntToString(cvar.IntValue, str_value, sizeof(str_value));
	SendUpdatedFwdValue(SMStatsUpdated_MinPlayers, str_value);
}
void OnUpdatedAllowAbuse(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	char str_value[2];
	IntToString(view_as<bool>(cvar.BoolValue), str_value, sizeof(str_value));
	SendUpdatedFwdValue(SMStatsUpdated_AllowAbuse, str_value);
}
void OnUpdatedAllowWarmup(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	char str_value[2];
	IntToString(view_as<bool>(cvar.BoolValue), str_value, sizeof(str_value));
	SendUpdatedFwdValue(SMStatsUpdated_AllowWarmup, str_value);
}
void OnUpdatedDisableAfterRoundEnd(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	char str_value[2];
	IntToString(view_as<bool>(cvar.BoolValue), str_value, sizeof(str_value));
	SendUpdatedFwdValue(SMStatsUpdated_DisableAfterRoundEnd, str_value);
}
void OnUpdatedDeathPoints(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	char str_value[11];
	IntToString(cvar.IntValue, str_value, sizeof(str_value));
	SendUpdatedFwdValue(SMStatsUpdated_DeathPoints, str_value);
}
void OnUpdatedAssistPoints(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	char str_value[11];
	IntToString(cvar.IntValue, str_value, sizeof(str_value));
	SendUpdatedFwdValue(SMStatsUpdated_AssistPoints, str_value);
}
void OnUpdatedPenaltySeconds(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	char str_value[24];
	IntToString(cvar.IntValue, str_value, sizeof(str_value));
	SendUpdatedFwdValue(SMStatsUpdated_PenaltySeconds, str_value);
}
void OnUpdatedConSndTop10(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	cvar.GetString(g_sndConnectedTop10, sizeof(g_sndConnectedTop10));
	if(CacheConnectSound(g_sndConnectedTop10, true))
	{
		SendUpdatedFwdValue(SMStatsUpdated_SndConnectedTop10, g_sndConnectedTop10);
	}
}
void OnUpdatedConSndTop1(ConVar cvar, const char[] oldvalue, const char[] newvalue)
{
	cvar.GetString(g_sndConnectedTop1, sizeof(g_sndConnectedTop1));
	if(CacheConnectSound(g_sndConnectedTop1, false))
	{
		SendUpdatedFwdValue(SMStatsUpdated_SndConnectedTop1, g_sndConnectedTop1);
	}
}

public void OnMapStart()
{
	CheckDatabase();
	
	if(bCachedSndConTop10)
	{
		AddFileToDownloadsTable(g_sndConnectedTop10);
	}
	if(bCachedSndConTop1)
	{
		AddFileToDownloadsTable(g_sndConnectedTop1);
	}
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
any Native_GetAssistPoints(Handle plugin, int params)
{
	return g_AssistPoints.IntValue;
}
any Native_GetPenaltySeconds(Handle plugin, int params)
{
	return g_PenaltySeconds.IntValue;
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

//

void SendUpdatedFwdValue(SMStatsUpdatedFwdType type, const char[] value)
{
	Call_StartForward(g_fwdTypeUpdated);
	Call_PushCell(type);
	Call_PushString(value);
	Call_Finish();
}

//

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

//

bool CacheConnectSound(const char[] sound_path, bool top_10, bool bPluginStart=false)
{
	if(strlen(sound_path) < 1)
	{
		if(!bPluginStart)
		{
			PrintToServer("%s Top %i player connect sound file path '%s' is NULL, disabling..", core_chattag, top_10?10:1, sound_path);
		}
		switch(top_10)
		{
			case false: bCachedSndConTop1 = false;
			case true: bCachedSndConTop10 = false;
		}
		return false;
	}
	
	switch(top_10)
	{
		case false:
		{
			if(!bCachedSndConTop1)
			{
				int maxlen = strlen(sound_path)+6; // character lenth of 'sound/' + 1 for correct string length.
				char[] snd_fmt = new char[maxlen];
				Format(snd_fmt, maxlen, "sound/%s", snd_fmt);
				PrecacheSound(snd_fmt);
				bCachedSndConTop1 = true;
			}
		}
		case true:
		{
			if(!bCachedSndConTop10)
			{
				int maxlen = strlen(sound_path)+6;
				char[] snd_fmt = new char[maxlen];
				Format(snd_fmt, maxlen, "sound/%s", snd_fmt);
				PrecacheSound(snd_fmt);
				bCachedSndConTop10 = true;
			}
		}
	}
	
	return true;
}