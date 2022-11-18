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
	... "TauntKills,"
	... "TeleFrags,"
	... "TotalBuildingsBuilt,"
	... "MiniSentryGunsBuilt,"
	... "SentryGunsBuilt,"
	... "DispensersBuilt,"
	... "TeleporterExitsBuilt,"
	... "TeleporterEntrancesBuilt,"
	... "SappersPlaced,"
	... "TotalBuildingsDestroyed,"
	... "MiniSentryGunsDestroyed,"
	... "SentryGunsDestroyed,"
	... "DispensersDestroyed,"
	... "TeleporterExitsDestroyed,"
	... "TeleporterEntrancesDestroyed,"
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
	... "PlayerTeleported,"
	... "TotalPlayersTeleported,"
	... "StunnedPlayers,"
	... "MoonShotStunnedPlayers,"
	... "TotalMonoculusStunned,"
	... "TotalMonoculusKilled,"
	... "TotalMerasmusStunned,"
	... "TotalMerasmusKilled,"
	... "TotalKilledHHH,"
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
	
	TotalStats[client].Points = results.FetchInt(0);
	TotalStats[client].PlayTime = results.FetchInt(1);
	TotalStats[client].Kills = results.FetchInt(2);
	TotalStats[client].Assists = results.FetchInt(3);
	TotalStats[client].Deaths = results.FetchInt(4);
	TotalStats[client].Suicides = results.FetchInt(5);
	TotalStats[client].MidAirKills = results.FetchInt(6);
	TotalStats[client].DamageDone = results.FetchInt(7);
	TotalStats[client].Dominations = results.FetchInt(8);
	TotalStats[client].Revenges = results.FetchInt(9);
	TotalStats[client].Headshots = results.FetchInt(10);
	TotalStats[client].Noscopes = results.FetchInt(11);
	TotalStats[client].Backstabs = results.FetchInt(12);
	TotalStats[client].Airshots = results.FetchInt(13);
	TotalStats[client].Deflects = results.FetchInt(14);
	TotalStats[client].Gibs = results.FetchInt(15);
	TotalStats[client].Critkills = results.FetchInt(16);
	TotalStats[client].MiniCritkills = results.FetchInt(17);
	TotalStats[client].Tauntkills = results.FetchInt(18);
	TotalStats[client].Telefrags = results.FetchInt(19);
	TotalStats[client].BuildingsBuilt = results.FetchInt(20);
	TotalStats[client].MiniSentryGunsBuilt = results.FetchInt(21);
	TotalStats[client].SentryGunsBuilt = results.FetchInt(22);
	TotalStats[client].DispensersBuilt = results.FetchInt(23);
	TotalStats[client].TeleporterExitsBuilt = results.FetchInt(24);
	TotalStats[client].TeleporterEntrancesBuilt = results.FetchInt(25);
	TotalStats[client].SappersPlaced = results.FetchInt(26);
	TotalStats[client].BuildingsDestroyed = results.FetchInt(27);
	TotalStats[client].MiniSentryGunsDestroyed = results.FetchInt(28);
	TotalStats[client].SentryGunsDestroyed = results.FetchInt(29);
	TotalStats[client].DispensersDestroyed = results.FetchInt(30);
	TotalStats[client].TeleporterExitsDestroyed = results.FetchInt(31);
	TotalStats[client].TeleporterEntrancesDestroyed = results.FetchInt(32);
	TotalStats[client].SappersDestroyed = results.FetchInt(33);
	TotalStats[client].Coated = results.FetchInt(34);
	TotalStats[client].Jarated = results.FetchInt(35);
	TotalStats[client].MadMilked = results.FetchInt(36);
	TotalStats[client].Extinguished = results.FetchInt(37);
	TotalStats[client].PointsCaptured = results.FetchInt(38);
	TotalStats[client].PointsDefended = results.FetchInt(39);
	TotalStats[client].FlagsPickedUp = results.FetchInt(40);
	TotalStats[client].FlagsCaptured = results.FetchInt(41);
	TotalStats[client].FlagsStolen = results.FetchInt(42);
	TotalStats[client].FlagsDefended = results.FetchInt(43);
	TotalStats[client].Ubercharged = results.FetchInt(44);
	TotalStats[client].SandvichesStolen = results.FetchInt(45);
	TotalStats[client].PlayerTeleported = results.FetchInt(46);
	TotalStats[client].PlayersTeleported = results.FetchInt(47);
	TotalStats[client].StunnedPlayers = results.FetchInt(48);
	TotalStats[client].MoonShotStunnedPlayers = results.FetchInt(49);
	TotalStats[client].StunnedMonoculus = results.FetchInt(50);
	TotalStats[client].KilledMonoculus = results.FetchInt(51);
	TotalStats[client].StunnedMerasmus = results.FetchInt(52);
	TotalStats[client].KilledMerasmus = results.FetchInt(53);
	TotalStats[client].KilledHHH = results.FetchInt(54);
	TotalStats[client].TanksDestroyed = results.FetchInt(55);
	TotalStats[client].SentryBustersKilled = results.FetchInt(56);
	TotalStats[client].PassBallsGotten = results.FetchInt(57);
	TotalStats[client].PassBallsScored = results.FetchInt(58);
	TotalStats[client].PassBallsDropped = results.FetchInt(59);
	TotalStats[client].PassBallsCatched = results.FetchInt(60);
	TotalStats[client].PassBallsStolen = results.FetchInt(61);
	TotalStats[client].PassBallsBlocked = results.FetchInt(62);
	
	RankPanel_Total_TF2(client, 1);
}

