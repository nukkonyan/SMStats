#include	<geoip>
#include	<tklib>
#include	<multicolors>
#include	<xstats>
#include	<updater>
#pragma		semicolon	1
#pragma		newdecls	required

/**
 *	Xstats is a multi-game statistical tracking plugin, influenced by gameMe & HLStatsX.
 */

#define LogTag "[Xstats]"
#define Version "0.01_dev1"

public Plugin myinfo = {
	name		=	"Xstats - Statistical Tracker",
	author		=	"Tk /id/Teamkiller324",
	description	=	"Xstats - Track kills, maps, kill events, achievements, etc.",
	version		=	Version,
	url			=	"https://steamcommunity.com/id/Teamkiller324"
}

/* Functions. */
GameIdentifier	game	= Game_Unknown;
Database		db;
GlobalForward	Fwd_Prefix;
GlobalForward	Fwd_Death;
GlobalForward	Fwd_Suicide;
PrivateForward	Fwd_GetStats;

/* Plugin */
bool			RoundActive = false;
bool			WarmupActive = false;
bool			RankActive = false;
ConVar			PluginActive, Debug, AllowBots, AllowWarmup, PrefixCvar, Death, AssistKill;
ConVar			ServerID, MinimumPlayers, DisableAfterWin, ConnectMsg, AntiAbuse;
ConVar			Weapon[40000];
ConVar			RemoveOldPlayers;
char			Prefix[96], logprefix[64], playerlist[64], kill_log[64], item_found[64], maps_log[64];
char			CurrentMap[64];

/* Client */
char			SteamID[64][MAXPLAYERS], Playername[64][MAXPLAYERS], Name[64][MAXPLAYERS], IP[16][MAXPLAYERS], Country[MAXPLAYERS][96];

/* Connect sound */
ConVar			ConnectSnd[2];
char			ConnectSound[2][64];

/**
 *	Kill scenario | Used for translations but is currently unused for the moment
 *	due to in process of adding new stuff whole time during development process.
 *	Translations will be added later.
 *	The kill events will be merged together automatically.
 *	Example: Headshot whilst Mid-Air or Headshot Through Smoke whilst Mid-Air, etc.. (You get it)
 */
stock char		Kill_Type[][] = {
	"Kill Event Type 0",	//Mid-Air.
	"Kill Event Type 1",	//Through Smoke.
	"Kill Event Type 2",	//Noscope Headshot.
	"Kill Event Type 3",	//Headshot.
	"Kill Event Type 4",	//Noscope.
	"Kill Event Type 5",	//Backstab.
	"Kill Event Type 6",	//Airshot.
	"Kill Event Type 7",	//Airshot Deflect Kill.
	"Kill Event Type 8",	//Deflect Kill.
	"Kill Event Type 9",	//Telefrag.
	"Kill Event Type 10",	//Collateral.
};

/* Session */
XStatsSession	Session[MAXPLAYERS];

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
	RegPluginLibrary("Xstats");
	
	PrepareNatives();
}

