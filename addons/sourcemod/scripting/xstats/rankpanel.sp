Action RankPanel(int client, int args=-1) {
	if(!DatabaseDirect()) {
		CPrintToChat(client, "%s The database connection is unavailable, please contact the server author.", Global.Prefix);
		XStats_DebugText(false, "Player %s tried catching a database connection for rank panel but failed.", Player[client].Playername);
		return Plugin_Handled;
	}
	
	DBResultSet results = SQL_QueryEx(DB.Direct,
	"select Points, PlayTime, Kills, Assists, Deaths, Suicides, DamageDone from `%s` where SteamID='%s' and ServerID='%i'",
	Global.playerlist, Player[client].SteamID, Cvars.ServerID.IntValue);
	
	if(results == null)	{
		CPrintToChat(client, "%s You don't seem to be on the database, you may try rejoin or contact the server author.", Global.Prefix);
		XStats_DebugText(false, "Player %s tried using rank panel but was not able to find the player on the database table.", Player[client].Playername);
		return Plugin_Handled;
	}
	
	if(!results.FetchRow())	{
		CPrintToChat(client, "%s Player stats were unable to be fetched from the database, please contact the server author.", Global.Prefix);
		XStats_DebugText(false, "Player %s tried fetching rows from the database table for the rank panel but failed.", Player[client].Playername);
		return Plugin_Handled;
	}
	
	Player[client].Position = GetClientPosition(Player[client].SteamID);
	int players = GetTablePlayerCount();
	int points = results.FetchInt(0);
	int playtime = results.FetchInt(1);
	int kills = results.FetchInt(2);
	int assists = results.FetchInt(3);
	int deaths = results.FetchInt(4);
	int suicides = results.FetchInt(5);
	int damagedone = results.FetchInt(6);
	float kdr = GetRatio(kills, deaths);
	
	delete results;
	StatsPanel[client].Main = true;
	
	PanelEx panel = new PanelEx();
	panel.DrawItem("XStats Panel");
	panel.DrawText("Playername: %s", Player[client].Playername);
	panel.DrawText("Positioned #%i out of %i players", Player[client].Position, players);
	panel.DrawSpace();
	panel.DrawItem("Current Session");
	panel.DrawText("%i Points", Session[client].Points);
	panel.DrawText("%i Minutes played", Session[client].PlayTime);
	panel.DrawText("%i Kills", Session[client].Kills);
	panel.DrawText("%i Assists", Session[client].Assists);
	panel.DrawText("%i Deaths", Session[client].Deaths);
	panel.DrawText("%i Suicides", Session[client].Suicides);
	panel.DrawText("%i Damage dealt", Session[client].DamageDone);
	panel.DrawText("KDR: %.2f", GetRatio(Session[client].Kills, Session[client].Deaths));
	panel.DrawSpace();
	panel.DrawItem("Total Statistics");
	panel.DrawText("%i Points", points);
	panel.DrawText("%i Total minutes played", playtime);
	panel.DrawText("%i Kills", kills);
	panel.DrawText("%i Assists", assists);
	panel.DrawText("%i Deaths", deaths);
	panel.DrawText("%i Suicides", suicides);
	panel.DrawText("%i Damage dealt", damagedone);
	panel.DrawText("KDR: %.2f", kdr);
	panel.DrawSpace();
	panel.DrawItem("Exit");
	panel.Send(client, RankPanelCallback, MENU_TIME_FOREVER);
	
	if(args != -1) {
		CPrintToChat(client, "%s %s is positioned #%i out of %i players with %.2f KDR and %i total minutes in playtime",
		Global.Prefix, Player[client].Name, Player[client].Position, players, kdr, playtime);
	}
	
	return Plugin_Handled;
}

/**
 *	Rank panel callback.
 */
stock int RankPanelCallback(Menu panel, MenuAction action, int client, int selection) {
	switch(selection)	{
		/**
		 * 1: Panel info.
		 * 2: Session.
		 * 3: Stats.
		 * 4. Exit.
		 */
		case 1: XStatsCmd(client);
		case 2:	{
			RankPanel_CurrentSession(client);
			StatsPanel[client].Main = false;
			StatsPanel[client].Session = false;
			StatsPanel[client].TotalPage = 0;
		}
		case 3:	{
			RankPanel_TotalStatistics(client);
			StatsPanel[client].Main = false;
			StatsPanel[client].Session = false;
			StatsPanel[client].TotalPage = 0;
		}
		case 4:	{
			StatsPanel[client].Main = false;
			StatsPanel[client].Session = false;
			StatsPanel[client].TotalPage = 0;
		}
	}
}

