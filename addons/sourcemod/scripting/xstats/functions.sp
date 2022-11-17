stock bool HasStored(int client, char[] str, any ...) {
	char chocolate[128];
	VFormat(chocolate, sizeof(chocolate), str, 3);
	return Player[client].InvCallback.GetStringBool("%i_%s", _, Player[client].AccountID, chocolate);
}

stock int GetStored(int client, char[] str, any ...) {
	char milk[128];
	VFormat(milk, sizeof(milk), str, 3);
	return Player[client].InvCallback.GetStringIndex("%i_%s", _, Player[client].AccountID, chocolate);
}

stock bool SetStored(int client, char[] str, any value, any ...) {
	char cookies[128];
	VFormat(cookies, sizeof(cookies), str, 4);
	Format(cookies, sizeof(cookies), "%i_%s", Player[client].AccountID, cookies);
	
	bool rtrn = false;
	
	switch(value) {
		case true: rtrn = Player[client].InvCallback.SetStringValue(cookies, value);
		case false: rtrn = Player[client].InvCallback.Remove(cookies);
	}
	
	return rtrn;
}

/**
 *	Returns the amount of points a player has.
 *
 *	@param	auth	The players steam authentication id.
 */
stock int GetClientPoints(const char[] auth) {
	int points = 0;
	
	if(SQL != null) {
		SQL.Lock();
		DBResultSet results = SQL.Query2("select Points from `%s` where SteamID='%s' and ServerID='%i'", Global.playerlist, auth, Cvars.ServerID.IntValue);
		points = (results != null && results.FetchRow()) ? results.FetchInt(0) : 0;
		
		delete results;
		SQL.Unlock();
	}
	
	XStats_DebugText(false, "GetClientPoints was fired for \"%s\", returning %i", auth, points);
	return points;
}

/**
 *	Returns the position of the player.
 *
 *	@param	auth	The players steam authentication id.
 */
stock int GetClientPosition(const char[] auth) {
	int position = 0
	, points = 0;
	
	if(SQL != null) {
		SQL.Lock();
		DBResultSet results = SQL.Query2("select Points from `%s` where SteamID='%s' and ServerID='%i'", Global.playerlist, auth, Cvars.ServerID.IntValue);
		while(results != null && results.FetchRow()) {
			points = results.FetchInt(0);
			
			results = SQL.Query2("select count(*) from `%s` where Points >='%i' and ServerID='%i'", Global.playerlist, points, Cvars.ServerID.IntValue);
			while(results.FetchRow()) position = results.FetchInt(0);
		}
		
		delete results;
		SQL.Unlock();
	}
	
	XStats_DebugText(false, "GetClientPosition was fired for \"%s\", returning %i", auth, position);
	return position;
}

/**
 *	Returns the total player count in a database table.
 */
stock int GetTablePlayerCount() {
	int playercount = 0;
	
	if(SQL != null) {
		SQL.Lock();
		DBResultSet results = SQL.Query2("select count(*) from `%s` where ServerID='%i'", Global.playerlist, Cvars.ServerID.IntValue);
		while(results != null && results.FetchRow()) playercount = results.FetchInt(0);
		
		delete results;
		SQL.Unlock();
	}
	
	XStats_DebugText(false, "GetTablePlayerCount was fired, returning %i", playercount);
	return playercount;
}

/**
 *	Returns the amount of playtime in minutes a player has.
 *
 *	@param	auth	The players steam authentication id.
 */
stock int GetClientPlayTime(const char[] auth) {
	int playtime = 0;
	
	if(SQL != null) {
		SQL.Lock();
		DBResultSet results = SQL.Query2("select PlayTime from `%s` where SteamID='%s' and ServerID='%i'", Global.playerlist, auth, Cvars.ServerID.IntValue);
		playtime = (results != null && results.FetchRow()) ? results.FetchInt(0) : 0;
		delete results;
		SQL.Unlock();
	}
	
	XStats_DebugText(false, "GetClientPlayTime was fired for \"%s\", returning %i", auth, playtime);
	return playtime;
}

/**
 *	Clears the players sessions.
 *
 *	@param	client	The users index.
 */
