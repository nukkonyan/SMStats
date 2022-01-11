void PrepareCommands()	{
	RegConsoleCmd("rank", RankCmd, "Xstats - returns the rank position.");
	RegConsoleCmd("sm_rank", RankCmd, "Xstats - Returns the rank position.");
}

Action RankCmd(int client, int args)	{
	Database database = SQL_Connect2(Xstats, false);
	
	if(database == null)	{
		CPrintToChat(client, "%s The database connection is unavailable, please contact the server author.", Prefix);
		delete database;
		return	Plugin_Handled;
	}
	
	GetClientAuth(client, SteamID[client], sizeof(SteamID[]));
	DBResultSet results = SQL_QueryEx(database, "select Playername, Points, PlayTime, Kills, Assists, Deaths, Suicides from `%s` where SteamID='%s'",
	playerlist, SteamID[client]);
	
	if(results == null)	{
		CPrintToChat(client, "%s The database query failed, please contact the server author.", Prefix);
		delete database;
		delete results;
		return	Plugin_Handled;
	}
	
	if(results.FetchRow())	{
		char playername[64];
		results.FetchString(0, playername, sizeof(playername));
		
		int position = GetClientPosition(SteamID[client]);
		int players = GetTablePlayerCount();
		
		int points = results.FetchInt(1);
		int playtime = results.FetchInt(2);
		int kills = results.FetchInt(3);
		int assists = results.FetchInt(4);
		int deaths = results.FetchInt(5);
		int suicides = results.FetchInt(6);
		
		float kdr = GetKDR(kills, deaths, assists);
		
		char info[256];
		Panel panel = new Panel();
		panel.SetTitle("xStats Panel");
		panel.DrawText(" ");
		
		Format(info, sizeof(info), "Playername : %s", playername);
		panel.DrawText(info);
		
		Format(info, sizeof(info), "Position #%i", position);
		panel.DrawText(info);
		
		panel.DrawText(" ");
		
		panel.DrawItem("Current Session");
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
		
		Format(info, sizeof(info), "KDR Ratio: %.2f", GetKDR(Session[client].Kills, Session[client].Deaths, Session[client].Assists));
		panel.DrawText(info);
		
		panel.DrawText(" ");
		
		panel.DrawItem("Total Statistics");
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
		
		Format(info, sizeof(info), "KDR Ratio: %.2f", kdr);
		panel.DrawText(info);
		
		panel.DrawText(" ");
		panel.DrawItem("Exit");
		panel.Send(client, PanelCallback, 120);
		delete panel;
		
		GetClientTeamString(client, Name[client], sizeof(Name[]));
		CPrintToChat(client, "%s %s is positioned #%i out of %i players with %.2f KDR Radio and %i total minutes in playtime",
		Prefix, Name[client], position, players, kdr, playtime);
	}
	
	return	Plugin_Handled;
}