#include	<tklib>
#include	<multicolors>

#include	<xstats>
#include	<xstats_achievements>

#undef		REQUIRE_PLUGIN
#include	<xstats_tf2>

#pragma		semicolon	1
#pragma		newdecls	required

char	Prefix[256], Game_Achievements[64], Game_Playerstats[64], Achievement_Sound[64];

Xstats	xstats;

#define		PLUGIN_NAME		"Xstats: Achievements"
#define		PLUGIN_VERSION	"0.01a"

public	Plugin	myinfo	=	{
	name		=	"Xstats: Achievements",
	author		=	"Tk /id/Teamkiller324",
	description	=	"Achievements tracking.",
	version		=	PLUGIN_VERSION,
	url			=	"https://steamcommunity.com/id/Teamkiller324"
}

//========================================================================//

#include	"xstats_achievements/databases.sp"
	//Load the database configuration

#include	"xstats_achievements/commands.sp"
	//Load the commands.

#include	"xstats_achievements/forwards.sp"
	//Load the xstats forwards and read them.

//========================================================================//

public void OnPluginStart()	{
	//Correctly identify the game.
	switch(IdentifyGame())	{
		case	Game_TF2:	{
			Game_Achievements	=	Xstats_achievements_tf2;
			Game_Playerstats	=	Xstats_playerstats_tf2;
			Achievement_Sound	=	"misc/achievement_earned.wav";
		}
		case	Game_TF2C:	{
			Achievement_Sound	=	"misc/achievement_earned.wav";
		}
		case	Game_CSPromod:	{
			Achievement_Sound	=	"misc/achievement_earned.wav";
		}
		case	Game_CSS:	{
			Achievement_Sound	=	"misc/achievement_earned.wav";
		}
		case	Game_CSGO:	{
			Achievement_Sound	=	"ui/achievement_earned.wav";
		}
		default:	{
			PrintToServer("[%s] This plugin is not supported for this game", PLUGIN_NAME);
			SetFailState("[%s] Fatal Error Detected!: ERR_GAME_NOT_SUPPORTED", PLUGIN_NAME);
		}
	}
	
	PrintToServer("[%s] Module has been initialized!", PLUGIN_NAME);
	
	//Translations.
	LoadTranslations("xstats_achievements.phrases");
	
	LoadCommands();
		//Load the commands.
	
	//Other
	CheckDatabaseConnection();
		//Check for a database connection.
	
	CheckPrefixTag();
		//Check for a prefix tag.
}

public void OnMapStart()	{
	PrecacheSound(Achievement_Sound);
}

//================================================//
// Make sure database connection is available.
//================================================//

float RetryTimer = 2.5;

public void xstats_OnDatabaseConnected()	{
	CheckDatabaseConnection();
}

void CheckDatabaseConnection()	{
	db = xstats.GetDatabaseConnection();
	
	switch(db == null)	{
		case	true:	{
			if(xstats.Debug())	{
				PrintToServer("[%s] Failed gather database connection!", PLUGIN_NAME);
				PrintToServer("[%s] Gathering database connection..", PLUGIN_NAME);
			}
			CreateTimer(RetryTimer, DatabaseConnectionRequest);
		}
		case	false:	{
			if(xstats.Debug())
				PrintToServer("[%s] Succeeded gathering database connection!", PLUGIN_NAME);
			UploadDB(db);
		}
	}
}

Action DatabaseConnectionRequest(Handle timer)	{
	db = xstats.GetDatabaseConnection();
	
	switch(db == null)	{
		case	true:	{
			if(xstats.Debug())	{
				PrintToServer("[%s] Failed to gather database connection", PLUGIN_NAME);
				PrintToServer("[%s] Gathering database connection..", PLUGIN_NAME);
			}
			CreateTimer(RetryTimer, DatabaseConnectionRequest);
		}
		case	false:	{
			if(xstats.Debug())
				PrintToServer("[%s] Succeeded gathering database connection!", PLUGIN_NAME);
			UploadDB(db);
				//Upload the tables to the database.
			//Make sure not to leak handles. Also SM Devs please expand timer functionalities and make timers have 'Timer' instead of 'Handle', Not great mixing old with new syntax.
		}
	}
}

//================================================//
// Makes sure there is a prefix applied (if there is.)
//================================================//

public void xstats_OnPrefixTagUpdated(char[] prefix)	{
	xstats.GetPrefixTag(Prefix, sizeof(Prefix));
}

void CheckPrefixTag()	{
	xstats.GetPrefixTag(Prefix, sizeof(Prefix));
}

//===============================================//
// Other things.
//===============================================//

/**
 *	Checks if the round or ranking statisticc itself is active.
 *
 *	@param		IgnoreRound		If true, ignores the round activity check. Defaulted to false.
 *	@param		IgnoreRanking	If true, ignores the ranking statistics activity check. Defaulted to false.
 *	returns true if the round is active and ranking statisticc is active.
 */
stock bool IsValidProcedure(bool IgnoreRound=false, bool IgnoreRanking=false)	{
	if(!IgnoreRound && !xstats.RoundActive())
		return	false;
	if(!IgnoreRanking && !xstats.RankingActive())
		return	false;
	return	true;
}