/* Current Session */
stock void RankPanel_CurrentSession(int client)	{
	PanelEx panel = new PanelEx();
	panel.DrawItem("XStats Panel: Current Session");
	
	/* Insert the generic ones first */
	panel.DrawText("%i Points", Session[client].Points);
	panel.DrawText("%i Minutes played", Session[client].PlayTime);
	panel.DrawText("%i Kills", Session[client].Kills);
	panel.DrawText("%i Assists", Session[client].Assists);
	panel.DrawText("%i Deaths", Session[client].Deaths);
	panel.DrawText("%i Suicides", Session[client].Suicides);
	panel.DrawText("%i Mid-air kills", Session[client].MidAirKills);
	panel.DrawText("%i Damage dealt", Session[client].DamageDone);
	panel.DrawText("KDR: %.2f", GetRatio(Session[client].Kills, Session[client].Deaths));
	panel.DrawSpace();
	
	switch(Global.Game)	{
		case Game_TF2, Game_TF2V: {
			panel.DrawItem("TF Stats");
			panel.DrawText("%i Dominations", Session[client].Dominations);
			panel.DrawText("%i Revenges", Session[client].Revenges);
			panel.DrawText("%i Headshots", Session[client].Headshots);
			panel.DrawText("%i Noscopes", Session[client].Noscopes);
			panel.DrawText("%i Backstabs", Session[client].Backstabs);
			panel.DrawText("%i Airshots", Session[client].Airshots);
			panel.DrawText("%i Deflects", Session[client].Deflects);
			panel.DrawText("%i Gibs", Session[client].Gibs);
			panel.DrawText("%i Critkills", Session[client].Critkills);
			panel.DrawText("%i Tauntkills", Session[client].Tauntkills);
			panel.DrawText("%i Tele Frags", Session[client].Telefrags);
			panel.DrawText("%i Buildings built", Session[client].BuildingsBuilt);
			panel.DrawText("%i Buildings destroyed", Session[client].BuildingsDestroyed);
			panel.DrawText("%i Sappers placed", Session[client].SappersPlaced);
			panel.DrawText("%i Sappers destroyed", Session[client].SappersDestroyed);
			panel.DrawText("%i Coated with milk", Session[client].MadMilked);
			panel.DrawText("%i Coated with jar", Session[client].Jarated);
			panel.DrawText("%i Extinguished", Session[client].Extinguished);
			panel.DrawText("%i Ignited", Session[client].Ignited);
			if(TF2_IsMvMGameMode())	{
				panel.DrawText("%i Sentry busters killed", Session[client].SentryBustersKilled);
				panel.DrawText("%i Times you've resetted the bomb.", Session[client].BombsResetted);
				panel.DrawText("%i Tanks destroyed", Session[client].TanksDestroyed);
			}
		}
		case Game_TF2C:	{
			panel.DrawItem("TF Stats");
			panel.DrawText("%i Dominations", Session[client].Dominations);
			panel.DrawText("%i Revenges", Session[client].Revenges);
			panel.DrawText("%i Headshots", Session[client].Headshots);
			panel.DrawText("%i Noscopes", Session[client].Noscopes);
			panel.DrawText("%i Backstabs", Session[client].Backstabs);
			panel.DrawText("%i Airshots", Session[client].Airshots);
			panel.DrawText("%i Deflects", Session[client].Deflects);
			panel.DrawText("%i Gibs", Session[client].Gibs);
			panel.DrawText("%i Critkills", Session[client].Critkills);
			panel.DrawText("%i Tauntkills", Session[client].Tauntkills);
			panel.DrawText("%i Telefrags", Session[client].Telefrags);
			panel.DrawText("%i Buildings built", Session[client].BuildingsBuilt);
			panel.DrawText("%i Buildings destroyed", Session[client].BuildingsDestroyed);
			panel.DrawText("%i Sappers placed", Session[client].SappersPlaced);
			panel.DrawText("%i Sappers destroyed", Session[client].SappersDestroyed);
			panel.DrawText("%i Extinguished", Session[client].Extinguished);
			panel.DrawText("%i Ignited", Session[client].Ignited);
		}
		case Game_TF2OP:	{
			panel.DrawItem("TF Stats");
			panel.DrawText("%i Dominations", Session[client].Dominations);
			panel.DrawText("%i Revenges", Session[client].Revenges);
			panel.DrawText("%i Headshots", Session[client].Headshots);
			panel.DrawText("%i Noscopes", Session[client].Noscopes);
			panel.DrawText("%i Backstabs", Session[client].Backstabs);
			panel.DrawText("%i Airshots", Session[client].Airshots);
			panel.DrawText("%i Deflects", Session[client].Deflects);
			panel.DrawText("%i Gibs", Session[client].Gibs);
			panel.DrawText("%i Critkills", Session[client].Critkills);
			panel.DrawText("%i Tauntkills", Session[client].Tauntkills);
			panel.DrawText("%i Telefrags", Session[client].Telefrags);
			panel.DrawText("%i Buildings built", Session[client].BuildingsBuilt);
			panel.DrawText("%i Buildings destroyed", Session[client].BuildingsDestroyed);
			panel.DrawText("%i Sappers placed", Session[client].SappersPlaced);
			panel.DrawText("%i Sappers destroyed", Session[client].SappersDestroyed);
			panel.DrawText("%i Extinguished", Session[client].Extinguished);
			panel.DrawText("%i Ignited", Session[client].Ignited);
		}
		case Game_CSS, Game_CSPromod, Game_CSGO, Game_CSCO:	{
			panel.DrawItem("CS Stats");
			panel.DrawText("%i Dominations", Session[client].Dominations);
			panel.DrawText("%i Revenges", Session[client].Revenges);
			panel.DrawText("%i Headshots", Session[client].Headshots);
			panel.DrawText("%i Noscopes", Session[client].Noscopes);
			panel.DrawText("%i Through smoke kills", Session[client].SmokeKills);
			panel.DrawText("%i Blinded kills", Session[client].BlindKills);
			panel.DrawText("%i Grenade kills", Session[client].GrenadeKills);
			panel.DrawText("%i Money spent", Session[client].MoneySpent);
		}
	}
	
	panel.DrawSpace();
	panel.DrawItem("Back");
	panel.DrawItem("Exit");
	panel.Send(client, RankPanelCallback2, MENU_TIME_FOREVER);
	
	StatsPanel[client].Session = true;
}

