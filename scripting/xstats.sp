#include	<xstats>
#include	<tklib>
#include	<multicolors>
#include	<geoip>

#pragma		semicolon	1
#pragma		newdecls	required

#define		PLUGIN_NAME		"Xstats: Core"

public	Plugin	myinfo	=	{
	name		=	PLUGIN_NAME,
	author		=	"Tk /id/Teamkiller324",
	description	=	"xstats: a player statistics tracking plugin",
	version		=	"0.01a",
	url			=	"https://steamcommunity.com/id/Teamkiller324"
}

bool	RoundActive		=	false;
bool	RankingActive	=	false;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)	{
	RegPluginLibrary(PLUGIN_NAME);
	
	CreateNative("Xstats_GetDatabaseConnection",		Native_GetDatabaseConnection);
	CreateNative("Xstats.GetDatabaseConnection",		Native_GetDatabaseConnection);
	
	CreateNative("Xstats_EstablishDatabaseConnection",	Native_EstablishDatabaseConnection);
	CreateNative("Xstats.EstablishDatabaseConnection",	Native_EstablishDatabaseConnection);
	
	CreateNative("Xstats_IsValidClient",				Native_IsValidClient);
	CreateNative("Xstats.IsValidClient",				Native_IsValidClient);
	
	CreateNative("Xstats_IsValidClientEx",				Native_IsValidClientEx);
	CreateNative("Xstats.IsValidClientEx",				Native_IsValidClientEx);
	
	CreateNative("Xstats_IsValidClientEx2",				Native_IsValidClientEx2);
	CreateNative("Xstats.IsValidClientEx2",				Native_IsValidClientEx2);
	
	CreateNative("Xstats_IsClientAbusive",				Native_IsClientAbusive);
	CreateNative("Xstats.IsClientAbusive",				Native_IsClientAbusive);
	
	CreateNative("Xstats_MinimumPlayers",				Native_MinimumPlayers);
	CreateNative("Xstats.MinimumPlayers",				Native_MinimumPlayers);
	
	CreateNative("Xstats_DisableOnWin",					Native_DisableOnWin);
	CreateNative("Xstats.DisableOnWin",					Native_DisableOnWin);
	
	CreateNative("Xstats_CountBots",					Native_CountBots);
	CreateNative("Xstats.CountBots",					Native_CountBots);
	
	CreateNative("Xstats_Debug",						Native_Debug);
	CreateNative("Xstats.Debug",						Native_Debug);
	
	CreateNative("Xstats_RoundActive",					Native_RoundActive);
	CreateNative("Xstats.RoundActive",					Native_RoundActive);

	CreateNative("Xstats_RankingActive",				Native_RankingActive);
	CreateNative("Xstats.RankingActive",				Native_RankingActive);
	
	CreateNative("Xstats_GetActivePlayers",				Native_GetActivePlayers);
	CreateNative("Xstats.GetActivePlayers",				Native_GetActivePlayers);

	CreateNative("Xstats_GetPrefixTag",					Native_GetPrefixTag);
	CreateNative("Xstats.GetPrefixTag",					Native_GetPrefixTag);
	
	CreateNative("Xstats_GetClientCountry",				Native_GetClientCountry);
	CreateNative("Xstats.GetClientCountry",				Native_GetClientCountry);
	
	CreateNative("Xstats_GetClientPoints",				Native_GetClientPoints);
	CreateNative("Xstats.GetClientPoints",				Native_GetClientPoints);
	
	CreateNative("Xstats_GetClientPos",					Native_GetClientPos);
	CreateNative("Xstats.GetClientPos",					Native_GetClientPos);

	CreateNative("Xstats_GetPlayerCount",				Native_GetPlayerCount);
	CreateNative("Xstats.GetPlayerCount",				Native_GetPlayerCount);
	
	CreateNative("Xstats_IsClientMidAir",				Native_IsClientMidAir);
	CreateNative("Xstats.IsClientMidAir",				Native_IsClientMidAir);
	
	return	APLRes_Success;
}

//================================================//

#include	"xstats/events.sp"
	//Hook events.

#include	"xstats/cvars.sp"
	//Console Variables.

#include	"xstats/commands.sp"
	//Commands.

public void OnPluginStart()	{
	LoadEvents();
		//Load Events.
	
	LoadCvars();
		//Load Console Variables.
	
	LoadCommands();
		//Load commands.
	
	//============================================================================//
	// Player events
	//============================================================================//
	
	HookEvent("player_disconnect", Event_PlayerDisconnect, EventHookMode_Pre);
		//When a player leaves, this is called (Faster than OnClientDisconnect forward).
}

// Events

//==========================================================================//
////////////////////////////| player_disconnect |/////////////////////////////
//==========================================================================//

