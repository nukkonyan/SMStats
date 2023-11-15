enum struct StatsMenuInfo
{
	int lol;
	
	void Main(int client, int page=1)
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
		
		char country[64], map_time[128];
		GeoipCountryName(client, g_Player[client].ip, country, sizeof(country));
		GetTimeFormat(client, iMapTimerSeconds, map_time, sizeof(map_time));
		
		// needs to be updated to not lag out the server, because of direct-sql query.
		// doing direct-sql will make the proceeding actions wait for the query to finish.
		/*
		if(!g_Player[client].bMenuCheckPosition)
		{
			g_Player[client].position = GetClientPosition(g_Player[client].auth);
			g_Player[client].bMenuCheckPosition = true; // avoid sql overload.
		}
		*/
		
		Panel panel = new Panel();
		panel.DrawItem("SourceMod Stats - "...VersionAlt..." by Teamkiller324 ( Work in progress )");
		
		switch(IsValidDeveloperType(client))
		{
			case 1: PanelText(panel, "%T\n ", "#SMStats_MenuInfo_DevType_Founder", client);
			case 2: PanelText(panel, "%T\n ", "#SMStats_MenuInfo_DevType_Contributor", client);
			case 3: PanelText(panel, "%T\n ", "#SMStats_MenuInfo_DevType_Tester", client);
			case 4: PanelText(panel, "%T\n ", "#SMStats_MenuInfo_DevType_Translator", client);
		}
		PanelText(panel, "%T", "#SMStats_MenuInfo_Playername", client, client);
		PanelText(panel, "%T", "#SMStats_MenuInfo_Country", client, country);
		PanelText(panel, "%T", "#SMStats_MenuInfo_MapTime", client, map_time);
		PanelText(panel, "%T\n ", "#SMStats_MenuInfo_Positioned", client, g_Player[client].position, g_TotalTablePlayers);		
		
		switch(page)
		{
			case 1:
			{
				PanelItem(panel, "%T\n  > %T\n "
				, "#SMStats_Menu_Session", client
				, "#SMStats_Menu_SessionInfo", client);
				PanelItem(panel, "%T\n  > %T\n "
				, "#SMStats_Menu_ActiveStats", client
				, "#SMStats_Menu_ActiveStatsInfo", client);
				PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
			}
			case 2:
			{
				PanelItem(panel, "%T\n  > %T\n "
				, "#SMStats_Menu_Top10", client
				, "#SMStats_Menu_Top10Info", client);
				PanelItem(panel, "%T\n  > %T\n "
				, "#SMStats_Menu_Settings", client
				, "#SMStats_Menu_SettingsInfo", client)
				PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
			}
		}
		
		panel.DrawText(" ");
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
		
		TF2_GetStatisticalInformation(panel, client, page, g_Player[client].session, _, g_Player[client].bPenalty);
		
		panel.Send(client, StatsMenu_Session, MENU_TIME_FOREVER);
		delete panel;
	}
	
	void ActiveStats(int client)
	{
		char query[256];
		Format(query, sizeof(query), "select `SteamID`,`PlayerName`,`IPAddress`,`Penalty` from `"...sql_table_settings..."` where SteamID = '%s'", g_Player[client].auth);
		sql.Query(DBQuery_CheckActiveStats_1, query, GetClientUserId(client));
	}
	
	void ActiveStatsInfo(int client, int page=1)
	{
		Panel panel = new Panel();
		PanelItem(panel, "SourceMod Stats - " ... VersionAlt ... " > %T > %T"
		, "#SMStats_Menu_ActiveStats", client
		, "#SMStats_Menu_Page", client, page);
		
		TF2_GetStatisticalInformation(panel, client, page, g_Player[client].menustats, _, g_Player[client].menustats_penalty);
		
		panel.Send(client, StatsMenu_ActiveStatsInfo, MENU_TIME_FOREVER);
		delete panel;
	}
	
	void TopStats(int client, int display_at=0)
	{
		DataPack pack = new DataPack();
		pack.WriteCell(GetClientUserId(client));
		pack.WriteCell(display_at);
		pack.Reset();
		sql.Query(DBQuery_TopStats_1, "select `LastConnectedName`,`SteamID`,`Points` from `"...sql_table_playerlist..."` order by `Points` desc limit 10", pack);
		
		/*
		char[][] SteamID = new char[10][64];
		char[][] PlayerName = new char[10][64];
		int Points[10];
		int Players = 0;
		
		char error[256];
		SQL_LockDatabase(sql);
		DBResultSet results = SQL_Query(sql, "select `LastConnectedName`,`SteamID`,`Points` from `"...sql_table_playerlist..."` order by `"...sql_table_playerlist..."`.`Points` desc limit 10");
		SQL_UnlockDatabase(sql);
		if(results == null)
		{
			delete results;
			
			SQL_GetError(sql, error, sizeof(error));
			PrintToServer("Failed parsing steamids\nError below:\n%s", error);
			
			CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_ErrorParsing", client);
			return;
		}
		
		while(results.FetchRow())
		{
			results.FetchString(0, PlayerName[Players], 28);
			results.FetchString(1, SteamID[Players], 64);
			Points[Players] = results.FetchInt(2);
			Players++
		}
		
		if(Players < 1)
		{
			CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_NoPlayers", client);
			return;
		}
		
		Menu menu = new Menu(StatsMenu_TopStats);
		menu.SetTitle("SourceMod Stats - " ... VersionAlt ... " > %T", "#SMStats_Menu_Top10", client);
		
		for(int i = 0; i < Players; i++)
		{
			char dummy[96], points_plural[32];
			PointsPluralSplitter(client, Points[i], points_plural, sizeof(points_plural));
			Format(dummy, sizeof(dummy), "%T", "#SMStats_MenuInfo_TopPlayer", client, i+1, PlayerName[i], points_plural);
			menu.AddItem(SteamID[i], dummy);
		}
		
		menu.ExitBackButton = true;
		menu.DisplayAt(client, display_at, MENU_TIME_FOREVER);
		*/
	}
	
	void TopStatsInfo(int client, int page=1, int top=10)
	{
		Panel panel = new Panel();
		PanelItem(panel, "SourceMod Stats - " ... VersionAlt ... " > %T > %s > %T"
		, "#SMStats_Menu_TopPlayer", client, top
		, g_Player[client].menustats_name
		, "#SMStats_Menu_Page", client, page);
		
		TF2_GetStatisticalInformation(panel, client, page, g_Player[client].menustats, true, g_Player[client].menustats_penalty);
		
		panel.Send(client, StatsMenu_TopStatsInfo, MENU_TIME_FOREVER);
		delete panel;
	}
	
	void TopPlayerId(int client, int top_player_id)
	{
		g_Player[client].menustats_pos = top_player_id;
		char query[255];
		Format(query, sizeof(query), "select SteamID from `"... sql_table_playerlist ... "` order by `Points` desc");
		sql.Query(StatsMenu_TopPlayerId_1, query, GetClientUserId(client));
	}
	
	void TopPlayerAuth(int client, const char[] auth)
	{
		char query[255];
		Format(query, sizeof(query), "select SteamID from `"... sql_table_playerlist..."` order by `Points` desc");
		DataPack pack = new DataPack();
		pack.WriteCell(GetClientUserId(client));
		pack.WriteCell(strlen(auth)+1);
		pack.WriteString(auth);
		pack.Reset();
		sql.Query(StatsMenu_TopPlayerAuth_1, query, pack);
	}
	
	void Settings(int client, int display_at=0)
	{
		Menu menu = new Menu(StatsMenu_Settings);
		menu.SetTitle("SourceMod Stats - " ... VersionAlt ... " > %T", "#SMStats_Menu_Settings", client);
		
		char dummy[96];
		OnOffPluralSplitter(client, g_Player[client].bPlayConSnd, dummy, sizeof(dummy));
		Format(dummy, sizeof(dummy), "%T", "#SMStats_MenuInfo_PlayConnectSnd", client, dummy);
		menu.AddItem("0", dummy);
		
		OnOffPluralSplitter(client, g_Player[client].bShowConMsg, dummy, sizeof(dummy));
		Format(dummy, sizeof(dummy), "%T", "#SMStats_MenuInfo_ShowConnectMsg", client, dummy);
		menu.AddItem("1", dummy);
		
		OnOffPluralSplitter(client, g_Player[client].bShowTopConMsg, dummy, sizeof(dummy));
		Format(dummy, sizeof(dummy), "%T", "#SMStats_MenuInfo_ShowTopConnectMsg", client, dummy);
		menu.AddItem("2", dummy);
		
		OnOffPluralSplitter(client, g_Player[client].bShowFragMsg, dummy, sizeof(dummy));
		Format(dummy, sizeof(dummy), "%T", "#SMStats_MenuInfo_ShowFragMsg", client, dummy);
		menu.AddItem("3", dummy);
		
		OnOffPluralSplitter(client, g_Player[client].bShowAssistMsg, dummy, sizeof(dummy));
		Format(dummy, sizeof(dummy), "%T", "#SMStats_MenuInfo_ShowAssistMsg", client, dummy);
		menu.AddItem("4", dummy);
		
		OnOffPluralSplitter(client, g_Player[client].bShowDeathMsg, dummy, sizeof(dummy));
		Format(dummy, sizeof(dummy), "%T", "#SMStats_MenuInfo_ShowDeathMsg", client, dummy);
		menu.AddItem("5", dummy);
		
		menu.ExitButton = true;
		menu.ExitBackButton = true;
		menu.DisplayAt(client, display_at, MENU_TIME_FOREVER);
	}
}

