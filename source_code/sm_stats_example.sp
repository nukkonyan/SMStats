#include <sm_stats>
#include <sm_stats_core>
#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0

public void OnPluginStart()
{
	RegAdminCmd("sm_smstats_testban", CallbackCmd, ADMFLAG_ROOT);
}

Action CallbackCmd(int client, int args)
{
	char text[28];
	if(!GetCmdArg(1, text, sizeof(text)))
	{
		ReplyToCommand(client, "sm_smstats_testban <ip>");
		return Plugin_Handled;
	}
	
	_sm_stats_detect_ban_player_ip(text, true);
	
	return Plugin_Continue;
}