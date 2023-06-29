enum struct StatsMenuInfo
{
	int lol;
	
	void Main(int client)
	{
		if(!bLoaded)
		{
			CPrintToChat(client, "%s {yellow}Error: {grey}SM Stats: Core {yellow}has yet initialized.", core_chattag);
			return;
		}
		else if(!sql)
		{
			CPrintToChat(client, "%s {yellow}Error: {grey}SQL Connection {yellow}is unavailable.", core_chattag);
			return;
		}
		
		Panel panel = new Panel();
		panel.DrawItem("SourceMod Stats - " ... VersionAlt);
		
		PanelText(panel, "%T", "#SMStats_Menu_Playername", client, client);
		PanelText(panel, "%T\n ", "#SMStats_Menu_Positioned", client, GetClientPosition(g_Player[client].auth), g_TotalTablePlayers);		
		
		panel.DrawItem("Session"
		... "\n  > View your current session statistics."
		... "\n ");
		
		panel.DrawItem("Active stats."
		... "\n  > View your active statistics."
		... "\n ");
		
		panel.Send(client, StatsMenu_Main, MENU_TIME_FOREVER);
		delete panel;
	}
	
	void Session(int client, int page=1)
	{
		Panel panel = new Panel();
		PanelItem(panel, "SourceMod Stats - %s > Session > Page %i", VersionAlt, page);
		
		switch(page)
		{
			case 1:
			{
				PanelText(panel, "  Play time : %i minutes", g_Player[client].session[Stats_PlayTime]);
				PanelText(panel, g_Player[client].session[Stats_Points] >= 0 ? "  Points earned : %i" : "  Points lost : %i", g_Player[client].session[Stats_Points]);
				PanelText(panel, "  Frags : %i", g_Player[client].session[Stats_Frags]);
				PanelText(panel, "  Assists : %i", g_Player[client].session[Stats_Assists]);
				PanelText(panel, "  Deaths : %i", g_Player[client].session[Stats_Deaths]);
				PanelText(panel, "  Suicides : %i", g_Player[client].session[Stats_Suicides]);
				PanelText(panel, "  Damage done : %i", g_Player[client].session[Stats_DamageDone]);
				PanelText(panel, "  Achievements Earned : %i", g_Player[client].session[Stats_Achievements]);
				panel.DrawText(" ");
				PanelItem(panel, "Next page");
				panel.DrawText(" ");
				PanelItem(panel, "Exit");
			}
			
			case 2:
			{
				PanelText(panel, "  Dominations : %i", g_Player[client].session[Stats_Dominations]);
				PanelText(panel, "  Revenges : %i", g_Player[client].session[Stats_Revenges]);
				PanelText(panel, "  Airshots : %i", g_Player[client].session[Stats_Airshots]);
				PanelText(panel, "  Headshots : %i", g_Player[client].session[Stats_Headshots]);
				PanelText(panel, "  Noscopes : %i", g_Player[client].session[Stats_Noscopes]);
				PanelText(panel, "  Backstabs : %i", g_Player[client].session[Stats_Backstabs]);
				PanelText(panel, "  Taunt frags : %i", g_Player[client].session[Stats_TauntFrags]);
				PanelText(panel, "  Gib frags : %i", g_Player[client].session[Stats_GibFrags]);
				PanelText(panel, "  Deflect frags : %i", g_Player[client].session[Stats_Deflects]);
				PanelText(panel, "  Ubercharged : %i", g_Player[client].session[Stats_Ubercharged]);
				PanelText(panel, "  Sandviches stolen : %i", g_Player[client].session[Stats_SandvichesStolen]);
				PanelText(panel, "  Telefrags : %i", g_Player[client].session[Stats_TeleFrags]);
				PanelText(panel, "  Collaterals : %i", g_Player[client].session[Stats_Collaterals]);
				PanelText(panel, "  Mid Air frags : %i", g_Player[client].session[Stats_MidAirFrags]);
				PanelText(panel, "  Critical frags : %i", g_Player[client].session[Stats_CritFrags]);
				PanelText(panel, "  Mini-Crit frags : %i", g_Player[client].session[Stats_MiniCritFrags]);
				panel.DrawText(" ");
				PanelItem(panel, "Previous page");
				PanelItem(panel, "Next page");
				panel.DrawText(" ");
				PanelItem(panel, "Exit");
			}
			
			case 3:
			{
				PanelText(panel, "  Scout : %i Frags / %i Deaths", g_Player[client].session[Stats_ScoutFrags], g_Player[client].session[Stats_ScoutDeaths]);
				PanelText(panel, "  Soldier : %i Frags / %i Deaths", g_Player[client].session[Stats_SoldierFrags], g_Player[client].session[Stats_SoldierDeaths]);
				PanelText(panel, "  Pyro : %i Frags / %i Deaths", g_Player[client].session[Stats_PyroFrags], g_Player[client].session[Stats_PyroDeaths]);
				PanelText(panel, "  Demoman : %i Frags / %i Deaths", g_Player[client].session[Stats_DemoFrags], g_Player[client].session[Stats_DemoDeaths]);
				PanelText(panel, "  Heavy : %i Frags / %i Deaths", g_Player[client].session[Stats_HeavyFrags], g_Player[client].session[Stats_HeavyDeaths]);
				PanelText(panel, "  Engineer : %i Frags / %i Deaths", g_Player[client].session[Stats_EngieFrags], g_Player[client].session[Stats_EngieDeaths]);
				PanelText(panel, "  Medic : %i Frags / %i Deaths", g_Player[client].session[Stats_MedicFrags], g_Player[client].session[Stats_MedicDeaths]);
				PanelText(panel, "  Sniper : %i Frags / %i Deaths", g_Player[client].session[Stats_SniperFrags], g_Player[client].session[Stats_SniperDeaths]);
				PanelText(panel, "  Spy : %i Frags / %i Deaths", g_Player[client].session[Stats_SpyFrags], g_Player[client].session[Stats_SpyDeaths]);			
				panel.DrawText(" ");
				PanelItem(panel, "Previous page");
				PanelItem(panel, "Next page");
				panel.DrawText(" ");
				PanelItem(panel, "Exit");
			}
			
			case 4:
			{
				PanelText(panel, "  Buildings : %i Placed / %i Destroyed", g_Player[client].session[Stats_BuildingsPlaced], g_Player[client].session[Stats_BuildingsDestroyed]);
				PanelText(panel, "  Dispenser : %i Placed / %i Destroyed", g_Player[client].session[Stats_DispensersPlaced], g_Player[client].session[Stats_DispensersDestroyed]);
				PanelText(panel, "  Sentry Gun : %i Placed / %i Destroyed", g_Player[client].session[Stats_SentryGunsPlaced], g_Player[client].session[Stats_SentryGunsDestroyed]);
				PanelText(panel, "  Teleporter Entrance : %i Placed / %i Destroyed", g_Player[client].session[Stats_TeleporterEntrancesPlaced], g_Player[client].session[Stats_TeleporterEntrancesDestroyed]);
				PanelText(panel, "  Teleporter Exits : %i Placed / %i Destroyed", g_Player[client].session[Stats_TeleporterExitsPlaced], g_Player[client].session[Stats_TeleporterExitsDestroyed]);
				PanelText(panel, "  Mini-Sentry Gun : %i Placed / %i Destroyed", g_Player[client].session[Stats_MiniSentryGunsPlaced], g_Player[client].session[Stats_MiniSentryGunsDestroyed]);
				PanelText(panel, "  Sapper : %i Placed / %i Destroyed", g_Player[client].session[Stats_SappersPlaced], g_Player[client].session[Stats_SappersDestroyed]);
				panel.DrawText(" ");
				PanelItem(panel, "Previous page");
				PanelItem(panel, "Next page");
				panel.DrawText(" ");
				PanelItem(panel, "Exit");
			}
			
			case 5:
			{
				PanelText(panel, "  Capture Points captured : %i", g_Player[client].session[Stats_PointsCaptured]);
				PanelText(panel, "  Capture Points defended : %i", g_Player[client].session[Stats_PointsDefended]);
				PanelText(panel, "  Flags stolen : %i", g_Player[client].session[Stats_FlagsStolen]);
				PanelText(panel, "  Flags picked up : %i", g_Player[client].session[Stats_FlagsPickedUp]);
				PanelText(panel, "  Flags captured : %i", g_Player[client].session[Stats_FlagsCaptured]);
				PanelText(panel, "  Flags defended : %i", g_Player[client].session[Stats_FlagsDefended]);
				PanelText(panel, "  Flags dropped : %i", g_Player[client].session[Stats_FlagsDropped]);
				panel.DrawText(" ");
				PanelItem(panel, "Previous page");
				PanelItem(panel, "Next page");
				panel.DrawText(" ");
				PanelItem(panel, "Exit");
			}
			
			case 6:
			{
				PanelText(panel, "  Teleporters used : %i", g_Player[client].session[Stats_Teleported]);
				PanelText(panel, "  Players teleported : %i", g_Player[client].session[Stats_PlayersTeleported]);
				PanelText(panel, "  Players coated with milk : %i", g_Player[client].session[Stats_MadMilked]);
				PanelText(panel, "  Players coated with piss : %i", g_Player[client].session[Stats_Jarated]);
				PanelText(panel, "  Players coated : %i", g_Player[client].session[Stats_Coated]);
				PanelText(panel, "  Extinguished : %i", g_Player[client].session[Stats_Extinguished]);
				PanelText(panel, "  Players ignited : %i", g_Player[client].session[Stats_Ignited]);
				panel.DrawText(" ");
				PanelItem(panel, "Previous page");
				PanelItem(panel, "Next page");
				panel.DrawText(" ");
				PanelItem(panel, "Exit");
			}
			
			case 7:
			{
				PanelText(panel, "  Monoculus : %i Frags / %i Stunned", g_Player[client].session[Stats_MonoculusFragged], g_Player[client].session[Stats_MonoculusStunned]);
				PanelText(panel, "  Merasmus : %i / %i Stunned", g_Player[client].session[Stats_MerasmusFragged], g_Player[client].session[Stats_MerasmusStunned]);
				PanelText(panel, "  Horseless Headless Horsemann : %i", g_Player[client].session[Stats_HHHFragged]);
				PanelText(panel, "  Skeleton King : %i", g_Player[client].session[Stats_SkeletonKingsFragged]);
				panel.DrawText(" ");
				PanelItem(panel, "Previous page");
				PanelItem(panel, "Next page");
				panel.DrawText(" ");
				PanelItem(panel, "Exit");
			}
			
			case 8:
			{
				PanelText(panel, "  Tanks Destroyed : %i", g_Player[client].session[Stats_TanksDestroyed]);
				PanelText(panel, "  Sentry Busters fragged : %i", g_Player[client].session[Stats_SentryBustersFragged]);
				PanelText(panel, "  Bombs resetted : %i", g_Player[client].session[Stats_BombsResetted]);
				panel.DrawText(" ");
				PanelItem(panel, "Previous page");
				//PanelItem(panel, "Next page");
				panel.DrawText(" ");
				PanelItem(panel, "Exit");
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