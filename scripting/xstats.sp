#include <multicolors>
#include <xstats>
#include <updater>
#include <geoip>
#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0

/**
 *	Xstats is a multi-game statistical tracking plugin, influenced by gameMe & HLStatsX.
 */

#define LogTag "[XStats]"
#define Version "0.0.1b"

public Plugin myinfo = {
	name		= "XStats - Statistical Tracker",
	author		= "Tk /id/Teamkiller324",
	description	= "XStats - Track kills, maps, kill events, achievements, etc.",
	version		= Version,
	url			= "https://steamcommunity.com/id/Teamkiller324"
}

/* Functions. */

/* Core */
XStatsDatabase DB;
XStatsForwards Forward;
XStatsPlayer Player[MAXPLAYERS];
XStatsCvars Cvars;
XStatsGlobal Global;
XStatsConnectSound Sound[2];

/* Session */
XStatsSession Session[MAXPLAYERS];
XStatsKillMsg KillMsg[MAXPLAYERS];

/**
 *	Kill scenario | Used for translations but is currently unused for the moment
 *	due to in process of adding new stuff whole time during development process.
 *	Translations will be added later.
 *	The kill events will be merged together automatically.
 *	Example: Headshot whilst Mid-Air or Headshot Through Smoke whilst Mid-Air, etc.. (You get it)
 */
stock char Kill_Type[][] = {
	"Kill Event Type 0",	//Mid-Air.
	"Kill Event Type 1",	//Through Smoke.
	"Kill Event Type 2",	//Noscope Headshot.
	"Kill Event Type 3",	//Headshot.
	"Kill Event Type 4",	//Noscope.
	"Kill Event Type 5",	//Backstab.
	"Kill Event Type 6",	//Airshot.
	"Kill Event Type 7",	//Deflect Kill.
	"Kill Event Type 8",	//Telefrag.
	"Kill Event Type 9",	//Taunt Kill.
	"Kill Event Type 10",	//Collateral.
	"Kill Event Type 11",	//Grenade Kill.
	"Kill Event Type 12",	//Bomb Kill.
	"Kill Event Type 13",	//Blinded Kill.
};

/* Includes. */
#include	"xstats/assister.sp" /* Experimental Assister */
#include	"xstats/database.sp" /* Database */
#include	"xstats/game.sp" /* Game */
#include	"xstats/forwards.sp" /* Forwards */
#include	"xstats/functions.sp" /* Function callbacks */
#include	"xstats/commands.sp" /* Commands */
#include	"xstats/natives.sp" /* Natives */
#include	"xstats/updater.sp" /* Updater Support */
#include	"xstats/events.sp" /* Global Events */

#include	"xstats/sounds.sp" /* Player Connect Sound */
//#include	"xstats/achievements.sp" /* Achievements */

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)	{
	RegPluginLibrary("XStats");
	PrepareNatives();
}

public void OnPluginStart()	{
	//Initialize
	Global.Game = IdentifyGame();
	GetGameName(Global.GameTitle, sizeof(Global.GameTitle));
	Global.RoundActive = true;
	Global.WarmupActive = false;
	
	/* Forwards */
	Forward.Prefix = new GlobalForward("XStats_OnPrefixUpdated",
		ET_Event,
		Param_String);
	Forward.Death = new GlobalForward("XStats_OnDeathEvent",
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell,
		Param_String,
		Param_Cell);
	Forward.Suicide = new GlobalForward("XStats_OnSuicideEvent",
		ET_Ignore,
		Param_Cell);
	Forward.GetStats = new PrivateForward(
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell);
	Forward.TF2_FlagEvent = new GlobalForward("XStats_TF2_OnFlagEvent",
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell,
		Param_Cell);
	
	CreateConVar("xstats_version", Version, "XStats - Version.").AddChangeHook(VersionChanged);
	Cvars.PluginActive		= CreateConVar("xstats_enabled",		"1", "XStats - Should the tracking plugin be enabled?.", _, true, _, true, 1.0);
	Cvars.Debug				= CreateConVar("xstats_debug",			"0", "XStats - Debug. (For development purposes)", FCVAR_DEVELOPMENTONLY, true, _, true, 1.0);
	Cvars.AllowBots			= CreateConVar("xstats_allow_bots",		"0", "XStats - Should bots be allowed to be tracked as a valid opponent?.", _, true, _, true, 1.0);
	Cvars.AllowWarmup		= CreateConVar("xstats_allow_warmup",	"0", "XStats - Should warmup be a valid round to track?.", _, true, _, true, 1.0);
	Cvars.ServerID			= CreateConVar("xstats_serverid",		"1", "XStats - Server ID the server should be identified as.", _, true);
	Cvars.MinimumPlayers	= CreateConVar("xstats_minimumplayers",	"4", "XStats - Minimum amount of players required.", _, true, 1.0);
	Cvars.DisableAfterWin	= CreateConVar("xstats_disableafterwin","1", "XStats - Should tracking be disabled when a team wins/round ends?.", _, true, _, true, 1.0);
	Cvars.ConnectMsg		= CreateConVar("xstats_connectmsg",		"1", "XStats - Should connect messages be enabled?", _, true, _, true, 1.0);
	Cvars.RemoveOldPlayers	= CreateConVar("xstats_removeoldplayers", "0", "XStats - Number of days of days to keep players in the database. (Since last connection). 0 Disables check.");
	Cvars.AntiAbuse			= CreateConVar("xstats_antiabuse",		"1", "XStats - Should abusing players be avoided to make sure the event was legit? (Noclipping, sv_cheats, etc)", _, true, _, true, 1.0);
	
	Cvars.PrefixCvar = CreateConVar("xstats_prefix", "{green}XStats", "XStats - Prefix to be used ingame texts.");
	Cvars.PrefixCvar.AddChangeHook(PrefixCallback);
	Cvars.PrefixCvar.GetString(Global.Prefix, sizeof(Global.Prefix));
	Format(Global.Prefix, sizeof(Global.Prefix), "%s{default}", Global.Prefix);
	
	Cvars.MinimumPlayers.AddChangeHook(PlayerCvarUpdated);
	Cvars.AllowBots.AddChangeHook(PlayerCvarUpdated);
	
	if(GetEngineVersion() != Engine_TF2)
		Cvars.Death	= CreateConVar("xstats_points_death", "5", "XStats - Points to remove from the player who died.", _, true);
	
	Cvars.AssistKill = CreateConVar("xstats_points_assist",	"3", "XStats - Points to give the assister.", _, true);
	
	//AutoExecConfig(true);
	
	//Prepare.
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

public void OnConfigsExecuted()	{
	CheckActivePlayers();
}

void VersionChanged(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	if(!StrEqual(newvalue, Version))
		cvar.SetString(Version);
}

void PrefixCallback(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	cvar.GetString(Global.Prefix, sizeof(Global.Prefix));
	Format(Global.Prefix, sizeof(Global.Prefix), "%s{default}", Global.Prefix);
	
	PreparePrefixUpdatedForward();
}

void PlayerCvarUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	CheckActivePlayers();
}

public void OnPluginEnd()	{
	PrintToServer("%s Ending..", LogTag);
}

public void OnEntityCreated(int entity, const char[] classname)	{
	OnEntityCreated_CounterStrike(entity, classname);
}