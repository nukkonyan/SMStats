/**
 *	Includes
 */
#include "xstats/rankpanel.sp"


void PrepareCommands()	{
	RegConsoleCmd("rank", RankCmd, "Xstats - Returns the rank position.");
	RegConsoleCmd("xstats", XStatsCmd, "Xstats - About the project.");
}

Action RankCmd(int client, int args=-1)	{
	Database database = SQL_Connect2(Xstats, false);
	
	if(database == null)	{
		CPrintToChat(client, "%s The database connection is unavailable, please contact the server author.", Prefix);
		delete database;
		return	Plugin_Handled;
	}
	
	DBResultSet results = SQL_QueryEx(database,
	"select Playername, Points, PlayTime, Kills, Assists, Deaths, Suicides, DamageDone from `%s` where SteamID='%s' and ServerID='%i'",
	playerlist, SteamID[client], ServerID.IntValue);
	
	if(results == null)	{
		CPrintToChat(client, "%s You don't seem to be on the database, you may try rejoin or contact the server author.", Prefix);
		delete database;
		delete results;
		return	Plugin_Handled;
	}
	
	if(!results.FetchRow())	{
		CPrintToChat(client, "%s Player stats were unable to be fetched from the database, please contact the server author.", Prefix);
		delete database;
		delete results;
		return	Plugin_Handled;
	}
	
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
	int damagedone = results.FetchInt(7);
	float kdr = GetKDR(kills, deaths, assists);
	
	XStatsRankPanel panel = new XStatsRankPanel();
	panel.DrawItem("Xstats Panel");
	panel.DrawText("Playername: %s", playername);
	panel.DrawText("Position #%i out of %i players", position, players);
	panel.DrawText(" ");
	panel.DrawItem("Current Session");
	panel.DrawText("%i Points", Session[client].Points);
	panel.DrawText("%i Minutes played", Session[client].Time);
	panel.DrawText("%i Kills", Session[client].Kills);
	panel.DrawText("%i Assists", Session[client].Assists);
	panel.DrawText("%i Deaths", Session[client].Deaths);
	panel.DrawText("%i Suicides", Session[client].Suicides);
	panel.DrawText("%i Damage dealt", Session[client].DamageDone);
	panel.DrawText("KDR: %.2f", GetKDR(Session[client].Kills, Session[client].Deaths, Session[client].Assists));
	panel.DrawText(" ");
	panel.DrawItem("Total Statistics");
	panel.DrawText("%i Points", points);
	panel.DrawText("%i Total minutes played", playtime);
	panel.DrawText("%i Kills", kills);
	panel.DrawText("%i Assists", assists);
	panel.DrawText("%i Deaths", deaths);
	panel.DrawText("%i Suicides", suicides);
	panel.DrawText("%i Damage dealt", damagedone);
	panel.DrawText("KDR: %.2f", kdr);
	panel.DrawText(" ");
	panel.DrawItem("Exit");
	panel.Send(client, RankPanelCallback, MENU_TIME_FOREVER);
	delete panel;
	
	CPrintToChat(client, "%s %s is positioned #%i out of %i players with %.2f KDR and %i total minutes in playtime",
	Prefix, Name[client], position, players, kdr, playtime);
	
	delete database;
	delete results;
	
	return	Plugin_Handled;
}

Action XStatsCmd(int client, int args=-1)	{
	if(!Tklib_IsValidClient(client, true))	{
		ReplyToCommand(client, "You may only use this ingame.");
		return	Plugin_Handled;
	}
	
	CPrintToChat(client, "{green}XStats {default}is a solo project created and managed by {orange}Teamkiller324 (/id/Teamkiller324)");
	CPrintToChat(client, "Running version {lightgreen}%s", Version);
	CPrintToChat(client, "More info @ https://teamkiller324.github.io/XStats/");
	return	Plugin_Handled;
}