#include	<tklib>
#include	<multicolors>
#include	<xstats>

#undef	REQUIRE_PLUGIN
#include	<xstats_tf2>

#pragma		semicolon	1
#pragma		newdecls	required

#define		PLUGIN_NAME		"Xstats: Connect"

public	Plugin	myinfo	=	{
	name		=	PLUGIN_NAME,
	author		=	"Tk /id/Teamkiller324",
	description	=	"Shows the connection & disconnection messages",
	version		=	"0.1",
	url			=	"https://steamcommunity.com/id/Teamkiller324"
}

Xstats		xstats;

char		Connect_Playerlist[256], Prefix[64];

Database	db = null;

public void OnPluginStart()	{
	switch(IdentifyGame())	{
		case	Game_TF2:	Format(Connect_Playerlist, sizeof(Connect_Playerlist), "%s", Xstats_playerstats_tf2);
		default:	{
			PrintToServer("[%s] This game is not supported!", PLUGIN_NAME);
			SetFailState("[%s] Fatal error detected!: ERR_GAME_NOT_SUPPORTED", PLUGIN_NAME);
		}
	}
	
	LoadTranslations("xstats_connect.phrases");
		//Load the translations.
	
	PrintToServer("[%s] Module has been initialized!", PLUGIN_NAME);
	
	HookEventEx("player_connect",			SilentIngameMsg, EventHookMode_Pre);
	HookEventEx("player_connect_client",	SilentIngameMsg, EventHookMode_Pre);

	CheckDatabaseConnection();
	CheckPrefixTag();
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
		case	false:
			if(xstats.Debug())
				PrintToServer("[%s] Succeeded gathering database connection!", PLUGIN_NAME);
	}
}

Action DatabaseConnectionRequest(Handle timer)	{
	db = xstats.GetDatabaseConnection();
	
	switch(db == null)	{
		case	true:	{
			PrintToServer("[%s] Failed to gather database connection", PLUGIN_NAME);
			PrintToServer("[%s] Gathering database connection..", PLUGIN_NAME);
			CreateTimer(RetryTimer, DatabaseConnectionRequest);
		}
		case	false:	{
			PrintToServer("[%s] Succeeded gathering database connection!", PLUGIN_NAME);
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

//

void SilentIngameMsg(Event event, const char[] name, bool dontbroadcast)	{
	event.BroadcastDisabled = true;
}

//===========================================================//
// Player has connected.
//===========================================================//

public void OnClientAuthorized(int client, const char[] auth)	{
	if(xstats.IsValidClientEx2(client, true))
		PrintConnectMessage(client);
}

//===========================================================//
// Player has disconnected. Called via 'player_disconnect' event.
//===========================================================//

public Action Xstats_OnClientDisconnect(int client, char[] reason, char[] auth)	{
	if(xstats.IsValidClientEx2(client, true))	{
		PrintDisconnectMessage(client, reason);
		return	Plugin_Handled;
	}
	return	Plugin_Continue;
}


//=======================================//
// Client connected.
//=======================================//
void PrintConnectMessage(int client)	{
	int client_points	= xstats.GetClientPoints(client, Connect_Playerlist);
	int client_position	= xstats.GetClientPos(client, Connect_Playerlist);
	int player_count	= xstats.GetPlayerCount(Connect_Playerlist);

	char country[96], client_name[64];
	xstats.GetClientCountry(client, country, sizeof(country));
	GetClientTeamString(client, client_name, sizeof(client_name));
	
	CPrintToChatAll("%s %t", Prefix, "Client Connected", client_name, client_position, player_count, client_points, country);
}

//=======================================//
// Client disconnected.
//=======================================//
void PrintDisconnectMessage(int client, char[] reason)	{
	int client_points	= xstats.GetClientPoints(client, Connect_Playerlist);
	int client_position	= xstats.GetClientPos(client, Connect_Playerlist);
	int player_count	= xstats.GetPlayerCount(Connect_Playerlist);
	
	char country[96], client_name[64];
	xstats.GetClientCountry(client, country, sizeof(country));
	GetClientTeamString(client, client_name, sizeof(client_name));
	
	CPrintToChatAll("%s %t", Prefix, "Client Disconnected", client_name, client_position, player_count, client_points, country, reason);
}