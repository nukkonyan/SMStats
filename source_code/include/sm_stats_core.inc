#include <sdkhooks>
#include <geoip_country>
#include <multicolors>
#include <unixtime_sourcemod>
#undef REQUIRE_PLUGIN
#include <sm_stats_info>

stock char str_statsCmd[][] =
{
	"sm_stat",
	"sm_stats",
};
stock char str_cmdMenu[][] =
{
	"sm_rank",
	"sm_ranks",
	"sm_top10",
	"sm_top",
	"sm_plats",
	"sm_placering",
	"sm_placerad",
	"sm_rang",
	"sm_topp",
	"sm_topp10"
};

//

#define queryId_frag_assister 0
#define queryId_frag_weapon 1
#define queryId_frag_victim_death 2
#define queryId_frag_playerlist 3
#define queryId_frag_playerlist_MapUpdate 4
#define queryId_object_placed 5
#define queryId_object_placed_MapUpdate 6
#define queryId_object_destroyed 7
#define queryId_object_destroyed_MapUpdate 8
stock char g_strTXNqueryId[][] = 
{
	/*0*/"frag event: assister",
	/*1*/"frag event: weapon",
	/*2*/"frag event: victim death",
	/*3*/"frag event: playerlist",
	/*4*/"frag event: playerlist map update",
	/*5*/"object event: placed",
	/*6*/"object event: placed map update",
	/*7*/"object event: destroyed",
	/*8*/"object event: destroyed map update",
};

//

enum PointsSplitType
{
	PointSplit_Off = 0,
	PointSplit_On = 1,
	PointSplit_Minus = 2,
	PointSplit_Plus = 3
}

//

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active chat tag.
 *
 *	@param	tag		The buffer to store the tag.
 *	@param	maxlen	The maximum length of the tag.
 *	@noreturn
 */
native void _sm_stats_get_chattag(char[] tag, int maxlen);

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active stats id.
 */
native int _sm_stats_get_statsid();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active database connection.
 */
native Database _sm_stats_get_sql();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the boolean status of debugging mode.
 */
native bool _sm_stats_get_debug();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the boolean status of bots being allowed.
 */
native bool _sm_stats_get_allowbots();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active death points.
 */
native int _sm_stats_get_deathpoints();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active assist points.
 */
native int _sm_stats_get_assistpoints();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the boolean status of warmup being allowed.
 */
native bool _sm_stats_get_allowwarmup();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the boolean status of abuse being allowed. (Noclip, etc)
 */
native bool _sm_stats_get_allowabuse();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the boolean status if stats are disabled after win.
 */
native bool _sm_stats_get_disableafterroundend();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active minimum players required to track statistics.
 */
native int _sm_stats_get_minplayers();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the seconds for penalty.
 */
native int _sm_stats_get_penaltyseconds();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the connect sounds.
 */
native int _sm_stats_get_connectsounds(char[] snd_top1, char[] snd_top10, char[] snd_generic);

/*
 *	SourceMod Stats: Core.
 *	Call the player death forward.
 */
native void _sm_stats_player_death_fwd(int attacker, int frags, int[] userids, int[] assisters, const char[] classname, int[] itemdef);

// crucial stuff, re-instate lost data after restart.
native void _sm_stats_info_update_stats_active(bool bStatsActive);
native void _sm_stats_info_update_round_active(bool bRoundActive);
native void _sm_stats_info_update_maptimer(int iMapTimerSeconds);
native void _sm_stats_info_save_crucial_stuff(bool bLoaded, bool bStatsActive, bool bRoundActive, int iMapTimerSeconds);
native void _sm_stats_info_get_crucial_stuff(any[] this_way_with_arrays_sucks_pls_add_SetNativeCell);

/*
 * Removes the player from the SMStats statistical database.
 * This is used with a ban plugin such as SourceBans++.
 * Writes a chat message that the player has been detected banned.
 *
 * @param	auth					The users authentication id.
 * @param	only_same_gameserver	If true, only removes the player from all tracking on same game as the server where player were banned on is using.
 *
 * @noreturn
 */
native void _sm_stats_detect_ban_player_auth(const char[] auth, bool only_same_gameserver=false);

