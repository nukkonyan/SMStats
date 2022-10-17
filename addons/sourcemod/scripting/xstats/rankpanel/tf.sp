stock void TotalStatistics_TF2(int client)	{
	char query[4096];
	int len = 0;
	
	len += Format(query[len], sizeof(query)-len, "select "); /* We select the tables below */
	len += Format(query[len], sizeof(query)-len, ", Points");
	len += Format(query[len], sizeof(query)-len, ", PlayTime");
	len += Format(query[len], sizeof(query)-len, ", Kills");
	len += Format(query[len], sizeof(query)-len, ", Assists");
	len += Format(query[len], sizeof(query)-len, ", Deaths");
	len += Format(query[len], sizeof(query)-len, ", Suicides");
	len += Format(query[len], sizeof(query)-len, ", MidAirKills");
	len += Format(query[len], sizeof(query)-len, ", DamageDone");
	len += Format(query[len], sizeof(query)-len, ", Dominations");
	len += Format(query[len], sizeof(query)-len, ", Revenges");
	len += Format(query[len], sizeof(query)-len, ", Headshots");
	len += Format(query[len], sizeof(query)-len, ", Noscopes");
	len += Format(query[len], sizeof(query)-len, ", Backstabs");
	len += Format(query[len], sizeof(query)-len, ", Airshots");
	len += Format(query[len], sizeof(query)-len, ", DeflectKills");
	len += Format(query[len], sizeof(query)-len, ", GibKills");
	len += Format(query[len], sizeof(query)-len, ", CritKills");
	len += Format(query[len], sizeof(query)-len, ", TauntKills");
	len += Format(query[len], sizeof(query)-len, ", TeleFrags");
	len += Format(query[len], sizeof(query)-len, ", TotalBuildingsBuilt");
	len += Format(query[len], sizeof(query)-len, ", MiniSentryGunsBuilt");
	len += Format(query[len], sizeof(query)-len, ", SentryGunsBuilt");
	len += Format(query[len], sizeof(query)-len, ", DispensersBuilt");
	len += Format(query[len], sizeof(query)-len, ", TeleporterExitsBuilt");
	len += Format(query[len], sizeof(query)-len, ", TeleporterEntrancesBuilt");
	len += Format(query[len], sizeof(query)-len, ", SappersPlaced");
	len += Format(query[len], sizeof(query)-len, ", TotalBuildingsDestroyed");
	len += Format(query[len], sizeof(query)-len, ", MiniSentryGunsDestroyed");
	len += Format(query[len], sizeof(query)-len, ", SentryGunsDestroyed");
	len += Format(query[len], sizeof(query)-len, ", DispensersDestroyed");
	len += Format(query[len], sizeof(query)-len, ", TeleporterExitsDestroyed");
	len += Format(query[len], sizeof(query)-len, ", TeleporterEntrancesDestroyed");
	len += Format(query[len], sizeof(query)-len, ", SappersDestroyed");
	len += Format(query[len], sizeof(query)-len, ", Coated");
	len += Format(query[len], sizeof(query)-len, ", Jarated");
	len += Format(query[len], sizeof(query)-len, ", MadMilked");
	len += Format(query[len], sizeof(query)-len, ", Extinguished");
	len += Format(query[len], sizeof(query)-len, ", PointsCaptured");
	len += Format(query[len], sizeof(query)-len, ", PointsDefended");
	len += Format(query[len], sizeof(query)-len, ", FlagsPickedUp");
	len += Format(query[len], sizeof(query)-len, ", FlagsCaptured");
	len += Format(query[len], sizeof(query)-len, ", FlagsStolen");
	len += Format(query[len], sizeof(query)-len, ", FlagsDefended");
	len += Format(query[len], sizeof(query)-len, ", Ubercharged");
	len += Format(query[len], sizeof(query)-len, ", SandvichesStolen");
	len += Format(query[len], sizeof(query)-len, ", PlayerTeleported");
	len += Format(query[len], sizeof(query)-len, ", TotalPlayersTeleported");
	len += Format(query[len], sizeof(query)-len, ", StunnedPlayers");
	len += Format(query[len], sizeof(query)-len, ", MoonShotStunnedPlayers");
	len += Format(query[len], sizeof(query)-len, ", TotalMonoculusStunned");
	len += Format(query[len], sizeof(query)-len, ", TotalMonoculusKilled");
	len += Format(query[len], sizeof(query)-len, ", TotalMerasmusStunned");
	len += Format(query[len], sizeof(query)-len, ", TotalMerasmusKilled");
	len += Format(query[len], sizeof(query)-len, ", TotalKilledHHH");
	len += Format(query[len], sizeof(query)-len, ", TanksDestroyed");
	len += Format(query[len], sizeof(query)-len, ", SentryBustersKilled");
	len += Format(query[len], sizeof(query)-len, ", PassBallsGotten");
	len += Format(query[len], sizeof(query)-len, ", PassBallsScored");
	len += Format(query[len], sizeof(query)-len, ", PassBallsDropped");
	len += Format(query[len], sizeof(query)-len, ", PassBallsCatched");
	len += Format(query[len], sizeof(query)-len, ", PassBallsStolen");
	len += Format(query[len], sizeof(query)-len, ", PassBallsBlocked");
	/* Prepare the query */
	len += Format(query[len], sizeof(query)-len, "from `%s` where SteamID='%s' and ServerID='%i'", Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	DB.Threaded.Query(DBQuery_TotalStatistics_TF2, query, client);
}

stock void DBQuery_TotalStatistics_TF2(Database database, DBResultSet results, const char[] error, int client)	{
	if(results == null)	{
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
		if(!StrEqual(error, NULL_STRING)) /* Incase an error is included. */
			XStats_DebugText(false, "Error: %s", error);
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
	TotalStats[client].Tauntkills = results.FetchInt(17);
	TotalStats[client].Telefrags = results.FetchInt(18);
	TotalStats[client].BuildingsBuilt = results.FetchInt(19);
	TotalStats[client].MiniSentryGunsBuilt = results.FetchInt(20);
	TotalStats[client].SentryGunsBuilt = results.FetchInt(21);
	TotalStats[client].DispensersBuilt = results.FetchInt(22);
	TotalStats[client].TeleporterExitsBuilt = results.FetchInt(23);
	TotalStats[client].TeleporterEntrancesBuilt = results.FetchInt(24);
	TotalStats[client].SappersPlaced = results.FetchInt(25);
	TotalStats[client].BuildingsDestroyed = results.FetchInt(26);
	TotalStats[client].MiniSentryGunsDestroyed = results.FetchInt(27);
	TotalStats[client].SentryGunsDestroyed = results.FetchInt(28);
	TotalStats[client].DispensersDestroyed = results.FetchInt(29);
	TotalStats[client].TeleporterExitsDestroyed = results.FetchInt(30);
	TotalStats[client].TeleporterEntrancesDestroyed = results.FetchInt(31);
	TotalStats[client].SappersDestroyed = results.FetchInt(32);
	TotalStats[client].Coated = results.FetchInt(33);
	TotalStats[client].Jarated = results.FetchInt(34);
	TotalStats[client].MadMilked = results.FetchInt(35);
	TotalStats[client].Extinguished = results.FetchInt(36);
	TotalStats[client].PointsCaptured = results.FetchInt(37);
	TotalStats[client].PointsDefended = results.FetchInt(38);
	TotalStats[client].FlagsPickedUp = results.FetchInt(39);
	TotalStats[client].FlagsCaptured = results.FetchInt(40);
	TotalStats[client].FlagsStolen = results.FetchInt(41);
	TotalStats[client].FlagsDefended = results.FetchInt(42);
	TotalStats[client].Ubercharged = results.FetchInt(43);
	TotalStats[client].SandvichesStolen = results.FetchInt(44);
	TotalStats[client].PlayerTeleported = results.FetchInt(45);
	TotalStats[client].PlayersTeleported = results.FetchInt(46);
	TotalStats[client].StunnedPlayers = results.FetchInt(47);
	TotalStats[client].MoonShotStunnedPlayers = results.FetchInt(48);
	TotalStats[client].StunnedMonoculus = results.FetchInt(49);
	TotalStats[client].KilledMonoculus = results.FetchInt(50);
	TotalStats[client].StunnedMerasmus = results.FetchInt(51);
	TotalStats[client].KilledMerasmus = results.FetchInt(52);
	TotalStats[client].KilledHHH = results.FetchInt(53);
	TotalStats[client].TanksDestroyed = results.FetchInt(54);
	TotalStats[client].SentryBustersKilled = results.FetchInt(55);
	TotalStats[client].PassBallsGotten = results.FetchInt(56);
	TotalStats[client].PassBallsScored = results.FetchInt(57);
	TotalStats[client].PassBallsDropped = results.FetchInt(58);
	TotalStats[client].PassBallsCatched = results.FetchInt(59);
	TotalStats[client].PassBallsStolen = results.FetchInt(60);
	TotalStats[client].PassBallsBlocked = results.FetchInt(61);
	
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
	panel.Send(client, Panel_TotalStatisticsCallback, MENU_TIME_FOREVER);
	StatsPanel[client].TotalPage = page;
}