Action Event_PlayerDisconnect(Event event, const char[] name, bool dontBroadcast)	{
	int client = GetClientOfUserId(event.GetInt("userid"));
	if(IsValidClientEx(client))	{
		GlobalForward disconnect = new GlobalForward("Xstats_OnClientDisconnect", ET_Hook, Param_Cell, Param_String, Param_String);
		Call_StartForward(disconnect);
		Call_PushCell(client);
		char reason[256], auth[64];
		event.GetString("reason", reason, sizeof(reason));
		GetClientAuth(client, auth, sizeof(auth));
		Call_PushString(reason);
		Call_PushString(auth);
		Action action;
		Call_Finish();
		delete disconnect;
		if(action == Plugin_Handled)
			event.BroadcastDisabled = true;
		return action;
	}
	return	Plugin_Continue;
}

//

#include	"xstats/databases.sp"

public void OnMapStart()	{
	LoadDB();
}

int Native_GetDatabaseConnection(Handle plugin, int params)	{
	return	view_as<any>(db);
}

int Native_EstablishDatabaseConnection(Handle plugin, int params)	{
	Native_DB_Initiated = true;
	
	Database.Connect(DBConnect, XSTATS_DBNAME);
	
	return	Native_DB_Succeed;
}

int Native_IsValidClient(Handle plugin, int params)	{
	return IsValidClient(GetNativeCell(1), GetNativeCell(2));
}

int Native_IsValidClientEx(Handle plugin, int params)	{
	return IsValidClientEx(GetNativeCell(1), GetNativeCell(2));
}

int Native_IsValidClientEx2(Handle plugin, int params)	{
	return IsValidClientEx2(GetNativeCell(1), GetNativeCell(2));
}

int Native_IsClientAbusive(Handle plugin, int params)	{
	return IsClientAbusive(GetNativeCell(1), GetNativeCell(2));
}

int Native_MinimumPlayers(Handle plugin, int params)	{
	return MinimumPlayers.IntValue;
}

int Native_DisableOnWin(Handle plugin, int params)	{
	return DisableOnWin.BoolValue;
}

int Native_Debug(Handle plugin, int params)	{
	return Debug.BoolValue;
}

int Native_RoundActive(Handle plugin, int params)	{
	return RoundActive;
}

int Native_RankingActive(Handle plugin, int params)	{
	return RankingActive;
}

int Native_GetActivePlayers(Handle plugin, int params)	{
	return GetActivePlayers(GetNativeCell(1));
}

int Native_CountBots(Handle plugin, int params)	{
	return CountBots.BoolValue;
}

int Native_GetPrefixTag(Handle plugin, int params)	{
	SetNativeString(1, Prefix, GetNativeCell(2));
}

int Native_GetClientCountry(Handle plugin, int params)	{
	int client = GetNativeCell(1);
	
	if(!IsValidClientEx2(client, true))	{
		ThrowNativeError(SP_ERROR_NATIVE, "[%s] Native GetClientCountry: Client index %d is invalid.", PLUGIN_NAME, client);
		return	false;
	}
	
	char ip[16], country[96];
	GetClientIP(client, ip, sizeof(ip));
	if(!GeoipCountry(ip, country, sizeof(country)))
		Format(country, sizeof(country), "unknown country");
	
	if(StrContains(country, "Russian Federation", false) != -1)
		Format(country, sizeof(country), "Russia");
	
	if(StrContains(country, "Macedonia", false) != -1)
		Format(country, sizeof(country), "Macedonia");
		
	if(StrContains(country, "Moldova", false) != -1)
		Format(country, sizeof(country), "Moldova");
	
	SetNativeString(2, country, GetNativeCell(3));
	return	true;
}

int Native_GetClientPoints(Handle plugin, int params)	{
	int client = GetNativeCell(1);
	
	if(!IsValidClientEx2(client, true))
		ThrowNativeError(SP_ERROR_NATIVE, "[%s] Native GetClientPoints: Client index %d is invalid.", PLUGIN_NAME, client);
	
	char query[256], players_table[128], auth[64];
	GetNativeString(2, players_table, sizeof(players_table));
	GetClientAuth(client, auth, sizeof(auth));
	
	int points = 0;	
	Database database = SQL_Connect2(XSTATS_DBNAME);
	Format(query, sizeof(query), "SELECT Points FROM %s WHERE SteamID='%s'", players_table, auth);
	DBResultSet results = SQL_Query(database, query);
	if(IsValidResults(results))
		points = results.FetchInt(0);
	
	delete database;
	delete results;
	
	return	points;
}

