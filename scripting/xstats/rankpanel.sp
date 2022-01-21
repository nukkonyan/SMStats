/**
 *	Rank panel callback.
 */
stock int RankPanelCallback(Menu panel, MenuAction action, int client, int selection)	{
	switch(selection)	{
		/**
		 * 1: Panel info.
		 * 2: Session.
		 * 3: Stats.
		 * 4. Exit.
		 */
		case	1:	XStatsCmd(client);
		case	2:	RankPanel_CurrentSession(client);
		case	3:	RankPanel_TotalStatistics(client);
	}
}

/* Current Session */
stock void RankPanel_CurrentSession(int client)	{
	XStatsRankPanel panel = new XStatsRankPanel();
	panel.DrawItem("XStats Panel: Current Session");
	
	/* Insert the generic ones first */
	panel.DrawText("%i Points", Session[client].Points);
	panel.DrawText("%i Minutes played", Session[client].Time);
	panel.DrawText("%i Kills", Session[client].Kills);
	panel.DrawText("%i Assists", Session[client].Assists);
	panel.DrawText("%i Deaths", Session[client].Deaths);
	panel.DrawText("%i Suicides", Session[client].Suicides);
	panel.DrawText("%i Mid-air kills", Session[client].MidAirKills);
	panel.DrawText("%i Damage dealt", Session[client].DamageDone);
	panel.DrawText("KDR: %.2f", GetKDR(Session[client].Kills, Session[client].Deaths, Session[client].Assists));
	panel.DrawText(" ");
	
	switch(game)	{
		case Game_TF2, Game_TF2V:	{
			panel.DrawItem("TF Stats");
			panel.DrawText("%i Dominations", Session[client].Dominations);
			panel.DrawText("%i Revenges", Session[client].Revenges);
			panel.DrawText("%i Headshots", Session[client].Headshots);
			panel.DrawText("%i Noscopes", Session[client].Noscopes);
			panel.DrawText("%i Backstabs", Session[client].Backstabs);
			panel.DrawText("%i Airshots", Session[client].Airshots);
			panel.DrawText("%i Deflect Kills", Session[client].DeflectKills);
			panel.DrawText("%i Gib Killls", Session[client].GibKills);
			panel.DrawText("%i Crit Kills", Session[client].CritKills);
			panel.DrawText("%i Taunt Kills", Session[client].TauntKills);
			panel.DrawText("%i Tele Frags", Session[client].TeleFrags);
			panel.DrawText("%i Buildings Built", Session[client].BuildingsBuilt);
			panel.DrawText("%i Buildings Destroyed", Session[client].BuildingsDestroyed);
			panel.DrawText("%i Sappers Placed", Session[client].SappersPlaced);
			panel.DrawText("%i Sappers Destroyed", Session[client].SappersDestroyed);
			panel.DrawText("%i Coated with milk", Session[client].MadMilked);
			panel.DrawText("%i Coated with jar", Session[client].Jarated);
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
			panel.DrawText("%i Deflect Kills", Session[client].DeflectKills);
			panel.DrawText("%i Gib Killls", Session[client].GibKills);
			panel.DrawText("%i Crit Kills", Session[client].CritKills);
			panel.DrawText("%i Taunt Kills", Session[client].TauntKills);
			panel.DrawText("%i Tele Frags", Session[client].TeleFrags);
			panel.DrawText("%i Buildings Built", Session[client].BuildingsBuilt);
			panel.DrawText("%i Buildings Destroyed", Session[client].BuildingsDestroyed);
			panel.DrawText("%i Sappers Placed", Session[client].SappersPlaced);
			panel.DrawText("%i Sappers Destroyed", Session[client].SappersDestroyed);
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
			panel.DrawText("%i Deflect Kills", Session[client].DeflectKills);
			panel.DrawText("%i Gib Killls", Session[client].GibKills);
			panel.DrawText("%i Crit Kills", Session[client].CritKills);
			panel.DrawText("%i Taunt Kills", Session[client].TauntKills);
			panel.DrawText("%i Tele Frags", Session[client].TeleFrags);
			panel.DrawText("%i Buildings Built", Session[client].BuildingsBuilt);
			panel.DrawText("%i Buildings Destroyed", Session[client].BuildingsDestroyed);
			panel.DrawText("%i Sappers Placed", Session[client].SappersPlaced);
			panel.DrawText("%i Sappers Destroyed", Session[client].SappersDestroyed);
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
	
	panel.DrawText(" ");
	panel.DrawItem("Back");
	panel.DrawItem("Exit");
	panel.Send(client, RankPanelCallback2, MENU_TIME_FOREVER);
	delete panel;
}

/* Total Statistics */
stock void RankPanel_TotalStatistics(int client)	{
	
}

/**
 *	Rank panel callback.
 */
stock int RankPanelCallback2(Menu panel, MenuAction action, int client, int selection)	{
	switch(selection)	{
		/**
		 * 1: Session.
		 * 2: Stats.
		 * 3: Back.
		 * 4. Exit.
		 */
		case	3:	RankCmd(client);
	}
}