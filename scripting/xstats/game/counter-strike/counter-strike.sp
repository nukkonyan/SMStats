/**
 *	Functions.
 */
ConVar	BombEvent[3];

void PrepareGame_CounterStrike()	{
	BombEvent[0] = CreateConVar("xstats_bomb_planted",	"2", "xStats: Counter-Strike - Points given when planting the bomb.", _, true, 0.0);
	BombEvent[1] = CreateConVar("xstats_bomb_defused",	"2", "xStats: Counter-Strike - Points given when defusing the bomb.", _, true, 0.0);
	BombEvent[2] = CreateConVar("xstats_bomb_exploded",	"2", "xStats: Counter-Strike - Points given when bomb explodes.", _, true, 0.0);
}

/*
 *	These events only is called in Counter-Strike.
 *	- Counter-Strike: Source.
 *	- Counter-Strike: Promod.
 *	- Counter-Strike: Global Offensive.
 *	- Counter-Strike: Classic Offensive.
 */

public void EM_Bomb_Planted(int userid)	{
	int client = GetClientOfUserId(userid);
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

public void EM_Bomb_Defused(int userid)	{
	int client = GetClientOfUserId(userid);
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

public void EM_Bomb_Exploded(int userid)	{
	int client = GetClientOfUserId(userid);
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

public void EM_Round_Start()	{
	RoundActive = true;
	
	switch(IsCurrentGame(Game_CSGO))	{
		case	true:	{
			WarmupActive = CS_IsWarmupRound();
			
			if(Debug.BoolValue)	{
				switch(CS_IsWarmupRound())	{
					case	true:	PrintToServer("[xStats: CS] Warmup Round Started");
					case	false:	PrintToServer("[xStats: CS] Round Started");
				}
			}
		}
		case	false:	PrintToServer("[xStats: CS] Round Started");
	}
}

public void EM_Round_End()	{
	RoundActive = false;
	
	switch(IsCurrentGame(Game_CSGO))	{
		case	true:	{
			WarmupActive = CS_IsWarmupRound();
			
			if(Debug.BoolValue)	{
				switch(CS_IsWarmupRound())	{
					case	true:	PrintToServer("[xStats: CS] Warmup Round Ended");
					case	false:	PrintToServer("[xStats: CS] Round Ended");
				}
			}
		}
		case	false:	PrintToServer("[xStats: CS] Round Ended");
	}
}