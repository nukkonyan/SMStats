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
GlobalForward	Fwd_Prepare;
GlobalForward	Fwd_Death;
PrivateForward	Fwd_GetStats;

/* Plugin */
bool			RoundActive = false;
bool			WarmupActive = false;
bool			RankActive = false;
ConVar			PluginActive, Debug, AllowBots, AllowWarmup, PrefixCvar, Death, AssistKill;
ConVar			ServerID, MinimumPlayers, DisableAfterWin, ConnectMsg;
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
 */
int				Kill_Scenario = 0;
stock char		Kill_Type[][] = {
	"Kill Event Type 0", //unused
	"Kill Event Type 1",
	"Kill Event Type 2",
	"Kill Event Type 3",
	"Kill Event Type 4",
	"Kill Event Type 5",
	"Kill Event Type 6",
	"Kill Event Type 7",
	"Kill Event Type 8",
	"Kill Event Type 9",
	"Kill Event Type 10"
};

/* For experimental assister function. */
int PlayerDamaged[MAXPLAYERS][MAXPLAYERS];

/* Session */
XStatsSession	Session[MAXPLAYERS];

/* Includes. */
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
	
	char title[64];
	GetGameName(title, sizeof(title));
	
	switch(game)	{
		case	Game_TF2:	{
			logprefix = "[Xstats: TF2]";
			playerlist = "playerlist_tf2";
			kill_log = "kill_log_tf2";
			item_found = "item_found_tf2";
			maps_log = "maps_log_tf2";
		}
		case	Game_TF2Classic:	{
			logprefix = "[Xstats: TF2:C]";
			playerlist = "playerlist_tf2classic";
			kill_log = "kill_log_tf2classic";
			maps_log = "maps_log_tf2classic";
			SetFailState("%s Game is unsuppported for the moment.", LogTag);
		}
		case	Game_CSS:	{
			logprefix = "[Xstats: CS:S]";
			playerlist = "playerlist_css";
			kill_log = "kill_log_css";
			maps_log = "maps_log_css";
			SetFailState("%s Game is unsuppported for the moment.", LogTag);
		}
		case	Game_CSPromod:	{
			logprefix = "[Xstats: CS:Promod]";
			playerlist = "playerlist_promod";
			kill_log = "kill_log_cspromod";
			maps_log = "maps_log_cspromod";
			SetFailState("%s Game is unsuppported for the moment.", LogTag);
		}
		case	Game_CSGO:	{
			logprefix = "[Xstats: CS:GO]";
			playerlist = "playerlist_csgo";
			kill_log = "kill_log_csgo";
			item_found = "item_found_csgo";
			maps_log = "maps_log_csgo";
			SetFailState("%s Game is unsuppported for the moment.", LogTag);
		}
		case	Game_CSCO:	{
			logprefix = "[Xstats: CS:CO]";
			playerlist = "playerlist_csco";
			kill_log = "kill_log_csco";
			maps_log = "maps_log_csco";
			SetFailState("%s Game is unsuppported for the moment.", LogTag);
		}
		default:	SetFailState("%s Game is unsupported.", LogTag);
	}
	
	PrintToServer("xStats Version %s Detected game: %s", Version, title);
	
	CreateConVar("xstats_version", Version, "Xstats - Version.").AddChangeHook(VersionChanged);
	PluginActive	= CreateConVar("xstats_enabled",		"1", "Xstats - Should the tracking plugin be enabled?.", _, true, _, true, 1.0);
	Debug			= CreateConVar("xstats_debug",			"0", "Xstats - Debug. (For development purposes)", FCVAR_DEVELOPMENTONLY, true, _, true, 1.0);
	AllowBots		= CreateConVar("xstats_allow_bots",		"0", "Xstats - Should bots be allowed to be tracked as a valid opponent?.", _, true, _, true, 1.0);
	AllowWarmup		= CreateConVar("xstats_allow_warmup",	"0", "Xstats - Should warmup be a valid round to track?.", _, true, _, true, 1.0);
	ServerID		= CreateConVar("xstats_serverid",		"1", "Xstats - Server ID the server should be identified as.", _, true);
	MinimumPlayers	= CreateConVar("xstats_minimumplayers",	"4", "Xstats - Minimum amount of players required.", _, true, 1.0);
	DisableAfterWin	= CreateConVar("xstats_disableafterwin","1", "Xstats - Should tracking be disabled when a team wins/round ends?.", _, true, _, true, 1.0);
	ConnectMsg		= CreateConVar("xstats_connectmsg",		"1", "Xstats - Should connect messages be enabled?", _, true, _, true, 1.0);
	RemoveOldPlayers = CreateConVar("xstats_removeoldplayers", "0", "Xstats - Number of days of days to keep players in the database. (Since last connection). 0 Disables check.");
	
	PrefixCvar = CreateConVar("xstats_prefix", "{green}Xstats", "Xstats - Prefix to be used ingame texts.");
	PrefixCvar.AddChangeHook(PrefixCallback);
	PrefixCvar.GetString(Prefix, sizeof(Prefix));
	Format(Prefix, sizeof(Prefix), "%s{default}", Prefix);
	
	MinimumPlayers.AddChangeHook(PlayerCvarUpdated);
	AllowBots.AddChangeHook(PlayerCvarUpdated);
	
	if(GetEngineVersion() != Engine_TF2)
		Death	= CreateConVar("xstats_points_death",	"5", "Xstats - Points to remove from the player who died.", _, true);
	
	AssistKill	= CreateConVar("xstats_points_assist",	"3", "Xstats - Points to give the assister.", _, true);
	
	//AutoExecConfig(true);
	
	//Prepare.
	PrepareGame(); /* Game stats */
	PrepareCommands(); /* Commands */
	PrepareUpdater(); /* Updater support */
	PrepareEvents(); /* Global events */
	PrepareSounds(); /* Connect sounds */
	
	//Translation. (Will be added later.)
	//LoadTranslations("xstats.phrases");
	
	/* Incase the plugin were launched manually or perhaps started (?)*/
	for(int client = 1; client < MaxClients; client++)	{
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
	
	PreparePrefixForward();
}

void PlayerCvarUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	CheckActivePlayers();
}

Action Assister_OnTakeDamage(int victim, int &client, int &inflictor, float &damage, int &damagetype)	{
	if(Tklib_IsValidClient(victim) && Tklib_IsValidClient(client, true))	{
		//Turn the float into a valid integer.
		char getdmg[96];
		FloatToString(damage, getdmg, sizeof(getdmg));
		SplitString(getdmg, ".", getdmg, sizeof(getdmg));
		int dmg = StringToInt(getdmg);
		
		PlayerDamaged[victim][client] = PlayerDamaged[victim][client]+dmg;

		Session[client].DamageDone += dmg;
	}
}

public void OnPluginEnd()	{
	PrintToServer("%s Ending..", LogTag);
}

/**
 *	Resets the assisted array.
 */
void ResetAssister()	{
	for(int i = 1; i < MaxClients; i++)	{
		for(int x = 1; x < MaxClients; x++)
			PlayerDamaged[i][x] = 0;
	}
}

/**
 *	Returns the user which done the most damage in the active round.
 *
 *	@param	victim	The victim that was damaged to check.
 *	@param	client	The attacker that gave damage to check.
 */
int GetLatestAssister(int victim, int client)	{
	int userid = 0;
	for(int i = 1; i < MaxClients; i++)	{
		//Make sure the user is in the game.
		if(Tklib_IsValidClient(i))	{
			//Make sure to not return the attacker if he did the most damage.
			if(client != i && PlayerDamaged[victim][i] > 50)
				userid = GetClientUserId(i);
		}
	}
	
	return userid;
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
	
	if(WarmupActive)
		return;
	
	int needed = MinimumPlayers.IntValue;
	int players = GetClientCountEx(!AllowBots.BoolValue);
	
	if(DisableAfterWin.BoolValue)	{
		if(needed <= players)	{
			RankActive = true;
			CPrintToChatAll("%s Round Start: Statistical Tracking Enabled [%i/%i]", Prefix, players, needed);
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
		int needed = MinimumPlayers.IntValue;
		int players = GetClientCountEx(!AllowBots.BoolValue);
		
		if(DisableAfterWin.BoolValue)	{
			RankActive = false;
			CPrintToChatAll("%s Round End: Statistical Tracking Disabled [%i/%i]", Prefix, players, needed);
		}
	}
	
	if(RemoveOldPlayers.IntValue >= 1)
		RemoveOldConnectedPlayers(RemoveOldPlayers.IntValue);
	
	ResetAssister();
}