stock void ClearSessions(int client) {
	/* Core */
	Session[client].PlayTime = 0;
	Session[client].Points = 0;
	Session[client].Kills = 0;
	Session[client].Deaths = 0;
	Session[client].Suicides = 0;
	Session[client].Assists = 0;
	Session[client].DamageDone = 0;
	
	/* Generic */
	Session[client].Dominations = 0;
	Session[client].Revenges = 0;
	Session[client].Airshots = 0;
	Session[client].Headshots = 0;
	Session[client].Noscopes = 0;
	Session[client].Collaterals = 0;
	Session[client].MidAirKills = 0;
	Session[client].GrenadeKills = 0;
	
	/* TF2 */
	Session[client].ScoutKills = 0;
	Session[client].SoldierKills = 0;
	Session[client].PyroKills = 0;
	Session[client].DemoKills = 0;
	Session[client].HeavyKills = 0;
	Session[client].EngieKills = 0;
	Session[client].MedicKills = 0;
	Session[client].SniperKills = 0;
	Session[client].SpyKills = 0;
	Session[client].CivilianKills = 0; /* TF2 Classic */
	Session[client].ScoutDeaths = 0;
	Session[client].SoldierDeaths = 0;
	Session[client].PyroDeaths = 0;
	Session[client].DemoDeaths = 0;
	Session[client].HeavyDeaths = 0;
	Session[client].EngieDeaths = 0;
	Session[client].MedicDeaths = 0;
	Session[client].SniperDeaths = 0;
	Session[client].SpyDeaths = 0;
	Session[client].CivilianDeaths = 0; /* TF2 Classic */
	Session[client].Backstabs = 0;
	Session[client].Tauntkills = 0;
	Session[client].Gibs = 0;
	Session[client].Deflects = 0;
	Session[client].Ubercharged = 0;
	Session[client].SandvichesStolen = 0;
	Session[client].Coated = 0;
	Session[client].Extinguished = 0;
	Session[client].Telefrags = 0;
	Session[client].Sentrykills = 0;
	Session[client].MiniSentrykills = 0;
	Session[client].MiniCritkills = 0;
	Session[client].Critkills = 0;
	Session[client].PointsCaptured = 0;
	Session[client].PointsDefended = 0;
	Session[client].FlagsStolen = 0;
	Session[client].FlagsPickedUp = 0;
	Session[client].FlagsCaptured = 0;
	Session[client].FlagsDefended = 0;
	Session[client].FlagsDropped = 0;
	Session[client].PassBallsGotten = 0;
	Session[client].PassBallsScored = 0;
	Session[client].PassBallsDropped = 0;
	Session[client].PassBallsCatched = 0;
	Session[client].PassBallsStolen = 0;
	Session[client].PassBallsBlocked = 0;
	Session[client].BuildingsBuilt = 0;
	Session[client].SentryGunsBuilt = 0;
	Session[client].DispensersBuilt = 0;
	Session[client].MiniSentryGunsBuilt = 0;
	Session[client].TeleporterEntrancesBuilt = 0;
	Session[client].TeleporterExitsBuilt = 0;
	Session[client].SappersPlaced = 0;
	Session[client].TotalBuildingsDestroyed = 0;
	Session[client].BuildingsDestroyed = 0;
	Session[client].SentryGunsDestroyed = 0;
	Session[client].DispensersDestroyed = 0;
	Session[client].MiniSentryGunsDestroyed = 0;
	Session[client].TeleporterEntrancesDestroyed = 0;
	Session[client].TeleporterExitsDestroyed = 0;
	Session[client].SappersDestroyed = 0;
	Session[client].PlayerTeleported = 0;
	Session[client].PlayersTeleported = 0;
	Session[client].StunnedPlayers = 0;
	Session[client].MoonShotStunnedPlayers = 0;
	Session[client].KilledHHH = 0;
	Session[client].KilledMonoculus = 0;
	Session[client].KilledMerasmus = 0;
	Session[client].KilledSkeletonKing = 0;
	Session[client].StunnedMonoculus = 0;
	Session[client].StunnedMerasmus = 0;
	Session[client].MadMilked = 0;
	Session[client].Jarated = 0;
	Session[client].Ignited = 0;
	
	/* TF2 MvM */
	Session[client].TanksDestroyed = 0;
	Session[client].SentryBustersKilled = 0;
	Session[client].BombsResetted = 0;
	
	/* CS:GO */
	Session[client].BlindKills = 0;
	Session[client].SmokeKills = 0;
	Session[client].Wipes = 0;
	Session[client].ChickenKills = 0;
	
	/* Counter-Strike Overall */
	Session[client].MVPs = 0;
	Session[client].BombsPlanted = 0;
	Session[client].BombsDefused = 0;
	Session[client].BombsExploded = 0;
	Session[client].BombKills = 0;
	Session[client].MoneySpent = 0;
	Session[client].FlashedOpponents = 0;
	Session[client].KnifeKills = 0;
	Session[client].HostagesRescued = 0;
	Session[client].HostagesKilled = 0;
}

/**
 *	Returns the Ratio. This desperately needs to be completely recoded with working 1.00 ratio.
 *
 *	@param	count1	The first count to check.
 *	@param	count2	The second count to check.
 */
