/* Prepare forwards */
stock void PrepareForwards() {
	Forward.Prefix = new GlobalForward("XStats_OnPrefixUpdated",
		ET_Event,
		Param_String);
	Forward.Death = new GlobalForward("XStats_OnDeathEvent",
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell,
		Param_String,
		Param_Cell);
	Forward.Suicide = new GlobalForward("XStats_OnSuicideEvent",
		ET_Ignore,
		Param_Cell);
	Forward.GetStats = new PrivateForward(
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell);
	Forward.TF2_FlagEvent = new GlobalForward("XStats_TF2_OnFlagEvent",
		ET_Ignore,
		Param_Cell,
		Param_Cell,
		Param_Cell,
		Param_Cell);
}

//OnClientConnect() could be used..
public void OnClientAuthorized(int client, const char[] auth) {
	GetClientNameEx(client, Player[client].Playername, sizeof(Player[].Playername));
	GetClientNameTeamString(client, Player[client].Name, sizeof(Player[].Name));
	
	if(StrEqual(auth, "bot", false)) return;
	if(!Tklib_IsValidClient(client, _, _, false)) return;	
	
	GetClientIP(client, Player[client].IP, sizeof(Player[].IP));
	Format(Player[client].SteamID, sizeof(Player[].SteamID), auth);
	if(!GeoipCountry(Player[client].IP, Player[client].Country, sizeof(Player[].Country))) Player[client].Country = "unknown country";
	
	SQL.QueryEx2(DBQuery_OnClientAuthorized, "select * from `%s` where SteamID = '%s'", client, Global.playerlist, auth);
}

