void PrepareDatabase(bool PluginLoad = false) {
	if(!DatabaseEx.CheckConfig("xstats"))
		XStats_DebugText(true, "FATAL ERROR 404 DATABASE_NOT_CONFIGURED: \"xstats\" was not found in the /configs/databases.cfg file, make sure you've entered it and correctly, must be matching \"xstats\" or else it'll fail.");
	
	/* Avoid double-connections. */
	CreateTimer(PluginLoad ? 0.0 : 0.5, Timer_PrepareDatabase);
}

Action Timer_PrepareDatabase(Handle timer) {
	if(!SQL) DatabaseEx.Connect(DBConnect, Xstats); /* If it's not null, we don't need to gather new connection since we already have one, prevent corruption. */
}

void DBConnect(DatabaseEx db, const char[] error) {
	if(!db) {
		delete db;
		XStats_SetFailState("Database connection failed! (%s)", error);
		return;
	}
	
	SQL = db;
	SQL.SetCharset("utf8mb4"); //Fix characters.
	PrintToServer("[XStats] Database connection was successful!");
	Games_DatabaseConnected();
}

/* Unused */
stock void GetNewDBConnection()	{
	if(SQL != null) return; /* no need to gather new connection since we already have one, prevent corruption. */
	
	CreateTimer(10.0, RetryDBConnection);
}

Action RetryDBConnection(Handle timer) { PrepareDatabase(); }

