void PrepareCommands()
{
	RegConsoleCmd("rank", RankCmd, "xStats - returns the rank position.");
	RegConsoleCmd("sm_rank", RankCmd, "xStats - Returns the rank position.");
}

Action RankCmd(int client, int args)
{
	Database database = SQL_Connect2("xstats", false);
	
	if(database == null)
	{
		CPrintToChat(client, "%s The database connection is unavailable, please contact the server author.", Prefix);
		delete database;
		return	Plugin_Handled;
	}
	
	char auth[64];
	GetClientAuth(client, auth, sizeof(auth));
	
	DBResultSet results = SQL_QueryEx(database, "select Playername, Points, PlayTime, Kills, Assists, Deaths, Suicides from `%s` where SteamID='%s'",
	playerlist, auth);
	
	if(results == null)
	{
		CPrintToChat(client, "%s The database query failed, please contact the server author.", Prefix);
		delete database;
		delete results;
		return	Plugin_Handled;
	}
	
	if(results.FetchRow())
	{
		char playername[64];
		results.FetchString(0, playername, sizeof(playername));
		
		int points = results.FetchInt(1);
		int playtime = results.FetchInt(2);
		int kills = results.FetchInt(3);
		int assists = results.FetchInt(4);
		int deaths = results.FetchInt(5);
		int suicides = results.FetchInt(6);
		
		char info[256];
		Panel panel = new Panel();
		panel.SetTitle("xStats Panel");
		panel.DrawText(" ");
		
		Format(info, sizeof(info), "Playername : %s", playername);
		panel.DrawText(info);
		panel.DrawText(" ");
		
		panel.DrawText("Current Session");
		panel.DrawText(" ");
		
		Format(info, sizeof(info), "%i Points", Session[client].Points);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Minutes played", Session[client].Time);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Kills", Session[client].Kills);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Assists", Session[client].Assists);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Deaths", Session[client].Deaths);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Suicides", Session[client].Suicides);
		panel.DrawText(info);
		
		panel.DrawText(" ");
		
		panel.DrawText("Total Statistics");
		Format(info, sizeof(info), "%i Points", points);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Total minutes played", playtime);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Kills", kills);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Assists", assists);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Deaths", deaths);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "%i Suicides", suicides);
		panel.DrawText(info);
		panel.DrawText(" ");
		
		panel.DrawItem("Exit");
		
		
		panel.Send(client, PanelCallback, 60);
		delete panel;
	}
	
	return	Plugin_Handled;
}