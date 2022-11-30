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
	
	SQL.QueryEx2(DBQuery_OnClientAuthorized, "select * from `%s` where SteamID = '%s' and ServerID = %i", client, Global.playerlist, auth, Cvars.ServerID.IntValue);
	
	SQL.QueryEx2(DBQuery_OnClientAuthorized_2, "select * from `%s` where SteamID = '%s' and ServerID = %i", client, Global.weapons, auth, Cvars.ServerID.IntValue);
}

void DBQuery_OnClientAuthorized(DatabaseEx db, DBResultSet r, const char[] error, int client) {
	if(!db) {
		XStats_DebugText(false, "[XStats::OnClientAuthorized()] Tried retrieving player table but database connection is invalid!", error);
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
			XStats_DebugText(false, "[XStats::OnClientAuthorized()] Updating table %s (SteamID '%s', ServerID %i)",
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
			
			XStats_DebugText(false, "[XStats::OnClientAuthorized()] Inserting into playerlist table %s (SteamID '%s', ServerID %i)",
			Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
		}
	}
}

void DBQuery_OnClientAuthorized_Callback(DatabaseEx db, DBResultSet r, const char[] error, bool u) {
	char T[][] = {"Update","Inserting"},I[][] = {"on","into"};
	if(!r) XStats_DebugText(true, "[XStats::OnClientAuthorized()] %s playerlist table %s \"%s\" failed! (%s)", T[u], I[u], Global.playerlist, error);
}

void DBQuery_OnClientAuthorized_2(DatabaseEx db, DBResultSet r, const char[] error, int client) {
	if(!db) {
		XStats_DebugText(false, "[XStats::OnClientAuthorized()] Tried retrieving weapons table but database connection is invalid!", error);
		return;
	}
	
	if(!r) {
		// Player was found
		db.QueryEx(DBQuery_OnClientAuthorized_2_Callback, "insert into `%s` (SteamID, ServerID) values ('%s', '%i')"
		, Global.weapons
		, Player[client].SteamID
		, Cvars.ServerID.IntValue);
		
		XStats_DebugText(false, "[XStats::OnClientAuthorized()] Inserting into weapons table %s (SteamID '%s', ServerID %i)",
		Global.weapons, Player[client].SteamID, Cvars.ServerID.IntValue);
	}
}

void DBQuery_OnClientAuthorized_2_Callback(DatabaseEx db, DBResultSet r, const char[] error) {
	if(!r) XStats_DebugText(true, "[XStats::OnClientAuthorized()] Inserting weapons table %s %s failed! (%s)", Global.weapons, error);
}

public void OnClientPutInServer(int client) {
	if(!Cvars.PluginActive.BoolValue) return;
	if(!Tklib_IsValidClient(client, true, _, false)) return;
	
	delete Player[client].InvCallback;
	Player[client].InvCallback = new StringMapEx();
	
	/* Session */
	Player[client].Session.Clear();
	Player[client].TotalStats.Clear();
	
	/* Experimental Assister */
	if(!IsCurrentEngine(Engine_TF2)
	&& !IsCurrentEngine(Engine_CSS)
	&& !IsCurrentEngine(Engine_CSGO)) SDKHook(client, SDKHook_OnTakeDamage, Assister_OnTakeDamage);
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
	
	CPrintToChatAll("%s %t"
	, Global.Prefix
	, "Player Connected"
	, Player[client].Name
	, Player[client].Position
	, Player[client].Points
	, Player[client].Country);
	
	XStats_DebugText(false
	, "%s (Pos #%i, %i points) has connected from %s"
	, Player[client].Playername
	, Player[client].Position
	, Player[client].Points
	, Player[client].Country);
	
	if(Player[client].Position <= 10 && IsValidString(Sound[0].path)) EmitSoundToAll(Sound[0].path);
	else if(IsValidString(Sound[1].path)) EmitSoundToAll(Sound[1].path);
	
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
	
	if(!SQL) {
		XStats_DebugText(false, "Tried updating player ingame total for %s time but database is invalid (Is the database actually connected?), ignoring..", Player[client].Playername);
		return Plugin_Handled;
	}
	
	Player[client].Session.PlayTime++;
	SQL.QueryEx2(DBQuery_IntervalPlayTimer, "update `%s` set PlayTime = PlayTime+1 where SteamID='%s' and ServerID = %i"
	, client
	, Global.playerlist
	, Player[client].SteamID
	, Cvars.ServerID.IntValue);
	XStats_DebugText(false, "Updating playtime %s with an additional minute", Player[client].Playername);
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
	XStats_DebugText(false, "[XStats:Map Log] Created 1 minute repeating timer for map '%s'", Global.CurrentMap);
}

Action MapLogTimer(Handle timer) {
	if(!Cvars.PluginActive.BoolValue) {
		KillTimer(timer);
		return Plugin_Handled;
	}
	
	if(!SQL) {
		XStats_DebugText(false, "Tried updating map '%s' but database connection is invalid, ignoring..", Global.CurrentMap);
		return Plugin_Handled;
	}
	
	/* Check if map exists in database table */
	SQL.QueryEx(DBQuery_MapLog_1, "select '%s' from `%s`", Global.CurrentMap, Global.maps_log);
	
	XStats_DebugText(false, "[XStats:Map Log] Checking if map '%s' exists in %s", Global.CurrentMap, Global.maps_log);
	return Plugin_Handled;
}

void DBQuery_MapLog_1(DatabaseEx db, DBResultSet r, const char[] error) {		
	switch(r != null && r.FetchRow()) {
		/* Map was found, lets update it */
		case true: {
			db.QueryEx(DBQuery_MapLog_3, "update `%s` set PlayTime = PlayTime+1 where MapName = '%s' and ServerID = %i"
			, Global.maps_log
			, Global.CurrentMap
			, Cvars.ServerID.IntValue);
			
			XStats_DebugText(false, "[XStats:Map Log] Map '%s' was found, updating the playtime in %s", Global.CurrentMap, Global.maps_log);
		}
		/* Map was not found, lets add it */
		case false: {
			db.QueryEx(DBQuery_MapLog_2, "insert into `%s` (MapName) values ('%s')", Global.maps_log, Global.CurrentMap);
			XStats_DebugText(false, "[XStats:Map Log] Map '%s' wasn't found on database, inserting it..", Global.CurrentMap);
		}
	}
}

void DBQuery_MapLog_2(DatabaseEx db, DBResultSet r, const char[] error) {
	switch(r != null) {
		case true: {
			db.QueryEx(DBQuery_MapLog_3, "update `%s` set PlayTime = PlayTime+1 where MapName = '%s' and ServerID = %i"
			, Global.maps_log
			, Global.CurrentMap
			, Cvars.ServerID.IntValue);
			XStats_DebugText(false, "[XStats:Map Log] Updating playtime on the added map..");
		}
		case false: XStats_DebugText(true, "[XStats:Map Log] Map Log Updater failed inserting! (%s)", error);
	}
}

void DBQuery_MapLog_3(DatabaseEx db, DBResultSet r, const char[] error) {
	if(!r) XStats_DebugText(true, "[XStats:Map Log] Map Log Updater failed updating! (%s)", error);
}

public void OnEntityCreated(int entity, const char[] classname) { OnEntityCreated_CounterStrike(entity, classname); }
public void OnConfigsExecuted() { CheckActivePlayers(); } /* Check active players */
public void OnPluginEnd() { XStats_DebugText(false, "Ending.."); }

public void OnGameFrame()
{
	switch(IdentifyGame())
	{
		case Game_TF2:
		{
			OnGameFrame_TF2(); //Team Fortress 2 specifically.
			OnGameFrame_TF(); //Team Fortress overall.
		}
	}
}