public void OnPluginStart()	{
	//Initialize
	game = IdentifyGame();
	
	/* Forwards */
	Fwd_Prefix = new GlobalForward("Xstats_OnPrefixUpdated",
		ET_Event,
		Param_String);
	Fwd_Death = new GlobalForward("XStats_OnDeathEvent",
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell,
		Param_String,
		Param_Cell);
	Fwd_Suicide = new GlobalForward("XStats_OnSuicideEvent",
		ET_Ignore,
		Param_Cell);
	Fwd_GetStats = new PrivateForward(
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell);
	
	char title[64];
	GetGameName(title, sizeof(title));
	bool supported = false; /* Temporary thing */
	
	switch(game)	{
		case	Game_DODS:	{
			logprefix = "[XStats: DOD:S]";
			playerlist = "playerlist_dods";
			kill_log = "kill_log_dods";
			maps_log = "maps_log_dods";
		}
		case	Game_TF2:	{
			logprefix = "[XStats: TF2]";
			playerlist = "playerlist_tf2";
			kill_log = "kill_log_tf2";
			item_found = "item_found_tf2";
			maps_log = "maps_log_tf2";
			supported = true;
		}
		case	Game_TF2Classic:	{
			logprefix = "[XStats: TF2:C]";
			playerlist = "playerlist_tf2classic";
			kill_log = "kill_log_tf2classic";
			maps_log = "maps_log_tf2classic";
		}
		case	Game_CSS:	{
			logprefix = "[XStats: CS:S]";
			playerlist = "playerlist_css";
			kill_log = "kill_log_css";
			maps_log = "maps_log_css";
			supported = true;
		}
		case	Game_CSPromod:	{
			logprefix = "[XStats: CS:Promod]";
			playerlist = "playerlist_promod";
			kill_log = "kill_log_cspromod";
			maps_log = "maps_log_cspromod";
		}
		case	Game_CSGO:	{
			logprefix = "[XStats: CS:GO]";
			playerlist = "playerlist_csgo";
			kill_log = "kill_log_csgo";
			item_found = "item_found_csgo";
			maps_log = "maps_log_csgo";
			supported = true;
		}
		case	Game_CSCO:	{
			logprefix = "[XStats: CS:CO]";
			playerlist = "playerlist_csco";
			kill_log = "kill_log_csco";
			maps_log = "maps_log_csco";
		}
		case	Game_L4D1:	{
			logprefix = "[XStats: L4D1]";
			playerlist = "playerlist_l4d1";
			kill_log = "kill_log_l4d1";
			maps_log = "maps_log_l4d1";
		}
		case	Game_L4D2:	{
			logprefix = "[XStats: L4D2]";
			playerlist = "playerlist_l4d2";
			kill_log = "kill_log_l4d2";
			maps_log = "maps_log_l4d2";
		}
		case	Game_Contagion:	{
			logprefix = "[XStats: Contagion]";
			playerlist = "playerlist_contagion";
			kill_log = "kill_log_contagion";
			maps_log = "maps_log_contagion";
		}
	}
	
	if(!supported)
		SetFailState("%s Game \"%s\" is unsupported.", LogTag, title);
	
	PrintToServer("XStats Version %s Detected game: %s", Version, title);
	
	CreateConVar("xstats_version", Version, "XStats - Version.").AddChangeHook(VersionChanged);
	PluginActive	= CreateConVar("xstats_enabled",		"1", "XStats - Should the tracking plugin be enabled?.", _, true, _, true, 1.0);
	Debug			= CreateConVar("xstats_debug",			"0", "XStats - Debug. (For development purposes)", FCVAR_DEVELOPMENTONLY, true, _, true, 1.0);
	AllowBots		= CreateConVar("xstats_allow_bots",		"0", "XStats - Should bots be allowed to be tracked as a valid opponent?.", _, true, _, true, 1.0);
	AllowWarmup		= CreateConVar("xstats_allow_warmup",	"0", "XStats - Should warmup be a valid round to track?.", _, true, _, true, 1.0);
	ServerID		= CreateConVar("xstats_serverid",		"1", "XStats - Server ID the server should be identified as.", _, true);
	MinimumPlayers	= CreateConVar("xstats_minimumplayers",	"4", "XStats - Minimum amount of players required.", _, true, 1.0);
	DisableAfterWin	= CreateConVar("xstats_disableafterwin","1", "XStats - Should tracking be disabled when a team wins/round ends?.", _, true, _, true, 1.0);
	ConnectMsg		= CreateConVar("xstats_connectmsg",		"1", "XStats - Should connect messages be enabled?", _, true, _, true, 1.0);
	RemoveOldPlayers = CreateConVar("xstats_removeoldplayers", "0", "XStats - Number of days of days to keep players in the database. (Since last connection). 0 Disables check.");
	AntiAbuse		= CreateConVar("xstats_antiabuse",		"1", "XStats - Should abusing players be avoided to make sure the event was legit? (Noclipping, sv_cheats, etc)", _, true, _, true, 1.0);
	
	PrefixCvar = CreateConVar("xstats_prefix", "{green}Xstats", "XStats - Prefix to be used ingame texts.");
	PrefixCvar.AddChangeHook(PrefixCallback);
	PrefixCvar.GetString(Prefix, sizeof(Prefix));
	Format(Prefix, sizeof(Prefix), "%s{default}", Prefix);
	
	MinimumPlayers.AddChangeHook(PlayerCvarUpdated);
	AllowBots.AddChangeHook(PlayerCvarUpdated);
	
	if(GetEngineVersion() != Engine_TF2)
		Death	= CreateConVar("xstats_points_death",	"5", "XStats - Points to remove from the player who died.", _, true);
	
	AssistKill	= CreateConVar("xstats_points_assist",	"3", "XStats - Points to give the assister.", _, true);
	
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
	for(int client = 1; client < MaxClients; client++)	{
		/* Only gather the steamid from the players */
		if(Tklib_IsValidClient(client, true, false, false))
			GetClientAuth(client, SteamID[client], sizeof(SteamID[]));
		
		/* Bots needs a name too, right? */
		if(Tklib_IsValidClient(client, false, false, false))	{
			GetClientNameEx(client, Playername[client], sizeof(Playername[]));
			GetClientTeamString(client, Name[client], sizeof(Name[]));
		}
	}
}