StatsMenuInfo StatsMenu;

int StatsMenu_Main(Menu menu, MenuAction action, int client, int select)
{
	switch(g_Player[client].active_page_mainmenu)
	{
		case 1:
		{
			/*
			 * Main page.
			 * 1: Menu title.
			 * 2: Session.
			 * 3: Active stats.
			 * 4: Next page
			 * 5: Close.
			 */
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = 1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Main(client, 1);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					g_Player[client].bMenuCheckPosition = false;
					StatsMenu.Session(client, 1);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 1;
					g_Player[client].active_page_topstats = -1;
					g_Player[client].bMenuCheckPosition = false;
					StatsMenu.ActiveStats(client);
				}
				case 4:
				{
					g_Player[client].active_page_mainmenu = 2;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
					g_Player[client].bMenuCheckPosition = false;
					StatsMenu.Main(client, 2);
				}
				case 5:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					g_Player[client].bMenuCheckPosition = false;
				}
			}
		}
		
		case 2:
		{
			/*
			 * Main page.
			 * 1: Menu title.
			 * 2: Top 10 player stats.
			 * 3: Settings.
			 * 4: Previous page.
			 * 5: Close.
			 */
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = 1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Main(client, 1);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
					g_Player[client].bMenuCheckPosition = false;
					StatsMenu.TopStats(client);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
					g_Player[client].bMenuCheckPosition = false;
					StatsMenu.Settings(client);
				}
				case 4:
				{
					g_Player[client].active_page_mainmenu = 1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
					g_Player[client].bMenuCheckPosition = false;
					StatsMenu.Main(client, 1);
				}
				case 5:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = -1;
					g_Player[client].bMenuCheckPosition = false;
				}
			}
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 1);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = 1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Main(client);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 2;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 2);
				}
				case 4: g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 2;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 2);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 1);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 3;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 3);
				}
				case 4: g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 3;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 3);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 2;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 2);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 4;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 4);
				}
				case 4: g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 4;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 4);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 3;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 3);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 5;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 5);
				}
				case 4: g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 5;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 5);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 4;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 4);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 6;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 6);
				}
				case 4: g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 6;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 6);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 5;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 5);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 7;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 7);
				}
				case 4: g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 7;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 7);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 6;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 6);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 8;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 8);
				}
				case 4: g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 8;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 8);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = 7;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Session(client, 7);
				}
				case 3: g_Player[client].ResetMenuStats();
			}
		}
	}
	
	return 0;
}