/*
 * Removes the player from the SMStats statistical database.
 * This is used with a ban plugin such as SourceBans++.
 * Writes a chat message that the player has been detected ip banned.
 *
 * @param	ip						ip address.
 * @param	only_same_gameserver	If true, only removes the player from all tracking on same game as the server where player were banned on is using.
 *
 * @noreturn
 */
native void _sm_stats_detect_ban_player_ip(const char[] ip, bool only_same_gameserver=false);

#if defined load_plugin_core

// default important things

#define sql_table_playerlist "playerlist_"...GameType
#define sql_table_weapons "weapons_"...GameType
#define sql_table_kill_log "kill_log_"...GameType
#define sql_table_item_log "item_log_"...GameType
#define sql_table_maps_log "maps_log_"... GameType
#define sql_table_achievements "achievements_"... GameType
#define sql_table_settings "settings"
#define game_translation "sm_stats_"... GameType...".phrases"
#define ach_translation "sm_stats_"... GameType..."_achievements.phrases"

#define ITEMDEF_INVALID -1

char g_ChatTag[96];
char g_sndConnectedTop10[96]
, g_sndConnectedTop1[96]
, g_sndConnectedGeneric[96];
Database sql = null;
bool bDebug = false;
bool bLoaded = false;
bool bStatsActive = false;
bool bRoundActive = false;
bool bWarmupActive = false;
bool bDisableAfterRoundEnd = false;
bool bAllowBots = false;
bool bAllowAbuse = false;
bool bAllowWarmup = false;
int g_StatsID = -1;
int g_TotalTablePlayers = -1;
int g_MinPlayers = -1;
int g_DeathPoints = -1;
int g_AssistPoints = -1;
int g_PenaltySeconds = -1;

SMStats_PlayerInfo g_Player[MaxPlayers+1];

PrivateForward g_GetPlayerSessionInfoFwd;

// map load event
int iMapTimerSeconds = 0;
Handle hMapTimerSeconds = null
Handle hMapTimer = null;
Handle hGameTimer = null;
char cMap[64];

public void _sm_stats_loaded_core()
{
	PrintToServer(core_chattag..." Version "...Version..." (https://github.com/SMStats)");
	LogToGame(core_chattag..." Version "...Version..." (https://github.com/SMStats)");
	bLoaded = true;
	
	_sm_stats_get_chattag(g_ChatTag, sizeof(g_ChatTag));
	_sm_stats_get_connectsounds(g_sndConnectedTop1, g_sndConnectedTop10, g_sndConnectedGeneric);
	g_StatsID = _sm_stats_get_statsid();
	bDebug = _sm_stats_get_debug();
	bAllowBots = _sm_stats_get_allowbots();
	bAllowAbuse = _sm_stats_get_allowabuse();
	bAllowWarmup = _sm_stats_get_allowwarmup();
	bDisableAfterRoundEnd = _sm_stats_get_disableafterroundend();
	g_MinPlayers = _sm_stats_get_minplayers();
	g_DeathPoints = _sm_stats_get_deathpoints();
	g_AssistPoints = _sm_stats_get_assistpoints();
	g_PenaltySeconds = _sm_stats_get_penaltyseconds();
	
	CreateTimer(5.0, Timer_PluginLoaded);
}

void PrepareTranslations()
{
	LoadTranslations("sm_stats.phrases");
	LoadTranslations(game_translation);
	GeoipCountryLoadTranslation();
}

