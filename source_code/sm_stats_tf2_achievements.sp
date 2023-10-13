#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0
#define MaxPlayers 33
#define Version "1.0.0"
#define GameTag "tf2"
#define core_chattag "[SM Stats: TF2 Achievements]"
#define core_chattag2 "SM Stats: TF2 Achievements"

// in active development, subject to change completely. This is a testing only.

#include <sm_stats>
#include <multicolors>
#include <tf2_stocks>

// updater
#define UpdaterURL "https://raw.githubusercontent.com/Teamkiller324/SMStats/main/sm_updater/SMStats_TF2.txt"
#include "sm_stats/updater.sp"

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	char gamefolder[16];
	GetGameFolderName(gamefolder, sizeof(gamefolder));
	
	if(!StrEqual(gamefolder, "tf"))
	{
		SetFailState("This SM Stats game addon may only be running in:"
		... "\nTeam Fortress 2."
		);
	}
	
	return APLRes_Success;
}

public Plugin myinfo =
{
	name = "SM Stats: Team Fortress 2 - Achievements",
	author = "teamkiller324",
	description = "SM Stats: TF2 achievements module",
	version = Version,
	url = "https://github.com/Teamkiller324"
}

public void SMStats_OnPlayerDeath(int attacker, int frags, int[] userid, int[] assister, const char[] classname, int[] itemdef)
{
	int client = GetClientOfUserId(attacker);
	
	for(int i = 0; i < frags; i++)
	{
		int victim = GetClientOfUserId(userid[i]);
		int assist = GetClientOfUserId(assister[i]);
		
		switch(assist > 0)
		{
			case false:
			{
				PrintToChat(client, "fragged %N (no assister) with itemdef %i (classname '%s')", victim, itemdef[i], classname);
			}
			case true:
			{
				PrintToChat(client, "fragged %N (assister: %N) with itemdef %i (classname '%s')", victim, assist, itemdef[i], classname);
			}
		}
	}
}

//

stock bool IsValidClient(int client, bool bIsFakeClient=true, bool bIsValidEntity=false)
{
	if(client < 1 || client > MaxPlayers)
	{
		return false;
	}
	
	if(bIsValidEntity)
	{
		if(!IsValidEntity(client))
		{
			return false;
		}
	}
	
	if(!IsClientConnected(client))
	{
		return false;
	}
	
	if(IsClientReplay(client))
	{
		return false;
	}
	
	if(IsClientSourceTV(client))
	{
		return false;
	}
	
	if(bIsFakeClient)
	{
		if(IsFakeClient(client))
		{
			return false;
		}
	}
	
	return true;
}