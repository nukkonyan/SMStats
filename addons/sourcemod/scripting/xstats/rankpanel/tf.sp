stock void TotalStatistics_TF2(int client)	{
	/* We select the tables below and prepare the query */
	SQL.QueryEx2(DBQuery_TotalStatistics_TF2, "select " 
	... "Points,"
	... "PlayTime,"
	... "Kills,"
	... "Assists,"
	... "Deaths,"
	... "Suicides,"
	... "MidAirKills,"
	... "DamageDone,"
	... "Dominations,"
	... "Revenges,"
	... "Headshots,"
	... "Noscopes,"
	... "Backstabs,"
	... "Airshots,"
	... "Deflects,"
	... "Gibs,"
	... "CritKills,"
	... "MiniCritKills,"
	... "Tauntkills,"
	... "TeleFrags,"
	... "BuildingsBuilt,"
	... "MiniSentryGunsBuilt,"
	... "SentryGunsBuilt,"
	... "DispensersBuilt,"
	... "TeleporterExitsBuilt,"
	... "TeleporterEntrancesBuilt,"
	... "TeleportersBuilt,"
	... "SappersPlaced,"
	... "BuildingsDestroyed,"
	... "MiniSentryGunsDestroyed,"
	... "SentryGunsDestroyed,"
	... "DispensersDestroyed,"
	... "TeleporterExitsDestroyed,"
	... "TeleporterEntrancesDestroyed,"
	... "TeleportersDestroyed,"
	... "SappersDestroyed,"
	... "Coated,"
	... "Jarated,"
	... "MadMilked,"
	... "Extinguished,"
	... "PointsCaptured,"
	... "PointsDefended,"
	... "FlagsPickedUp,"
	... "FlagsCaptured,"
	... "FlagsStolen,"
	... "FlagsDefended,"
	... "Ubercharged,"
	... "SandvichesStolen,"
	... "Teleported,"
	... "PlayersTeleported,"
	... "StunnedPlayers,"
	... "MoonShotStunnedPlayers,"
	... "MonoculusStunned,"
	... "MonoculusKilled,"
	... "MerasmusStunned,"
	... "MerasmusKilled,"
	... "KilledHHH,"
	... "TanksDestroyed,"
	... "SentryBustersKilled,"
	... "PassBallsGotten,"
	... "PassBallsScored,"
	... "PassBallsDropped,"
	... "PassBallsCatched,"
	... "PassBallsStolen,"
	... "PassBallsBlocked"
	... " from `%s` where SteamID='%s' and ServerID='%i'", client, Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
}

void DBQuery_TotalStatistics_TF2(DatabaseEx database, DBResultSet results, const char[] error, int client) {
	if(!results) {
		CPrintToChat(client, "%s Unable to read the playerlist table.", Global.Prefix);
		XStats_DebugText(false, "%s attempted to read their total statistics on the rank panel but failed to read the table from table \"%s\"",
		Player[client].Playername, Global.playerlist);
		XStats_DebugText(false, "Error: %s", error);
		return;
	}
	
	if(!results.FetchRow())	{
		CPrintToChat(client, "%s Unable to fetch the playerlist table.", Global.Prefix);
		XStats_DebugText(false, "%s attempted to read their total statistics on the rank panel but failed to fetch the table from table \"%s\"",
		Player[client].Playername, Global.playerlist);
		if(IsValidString(error)) XStats_DebugText(false, "Error: %s", error); /* Incase an error is included. */
		return;
	}
	
	Player[client].TotalStats.Points = results.FetchInt(0);
	Player[client].TotalStats.PlayTime = results.FetchInt(1);
	Player[client].TotalStats.Kills = results.FetchInt(2);
	Player[client].TotalStats.Assists = results.FetchInt(3);
	Player[client].TotalStats.Deaths = results.FetchInt(4);
	Player[client].TotalStats.Suicides = results.FetchInt(5);
	Player[client].TotalStats.MidAirKills = results.FetchInt(6);
	Player[client].TotalStats.DamageDone = results.FetchInt(7);
	Player[client].TotalStats.Dominations = results.FetchInt(8);
	Player[client].TotalStats.Revenges = results.FetchInt(9);
	Player[client].TotalStats.Headshots = results.FetchInt(10);
	Player[client].TotalStats.Noscopes = results.FetchInt(11);
	Player[client].TotalStats.Backstabs = results.FetchInt(12);
	Player[client].TotalStats.Airshots = results.FetchInt(13);
	Player[client].TotalStats.Deflects = results.FetchInt(14);
	Player[client].TotalStats.Gibs = results.FetchInt(15);
	Player[client].TotalStats.Critkills = results.FetchInt(16);
	Player[client].TotalStats.MiniCritkills = results.FetchInt(17);
	Player[client].TotalStats.Tauntkills = results.FetchInt(18);
	Player[client].TotalStats.Telefrags = results.FetchInt(19);
	Player[client].TotalStats.BuildingsBuilt = results.FetchInt(20);
	Player[client].TotalStats.MiniSentryGunsBuilt = results.FetchInt(21);
	Player[client].TotalStats.SentryGunsBuilt = results.FetchInt(22);
	Player[client].TotalStats.DispensersBuilt = results.FetchInt(23);
	Player[client].TotalStats.TeleporterExitsBuilt = results.FetchInt(24);
	Player[client].TotalStats.TeleporterEntrancesBuilt = results.FetchInt(25);
	Player[client].TotalStats.TeleportersBuilt = results.FetchInt(26);
	Player[client].TotalStats.SappersPlaced = results.FetchInt(27);
	Player[client].TotalStats.BuildingsDestroyed = results.FetchInt(28);
	Player[client].TotalStats.MiniSentryGunsDestroyed = results.FetchInt(29);
	Player[client].TotalStats.SentryGunsDestroyed = results.FetchInt(30);
	Player[client].TotalStats.DispensersDestroyed = results.FetchInt(31);
	Player[client].TotalStats.TeleporterExitsDestroyed = results.FetchInt(32);
	Player[client].TotalStats.TeleporterEntrancesDestroyed = results.FetchInt(33);
	Player[client].TotalStats.TeleportersDestroyed = results.FetchInt(34);
	Player[client].TotalStats.SappersDestroyed = results.FetchInt(35);
	Player[client].TotalStats.Coated = results.FetchInt(36);
	Player[client].TotalStats.Jarated = results.FetchInt(37);
	Player[client].TotalStats.MadMilked = results.FetchInt(38);
	Player[client].TotalStats.Extinguished = results.FetchInt(39);
	Player[client].TotalStats.PointsCaptured = results.FetchInt(40);
	Player[client].TotalStats.PointsDefended = results.FetchInt(41);
	Player[client].TotalStats.FlagsPickedUp = results.FetchInt(42);
	Player[client].TotalStats.FlagsCaptured = results.FetchInt(43);
	Player[client].TotalStats.FlagsStolen = results.FetchInt(44);
	Player[client].TotalStats.FlagsDefended = results.FetchInt(45);
	Player[client].TotalStats.Ubercharged = results.FetchInt(46);
	Player[client].TotalStats.SandvichesStolen = results.FetchInt(47);
	Player[client].TotalStats.PlayerTeleported = results.FetchInt(48);
	Player[client].TotalStats.PlayersTeleported = results.FetchInt(49);
	Player[client].TotalStats.StunnedPlayers = results.FetchInt(50);
	Player[client].TotalStats.MoonShotStunnedPlayers = results.FetchInt(51);
	Player[client].TotalStats.StunnedMonoculus = results.FetchInt(52);
	Player[client].TotalStats.KilledMonoculus = results.FetchInt(53);
	Player[client].TotalStats.StunnedMerasmus = results.FetchInt(54);
	Player[client].TotalStats.KilledMerasmus = results.FetchInt(55);
	Player[client].TotalStats.KilledHHH = results.FetchInt(56);
	Player[client].TotalStats.TanksDestroyed = results.FetchInt(57);
	Player[client].TotalStats.SentryBustersKilled = results.FetchInt(58);
	Player[client].TotalStats.PassBallsGotten = results.FetchInt(59);
	Player[client].TotalStats.PassBallsScored = results.FetchInt(60);
	Player[client].TotalStats.PassBallsDropped = results.FetchInt(61);
	Player[client].TotalStats.PassBallsCatched = results.FetchInt(62);
	Player[client].TotalStats.PassBallsStolen = results.FetchInt(63);
	Player[client].TotalStats.PassBallsBlocked = results.FetchInt(64);
	
	RankPanel_Total_TF2(client, 1);
}

void RankPanel_Total_TF2(int client, int page) {
	PanelEx panel = new PanelEx();
	panel.DrawItem("XStats Panel: Total Statistics (Page %i)", page);
	
	switch(page) {
		case 1:	{
			panel.DrawText("%i Points", Player[client].TotalStats.Points);
			panel.DrawText("%i Minutes played", Player[client].TotalStats.PlayTime);
			panel.DrawText("%i Kills", Player[client].TotalStats.Kills);
			panel.DrawText("%i Assists", Player[client].TotalStats.Assists);
			panel.DrawText("%i Deaths", Player[client].TotalStats.Deaths);
			panel.DrawText("%i Suicides", Player[client].TotalStats.Suicides);
			panel.DrawText("%i Mid-air kills", Player[client].TotalStats.MidAirKills);
			panel.DrawText("%i Damage dealt", Player[client].TotalStats.DamageDone+Player[client].Session.DamageDone); /* We combine these two as one, since otherwise we'd have lags big time */
			panel.DrawText("KDR: %.2f", GetRatio(Player[client].TotalStats.Kills, Player[client].TotalStats.Deaths));
			panel.DrawSpace();
			panel.DrawItem("TF Stats");
			panel.DrawText("%i Dominations", Player[client].TotalStats.Dominations);
			panel.DrawText("%i Revenges", Player[client].TotalStats.Revenges);
			panel.DrawText("%i Headshots", Player[client].TotalStats.Headshots);
			panel.DrawText("%i Noscopes", Player[client].TotalStats.Noscopes);
			panel.DrawText("%i Backstabs", Player[client].TotalStats.Backstabs);
			panel.DrawText("%i Airshots", Player[client].TotalStats.Airshots);
			panel.DrawText("%i Deflects", Player[client].TotalStats.Deflects);
			panel.DrawText("%i Gibs", Player[client].TotalStats.Gibs);
			panel.DrawText("%i Critkills", Player[client].TotalStats.Critkills);
			panel.DrawText("%i Mini-critkills", Player[client].TotalStats.MiniCritkills);
			panel.DrawText("%i Tauntkills", Player[client].TotalStats.Tauntkills);
			panel.DrawText("%i Telefrags", Player[client].TotalStats.Telefrags);
			panel.DrawText("%i Buildings built", Player[client].TotalStats.BuildingsBuilt);
			panel.DrawText("%i Buildings destroyed", Player[client].TotalStats.BuildingsDestroyed);
			panel.DrawSpace();
			panel.DrawItem("Back");
			panel.DrawItem("Next");
		}
		
		case 2:	{
			panel.DrawSpace();
			panel.DrawText("%i Mini-Sentryguns built", Player[client].TotalStats.MiniSentryGunsBuilt);
			panel.DrawText("%i Sentryguns built", Player[client].TotalStats.SentryGunsBuilt);
			panel.DrawText("%i Dispensers built", Player[client].TotalStats.DispensersBuilt);
			panel.DrawText("%i Teleporter exits built", Player[client].TotalStats.TeleporterExitsBuilt);
			panel.DrawText("%i Teleporter entrances built", Player[client].TotalStats.TeleporterEntrancesBuilt);
			panel.DrawText("%i Teleporters built", Player[client].TotalStats.TeleportersBuilt);
			panel.DrawText("%i Sappers placed", Player[client].TotalStats.SappersPlaced);
			panel.DrawText("%i Mini-Sentryguns destroyed", Player[client].TotalStats.MiniSentryGunsBuilt);
			panel.DrawText("%i Sentryguns destroyed", Player[client].TotalStats.SentryGunsDestroyed);
			panel.DrawText("%i Dispensers destroyed", Player[client].TotalStats.DispensersBuilt);
			panel.DrawText("%i Teleporter exits destroyed", Player[client].TotalStats.TeleporterExitsDestroyed);
			panel.DrawText("%i Teleporter entrances destroyed", Player[client].TotalStats.TeleporterEntrancesDestroyed);
			panel.DrawText("%i Teleporters destroyed", Player[client].TotalStats.TeleportersDestroyed);
			panel.DrawText("%i Sappers destroyed", Player[client].TotalStats.SappersDestroyed);
			panel.DrawText("%i Coated", Player[client].TotalStats.Coated);
			panel.DrawText("%i Jarated", Player[client].TotalStats.Jarated);
			panel.DrawText("%i Mad milked", Player[client].TotalStats.MadMilked);
			panel.DrawText("%i Extinguished", Player[client].TotalStats.Extinguished);
			panel.DrawText("%i Points captured", Player[client].TotalStats.PointsCaptured);
			panel.DrawText("%i Points defended", Player[client].TotalStats.PointsDefended);
			panel.DrawSpace();
			panel.DrawItem("Back");
			panel.DrawItem("Next");
		}
		
		case 3:	{
			panel.DrawSpace();
			panel.DrawText("%i Flags picked up", Player[client].TotalStats.FlagsPickedUp);
			panel.DrawText("%i Flags captured", Player[client].TotalStats.FlagsCaptured);
			panel.DrawText("%i Flags stolen", Player[client].TotalStats.FlagsStolen);
			panel.DrawText("%i Flags defended", Player[client].TotalStats.FlagsDefended);
			panel.DrawText("%i Players übercharged", Player[client].TotalStats.Ubercharged);
			panel.DrawText("%i Sandviches stolen", Player[client].TotalStats.SandvichesStolen);
			panel.DrawText("%i Teleporters used", Player[client].TotalStats.PlayersTeleported);
			panel.DrawText("%i Players teleported", Player[client].TotalStats.PlayersTeleported);
			panel.DrawText("%i Stunned players", Player[client].TotalStats.StunnedPlayers);
			panel.DrawText("%i Moonshot stunned players", Player[client].TotalStats.MoonShotStunnedPlayers);
			panel.DrawText("%i Stunned monoculus", Player[client].TotalStats.StunnedMonoculus);
			panel.DrawText("%i Killed monoculus", Player[client].TotalStats.KilledMonoculus);
			panel.DrawText("%i Stunned merasmus", Player[client].TotalStats.StunnedMerasmus);
			panel.DrawText("%i Killed merasmus", Player[client].TotalStats.KilledMerasmus);
			panel.DrawText("%i Killed Horseless headless horsemann", Player[client].TotalStats.KilledHHH);
			panel.DrawText("%i Tanks destroyed", Player[client].TotalStats.TanksDestroyed);
			panel.DrawText("%i Sentrybusters destroyed", Player[client].TotalStats.SentryBustersKilled);
			panel.DrawSpace();	
			panel.DrawItem("Back");
			panel.DrawItem("Next");
		}
		
		case 4:	{
			panel.DrawSpace();
			panel.DrawText("%i Passballs gotten", Player[client].TotalStats.PassBallsGotten);
			panel.DrawText("%i Passballs scored", Player[client].TotalStats.PassBallsScored);
			panel.DrawText("%i Passballs dropped", Player[client].TotalStats.PassBallsDropped);
			panel.DrawText("%i Passballs catched", Player[client].TotalStats.PassBallsCatched);
			panel.DrawText("%i Passballs stolen", Player[client].TotalStats.PassBallsStolen);
			panel.DrawText("%i Passballs blocked", Player[client].TotalStats.PassBallsBlocked);
			panel.DrawSpace();	
			panel.DrawItem("Back");
		}
	}
	
	panel.DrawItem("Exit");
	panel.Send(client, Panel_TotalStatisticsCallback);
	Player[client].StatsPanel.TotalPage = page;
}