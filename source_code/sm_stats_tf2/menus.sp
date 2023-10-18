enum struct StatsMenuInfo
{
	int lol;
	
	void Main(int client)
	{
		if(!bLoaded)
		{
			CPrintToChat(client, "%s %T", core_chattag, "#SMStats_Error_NotInitialized", client);
			return;
		}
		else if(!sql)
		{
			CPrintToChat(client, "%s %T", core_chattag, "#SMStats_Error_SQLNotInitialized", client);
			return;
		}
		
		Panel panel = new Panel();
		panel.DrawItem("SourceMod Stats - " ... VersionAlt ... " by Teamkiller324 ( Work in progress )");
		
		PanelText(panel, "%T", "#SMStats_Menu_Playername", client, client);
		
		char country[64];
		GeoipCountryName(client, g_Player[client].ip, country, sizeof(country));
		PanelText(panel, "%T", "#SMStats_MenuInfo_Country", client, country);
		
		PanelText(panel, "%T\n ", "#SMStats_Menu_Positioned", client, (g_Player[client].position = GetClientPosition(g_Player[client].auth)), g_TotalTablePlayers);		
		PanelItem(panel, "%T"
		... "\n  > %T"
		... "\n "
		, "#SMStats_Menu_Session", client
		, "#SMStats_Menu_SessionInfo", client);
		PanelItem(panel, "%T"
		... "\n  > %T"
		... "\n  > %T"
		... "\n "
		, "#SMStats_Menu_ActiveStats", client
		, "#SMStats_Menu_ActiveStatsInfo", client
		, "#SMStats_FeatureUnavailable", client);
		PanelItem(panel, "%T"
		... "\n  > %T"
		... "\n "
		, "#SMStats_Menu_Top10", client
		, "#SMStats_Menu_Top10Info", client);
		PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		
		panel.Send(client, StatsMenu_Main, MENU_TIME_FOREVER);
		delete panel;
	}
	
	void Session(int client, int page=1)
	{
		Panel panel = new Panel();
		PanelItem(panel, "SourceMod Stats - " ... VersionAlt ... " > %T > %T"
		, "#SMStats_Menu_Session", client
		, "#SMStats_Menu_Page", client, page);
		
		switch(page)
		{
			case 1:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_PlayTime", client, g_Player[client].session[Stats_PlayTime]);
				switch(g_Player[client].session[Stats_Points] >= 0)
				{
					case false: PanelText(panel, "  %T", "#SMStats_MenuInfo_PointsLost", client, g_Player[client].session[Stats_Points]);
					case true: PanelText(panel, "  %T", "#SMStats_MenuInfo_PointsEarned", client, g_Player[client].session[Stats_Points]);
				}
				
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Frags", client, g_Player[client].session[Stats_Frags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Assists", client, g_Player[client].session[Stats_Assists]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Deaths", client, g_Player[client].session[Stats_Deaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Suicides", client, g_Player[client].session[Stats_Suicides]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_DamageDone", client, g_Player[client].session[Stats_DamageDone]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_AchievementsEarned", client, g_Player[client].session[Stats_Achievements]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			
			case 2:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Dominations", client, g_Player[client].session[Stats_Dominations]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Revenges", client, g_Player[client].session[Stats_Revenges]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Airshots", client, g_Player[client].session[Stats_Airshots]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Headshots", client, g_Player[client].session[Stats_Headshots]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Noscopes", client, g_Player[client].session[Stats_Noscopes]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Backstabs", client, g_Player[client].session[Stats_Backstabs]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TauntFrags", client, g_Player[client].session[Stats_TauntFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_GibFrags", client, g_Player[client].session[Stats_GibFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_DeflectFrags", client, g_Player[client].session[Stats_Deflects]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleFrags", client, g_Player[client].session[Stats_TeleFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Collaterals", client, g_Player[client].session[Stats_Collaterals]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MidAirFrags", client, g_Player[client].session[Stats_MidAirFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CritFrags", client, g_Player[client].session[Stats_CritFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MiniCritFrags", client, g_Player[client].session[Stats_MiniCritFrags]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			
			case 3:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Scout", client, g_Player[client].session[Stats_ScoutFrags], g_Player[client].session[Stats_ScoutDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Soldier", client, g_Player[client].session[Stats_SoldierFrags], g_Player[client].session[Stats_SoldierDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Pyro", client, g_Player[client].session[Stats_PyroFrags], g_Player[client].session[Stats_PyroDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Demoman", client, g_Player[client].session[Stats_DemoFrags], g_Player[client].session[Stats_DemoDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Heavy", client, g_Player[client].session[Stats_HeavyFrags], g_Player[client].session[Stats_HeavyDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Engineer", client, g_Player[client].session[Stats_EngieFrags], g_Player[client].session[Stats_EngieDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Medic", client, g_Player[client].session[Stats_MedicFrags], g_Player[client].session[Stats_MedicDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Sniper", client, g_Player[client].session[Stats_SniperFrags], g_Player[client].session[Stats_SniperDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Spy", client, g_Player[client].session[Stats_SpyFrags], g_Player[client].session[Stats_SpyDeaths]);			
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			
			case 4:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Buildings", client, g_Player[client].session[Stats_BuildingsPlaced], g_Player[client].session[Stats_BuildingsDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Dispenser", client, g_Player[client].session[Stats_DispensersPlaced], g_Player[client].session[Stats_DispensersDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_SentryGun", client, g_Player[client].session[Stats_SentryGunsPlaced], g_Player[client].session[Stats_SentryGunsDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleporterEntrance", client, g_Player[client].session[Stats_TeleporterEntrancesPlaced], g_Player[client].session[Stats_TeleporterEntrancesDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleporterExit", client, g_Player[client].session[Stats_TeleporterExitsPlaced], g_Player[client].session[Stats_TeleporterExitsDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MiniSentryGun", client, g_Player[client].session[Stats_MiniSentryGunsPlaced], g_Player[client].session[Stats_MiniSentryGunsDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Sapper", client, g_Player[client].session[Stats_SappersPlaced], g_Player[client].session[Stats_SappersDestroyed]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			
			case 5:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CP_Captured", client, g_Player[client].session[Stats_PointsCaptured]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CP_Defended", client, g_Player[client].session[Stats_PointsDefended]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Stolen", client, g_Player[client].session[Stats_FlagsStolen]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_PickedUp", client, g_Player[client].session[Stats_FlagsPickedUp]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Captured", client, g_Player[client].session[Stats_FlagsCaptured]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Defended", client, g_Player[client].session[Stats_FlagsDefended]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Dropped", client, g_Player[client].session[Stats_FlagsDropped]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			
			case 6:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleportersUsed", client, g_Player[client].session[Stats_TeleportersUsed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_PlayersTeleported", client, g_Player[client].session[Stats_PlayersTeleported]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CoatedMilk", client, g_Player[client].session[Stats_CoatedMilk]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CoatedPiss", client, g_Player[client].session[Stats_CoatedPiss]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Coated", client, g_Player[client].session[Stats_Coated]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Extinguished", client, g_Player[client].session[Stats_Extinguished]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Ignited", client, g_Player[client].session[Stats_Ignited]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Ubercharged", client, g_Player[client].session[Stats_Ubercharged]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_SandvichesStolen", client, g_Player[client].session[Stats_SandvichesStolen]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			
			case 7:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_Monoculus", client, g_Player[client].session[Stats_MonoculusFragged], g_Player[client].session[Stats_MonoculusStunned]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_Merasmus", client, g_Player[client].session[Stats_MerasmusFragged], g_Player[client].session[Stats_MerasmusStunned]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_HHH", client, g_Player[client].session[Stats_HHHFragged]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_SkeletonKing", client, g_Player[client].session[Stats_SkeletonKingsFragged]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			
			case 8:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MvM_TanksDestroyed", client, g_Player[client].session[Stats_TanksDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MvM_SentryBustersFragged", client, g_Player[client].session[Stats_SentryBustersFragged]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MvM_BombsResetted", client, g_Player[client].session[Stats_BombsResetted]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				//PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
		}
		
		panel.Send(client, StatsMenu_Session, MENU_TIME_FOREVER);
		delete panel;
	}
	
	void TopStats(int client, int display_at=0)
	{
		char[][] SteamID = new char[10][64];
		char[][] PlayerName = new char[10][64];
		int Points[10];
		int Players = 0;
		
		SQL_LockDatabase(sql);
		//char error[256];
		DBResultSet results = SQL_Query(sql, "SELECT PlayerName, SteamID, Points FROM `"... sql_table_playerlist ... "` ORDER BY `" ... sql_table_playerlist ..."`.`Points` DESC LIMIT 10");
		if(results == null)
		{
			SQL_UnlockDatabase(sql);
			delete results;
			CPrintToChat(client, "%s SQL Error parsing top 10 players", g_ChatTag);
			return;
		}
		
		while(results.FetchRow())
		{
			results.FetchString(0, PlayerName[Players], 64);
			results.FetchString(1, SteamID[Players], 64);
			Points[Players] = results.FetchInt(2);
			
			Players++
		}
		delete results;
		SQL_UnlockDatabase(sql);
		
		if(Players < 1)
		{
			CPrintToChat(client, "%s found no players on the leaderboard.", g_ChatTag);
			return;
		}
		
		Menu menu = new Menu(StatsMenu_TopStats);
		menu.SetTitle("SourceMod Stats - " ... VersionAlt ... " > %T", "#SMStats_Menu_Top10", client);
		
		for(int i = 0; i < Players; i++)
		{
			char dummy[96];
			Format(dummy, sizeof(dummy), "%T", "#SMStats_MenuInfo_TopPlayer", client, i+1, PlayerName[i], Points[i]);
			menu.AddItem(SteamID[i], dummy);
		}
		
		menu.ExitBackButton = true;
		menu.DisplayAt(client, display_at, MENU_TIME_FOREVER);
	}
	
	void TopStatsInfo(int client, int page=1, int top=10)
	{
		Panel panel = new Panel();
		PanelItem(panel, "SourceMod Stats - " ... VersionAlt ... " > %T > %s > %T"
		, "#SMStats_Menu_TopPlayer", client, top
		, g_Player[client].topstatsname
		, "#SMStats_Menu_Page", client, page);
		
		switch(page)
		{
			case 1:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_PlayTime", client, g_Player[client].topstats[Stats_PlayTime]);
				
				char country[64];
				GeoipCountryName(client, g_Player[client].topstatsip, country, sizeof(country));
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Country", client, country);
				
				switch(g_Player[client].topstats[Stats_Points] >= 0)
				{
					case false: PanelText(panel, "  %T", "#SMStats_MenuInfo_PointsLost", client, g_Player[client].topstats[Stats_Points]);
					case true: PanelText(panel, "  %T", "#SMStats_MenuInfo_PointsEarned", client, g_Player[client].topstats[Stats_Points]);
				}
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Frags", client, g_Player[client].topstats[Stats_Frags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Assists", client, g_Player[client].topstats[Stats_Assists]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Deaths", client, g_Player[client].topstats[Stats_Deaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Suicides", client, g_Player[client].topstats[Stats_Suicides]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_DamageDone", client, g_Player[client].topstats[Stats_DamageDone]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_AchievementsEarned", client, g_Player[client].topstats[Stats_Achievements]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			case 2:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Dominations", client, g_Player[client].topstats[Stats_Dominations]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Revenges", client, g_Player[client].topstats[Stats_Revenges]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Airshots", client, g_Player[client].topstats[Stats_Airshots]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Headshots", client, g_Player[client].topstats[Stats_Headshots]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Noscopes", client, g_Player[client].topstats[Stats_Noscopes]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Backstabs", client, g_Player[client].topstats[Stats_Backstabs]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TauntFrags", client, g_Player[client].topstats[Stats_TauntFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_GibFrags", client, g_Player[client].topstats[Stats_GibFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_DeflectFrags", client, g_Player[client].topstats[Stats_Deflects]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleFrags", client, g_Player[client].topstats[Stats_TeleFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Collaterals", client, g_Player[client].topstats[Stats_Collaterals]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MidAirFrags", client, g_Player[client].topstats[Stats_MidAirFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CritFrags", client, g_Player[client].topstats[Stats_CritFrags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MiniCritFrags", client, g_Player[client].topstats[Stats_MiniCritFrags]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			case 3:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Scout", client, g_Player[client].topstats[Stats_ScoutFrags], g_Player[client].topstats[Stats_ScoutDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Soldier", client, g_Player[client].topstats[Stats_SoldierFrags], g_Player[client].topstats[Stats_SoldierDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Pyro", client, g_Player[client].topstats[Stats_PyroFrags], g_Player[client].topstats[Stats_PyroDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Demoman", client, g_Player[client].topstats[Stats_DemoFrags], g_Player[client].topstats[Stats_DemoDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Heavy", client, g_Player[client].topstats[Stats_HeavyFrags], g_Player[client].topstats[Stats_HeavyDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Engineer", client, g_Player[client].topstats[Stats_EngieFrags], g_Player[client].topstats[Stats_EngieDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Medic", client, g_Player[client].topstats[Stats_MedicFrags], g_Player[client].topstats[Stats_MedicDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Sniper", client, g_Player[client].topstats[Stats_SniperFrags], g_Player[client].topstats[Stats_SniperDeaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Spy", client, g_Player[client].topstats[Stats_SpyFrags], g_Player[client].topstats[Stats_SpyDeaths]);			
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			case 4:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Buildings", client, g_Player[client].topstats[Stats_BuildingsPlaced], g_Player[client].topstats[Stats_BuildingsDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Dispenser", client, g_Player[client].topstats[Stats_DispensersPlaced], g_Player[client].topstats[Stats_DispensersDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_SentryGun", client, g_Player[client].topstats[Stats_SentryGunsPlaced], g_Player[client].topstats[Stats_SentryGunsDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleporterEntrance", client, g_Player[client].topstats[Stats_TeleporterEntrancesPlaced], g_Player[client].topstats[Stats_TeleporterEntrancesDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleporterExit", client, g_Player[client].topstats[Stats_TeleporterExitsPlaced], g_Player[client].topstats[Stats_TeleporterExitsDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MiniSentryGun", client, g_Player[client].topstats[Stats_MiniSentryGunsPlaced], g_Player[client].topstats[Stats_MiniSentryGunsDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Sapper", client, g_Player[client].topstats[Stats_SappersPlaced], g_Player[client].topstats[Stats_SappersDestroyed]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			case 5:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CP_Captured", client, g_Player[client].topstats[Stats_PointsCaptured]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CP_Defended", client, g_Player[client].topstats[Stats_PointsDefended]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Stolen", client, g_Player[client].topstats[Stats_FlagsStolen]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_PickedUp", client, g_Player[client].topstats[Stats_FlagsPickedUp]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Captured", client, g_Player[client].topstats[Stats_FlagsCaptured]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Defended", client, g_Player[client].topstats[Stats_FlagsDefended]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Dropped", client, g_Player[client].topstats[Stats_FlagsDropped]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			case 6:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleportersUsed", client, g_Player[client].topstats[Stats_TeleportersUsed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_PlayersTeleported", client, g_Player[client].topstats[Stats_PlayersTeleported]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CoatedMilk", client, g_Player[client].topstats[Stats_CoatedMilk]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_CoatedPiss", client, g_Player[client].topstats[Stats_CoatedPiss]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Coated", client, g_Player[client].topstats[Stats_Coated]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Extinguished", client, g_Player[client].topstats[Stats_Extinguished]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Ignited", client, g_Player[client].topstats[Stats_Ignited]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Ubercharged", client, g_Player[client].topstats[Stats_Ubercharged]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_SandvichesStolen", client, g_Player[client].topstats[Stats_SandvichesStolen]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			case 7:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_Monoculus", client, g_Player[client].topstats[Stats_MonoculusFragged], g_Player[client].topstats[Stats_MonoculusStunned]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_Merasmus", client, g_Player[client].topstats[Stats_MerasmusFragged], g_Player[client].topstats[Stats_MerasmusStunned]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_HHH", client, g_Player[client].topstats[Stats_HHHFragged]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_SkeletonKing", client, g_Player[client].topstats[Stats_SkeletonKingsFragged]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
			case 8:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MvM_TanksDestroyed", client, g_Player[client].topstats[Stats_TanksDestroyed]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MvM_SentryBustersFragged", client, g_Player[client].topstats[Stats_SentryBustersFragged]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_MvM_BombsResetted", client, g_Player[client].topstats[Stats_BombsResetted]);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
				//PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
				panel.DrawText(" ");
				PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
			}
		}
		
		panel.Send(client, StatsMenu_TopStatsInfo, MENU_TIME_FOREVER);
		delete panel;
	}
}

StatsMenuInfo StatsMenu;

int StatsMenu_Main(Menu menu, MenuAction action, int client, int select)
{
	/*
	 * Main page.
	 * 1: Menu title.
	 * 2: Session.
	 * 3: Active stats.
	 * 4: Top 10 players.
	 * 5: Close.
	 */
	switch(select)
	{
		case 1:
		{
			g_Player[client].active_page_session = -1;
			g_Player[client].active_page_topstats = -1;
			StatsMenu.Main(client);
		}
		case 2:
		{
			g_Player[client].active_page_session = 1;
			g_Player[client].active_page_topstats = -1;
			StatsMenu.Session(client, 1);
		}
		case 3:
		{
			g_Player[client].active_page_session = -1;
			g_Player[client].active_page_topstats = -1;
			StatsMenu.Main(client);
		}
		case 4:
		{
			g_Player[client].active_page_session = -1;
			g_Player[client].active_page_topstats = -1;
			StatsMenu.TopStats(client);
		}
		case 5:
		{
			g_Player[client].active_page_session = -1;
			g_Player[client].active_page_topstats = -1;
		}
	}
	
	return 0;
}

int StatsMenu_Session(Menu menu, MenuAction action, int client, int select)
{
	switch(g_Player[client].active_page_session)
	{
		case 1:
		{
			/*
			 * Session page 1
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			 
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = 1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 1);
				}
				case 2:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Main(client);
				}
				case 3:
				{
					g_Player[client].active_page_session = 2;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 2);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
				}
			}
		}
		
		case 2:
		{
			/*
			 * Session page 2
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = 2;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 2);
				}
				case 2:
				{
					g_Player[client].active_page_session = 1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 1);
				}
				case 3:
				{
					g_Player[client].active_page_session = 3;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 3);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
				}
			}
		}
		
		case 3:
		{
			/*
			 * Session page 3
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = 3;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 3);
				}
				case 2:
				{
					g_Player[client].active_page_session = 2;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 2);
				}
				case 3:
				{
					g_Player[client].active_page_session = 4;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 4);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
				}
			}
		}
		
		case 4:
		{
			/*
			 * Session page 4
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = 4;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 4);
				}
				case 2:
				{
					g_Player[client].active_page_session = 3;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 3);
				}
				case 3:
				{
					g_Player[client].active_page_session = 5;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 5);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
				}
			}
		}
		
		case 5:
		{
			/*
			 * Session page 5
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = 5;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 5);
				}
				case 2:
				{
					g_Player[client].active_page_session = 4;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 4);
				}
				case 3:
				{
					g_Player[client].active_page_session = 6;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 6);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
				}
			}
		}
		
		case 6:
		{
			/*
			 * Session page 6
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = 6;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 6);
				}
				case 2:
				{
					g_Player[client].active_page_session = 5;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 5);
				}
				case 3:
				{
					g_Player[client].active_page_session = 7;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 7);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
				}
			}
		}
		
		case 7:
		{
			/*
			 * Session page 7
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = 7;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 7);
				}
				case 2:
				{
					g_Player[client].active_page_session = 6;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 6);
				}
				case 3:
				{
					g_Player[client].active_page_session = 8;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 8);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
				}
			}
		}
		
		case 8:
		{
			/*
			 * Session page 8
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = 8;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 8);
				}
				case 2:
				{
					g_Player[client].active_page_session = 7;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 7);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
				}
			}
		}
	}
	
	return 0;
}

int StatsMenu_TopStats(Menu menu, MenuAction action, int client, int select)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			char auth[64];
			menu.GetItem(select, auth, sizeof(auth));
			
			if(strlen(auth) < 1)
			{
				CPrintToChat(client, "%s Encountered a problem reading steam id of the top player.", g_ChatTag);
				return 0;
			}
			
			SQL_LockDatabase(sql);
			
			char query[2048];
			Format(query, sizeof(query), "select "
			/* 0*/... "PlayerName,"
			/* 1*/... "IPAddress,"
			/* 2*/... "PlayTime,"
			/* 3*/... "Points,"
			/* 4*/... "Frags,"
			/* 5*/... "Assists,"
			/* 6*/... "Deaths,"
			/* 7*/... "Suicides,"
			/* 8*/... "DamageDone,"
			/* 9*/... "Achievements,"
			
			/*10*/... "Dominations,"
			/*11*/... "Revenges,"
			/*12*/... "Airshots,"
			/*13*/... "Headshots,"
			/*14*/... "Noscopes,"
			/*15*/... "Backstabs,"
			/*16*/... "TauntFrags,"
			/*17*/... "GibFrags,"
			/*18*/... "DeflectFrags,"
			/*19*/... "TeleFrags,"
			/*20*/... "Collaterals,"
			/*21*/... "MidAirFrags,"
			/*22*/... "CritFrags,"
			/*23*/... "MiniCritFrags,"
			
			/*24*/... "ScoutFrags,"
			/*25*/... "SoldierFrags,"
			/*26*/... "PyroFrags,"
			/*27*/... "DemoFrags,"
			/*28*/... "HeavyFrags,"
			/*29*/... "EngieFrags,"
			/*30*/... "MedicFrags,"
			/*31*/... "SniperFrags,"
			/*32*/... "SpyFrags,"
			/*33*/... "ScoutDeaths,"
			/*34*/... "SoldierDeaths,"
			/*35*/... "PyroDeaths,"
			/*36*/... "DemoDeaths,"
			/*37*/... "HeavyDeaths,"
			/*38*/... "EngieDeaths,"
			/*39*/... "MedicDeaths,"
			/*40*/... "SniperDeaths,"
			/*41*/... "SpyDeaths,"
			
			/*42*/... "BuildingsPlaced,"
			/*43*/... "DispensersPlaced,"
			/*44*/... "SentryGunsPlaced,"
			/*45*/... "TeleporterEntrancesPlaced,"
			/*46*/... "TeleporterExitsPlaced,"
			/*47*/... "MiniSentryGunsPlaced,"
			/*48*/... "SappersPlaced,"
			/*49*/... "BuildingsDestroyed,"
			/*50*/... "DispensersDestroyed,"
			/*51*/... "SentryGunsDestroyed,"
			/*52*/... "TeleporterEntrancesDestroyed,"
			/*53*/... "TeleporterExitsDestroyed,"
			/*54*/... "MiniSentryGunsDestroyed,"
			/*55*/... "SappersDestroyed,"
			
			/*56*/... "PointsCaptured,"
			/*57*/... "PointsDefended,"
			/*58*/... "FlagsPickedUp,"
			/*59*/... "FlagsCaptured,"
			/*60*/... "FlagsStolen,"
			/*61*/... "FlagsDefended,"
			/*62*/... "FlagsDropped,"
			
			/*63*/... "TeleportersUsed,"
			/*64*/... "PlayersTeleported,"
			/*65*/... "CoatedMilk,"
			/*66*/... "CoatedPiss,"
			/*67*/... "Coated,"
			/*68*/... "Extinguished,"
			/*XX*///... "Ignited,"
			/*69*/... "Ubercharged,"
			/*70*/... "SandvichesStolen,"
			
			/*71*/... "MonoculusStunned,"
			/*72*/... "MerasmusStunned,"
			/*73*/... "MonoculusFragged,"
			/*74*/... "MerasmusFragged,"
			/*75*/... "HHHFragged,"
			/*76*/... "SkeletonKingsFragged,"
			
			/*XX*///... "RobotsFragged,"
			/*77*/... "TanksDestroyed,"
			/*78*/... "SentryBustersFragged,"
			/*79*/... "BombsResetted"
			
			... " from `%s` where SteamID = '%s' and ServerID = %i"
			, sql_table_playerlist, auth, g_ServerID);
			DBResultSet results = SQL_Query(sql, query);
			switch(results != null && results.FetchRow())
			{
				case false:
				{
					SQL_UnlockDatabase(sql);
					delete results;
					
					char error[255];
					SQL_GetError(sql, error, sizeof(error));
					PrintToServer("%s Failed to query top 10 player\nError below:\n%s", core_chattag, error);
					
					CPrintToChat(client, "%s Failed to query information of the top player", g_ChatTag);
					return 0;
				}
				case true:
				{
					results.FetchString(0, g_Player[client].topstatsname, sizeof(g_Player[].topstatsname));
					results.FetchString(1, g_Player[client].topstatsip, sizeof(g_Player[].topstatsip));
					g_Player[client].topstats[Stats_PlayTime] = results.FetchInt(2);
					g_Player[client].topstats[Stats_Points] = results.FetchInt(3);
					g_Player[client].topstats[Stats_Frags] = results.FetchInt(4);
					g_Player[client].topstats[Stats_Assists] = results.FetchInt(5);
					g_Player[client].topstats[Stats_Deaths] = results.FetchInt(6);
					g_Player[client].topstats[Stats_Suicides] = results.FetchInt(7);
					g_Player[client].topstats[Stats_DamageDone] = results.FetchInt(8);
					g_Player[client].topstats[Stats_Achievements] = results.FetchInt(9);
					
					g_Player[client].topstats[Stats_Dominations] = results.FetchInt(10);
					g_Player[client].topstats[Stats_Revenges] = results.FetchInt(11);
					g_Player[client].topstats[Stats_Airshots] = results.FetchInt(12);
					g_Player[client].topstats[Stats_Headshots] = results.FetchInt(13);
					g_Player[client].topstats[Stats_Noscopes] = results.FetchInt(14);
					g_Player[client].topstats[Stats_Backstabs] = results.FetchInt(15);
					g_Player[client].topstats[Stats_TauntFrags] = results.FetchInt(16);
					g_Player[client].topstats[Stats_GibFrags] = results.FetchInt(17);
					g_Player[client].topstats[Stats_Deflects] = results.FetchInt(18);
					g_Player[client].topstats[Stats_TeleFrags] = results.FetchInt(19);
					g_Player[client].topstats[Stats_Collaterals] = results.FetchInt(20);
					g_Player[client].topstats[Stats_MidAirFrags] = results.FetchInt(21);
					g_Player[client].topstats[Stats_CritFrags] = results.FetchInt(22);
					g_Player[client].topstats[Stats_MiniCritFrags] = results.FetchInt(23);
					
					g_Player[client].topstats[Stats_ScoutFrags] = results.FetchInt(24);
					g_Player[client].topstats[Stats_SoldierFrags] = results.FetchInt(25);
					g_Player[client].topstats[Stats_PyroFrags] = results.FetchInt(26);
					g_Player[client].topstats[Stats_DemoFrags] = results.FetchInt(27);
					g_Player[client].topstats[Stats_HeavyFrags] = results.FetchInt(28);
					g_Player[client].topstats[Stats_EngieFrags] = results.FetchInt(29);
					g_Player[client].topstats[Stats_MedicFrags] = results.FetchInt(30);
					g_Player[client].topstats[Stats_SniperFrags] = results.FetchInt(31);
					g_Player[client].topstats[Stats_SpyFrags] = results.FetchInt(32);
					g_Player[client].topstats[Stats_ScoutDeaths] = results.FetchInt(33);
					g_Player[client].topstats[Stats_SoldierDeaths] = results.FetchInt(34);
					g_Player[client].topstats[Stats_PyroDeaths] = results.FetchInt(35);
					g_Player[client].topstats[Stats_DemoDeaths] = results.FetchInt(36);
					g_Player[client].topstats[Stats_HeavyDeaths] = results.FetchInt(37);
					g_Player[client].topstats[Stats_EngieDeaths] = results.FetchInt(38);
					g_Player[client].topstats[Stats_MedicDeaths] = results.FetchInt(39);
					g_Player[client].topstats[Stats_SniperDeaths] = results.FetchInt(40);
					g_Player[client].topstats[Stats_SpyDeaths] = results.FetchInt(41);
					
					g_Player[client].topstats[Stats_BuildingsPlaced] = results.FetchInt(42);
					g_Player[client].topstats[Stats_DispensersPlaced] = results.FetchInt(43);
					g_Player[client].topstats[Stats_SentryGunsPlaced] = results.FetchInt(44);
					g_Player[client].topstats[Stats_TeleporterEntrancesPlaced] = results.FetchInt(45);
					g_Player[client].topstats[Stats_TeleporterExitsPlaced] = results.FetchInt(46);
					g_Player[client].topstats[Stats_MiniSentryGunsPlaced] = results.FetchInt(47);
					g_Player[client].topstats[Stats_SappersPlaced] = results.FetchInt(48);
					g_Player[client].topstats[Stats_BuildingsDestroyed] = results.FetchInt(49);
					g_Player[client].topstats[Stats_DispensersDestroyed] = results.FetchInt(50);
					g_Player[client].topstats[Stats_SentryGunsDestroyed] = results.FetchInt(51);
					g_Player[client].topstats[Stats_TeleporterEntrancesDestroyed] = results.FetchInt(52);
					g_Player[client].topstats[Stats_TeleporterExitsDestroyed] = results.FetchInt(53);
					g_Player[client].topstats[Stats_MiniSentryGunsDestroyed] = results.FetchInt(54);
					g_Player[client].topstats[Stats_SappersDestroyed] = results.FetchInt(55);
					
					g_Player[client].topstats[Stats_PointsCaptured] = results.FetchInt(56);
					g_Player[client].topstats[Stats_PointsDefended] = results.FetchInt(57);
					g_Player[client].topstats[Stats_FlagsPickedUp] = results.FetchInt(58);
					g_Player[client].topstats[Stats_FlagsCaptured] = results.FetchInt(59);
					g_Player[client].topstats[Stats_FlagsStolen] = results.FetchInt(60);
					g_Player[client].topstats[Stats_FlagsDefended] = results.FetchInt(61);
					g_Player[client].topstats[Stats_FlagsDropped] = results.FetchInt(62);
					
					g_Player[client].topstats[Stats_TeleportersUsed] = results.FetchInt(63);
					g_Player[client].topstats[Stats_PlayersTeleported] = results.FetchInt(64);
					g_Player[client].topstats[Stats_CoatedMilk] = results.FetchInt(65);
					g_Player[client].topstats[Stats_CoatedPiss] = results.FetchInt(66);
					g_Player[client].topstats[Stats_Coated] = results.FetchInt(67);
					g_Player[client].topstats[Stats_Extinguished] = results.FetchInt(68);
					//g_Player[client].topstats[Stats_Ignited] = results.FetchInt(XX);
					g_Player[client].topstats[Stats_Ubercharged] = results.FetchInt(69);
					g_Player[client].topstats[Stats_SandvichesStolen] = results.FetchInt(70);
					
					g_Player[client].topstats[Stats_MonoculusStunned] = results.FetchInt(71);
					g_Player[client].topstats[Stats_MerasmusStunned] = results.FetchInt(72);
					g_Player[client].topstats[Stats_MonoculusFragged] = results.FetchInt(73);
					g_Player[client].topstats[Stats_MerasmusFragged] = results.FetchInt(74);
					g_Player[client].topstats[Stats_HHHFragged] = results.FetchInt(75);
					g_Player[client].topstats[Stats_SkeletonKingsFragged] = results.FetchInt(76);
					
					//g_Player[client].topstats[Stats_RobotsFragged] = results.FetchInt(XX);
					g_Player[client].topstats[Stats_TanksDestroyed] = results.FetchInt(77);
					g_Player[client].topstats[Stats_SentryBustersFragged] = results.FetchInt(78);
					g_Player[client].topstats[Stats_BombsResetted] = results.FetchInt(79);
					
					//
					
					g_Player[client].active_page_menu = menu.Selection;
					g_Player[client].active_page_topstats = 1;
					g_Player[client].toppos = select+1;
					StatsMenu.TopStatsInfo(client, 1, g_Player[client].toppos);
				}
			}
			
			delete results;
			SQL_UnlockDatabase(sql);
		}
		case MenuAction_Cancel:
		{
			if(select == MenuCancel_ExitBack)
			{
				StatsMenu.Main(client);
			}
		}
		case MenuAction_End: delete menu;
	}
	
	return 0;
}

int StatsMenu_TopStatsInfo(Menu menu, MenuAction action, int client, int select)
{
	switch(g_Player[client].active_page_topstats)
	{
		case 1:
		{
			/*
			 * Top player page 1
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			 
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 1;
					StatsMenu.TopStatsInfo(client, 1, g_Player[client].toppos);
				}
				case 2:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.TopStats(client, g_Player[client].active_page_menu);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 2;
					StatsMenu.TopStatsInfo(client, 2, g_Player[client].toppos);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].ResetTopStats();
				}
			}
		}
		
		case 2:
		{
			/*
			 * Top player page 2
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 2;
					StatsMenu.TopStatsInfo(client, 2, g_Player[client].toppos);
				}
				case 2:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 1;
					StatsMenu.TopStatsInfo(client, 1, g_Player[client].toppos);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 3;
					StatsMenu.TopStatsInfo(client, 3, g_Player[client].toppos);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].ResetTopStats();
				}
			}
		}
		
		case 3:
		{
			/*
			 * Top player page 3
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 3;
					StatsMenu.TopStatsInfo(client, 3, g_Player[client].toppos);
				}
				case 2:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 2;
					StatsMenu.TopStatsInfo(client, 2, g_Player[client].toppos);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 4;
					StatsMenu.TopStatsInfo(client, 4, g_Player[client].toppos);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].ResetTopStats();
				}
			}
		}
		
		case 4:
		{
			/*
			 * Top player page 4
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 4;
					StatsMenu.TopStatsInfo(client, 4, g_Player[client].toppos);
				}
				case 2:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 3;
					StatsMenu.TopStatsInfo(client, 3, g_Player[client].toppos);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 5;
					StatsMenu.TopStatsInfo(client, 5, g_Player[client].toppos);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].ResetTopStats();
				}
			}
		}
		
		case 5:
		{
			/*
			 * Top player page 5
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 5;
					StatsMenu.TopStatsInfo(client, 5, g_Player[client].toppos);
				}
				case 2:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 4;
					StatsMenu.TopStatsInfo(client, 4, g_Player[client].toppos);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 6;
					StatsMenu.TopStatsInfo(client, 6, g_Player[client].toppos);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].ResetTopStats();
				}
			}
		}
		
		case 6:
		{
			/*
			 * Top player page 6
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 6;
					StatsMenu.TopStatsInfo(client, 6, g_Player[client].toppos);
				}
				case 2:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 5;
					StatsMenu.TopStatsInfo(client, 5, g_Player[client].toppos);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 7;
					StatsMenu.TopStatsInfo(client, 7, g_Player[client].toppos);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].ResetTopStats();
				}
			}
		}
		
		case 7:
		{
			/*
			 * Top player page 7
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 7;
					StatsMenu.TopStatsInfo(client, 7, g_Player[client].toppos);
				}
				case 2:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 6;
					StatsMenu.TopStatsInfo(client, 6, g_Player[client].toppos);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 8;
					StatsMenu.TopStatsInfo(client, 8, g_Player[client].toppos);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].ResetTopStats();
				}
			}
		}
		
		case 8:
		{
			/*
			 * Top player page 8
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 8;
					StatsMenu.TopStatsInfo(client, 8, g_Player[client].toppos);
				}
				case 2:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 7;
					StatsMenu.TopStatsInfo(client, 7, g_Player[client].toppos);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
					g_Player[client].ResetTopStats();
				}
			}
		}
	}
	
	return 0;
}

/* =================================================== */

void LoadMenus()
{
	for(int i = 0; i < sizeof(str_cmdMenu); i++)
	{
		RegConsoleCmd(str_cmdMenu[i], StatsMenuCmd, "SM Stats: TF2 - Statistical menu.");
	}
}

Action StatsMenuCmd(int client, int args)
{
	switch(client == 0)
	{
		case false: StatsMenu.Main(client);
		case true: ReplyToCommand(client, "[SM Stats: TF2] This command may only be used in-game!");
	}
	
	return Plugin_Handled;
}

/* =================================================== */