// When player disconnects, this is called. Unused for now
stock void OnDisconnectQueries(int client)
{
	//save the info just incase.	
	integer LastConnected = GetTime();
	integer Points = Player[client].Points;
	integer SPoints = Session[client].Points;
	
	if(SPoints < 0)
	{
		Points -= SPoints;
	}
	else if(SPoints > 0)
	{
		Points += SPoints;
	}
	
	// The ones marked out are yet to be added.
	// Sessions are gonna be used mostly for custom achievements.
	
	char query[4096];
	int len = 0;
	
	switch(IdentifyGame())
	{
		case Game_TF2:
		{
			len += Format(query[len], sizeof(query)-len, "update `%s` set ", Global.playerlist);
			len += Format(query[len], sizeof(query)-len, "Points = Points = %i,", Points);
			len += Format(query[len], sizeof(query)-len, "LastConnected = %i,", LastConnected); //Could easily be done using while() in php retrieving the latest unix timestamp of them all.
			len += Format(query[len], sizeof(query)-len, "PlayTime = PlayTime + %i,", Session[client].PlayTime);
			len += Format(query[len], sizeof(query)-len, "IPAddress = '%s',", Player[client].IP);
			len += Format(query[len], sizeof(query)-len, "Kills = Kills + %i,", Session[client].Kills);
			len += Format(query[len], sizeof(query)-len, "Deaths = Deaths + %i,", Session[client].Deaths);
			len += Format(query[len], sizeof(query)-len, "Assists = Assists + %i,", Session[client].Assists);
			len += Format(query[len], sizeof(query)-len, "Suicides = Suicides + %i,", Session[client].Suicides);
			len += Format(query[len], sizeof(query)-len, "DamageDone = DamageDone + %i,", Session[client].DamageDone);
			
			len += Format(query[len], sizeof(query)-len, "ScoutKills = ScoutKills + %i,", Session[client].ScoutKills);
			len += Format(query[len], sizeof(query)-len, "SoldierKills = SoldierKills + %i,", Session[client].SoldierKills);
			len += Format(query[len], sizeof(query)-len, "PyroKills = PyroKills + %i,", Session[client].PyroKills);
			len += Format(query[len], sizeof(query)-len, "DemoKills = DemoKills + %i,", Session[client].DemoKills);
			len += Format(query[len], sizeof(query)-len, "HeavyKills = HeavyKills + %i,", Session[client].HeavyKills);
			len += Format(query[len], sizeof(query)-len, "EngieKills = EngieKills + %i,", Session[client].EngieKills);
			len += Format(query[len], sizeof(query)-len, "MedicKills = MedicKills + %i,", Session[client].MedicKills);
			len += Format(query[len], sizeof(query)-len, "SniperKills = SniperKills + %i,", Session[client].SniperKills);
			len += Format(query[len], sizeof(query)-len, "SpyKills = SpyKills + %i,", Session[client].SpyKills);
			
			len += Format(query[len], sizeof(query)-len, "ScoutDeaths = ScoutDeaths + %i,", Session[client].ScoutDeaths);
			len += Format(query[len], sizeof(query)-len, "SoldierDeaths = SoldierDeaths + %i,", Session[client].SoldierDeaths);
			len += Format(query[len], sizeof(query)-len, "PyroDeaths = PyroDeaths + %i,", Session[client].PyroDeaths);
			len += Format(query[len], sizeof(query)-len, "DemoDeaths = DemoDeaths + %i,", Session[client].DemoDeaths);
			len += Format(query[len], sizeof(query)-len, "HeavyDeaths = HeavyDeaths + %i,", Session[client].HeavyDeaths);
			len += Format(query[len], sizeof(query)-len, "EngieDeaths = EngieDeaths + %i,", Session[client].EngieDeaths);
			len += Format(query[len], sizeof(query)-len, "MedicDeaths = MedicDeaths + %i,", Session[client].MedicDeaths);
			len += Format(query[len], sizeof(query)-len, "SniperDeaths = SniperDeaths + %i,", Session[client].SniperDeaths);
			len += Format(query[len], sizeof(query)-len, "SpyDeaths = SpyDeaths + %i,", Session[client].SpyDeaths);
			
			len += Format(query[len], sizeof(query)-len, "Deflects = Deflects + %i,", Session[client].Deflects);
			len += Format(query[len], sizeof(query)-len, "Gibs = Gibs + %i,", Session[client].Gibs);
			len += Format(query[len], sizeof(query)-len, "MiniCritKills = MiniCritKills + %i,", Session[client].MiniCritkills);
			len += Format(query[len], sizeof(query)-len, "CritKills = CritKills + %i,", Session[client].Critkills);
			len += Format(query[len], sizeof(query)-len, "TauntKills = TauntKills + %i,", Session[client].Tauntkills);
			len += Format(query[len], sizeof(query)-len, "Collaterals = Collaterals + %i,", Session[client].Collaterals);
			len += Format(query[len], sizeof(query)-len, "MidAirKills = MidAirKills + %i,", Session[client].MidAirKills);
			len += Format(query[len], sizeof(query)-len, "Airshots = Airshots + %i,", Session[client].Airshots);
			len += Format(query[len], sizeof(query)-len, "Headshots = Headshots + %i,", Session[client].Headshots);
			len += Format(query[len], sizeof(query)-len, "Backstabs = Backstabs + %i,", Session[client].Backstabs);
			len += Format(query[len], sizeof(query)-len, "Noscopes = Noscopes + %i,", Session[client].Noscopes);
			len += Format(query[len], sizeof(query)-len, "Dominations = Dominations + %i,", Session[client].Dominations);
			len += Format(query[len], sizeof(query)-len, "Revenges = Revenges + %i,", Session[client].Revenges);
			len += Format(query[len], sizeof(query)-len, "Telefrags = Telefrags + %i,", Session[client].Telefrags);
			
			len += Format(query[len], sizeof(query)-len, "BuildingsBuilt = BuildingsBuilt + %i,", Session[client].BuildingsBuilt);
			len += Format(query[len], sizeof(query)-len, "MiniSentryGunsBuilt = MiniSentryGunsBuilt + %i,", Session[client].MiniSentryGunsBuilt);
			len += Format(query[len], sizeof(query)-len, "SentryGunsBuilt = SentryGunsBuilt + %i,", Session[client].SentryGunsBuilt);
			len += Format(query[len], sizeof(query)-len, "DispensersBuilt = DispensersBuilt + %i,", Session[client].DispensersBuilt);
			len += Format(query[len], sizeof(query)-len, "TeleporterExitsBuilt = TeleporterExitsBuilt + %i,", Session[client].TeleporterExitsBuilt);
			len += Format(query[len], sizeof(query)-len, "TeleporterEntrancesBuilt = TeleporterEntrancesBuilt + %i,", Session[client].TeleporterEntrancesBuilt);
			len += Format(query[len], sizeof(query)-len, "TeleportersBuilt = TeleportersBuilt + %i,", Session[client].TeleportersBuilt);
			len += Format(query[len], sizeof(query)-len, "SappersPlaced = SappersPlaced + %i,", Session[client].SappersPlaced);
			
			len += Format(query[len], sizeof(query)-len, "BuildingsDestroyed = BuildingsDestroyed + %i,", Session[client].BuildingsDestroyed);
			len += Format(query[len], sizeof(query)-len, "MiniSentryGunsDestroyed = MiniSentryGunsDestroyed + %i,", Session[client].MiniSentryGunsDestroyed);
			len += Format(query[len], sizeof(query)-len, "SentryGunsDestroyed = SentryGunsDestroyed + %i,", Session[client].SentryGunsDestroyed);
			len += Format(query[len], sizeof(query)-len, "DispensersDestroyed = DispensersDestroyed + %i,", Session[client].DispensersDestroyed);
			len += Format(query[len], sizeof(query)-len, "TeleporterExitsDestroyed = TeleporterExitsDestroyed + %i,", Session[client].TeleporterExitsDestroyed);
			len += Format(query[len], sizeof(query)-len, "TeleportersDestroyed = TeleportersDestroyed + %i,", Session[client].TeleportersDestroyed);
			len += Format(query[len], sizeof(query)-len, "SappersDestroyed = TeleportersDestroyed + %i,", Session[client].SappersDestroyed);
			
			len += Format(query[len], sizeof(query)-len, "PointsCaptured = PointsCaptured + %i,", Session[client].PointsCaptured);
			len += Format(query[len], sizeof(query)-len, "PointsDefended = PointsDefended + %i,", Session[client].PointsDefended);
			
			len += Format(query[len], sizeof(query)-len, "FlagsPickedUp = FlagsPickedUp + %i,", Session[client].FlagsPickedUp);
			len += Format(query[len], sizeof(query)-len, "FlagsCaptured = FlagsCaptured + %i,", Session[client].FlagsCaptured);
			len += Format(query[len], sizeof(query)-len, "FlagsStolen = FlagsStolen + %i,", Session[client].FlagsStolen);
			len += Format(query[len], sizeof(query)-len, "FlagsDefended = FlagsDefended + %i,", Session[client].FlagsDefended);
			
			len += Format(query[len], sizeof(query)-len, "Ubercharged = Ubercharged + %i,", Session[client].Ubercharged);
			len += Format(query[len], sizeof(query)-len, "SandvichesStolen = SandvichesStolen + %i,", Session[client].SandvichesStolen);
			
			len += Format(query[len], sizeof(query)-len, "Teleported = Teleported + %i,", Session[client].PlayerTeleported);
			len += Format(query[len], sizeof(query)-len, "PlayersTeleported = PlayersTeleported + %i,", Session[client].PlayersTeleported);
			
			len += Format(query[len], sizeof(query)-len, "StunnedPlayers = StunnedPlayers + %i,", Session[client].StunnedPlayers);
			len += Format(query[len], sizeof(query)-len, "MoonShotStunnedPlayers = MoonShotStunnedPlayers + %i,", Session[client].MoonShotStunnedPlayers);
			
			len += Format(query[len], sizeof(query)-len, "MonoculusStunned = MonoculusStunned + %i,", Session[client].StunnedMonoculus);
			len += Format(query[len], sizeof(query)-len, "MonoculusKilled = MonoculusKilled + %i,", Session[client].KilledMonoculus);
			len += Format(query[len], sizeof(query)-len, "MerasmusStunned = MerasmusStunned + %i,", Session[client].StunnedMerasmus);
			len += Format(query[len], sizeof(query)-len, "MerasmusKilled = MerasmusKilled + %i,", Session[client].KilledMerasmus);
			len += Format(query[len], sizeof(query)-len, "KilledHHH = KilledHHH + %i,", Session[client].KilledHHH);
			
			len += Format(query[len], sizeof(query)-len, "PassBallsGotten = PassBallsGotten + %i,", Session[client].PassBallsGotten);
			len += Format(query[len], sizeof(query)-len, "PassBallsScored = PassBallsScored + %i,", Session[client].PassBallsScored);
			len += Format(query[len], sizeof(query)-len, "PassBallsDropped = PassBallsDropped + %i,", Session[client].PassBallsDropped);
			len += Format(query[len], sizeof(query)-len, "PassBallsCatched = PassBallsCatched + %i,", Session[client].PassBallsCatched);
			len += Format(query[len], sizeof(query)-len, "PassBallsStolen = PassBallsStolen + %i,", Session[client].PassBallsStolen);
			len += Format(query[len], sizeof(query)-len, "PassBallsBlocked = PassBallsBlocked + %i,", Session[client].PassBallsBlocked);
			
			len += Format(query[len], sizeof(query)-len, "Coated = Coated + %i,", Session[client].Coated);
			len += Format(query[len], sizeof(query)-len, "Jarated = Jarated + %i,", Session[client].Jarated);
			len += Format(query[len], sizeof(query)-len, "MadMilked = MadMilked + %i,", Session[client].MadMilked);
			len += Format(query[len], sizeof(query)-len, "Extinguished = Extinguished + %i,", Session[client].Extinguished);
			
			len += Format(query[len], sizeof(query)-len, "TanksDestroyed = TanksDestroyed + %i,", Session[client].TanksDestroyed);
			len += Format(query[len], sizeof(query)-len, "SentryBustersKilled = SentryBustersKilled + %i", Session[client].SentryBustersKilled);
			
			len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", Player[client].SteamID, Cvars.ServerID.IntValue);
		}
	}
	
	if(IsValidString(query))
	{
		SQL.Query(OnDisconnectQueries_Callback, query, client);
	}
}

stock void OnDisconnectQueries_Callback(DatabaseEx db, DBResultSet r, const char[] e, int c)
{
	switch(r != null)
	{
		case true: PrintToServer("[XStats:OnDisconnectQueries()] : Suceeded updating queries for %s player table %s!", Player[c].Playername, Global.playerlist);
		case false: PrintToServer("[XStats:OnDisconnectQueries()] Failed to update queries for %s on player table %s! (%s)", Player[c].Playername, Global.playerlist, e);
	}
}