stock float GetRatio(int count1, int count2) {
	float ratio = 1.00;
	float fcount1 = float(count1);
	float fcount2 = float(count2);
	//float fassists = float(assists);
	
	//fkills += (fassists / 2.0);
	
	XStats_DebugText(false, "\n//===== XStats debug Log: GetRatio =====//");
	XStats_DebugText(false, "count1: %i", count1);
	XStats_DebugText(false, "count2: %i", count2);
	//XStats_DebugText(false, "assists: %i", assists);
	XStats_DebugText(false, "fcount1: %.2f", fcount1);
	//XStats_DebugText(false, "fkills += (fassists / 2.0): %.2f", fkills);
	XStats_DebugText(false, "fcount2: %.2f", fcount2);
	//XStats_DebugText(false, "fassists: %.2f", fassists);
	
	switch(fcount2 == 0.0) {
		case true: {
			fcount2 = 1.0;
			XStats_DebugText(false, "after fcount2 check: %.2f (Because fcount2 were 0.00)", fcount2);
		}
		case false: XStats_DebugText(false, "after fcount2 check: %.2f", fcount2);
	}
	
	ratio = fcount1 / fcount2;
	XStats_DebugText(false, "Ratio: %.2f\n", ratio);
	
	ratio /= 100.0; /* Fix the KDR To be correct. 120.0 -> 1.20 */
	
	if(ratio == 0.00) ratio = 1.00;
	
	XStats_DebugText(false, "GetRatio was fired (count1 %i, count2 %i), returning %.2f", count1, count2, ratio);
	return ratio;
}

/**
 *	Update players last connected time state.
 *
 *	@param	auth	The players steam authentication id.
 */
stock void UpdateLastConnectedState(const char[] auth) {
	if(!SQL) {
		XStats_DebugText(true, "Failed to establish database connection for UpdateLastConnectedState. (Invalid database connection)");
		return;
	}
	
	SQL.Query(DBQuery_Callback, "update `%s` set LastConnected='%i' where SteamID='%s' and ServerID='%i'", _, _, Global.playerlist, GetTime(), auth, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, "update `%s` set LastConnectedServerID='%i' where SteamID='%s'", _, _, Global.playerlist, Cvars.ServerID.IntValue, auth);
}

/**
 *	Remove players from the database table if found too old.
 *
 *	@param	days	If the player has not been in this many days, the player gets removed.
 */
stock void RemoveOldConnectedPlayers(int days = 30) {
	int time = GetTime() - (days * 86400);
	char query[512];
	Format(query, sizeof(query), "select SteamID from `%s` where LastConnected < '%i' and ServerID='%i'",
	Global.playerlist, time, Cvars.ServerID.IntValue);
	
	DataPack pack = new DataPack();
	pack.WriteCell(time);
	pack.WriteCell(days);
	SQL.Query(DBQuery_RemoveOldPlayers_1, query, pack);
}

stock void DBQuery_RemoveOldPlayers_1(Database database, DBResultSet results, const char[] error, DataPack pack)	{
	pack.Reset();
	int time = pack.ReadCell();
	int days = pack.ReadCell();
	delete pack;
	
	if(!results) XStats_DebugText(true, "Deleting old players failed! (%s)", error);
	
	int count = 0;
	while(results.FetchRow()) {
		count++;
		char auth[64];
		results.FetchString(0, auth, sizeof(auth));
		XStats_DebugText(false, "[%i] Deleted %s from database after %i days of no activity", count, auth, days);
	}
	
	/* Avoid spamming this in the while loop */
	if(count > 0) {
		char query[150];
		Format(query, sizeof(query), "delete from `%s` where LastLastConnectedServerID='%i'",
		Global.playerlist, time, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_RemoveOldPlayers_2, query);
	}
}

stock void DBQuery_RemoveOldPlayers_2(Database database, DBResultSet results, const char[] error, any data)	{
	if(!results) XStats_DebugText(true, "Deleting old players failed! (%s)", error);
}

//====================//
// Database stuff.
//====================//

/**
 *	Callback query for death events.
 */
stock void DBQuery_Callback(DatabaseEx database, DBResultSet results, const char[] error) {
	if(!results) XStats_DebugText(true, "Updating table \"%s\" failed! (%s)", Global.playerlist, error);
}

/**
 *	Callback query for kill log.
 */
stock void DBQuery_Kill_Log(DatabaseEx database, DBResultSet results, const char[] error) {
	if(!results) XStats_DebugText(true, "Adding kill log event to \"%s\" failed! (%s)", Global.kill_log, error);
}

/**
 *	Callback query for playtimer.
 */
