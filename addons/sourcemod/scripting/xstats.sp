#include <multicolors>
#include <xstats>
#include <geoip>
#include <updater>
#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0

/* XStats is a multi-game statistical tracking plugin, influenced by gameMe & HLStatsX. */
#define Version "1.0.0.0a"
SetPluginInfo("XStats - Statistical Multi-Tracker", _tklib_author, "XStats - Track kills, maps, kill events, achievements, etc.", Version, _tklib_author_url)

/**
 *	TODO List
 *
 *	> 0: (Yes i count from 0)
 *		→ Make database queries pre-disconnect instead of every kill event, etc to lower database quering all the time.
 *		  Just to make sure the server doesn't 'hiccup' most of the time for the most fresh experience.
 *		  You just don't want some random server hiccups when you're in example clutch situation or during a fight.
 *		  Basically make it an all-in-one simple query.
 *
 *	> 1:
 *		→ Make sure the GetClientPosition() function properly retrieves the correct position.
 *		  Currrently has flaw of outputting same position of users having same points.
 *
 *	> 2:
 *		→ Make Session be saved via SQLIte (Local sql database connection)
 *		  This is to make sure the session is saved, after potential update is found and installed.
 *		  Just for the session to be not lost.
 *
 *	> 3:
 *		→ Make kill events merged as one if multiple kills were made at the same frame.
 */

/* Core */
DatabaseEx SQL;
XStatsForwards Forward;
XStatsCvars Cvars;
XStatsGlobal Global;
XStatsConnectSound Sound[2];

/* Session */
XStatsPlayer Player[MaxPlayers+1];

/* Includes. */
#include "xstats/cvars.sp" /* Console variables */
#include "xstats/assister.sp" /* Experimental Assister */
#include "xstats/database.sp" /* Database */
#include "xstats/game.sp" /* Game */
#include "xstats/forwards.sp" /* Forwards */
#include "xstats/functions.sp" /* Function callbacks */
#include "xstats/commands.sp" /* Commands */
#include "xstats/natives.sp" /* Natives */
#include "xstats/updater.sp" /* Updater Support */
#include "xstats/events.sp" /* Global Events */
#include "xstats/sounds.sp" /* Player Connect Sound */
//#include	"xstats/achievements.sp" /* Achievements */

public void OnPluginStart()	{
	//Prepare.
	PrepareDatabase(true);
	PrepareForwards(); /* Forwards */
	PrepareCvars(); /* Console variables */
	PrepareGame(); /* Game stats */
	PrepareCommands(); /* Commands */
	PrepareEvents(); /* Global events */
	PrepareSounds(); /* Connect sounds */
	
	//Translation.
	LoadTranslations("xstats.phrases");
	
	CPrintToChatAll("{orange}XStats version {lightgreen}%s {orange}loaded", Version);
}

public void OnAllPluginsLoaded() {
	/* Incase the plugin were launched manually or perhaps started or updated (?)*/
	CreateTimer(2.5, CheckPlayersPluginStart);
}