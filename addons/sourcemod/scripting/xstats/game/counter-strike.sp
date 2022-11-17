/**
 *	Functions.
 */
ConVar	BombEvent[3];
ConVar	HostageEvent[2];

/* Custom network props */
stock int m_hLastFlashBangGrenade = 0;
stock int m_hLastHeGrenade = 0;
stock int m_hLastSmokeGrenade = 0;
stock int m_hLastFirebombGrenade[MaxPlayers+1] = -1;
stock int m_hLastGrenade[MaxPlayers+1] = -1;

stock int m_hLastBombPlanter = 0;
stock int m_hLastBombDefuser = 0;

stock bool m_bIsFlashed[MaxPlayers+1] = false;

void PrepareGame_CounterStrike() {
	/* Bomb events */
	BombEvent[0] = CreateConVar("xstats_points_bomb_planted",	"2", "XStats: Counter-Strike - Points given when planting the bomb.", _, true);
	BombEvent[1] = CreateConVar("xstats_points_bomb_defused",	"2", "XStats: Counter-Strike - Points given when defusing the bomb.", _, true);
	BombEvent[2] = CreateConVar("xstats_points_bomb_exploded",	"2", "XStats: Counter-Strike - Points given when bomb explodes.", _, true);
	
	/* Hostage events */
	HostageEvent[0] = CreateConVar("xstats_points_hostage_rescued",	"2", "XStats: Counter-Strike - Points given when hostage is rescued.", _, true);
	HostageEvent[1] = CreateConVar("xstats_points_hostage_killed",	"2", "XStats: Counter-Strike - Points taken when hostage is killed.", _, true);
	
	/* Events */
	HookEventEx(EVENT_BOMB_PLANTED, CS_Bombs, EventHookMode_Pre);
	HookEventEx(EVENT_BOMB_DEFUSED, CS_Bombs, EventHookMode_Pre);
	HookEventEx(EVENT_BOMB_EXPLODED, CS_Bombs, EventHookMode_Pre);
	
	/* Hostages */
	HookEventEx(EVENT_HOSTAGE_RESCUED, CS_Hostages, EventHookMode_Pre);
	HookEventEx(EVENT_HOSTAGE_KILLED, CS_Hostages, EventHookMode_Pre);
	
	/* Blinded */
	HookEventEx(EVENT_PLAYER_BLIND, CS_Flashed, EventHookMode_Pre);
	
	if(IsCurrentGame(Game_CSGO)) HookEvent(EVENT_WEAPON_FIRE, Weapon_Fire_CSGO, EventHookMode_Pre);
}

/**
 *	These events are only called in Counter-Strike.
 *	- Counter-Strike: Source.
 *	- Counter-Strike: Promod.
 *	- Counter-Strike: Global Offensive.
 *	- Counter-Strike: Classic Offensive.
 */

stock void CS_Bombs(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats()) return;
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(client, true)) return;
	
	char query[256];
	int points = 0;
	
	if(StrEqual(event_name, EVENT_BOMB_PLANTED) && CS_GetClientTeam(client) == CSTeam_T)	{
		m_hLastBombPlanter = client;
		
		Session[client].BombsPlanted++;
		Format(query, sizeof(query), "update `%s` set BombsPlanted = BombsPlanted+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		if((points = BombEvent[0].IntValue) > 0)	{
			Session[client].AddPoints(points);
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", Global.playerlist, points, Player[client].SteamID);
			SQL.Query(DBQuery_Callback, query);
			
			CPrintToChat(client, "%s %t", Global.Prefix, "Bomb Planted", Player[client].Name, GetClientPoints(Player[client].SteamID), points);
		}
	}
	
	if(StrEqual(event_name, EVENT_BOMB_DEFUSED) && CS_GetClientTeam(client) == CSTeam_CT)	{
		m_hLastBombDefuser = client;
		
		Session[client].BombsDefused++;
		Format(query, sizeof(query), "update `%s` set BombsDefused = BombsDefused+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		if((points = BombEvent[1].IntValue) > 0)	{
			Session[client].AddPoints(points);
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", Global.playerlist, points, Player[client].SteamID);
			SQL.Query(DBQuery_Callback, query);
			
			CPrintToChat(client, "%s %t", Global.Prefix, "Bomb Defused", Player[client].Name, GetClientPoints(Player[client].SteamID), points);
		}
	}
		
	if(StrEqual(event_name, EVENT_BOMB_EXPLODED) && CS_GetClientTeam(client) == CSTeam_T)	{
		Session[client].BombsExploded++;
		Format(query, sizeof(query), "update `%s` set BombsDefused = BombsDefused+1 where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		
		if((points = BombEvent[2].IntValue) > 0)	{
			Session[client].AddPoints(points);
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", Global.playerlist, points, Player[client].SteamID);
			SQL.Query(DBQuery_Callback, query);
			
			CPrintToChat(client, "%s %t", Global.Prefix, "Bomb Exploded", Player[client].Name, GetClientPoints(Player[client].SteamID), points);
		}
	}
}