int StatsMenu_ActiveStatsInfo(Menu menu, MenuAction action, int client, int select)
{
	switch(g_Player[client].active_page_activestats)
	{
		case 1:
		{
			/*
			 * Active stats page 1
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 1);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = 1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.Main(client, g_Player[client].active_page_menu);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 2;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 2);
				}
				case 4: g_Player[client].ResetMenuStats();
			}
		}
		
		case 2:
		{
			/*
			 * Active stats 2
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 2;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 2);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 1);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 3;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 3);
				}
				case 4: g_Player[client].ResetMenuStats();
			}
		}
		
		case 3:
		{
			/*
			 * Active stats page 3
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 3;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 3);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 2;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 2);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 4;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 4);
				}
				case 4: g_Player[client].ResetMenuStats();
			}
		}
		
		case 4:
		{
			/*
			 * Active stats page 4
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 4;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 4);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 3;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 3);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 5;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 5);
				}
				case 4: g_Player[client].ResetMenuStats();
			}
		}
		
		case 5:
		{
			/*
			 * Active stats page 5
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 5;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 5);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 4;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 4);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_topstats = 6;
					StatsMenu.ActiveStatsInfo(client, 6);
				}
				case 4: g_Player[client].ResetMenuStats();
			}
		}
		
		case 6:
		{
			/*
			 * Active stats page 6
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 6;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 6);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 5;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 5);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 7;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 7);
				}
				case 4: g_Player[client].ResetMenuStats();
			}
		}
		
		case 7:
		{
			/*
			 * Active stats page 7
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Next page.
			 * 4 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 7;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 7);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 6;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 6);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 8;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 8);
				}
				case 4: g_Player[client].ResetMenuStats();
			}
		}
		
		case 8:
		{
			/*
			 * Active stats page 8
			 * 1 : Menu title.
			 * 2 : Previous page.
			 * 3 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 8;
					g_Player[client].active_page_topstats = 8;
					StatsMenu.ActiveStatsInfo(client, 8);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = 7;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.ActiveStatsInfo(client, 7);
				}
				case 3: g_Player[client].ResetMenuStats();
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
			
			g_Player[client].menustats_pos = select+1;
			
			char query[256];
			Format(query, sizeof(query), "select `SteamID`,`PlayerName`,`IPAddress`,`Penalty` from `"...sql_table_settings..."` where SteamID = '%s'", auth);
			sql.Query(DBQuery_TopStats_Menu_1, query, GetClientUserId(client));
		}
		case MenuAction_Cancel:
		{
			if(select == MenuCancel_ExitBack)
			{
				g_Player[client].active_page_mainmenu = 2;
				StatsMenu.Main(client, 2);
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
			 * 2 : Visit profile.
			 * 3 : Previous page.
			 * 4 : Next page.
			 * 5 : Exit.
			 */
			
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 1;
					StatsMenu.TopStatsInfo(client, 1, g_Player[client].menustats_pos);
				}
				/*
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 1;
					StatsMenu.TopStatsInfo(client, 1, g_Player[client].menustats_pos);
					
					//char profile[128];
					//Format(profile, sizeof(profile), "https://steamcommunity.com/profiles/%i");
					//ShowMOTDPanel(client, core_chattag2, profile, MOTDPANEL_TYPE_URL);
					//PrintToServer(profile);
				}
				*/
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = -1;
					StatsMenu.TopStats(client, g_Player[client].active_page_menu);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 2;
					StatsMenu.TopStatsInfo(client, 2, g_Player[client].menustats_pos);
				}
				case 4:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 2;
					StatsMenu.TopStatsInfo(client, 2, g_Player[client].menustats_pos);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 1;
					StatsMenu.TopStatsInfo(client, 1, g_Player[client].menustats_pos);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 3;
					StatsMenu.TopStatsInfo(client, 3, g_Player[client].menustats_pos);
				}
				case 4:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 3;
					StatsMenu.TopStatsInfo(client, 3, g_Player[client].menustats_pos);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 2;
					StatsMenu.TopStatsInfo(client, 2, g_Player[client].menustats_pos);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 4;
					StatsMenu.TopStatsInfo(client, 4, g_Player[client].menustats_pos);
				}
				case 4:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 4;
					StatsMenu.TopStatsInfo(client, 4, g_Player[client].menustats_pos);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 3;
					StatsMenu.TopStatsInfo(client, 3, g_Player[client].menustats_pos);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 5;
					StatsMenu.TopStatsInfo(client, 5, g_Player[client].menustats_pos);
				}
				case 4:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 5;
					StatsMenu.TopStatsInfo(client, 5, g_Player[client].menustats_pos);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 4;
					StatsMenu.TopStatsInfo(client, 4, g_Player[client].menustats_pos);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 6;
					StatsMenu.TopStatsInfo(client, 6, g_Player[client].menustats_pos);
				}
				case 4:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 6;
					StatsMenu.TopStatsInfo(client, 6, g_Player[client].menustats_pos);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 5;
					StatsMenu.TopStatsInfo(client, 5, g_Player[client].menustats_pos);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 7;
					StatsMenu.TopStatsInfo(client, 7, g_Player[client].menustats_pos);
				}
				case 4:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 7;
					StatsMenu.TopStatsInfo(client, 7, g_Player[client].menustats_pos);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 6;
					StatsMenu.TopStatsInfo(client, 6, g_Player[client].menustats_pos);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 8;
					StatsMenu.TopStatsInfo(client, 8, g_Player[client].menustats_pos);
				}
				case 4:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].ResetMenuStats();
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
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 8;
					StatsMenu.TopStatsInfo(client, 8, g_Player[client].menustats_pos);
				}
				case 2:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].active_page_topstats = 7;
					StatsMenu.TopStatsInfo(client, 7, g_Player[client].menustats_pos);
				}
				case 3:
				{
					g_Player[client].active_page_mainmenu = -1;
					g_Player[client].active_page_session = -1;
					g_Player[client].active_page_activestats = -1;
					g_Player[client].ResetMenuStats();
				}
			}
		}
	}
	
	return 0;
}

void StatsMenu_TopPlayerId_1(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		return;
	}
	
	int Players = 0;
	if(results == null)
	{
		delete results;
		CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_ErrorParsing", client);
		return;
	}
	
	int top_player_id = g_Player[client].menustats_pos;
	
	char auth[64];
	while(results.FetchRow())
	{
		Players++
		
		if(Players == top_player_id)
		{
			results.FetchString(0, auth, sizeof(auth));
			break;
		}
	}
	
	if(Players < 1)
	{
		CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_NoPlayers", client);
		return;
	}
	
	char query[256];
	Format(query, sizeof(query), "select `SteamID`,`PlayerName`,`IPAddress`,`Penalty` from `"...sql_table_settings..."` where SteamID = '%s'", auth);
	sql.Query(StatsMenu_TopPlayerId_2, query, GetClientUserId(client));
}

void StatsMenu_TopPlayerId_2(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		if(results != null && results.FetchRow())
		{
			char auth[28];
			results.FetchString(0, auth, sizeof(auth));
			results.FetchString(1, g_Player[client].menustats_name, sizeof(g_Player[].menustats_name));
			results.FetchString(2, g_Player[client].menustats_ip, sizeof(g_Player[].menustats_ip));
			g_Player[client].menustats_penalty = view_as<bool>(results.FetchInt(3));
			
			char query[256];
			Format(query, sizeof(query), "select * from `"...sql_table_playerlist..."` where `SteamID`='%s' and `StatsID` = %i", auth, g_StatsID);
			sql.Query(StatsMenu_TopPlayerId_3, query, userid);
		}
		else
		{
			CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_TopPlayerIdDoesNotExist", client, g_Player[client].menustats_pos);
		}
	}
}

void StatsMenu_TopPlayerId_3(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		if(results != null && results.FetchRow())
		{
			g_Player[client].menustats_lastconnected = GetFieldValue(results, "LastConnectedTime");
			GetPlayerlistStats(results, g_Player[client].menustats);
			
			g_Player[client].active_page_mainmenu = -1;
			g_Player[client].active_page_session = -1;
			g_Player[client].active_page_activestats = -1;
			g_Player[client].active_page_topstats = 1;
			StatsMenu.TopStatsInfo(client, 1, g_Player[client].menustats_pos);
		}
		else
		{
			CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_TopPlayerIdDoesNotExist", client, g_Player[client].menustats_pos);
		}
	}
}

