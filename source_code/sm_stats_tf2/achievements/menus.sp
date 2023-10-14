enum struct MenuPageInfo
{
	int iAchId;
}

MenuPageInfo g_MenuPageInfo[MaxPlayers+1];

enum struct StatsMenuInfo
{
	int lol;
	
	void Main(int client)
	{
		/*
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
		*/
		
		Panel panel = new Panel();
		panel.DrawText("SourceMod Stats: Achievements - " ... VersionAlt ... " by Teamkiller324 ( Work in progress )");
		
		for(int i = 0; i < g_AchCount; i++)
		{
			panel.DrawItem(AchName[i]);
		}
		
		panel.DrawText(" ");
		PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		panel.Send(client, StatsMenu_Main, MENU_TIME_FOREVER);
		delete panel;
	}
	
	void AchInfo(int client, int ach_id)
	{
		Panel panel = new Panel();
		panel.DrawText("SourceMod Stats - " ... VersionAlt);
		panel.DrawText(" ");
		PanelItem(panel, "%T", "#SMStats_MenuInfo_Achievement", client, AchName[ach_id-1]);
		panel.DrawText(" ");
		PanelText(panel, "%T", "#SMStats_MenuInfo_Description", client);
		PanelText(panel, AchDescription[ach_id-1]);
		panel.DrawText(" ");
		panel.DrawText(" ");
		PanelItem(panel, "%T", "#SMStats_Menu_PreviousPage", client);
		PanelItem(panel, "%T", "#SMStats_Menu_ExitPage", client);
		panel.Send(client, StatsMenu_AchInfo, MENU_TIME_FOREVER);
		delete panel;
	}
}

StatsMenuInfo StatsMenu;

int StatsMenu_Main(Menu menu, MenuAction action, int client, int select)
{
	/*
	 * Main page.
	 * 1: test1.
	 * 2: test2
	 * 3: test3.
	 */
	
	if(select <= g_AchCount)
	{
		StatsMenu.AchInfo(client, select);
		g_MenuPageInfo[client].iAchId = select;
	}
	
	return 0;
}

int StatsMenu_AchInfo(Menu menu, MenuAction action, int client, int select)
{
	/*
	 * Main page.
	 * 1: achievement page.
	 * 2: previous page.
	 * 3: exit.
	 */
	
	switch(select)
	{
		case 1: StatsMenu.AchInfo(client, g_MenuPageInfo[client].iAchId);
		case 2: StatsMenu.Main(client);
	}
	
	return 0;
}

void LoadMenus()
{
	RegConsoleCmd("sm_achievements", AchCmd, "SM Stats: TF2 Achievements - View your achievements.");
	RegConsoleCmd("sm_achievement", AchCmd, "SM Stats: TF2 Achievements - View your achievements.");
	RegConsoleCmd("sm_ach", AchCmd, "SM Stats: TF2 Achievements - View your achievements.");
}

Action AchCmd(int client, int args)
{
	StatsMenu.Main(client);
	return Plugin_Handled;
}