public void _sm_stats_updatedfwd(SMStatsUpdatedFwdType type, const char[] value)
{
	switch(type)
	{
		case SMStatsUpdated_ChatTag: strcopy(g_ChatTag, sizeof(g_ChatTag), value);
		case SMStatsUpdated_StatsID: g_StatsID = StringToInt(value);
		case SMStatsUpdated_AllowBots:
		{
			bAllowBots = view_as<bool>(StringToInt(value));
			CheckActivePlayers();
		}
		case SMStatsUpdated_AllowAbuse: bAllowAbuse = view_as<bool>(StringToInt(value));
		case SMStatsUpdated_AllowWarmup: bAllowWarmup = view_as<bool>(StringToInt(value));
		case SMStatsUpdated_DisableAfterRoundEnd: bDisableAfterRoundEnd = view_as<bool>(StringToInt(value));
		case SMStatsUpdated_MinPlayers:
		{
			g_MinPlayers = StringToInt(value);
			CheckActivePlayers();
		}
		case SMStatsUpdated_DeathPoints: g_DeathPoints = view_as<int>(StringToInt(value));
		case SMStatsUpdated_AssistPoints: g_AssistPoints = view_as<int>(StringToInt(value));
		case SMStatsUpdated_SndConnectedTop10: strcopy(g_sndConnectedTop10, sizeof(g_sndConnectedTop10), value);
		case SMStatsUpdated_SndConnectedTop1: strcopy(g_sndConnectedTop1, sizeof(g_sndConnectedTop1), value);
		case SMStatsUpdated_SndConnectedGeneric: strcopy(g_sndConnectedGeneric, sizeof(g_sndConnectedGeneric), value);
		case SMStatsUpdated_Debug: bDebug = view_as<bool>(StringToInt(value));
	}
}

public void OnPluginStart()
{
	PrepareTranslations();
	PrepareGame();
	
	#if defined load_menus
	LoadMenus();
	#endif
	
	#if defined load_forwards
	LoadForwardEvents();
	#endif
	
	#if defined assister_func
	LoadAssisterEvents();
	#endif
	
	RegAdminCmd("sm_stats_erase_database", _sm_stats_erase_db_cmd, ADMFLAG_ROOT, "SMStats: Core - Erase all database information.");
	
	// plugin was restarted, manually or via update.
	// make sure the natives are loaded.
	if(SMStatsInfo.IsLoaded())
	{
		SMStatsInfo_CrucialStuff this_way_with_arrays_sucks_pls_add_SetNativeCell;
		_sm_stats_info_get_crucial_stuff(this_way_with_arrays_sucks_pls_add_SetNativeCell);
		if(this_way_with_arrays_sucks_pls_add_SetNativeCell.bLoaded)
		{
			bLoaded = true;
		}
		if(this_way_with_arrays_sucks_pls_add_SetNativeCell.bStatsActive)
		{
			bStatsActive = true;
		}
		if(this_way_with_arrays_sucks_pls_add_SetNativeCell.bRoundActive)
		{
			bRoundActive = true;
		}
		if(this_way_with_arrays_sucks_pls_add_SetNativeCell.iMapTimerSeconds > 0)
		{
			iMapTimerSeconds = this_way_with_arrays_sucks_pls_add_SetNativeCell.iMapTimerSeconds;
		}
		
		PrintToServer(core_chattag..." Version "...Version..." (https://github.com/SMStats)");
		LogToGame(core_chattag..." Version "...Version..." (https://github.com/SMStats)");
		
		_sm_stats_get_chattag(g_ChatTag, sizeof(g_ChatTag));
		_sm_stats_get_connectsounds(g_sndConnectedTop1, g_sndConnectedTop10, g_sndConnectedGeneric);
		g_StatsID = _sm_stats_get_statsid();
		bDebug = _sm_stats_get_debug();
		bAllowBots = _sm_stats_get_allowbots();
		bAllowAbuse = _sm_stats_get_allowabuse();
		bAllowWarmup = _sm_stats_get_allowwarmup();
		bDisableAfterRoundEnd = _sm_stats_get_disableafterroundend();
		g_MinPlayers = _sm_stats_get_minplayers();
		g_DeathPoints = _sm_stats_get_deathpoints();
		g_AssistPoints = _sm_stats_get_assistpoints();
		g_PenaltySeconds = _sm_stats_get_penaltyseconds();
		
		if(SMStats.IsLoaded())
		{
			if((sql = _sm_stats_get_sql()) != null)
			{
				_sm_stats_loaded_sql(sql, true);
			}
			
			CreateTimer(1.25, Timer_OnRestarted);
		}
	}
}

Action Timer_OnRestarted(Handle timer)
{
	CheckActivePlayers();
	CreateTimer(0.5, Timer_PluginLoaded);
	return Plugin_Continue;
}

//

char g_strTableName[][] =
{
	/*0*/sql_table_playerlist
	/*1*/,sql_table_weapons
	/*2*/,sql_table_kill_log
	/*3*/,sql_table_item_log
	/*4*/,sql_table_maps_log
	/*5*/,sql_table_achievements
	/*6*/,sql_table_settings
};

