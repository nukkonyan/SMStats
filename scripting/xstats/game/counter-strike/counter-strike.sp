/**
 *	Functions.
 */
ConVar	BombEvent[3];

void PrepareGame_CounterStrike()	{
	BombEvent[0] = CreateConVar("xstats_points_bomb_planted",	"2", "xStats: Counter-Strike - Points given when planting the bomb.", _, true);
	BombEvent[1] = CreateConVar("xstats_points_bomb_defused",	"2", "xStats: Counter-Strike - Points given when defusing the bomb.", _, true);
	BombEvent[2] = CreateConVar("xstats_points_bomb_exploded",	"2", "xStats: Counter-Strike - Points given when bomb explodes.", _, true);
	
	/* Events */
	HookEventEx(EVENT_BOMB_PLANTED,		CS_Bombs, EventHookMode_Pre);
	HookEventEx(EVENT_BOMB_DEFUSED,		CS_Bombs, EventHookMode_Pre);
	HookEventEx(EVENT_BOMB_EXPLODED,	CS_Bombs, EventHookMode_Pre);
	
	HookEventEx(EVENT_ROUND_END,	CS_Round, EventHookMode_Pre);
	HookEventEx(EVENT_ROUND_START,	CS_Round, EventHookMode_Pre);
}

/**
 *	These events are only called in Counter-Strike.
 *	- Counter-Strike: Source.
 *	- Counter-Strike: Promod.
 *	- Counter-Strike: Global Offensive.
 *	- Counter-Strike: Classic Offensive.
 */

stock void CS_Bombs(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats())
		return;
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(client, true))
		return;
	
	char query[256];
	int points = 0;
	
	if(StrEqual(event_name, EVENT_BOMB_PLANTED) && CS_GetClientTeam(client) == CSTeam_T)	{
		points = BombEvent[0].IntValue;
		
		Session[client].BombsPlanted++;
		Format(query, sizeof(query), "update `%s` set BombsPlanted = BombsPlanted+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(points > 0)	{
			AddSessionPoints(client, points);
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", playerlist, points, SteamID[client]);
			db.Query(DBQuery_Callback, query);
			int points_client = GetClientPoints(SteamID[client]);
			
			CPrintToChat(client, "%s %s (%i) earned %i points for planting the bomb.",
			Prefix, Name[client], points_client, points);
		}
	}
	
	if(StrEqual(event_name, EVENT_BOMB_DEFUSED) && CS_GetClientTeam(client) == CSTeam_CT)	{
		points = BombEvent[1].IntValue;
		
		Session[client].BombsDefused++;
		Format(query, sizeof(query), "update `%s` set BombsDefused = BombsDefused+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(points > 0)	{
			AddSessionPoints(client, points);
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", playerlist, points, SteamID[client]);
			db.Query(DBQuery_Callback, query);
			int points_client = GetClientPoints(SteamID[client]);
			
			CPrintToChat(client, "%s %s (%i) earned %i points for defusing the bomb.",
			Prefix, Name[client], points_client, points);
		}
		
		if(StrEqual(event_name, EVENT_BOMB_EXPLODED) && CS_GetClientTeam(client) == CSTeam_T)	{
			points = BombEvent[2].IntValue;
			
			Session[client].BombsExploded++;
			Format(query, sizeof(query), "update `%s` set BombsDefused = BombsDefused+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(points > 0)	{
				AddSessionPoints(client, points);
				Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", playerlist, points, SteamID[client]);
				db.Query(DBQuery_Callback, query);
				int points_client = GetClientPoints(SteamID[client]);
				
				CPrintToChat(client, "%s %s (%i) earned %i points for letting bomb explode.",
				Prefix, Name[client], points_client, points);
			}
		}
	}
}

stock void CS_Round(Event event, const char[] event_name, bool dontBroadcast)	{StrEqual(event_name, EVENT_ROUND_END) ? RoundEnded() : RoundStarted();}

/**
 *	At the moment not gonna be super accurate
 *	but will be fixed up later and be more accurate.
 */
public Action CS_OnBuyCommand(int client, const char[] weapon)	{
	if(Tklib_IsValidClient(client, true))	{
		DataPack pack = new DataPack();
		pack.WriteCell(client);
		pack.WriteString(weapon);
		CreateTimer(0.25, Timer_OnBuyCommand, pack);
	}
}

Action Timer_OnBuyCommand(Handle timer, DataPack pack)	{
	pack.Reset();
	int client = pack.ReadCell();
	char weapon[64];
	pack.ReadString(weapon, sizeof(weapon));
	delete pack;
	
	/* If player left */
	if(!IsClientConnected(client))	{
		KillTimer(timer);
		return Plugin_Handled;
	}
	
	int price = CS_GetPriceFromWeapon(weapon);
	Session[client].MoneySpent = Session[client].MoneySpent;
	
	char query[256];
	Format(query, sizeof(query), "update `%s` set MoneySpent = MoneySpent+%i where SteamID='%i' and ServerID='%i'",
	playerlist, price, SteamID[client], ServerID.IntValue);
	
	return Plugin_Handled;
}