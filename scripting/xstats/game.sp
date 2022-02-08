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
	switch(Global.Game)	{
		//case Game_DODS: PrepareDB_DODS();
		case Game_TF2: PrepareDB_TF2();
		case Game_CSGO: PrepareDB_CSGO();
		case Game_CSS: PrepareDB_CSS();
		case Game_CSPro: PrepareDB_CSS();
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
			Global.logprefix = "[XStats Debug: DOD:S]";
			Global.playerlist = "playerlist_dods";
			Global.kill_log = "kill_log_dods";
			Global.maps_log = "maps_log_dods";
			//PrepareGame_DODS();
		}
		case Game_TF2:	{
			Global.logprefix = "[XStats Debug: TF2]";
			Global.playerlist = "playerlist_tf2";
			Global.kill_log = "kill_log_tf2";
			Global.item_found = "item_found_tf2";
			Global.maps_log = "maps_log_tf2";
			supported = true;
			
			PrepareGame_TF2();
			PrepareGame_TeamFortress();
		}
		case Game_TF2Classic:	{
			Global.logprefix = "[XStats Debug: TF2: Classic]";
			Global.playerlist = "playerlist_tf2classic";
			Global.kill_log = "kill_log_tf2classic";
			Global.maps_log = "maps_log_tf2classic";
		}
		case Game_TF2Vintage:	{
			Global.logprefix = "[XStats Debug: TF2: Vintage]";
			Global.playerlist = "playerlist_tf2vintage";
			Global.kill_log = "kill_log_tf2vintage";
			Global.maps_log = "maps_log_tf2vintage";
		}
		case Game_TF2OpenFortress:	{
			Global.logprefix = "[XStats Debug: TF2: Open Fortress]";
			Global.playerlist = "playerlist_tf2op";
			Global.kill_log = "kill_log_tf2op";
			Global.maps_log = "maps_log_tf2op";
		}
		case Game_CSS:	{
			Global.logprefix = "[XStats Debug: CS:S]";
			Global.playerlist = "playerlist_css";
			Global.kill_log = "kill_log_css";
			Global.maps_log = "maps_log_css";
			supported = true;
			
			PrepareGame_CounterStrike();
			PrepareGame_CSS();
		}
		case Game_CSPromod:	{
			Global.logprefix = "[XStats Debug: CS:Promod]";
			Global.playerlist = "playerlist_promod";
			Global.kill_log = "kill_log_cspromod";
			Global.maps_log = "maps_log_cspromod";
			
			PrepareGame_CounterStrike();
			PrepareGame_CSS();
		}
		case Game_CSGO:	{
			Global.logprefix = "[XStats Debug: CS:GO]";
			Global.playerlist = "playerlist_csgo";
			Global.kill_log = "kill_log_csgo";
			Global.item_found = "item_found_csgo";
			Global.maps_log = "maps_log_csgo";
			supported = true;
			
			PrepareGame_CounterStrike();
			PrepareGame_CSGO();
		}
		case Game_CSCO:	{
			Global.logprefix = "[XStats Debug: CS:CO]";
			Global.playerlist = "playerlist_csco";
			Global.kill_log = "kill_log_csco";
			Global.maps_log = "maps_log_csco";
			
			PrepareGame_CounterStrike();
			//PrepareGame_CSCO();
		}
		case Game_L4D1:	{
			Global.logprefix = "[XStats Debug: L4D1]";
			Global.playerlist = "playerlist_l4d1";
			Global.kill_log = "kill_log_l4d1";
			Global.maps_log = "maps_log_l4d1";
		}
		case Game_L4D2:	{
			Global.logprefix = "[XStats Debug: L4D2]";
			Global.playerlist = "playerlist_l4d2";
			Global.kill_log = "kill_log_l4d2";
			Global.maps_log = "maps_log_l4d2";
		}
		case Game_Contagion:	{
			Global.logprefix = "[XStats Debug: Contagion]";
			Global.playerlist = "playerlist_contagion";
			Global.kill_log = "kill_log_contagion";
			Global.maps_log = "maps_log_contagion";
		}
		case Game_HL2DM:	{
			Global.logprefix = "[XStats Debug: Half-Life 2 Deathmatch]";
			Global.playerlist = "playerlist_hl2dm";
			Global.kill_log = "kill_log_hl2dm";
			Global.maps_log = "maps_log_hl2dm";
		}
	}
	
	switch(supported)	{
		case true: PrintToServer("XStats Version %s Detected game: %s", Version, Global.GameTitle);
		case false: SetFailState("[XStats] Game \"%s\" is unsupported.", Global.GameTitle);
	}
}