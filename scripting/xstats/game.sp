/**
 *	Initialize the includes.
 */
#include	"xstats/game/tf/tf.sp"
#include	"xstats/game/csgo/csgo.sp"
#include	"xstats/game/cstrike/cstrike.sp"

/**
 *	Counter-Strike Forwards.
 */
#include	"xstats/game/counter-strike/counter-strike.sp"

/**
 *	Initialize the database.
 */
void Games_DatabaseConnected()	{
	switch(game)	{
		case	Game_TF2:	PrepareDB_TF2();
		case	Game_CSGO:	PrepareDB_CSGO();
		case	Game_CSS:	PrepareDB_CSS();
	}
}

/**
 *	Prepare the game.
 */
void PrepareGame()	{
	switch(game)	{
		case	Game_TF2:	PrepareGame_TF2();
		case	Game_CSS:	{
			PrepareGame_CounterStrike();
			PrepareGame_CSS();
		}
		case	Game_CSPromod:	{
			PrepareGame_CounterStrike();
			//PrepareGame_CSPromod();
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