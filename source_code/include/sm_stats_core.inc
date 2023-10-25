#include <sdkhooks>
#include <geoip_country>
#include <multicolors>
#include <unixtime_sourcemod>
#undef REQUIRE_PLUGIN
#include <sm_stats_info>

bool DEBUG = false;

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
	"sm_top"
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
 *	Retrieve the active server id.
 */
native int _sm_stats_get_serverid();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active database connection.
 */
native Database _sm_stats_get_sql();

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
 *	Call the player death forward.
 */
native void _sm_stats_player_death_fwd(int attacker, int frags, int[] userids, int[] assisters, const char[] classname, int[] itemdef);

// crucial stuff, re-instate lost data after restart.
native void _sm_stats_info_update_loaded_active(bool bLoaded);
native void _sm_stats_info_update_stats_active(bool bStatsActive);
native void _sm_stats_info_update_round_active(bool bRoundActive);
native void _sm_stats_info_update_maptimer(int iMapTimerSeconds);
native void _sm_stats_info_save_crucial_stuff(bool bLoaded, bool bStatsActive, bool bRoundActive, int iMapTimerSeconds);
native void _sm_stats_info_get_crucial_stuff(any[] this_way_with_arrays_sucks_pls_add_SetNativeCell);

// default important things

#define sql_table_playerlist "playerlist_" ... GameTag
#define sql_table_weapons "weapons_" ... GameTag
#define sql_table_kill_log "kill_log_" ... GameTag
#define sql_table_item_found "item_found_" ... GameTag
#define sql_table_maps_log "maps_log_" ... GameTag
#define sql_table_achievements "achievements_" ... GameTag
#define game_translation "sm_stats_" ... GameTag ... ".phrases"
#define ach_translation "sm_stats_" ... GameTag ... "_achievements.phrases"

#define ITEMDEF_ASSIST_SUICIDE -69

char g_ChatTag[96];
Database sql = null;
bool bLoaded = false;
bool bStatsActive = false;
bool bRoundActive = false;
bool bWarmupActive = false;
bool bDisableAfterRoundEnd = false;
bool bAllowBots = false;
bool bAllowAbuse = false;
bool bAllowWarmup = false;
int g_ServerID = -1;
stock int g_TotalTablePlayers = -1;
int g_MinPlayers = -1;
int g_DeathPoints = -1;
int g_AssistPoints = -1;
int g_PenaltySeconds = -1;

SMStats_PlayerInfo g_Player[MaxPlayers+1];

stock PrivateForward g_GetPlayerSessionInfoFwd;

// map load event
int iMapTimerSeconds = 0;
Handle hMapTimerSeconds = null
Handle hMapTimer = null;
Handle hGameTimer = null;
char cMap[64];

public void _sm_stats_loaded_core()
{
	PrintToServer("%s loading..", core_chattag);
	bLoaded = true;
	_sm_stats_info_update_loaded_active(true);
	
	_sm_stats_get_chattag(g_ChatTag, sizeof(g_ChatTag));
	g_ServerID = _sm_stats_get_serverid();
	bAllowBots = _sm_stats_get_allowbots();
	bAllowAbuse = _sm_stats_get_allowabuse();
	bAllowWarmup = _sm_stats_get_allowwarmup();
	bDisableAfterRoundEnd = _sm_stats_get_disableafterroundend();
	g_MinPlayers = _sm_stats_get_minplayers();
	g_DeathPoints = _sm_stats_get_deathpoints();
	g_PenaltySeconds = _sm_stats_get_penaltyseconds();
	
	#if defined load_players
	CreateTimer(5.0, Timer_PluginLoaded);
	#endif
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
		case SMStatsUpdated_ServerID: g_ServerID = StringToInt(value);
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
	
	// plugin was restarted, manually or via update.
	if(!bLoaded)
	{
		// make sure the natives are loaded.
		switch(SMStatsInfo.IsLoaded())
		{
			case false: ThrowError("%s Error: SMStats: Info doesn't seem to be loaded.\nUnable to re-instate crucial information, problems are to be expected.", core_chattag);
			case true:
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
				
				_sm_stats_get_chattag(g_ChatTag, sizeof(g_ChatTag));
				g_ServerID = _sm_stats_get_serverid();
				bAllowBots = _sm_stats_get_allowbots();
				bAllowAbuse = _sm_stats_get_allowabuse();
				bAllowWarmup = _sm_stats_get_allowwarmup();
				bDisableAfterRoundEnd = _sm_stats_get_disableafterroundend();
				g_MinPlayers = _sm_stats_get_minplayers();
				g_DeathPoints = _sm_stats_get_deathpoints();
				g_PenaltySeconds = _sm_stats_get_penaltyseconds();
				
				PrintToServer("%s Crucial information Re-instated from detected restart.", core_chattag);
				
				CheckActivePlayers();
				
				switch(SMStats.IsLoaded())
				{
					case false: ThrowError("%s Error: SMStats: Core seems to not be loaded.\nUnable to re-instate SQL Connection, problems to be expected.", core_chattag);
					case true:
					{
						PrintToServer("%s SQL connection re-instated from detected restart.", core_chattag);
						if((sql = _sm_stats_get_sql()) != null)
						{
							_sm_stats_loaded_sql(sql, true);
						}
					}
				}
				
				int client = 0;
				while((client = FindEntityByClassname(client, "player")) > 0)
				{
					if(IsClientInGame(client))
					{
						if(!IsFakeClient(client))
						{
							CPrintToChat(client, "{lightgreen}%s {default}%T", core_chattag, "#SMStats_VersionLoaded", client, Version);
						}
					}
				}
			}
		}
	}
}

//

char g_strTableName[][] =
{
	/*0*/sql_table_playerlist
	/*1*/,sql_table_weapons
	/*2*/,sql_table_kill_log
	/*3*/,sql_table_item_found
	/*4*/,sql_table_maps_log
	/*5*/,sql_table_achievements
};

public void _sm_stats_loaded_sql(Database database, bool bOnPluginStart)
{
	sql = database;
	
	PrintToServer("%s Caught database connection.", core_chattag);
	
	if(bOnPluginStart)
	{
		File file;
		char path[96], query[16177], table[128];
		int len;
		
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
		
		//
		
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
				
				sql.Query(DBQuery_InsertTables, query, 1);
				
				query = "";
				len = 0;
			}
		}
		
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
	LogError("\n%s Failed to query id %i"
	... "\nMake sure the database connection is available and/or stable."
	... "\nError reason below:"
	... "\n%s", core_chattag, unique_query_id, error);
}

//

stock Action Timer_PluginLoaded(Handle timer)
{
	// plugin may have just reloaded.
	
	int client = 0;
	while((client = FindEntityByClassname(client, "player")) != -1)
	{
		if(IsValidClient(client, false))
		{
			// obtain the names.
			GetPlayerName(client, g_Player[client].name, sizeof(g_Player[].name));
			
			if(!IsFakeClient(client))
			{
				CPrintToChat(client, "{lightgreen}%s %T", core_chattag, "#SMStats_VersionLoaded", client, Version);
			}
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
	Format(fixed, maxlen, "%s - Points earned when fragging using %s.", core_chattag2, description);
	
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