stock void DBQuery_IntervalPlayTimer(DatabaseEx database, DBResultSet results, const char[] error, int client) {
	if(!IsClientConnected(client)) return;
	if(!results) XStats_DebugText(true, "Updating playtime by 1 minute for client index %i to \"%s\" failed! (%s)", client, Global.playerlist, error);
}

/**
 *	Callback query for database query insertions.
 */
stock void DBQuery_DB(Database database, DBResultSet results, const char[] error, int id) {
	if(!results) XStats_DebugText(true, "Creating query for database table id %i failed! (%s)", id, error);
}

/**
 *	Callback for the panel.
 */
stock void PanelCallback(MenuEx menu, MenuAction action, int client, int selection) {}

/**
 *	Check active players.
 */
stock void CheckActivePlayers()	{
	int needed = Cvars.MinimumPlayers.IntValue;
	int players = GetClientCountEx(!Cvars.AllowBots.BoolValue);
	XStats_DebugText(false, "CheckActivePlayers: %i players out of required %i", players, needed);
	
	switch(Global.RankActive) {
		case true: {
			if(players < needed) {
				Global.RankActive = false;
				
				CPrintToChatAll("%s %t", Global.Prefix, "Not Enough Players", players, needed);
				XStats_DebugText(false, "Not enough players (%i out of %i), disabling..", players, needed);
			}
		}
		case false: {
			if(players >= needed && Global.RoundActive) {
				Global.RankActive = true;
				CPrintToChatAll("%s %t", Global.Prefix, "Enough Players", players, needed);
				XStats_DebugText(false, "Enough players (%i out of %i), enabling..", players, needed);
			}
		}
	}
}

/**
 *	Make sure the stats is properly configured.
 */
stock bool IsValidStats() { return !(!Cvars.PluginActive.BoolValue || Cvars.ServerID.IntValue < 1 || !Global.RoundActive || !Global.RankActive || Global.WarmupActive && !Cvars.AllowWarmup.BoolValue); }

/**
 *	Make sure the event wasn't abused.
 *
 *	@param	client	The users index to read. (0 disables reading the client)
 */
stock bool IsValidAbuse(int client=0) {
	bool abuse = false;
	
	if(Cvars.AntiAbuse.BoolValue) {
		ConVar cvar = null;
		if((cvar = FindConVar("sv_cheats")) != null && cvar.BoolValue) abuse = true;
		delete cvar;
		if(client > 0) { if(IsClientNoclipping(client)) abuse = true; }
	}
	
	return	abuse;
}

/**
 *	Returns if the client is inside a smoke.
 *	Used as alternative for CS:S since 'thrusmoke' is only available in CS:GO.
 *
 *	@param	client	The users index.
 */
stock bool CS_IsClientInsideSmoke(int client) {
	Entity ent = Entity_Empty;
	while((ent = Entity.FindByClassname("env_particlesmokegrenade")) != Entity_Invalid) if(ent.GetDistance(client) <= 3.0) return true;
	return false;
}

/* Forwards */

/**
 *	Prepare Global.Prefix forward.
 *
 *	@noreturn
 */
stock void PreparePrefixUpdatedForward() {
	XStats_DebugText(false, "Preparing prefix forward..");
	Call_StartForward(Forward.Prefix);
	Call_PushString(Global.Prefix);
	Call_Finish();
}

/**
 *	Prepare OnDeath forward.
 *
 *	@param	client		The players user index.
 *	@param	victim		The killed users index.
 *	@param	assist		The assisting users index.
 *	@param	weapon		The weapon string to forward.
 *	@param	defindex	The weapon definition index. (0 if invalid for the game)
 *
 *	@noreturn
 */
stock void PrepareOnDeathForward(int client, int victim, int assist, const char[] weapon, int defindex) {
	XStats_DebugText(false, "Preparing OnDeathEvent forward..");
	Call_StartForward(Forward.Death);
	Call_PushCell(client);
	Call_PushCell(victim);
	Call_PushCell(assist);
	Call_PushString(weapon);
	Call_PushCell(defindex);
	Call_Finish();
}

/**
 *	Prepare OnSuicide forward.
 *
 *	@param	client		The players user index.
 *
 *	@noreturn
 */
stock void PrepareOnSuicideForward(int client) {
	XStats_DebugText(false, "Preparing OnSuicideEvent forward..");
	Call_StartForward(Forward.Suicide);
	Call_PushCell(client);
	Call_Finish();
}

/**
 *	Prepare flag event forward.
 *
 *	@param	client		The players user index.
 *	@param	carrier		The carriers user index.
 *	@param	flag		The flag event type.
 *	@param	home		The flag was stolen.
 *
 *	@noreturn
 */
