/**
 *	Functions.
 */
ConVar	BombEvent[3];

void PrepareGame_CounterStrike()	{
	BombEvent[0] = CreateConVar("xstats_bomb_planted",	"2", "xStats: Counter-Strike - Points given when planting the bomb.", _, true, 0.0);
	BombEvent[1] = CreateConVar("xstats_bomb_defused",	"2", "xStats: Counter-Strike - Points given when defusing the bomb.", _, true, 0.0);
	BombEvent[2] = CreateConVar("xstats_bomb_exploded",	"2", "xStats: Counter-Strike - Points given when bomb explodes.", _, true, 0.0);
	
	/* Events */
	HookEventEx(EVENT_BOMB_PLANTED, Bomb_Planted, EventHookMode_Pre);
	HookEventEx(EVENT_BOMB_DEFUSED, Bomb_Defused, EventHookMode_Pre);
	HookEventEx(EVENT_BOMB_EXPLODED, Bomb_Exploded, EventHookMode_Pre);
	
	HookEventEx(EVENT_ROUND_END, Round_End, EventHookMode_Pre);
	HookEventEx(EVENT_ROUND_START, Round_Start, EventHookMode_Pre);
}

/*
 *	These events only is called in Counter-Strike.
 *	- Counter-Strike: Source.
 *	- Counter-Strike: Promod.
 *	- Counter-Strike: Global Offensive.
 *	- Counter-Strike: Classic Offensive.
 */

stock void Bomb_Planted(Event event, const char[] event_name, bool dontBroadcast)	{
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	int points = BombEvent[0].IntValue;
	
	if(Tklib_IsValidClient(client, true))	{
		if(CS_GetClientTeam(client) != CSTeam_T)
			return;
		
		char query[256];
		GetClientTeamString(client, Name[client], sizeof(Name[]));
		
		Session[client].BombsPlanted++;
		Format(query, sizeof(query), "update `%s` set BombsPlanted = BombsPlanted+1 where SteamID='%s'", playerlist, SteamID[client]);
		db.Query(DBQuery_CS_Bombs, query);
		
		if(points > 0)	{
			Session[client].Points = Session[client].Points+points;
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", playerlist, points, SteamID[client]);
			db.Query(DBQuery_CS_Bombs, query);
			int points_client = GetClientPoints(SteamID[client]);
			
			CPrintToChat(client, "%s %t{default}", Prefix, "Bomb Planted", Name[client], points_client, points);
		}
	}
}

stock void Bomb_Defused(Event event, const char[] event_name, bool dontBroadcast)	{
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	int points = BombEvent[1].IntValue;
	
	if(Tklib_IsValidClient(client, true))	{
		if(CS_GetClientTeam(client) != CSTeam_CT)
			return;
		
		char query[256];
		GetClientTeamString(client, Name[client], sizeof(Name[]));
		
		Session[client].BombsDefused++;
		Format(query, sizeof(query), "update `%s` set BombsDefused = BombsDefused+1 where SteamID='%s'", playerlist, SteamID[client]);
		db.Query(DBQuery_CS_Bombs, query);
		
		if(points > 0)	{
			Session[client].Points = Session[client].Points+points;
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", playerlist, points, SteamID[client]);
			db.Query(DBQuery_CS_Bombs, query);
			int points_client = GetClientPoints(SteamID[client]);
			
			CPrintToChat(client, "%s %t{default}", Prefix, "Bomb Defused", Name[client], points_client, points);
		}
	}
}

stock void Bomb_Exploded(Event event, const char[] event_name, bool dontBroadcast)	{
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	int points = BombEvent[2].IntValue;
	
	if(Tklib_IsValidClient(client, true))	{
		if(CS_GetClientTeam(client) != CSTeam_T)
			return;
		
		char query[256];
		GetClientTeamString(client, Name[client], sizeof(Name[]));
		
		Session[client].BombsExploded++;
		Format(query, sizeof(query), "update `%s` set BombsDefused = BombsDefused+1 where SteamID='%s'", playerlist, SteamID[client]);
		db.Query(DBQuery_CS_Bombs, query);
		
		if(points > 0)	{
			Session[client].Points = Session[client].Points+points;
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", playerlist, points, SteamID[client]);
			db.Query(DBQuery_CS_Bombs, query);
			int points_client = GetClientPoints(SteamID[client]);
			
			CPrintToChat(client, "%s %t{default}", Prefix, "Bomb Explode", Name[client], points_client, points);
		}
	}
}

void DBQuery_CS_Bombs(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		SetFailState("[xStats: CS] Updating player table for bomb event failed! (%s)", error);
}

stock void Round_End(Event event, const char[] event_name, bool dontBroadcast)	{
	RoundEnded();
	ResetAssister();
}

stock void Round_Start(Event event, const char[] event_name, bool dontBroadcast)	{
	RoundStarted();
}