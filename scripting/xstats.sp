#include	<tklib>
#include	<multicolors>
#include	<xstats>
#include	<updater>
#pragma		semicolon	1
#pragma		newdecls	required

/*
	xStats is a multi-game statistical tracking plugin, functioning similiarly to gameMe & HlStatsX.
*/

#define LogTag "[Xstats]"
#define Version "0.01_dev1"

public Plugin myinfo = {
	name		=	"Xstats - Statistical Tracker",
	author		=	"Tk /id/Teamkiller324",
	description	=	"Xstats - Statistical tracker.",
	version		=	Version,
	url			=	"https://steamcommunity.com/id/Teamkiller324"
}

/* Functions. */
GameIdentifier	game	= Game_Unknown;
Database		db		= null;

/* Plugin */
bool			RoundActive = true;
bool			WarmupActive = false;
ConVar			PluginActive, Debug, AllowBots, AllowWarmup, PrefixCvar, Death, AssistKill;
ConVar			ServerID;
ConVar			Weapon[40000];
char			Prefix[96], logprefix[64], playerlist[64], kill_log[64];

/* Client */
char			SteamID[64][MAXPLAYERS], Playername[64][MAXPLAYERS], Name[64][MAXPLAYERS], IP[16][MAXPLAYERS];

/* Kill scenario */
int				Kill_Scenario = 0;
char			Kill_Type[][] = {
	"",	//unused
	"Kill Event Type 1",
	"Kill Event Type 2",
	"Kill Event Type 3",
	"Kill Event Type 4",
	"Kill Event Type 5",
	"Kill Event Type 6",
	"Kill Event Type 7",
	"Kill Event Type 8"
};

//For experimental assister function.
int PlayerDamaged[MAXPLAYERS][MAXPLAYERS];

/* Session */
XstatsSession	Session[MAXPLAYERS];

/* Includes. */
#include	"xstats/database.sp"
#include	"xstats/game.sp"
#include	"xstats/forwards.sp"
#include	"xstats/functions.sp"
#include	"xstats/commands.sp"
#include	"xstats/natives.sp"
#include	"xstats/updater.sp"

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)	{
	RegPluginLibrary("xStats");
	
	PrepareNatives();
}

public void OnPluginStart()	{
	//Initialize
	game = IdentifyGame();
	
	char title[64];
	switch(game)	{
		case	Game_TF2:	{
			logprefix = "[xStats: TF2]";
			title = "Team Fortress 2";
			playerlist = "playerlist_tf2";
			kill_log = "kill_log_tf2";
		}
		case	Game_TF2Classic:	{
			logprefix = "[xStats: TF2C]";
			title = "Team Fortress 2: Classic";
			playerlist = "playerlist_tf2classic";
			kill_log = "kill_log_tf2classic";
			SetFailState("%s Game is unsuppported for the moment.", LogTag);
		}
		case	Game_CSS:	{
			logprefix = "[xStats: CSS]";
			title = "Counter-Strike: Source";
			playerlist = "playerlist_css";
			kill_log = "kill_log_css";
		}
		case	Game_CSPromod:	{
			logprefix = "[xStats: CSPromod]";
			title = "Counter-Strike: Promod";
			playerlist = "playerlist_promod";
			kill_log = "kill_log_cspromod";
			SetFailState("%s Game is unsuppported for the moment.", LogTag);
		}
		case	Game_CSGO:	{
			logprefix = "[xStats: CSGO]";
			title = "Counter-Strike: Global Offensive";
			playerlist = "playerlist_csgo";
			kill_log = "kill_log_csgo";
		}
		case	Game_CSCO:	{
			logprefix = "[xStats: CSCO]";
			title = "Counter-Strike: Classic Offensive";
			playerlist = "playerlist_csco";
			kill_log = "kill_log_csco";
			SetFailState("%s Game is unsuppported for the moment.", LogTag);
		}
		default:	SetFailState("%s Game is unsupported.", LogTag);
	}
	
	PrintToServer("xStats Version %s Detected game: %s", Version, title);
	
	CreateConVar("xstats_version", Version, "xStats - Version.").AddChangeHook(VersionChanged);
	PluginActive	= CreateConVar("xstats_enabled",		"1", "Xstats - Should the tracking plugin be enabled?.", _, true, 0.0, true, 1.0);
	Debug			= CreateConVar("xstats_debug",			"0", "Xstats - Debug. (For development purposes)", FCVAR_DEVELOPMENTONLY, true, 0.0, true, 1.0);
	AllowBots		= CreateConVar("xstats_allow_bots",		"0", "Xstats - Should bots be allowed to be tracked as a valid opponent?.", _, true, 0.0, true, 1.0);
	AllowWarmup		= CreateConVar("xstats_allow_warmup",	"0", "Xstats - Should warmup be a valid round to track?.", _, true, 0.0, true, 1.0);
	ServerID		= CreateConVar("xstats_serverid",		"1", "Xstats - Server ID the server should be identified as.", _, true, 0.0);
	
	PrefixCvar = CreateConVar("xstats_prefix", "{green}Xstats", "Xstats - Prefix to be used ingame texts.");
	PrefixCvar.AddChangeHook(PrefixCallback);
	PrefixCvar.GetString(Prefix, sizeof(Prefix));
	Format(Prefix, sizeof(Prefix), "%s{default}", Prefix);
	
	Death		= CreateConVar("xstats_points_death",	"5", "Xstats - Points to remove from the player who died.", _, true, 0.0);
	AssistKill	= CreateConVar("xstats_points_assist",	"3", "Xstats - Points to give the assister.", _, true, 0.0);
	
	//AutoExecConfig(true);
	
	//Prepare.
	PrepareDatabase();
	PrepareGame();
	PrepareCommands();
	PrepareUpdater();
	
	//Translation.
	LoadTranslations("xstats.phrases");
}

void VersionChanged(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	cvar.SetString(Version);
}

void PrefixCallback(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	cvar.GetString(Prefix, sizeof(Prefix));
	Format(Prefix, sizeof(Prefix), "%s{default}", Prefix);
}

Action Assister_OnTakeDamage(int victim, int &client, int &inflictor, float &damage, int &damagetype)	{
	if(Tklib_IsValidClient(victim) && Tklib_IsValidClient(client))	{
		//Turn the float into a valid integer.
		char getdmg[96];
		FloatToString(damage, getdmg, sizeof(getdmg));
		SplitString(getdmg, ".", getdmg, sizeof(getdmg));
		int dmg = StringToInt(getdmg);
		
		PlayerDamaged[victim][client] = PlayerDamaged[victim][client]+dmg;		
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
	
	switch(IsCurrentGame(Game_CSGO))	{
		case	true:	{
			WarmupActive = CS_IsWarmupRound();
			
			if(Debug.BoolValue)	{
				switch(CS_IsWarmupRound())	{
					case	true:	PrintToServer("%s Warmup Round Started", LogTag);
					case	false:	PrintToServer("%s Round Started", LogTag);
				}
			}
		}
		case	false:	PrintToServer("%s Round Started", LogTag);
	}
}

/* When round ends */
stock void RoundEnded()	{
	RoundActive = false;
	
	switch(IsCurrentGame(Game_CSGO))	{
		case	true:	{
			WarmupActive = CS_IsWarmupRound();
			
			if(Debug.BoolValue)	{
				switch(CS_IsWarmupRound())	{
					case	true:	PrintToServer("%s Warmup Round Ended", LogTag);
					case	false:	PrintToServer("%s Round Ended", LogTag);
				}
			}
		}
		case	false:	PrintToServer("%s Round Ended", LogTag);
	}
}