void StatsMenu_TopPlayerAuth_1(Database database, DBResultSet results, const char[] error, DataPack pack)
{
	int userid = pack.ReadCell();
	int maxlen = pack.ReadCell();
	char[] auth = new char[maxlen];
	pack.ReadString(auth, maxlen);
	delete pack;
	
	int client;
	if(!IsValidClient((client = GetClientOfUserId(userid))))
	{
		return;
	}
	
	if(results == null)
	{
		delete results;
		CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_ErrorParsing", client);
		return;
	}
	
	int top_player_id;
	int Players = 0;
	
	while(results.FetchRow())
	{
		Players++
		
		char SteamID[64];
		results.FetchString(0, SteamID, sizeof(SteamID));
		if(StrEqual(SteamID, auth, false))
		{
			top_player_id = Players;
			break;
		}
	}
	
	if(Players < 1)
	{
		CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_NoPlayers", client);
		return;
	}
	
	g_Player[client].menustats_pos = top_player_id;
	strcopy(g_Player[client].menustats_auth, sizeof(g_Player[].menustats_auth), auth);
	
	char query[256];
	Format(query, sizeof(query), "select `SteamID`,`PlayerName`,`IPAddress`,`Penalty` from `"...sql_table_settings..."` where SteamID = '%s'", auth);
	sql.Query(StatsMenu_TopPlayerAuth_2, query, GetClientUserId(userid));
}

void StatsMenu_TopPlayerAuth_2(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		if(results != null && results.FetchRow())
		{
			char auth[28];
			results.FetchString(0, auth, sizeof(auth));
			results.FetchString(1, g_Player[client].menustats_name, sizeof(g_Player[].menustats_name));
			results.FetchString(2, g_Player[client].menustats_ip, sizeof(g_Player[].menustats_ip));
			g_Player[client].menustats_penalty = view_as<bool>(results.FetchInt(3));
			
			char query[256];
			Format(query, sizeof(query), "select * from `"...sql_table_playerlist..."` where `SteamID`='%s' and `StatsID`='%i'", auth, g_StatsID);
			sql.Query(StatsMenu_TopPlayerAuth_3, query, userid);
		}
		else
		{
			CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_TopPlayerSteamIDDoesNotExist", client, g_Player[client].menustats_auth);
		}
	}
}

void StatsMenu_TopPlayerAuth_3(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		if(results != null && results.FetchRow())
		{
			g_Player[client].menustats_lastconnected = GetFieldValue(results, "LastConnectedTime");
			GetPlayerlistStats(results, g_Player[client].menustats);
			
			g_Player[client].active_page_mainmenu = -1;
			g_Player[client].active_page_session = -1;
			g_Player[client].active_page_activestats = -1;
			g_Player[client].active_page_topstats = 1;
			StatsMenu.TopStatsInfo(client, 1, g_Player[client].menustats_pos);
		}
		else
		{
			CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_TopPlayerSteamIDDoesNotExist", client, g_Player[client].menustats_auth);
		}
	}
}

int StatsMenu_Settings(Menu menu, MenuAction action, int client, int select)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			char str_option[3];
			menu.GetItem(select, str_option, sizeof(str_option));
			int option = StringToInt(str_option);
			
			switch(option)
			{
				case 0:
				{
					g_Player[client].bPlayConSnd = g_Player[client].bPlayConSnd ? false : true;
					g_Player[client].bPlayConSndUpdated = true;
				}
				case 1:
				{
					g_Player[client].bShowConMsg = g_Player[client].bShowConMsg ? false : true;
					g_Player[client].bShowConMsgUpdated = true;
				}
				case 2:
				{
					g_Player[client].bShowTopConMsg = g_Player[client].bShowTopConMsg ? false : true;
					g_Player[client].bShowTopConMsgUpdated = true;
				}
				case 3:
				{
					g_Player[client].bShowFragMsg = g_Player[client].bShowFragMsg ? false : true;
					g_Player[client].bShowFragMsgUpdated = true;
				}
				case 4:
				{
					g_Player[client].bShowAssistMsg = g_Player[client].bShowAssistMsg ? false : true;
					g_Player[client].bShowAssistMsgUpdated = true;
				}
				case 5:
				{
					g_Player[client].bShowDeathMsg = g_Player[client].bShowDeathMsg ? false : true;
					g_Player[client].bShowDeathMsgUpdated = true;
				}
			}
			
			StatsMenu.Settings(client, menu.Selection);
		}
		case MenuAction_Cancel:
		{
			if(select == MenuCancel_Exit || select == MenuCancel_ExitBack)
			{
				if(g_Player[client].bPlayConSndUpdated
				|| g_Player[client].bShowConMsgUpdated
				|| g_Player[client].bShowTopConMsgUpdated
				|| g_Player[client].bShowFragMsgUpdated
				|| g_Player[client].bShowAssistMsgUpdated
				|| g_Player[client].bShowDeathMsgUpdated)
				{
					int len = 0;
					char query[512];
					
					len += Format(query[len], sizeof(query)-len, "update `"...sql_table_settings..."` set ");
					
					if(g_Player[client].bPlayConSndUpdated)
					{
						len += Format(query[len], sizeof(query)-len, "PlayConnectSnd = %i", g_Player[client].bPlayConSnd);
						g_Player[client].bPlayConSndUpdated = false
					}
					if(g_Player[client].bShowConMsgUpdated)
					{
						if(!StrEqual(query[len-1], ","))
						{
							len += Format(query[len], sizeof(query)-len, ",");
						}
						len += Format(query[len], sizeof(query)-len, "ShowConnectMsg = %i", g_Player[client].bShowConMsg);
						g_Player[client].bShowConMsgUpdated = false;
					}
					if(g_Player[client].bShowTopConMsgUpdated)
					{
						if(!StrEqual(query[len-1], ","))
						{
							len += Format(query[len], sizeof(query)-len, ",");
						}
						len += Format(query[len], sizeof(query)-len, "ShowTopConnectMsg = %i", g_Player[client].bShowTopConMsg);
						g_Player[client].bShowTopConMsgUpdated = false;
					}
					if(g_Player[client].bShowFragMsgUpdated)
					{
						if(!StrEqual(query[len-1], ","))
						{
							len += Format(query[len], sizeof(query)-len, ",");
						}
						len += Format(query[len], sizeof(query)-len, "ShowFragMsg = %i", g_Player[client].bShowFragMsg);
						g_Player[client].bShowFragMsgUpdated = false;
					}
					if(g_Player[client].bShowAssistMsgUpdated)
					{
						if(!StrEqual(query[len-1], ","))
						{
							len += Format(query[len], sizeof(query)-len, ",");
						}
						len += Format(query[len], sizeof(query)-len, "ShowAssistMsg = %i", g_Player[client].bShowAssistMsg);
						g_Player[client].bShowAssistMsgUpdated = false;
					}
					if(g_Player[client].bShowDeathMsgUpdated)
					{
						if(!StrEqual(query[len-1], ","))
						{
							len += Format(query[len], sizeof(query)-len, ",");
						}
						len += Format(query[len], sizeof(query)-len, "ShowDeathMsg = %i", g_Player[client].bShowDeathMsg);
						g_Player[client].bShowDeathMsgUpdated = false;
					}
					
					len += Format(query[len], sizeof(query)-len, " where SteamID = '%s'", g_Player[client].auth);
					CallbackQuery(query, query_error_uniqueid_OnUpdatedMenuSettingValue);
				}
			}
			if(select == MenuCancel_ExitBack)
			{
				g_Player[client].active_page_mainmenu = 2;
				StatsMenu.Main(client, 2);
			}
		}
		case MenuAction_End: delete menu;
	}
	
	return 0;
}

