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
	"sm_plats",
	"sm_placering",
	"sm_placerad",
	"sm_rang",
};
stock char str_Top10Menu[][] =
{
	"sm_top10",
	"sm_top",
	"sm_topp",
	"sm_topp10"
};

//

#define queryId_kill_assister 0
#define queryId_kill_weapon 1
#define queryId_kill_victim_death 2
#define queryId_kill_playerlist 3
#define queryId_kill_playerlist_MapUpdate 4
#define queryId_object_placed 5
#define queryId_object_placed_MapUpdate 6
#define queryId_object_destroyed 7
#define queryId_object_destroyed_MapUpdate 8
stock char g_strTXNqueryId[][] = 
{
	/*0*/"kill event: assister",
	/*1*/"kill event: weapon",
	/*2*/"kill event: victim death",
	/*3*/"kill event: playerlist",
	/*4*/"kill event: playerlist map update",
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

enum SMStats_CustomGameType
{
	GameType_TF2 = 0,
	GameType_TF2C = 1,
	GameType_OpenFortress = 2,
	
	GameType_CSS = 3,
	GameType_CSProMod = 4,
	
	GameType_CSGO = 5,
	GameType_CSCO = 6,
	GameType_Legacy = 7,
}

stock SMStats_CustomGameType g_CustomGameType;

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
native void _sm_stats_player_death_fwd(int attacker, int kills, int[] userids, int[] assisters, const char[] classname, int[] itemdef);

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

// sql

#define sql_table_playerlist "playerlist_" ... GameType
#define sql_table_weapons    "weapons_"    ... GameType
#define sql_table_kill_log   "kill_log_"   ... GameType
#define sql_table_item_log   "item_log_"   ... GameType
#define sql_table_maps_log   "maps_log_"   ... GameType
#define sql_table_settings   "settings"

char g_strTableName[7][24];

enum struct SMStats_SQLInfo
{
	Database setsuzoku;
	
	
	char playerlist[24];
	char weapons[24];
	char kill_log[24];
	char item_log[24];
	char maps_log[24];
	char achievements[24];
	char settings[9];
	
	void init_tablenames()
	{
		PrintToServer("init_tablenames()");
		
		Format(this.playerlist, sizeof(this.playerlist), "playerlist_%s", GameType);
		strcopy(g_strTableName[0], sizeof(g_strTableName[]), this.playerlist);
		
		Format(this.weapons, sizeof(this.weapons), "weapons_%s", GameType);
		strcopy(g_strTableName[1], sizeof(g_strTableName[]), this.weapons);
		
		Format(this.kill_log, sizeof(this.kill_log), "kill_log_%s", GameType);
		strcopy(g_strTableName[2], sizeof(g_strTableName[]), this.kill_log);
		
		Format(this.item_log, sizeof(this.item_log), "item_log_%s", GameType);
		strcopy(g_strTableName[3], sizeof(g_strTableName[]), this.item_log);
		
		Format(this.maps_log, sizeof(this.maps_log), "maps_log_%s", GameType);
		strcopy(g_strTableName[4], sizeof(g_strTableName[]), this.maps_log);
		
		Format(this.achievements, sizeof(this.achievements), "achievements_log_%s", GameType);
		strcopy(g_strTableName[5], sizeof(g_strTableName[]), this.achievements);
		
		strcopy(this.settings, sizeof(this.settings), "settings");
		strcopy(g_strTableName[6], 9, "settings");
	}
	
	void lock()
	{
		SQL_LockDatabase(this.setsuzoku);
	}
	
	void unlock()
	{
		SQL_UnlockDatabase(this.setsuzoku);
	}
	
	DBResultSet query(char[] query)
	{
		return SQL_Query(this.setsuzoku, query);
	}
	
	void tquery(SQLQueryCallback callback, char[] query, any data=0, DBPriority prio=DBPrio_Normal)
	{
		this.setsuzoku.Query(callback, query, data, prio)
	}
	
	bool error(char[] error, int maxlen)
	{
		return SQL_GetError(this.setsuzoku, error, maxlen);
	}
	
	void exec(Transaction txn, SQLTxnSuccess success=INVALID_FUNCTION, SQLTxnFailure error=INVALID_FUNCTION, any data=0, DBPriority prio=DBPrio_Normal)
	{
		this.setsuzoku.Execute(txn, success, error, data, prio);
	}
	
	bool valid()
	{
		return (this.setsuzoku != null);
	}
}
SMStats_SQLInfo sql;

char game_translation[24];
char ach_translation[24];

#define ITEMDEF_INVALID -1

char g_ChatTag[96];
char g_sndConnectedTop10[96]
, g_sndConnectedTop1[96]
, g_sndConnectedGeneric[96];
KeyValues core = null;
bool bDebug = false;
bool bLoaded = false;
bool bStatsActive = false;
bool bRoundActive = false;
bool bWarmupActive = false;
bool bDisableAfterRoundEnd = false;
bool bAllowBots = false;
bool bAllowAbuse = false;
bool bAllowWarmup = false;
stock bool bAllowTeamFrag = false;
int g_StatsID = -1;
int g_TotalTablePlayers = -1;
int g_MinPlayers = -1;
int g_DeathPoints = -1;
stock int g_TeamFragPoints = -1;
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
	sql.init_tablenames();
	
	Format(game_translation, sizeof(game_translation), "sm_stats_%s.phrases", GameType);
	Format(ach_translation, sizeof(ach_translation), "sm_stats_%s_achievements.phrases", GameType);
	
	//
	
	PrintToServer(core_chattag..." Version "...Version..." (https://github.com/nukkonyan/SMStats)");
	LogToGame(core_chattag..." Version "...Version..." (https://github.com/nukkonyan/SMStats)");
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
	#if defined load_cstrike
	LoadTranslations("sm_stats_cstrike.phrases");
	#endif
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
		case SMStatsUpdated_AllowTeamFrag: bAllowTeamFrag = view_as<bool>(StringToInt(value));
		case SMStatsUpdated_DisableAfterRoundEnd: bDisableAfterRoundEnd = view_as<bool>(StringToInt(value));
		case SMStatsUpdated_MinPlayers:
		{
			g_MinPlayers = StringToInt(value);
			CheckActivePlayers();
		}
		case SMStatsUpdated_DeathPoints: g_DeathPoints = view_as<int>(StringToInt(value));
		case SMStatsUpdated_TeamFragPoints: g_TeamFragPoints = view_as<int>(StringToInt(value));
		case SMStatsUpdated_AssistPoints: g_AssistPoints = view_as<int>(StringToInt(value));
		case SMStatsUpdated_SndConnectedTop10: strcopy(g_sndConnectedTop10, sizeof(g_sndConnectedTop10), value);
		case SMStatsUpdated_SndConnectedTop1: strcopy(g_sndConnectedTop1, sizeof(g_sndConnectedTop1), value);
		case SMStatsUpdated_SndConnectedGeneric: strcopy(g_sndConnectedGeneric, sizeof(g_sndConnectedGeneric), value);
		case SMStatsUpdated_Debug: bDebug = view_as<bool>(StringToInt(value));
	}
}