/* Hostages */
stock void CS_Hostages(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats())
		return;
	
	int client = GetClientOfUserId(event.GetInt("userid"));
	if(!Tklib_IsValidClient(client, true))
		return;
	
	char query[512];
	int points = 0;
	
	if(StrEqual(event_name, EVENT_HOSTAGE_RESCUED))	{
		Session[client].HostagesRescued++;
		
		if((points = HostageEvent[0].IntValue) > 0)	{	
			CPrintToChat(client, "Hostage Rescued", Player[client].Name, GetClientPoints(Player[client].SteamID), points);
			
			Format(query, sizeof(query), "update `%s` set Points = Points+%i, HostagesRescued = HostagesRescued+1 where SteamID='%s' and ServerID='%i'",
			Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
			SQL.Query(DBQuery_Callback, query);
		}
	}
	
	if(StrEqual(event_name, EVENT_HOSTAGE_KILLED))	{
		Session[client].HostagesRescued++;
		
		if((points = HostageEvent[1].IntValue) > 0)	{
			CPrintToChat(client, "Hostage Killed", Player[client].Name, GetClientPoints(Player[client].SteamID), points);
			
			Format(query, sizeof(query), "update `%s` set Points = Points+%i, HostagesKilled = HostagesKilled+1 where SteamID='%s' and ServerID='%i'",
			Global.playerlist, points, Player[client].SteamID, Cvars.ServerID.IntValue);
			SQL.Query(DBQuery_Callback, query);
		}
	}
}

/* Flashed */
stock void CS_Flashed(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats())
		return;
	
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	if(!Tklib_IsValidClient(victim))
		return;
	
	if(IsFakeClient(victim) && !Cvars.ServerID.IntValue)
		return;
	
	if(!IsFakeClient(victim))	{
		float m_flFlashDuration = GetEntPropFloatEx(victim, Prop_Send, "m_flFlashDuration");
		m_bIsFlashed[victim] = (m_flFlashDuration > 1.0);
		
		CreateTimer(m_flFlashDuration-1.1257525125, Timer_CS_Flashed, victim);
	}
	
	int client;
	switch(Global.Game)	{
		case Game_CSS, Game_CSPromod:
			client = (m_hLastFlashBangGrenade = client) ? client : 0;
		case Game_CSGO, Game_CSCO:
			client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	}
	
	if(!Tklib_IsValidClient(client, true))
		return;
	
	if(IsSameTeam(victim, client) || IsSamePlayers(victim, client))
		return;
	
	XStats_DebugText(false, "//===== CS_Flashed =====//");
	XStats_DebugText(false, "Client: %i (%N)", client, client);
	XStats_DebugText(false, "Victim: %i (%N)", victim, victim);
	XStats_DebugText(false, " ");
	
	Session[client].FlashedOpponents++;
	
	char query[512];
	Format(query, sizeof(query), "update `%s` set FlashedOpponents = FlashedOpponents+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
}

Action Timer_CS_Flashed(Handle timer, int client) { m_bIsFlashed[client] = false; }

