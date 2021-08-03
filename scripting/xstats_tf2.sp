#include	<tklib>
#include	<multicolors>

#include	<xstats>
#include	<xstats_tf2>
#include	<xstats_libraries>

#pragma		semicolon	1
#pragma		newdecls	required

Xstats				xstats;
Xstats_Libraries	libraries;

char	Prefix[256];

#define		PLUGIN_NAME		"Xstats: Team Fortress 2"
#define		PLUGIN_VERSION	"0.1a"

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)	{
	RegPluginLibrary(PLUGIN_NAME);
}

public	Plugin	myinfo	=	{
	name		=	PLUGIN_NAME,
	author		=	"Tk /id/Teamkiller324",
	description	=	"Player Statistics Tracking for TF2",
	version		=	PLUGIN_VERSION,
	url			=	"https://steamcommunity.com/id/Teamkiller324"
}

//========================================================================//

#include	"xstats_tf2/databases.sp"
	//Load the database configuration

#include	"xstats_tf2/events.sp"
	//Hook events onto forwards.

#include	"xstats_tf2/cvars.sp"
	//Console Variables.

#include	"xstats_tf2/forwards.sp"
	//Read the plugins forwards.

//========================================================================//

public void OnPluginStart()	{
	if(IdentifyGame() != Game_TF2)	{
		PrintToServer("[%s] This plugin is only designed for Team Fortress 2", PLUGIN_NAME);
		SetFailState("[%s] Fatal Error Detected!: ERR_GAME_IS_NOT_TF2", PLUGIN_NAME);
	}
	
	PrintToServer("[%s] Module has been initialized!", PLUGIN_NAME);
	
	//Translations.
	LoadTranslations("xstats_tf2.phrases");
	
	LoadEvents();
		//Load events.
	
	LoadCvars();
		//Load command variables.

	//Other
	CheckDatabaseConnection();
		//Check for a database connection.
	
	CheckPrefixTag();
		//Check for a prefix tag.
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

/**
 *	Print the message about if there's enough players.
 */
public void CheckActivePlayers()	{
	int players = xstats.GetActivePlayers(xstats.CountBots());
	int minimum = xstats.MinimumPlayers();
	
	switch(xstats.RankingActive())	{
		case	true:	CPrintToChatAll("%s ranking is enabled (Enough players connected, %d out of %d)", Prefix, players, minimum);
		case	false:	CPrintToChatAll("%s ranking is disabled (Not enough players connected, only %d out of %d required)", Prefix, players, minimum);
	}
}