public void _sm_stats_loaded_sql(Database database, bool bOnPluginStart)
{
	sql = database;
	
	LogToGame(core_chattag..." : Caught database connection.");
	
	if(bOnPluginStart)
	{
		File file;
		char path[64], query[16177], table[128];
		int len;
		
		#if defined sql_loadtable_playerlist
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql_table_playerlist);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				SetFailState("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for statistical tracking.), Did you install it correctly?", sql_table_playerlist);
			}
			
			case true:
			{
				while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))
				{
					ReplaceString(table, sizeof(table), "\n", "");
					ReplaceString(table, sizeof(table), "\r", "");
					ReplaceString(table, sizeof(table), "\t", "");
					
					len += Format(query[len], sizeof(query)-len, table);
				}
				
				sql.Query(DBQuery_InsertTables, query, 0);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		#if defined sql_loadtable_weapons
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql_table_weapons);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				SetFailState("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for tracking weapon frags.), Did you install it correctly?", sql_table_weapons);
			}
			
			case true:
			{
				while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))
				{
					ReplaceString(table, sizeof(table), "\n", "");
					ReplaceString(table, sizeof(table), "\r", "");
					ReplaceString(table, sizeof(table), "\t", "");
					
					len += Format(query[len], sizeof(query)-len, table);
				}
				
				sql.Query(DBQuery_InsertTables, query, 1);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		#if defined sql_loadtable_kill_log
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql_table_kill_log);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				SetFailState("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for tracking frag events.), Did you install it correctly?", sql_table_kill_log);
			}
			
			case true:
			{
				while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))
				{
					ReplaceString(table, sizeof(table), "\n", "");
					ReplaceString(table, sizeof(table), "\r", "");
					ReplaceString(table, sizeof(table), "\t", "");
					
					len += Format(query[len], sizeof(query)-len, table);
				}
				
				sql.Query(DBQuery_InsertTables, query, 1);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		#if defined sql_loadtable_item_log
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql_table_item_log);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				LogError("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for tracking items found, traded, unboxed, etc.), Did you install it correctly?"
				, sql_table_item_log);
			}
			
			case true:
			{
				while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))
				{
					ReplaceString(table, sizeof(table), "\n", "");
					ReplaceString(table, sizeof(table), "\r", "");
					ReplaceString(table, sizeof(table), "\t", "");
					
					len += Format(query[len], sizeof(query)-len, table);
				}
				
				sql.Query(DBQuery_InsertTables, query, 4);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		#if defined sql_loadtable_maps_log
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql_table_maps_log);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				LogError("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for tracking maps.), Did you install it correctly?", sql_table_maps_log);
			}
			
			case true:
			{
				while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))
				{
					ReplaceString(table, sizeof(table), "\n", "");
					ReplaceString(table, sizeof(table), "\r", "");
					ReplaceString(table, sizeof(table), "\t", "");
					
					len += Format(query[len], sizeof(query)-len, table);
				}
				
				sql.Query(DBQuery_InsertTables, query, 4);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		#if defined sql_loadtable_achievements
		// achievements here
		#endif
		
		//
		
		#if defined sql_loadtable_settings
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql_table_settings);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				LogError("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for saving settings.), Did you install it correctly?", sql_table_settings);
			}
			
			case true:
			{
				while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))
				{
					ReplaceString(table, sizeof(table), "\n", "");
					ReplaceString(table, sizeof(table), "\r", "");
					ReplaceString(table, sizeof(table), "\t", "");
					
					len += Format(query[len], sizeof(query)-len, table);
				}
				
				sql.Query(DBQuery_InsertTables, query, 6);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		
		int client = 0;
		while((client = FindEntityByClassname(client, "player")) > 0)
		{
			if(IsValidClient(client))
			{
				OnClientConnected(client);
			}
		}
	}
}

void DBQuery_InsertTables(Database database, DBResultSet results, const char[] error, int query_id)
{
	if(!results)
	{
		LogError("%s Failed to insert database table '%s'"
		... "\nMake sure the database connection is available or file is correct."
		... "\nError: %s", core_chattag, g_strTableName[query_id], error);
	}
}