int Native_GetClientPos(Handle plugin, int params)	{
	int client = GetNativeCell(1);
	
	if(!IsValidClientEx2(client, true))
		ThrowNativeError(SP_ERROR_NATIVE, "[%s] Native GetClientPos: Client index %d is invalid.", PLUGIN_NAME, client);
	
	char query[256], players_table[128], auth[64];
	GetNativeString(2, players_table, sizeof(players_table));
	GetClientAuth(client, auth, sizeof(auth));
	
	Database database = SQL_Connect2(XSTATS_DBNAME);
	DBResultSet results = null;
	
	Format(query, sizeof(query), "SELECT Points FROM %s WHERE SteamID='%s'", players_table, auth);
	results = SQL_Query(database, query);
	
	if(IsValidResults(results))	{
		Format(query, sizeof(query), "SELECT COUNT(*) FROM %s WHERE Points >='%d'", players_table, results.FetchInt(0));
		results = SQL_Query(database, query);
			
		while(IsValidResults(results))
			return results.FetchInt(0);
	}
	
	delete database;
	delete results;
	
	return 0;
}

int Native_GetPlayerCount(Handle plugin, int params)	{
	char query[256], players_table[128];
	GetNativeString(1, players_table, sizeof(players_table));
	
	Database database = SQL_Connect2(XSTATS_DBNAME);
	Format(query, sizeof(query), "SELECT COUNT(*) FROM %s", players_table);
	DBResultSet results = SQL_Query(database, query);
	while(IsValidResults(results))
		return results.FetchInt(0);
	
	delete database;
	delete results;
	
	return 0;
}

int Native_IsClientMidAir(Handle plugin, int params)	{
	return	IsClientMidAir(GetNativeCell(1));
}

//===============================================//
// Other things.
//===============================================//

public void Xstats_OnRoundBegin()	{
	RoundActive = true;
	
	CheckActivePlayers();
}

public void Xstats_OnRoundEnd()	{
	RoundActive = false;
	
	CheckActivePlayers();
}

public void OnClientAuthorized(int client)	{
	if(IsValidClientEx(client))
		CheckActivePlayers();
}

public Action Xstats_OnClientDisconnect(int client)	{
	if(IsValidClientEx(client))
		CheckActivePlayers();
}

//================================================//

void CheckActivePlayers()	{
	switch(GetActivePlayers(CountBots.BoolValue) < MinimumPlayers.IntValue)	{
		case	true:	RankingActive = false;
		case	false:	RankingActive = true;
	}
}

int GetActivePlayers(bool bots)	{
	int value;
	
	switch(bots)	{
		case	true:	{
			for(int i = 0; i < MaxClients; i++)	{
				if(IsValidClient(i))
					value = i;
			}
		}
		case	false:	{
			for(int i = 0; i < MaxClients; i++)	{
				if(IsValidClient(i) && !IsFakeClient(i))
					value = i;
			}
		}
	}
	return value;
}

//================================================//

/**
 *	Makes sure if the client is valid.
 */
bool IsValidClient(int client, bool IgnoreBots=false)	{
	if(client == 0)
		return	false;
	if(client == -1)
		return	false;
	if(client < 1 || client > MaxClients)
		return	false;
	if(!IsClientConnected(client))
		return	false;
	if(!IsClientInGame(client))
		return	false;
	if(IsClientReplay(client))
		return	false;
	if(IsClientSourceTV(client))
		return	false;
	if(IsFakeClient(client) && IgnoreBots)
		return	false;
	return	true;
}

/**
 *	Same as IsValidClient but removes IsClientInGame check due to that will make client 'invalid' at certain events.
 */
bool IsValidClientEx(int client, bool IgnoreBots=false)	{
	if(client == 0)
		return	false;
	if(client == -1)
		return	false;
	if(client < 1 || client > MaxClients)
		return	false;
	if(!IsClientConnected(client))
		return	false;
	if(IsClientReplay(client))
		return	false;
	if(IsClientSourceTV(client))
		return	false;
	if(IsFakeClient(client) && IgnoreBots)
		return	false;
	return	true;
}

/**
 *	Same as IsValidClient but removes IsClientInGame & IsClientConnected check due to that will make client 'invalid' at certain events.
 */
bool IsValidClientEx2(int client, bool IgnoreBots=false)	{
	if(client == 0)
		return	false;
	if(client == -1)
		return	false;
	if(client < 1 || client > MaxClients)
		return	false;
	if(!IsClientConnected(client))
		return	false;
	if(IsClientReplay(client))
		return	false;
	if(IsClientSourceTV(client))
		return	false;
	if(IsFakeClient(client) && IgnoreBots)
		return	false;
	return	true;
}

/**
 *	Checks through the player if the player is 'abusive'.
 *
 *	Returns true if abusive, else false.
 */
stock bool IsClientAbusive(int client, bool SvCheats=false)	{
	if(GetEntityMoveType(client) != MOVETYPE_WALK)
		return	true;
	if(SvCheats && FindConVar("sv_cheats").IntValue != 0)
		return	true;
	
	return	false;
}

/**
 *	Returns true or false if the client is midair.
 *
 *	@param		client		The client index.
 */
stock bool IsClientMidAir(int client)	{
	if(GetEntPropEnt(client, Prop_Send, "m_hGroundEntity") == -1)
		return	true;
	return	false;
}

//================================================//