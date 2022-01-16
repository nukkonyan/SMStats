/**
 *	Functions.
 */
ConVar	BombEvent[3];

/* Custom network props */
int m_hFlashBangOwner[MAXPLAYERS] = {0, ...};
int m_hFlashBangEntity[MAXPLAYERS] = {0, ...};

int m_hHeGrenadeOwner[MAXPLAYERS] = {0, ...};
int m_hHeGrenadeEntity[MAXPLAYERS] = {0, ...};

int m_hSmokeGrenadeOwner[MAXPLAYERS] = {0, ...};
int m_hSmokeGrenadeEntity[MAXPLAYERS] = {0, ...};

int m_hSmokeGrenadeParticleOwner[MAXPLAYERS] = {0, ...};
int m_hSmokeGrenadeParticleEntity[MAXPLAYERS] = {0, ...};

int m_hLastFirebombGrenade[MAXPLAYERS] = {0, ...};

stock int LatestFlash = 0; /* The most recent flashbang entity that went off */

void PrepareGame_CounterStrike()	{
	BombEvent[0] = CreateConVar("xstats_points_bomb_planted",	"2", "xStats: Counter-Strike - Points given when planting the bomb.", _, true);
	BombEvent[1] = CreateConVar("xstats_points_bomb_defused",	"2", "xStats: Counter-Strike - Points given when defusing the bomb.", _, true);
	BombEvent[2] = CreateConVar("xstats_points_bomb_exploded",	"2", "xStats: Counter-Strike - Points given when bomb explodes.", _, true);
	
	/* Events */
	HookEventEx(EVENT_BOMB_PLANTED,		CS_Bombs, EventHookMode_Pre);
	HookEventEx(EVENT_BOMB_DEFUSED,		CS_Bombs, EventHookMode_Pre);
	HookEventEx(EVENT_BOMB_EXPLODED,	CS_Bombs, EventHookMode_Pre);
	HookEventEx(EVENT_PLAYER_BLIND,		CS_Flashed, EventHookMode_Pre);
	
	if(IsCurrentGame(Game_CSGO))
		HookEventEx(EVENT_WEAPON_FIRE, Weapon_Fire_CSGO, EventHookMode_Pre);
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

void CS_Flashed(Event event, const char[] event_name, bool dontBroadcast)	{
	int client;
	switch(game)	{
		case	Game_CSS, Game_CSPromod:
			client = m_hFlashBangOwner[client];
		case	Game_CSGO, Game_CSCO:
			client = event.GetInt(EVENT_STR_ATTACKER);
	}
	
	if(!Tklib_IsValidClient(client, true))
		return;
	
	int victim = event.GetInt(EVENT_STR_USERID);
	if(!Tklib_IsValidClient(victim, !(IsFakeClient(client) && !AllowBots.BoolValue)))
		return;
	
	if(IsSameTeam(victim, client) || IsSamePlayers(victim, client))
		return;
	
	if(Debug.BoolValue)	{
		PrintToServer("//===== CS_Flashed =====//");
		PrintToServer("Client: %i (%N)", client, client);
		PrintToServer("Victim: %i (%N)", victim, victim);
		PrintToServer(" ");
	}
	
	Session[client].FlashedOpponents++;
	
	char query[512];
	Format(query, sizeof(query), "select `%s` set FlashedOpponents = FlashedOpponents+1 where SteamID='%s' and ServerID='%i'",
	playerlist, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
}

void Weapon_Fire_CSGO(Event event, const char[] event_name, bool dontBroadcast)	{
	int client = GetClientOfUserId(event.GetInt("userid"));
	
	/* Since both Incendiary and Molotov counts as 'firebomb', we need to get the correct grenade. */
	char[] weapon = new char[64];
	event.GetString(EVENT_STR_WEAPON, weapon, 64); /* You can use sizeof() on construction character function */
	
	if(Debug.BoolValue)	{
		PrintToServer("//===== Weapon_Fire_CSGO =====//");
		PrintToServer("Client: %N", client);
		PrintToServer("weapon: \%s\"", weapon);
		PrintToServer(" ");
	}
	
	if(StrEqual(weapon, "weapon_incgrenade"))
		m_hLastFirebombGrenade[client] = CSGO_Grenade_Incendiary;
	if(StrEqual(weapon, "weapon_molotov"))
		m_hLastFirebombGrenade[client] = CSGO_Grenade_Molotov;
}

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

void OnEntityCreated_CounterStrike(int entity, const char[] classname)	{
	if(!IsValidEntityEx(entity)
	|| entity == -1)
		return; /* In CS:GO, at round start, some entity with index -1 (for some odd reason) is spawned, so this will fix the errors. */
	
	/* Need a short delay so we can get the entity owner. */
	if((StrEqual(classname, "flashbang_projectile")
	|| StrEqual(classname, "hegrenade_projectile")
	|| StrEqual(classname, "smokegrenade_projectile")
	|| StrEqual(classname, "env_particlesmokegrenade")))	{
		DataPack pack = new DataPack();
		pack.WriteCell(EntIndexToEntRef(entity));
		pack.WriteString(classname);
		CreateTimer(0.01, Timer_OnEntityCreated, pack);
	}
}

Action Timer_OnEntityCreated(Handle timer, DataPack pack)	{
	pack.Reset();
	int ref = pack.ReadCell();
	char[] classname = new char[96];
	pack.ReadString(classname, 96);
	delete pack;
	
	int entity = EntRefToEntIndex(ref);
	int client = Ent(entity).Owner; /*GetEntPropEntEx(entity, Prop_Send, "m_hThrower");*/
	LatestFlash = client;
	
	if(StrEqual(classname, "flashbang_projectile"))	{	
		m_hFlashBangEntity[client] = entity;
		m_hFlashBangOwner[client] = client;
	}
	
	if(StrEqual(classname, "hegrenade_projectile"))	{
		m_hHeGrenadeEntity[client] = entity;
		m_hHeGrenadeOwner[client] = client;
	}
	
	if(StrEqual(classname, "smokegrenade_projectile"))	{
		m_hSmokeGrenadeEntity[client] = entity;
		m_hSmokeGrenadeOwner[client] = client;
	}
	
	if(StrEqual(classname, "env_particlesmokegrenade"))	{
		m_hSmokeGrenadeParticleEntity[client] = entity;
		m_hSmokeGrenadeParticleOwner[client] = client;
	}
	
	if(Debug.BoolValue)	{
		PrintToServer("//===== OnEntityCreated_CounterStrike =====//");
		PrintToServer(" ");
		PrintToServer("Classname \"%s\"", classname);
		PrintToServer("Entity index \"%i\"", entity);
		PrintToServer("Entity reference \"%i\"", ref);
		PrintToServer("Thrower \"%i\" \"%d\" (%N)", classname, client, client, client);
		PrintToServer(" ");
	}
	
	//PrintToServer("OnEntityCreated \nclassname \"%s\" \nentity index %i \nentity reference %i \n", classname, entity, ref);
}