void DBQuery_OnClientAuthorized(DatabaseEx db, DBResultSet r, const char[] error, int client) {
	if(!db) {
		XStats_DebugText(false, "Tried retrieving player table but database connection is invalid!", error);
		return;
	}
	
	switch(r != null && r.RowCount != 0) {
		// Player was found
		case true: {
			db.QueryEx2(DBQuery_OnClientAuthorized_Callback, "update `%s` set IPAddress = '%s' where SteamID='%s' and ServerID='%i'"
			, true
			, Global.playerlist
			, Player[client].IP
			, Player[client].SteamID
			, Cvars.ServerID.IntValue);
			
			// Avoid showing ip due to privacy
			XStats_DebugText(false, "Updating table \"%s\"\nSteamID \"%s\" (ServerID %i)",
			Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		}
		// Player wasn't found, adding..
		case false: {
			db.QueryEx2(DBQuery_OnClientAuthorized_Callback, "insert into `%s` (IPAddress, SteamID, ServerID) values ('%s', '%s', '%i')"
			, false
			, Global.playerlist
			, Player[client].IP
			, Player[client].SteamID
			, Cvars.ServerID.IntValue);
			
			XStats_DebugText(false, "Inserting into table \"%s\" \nSteamID \"%s\" (ServerID %i)",
			Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		}
	}
}

void DBQuery_OnClientAuthorized_Callback(DatabaseEx db, DBResultSet r, const char[] error, bool u) {
	char T[][] = {"Update","Inserting"},I[][] = {"on","into"};
	if(!r) XStats_DebugText(true, "[XStats:OnClientAuthorized] %s player table %s \"%s\" failed! (%s)", T[u], I[u], Global.playerlist, error);
}

public void OnClientPutInServer(int client) {
	if(!Cvars.PluginActive.BoolValue) return;
	if(!Tklib_IsValidClient(client, true, _, false)) return;
	
	delete Player[client].InvCallback;
	Player[client].InvCallback = new StringMapEx();
	
	/* Session */
	ClearSessions(client);
	
	/* Experimental Assister */
	SDKHook(client, SDKHook_OnTakeDamage, Assister_OnTakeDamage);
	//TargetLoop(i) PlayerDamaged[i][client] = 0;
	
	/* Check active players */
	CheckActivePlayers();
	
	UpdateLastConnectedState(Player[client].SteamID);
	
	int list[2];
	GetClientPosition(Player[client].SteamID, list);
	Player[client].Position = list[0];
	Player[client].Points = list[1];
	Player[client].UserID = GetClientUserId(client);
	Player[client].AccountID = GetSteamAccountID(client);
	
	CPrintToChatAll("%s %t", Global.Prefix, "Player Connected", Player[client].Name, Player[client].Position, Player[client].Points, Player[client].Country);
	XStats_DebugText(false, "%s (Pos #%i, %i points) has connected from %s",
	Player[client].Playername, Player[client].Position, Player[client].Points, Player[client].Country);
	
	if(Player[client].Position <= 10 && !StrEqual(Sound[0].path, "")) EmitSoundToAll(Sound[0].path);
	else if(!StrEqual(Sound[1].path, "")) EmitSoundToAll(Sound[1].path);
	
	CreateTimer(60.0, IntervalPlayTimer, client, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	
	/* Safety callback if the steamid weren't acquired. (for some reason) */
	if(StrEqual(Player[client].SteamID, "")) GetClientAuth(client, Player[client].SteamID, sizeof(Player[].SteamID));
}

Action IntervalPlayTimer(Handle timer, int client) {
	/* Incase the player disconnected or plugin is disabled. */
	if(!Cvars.PluginActive.BoolValue || !IsClientConnected(client))	{
		KillTimer(timer);
		return Plugin_Handled;
	}
	
	XStats_DebugText(false, "//===== XStats Debug Log: Updating players total ingame minutes =====//");
	
	if(!SQL) {
		XStats_DebugText(false, "Tried updating player ingame total for %s time but database is invalid (Is the database actually connected?), ignoring..", Player[client].Playername);
		return Plugin_Handled;
	}
	
	Session[client].PlayTime++;
	char query[256];
	Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where SteamID='%s' and ServerID='%i'",
	Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	SQL.Query(DBQuery_IntervalPlayTimer, query, client);
	XStats_DebugText(false, "Updating playtime by adding additional minute for %s [%i Points]", Player[client].Playername, Player[client].Points);
	return Plugin_Handled;
}

public void OnClientDisconnect(int client) {	
	if(!Tklib_IsValidClient(client, true)) return;	
	delete Player[client].InvCallback;
	UpdateDamage(client);
}

public void OnMapStart() {
	if(!Cvars.PluginActive.BoolValue) return;
	
	/* If database lost connection or plugin was late loaded */
	PrepareDatabase(); /* Database */
	
	GetCurrentMap(Global.CurrentMap, sizeof(Global.CurrentMap));	
	CreateTimer(60.0, MapLogTimer, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	XStats_DebugText(false, "//===== XStats Debug Log: Map Log =====//" ... "\nCreating a minute long repeating timer for map \"%s\"\n", Global.CurrentMap);
}

Action MapLogTimer(Handle timer) {
	if(!Cvars.PluginActive.BoolValue) {
		KillTimer(timer);
		return Plugin_Handled;
	}
	
	if(!SQL) {
		XStats_DebugText(false, "Tried updating map statistics but database is invalid (Is the database actually connected?), ignoring..");
		return Plugin_Handled;
	}
	
	/* Check if map exists in database table */
	char query[256];
	Format(query, sizeof(query), "select '%s' from `%s`", Global.CurrentMap, Global.maps_log);
	SQL.Query(DBQuery_MapLog_1, query);
	
	XStats_DebugText(false, "//===== XStats Debug Log: Map Log =====//" ... "\nChecking if map \"%s\" exists on database table \"%s\"\n", Global.CurrentMap, Global.maps_log);
	return Plugin_Handled;
}

void DBQuery_MapLog_1(Database database, DBResultSet results, const char[] error, any data) {		
	char query[512];
	
	switch(results != null && results.FetchRow()) {
		/* Map was found, lets update it */
		case true: {
			Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where MapName='%s' and ServerID='%i'",
			Global.maps_log, Global.CurrentMap, Cvars.ServerID.IntValue);
			SQL.Query(DBQuery_MapLog_2, query);
			XStats_DebugText(false, "Map was found, updating the playtime for \"%s\" by adding additional minute on database table \"%s\"\n", Global.CurrentMap, Global.maps_log);
		}
		/* Map was not found, lets add it */
		case false: {
			Format(query, sizeof(query), "insert into `%s` (MapName) values ('%s')", Global.maps_log, Global.CurrentMap);
			SQL.Query(DBQuery_MapLog_2, query);
			XStats_DebugText(false, "Map \"%s\" not found on database, inserting it..\n", Global.CurrentMap);
			
			Format(query, sizeof(query), "update `%s` set PlayTime = PlayTime+1 where MapName='%s' and ServerID='%i'",
			Global.maps_log, Global.CurrentMap, Cvars.ServerID.IntValue);
			SQL.Query(DBQuery_MapLog_2, query);
			XStats_DebugText(false, "Updating the playtime on the added map by adding additional minute\n");
		}
	}
}

void DBQuery_MapLog_2(Database database, DBResultSet results, const char[] error, any data) {
	if(results == null) XStats_DebugText(true, "Map Log Updater failed! (%s)", error);
}

public void OnEntityCreated(int entity, const char[] classname) { OnEntityCreated_CounterStrike(entity, classname); }
public void OnConfigsExecuted() { CheckActivePlayers(); } /* Check active players */
public void OnPluginEnd() { XStats_DebugText(false, "Ending.."); }