stock void PrepareTF2FlagEventForward(int client, int carrier, TFFlag flag, bool home) {
	XStats_DebugText(false, "Preparing TF2_OnFlagEvent forward..");
	Call_StartForward(Forward.TF2_FlagEvent);
	Call_PushCell(client);
	Call_PushCell(carrier);
	Call_PushCell(flag);
	Call_PushCell(home);
	Call_Finish();
}

/* Stuff */
 
/**
 *	Assisted kill event.
 *
 *	@param	assist	Assisters user index.
 *	@param	client	The client that was assisted.
 *	@param	victim	The victim that was killed.
 *
 *	@return	Returns if the assister is valid.
 */
stock bool AssistedKill(int assist, int client, int victim) {
	if(!Tklib_IsValidClient(assist, true)) return false;
	
	char query[256];
	Session[assist].Assists++;
	Format(query, sizeof(query), "update `%s` set Assists = Assists+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, Player[assist].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
	XStats_DebugText(false, "Updating assist count for %s", Player[assist].Playername);
	
	if(Cvars.AssistKill.IntValue > 0) {
		Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s' and ServerID='%i'",
		Global.playerlist, Cvars.AssistKill.IntValue, Player[assist].SteamID, Cvars.ServerID.IntValue);
		SQL.Query(DBQuery_Callback, query);
		XStats_DebugText(false, "Updating points for %s due to assisting a kill", Player[victim].Playername);
		
		Player[assist].Points = GetClientPoints(Player[assist].SteamID);
		CPrintToChat(assist, "%s %t",
		Global.Prefix, "Assist Kill Event", Player[assist].Name, Player[assist].Points, Cvars.AssistKill.IntValue, Player[client].Name, Player[victim].Name);
	}
	
	return true;
}

/**
 *	Victim died.
 *
 *	@param	victim	The victims user index.
 *
 *	@noreturn.
 */
