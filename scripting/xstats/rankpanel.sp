/**
 *	Rank panel callback.
 */
stock int RankPanelCallback(Menu panel, MenuAction action, int client, int selection)
{
	switch(selection)
	{
		/* Current Session */
		case	1:	RankPanel_CurrentSession(client);
		/* Total Statistics */
		case	2:	RankPanel_TotalStatistics(client);
	}
}

/* Current Session */
stock void RankPanel_CurrentSession(int client)
{
	XStatsRankPanel panel = new XStatsRankPanel();
	panel.DrawItem("Xstats Panel: Current Session");
	
	/* Insert the generic ones first */
	panel.DrawText("%i Points", Session[client].Points);
	panel.DrawText("%i Minutes played", Session[client].Time);
	panel.DrawText("%i Kills", Session[client].Kills);
	panel.DrawText("%i Assists", Session[client].Assists);
	panel.DrawText("%i Deaths", Session[client].Deaths);
	panel.DrawText("%i Suicides", Session[client].Suicides);
	panel.DrawText("%i Damage dealt", Session[client].DamageDone);
	panel.DrawText("KDR: %.2f", GetKDR(Session[client].Kills, Session[client].Deaths, Session[client].Assists));
	panel.DrawText(" ");
	
	switch(IdentifyGame())
	{
		case	Game_TF2, Game_TF2C, Game_TF2V, Game_TF2OP:
		{
			panel.DrawItem("TF2 Stats");
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
			panel.DrawText("%i Scouts Killed", Session[client].ScoutsKilled);
			panel.DrawText("%i Soldiers Killed", Session[client].SoldiersKilled);	
			panel.DrawText("%i Pyros Killed", Session[client].PyrosKilled);
			panel.DrawText("%i Demos Killed", Session[client].DemosKilled);
			panel.DrawText("%i Heavies Killed", Session[client].HeaviesKilled);
			panel.DrawText("%i Engies Killed", Session[client].EngiesKilled);
			panel.DrawText("%i Medics Killed", Session[client].MedicsKilled);
			panel.DrawText("%i Snipers Killed", Session[client].SnipersKilled);
			panel.DrawText("%i Spies Killed", Session[client].SpiesKilled);
			if(IsCurrentGame(Game_TF2C))
				panel.DrawText("%i Civilians Killed", Session[client].CiviliansKilled);
			panel.DrawText("%i Buildings Built", Session[client].BuildingsBuilt);
			panel.DrawText("%i Buildings Destroyed", Session[client].BuildingsDestroyed);
			panel.DrawText("%i Sappers Placed", Session[client].SappersPlaced);
			panel.DrawText("%i Sappers Destroyed", Session[client].SappersDestroyed);
		}
		case	Game_CSS, Game_CSPro, Game_CSGO, Game_CSCO:
		{
			
		}
	}
	
	panel.DrawText(" ");
	panel.DrawItem("Exit");
	panel.Send(client, PanelCallback, MENU_TIME_FOREVER);
	delete panel;
}

/* Total Statistics */
stock void RankPanel_TotalStatistics(int client)
{
	
}