public void OnPluginStart()
{
	sql.init_tablenames();
	
	Format(game_translation, sizeof(game_translation), "sm_stats_%s.phrases", GameType);
	Format(ach_translation, sizeof(ach_translation), "sm_stats_%s_achievements.phrases", GameType);
	
	//
	
	PrepareTranslations();
	PrepareGame();
	#if defined load_cstrike
	PrepareGame_CStrike();
	#endif
	PrepareCoreCFG();
	
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
	
	// plugin was restarted, manually started or restarted via update.
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
		
		LogMessage(" Version "...Version..." (https://github.com/nukkonyan/SMStats)");
		
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
			if((sql.setsuzoku = _sm_stats_get_sql()) != null)
			{
				_sm_stats_loaded_sql(sql.setsuzoku, true);
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

stock void PostAskPluginLoad(EngineVersion engine)
{
	char gamefolder[16];
	GetGameFolderName(gamefolder, sizeof(gamefolder));
	bool bValid = false;
	
	switch(engine)
	{
		case Engine_TF2:
		{
			if(StrEqual(gamefolder, "tf", false))
			{
				g_CustomGameType = GameType_TF2;
			}
		}
		case Engine_CSGO:
		{
			if(StrEqual(gamefolder, "csgo", false))
			{
				g_CustomGameType = GameType_CSGO;
				bValid = true;
			}
			else if(StrEqual(gamefolder, "cscomod", false))
			{
				g_CustomGameType = GameType_CSCO;
				bValid = true;
			}
		}
	}
	
	if(!bValid)
	{
		SetFailState("This game is unsupported.");
	}
	
	CreateNative("SMStats.Native_GetPlayerSessionInfo", Native_GetPlayerSessionInfo);
	CreateNative("_sm_stats_detect_ban_player_auth", Native_BanPlayer_Auth);
	CreateNative("_sm_stats_detect_ban_player_ip", Native_BanPlayer_IPAddress);
}

//

public void _sm_stats_loaded_sql(Database database, bool bOnPluginStart)
{
	sql.setsuzoku = database;
	
	LogToGame(core_chattag..." : Caught database connection.");
	
	if(bOnPluginStart)
	{
		File file;
		char path[64], query[16177], table[128];
		int len;
		
		#if defined sql_loadtable_playerlist
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql.playerlist);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				SetFailState("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for statistical tracking.), Did you install it correctly?", sql.playerlist);
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
				
				sql.tquery(DBQuery_InsertTables, query, 0);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		#if defined sql_loadtable_weapons
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql.weapons);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				SetFailState("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for tracking weapon kills.), Did you install it correctly?", sql.weapons);
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
				
				sql.tquery(DBQuery_InsertTables, query, 1);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		#if defined sql_loadtable_kill_log
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql.kill_log);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				SetFailState("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for tracking kills events.), Did you install it correctly?", sql.kill_log);
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
				
				sql.tquery(DBQuery_InsertTables, query, 1);
				
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
				
				sql.tquery(DBQuery_InsertTables, query, 4);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		#if defined sql_loadtable_maps_log
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql.maps_log);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				LogError("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for tracking maps.), Did you install it correctly?", sql.maps_log);
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
				
				sql.tquery(DBQuery_InsertTables, query, 4);
				
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
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql.settings);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				LogError("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for saving settings.), Did you install it correctly?", sql.settings);
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
				
				sql.tquery(DBQuery_InsertTables, query, 6);
				
				query = "";
				len = 0;
			}
		}
		#endif
		
		//
		
		
		int client = 0;
		while((client = FindEntityByClassname(client, "player")) > 0)
		{
			if(SMStats_IsValidClient(client))
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
	sql.tquery(DBQuery_Callback, format, unique_query_id);
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
		if(SMStats_IsValidClient(client))
		{
			// obtain the player info.
			UpdatePlayerInfo(client);
			
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
	Format(fixed, maxlen, "%s - Points earned when killing with %s.", core_chattag2, description);
	
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
		... "\n 1 - Erase playerlist" ..." [ %s ]"
		... "\n 2 - Erase weapons" ..." [ %s ]"
		... "\n 3 - Erase kill log" ..." [ %s ]"
		... "\n 4 - Erase item log" ..." [ %s ]"
		... "\n 5 - Erase maps log" ..." [ %s ]"
		... "\n 6 - Erase achievements" ..." [ %s ]"
		... "\n 7 - Erase settings" ..." [ %s ]"
		... "\n 8 - Erase everything"
		, core_chattag
		, sql.playerlist
		, sql.weapons
		, sql.kill_log
		, sql.item_log
		, sql.maps_log
		, sql.achievements
		, sql.settings);
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
		Format(query, sizeof(query), "drop table %s", sql.playerlist);
		txn.AddQuery(query, 0);
	}
	#endif
	
	#if defined sql_loadtable_weapons
	if(id == 2 || id == 8)
	{
		Format(query, sizeof(query), "drop table %s", sql.weapons);
		txn.AddQuery(query, 1);
	}
	#endif
	
	#if defined sql_loadtable_kill_log
	if(id == 3 || id == 8)
	{
		Format(query, sizeof(query), "drop table %s", sql.kill_log);
		txn.AddQuery(query, 2);
	}
	#endif
	
	#if defined sql_loadtable_item_log
	if(id == 4 || id == 8)
	{
		Format(query, sizeof(query), "drop table %s", sql.item_log);
		txn.AddQuery(query, 3);
	}
	#endif
	
	#if defined sql_loadtable_maps_log
	if(id == 5 || id == 8)
	{
		Format(query, sizeof(query), "drop table %s", sql.maps_log);
		txn.AddQuery(query, 4);
	}
	#endif
	
	#if defined sql_loadtable_achievements_log
	if(id == 6)
	{
		Format(query, sizeof(query), "drop table %s", sql.achievements);
		txn.AddQuery(query, 5);
	}
	#endif
	
	if(id == 7 || id == 8)
	{
		Format(query, sizeof(query), "drop table %s", sql.settings);
		txn.AddQuery(query, 6);
	}
	
	sql.exec(txn, TXN_EraseDatabaseConfig_OnSuccess, TXN_EraseDatabaseConfig_OnFailure, client);
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