/* =================================================== */

void LoadMenus()
{
	for(int i = 0; i < sizeof(str_cmdMenu); i++)
	{
		RegConsoleCmd(str_cmdMenu[i], StatsMenuCmd, "SMStats: TF2 - Statistical tracking menu.");
	}
	
	for(int i = 0; i < sizeof(str_statsCmd); i++)
	{
		RegConsoleCmd(str_statsCmd[i], StatsCmd, "SMStats: TF2 - Statistical command.");
	}
}

Action StatsMenuCmd(int client, int args)
{
	switch(client == 0)
	{
		case false:
		{
			g_Player[client].active_page_mainmenu = 1;
			g_Player[client].active_page_session = -1;
			g_Player[client].active_page_topstats = -1;
			StatsMenu.Main(client);
		}
		case true: ReplyToCommand(client, "%s This command may only be used in-game!", core_chattag);
	}
	return Plugin_Handled;
}

Action StatsCmd(int client, int args)
{
	switch(client == 0)
	{
		case false:
		{
			if(!bLoaded)
			{
				CPrintToChat(client, "%s %T", core_chattag, "#SMStats_Error_NotInitialized", client);
				return Plugin_Handled;
			}
			else if(!sql)
			{
				CPrintToChat(client, "%s %T", core_chattag, "#SMStats_Error_SQLNotInitialized", client);
				return Plugin_Handled;
			}
			
			switch(args < 1)
			{
				case false:
				{
					if(args > 1)
					{
						CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_StatsCmd_Usage", client);
						return Plugin_Handled;
					}
					
					char dummy[64];
					if(GetCmdArg(1, dummy, sizeof(dummy)) < 1)
					{
						CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_StatsCmd_Error", client);
						return Plugin_Handled;
					}
					
					if(StrEqual(dummy, " "))
					{
						CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_StatsCmd_NULL", client);
						return Plugin_Handled;
					}
					
					switch(StrContains(dummy, "STEAM", false) != -1)
					{
						case false:
						{
							int top_player_id = StringToInt(dummy);
							switch(top_player_id >= 1)
							{
								case false: CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_StatsCmd_InvalidTopPlayer", client, top_player_id);
								case true: StatsMenu.TopPlayerId(client, top_player_id);
							}
						}
						case true:
						{
							switch(IsValidSteamID(dummy))
							{
								case false: CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_StatsCmd_InvalidSteamID", client, dummy);
								case true: StatsMenu.TopPlayerAuth(client, dummy);
							}
						}
					}
				}
				case true:
				{
					g_Player[client].active_page_mainmenu = 1;
					StatsMenu.Main(client);
				}
			}
		}
		case true: ReplyToCommand(client, "%s This command may only be used in-game!", core_chattag);
	}
	return Plugin_Handled;
}

/* =================================================== */

stock bool IsValidSteamID(const char[] steam_id)
{
	Regex exp = new Regex("^STEAM_[0-5]:[0-1]:[0-9]+$");
	int matches = exp.Match(steam_id);
	delete exp;
	return (matches == 1);
}

/**
 *	Returns if the string contains a number.
 *
 *	@param	str	The string to check.
 */
stock bool StrHasNumbers(const char[] str) {
	return (StrContains(str, "1") != -1
	|| StrContains(str, "2") != -1
	|| StrContains(str, "3") != -1
	|| StrContains(str, "4") != -1
	|| StrContains(str, "5") != -1
	|| StrContains(str, "6") != -1
	|| StrContains(str, "7") != -1
	|| StrContains(str, "8") != -1
	|| StrContains(str, "9") != -1
	|| StrContains(str, "0") != -1);
}

//

/**
 *	Fetch the information of a steamid.
 *
 *	@param client	The user index of the fetcher.
 *	@param auth		The authentication steamid to read.
 */
 /*
bool TF2_GetPlayerSQLInfo(int client
						, const char[] auth
						, char[] szPlayerName=""
						, int lenPlayerName=0
						, char[] szPlayerIP=""
						, int lenPlayerIP=0
						, int &LastConnectedTime=0
						, bool &bPenalty=false
						, bool bTopPlayerCustom=false
						, bool bTopPlayerId=false)
{
	if(!sql)
	{
		PrintToServer("%s TF2_GetPlayerSQLInfo() error : Invalid SQL Connection.", core_chattag);
		return false;
	}
	else if(!bLoaded)
	{
		PrintToServer("%s TF2_GetPlayerSQLInfo() error : SMStats Core not loaded.", core_chattag);
		return false;
	}
	
	bool bReturn;
	char query[2048];
	Format(query, sizeof(query), "select `PlayerName`,`IPAddress`,`Penalty` from `"...sql_table_settings..."` where SteamID = '%s'", auth);	
	SQL_LockDatabase(sql);
	DBResultSet results = SQL_Query(sql, query);
	SQL_UnlockDatabase(sql);
	
	if(results != null && results.FetchRow())
	{
		results.FetchString(0, szPlayerName, lenPlayerName);
		results.FetchString(1, szPlayerIP, lenPlayerIP);
		bPenalty = view_as<bool>(results.FetchInt(2));
	}
	else
	{
		strcopy(szPlayerName, lenPlayerName, "");
		strcopy(szPlayerIP, lenPlayerIP, "");
		bPenalty = false;
	}
	
	//
	
	Format(query, sizeof(query), "select * from `"...sql_table_playerlist..."` where SteamID = '%s' and ServerID = %i", auth, g_ServerID);
	
	SQL_LockDatabase(sql);
	results = SQL_Query(sql, query);
	SQL_UnlockDatabase(sql); // not unlocking will cause server to freeze or crash on the next sql call, due to accessing what it thinks exists but doesn't anymore.
	switch(results != null && results.FetchRow())
	{
		case false:
		{
			char error[255];
			SQL_GetError(sql, error, sizeof(error));
			PrintToServer("error : '%s'", error);
			
			if(bTopPlayerCustom)
			{
				switch(bTopPlayerId)
				{
					case true: CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_TopPlayerIdDoesNotExist", client, g_Player[client].menustats_pos);
					case false: CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_TopPlayerSteamIDDoesNotExist", client, g_Player[client].menustats_auth);
				}
			}
		}
		case true:
		{
			LastConnectedTime = GetFieldValue(results, "LastConnectedTime");
			GetPlayerlistStats(results, g_Player[client].menustats);
			bReturn = true;
		}
	}
	
	delete results;
	return bReturn;
}
*/

