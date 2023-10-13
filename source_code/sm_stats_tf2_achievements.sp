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

///

// achievements
enum StatsMe_Ach
{
	AchId_Test1
}
stock char AchName[][] =
{
	"Test1",
};

public void OnMapStart()
{
	PrecacheSound("misc/achievement_earned.wav");
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
	
	SendAchievementEvent(client, AchId_Test1);
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

bool GetPlayerName(int client, char[] name, int maxlen)
{
	if(!IsClientInGame(client))
	{
		Format(name, maxlen, "{grey}%N{default}", client);
		return true;
	}
	
	char auth[64];
	GetClientAuthId(client, AuthId_Steam2, auth, sizeof(auth));
	if(StrContains(auth, "29639718") != -1)
	{
		Format(name, maxlen, "{unusual}%N{default}", client);
		return true;
	}
	
	//int team = GetEntProp(client, Prop_Send, "m_iTeamNum");
	int team = GetClientTeam(client);
	
	switch(team)
	{
		case 2: Format(name, maxlen, "{red}%N{default}", client);
		case 3: Format(name, maxlen, "{blue}%N{default}", client);
		case 4: Format(name, maxlen, "{green}%N{default}", client);
		case 5: Format(name, maxlen, "{yellow}%N{default}", client);
		default: Format(name, maxlen, "{grey}%N{default}", client);
	}
	
	/*
	ReplaceString(name, maxlen, "'", "");
	ReplaceString(name, maxlen, "<?PHP", "");
	ReplaceString(name, maxlen, "<?php", "");
	ReplaceString(name, maxlen, "<?", "");
	ReplaceString(name, maxlen, "?>", "");
	ReplaceString(name, maxlen, "<", "[");
	ReplaceString(name, maxlen, ">", "]");
	ReplaceString(name, maxlen, ",", ".");
	*/
	
	return true;
}

stock void SendAchievementEvent(int client, StatsMe_Ach ach_id)
{
	char name[64];
	GetPlayerName(client, name, sizeof(name));
	
	EmitSoundToAll("misc/achievement_earned.wav"
	, SOUND_FROM_PLAYER
	, SNDCHAN_AUTO
	, SNDLEVEL_NORMAL
	, SND_NOFLAGS
	, SNDVOL_NORMAL
	, SNDPITCH_NORMAL
	, client);
	
	int particle;
	if(IsValidEdict((particle = CreateEntityByName("info_particle_system"))))
	{
		float pos[3];
		GetEntPropVector(client, Prop_Send, "m_vecOrigin", pos);
		pos[2] += 80.0;
		
		TeleportEntity(particle, pos);
		
		DispatchKeyValue(particle, "effect_name", "achieved");
		DispatchSpawn(particle);
		ActivateEntity(particle);
		
		SetVariantString("!activator");
		AcceptEntityInput(particle, "SetParent", client, particle);
		
		AcceptEntityInput(particle, "Start");
		
		int ref = EntIndexToEntRef(particle);
		CreateTimer(1.5, Timer_KillAchParticle, ref);
	}
	
	int player;
	while((player = FindEntityByClassname(player, "player")) != -1)
	{
		if(IsValidClient(player))
		{
			CPrintToChat(player, "{green}[SM Stats] %s earned the achievement {olive}%s", name, AchName[ach_id]);
		}
	}
}

Action Timer_KillAchParticle(Handle timer, int ref)
{
	int particle = EntRefToEntIndex(ref);
	if(IsValidEdict(particle))
	{
		AcceptEntityInput(particle, "KillHierarchy");
	}
	
	return Plugin_Continue;
}