// core cfg

stock void PrepareCoreCFG()
{
	char path[64];
	BuildPath(Path_SM, path, sizeof(path), "configs/sm_stats/core.cfg");
	if(!FileExists(path))
	{
		LogError(core_chattag..." Core CFG Error : File 'configs/sm_stats/core.cfg' was not found!");
		return;
	}
	
	core = new KeyValues("SMStatsCFG");
	
	if(!core.ImportFromFile(path))
	{
		delete core;
		LogError(core_chattag..." Core CFG Error : Could not convert into readable KeyValue!");
		return;
	}
	
	if(!core.GotoFirstSubKey())
	{
		delete core;
		LogError(core_chattag..." Core CFG Error : Could not read first subkey!");
		return;
	}
	
	LogToGame(core_chattag..." Loaded Core CFG ('configs/sm_stats/core.cfg')");
	core.Rewind();
}

// other

/*
 * @param client		- client player ent index
 * @param aBlock[0]		- Boolean if to to block non-ingame players.
 * @param aBlock[1]		- 0 = Do not block fake players.
 *                      - 1 = Block fake players.
 *                      - 2 = Block bots if disabled by cvar setting.
 * @param aBlock[2]		- Boolean if to Block dead players or not.
 * @param aBlock[3]		- Boolean if to check if player is abusing.
 * @param aBlock[4]		- Boolean if to check steam authentication id.
 * @param iBlockp1		- 1 = Block if on the same team.
 *                        2 = Block if not same team.
 *                        3 = Block if same player.
 *                        4 = Block if not same player.
 * @param iBlockp2		- Target index.
 * @param auth			- Steam authentication id.
*/
stock bool SMStats_IsValidClient(int client, int aBlock[5]={1,1,0,0,0}, int iBlockp1=-1, int iBlockp2=-1, char[] auth="")
{
	if(client >= 1)
	{
		if(!IsClientConnected(client))
		{
			return false;
		}
		if(IsClientReplay(client))
		{
			return false;
		}
		if(IsClientSourceTV(client))
		{
			return false;
		}
		
		if(aBlock[0] == 1)
		{
			if(!IsClientInGame(client))
			{
				return false;
			}
		}
		
		bool bBot = IsFakeClient(client);
		
		switch(aBlock[1])
		{
			case 1:
			{
				if(bBot)
				{
					return false;
				}
			}
			case 2:
			{
				if(!bAllowBots && bBot)
				{
					return false;
				}
			}
		}
		if(aBlock[2] == 1)
		{
			if(!IsPlayerAlive(client))
			{
				return false;
			}
		}
		if(aBlock[3] == 0)
		{
			if(!bBot)
			{
				if(IsValidAbuse(client))
				{
					return false;
				}
			}
		}
		if(aBlock[4] == 0)
		{
			if(!bBot)
			{
				if(!GetClientAuthId(client, AuthId_Steam3, auth, AUTH_LENGTH, false))
				{
					return false;
				}
			}
		}
		switch(iBlockp1)
		{
			case 1:
			{
				if(GetClientTeam(client) == GetClientTeam(iBlockp2))
				{
					return false;
				}
			}
			case 2:
			{
				if(GetClientTeam(client) != GetClientTeam(iBlockp2))
				{
					return false;
				}
			}
			case 3:
			{
				if(client == iBlockp2)
				{
					return false;
				}
			}
			case 4:
			{
				if(client != iBlockp2)
				{
					return false;
				}
			}
		}
	}
	
	return true;
}