stock void CallbackQuery(const char[] query, int unique_query_id, any ...)
{
	int maxlen = strlen(query)+1025;
	char[] format = new char[maxlen];
	VFormat(format, maxlen, query, 3);
	sql.Query(DBQuery_Callback, format, unique_query_id);
}
stock void DBQuery_Callback(Database database, DBResultSet results, const char[] error, int unique_query_id)
{	
	if(!results)
	{
		LogError("\n%s Failed to query id %i"
		... "\nMake sure the database connection is available."
		... "\nError reason below:"
		... "\n%s", core_chattag, unique_query_id, error);
	}
}
stock void TXN_Callback_Failure(Database db, int unique_query_id, int numQueries, const char[] error, int failIndex, any[] queryData)
{
	LogError("\n"...core_chattag..." Failed to query id %i"
	... "\nMake sure the database connection is available and/or stable."
	... "\nError reason below:"
	... "\n%s", unique_query_id, error);
}
stock void TXN_OnGameFrameCallback_Failure(Database db, any data, int numQueries, const char[] error, int failIndex, int[] query_id)
{
	LogError("\n"...core_chattag..." MapTimer_GameTimer() : Query id %i failed (%i Total queries)"
	... "\nMake sure the database connection is available and/or stable."
	... "\nError reason below:"
	... "\n%s", query_id[failIndex], numQueries, error);
}

//

Action Timer_PluginLoaded(Handle timer)
{
	// plugin may have just reloaded.
	
	int client = 0;
	while((client = FindEntityByClassname(client, "player")) != -1)
	{
		if(IsValidClient(client, false))
		{
			// obtain the names.
			GetPlayerName(client, g_Player[client].name, sizeof(g_Player[].name));
			
			#if defined load_players
			if(!IsFakeClient(client))
			{
				CPrintToChat(client, "{lightgreen}%s %T", core_chattag, "#SMStats_VersionLoaded", client, Version);
			}
			#endif
		}
	}
	
	return Plugin_Continue;
}


// weapons
enum struct CvarWeapon
{
	int itemdef;
	ConVar cvar;
}
ArrayList g_arrayWeapons;
stock void array_InitializeWeapons()
{
	g_arrayWeapons = new ArrayList(sizeof(CvarWeapon));
}
stock void array_AddWeapon(int itemdef, const char[] cvar_name, int value, char[] description)
{
	char str_value[11];
	IntToString(value, str_value, sizeof(str_value));
	
	int maxlen = strlen(description)+52;
	char[] fixed = new char[maxlen];
	Format(fixed, maxlen, "%s - Points earned when fragging with %s.", core_chattag2, description);
	
	CvarWeapon array;
	array.itemdef = itemdef;
	array.cvar = CreateConVar(cvar_name, str_value, fixed, _, true);
	g_arrayWeapons.PushArray(array, sizeof(array));
}
stock void array_AddSameWeapon(int itemdef1, int itemdef2)
{
	int index = -2;
	
	if((index = g_arrayWeapons.FindValue(itemdef2)) != -1)
	{
		CvarWeapon get_array;
		g_arrayWeapons.GetArray(index, get_array, sizeof(get_array));
		
		CvarWeapon array;
		array.itemdef = itemdef1;
		array.cvar = get_array.cvar;
		g_arrayWeapons.PushArray(array, sizeof(array));
	}
}
stock ConVar array_GetWeapon(int itemdef)
{
	int index = -2;
	
	if((index = g_arrayWeapons.FindValue(itemdef)) != -1)
	{
		CvarWeapon array;
		g_arrayWeapons.GetArray(index, array, sizeof(array));
		
		return array.cvar;
	}
	
	return null;
}

// eraser

