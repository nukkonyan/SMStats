/**
 *	Game Events.
 */
#include	"xstats/game/team-fortress.sp"
#include	"xstats/game/counter-strike.sp"

/**
 *	Initialize the includes.
 */
//#include	"xstats/game/dod.sp"
#include	"xstats/game/tf.sp"
#include	"xstats/game/csgo.sp"
#include	"xstats/game/cstrike.sp"

/**
 *	Initializes callback includes.
 */
#include	"xstats/game/callbacks.sp"

/**
 *	Initialize the database.
 */
void Games_DatabaseConnected()	{
	File file;
	char path[256], query[16177], table[512];
	int len = 0;
	
	BuildPath(Path_SM, path, sizeof(path), "configs/xstats/%s.xstats", Global.playerlist);
	switch((file = OpenFile(path, "r")) != null)	{
		case true:	{
			while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))	{
				ReplaceString(table, sizeof(table), "\n", "");
				ReplaceString(table, sizeof(table), "\r", "");
				ReplaceString(table, sizeof(table), "\t", "");
				
				len += Format(query[len], sizeof(query)-len, table);
				//PrintToServer("[%i] %s", len, table);
			}
			
			DB.Threaded.Query(DBQuery_CreateTables, query, 1);
		}
		case false: XStats_SetFailState("%s Failed loading database file \"/configs/xstats/%s.xstats\" (Required for players statistical tracking.) (Did you install it correctly?.)", Global.logprefix, Global.playerlist);
	}
	
	query = NULL_STRING;
	len = 0;
	
	BuildPath(Path_SM, path, sizeof(path), "configs/xstats/%s.xstats", Global.kill_log);
	switch((file = OpenFile(path, "r")) != null)	{
		case true:	{
			while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))	{
				ReplaceString(table, sizeof(table), "\n", "");
				ReplaceString(table, sizeof(table), "\r", "");
				ReplaceString(table, sizeof(table), "\t", "");
				
				len += Format(query[len], sizeof(query)-len, table);
				//PrintToServer("[%i] %s", len, table);
			}
			
			DB.Threaded.Query(DBQuery_CreateTables, query, 2);
		}
		case false: XStats_SetFailState("%s Failed loading database file \"/configs/xstats/%s.xstats\" (Required for tracking kills.) (Did you install it correctly?.)", Global.logprefix, Global.kill_log);
	}
	
	query = NULL_STRING;
	len = 0;
	
	switch(Global.Game)	{
		case Game_TF2, Game_CSGO:	{
			BuildPath(Path_SM, path, sizeof(path), "configs/xstats/%s.xstats", Global.item_found);
			switch((file = OpenFile(path, "r")) != null)	{
				case true:	{
					while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))	{
						ReplaceString(table, sizeof(table), "\n", "");
						ReplaceString(table, sizeof(table), "\r", "");
						ReplaceString(table, sizeof(table), "\t", "");
						
						len += Format(query[len], sizeof(query)-len, table);
						//PrintToServer("[%i] %s", len, table);
					}
					
					DB.Threaded.Query(DBQuery_CreateTables, query, 3);
				}
				case false: XStats_SetFailState("%s Failed loading database file \"/configs/xstats/%s.xstats\" (Required for tracking items found, traded, etc.) (Did you install it correctly?.)", Global.logprefix, Global.item_found);
			}
		}
	}
	
	query = NULL_STRING;
	len = 0;
	
	BuildPath(Path_SM, path, sizeof(path), "configs/xstats/%s.xstats", Global.maps_log);
	switch((file = OpenFile(path, "r")) != null)	{
		case true:	{
			while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))	{
				ReplaceString(table, sizeof(table), "\n", "");
				ReplaceString(table, sizeof(table), "\r", "");
				ReplaceString(table, sizeof(table), "\t", "");
				
				len += Format(query[len], sizeof(query)-len, table);
				//PrintToServer("[%i] %s", len, table);
			}
			
			DB.Threaded.Query(DBQuery_CreateTables, query, 4);
		}
		case false: XStats_SetFailState("%s Failed loading database file \"/configs/xstats/%s.xstats\" (Required for tracking maps.) (Did you install it correctly?.)", Global.logprefix, Global.maps_log);
	}
	
	query = NULL_STRING;
	len = 0;
	
	BuildPath(Path_SM, path, sizeof(path), "configs/xstats/%s.xstats", Global.achievements);
	switch((file = OpenFile(path, "r")) != null)	{
		case true:	{
			while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))	{
				ReplaceString(table, sizeof(table), "\n", "");
				ReplaceString(table, sizeof(table), "\r", "");
				ReplaceString(table, sizeof(table), "\t", "");
				
				len += Format(query[len], sizeof(query)-len, table);
				//PrintToServer("[%i] %s", len, table);
			}
			
			DB.Threaded.Query(DBQuery_CreateTables, query, 5);
		}
		case false: XStats_SetFailState("%s Failed loading database file \"/configs/xstats/%s.xstats\" (Required for tracking custom achievements.) (Did you install it correctly?.)", Global.logprefix, Global.achievements);
	}
	
	delete file;
}