/*
 * @param client		- client player ent index
 * @param userid		- userid
 * @param aBlock[0]		- Boolean if to to block non-ingame players.
 * @param aBlock[1]		- 0 = Do not block fake players.
 *                      - 1 = Block fake players.
 *                      - 2 = Block bots if disabled by cvar setting.
 * @param aBlock[2]		- Boolean if to Block dead players or not.
 * @param aBlock[3]		- Boolean if to check if player is abusing.
 * @param aBlock[4]		- Boolean if to check steam authentication id.
 * @param iBlockp1		- 1 = Block if on the same team.
 *                        2 = Block if not same team.
 *                        3 = Block if same player.
 *                        4 = Block if not same player.
 * @param iBlockp2		- Target index.
 * @param auth			- Steam authentication id.
*/
stock bool SMStats_IsValidUserID(int &client=0, int userid, int aBlock[5]={1,1,0,0,0}, int iBlockp1=-1, int iBlockp2=-1, char[] auth="")
{
	if(userid < 1)
	{
		return false;
	}
	
	if((client = GetClientOfUserId(userid)) < 1)
	{
		return false;
	}
	
	return SMStats_IsValidClient(client, aBlock, iBlockp1, iBlockp2, auth);
}

stock bool SMStats_IsValidConnected(int client)
{
	if(client < 1)
	{
		return false;
	}
	
	if(IsFakeClient(client))
	{
		return true;
	}
	
	return true;
}

stock bool IsValidConnectedUserID(int &client=0, int userid)
{
	if(userid < 1)
	{
		return false;
	}
	
	if((client = GetClientOfUserId(userid)) < 1)
	{
		return false;
	}
	
	return SMStats_IsValidConnected(client);
}

#endif