stock void VictimDied(int victim) {
	if(!Tklib_IsValidClient(victim, true)) return;
	
	SQL.QueryEx(DBQuery_Callback, "update `%s` set Deaths = Deaths+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, Player[victim].SteamID, Cvars.ServerID.IntValue);
	XStats_DebugText(false, "Updating death count for %s", Player[victim].Playername);
	
	int points;
	switch(Global.Game) {
		case Game_TF2, Game_TF2C, Game_TF2V, Game_TF2B, Game_TF2OP: {
			TFClassType class = TF2_GetPlayerClass(victim);
			if(class < TFClass_Scout) return;
			if((points = TF2_DeathClass[class].IntValue) < 1) return;
		}
		default: if((points = Cvars.Death.IntValue) < 1) return;
	}
		
	int victim_points = GetClientPoints(Player[victim].SteamID);
	Session[victim].RemovePoints(points);
	CPrintToChat(victim, "%s %t", Global.Prefix, "Death Kill Event", Player[victim].Name, victim_points, points);
	
	SQL.QueryEx(DBQuery_Callback, "update `%s` set Points = Points-%i where SteamID='%s' and ServerID='%i'",
	Global.playerlist, points, Player[victim].SteamID, Cvars.ServerID.IntValue);
	XStats_DebugText(false, "Updating points for %s due to dying", Player[victim].Playername);
}

/* When round starts */
stock void RoundStarted() {
	Global.RoundActive = true;
	
	switch(Global.Game) {
		case Game_CSGO, Game_CSCO: Global.WarmupActive = CS_IsWarmupRound();
		case Game_TF2, Game_TF2C, Game_TF2B, Game_TF2V, Game_TF2OP: Global.WarmupActive = TF2_IsWaitingForPlayers();
	}
	
	switch(Global.WarmupActive) {
		case true: XStats_DebugText(false, "Warmup Round Started");
		case false: XStats_DebugText(false, "Round Started");
	}
	
	if(Global.RoundActive && Global.WarmupActive) {
		CPrintToChatAll("%s %t", Global.Prefix, "Round Start Warmup");
		return;
	}
	
	int needed = Cvars.MinimumPlayers.IntValue;
	int players = GetClientCountEx(!Cvars.ServerID.IntValue);
	
	if(Cvars.DisableAfterWin.BoolValue) {
		if(needed <= players) {
			Global.RankActive = true;
			CPrintToChatAll("%s %t", Global.Prefix, "Round Start");
		}
	}
}

/* When round ends */
stock void RoundEnded()	{
	Global.RoundActive = false;
	
	switch(Global.Game)	{
		case Game_CSGO, Game_CSCO: Global.WarmupActive = CS_IsWarmupRound();
		case Game_TF2, Game_TF2C, Game_TF2V, Game_TF2OP: Global.WarmupActive = TF2_IsWaitingForPlayers();
	}
			
	switch(Global.WarmupActive)	{
		case true: XStats_DebugText(false, "Warmup Round Ended");
		case false: XStats_DebugText(false, "Round Ended");
	}
	
	if(!Global.WarmupActive)	{
		if(Cvars.DisableAfterWin.BoolValue)	{
			Global.RankActive = false;
			CPrintToChatAll("%s %t", Global.Prefix, "Round End");
		}
	}
	
	if(Cvars.RemoveOldPlayers.IntValue >= 1) RemoveOldConnectedPlayers(Cvars.RemoveOldPlayers.IntValue);
	
	ResetAssister();
}

stock Action CheckPlayersPluginStart(Handle timer) {
	if(!SQL) return Plugin_Handled;
	
	XStats_DebugText(false, "//== XStats Debug Log: CheckPlayersPluginStart ==//\n");
	
	//SQL.Lock();
	//DBResultSet results;
	
	TargetLoopEx(client) {
		/* Bots needs a name too, right? */
		if(Tklib_IsValidClient(client, false, false, false)) {
			GetClientNameEx(client, Player[client].Playername, sizeof(Player[].Playername));
			GetClientNameTeamString(client, Player[client].Name, sizeof(Player[].Name));
		}
		
		//Only gather the steamid from the players
		if(!Tklib_IsValidClient(client, true, false, false)) continue;
		
		GetClientAuth(client, Player[client].SteamID, sizeof(Player[].SteamID));
		GetClientIP(client, Player[client].IP, sizeof(Player[].IP));
		GetClientNameEx(client, Player[client].Playername, sizeof(Player[].Playername));
		GetClientNameTeamString(client, Player[client].Name, sizeof(Player[].Name));
		if(!GeoipCountry(Player[client].IP, Player[client].Country, sizeof(Player[].Country))) Format(Player[client].Country, sizeof(Player[].Country), "Unknown Country");
		
		SQL.QueryEx2(DBQuery_CheckPlayer, "select * from `%s` where SteamID = '%s' and ServerID='%i'",
		client, Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	}
	
	return Plugin_Handled;
}

void DBQuery_CheckPlayer(DatabaseEx database, DBResultSet results, const char[] error, int client) {
	switch(results && results.RowCount != 0) {
		// Player exists
		case true: {
			XStats_DebugText(false, "Found player %s in \"%s\" at ServerID %i, initializing forwards OnClientPutInServer..",
			Player[client].Playername, Global.playerlist, Cvars.ServerID.IntValue);
			Player[client].Points = GetClientPoints(Player[client].SteamID);
			Player[client].Position = GetClientPosition(Player[client].SteamID);
			
			OnClientPutInServer(client);
		}
		
		// Player wasn't found.
		case false: {
			char temp_playername[64];
			temp_playername = Player[client].Playername;
			TrimString(temp_playername);
			database.Escape(temp_playername, temp_playername, sizeof(temp_playername));
			
			database.QueryEx2(DBQuery_CheckPlayer_Callback, "insert into `%s` (SteamID, Playername, IP, ServerID) values ('%s', '%s', '%s', '%i')",
			client, Global.playerlist, Player[client].SteamID, temp_playername, Player[client].IP, Cvars.ServerID.IntValue);
		}
	}
}

void DBQuery_CheckPlayer_Callback(DatabaseEx database, DBResultSet results, const char[] error, int client) {
	XStats_DebugText(false, "Failed to find player %s on playerlist table, inserting new query directly onto database.", Player[client].Playername);
	if(results) OnClientPutInServer(client);
}

/**
 *	Prepare the kill message.
 *
 *	@param	client	The client who killed.
 *	@param	victim	The victim who died.
 *	@param	points	The points the client was given
 */
stock void PrepareKillMessage(int client, int victim, int points) {
	Player[client].Points = GetClientPoints(Player[client].SteamID);
	
	char buffer[196];
	
	/* Lë ol' messy code but has to be it. */
	
	/* Deflect kill */
	if(KillMsg[client].DeflectKill)
	{
		/* Airshot deflect kill */
		if(KillMsg[client].AirshotKill)
		{
			switch(KillMsg[client].HeadshotKill)
			{
				/* Headshot airshot deflect kill */
				case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[6], Kill_Type[7]);
				/* Airshot deflect kill */
				case false: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[6], Kill_Type[7]);
			}
		}
		else
		{
			switch(KillMsg[client].HeadshotKill)
			{
				/* Headshot deflect kill */
				case true: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[7]);
				/* Deflect kill */
				case false: Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[7]);
			}
		}
	}
	/* Collateral */
	else if(KillMsg[client].CollateralKill)
	{
		switch(KillMsg[client].HeadshotKill)
		{
			/* Headshot collateral kill */
			case true: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[10]);
			/* Colllateral kill */
			case false: Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[10]);
		}
	}
	/* Airshot kill */
	else if(KillMsg[client].AirshotKill)
	{
		/* Mid air airshot kill */
		if(KillMsg[client].MidAirKill)
		{
			switch(KillMsg[client].HeadshotKill)
			{
				/* Mid air airshot headshot kill */
				case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[6], Kill_Type[0]);
				/* Mid air airshot kill */
				case false: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[6], Kill_Type[0]);
			}
		}
		/* Airshot kill */
		else
		{
			switch(KillMsg[client].HeadshotKill)
			{
				/* Airshot headshot kill */
				case true: Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[3], Kill_Type[6]);
				/* Airshot kill */
				case false: Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[6]);
			}
		}
	}
	/* Backstab kill */
	else if(KillMsg[client].BackstabKill)
	{
		switch(KillMsg[client].MidAirKill)
		{
			/* Mid air backstab kill */
			case true: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[5], Kill_Type[0]);
			case false: Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[5]);
		}
	}
	/* Noscope kill */
	else if(KillMsg[client].NoscopeKill)
	{
		/* Noscope headshot kill */
		if(KillMsg[client].HeadshotKill)
		{
			/* Noscope headshot kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				/* Noscope headshot through smoke whilst blinded */
				if(KillMsg[client].BlindedKill)
				{
					switch(KillMsg[client].MidAirKill)
					{
						/* Mid air noscope headshot kill through smoke whilst blinded */
						case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default} %t{default}", Kill_Type[2], Kill_Type[1], Kill_Type[13], Kill_Type[0]);
						/* Noscope headshot through smoke whilst blinded */
						case false: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[2], Kill_Type[1], Kill_Type[13]);
					}
				}
				/* Noscope headshot kill through smoke */
				else
				{
					switch(KillMsg[client].MidAirKill)
					{
						/* Mid air noscope headshot kill through smoke */
						case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[2], Kill_Type[1], Kill_Type[0]);
						/* Noscope headshot kill through smoke */
						case false: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[2], Kill_Type[1]);
					}
				}
			}
			/* Noscope headshot kill */
			else
			{
				switch(KillMsg[client].MidAirKill)
				{
					/* Mid air noscope headshot */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[2], Kill_Type[0]);
					/* Noscope headshot kill */
					case false: Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[2]);
				}

			}
		}
		/* Mid air noscope kill */
		else if(KillMsg[client].MidAirKill)
		{
			/* Mid air noscope kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Mid air noscope kill through smoke whilst blinded */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default} %t{default}", Kill_Type[2], Kill_Type[1], Kill_Type[13], Kill_Type[0]);
					/* Mid air noscope kill through smoke */
					case false: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[4], Kill_Type[1], Kill_Type[0]);
				}
			}
			/* Mid air headshot kill */
			else
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Mid air noscope headshot kill while blinded */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[2], Kill_Type[13], Kill_Type[0]);
					/* Mid air noscope headshot kill */
					case false: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[2], Kill_Type[0]);
				}
			}
		}
		/* Noscope kill */
		else
		{
			/* Noscope kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Noscope kill through smoke while blinded */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[4], Kill_Type[1], Kill_Type[13]);
					/* Noscope kill through smoke */
					case false: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[4], Kill_Type[1]);
				}
			}
			/* Noscope kill */
			else
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Noscope kill whilst blinded */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[4], Kill_Type[13]);
					/* Noscope kill */
					case false: Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[4]);
				}
			}
		}
	}
	/* Headshot kill */
	else if(KillMsg[client].HeadshotKill)
	{
		/* Headshot kill through smoke */
		if(KillMsg[client].SmokeKill)
		{
			/* Headshot through smoke whilst blinded */
			if(KillMsg[client].BlindedKill)
			{
				switch(KillMsg[client].MidAirKill)
				{
					/* Mid air headshot kill through smoke whilst blinded */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[13], Kill_Type[0]);
					/* Headshot through smoke whilst blinded */
					case false: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[13]);
				}
			}
			/* Headshot kill through smoke */
			else
			{
				switch(KillMsg[client].MidAirKill)
				{
					/* Mid air headshot kill through smoke */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[0]);
					/* Headshot kill through smoke */
					case false: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[1]);
				}
			}
		}
		/* Mid air headshot kill */
		else if(KillMsg[client].MidAirKill)
		{
			/* Mid air headshot kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Mid air headshot kill through smoke whilst blinded */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[13], Kill_Type[0]);
					/* Mid air headshot kill through smoke */
					case false: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[0]);
				}
			}
			/* Mid air headshot kill */
			else
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Mid air eadshot kill while blinded */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[13], Kill_Type[0]);
					/* Mid air headshot kill */
					case false: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[0]);
				}
			}
		}
		/* Headshot kill */
		else
		{
			/* Headshot kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Headshot kill through smoke while blinded */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[13]);
					/* Headshot kill through smoke */
					case false: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[1]);
				}
			}
			/* Headshot kill */
			else
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Headshot kill whilst blinded */
					case true: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[13]);
					/* Headshot kill */
					case false: Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[3]);
				}
			}
		}
	}
	/* Telefrag */
	else if(KillMsg[client].TeleFragKill)
	{
		Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[8]);
	}
	/* Taunt Kill */
	else if(KillMsg[client].TauntKill)
	{
		Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[9]);
	}
	/* Grenade Frag */
	else if(KillMsg[client].GrenadeKill)
	{
		Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[11]);
	}
	/* Bomb Kill */
	else if(KillMsg[client].BombKill)
	{
		Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[12]);
	}
	/* Blinded Kill */
	else if(KillMsg[client].BlindedKill)
	{
		switch(KillMsg[client].MidAirKill)
		{
			/* Mid air blinded kill */
			case true: Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[13], Kill_Type[0]);
			/* Blinded kill */
			case false: Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[13]);
		}
	}
	/* Mid air kill */
	else if(KillMsg[client].MidAirKill)
	{
		Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[0]);
	}
	
	switch(IsValidString(buffer)) {
		case true: CPrintToChat(client, "%s %t", Global.Prefix, "Special Kill Event", Player[client].Name, Player[client].Points, points, Player[victim].Name, buffer);
		case false: CPrintToChat(client, "%s %t", Global.Prefix, "Default Kill Event", Player[client].Name, Player[client].Points, points, Player[victim].Name);
	}
}

