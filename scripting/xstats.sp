#include	<event_manager>
#include	<tklib>
#include	<xstats>
#include	<updater>
#pragma		semicolon	1
#pragma		newdecls	required

/*
	xStats is a multi-game statistical tracking plugin, functioning similiarly to gameMe & HlStatsX.
*/

#define LogTag "[xStats]"
#define Version "0.01"

public Plugin myinfo = {
	name		=	"xStats",
	author		=	"Tk /id/Teamkiller324",
	description	=	"xStats - Statistical tracker.",
	version		=	Version,
	url			=	"https://steamcommunity.com/id/Teamkiller324"
}


/*
	Functions.
*/
GameIdentifier	game	= Game_Unknown;
Database		db		= null;

bool			RoundActive = true;
bool			WarmupActive = false;
ConVar			PluginActive, Debug, AllowBots, AllowWarmup, PrefixCvar, Death, AssistKill;
ConVar			Weapon[40000];

char			Prefix[96], logprefix[64], playerlist[64], kill_log[64];
char			SteamID[64][MAXPLAYERS], Playername[64][MAXPLAYERS], Name[64][MAXPLAYERS], IP[16][MAXPLAYERS];

int				Kill_Scenario = 0;
char			Kill_Type[][] = {
	"",	//unused
	"Kill Type 1",
	"Kill Type 2",
	"Kill Type 3",
	"Kill Type 4",
	"Kill Type 5",
	"Kill Type 6",
	"Kill Type 7"
};

xStatsSession	Session[MAXPLAYERS];

/*
	Includes.
*/

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
	PluginActive = CreateConVar("xstats_enabled", "1", "xStats - Should the tracking plugin be enabled?.", _, true, 0.0, true, 1.0);
	Debug = CreateConVar("xstats_debug", "0", "xStats - Debug.", _, true, 0.0, true, 1.0);
	AllowBots = CreateConVar("xstats_allow_bots", "0", "xStats - Should bots be allowed to be tracked as a valid opponent?.", _, true, 0.0, true, 1.0);
	AllowWarmup = CreateConVar("xstats_allow_warmup", "0", "xStats - Should warmup be a valid round to track?.", _, true, 0.0, true, 1.0);
	
	PrefixCvar = CreateConVar("xstats_prefix", "{green}xStats", "xStats - Prefix to be used ingame texts.");
	PrefixCvar.AddChangeHook(PrefixCallback);
	PrefixCvar.GetString(Prefix, sizeof(Prefix));
	Format(Prefix, sizeof(Prefix), "%s{default}", Prefix);
	
	Death = CreateConVar("xstats_death", "5", "xStats - Points to remove from the player who died.", _, true, 0.0);
	AssistKill = CreateConVar("xstats_assist", "3", "xStats - Points to give the assister.", _, true, 0.0);
	
	AutoExecConfig(true);
	
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