Action _sm_stats_erase_db_cmd(int client, int args)
{
	if(client != 0)
	{
		ReplyToCommand(client, "%s You must be console to proceed erasing active gameserver database information!", core_chattag);
		return Plugin_Handled;
	}
	
	if(!sql)
	{
		ReplyToCommand(client, "%s Failed erasing active gameserver database information on invalid database connection.", core_chattag);
		return Plugin_Handled;
	}
	
	if(args != 1)
	{
		ReplyToCommand(client, "%s You must choose to erase everything or a specific table:"
		... "\n 1 - Erase playerlist" ..." [ "...sql_table_playerlist..." ]"
		... "\n 2 - Erase weapons" ..." [ "...sql_table_weapons..." ]"
		... "\n 3 - Erase kill log" ..." [ "...sql_table_kill_log..." ]"
		... "\n 4 - Erase item log" ..." [ "...sql_table_item_log..." ]"
		... "\n 5 - Erase maps log" ..." [ "...sql_table_maps_log..." ]"
		... "\n 6 - Erase achievements" ..." [ "...sql_table_achievements..." ]"
		... "\n 7 - Erase settings" ..." [ "...sql_table_settings..." ]"
		... "\n 8 - Erase everything", core_chattag);
		return Plugin_Handled;
	}
	
	char str_id[2];
	if(GetCmdArg(1, str_id, sizeof(str_id)) < 1)
	{
		ReplyToCommand(client, "%s You must choose a valid table to erase, value cannot be NULL", core_chattag);
		return Plugin_Handled;
	}
	
	int id = StringToInt(str_id);
	
	ReplyToCommand(client, "%s Forced erasing active gameserver database information.. expect SQL errors..", core_chattag);
	_sm_stats_erase_database_config(client, id);
	return Plugin_Continue;
}

void _sm_stats_erase_database_config(int client, int id = 0)
{
	char query[256];
	Transaction txn = new Transaction();
	
	#if defined sql_loadtable_playerlist
	if(id == 1 || id == 8)
	{
		Format(query, sizeof(query), "drop table "...sql_table_playerlist);
		txn.AddQuery(query, 0);
	}
	#endif
	
	#if defined sql_loadtable_weapons
	if(id == 2 || id == 8)
	{
		Format(query, sizeof(query), "drop table "...sql_table_weapons);
		txn.AddQuery(query, 1);
	}
	#endif
	
	#if defined sql_loadtable_kill_log
	if(id == 3 || id == 8)
	{
		Format(query, sizeof(query), "drop table "...sql_table_kill_log);
		txn.AddQuery(query, 2);
	}
	#endif
	
	#if defined sql_loadtable_item_log
	if(id == 4 || id == 8)
	{
		Format(query, sizeof(query), "drop table "...sql_table_item_log);
		txn.AddQuery(query, 3);
	}
	#endif
	
	#if defined sql_loadtable_maps_log
	if(id == 5 || id == 8)
	{
		Format(query, sizeof(query), "drop table "...sql_table_maps_log);
		txn.AddQuery(query, 4);
	}
	#endif
	
	#if defined sql_loadtable_achievements_log
	if(id == 6)
	{
		Format(query, sizeof(query), "drop table "...sql_table_achievements);
		txn.AddQuery(query, 5);
	}
	#endif
	
	if(id == 7 || id == 8)
	{
		Format(query, sizeof(query), "drop table "...sql_table_settings);
		txn.AddQuery(query, 6);
	}
	
	sql.Execute(txn, TXN_EraseDatabaseConfig_OnSuccess, TXN_EraseDatabaseConfig_OnFailure, client);
}

stock void TXN_EraseDatabaseConfig_OnSuccess(Database db, any data , int numQueries, DBResultSet[] results, int[] queryData)
{
	char txt[512];
	int len = 0;
	
	len += FormatEx(txt[len], sizeof(txt)-len, "\n%s Removed %i tables:", core_chattag, numQueries);
	for(int i = 0; i < numQueries; i++)
	{
		len += FormatEx(txt[len], sizeof(txt)-len, "\nRemoved table '%s'", g_strTableName[queryData[i]]);
	}
	
	PrintToServer(txt);
}
stock void TXN_EraseDatabaseConfig_OnFailure(Database db, int client, int numQueries, const char[] error, int failIndex, any[] queryData)
{
	char txt[512];
	int len = 0;
	
	len += FormatEx(txt[len], sizeof(txt)-len, "\n%s Failed to remove %i tables:", core_chattag, numQueries);
	for(int i = 0; i < numQueries; i++)
	{
		len += FormatEx(txt[len], sizeof(txt)-len, "\ntable '%s'", g_strTableName[queryData[i]]);
	}
	
	len += FormatEx(txt[len], sizeof(txt)-len, "\nError reason below:\n%s", error);
	
	PrintToServer(txt);
}

#endif