/* Total Statistics */
stock void RankPanel_TotalStatistics(int client) {
	if(DB.Threaded == null) {
		CPrintToChat(client, "%s The threaded database connection is unavailable, please contact the server author.", Global.Prefix);
		return;
	}
	
	switch(Global.Game)	{
		case Game_TF2: TotalStatistics_TF2(client);
	}
}

#include "xstats/rankpanel/tf.sp"

/**
 *	Rank panel callback.
 */
stock int RankPanelCallback2(Menu panel, MenuAction action, int client, int selection) {
	switch(selection) {
		/**
		 * 1: Session.
		 * 2: Stats.
		 * 3: Back.
		 * 4. Exit.
		 */
		case 3:	RankPanel(client);
		case 4: StatsPanel[client].Session = false;
	}
}

stock void OnDeathRankPanel(int client) {
	if(StatsPanel[client].Main)
		RankPanel(client);
	else if(StatsPanel[client].Session)
		RankPanel_CurrentSession(client);
	else if(StatsPanel[client].TotalPage > 0)
		RankPanel_TotalPage(client, StatsPanel[client].TotalPage);
}

stock void RankPanel_TotalPage(int client, int page) {
	switch(Global.Game) {
		case Game_TF2: RankPanel_Total_TF2(client, page);
	}
}

stock int Panel_TotalStatisticsCallback(Menu menu, MenuAction action, int client, int selection) {
	int page;
	switch((page = StatsPanel[client].TotalPage)) {
		case 1:	{
			/**
			 * 1: Panel info.
			 * 2: Total statistics.
			 * 3: Back.
			 * 4: Next.
			 * 5: Exit.
			 */
			switch(selection) {
				case 1: RankPanel_TotalPage(client, page);
				case 2: RankPanel_TotalPage(client, page);
				case 3:	RankPanel(client);
				case 4: RankPanel_TotalPage(client, page+1);
				case 5:	{
					StatsPanel[client].Main = false;
					StatsPanel[client].Session = false;
					StatsPanel[client].TotalPage = 0;
				}
			}
		}
		
		case 2:	{
			/**
			 * 1: Panel info.
			 * 2: Back.
			 * 3: Next.
			 * 4: Exit.
			 */
			switch(selection) {
				case 1: RankPanel_TotalPage(client, page);
				case 2: RankPanel_TotalPage(client, page-1);
				case 3:	RankPanel_TotalPage(client, page+1);
				case 4:	{
					StatsPanel[client].Main = false;
					StatsPanel[client].Session = false;
					StatsPanel[client].TotalPage = 0;
				}
			}
		}
		
		case 3:	{
			/**
			 * 1: Panel info.
			 * 2: Back.
			 * 3: Next.
			 * 4: Exit.
			 */
			switch(selection) {
				case 1: RankPanel_TotalPage(client, page);
				case 2: RankPanel_TotalPage(client, page-1);
				case 3:	RankPanel_TotalPage(client, page+1);
				case 4:	{
					StatsPanel[client].Main = false;
					StatsPanel[client].Session = false;
					StatsPanel[client].TotalPage = 0;
				}
			}
		}
		
		case 4:	{
			/**
			 * 1: Panel info.
			 * 2: Back.
			 * 3: Exit.
			 */
			switch(selection) {
				case 1: RankPanel_Total_TF2(client, page);
				case 2:	RankPanel_Total_TF2(client, page-1);
				case 3: {
					StatsPanel[client].Main = false;
					StatsPanel[client].Session = false;
					StatsPanel[client].TotalPage = 0;
				}
			}
		}
	}
}