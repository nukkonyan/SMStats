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
		PanelText(panel, "%T\n ", "#SMStats_Menu_Positioned", client, GetClientPosition(g_Player[client].auth), g_TotalTablePlayers);		
		
		PanelItem(panel, "%T"
		... "\n  > %T"
		... "\n "
		, "#SMStats_Menu_Session", client
		, "#SMStats_Menu_SessionInfo", client);
		
		PanelItem(panel, "%T"
		... "\n  > %T"
		... "\n "
		, "#SMStats_Menu_ActiveStats", client
		, "#SMStats_Menu_ActiveStatsInfo", client);
		
		panel.Send(client, StatsMenu_Main, MENU_TIME_FOREVER);
		delete panel;
	}
	
	void Session(int client, int page=1)
	{
		Panel panel = new Panel();
		PanelItem(panel, "SourceMod Stats - %s > %T > %T"
		, VersionAlt
		, "#SMStats_Menu_Session", client
		, "#SMStats_Menu_Page", client, page);
		
		switch(page)
		{
			case 1:
			{
				PanelText(panel, "  %T", "#SMStats_MenuInfo_PlayTime", client, g_Player[client].session[Stats_PlayTime]);
				switch(g_Player[client].session[Stats_Points] >= 0)
				{
					case false: PanelText(panel, "  %T", "#SMStats_MenuInfo_PointsEarned", client, g_Player[client].session[Stats_Points]);
					case true: PanelText(panel, "  %T", "#SMStats_MenuInfo_PointsLost", client, g_Player[client].session[Stats_Points]);
				}
				
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Frags", client, g_Player[client].session[Stats_Frags]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Assists", client, g_Player[client].session[Stats_Assists]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Deaths", client, g_Player[client].session[Stats_Deaths]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_Suicides", client, g_Player[client].session[Stats_Suicides]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_DamageDone", client, g_Player[client].session[Stats_DamageDone]);
				PanelText(panel, "  %T", "#SMStats_MenuInfo_AchievementsEarned", client, g_Player[client].session[Stats_Achievements]);
				panel.DrawText(" ");
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
				PanelText(panel, "  %T", "#SMStats_MenuInfo_TeleportersUsed", client, g_Player[client].session[Stats_Teleported]);
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
}

StatsMenuInfo StatsMenu;

int StatsMenu_Main(Menu menu, MenuAction action, int client, int select)
{
	/*
	 * Main page.
	 * 1: Menu title.
	 * 2: Session.
	 * 3: Total stats.
	 */
	switch(select)
	{
		case 1:
		{
			StatsMenu.Main(client);
		}
		case 2:
		{
			g_Player[client].active_page_session = 1;
			StatsMenu.Session(client, 1);
		}
		
		case 3:
		{
			StatsMenu.Main(client);
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
			 * 2 : Next page.
			 * 3 : Exit.
			 */
			 
			switch(select)
			{
				case 1:
				{
					g_Player[client].active_page_session = 1;
					StatsMenu.Session(client, 1);
				}
				case 2:
				{
					g_Player[client].active_page_session = 2;
					StatsMenu.Session(client, 2);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
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
					StatsMenu.Session(client, 2);
				}
				case 2:
				{
					g_Player[client].active_page_session = 1;
					StatsMenu.Session(client, 1);
				}
				case 3:
				{
					g_Player[client].active_page_session = 3;
					StatsMenu.Session(client, 3);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
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
					StatsMenu.Session(client, 3);
				}
				case 2:
				{
					g_Player[client].active_page_session = 2;
					StatsMenu.Session(client, 2);
				}
				case 3:
				{
					g_Player[client].active_page_session = 4;
					StatsMenu.Session(client, 4);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
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
					StatsMenu.Session(client, 4);
				}
				case 2:
				{
					g_Player[client].active_page_session = 3;
					StatsMenu.Session(client, 3);
				}
				case 3:
				{
					g_Player[client].active_page_session = 5;
					StatsMenu.Session(client, 5);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
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
					StatsMenu.Session(client, 5);
				}
				case 2:
				{
					g_Player[client].active_page_session = 4;
					StatsMenu.Session(client, 4);
				}
				case 3:
				{
					g_Player[client].active_page_session = 6;
					StatsMenu.Session(client, 6);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
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
					StatsMenu.Session(client, 6);
				}
				case 2:
				{
					g_Player[client].active_page_session = 5;
					StatsMenu.Session(client, 5);
				}
				case 3:
				{
					g_Player[client].active_page_session = 7;
					StatsMenu.Session(client, 7);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
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
					StatsMenu.Session(client, 7);
				}
				case 2:
				{
					g_Player[client].active_page_session = 6;
					StatsMenu.Session(client, 6);
				}
				case 3:
				{
					g_Player[client].active_page_session = 8;
					StatsMenu.Session(client, 8);
				}
				case 4:
				{
					g_Player[client].active_page_session = -1;
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
					StatsMenu.Session(client, 8);
				}
				case 2:
				{
					g_Player[client].active_page_session = 7;
					StatsMenu.Session(client, 7);
				}
				case 3:
				{
					g_Player[client].active_page_session = -1;
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