void DBQuery_CreateTables(Database database, DBResultSet results, const char[] error, int queryid)	{
	char table_name[64];
	switch(queryid)	{
		case 1: table_name = Global.playerlist;
		case 2: table_name = Global.kill_log;
		case 3: table_name = Global.item_found;
		case 4: table_name = Global.maps_log;
		case 5: table_name = Global.achievements;
	}
	
	switch(results == null)	{
		case true: XStats_DebugText(true, "%s Failed to insert database table \"%s\". \n%s \n\nMake sure the database connection is available or file is correct.", Global.logprefix, table_name, error);
		case false: XStats_DebugText(false, "%s Inserted database table %s", Global.logprefix, table_name);
	}
}

/**
 *	Prepare the game.
 */
void PrepareGame()	{
	//Initialize
	Global.Game = IdentifyGame();
	GetGameName(Global.GameTitle, sizeof(Global.GameTitle));
	Global.RoundActive = true;
	Global.WarmupActive = false;
	
	bool supported = false; /* Temporary thing */
	
	switch(Global.Game)	{
		case Game_DODS:	{
			Global.logprefix = "[XStats DOD:S]";
			Global.playerlist = "playerlist_dods";
			Global.kill_log = "kill_log_dods";
			Global.maps_log = "maps_log_dods";
			Global.achievements = "achievements_dods";
			//PrepareGame_DODS();
		}
		case Game_TF2:	{
			Global.logprefix = "[XStats TF2]";
			Global.playerlist = "playerlist_tf2";
			Global.kill_log = "kill_log_tf2";
			Global.item_found = "item_found_tf2";
			Global.maps_log = "maps_log_tf2";
			Global.achievements = "achievements_tf2";
			supported = true;
			
			PrepareGame_TF2();
			PrepareGame_TeamFortress();
		}
		case Game_TF2Classic:	{
			Global.logprefix = "[XStats TF2: Classic]";
			Global.playerlist = "playerlist_tf2classic";
			Global.kill_log = "kill_log_tf2classic";
			Global.maps_log = "maps_log_tf2classic";
			Global.achievements = "achievements_tf2classic";
		}
		case Game_TF2Vintage:	{
			Global.logprefix = "[XStats TF2: Vintage]";
			Global.playerlist = "playerlist_tf2vintage";
			Global.kill_log = "kill_log_tf2vintage";
			Global.maps_log = "maps_log_tf2vintage";
			Global.achievements = "achievements_tf2vintage";
		}
		case Game_TF2OpenFortress:	{
			Global.logprefix = "[XStats TF2: Open Fortress]";
			Global.playerlist = "playerlist_tf2op";
			Global.kill_log = "kill_log_tf2op";
			Global.maps_log = "maps_log_tf2op";
			Global.achievements = "achievements_tf2op";
		}
		case Game_CSS:	{
			Global.logprefix = "[XStats CS:S]";
			Global.playerlist = "playerlist_css";
			Global.kill_log = "kill_log_css";
			Global.maps_log = "maps_log_css";
			Global.achievements = "achievements_css";
			supported = true;
			
			PrepareGame_CounterStrike();
			PrepareGame_CSS();
		}
		case Game_CSPromod:	{
			Global.logprefix = "[XStats CS:Promod]";
			Global.playerlist = "playerlist_promod";
			Global.kill_log = "kill_log_cspromod";
			Global.maps_log = "maps_log_cspromod";
			Global.achievements = "achievements_cspromod";
			
			PrepareGame_CounterStrike();
			PrepareGame_CSS();
		}
		case Game_CSGO:	{
			Global.logprefix = "[XStats CS:GO]";
			Global.playerlist = "playerlist_csgo";
			Global.kill_log = "kill_log_csgo";
			Global.item_found = "item_found_csgo";
			Global.maps_log = "maps_log_csgo";
			Global.achievements = "achievements_csgo";
			supported = true;
			
			PrepareGame_CounterStrike();
			PrepareGame_CSGO();
		}
		case Game_CSCO:	{
			Global.logprefix = "[XStats CS:CO]";
			Global.playerlist = "playerlist_csco";
			Global.kill_log = "kill_log_csco";
			Global.maps_log = "maps_log_csco";
			Global.achievements = "achievements_csco";
			
			PrepareGame_CounterStrike();
			//PrepareGame_CSCO();
		}
		case Game_L4D1:	{
			Global.logprefix = "[XStats L4D1]";
			Global.playerlist = "playerlist_l4d1";
			Global.kill_log = "kill_log_l4d1";
			Global.maps_log = "maps_log_l4d1";
			Global.achievements = "achievements_l4d1";
		}
		case Game_L4D2:	{
			Global.logprefix = "[XStats L4D2]";
			Global.playerlist = "playerlist_l4d2";
			Global.kill_log = "kill_log_l4d2";
			Global.maps_log = "maps_log_l4d2";
			Global.achievements = "achievements_l4d2";
		}
		case Game_Contagion:	{
			Global.logprefix = "[XStats Contagion]";
			Global.playerlist = "playerlist_contagion";
			Global.kill_log = "kill_log_contagion";
			Global.maps_log = "maps_log_contagion";
			Global.achievements = "achievements_contagion";
		}
		case Game_HL2DM:	{
			Global.logprefix = "[XStats Half-Life 2 Deathmatch]";
			Global.playerlist = "playerlist_hl2dm";
			Global.kill_log = "kill_log_hl2dm";
			Global.maps_log = "maps_log_hl2dm";
			Global.achievements = "achievements_contagion";
		}
	}
	
	switch(supported)	{
		case true: PrintToServer("XStats Version %s Detected game: %s", Version, Global.GameTitle);
		case false: SetFailState("[XStats] Game \"%s\" is unsupported.", Global.GameTitle);
	}
}