void TF2_GetStatisticalInformation(Panel panel, int client, int page, int[] stats, bool top_player=false, bool penalty=false)
{
	switch(page)
	{
		case 1:
		{
			char play_time[256];
			GetTimeFormat(client, stats[Stats_PlayTime], play_time, sizeof(play_time));
			
			switch(top_player)
			{
				case false: PanelText(panel, "  %T", "#SMStats_MenuInfo_PlayTime", client, play_time);
				case true:
				{
					char country[64], last_connected[128];
					GeoipCountryName(client, g_Player[client].menustats_ip, country, sizeof(country));
					GetLastConnectedFormat(client, g_Player[client].menustats_ip, g_Player[client].menustats_lastconnected, last_connected, sizeof(last_connected));
					
					//PanelItem(panel, "  %T", "#SMStats_MenuInfo_Profile", client); // need a working Steam32 (STEAM_0:0:123456 => 7655168912398123456)
					PanelText(panel, "  %T", "#SMStats_MenuInfo_PlayTime", client, play_time);
					PanelText(panel, "  %T", "#SMStats_MenuInfo_Country", client, country);
					PanelText(panel, "  %T", "#SMStats_MenuInfo_LastConnected", client, last_connected);
				}
			}
			switch(stats[Stats_Points] >= 0)
			{
				case false:
				{
					switch(penalty)
					{
						case false: PanelText(panel, "  %T", "#SMStats_MenuInfo_PointsLost", client, stats[Stats_Points]);
						case true: PanelText(panel, "  %T%T", "#SMStats_MenuInfo_PointsLost", client, stats[Stats_Points], "#SMStats_Points_Penalty", client);
					}
				}
				case true:
				{
					switch(penalty)
					{
						case false: PanelText(panel, "  %T", "#SMStats_MenuInfo_PointsEarned", client, stats[Stats_Points]);
						case true: PanelText(panel, "  %T%T", "#SMStats_MenuInfo_PointsEarned", client, stats[Stats_Points], "#SMStats_Points_Penalty", client);
					}
				}
			}
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Frags", client, stats[Stats_Frags]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Assists", client, stats[Stats_Assists]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Deaths", client, stats[Stats_Deaths]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Suicides", client, stats[Stats_Suicides]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_DamageDone", client, stats[Stats_DamageDone]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_AchievementsEarned", client, stats[Stats_Achievements]);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
			PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		}
		case 2:
		{
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Dominations", client, stats[Stats_Dominations]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Revenges", client, stats[Stats_Revenges]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Airshots", client, stats[Stats_Airshots]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Headshots", client, stats[Stats_Headshots]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Noscopes", client, stats[Stats_Noscopes]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Backstabs", client, stats[Stats_Backstabs]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_TauntFrags", client, stats[Stats_TauntFrags]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_PumpkinBombFrags", client, stats[Stats_PumpkinBombFrags]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_GibFrags", client, stats[Stats_GibFrags]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_DeflectFrags", client, stats[Stats_Deflects]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleFrags", client, stats[Stats_TeleFrags]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Collaterals", client, stats[Stats_Collaterals]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_MidAirFrags", client, stats[Stats_MidAirFrags]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CritFrags", client, stats[Stats_CritFrags]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_MiniCritFrags", client, stats[Stats_MiniCritFrags]);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
			PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		}
		case 3:
		{
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Scout", client, stats[Stats_ScoutFrags], stats[Stats_ScoutDeaths]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Soldier", client, stats[Stats_SoldierFrags], stats[Stats_SoldierDeaths]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Pyro", client, stats[Stats_PyroFrags], stats[Stats_PyroDeaths]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Demoman", client, stats[Stats_DemoFrags], stats[Stats_DemoDeaths]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Heavy", client, stats[Stats_HeavyFrags], stats[Stats_HeavyDeaths]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Engineer", client, stats[Stats_EngieFrags], stats[Stats_EngieDeaths]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Medic", client, stats[Stats_MedicFrags], stats[Stats_MedicDeaths]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Sniper", client, stats[Stats_SniperFrags], stats[Stats_SniperDeaths]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Spy", client, stats[Stats_SpyFrags], stats[Stats_SpyDeaths]);			
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
			PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		}
		case 4:
		{
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Buildings", client, stats[Stats_BuildingsPlaced], stats[Stats_BuildingsDestroyed]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Dispenser", client, stats[Stats_DispensersPlaced], stats[Stats_DispensersDestroyed]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_SentryGun", client, stats[Stats_SentryGunsPlaced], stats[Stats_SentryGunsDestroyed]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleporterEntrance", client, stats[Stats_TeleporterEntrancesPlaced], stats[Stats_TeleporterEntrancesDestroyed]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleporterExit", client, stats[Stats_TeleporterExitsPlaced], stats[Stats_TeleporterExitsDestroyed]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_MiniSentryGun", client, stats[Stats_MiniSentryGunsPlaced], stats[Stats_MiniSentryGunsDestroyed]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Sapper", client, stats[Stats_SappersPlaced], stats[Stats_SappersDestroyed]);
			
			// will be worked on further, not finished yet.
			panel.DrawText(" ");
			PanelText(panel, "  %T", "#SMStats_MenuInfo_SentryGunFrags", client
			, stats[Stats_SentryFrags]
			, stats[Stats_SentryLVL1Frags]
			, stats[Stats_SentryLVL2Frags]
			, stats[Stats_SentryLVL3Frags]
			, stats[Stats_MiniSentryFrags]);
			
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
			PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		}
		case 5:
		{
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CP_Captured", client, stats[Stats_PointsCaptured]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CP_Defended", client, stats[Stats_PointsDefended]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Stolen", client, stats[Stats_FlagsStolen]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_PickedUp", client, stats[Stats_FlagsPickedUp]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Captured", client, stats[Stats_FlagsCaptured]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Defended", client, stats[Stats_FlagsDefended]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CTF_Dropped", client, stats[Stats_FlagsDropped]);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
			PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		}
		case 6:
		{
			PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleportersUsed", client, stats[Stats_TeleportersUsed]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_PlayersTeleported", client, stats[Stats_PlayersTeleported]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CoatedPiss", client, stats[Stats_CoatedPiss]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CoatedMilk", client, stats[Stats_CoatedMilk]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_CoatedGasoline", client, stats[Stats_CoatedGasoline]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Coated", client, stats[Stats_Coated]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Extinguished", client, stats[Stats_Extinguished]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Ignited", client, stats[Stats_Ignited]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_Ubercharged", client, stats[Stats_Ubercharged]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_SandvichesStolen", client, stats[Stats_SandvichesStolen]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_StunnedPlayers", client, stats[Stats_StunnedPlayers], stats[Stats_MoonShotStunnedPlayers]);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
			PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		}
		case 7:
		{
			PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_Monoculus", client, stats[Stats_MonoculusFragged], stats[Stats_MonoculusStunned]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_Merasmus", client, stats[Stats_MerasmusFragged], stats[Stats_MerasmusStunned]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_HHH", client, stats[Stats_HHHFragged]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_HWN_SkeletonKing", client, stats[Stats_SkeletonKingsFragged]);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
			PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		}
		case 8:
		{
			PanelText(panel, "  %T", "#SMStats_MenuInfo_MvM_TanksDestroyed", client, stats[Stats_TanksDestroyed]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_MvM_SentryBustersFragged", client, stats[Stats_SentryBustersFragged]);
			PanelText(panel, "  %T", "#SMStats_MenuInfo_MvM_BombsResetted", client, stats[Stats_BombsResetted]);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
			//PanelItem(panel, "%T", "#SMStats_Menu_NextPage", client);
			panel.DrawText(" ");
			PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		}
	}
}

