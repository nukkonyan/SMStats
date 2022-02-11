#include <multicolors>
#include <xstats>
#include <updater>
#include <geoip>
#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0

/* XStats is a multi-game statistical tracking plugin, influenced by gameMe & HLStatsX. */
#define Version "0.01a_01f"

public Plugin myinfo = {
	name		= "XStats - Statistical Tracker",
	author		= "Tk /id/Teamkiller324",
	description	= "XStats - Track kills, maps, kill events, achievements, etc.",
	version		= Version,
	url			= "https://steamcommunity.com/id/Teamkiller324"
}

/* Core */
XStatsDatabase DB;
XStatsForwards Forward;
XStatsCvars Cvars;
XStatsGlobal Global;
XStatsConnectSound Sound[2];

/* Session */
XStatsPlayer Player[MAXPLAYERS];
XStatsPanel StatsPanel[MAXPLAYERS];
XStatsSession Session[MAXPLAYERS];
XStatsSession TotalStats[MAXPLAYERS];
XStatsKillMsg KillMsg[MAXPLAYERS];

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
	PrepareDatabase();
	PrepareForwards(); /* Forwards */
	PrepareCvars(); /* Console variables */
	PrepareGame(); /* Game stats */
	PrepareCommands(); /* Commands */
	PrepareUpdater(); /* Updater support */
	PrepareEvents(); /* Global events */
	PrepareSounds(); /* Connect sounds */
	
	//Translation.
	LoadTranslations("xstats.phrases");
	
	/* Incase the plugin were launched manually or perhaps started (?)*/
	CheckPlayersPluginStart();
}