stock void Weapon_Fire_CSGO(Event event, const char[] event_name, bool dontBroadcast)	{
	int client = GetClientOfUserId(event.GetInt("userid"));
	
	/* Since both Incendiary and Molotov counts as 'firebomb', we need to get the correct grenade. */
	char[] weapon = new char[64];
	event.GetString(EVENT_STR_WEAPON, weapon, 64); /* You can't use sizeof() on construction character function */
	
	XStats_DebugText(false, "//===== Weapon_Fire_CSGO =====//"
	... "\nClient: %N"
	... "\nWeapon: \%s\"\n"
	, client
	, weapon);
	
	if(StrEqual(weapon, "weapon_incgrenade")) m_hLastFirebombGrenade[client] = CSGO_Grenade_Incendiary;
	if(StrEqual(weapon, "weapon_molotov")) m_hLastFirebombGrenade[client] = CSGO_Grenade_Molotov;
}

/**
 *	At the moment not gonna be super accurate
 *	but will be fixed up later and be more accurate.
 */
public Action CS_OnBuyCommand(int client, const char[] weapon)	{
	if(Tklib_IsValidClient(client, true))	{
		DataPack pack;
		CreateDataTimer(0.25, Timer_OnBuyCommand, pack);
		pack.WriteCell(client);
		pack.WriteString(weapon);
		pack.Reset();
	}
}

stock Action Timer_OnBuyCommand(Handle timer, DataPack pack)	{
	int client = pack.ReadCell();
	char weapon[64];
	pack.ReadString(weapon, sizeof(weapon));
	
	/* If player left */
	if(!IsClientConnected(client))	{
		KillTimer(timer);
		delete pack;
		return Plugin_Handled;
	}
	
	int price = CS_GetPriceFromWeapon(weapon);
	Session[client].MoneySpent = Session[client].MoneySpent;
	
	char query[256];
	Format(query, sizeof(query), "update `%s` set MoneySpent = MoneySpent+%i where SteamID='%i' and ServerID='%i'",
	Global.playerlist, price, Player[client].SteamID, Cvars.ServerID.IntValue);
	
	return Plugin_Handled;
}

stock void OnEntityCreated_CounterStrike(int entity, const char[] classname)	{
	if(!IsValidEntityEx(entity)
	|| entity == -1)
		return; /* In CS:GO, at round start, some entity with index -1 (for some odd reason) is spawned, so this will fix the errors. */
	
	/* Need a short delay so we can get the entity owner. */
	if(StrEqual(classname, "flashbang_projectile")
	|| StrEqual(classname, "hegrenade_projectile")
	|| StrEqual(classname, "smokegrenade_projectile"))	{
		DataPack pack;
		CreateDataTimer(0.01, Timer_OnEntityCreated, pack);
		pack.WriteCell(EntIndexToEntRef(entity));
		pack.WriteString(classname);
		pack.Reset();
	}
}

stock Action Timer_OnEntityCreated(Handle timer, DataPack pack)	{
	int ref = pack.ReadCell();
	char[] classname = new char[96];
	pack.ReadString(classname, 96);
	
	Entity entity = Ent(EntRefToEntIndex(ref));
	
	/* If entity goes invalid. */
	if(!entity.Valid()) {
		KillTimer(timer);
		delete pack;
		return Plugin_Handled;
	}
	
	int client = entity.Owner; /*entity.GetPropEnt(Prop_Send, "m_hThrower");*/
	
	if(StrEqual(classname, "flashbang_projectile")) m_hLastFlashBangGrenade = client;
	if(StrEqual(classname, "hegrenade_projectile")) m_hLastHeGrenade = client;
	if(StrEqual(classname, "smokegrenade_projectile")) m_hLastSmokeGrenade = client;
	
	XStats_DebugText(false, "//===== OnEntityCreated_CounterStrike =====//"
	... "\nClassname \"%s\""
	... "\nEntity index \"%i\""
	... "\nEntity reference \"%i\""
	... "\nThrower \"%i\" \"%d\" (%N)\n"
	, classname
	, entity
	, ref
	, classname, client, client, client);
	
	//XStats_DebugText(false, "OnEntityCreated \nclassname \"%s\" \nentity index %i \nentity reference %i \n", classname, entity, ref);
	return Plugin_Handled;
}