//

void GetPlayerlistStats(DBResultSet results, int[] stats)
{
	stats[Stats_PlayTime] = GetFieldValue(results, "PlayTime");
	stats[Stats_Points] = GetFieldValue(results, "Points");
	stats[Stats_Frags] = GetFieldValue(results, "Frags");
	stats[Stats_Assists] = GetFieldValue(results, "Assists");
	stats[Stats_Deaths] = GetFieldValue(results, "Deaths");
	stats[Stats_Suicides] = GetFieldValue(results, "Suicides");
	stats[Stats_DamageDone] = GetFieldValue(results, "DamageDone");
	stats[Stats_Achievements] = GetFieldValue(results, "Achievements");
	
	stats[Stats_Dominations] = GetFieldValue(results, "Dominations");
	stats[Stats_Revenges] = GetFieldValue(results, "Revenges");
	stats[Stats_Airshots] = GetFieldValue(results, "Airshots");
	stats[Stats_Headshots] = GetFieldValue(results, "Headshots");
	stats[Stats_Noscopes] = GetFieldValue(results, "Noscopes");
	stats[Stats_Backstabs] = GetFieldValue(results, "Backstabs");
	stats[Stats_TauntFrags] = GetFieldValue(results, "TauntFrags");
	stats[Stats_GibFrags] = GetFieldValue(results, "GibFrags");
	stats[Stats_Deflects] = GetFieldValue(results, "DeflectFrags");
	stats[Stats_TeleFrags] = GetFieldValue(results, "TeleFrags");
	stats[Stats_Collaterals] = GetFieldValue(results, "Collaterals");
	stats[Stats_MidAirFrags] = GetFieldValue(results, "MidAirFrags");
	stats[Stats_CritFrags] = GetFieldValue(results, "CritFrags");
	stats[Stats_MiniCritFrags] = GetFieldValue(results, "MiniCritFrags");
	stats[Stats_PumpkinBombFrags] = GetFieldValue(results, "PumpkinBombFrags");
	
	stats[Stats_ScoutFrags] = GetFieldValue(results, "ScoutFrags");
	stats[Stats_SoldierFrags] = GetFieldValue(results, "SoldierFrags");
	stats[Stats_PyroFrags] = GetFieldValue(results, "PyroFrags");
	stats[Stats_DemoFrags] = GetFieldValue(results, "DemoFrags");
	stats[Stats_HeavyFrags] = GetFieldValue(results, "HeavyFrags");
	stats[Stats_EngieFrags] = GetFieldValue(results, "EngieFrags");
	stats[Stats_MedicFrags] = GetFieldValue(results, "MedicFrags");
	stats[Stats_SniperFrags] = GetFieldValue(results, "SniperFrags");
	stats[Stats_SpyFrags] = GetFieldValue(results, "SpyFrags");
	stats[Stats_ScoutDeaths] = GetFieldValue(results, "ScoutDeaths");
	stats[Stats_SoldierDeaths] = GetFieldValue(results, "SoldierDeaths");
	stats[Stats_PyroDeaths] = GetFieldValue(results, "PyroDeaths");
	stats[Stats_DemoDeaths] = GetFieldValue(results, "DemoDeaths");
	stats[Stats_HeavyDeaths] = GetFieldValue(results, "HeavyDeaths");
	stats[Stats_EngieDeaths] = GetFieldValue(results, "EngieDeaths");
	stats[Stats_MedicDeaths] = GetFieldValue(results, "MedicDeaths");
	stats[Stats_SniperDeaths] = GetFieldValue(results, "SniperDeaths");
	stats[Stats_SpyDeaths] = GetFieldValue(results, "SpyDeaths");
	
	stats[Stats_BuildingsPlaced] = GetFieldValue(results, "BuildingsPlaced");
	stats[Stats_DispensersPlaced] = GetFieldValue(results, "DispensersPlaced");
	stats[Stats_SentryGunsPlaced] = GetFieldValue(results, "SentryGunsPlaced");
	stats[Stats_TeleporterEntrancesPlaced] = GetFieldValue(results, "TeleporterEntrancesPlaced");
	stats[Stats_TeleporterExitsPlaced] = GetFieldValue(results, "TeleporterExitsPlaced");
	stats[Stats_MiniSentryGunsPlaced] = GetFieldValue(results, "MiniSentryGunsPlaced");
	stats[Stats_SappersPlaced] = GetFieldValue(results, "SappersPlaced");
	stats[Stats_BuildingsDestroyed] = GetFieldValue(results, "BuildingsDestroyed");
	stats[Stats_DispensersDestroyed] = GetFieldValue(results, "DispensersDestroyed");
	stats[Stats_SentryGunsDestroyed] = GetFieldValue(results, "SentryGunsDestroyed");
	stats[Stats_TeleporterEntrancesDestroyed] = GetFieldValue(results, "TeleporterEntrancesDestroyed");
	stats[Stats_TeleporterExitsDestroyed] = GetFieldValue(results, "TeleporterExitsDestroyed");
	stats[Stats_MiniSentryGunsDestroyed] = GetFieldValue(results, "MiniSentryGunsDestroyed");
	stats[Stats_SappersDestroyed] = GetFieldValue(results, "SappersDestroyed");
	
	stats[Stats_PointsCaptured] = GetFieldValue(results, "PointsCaptured");
	stats[Stats_PointsDefended] = GetFieldValue(results, "PointsDefended");
	stats[Stats_FlagsPickedUp] = GetFieldValue(results, "FlagsPickedUp");
	stats[Stats_FlagsCaptured] = GetFieldValue(results, "FlagsCaptured");
	stats[Stats_FlagsStolen] = GetFieldValue(results, "FlagsStolen");
	stats[Stats_FlagsDefended] = GetFieldValue(results, "FlagsDefended");
	stats[Stats_FlagsDropped] = GetFieldValue(results, "FlagsDropped");
	
	stats[Stats_TeleportersUsed] = GetFieldValue(results, "TeleportersUsed");
	stats[Stats_PlayersTeleported] = GetFieldValue(results, "PlayersTeleported");
	stats[Stats_CoatedPiss] = GetFieldValue(results, "CoatedPiss");
	stats[Stats_CoatedMilk] = GetFieldValue(results, "CoatedMilk");
	stats[Stats_CoatedGasoline] = GetFieldValue(results, "CoatedGasoline");
	stats[Stats_Coated] = GetFieldValue(results, "Coated");
	stats[Stats_Extinguished] = GetFieldValue(results, "Extinguished");
	//stats[Stats_Ignited] = GetFieldValue(results, "Ignited");
	stats[Stats_Ubercharged] = GetFieldValue(results, "Ubercharged");
	stats[Stats_SandvichesStolen] = GetFieldValue(results, "SandvichesStolen");
	stats[Stats_StunnedPlayers] = GetFieldValue(results, "StunnedPlayers");
	stats[Stats_MoonShotStunnedPlayers] = GetFieldValue(results, "MoonShotStunnedPlayers");
	
	stats[Stats_MonoculusStunned] = GetFieldValue(results, "MonoculusFragged");
	stats[Stats_MerasmusStunned] = GetFieldValue(results, "MerasmusStunned");
	stats[Stats_MonoculusFragged] = GetFieldValue(results, "MonoculusFragged");
	stats[Stats_MerasmusFragged] = GetFieldValue(results, "MerasmusFragged");
	stats[Stats_HHHFragged] = GetFieldValue(results, "HHHFragged");
	stats[Stats_SkeletonKingsFragged] = GetFieldValue(results, "SkeletonKingsFragged");
	
	//stats[Stats_RobotsFragged] = GetFieldValue(results, "RobotFrags");
	stats[Stats_TanksDestroyed] = GetFieldValue(results, "TanksDestroyed");
	stats[Stats_SentryBustersFragged] = GetFieldValue(results, "SentryBustersFragged");
	stats[Stats_BombsResetted] = GetFieldValue(results, "BombsResetted");
}

