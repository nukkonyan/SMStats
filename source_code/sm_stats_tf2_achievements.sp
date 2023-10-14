#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0
#define Version "1.0.0"
#define VersionAlt "v" ... Version
#define MaxPlayers 33 // 101 cuz -unrestricted_maxplayers ?
#define GameTag "tf2"
#define core_chattag "[SM Stats: TF2 Achievements]"
#define core_chattag2 "SM Stats: TF2 Achievements"
#define load_menus

// in active development, this is subject to change completely. This is a testing only, early prototype.

#include <sm_stats>
#include <sm_stats_core>
#include <multicolors>
#include <tf2_stocks>

// updater
#define UpdaterURL "https://raw.githubusercontent.com/Teamkiller324/SMStats/main/sm_updater/SMStats_TF2_Achievements.txt"
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

#include "sm_stats/functions.sp"

///

// achievements
enum StatsMe_Ach
{
	AchId_Test1,
	AchId_Test2,
	AchId_Test3,
}
stock char AchName[][] =
{
	"Test1",
	"Test2",
	"Test3",
};
stock char AchDescription[][] =
{
	//Test1
	"get 69 kills lmao",
	//Test2
	"insert dank text here",
	//Test3
	"420 blaze it"
};

int g_AchCount = 3;

enum struct AchievementsStruct
{
	bool bAch_Test1;
	
	void Reset()
	{
		this.bAch_Test1 = false;
	}
}

AchievementsStruct g_Ach[MaxPlayers+1];

#include "sm_stats_tf2/achievements/menus.sp"

//

public void OnMapStart()
{
	PrecacheSound("misc/achievement_earned.wav");
}

void PrepareGame()
{
	
}

public void OnClientConnected(int client)
{
	
}

public void OnClientDisconnect_Post(int client)
{
	g_Ach[client].Reset();
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
			CPrintToChat(player, "{green}[SM Stats] %T", "#SMStats_AchEvent", client, name, AchName[ach_id]);
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