/**
 *	Debugs to server console and logs to a file.
 *
 *	@param	text	The text to write.
 *	@param	...		Additional parameters.
 *
 *	@noreturn
 */
stock void XStats_DebugText(bool FailState, const char[] text, any ...)	{
	if(!Cvars.Debug.BoolValue) return;
	
	char format[8192];
	VFormat(format, sizeof(format), text, 3);
	
	char path[64];
	BuildPath(Path_SM, path, sizeof(path), "logs/xstats_debug.log.txt");
	if(!FileExists(path)) delete OpenFile(path, "a+");
	
	LogToFileEx(path, format);
	
	if(FailState) XStats_SetFailState("%s", format);
}

/**
 *	Updates a table on the playerlist via threaded database connection.
 *
 *	@param	table		The table to update.
 *	@param	client		The user to target.
 *	@param	increment	If true, it will increment. Decrement if false.
 *
 *	@error	If the user is invalid, nothing happens.
 *
 *	@noreturn
 */
stock void XStats_UpdateTable(const char[] table, int client, bool increment=true) {
	if(!Tklib_IsValidClient(client, true)) return; /* Make sure to safely proceed. */
	
	char query[512], Increment[][] = {"-","+"};
	Format(query, sizeof(query), "alter table %s update '%s' = '%s' %s 1 where SteamID = '%s' and ServerID = '%i'",
	Global.playerlist, table, table, Increment[increment], Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_Callback, query);
}