// StatsMenu_CheckActiveStats()

void DBQuery_CheckActiveStats_1(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		if(results != null && results.FetchRow())
		{
			char auth[28];
			results.FetchString(0, auth, sizeof(auth));
			results.FetchString(1, g_Player[client].menustats_name, sizeof(g_Player[].menustats_name));
			results.FetchString(2, g_Player[client].menustats_ip, sizeof(g_Player[].menustats_ip));
			g_Player[client].menustats_penalty = view_as<bool>(results.FetchInt(3));
			
			char query[256];
			Format(query, sizeof(query), "select * from `"...sql_table_playerlist..."` where `SteamID`='%s' and `StatsID`='%i'", auth, g_StatsID);
			sql.Query(DBQuery_CheckActiveStats_2, query, userid);
		}
	}
}

void DBQuery_CheckActiveStats_2(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		if(results != null && results.FetchRow())
		{
			g_Player[client].menustats_lastconnected = GetFieldValue(results, "LastConnectedTime");
			GetPlayerlistStats(results, g_Player[client].menustats);
			
			g_Player[client].active_page_mainmenu = -1;
			g_Player[client].active_page_session = -1;
			g_Player[client].active_page_activestats = 1;
			g_Player[client].active_page_topstats = -1;
			StatsMenu.ActiveStatsInfo(client, 1);
		}
	}
}

// StatsMenu_TopStats()

void DBQuery_TopStats_1(Database database, DBResultSet results, const char[] error, DataPack pack)
{
	int userid = pack.ReadCell();
	int display_at = pack.ReadCell();
	delete pack;
	
	//
	
	int client;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		char[][] SteamID = new char[10][64];
		char[][] PlayerName = new char[10][64];
		int Points[10];
		int Players = 0;
		
		while(results.FetchRow())
		{
			results.FetchString(0, PlayerName[Players], 28);
			results.FetchString(1, SteamID[Players], 64);
			Points[Players] = results.FetchInt(2);
			Players++
		}
		
		if(Players < 1)
		{
			CPrintToChat(client, "%s %T", g_ChatTag, "#SMStats_TopSQLInfo_NoPlayers", client);
			return;
		}
		
		Menu menu = new Menu(StatsMenu_TopStats);
		menu.SetTitle("SourceMod Stats - "...VersionAlt..." > %T", "#SMStats_Menu_Top10", client);
		
		for(int i = 0; i < Players; i++)
		{
			char dummy[96], points_plural[32];
			PointsPluralSplitter(client, Points[i], points_plural, sizeof(points_plural));
			Format(dummy, sizeof(dummy), "%T", "#SMStats_MenuInfo_TopPlayer", client, i+1, PlayerName[i], points_plural);
			menu.AddItem(SteamID[i], dummy);
		}
		
		menu.ExitBackButton = true;
		menu.DisplayAt(client, display_at, MENU_TIME_FOREVER);
	}
}

// StatsMenu_TopStats_MenuHandler()

void DBQuery_TopStats_Menu_1(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		if(results != null && results.FetchRow())
		{
			char auth[28];
			results.FetchString(0, auth, sizeof(auth));
			results.FetchString(1, g_Player[client].menustats_name, sizeof(g_Player[].menustats_name));
			results.FetchString(2, g_Player[client].menustats_ip, sizeof(g_Player[].menustats_ip));
			g_Player[client].menustats_penalty = view_as<bool>(results.FetchInt(3));
			
			char query[256];
			Format(query, sizeof(query), "select * from `"...sql_table_playerlist..."` where `SteamID`='%s' and `StatsID`='%i'", auth, g_StatsID);
			sql.Query(DBQuery_TopStats_Menu_2, query, userid);
		}
	}
}

void DBQuery_TopStats_Menu_2(Database database, DBResultSet results, const char[] error, int userid)
{
	int client;
	if(IsValidClient((client = GetClientOfUserId(userid))))
	{
		if(results != null && results.FetchRow())
		{
			g_Player[client].menustats_lastconnected = GetFieldValue(results, "LastConnectedTime");
			GetPlayerlistStats(results, g_Player[client].menustats);
			
			g_Player[client].active_page_mainmenu = -1;
			g_Player[client].active_page_session = -1;
			g_Player[client].active_page_activestats = -1;
			g_Player[client].active_page_topstats = 1;
			StatsMenu.TopStatsInfo(client, 1, g_Player[client].menustats_pos);
		}
	}
}