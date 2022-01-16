/**
 *	Game Events.
 */
#include	"xstats/game/team-fortress.sp"
#include	"xstats/game/counter-strike.sp"

/**
 *	Initialize the includes.
 */
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
	switch(game)	{
		case	Game_TF2:	PrepareDB_TF2();
		case	Game_CSGO:	PrepareDB_CSGO();
		case	Game_CSS:	PrepareDB_CSS();
		case	Game_CSPro:	PrepareDB_CSS();
	}
}

/**
 *	Prepare the game.
 */
void PrepareGame()	{
	switch(game)	{
		case	Game_TF2:	{
			PrepareGame_TF2();
			PrepareGame_TeamFortress();
		}
		case	Game_CSS:	{
			PrepareGame_CounterStrike();
			PrepareGame_CSS();
		}
		case	Game_CSPromod:	{
			PrepareGame_CounterStrike();
			PrepareGame_CSS();
		}
		case	Game_CSGO:	{
			PrepareGame_CounterStrike();
			PrepareGame_CSGO();
		}
		case	Game_CSCO:	{
			PrepareGame_CounterStrike();
			//PrepareGame_CSCO();
		}
	}
}