public void OnConfigsExecuted()	{
	CheckActivePlayers();
}

void VersionChanged(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	if(!StrEqual(newvalue, Version))
		cvar.SetString(Version);
}

void PrefixCallback(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	cvar.GetString(Prefix, sizeof(Prefix));
	Format(Prefix, sizeof(Prefix), "%s{default}", Prefix);
	
	PreparePrefixUpdatedForward();
}

void PlayerCvarUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	CheckActivePlayers();
}

public void OnPluginEnd()	{
	PrintToServer("%s Ending..", LogTag);
}

/* When round starts */
stock void RoundStarted()	{
	RoundActive = true;
	
	switch(game)	{
		case	Game_CSGO, Game_CSCO:
			WarmupActive = CS_IsWarmupRound();
		case	Game_TF2, Game_TF2C, Game_TF2B, Game_TF2V, Game_TF2OP:
			WarmupActive = TF2_IsWaitingForPlayers();
	}
	
	if(Debug.BoolValue)	{
		switch(WarmupActive)	{
			case	true:	PrintToServer("%s Warmup Round Started", LogTag);
			case	false:	PrintToServer("%s Round Started", LogTag);
		}
	}
	
	if(RoundActive && WarmupActive)	{
		CPrintToChatAll("%s %t", Prefix, "Round Start Warmup");
		return;
	}
	
	int needed = MinimumPlayers.IntValue;
	int players = GetClientCountEx(!AllowBots.BoolValue);
	
	if(DisableAfterWin.BoolValue)	{
		if(needed <= players)	{
			RankActive = true;
			CPrintToChatAll("%s %t", Prefix, "Round Start");
		}
	}
}

/* When round ends */
stock void RoundEnded()	{
	RoundActive = false;
	
	switch(game)	{
		case	Game_CSGO, Game_CSCO:
			WarmupActive = CS_IsWarmupRound();
		case	Game_TF2, Game_TF2C:
			WarmupActive = TF2_IsWaitingForPlayers();
	}
			
	if(Debug.BoolValue)	{
		switch(WarmupActive)	{
			case	true:	PrintToServer("%s Warmup Round Ended", LogTag);
			case	false:	PrintToServer("%s Round Ended", LogTag);
		}
	}
	
	if(!WarmupActive)	{
		if(DisableAfterWin.BoolValue)	{
			RankActive = false;
			CPrintToChatAll("%s %t", Prefix, "Round End");
		}
	}
	
	if(RemoveOldPlayers.IntValue >= 1)
		RemoveOldConnectedPlayers(RemoveOldPlayers.IntValue);
	
	ResetAssister();
}