/**
 *	Includes
 */
#include "xstats/rankpanel.sp"


void PrepareCommands()	{
	RegConsoleCmd("rank", RankCmd, "Xstats - Returns the rank position.");
	RegConsoleCmd("xstats", XStatsCmd, "Xstats - About the project.");
}

Action RankCmd(int client, int args)	{
	return RankPanel(client, args);
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