/* Sends a message to all that XStats has crashed just before crashing the plugin. */
stock void XStats_SetFailState(const char[] reason, any ...) {
	TargetLoop(client) {
		if(!Tklib_IsValidClient(client, true)) continue;
		
		switch(Global.Game)	{
			case Game_CSGO, Game_CSCO, Game_L4D1, Game_L4D2: CPrintToChat(client, "{orange}XStats ({lightgreen}%s{orange}) has {lightred}Crashed.", Version);
			default: CPrintToChat(client, "{orange}XStats ({lightgreen}%s{orange}) has {red}Crashed.", Version);
		}
	}
	
	char format[256];
	VFormat(format, sizeof(format), reason, 2);
	SetFailState("[XStats] : %s", format);
}

/* Update the total damage done. */
stock void UpdateDamage(int client)	{
	SQL.Query(DBQuery_UpdateDamage, "select DamageDone from `%s` where SteamID='%s' and ServerID='%i'", client, DBPrio_Low,
	Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
}

void DBQuery_UpdateDamage(Database database, DBResultSet results, const char[] error, int client) {
	if(results != null && results.FetchRow()) {
		/* Low priority to lower chances of lag spikes */
		SQL.Query(DBQuery_Callback, "alter table `%s` update DamageDone = DamageDone + %i where SteamID='%s' and ServerID='%i'", _, DBPrio_Low,
		Global.playerlist, Session[client].DamageDone, Player[client].SteamID, Cvars.ServerID.IntValue); 
	}
}