void RankPanel_Total_TF2(int client, int page) {
	PanelEx panel = new PanelEx();
	panel.DrawItem("XStats Panel: Total Statistics (Page %i)", page);
	
	switch(page) {
		case 1:	{
			panel.DrawText("%i Points", TotalStats[client].Points);
			panel.DrawText("%i Minutes played", TotalStats[client].PlayTime);
			panel.DrawText("%i Kills", TotalStats[client].Kills);
			panel.DrawText("%i Assists", TotalStats[client].Assists);
			panel.DrawText("%i Deaths", TotalStats[client].Deaths);
			panel.DrawText("%i Suicides", TotalStats[client].Suicides);
			panel.DrawText("%i Mid-air kills", TotalStats[client].MidAirKills);
			panel.DrawText("%i Damage dealt", TotalStats[client].DamageDone+Session[client].DamageDone); /* We combine these two as one, since otherwise we'd have lags big time */
			panel.DrawText("KDR: %.2f", GetRatio(TotalStats[client].Kills, TotalStats[client].Deaths));
			panel.DrawSpace();
			panel.DrawItem("TF Stats");
			panel.DrawText("%i Dominations", TotalStats[client].Dominations);
			panel.DrawText("%i Revenges", TotalStats[client].Revenges);
			panel.DrawText("%i Headshots", TotalStats[client].Headshots);
			panel.DrawText("%i Noscopes", TotalStats[client].Noscopes);
			panel.DrawText("%i Backstabs", TotalStats[client].Backstabs);
			panel.DrawText("%i Airshots", TotalStats[client].Airshots);
			panel.DrawText("%i Deflects", TotalStats[client].Deflects);
			panel.DrawText("%i Gibs", TotalStats[client].Gibs);
			panel.DrawText("%i Critkills", TotalStats[client].Critkills);
			panel.DrawText("%i Mini-critkills", TotalStats[client].MiniCritkills);
			panel.DrawText("%i Tauntkills", TotalStats[client].Tauntkills);
			panel.DrawText("%i Telefrags", TotalStats[client].Telefrags);
			panel.DrawText("%i Buildings built", TotalStats[client].BuildingsBuilt);
			panel.DrawText("%i Buildings destroyed", TotalStats[client].BuildingsDestroyed);
			panel.DrawSpace();
			panel.DrawItem("Back");
			panel.DrawItem("Next");
		}
		
		case 2:	{
			panel.DrawSpace();
			panel.DrawText("%i Mini-Sentryguns built", TotalStats[client].MiniSentryGunsBuilt);
			panel.DrawText("%i Sentryguns built", TotalStats[client].SentryGunsBuilt);
			panel.DrawText("%i Dispensers built", TotalStats[client].DispensersBuilt);
			panel.DrawText("%i Teleporter exits built", TotalStats[client].TeleporterExitsBuilt);
			panel.DrawText("%i Teleporter entrances built", TotalStats[client].TeleporterEntrancesBuilt);
			panel.DrawText("%i Sappers placed", TotalStats[client].SappersPlaced);
			panel.DrawText("%i Mini-Sentryguns destroyed", TotalStats[client].MiniSentryGunsBuilt);
			panel.DrawText("%i Sentryguns destroyed", TotalStats[client].SentryGunsDestroyed);
			panel.DrawText("%i Dispensers destroyed", TotalStats[client].DispensersBuilt);
			panel.DrawText("%i Teleporter exits destroyed", TotalStats[client].TeleporterExitsDestroyed);
			panel.DrawText("%i Teleporter entrances destroyed", TotalStats[client].TeleporterEntrancesDestroyed);
			panel.DrawText("%i Sappers destroyed", TotalStats[client].SappersDestroyed);
			panel.DrawText("%i Coated", TotalStats[client].Coated);
			panel.DrawText("%i Jarated", TotalStats[client].Jarated);
			panel.DrawText("%i Mad milked", TotalStats[client].MadMilked);
			panel.DrawText("%i Extinguished", TotalStats[client].Extinguished);
			panel.DrawText("%i Points captured", TotalStats[client].PointsCaptured);
			panel.DrawText("%i Points defended", TotalStats[client].PointsDefended);
			panel.DrawSpace();
			panel.DrawItem("Back");
			panel.DrawItem("Next");
		}
		
		case 3:	{
			panel.DrawSpace();
			panel.DrawText("%i Flags picked up", TotalStats[client].FlagsPickedUp);
			panel.DrawText("%i Flags captured", TotalStats[client].FlagsCaptured);
			panel.DrawText("%i Flags stolen", TotalStats[client].FlagsStolen);
			panel.DrawText("%i Flags defended", TotalStats[client].FlagsDefended);
			panel.DrawText("%i Players übercharged", TotalStats[client].Ubercharged);
			panel.DrawText("%i Sandviches stolen", TotalStats[client].SandvichesStolen);
			panel.DrawText("%i Teleporters used", TotalStats[client].PlayersTeleported);
			panel.DrawText("%i Players teleported", TotalStats[client].PlayersTeleported);
			panel.DrawText("%i Stunned players", TotalStats[client].StunnedPlayers);
			panel.DrawText("%i Moonshot stunned players", TotalStats[client].MoonShotStunnedPlayers);
			panel.DrawText("%i Stunned monoculus", TotalStats[client].StunnedMonoculus);
			panel.DrawText("%i Killed monoculus", TotalStats[client].KilledMonoculus);
			panel.DrawText("%i Stunned merasmus", TotalStats[client].StunnedMerasmus);
			panel.DrawText("%i Killed merasmus", TotalStats[client].KilledMerasmus);
			panel.DrawText("%i Killed Horseless headless horsemann", TotalStats[client].KilledHHH);
			panel.DrawText("%i Tanks destroyed", TotalStats[client].TanksDestroyed);
			panel.DrawText("%i Sentrybusters destroyed", TotalStats[client].SentryBustersKilled);
			panel.DrawSpace();	
			panel.DrawItem("Back");
			panel.DrawItem("Next");
		}
		
		case 4:	{
			panel.DrawSpace();
			panel.DrawText("%i Passballs gotten", TotalStats[client].PassBallsGotten);
			panel.DrawText("%i Passballs scored", TotalStats[client].PassBallsScored);
			panel.DrawText("%i Passballs dropped", TotalStats[client].PassBallsDropped);
			panel.DrawText("%i Passballs catched", TotalStats[client].PassBallsCatched);
			panel.DrawText("%i Passballs stolen", TotalStats[client].PassBallsStolen);
			panel.DrawText("%i Passballs blocked", TotalStats[client].PassBallsBlocked);
			panel.DrawSpace();	
			panel.DrawItem("Back");
		}
	}
	
	panel.DrawItem("Exit");
	panel.Send(client, Panel_TotalStatisticsCallback);
	StatsPanel[client].TotalPage = page;
}