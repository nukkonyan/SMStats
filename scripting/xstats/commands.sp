/*
 *	This is the commands section for the Xstats, a statistical tracking plugin for source engine games.
 *	Expect changes & updates.
 */

void LoadCommands()	{
	RegAdminCmd("sm_xstatsmenu",	XstatsMenuCmd,		ADMFLAG_ROOT,	"Xstats - The menu to manage the statistical tracking plugin.");
	RegAdminCmd("xstats_reload_db",	ReloadDatabaseCmd,	ADMFLAG_ROOT,	"Xstats - Re-establish the database connection");
}

Action XstatsMenuCmd(int client, int args)	{
	GlobalForward menucommand = new GlobalForward("xstats_OnMenuCommand", ET_Hook, Param_Cell);
	Call_StartForward(menucommand);
	Call_PushCell(client);
	Action returnvalue;
	Call_Finish(returnvalue);
	delete menucommand;
	
	switch(returnvalue)	{
		case	Plugin_Handled:
			return returnvalue;
		case	Plugin_Continue:	{
			Menu menu = new Menu(XstatsMenu);
			menu.SetTitle("Xstats Menu");
			char menuinfo[128];
			
			Format(menuinfo, sizeof(menuinfo), "Toggle round active: %s",	RoundActive		? "True":"False");
			menu.AddItem("1", menuinfo);
			
			Format(menuinfo, sizeof(menuinfo), "Toggle ranking active: %s",	RankingActive	? "True":"False");
			menu.AddItem("2", menuinfo);
			menu.Display(client, MENU_TIME_FOREVER);
			return Plugin_Handled;
		}
	}
	
	return	Plugin_Handled;
}

int XstatsMenu(Menu menu, MenuAction action, int client, int selection)	{
	switch(action)	{
		case	MenuAction_Select:	{
			char info[64];
			menu.GetItem(selection, info, sizeof(info));
			switch(StringToInt(info))	{
				case	1:	{
					switch(RoundActive)	{
						case	true:	RoundActive = false;
						case	false:	RoundActive = true;
					}
					
					CPrintToChat(client, "%s You set the round active to %s.", Prefix, RoundActive ? "{green}True":"{red}False");
				}
				case	2:	{
					switch(RankingActive)	{
						case	true:	RankingActive = false;
						case	false:	RankingActive = true;
					}
					
					CPrintToChat(client, "%s You set the ranking active to %s.", Prefix, RankingActive ? "{green}True":"{red}False");
				}
			}
			XstatsMenuCmd(client, -1);
		}
		case	MenuAction_Cancel:
			delete menu;
	}
}

Action ReloadDatabaseCmd(int client, int args)	{
	CreateTimer(1.5, DBConnect_RetryTimer);
	
	switch(IsClientConsole(client))	{
		case	true:	ReplyToCommand(client, "[xstats] Re-establishing a new forced database connection..");
		case	false:	PrintToChat(client, "[xstats] Re-establishing a new forced database connection..");
	}
}