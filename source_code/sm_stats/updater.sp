#undef REQUIRE_PLUGIN
#include <updater>

Handle g_CheckUpdateTimer;
bool bUpdaterURLAdded = false;

public void Updater_OnLoaded()
{
	CreateTimer(5.0, Timer_PrepareUpdater);
}

Action Timer_PrepareUpdater(Handle timer)
{
	if(IsUpdaterAvailable())
	{
		PrintToServer("%s Adding plugin to updater..", core_chattag);
		Updater_AddPlugin(UpdaterURL);
		Updater_ForceUpdate();
		bUpdaterURLAdded = true;
	}
	
	return Plugin_Continue;
}

public void OnLibraryAdded(const char[] name)
{
	if(StrEqual(name, "updater", false))
	{
		if(!bUpdaterURLAdded)
		{
			PrintToServer("%s Adding plugin to updater..", core_chattag);
			Updater_AddPlugin(UpdaterURL);
		}
		
		if(!g_CheckUpdateTimer)
		{
			PrintToServer("%s Adding 5 minute timer update check repeater", core_chattag);
			g_CheckUpdateTimer = CreateTimer(300.0, Timer_CheckForUpdate, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
		}
	}
}

public void Updater_OnPluginUpdating()
{
	#if defined updater_info
	_sm_stats_info_save_crucial_stuff(bLoaded, bStatsActive, bRoundActive, iMapTimerSeconds);
	if(DEBUG) PrintToServer("Updater_OnPluginUpdated()"
	... "\nbLoaded : %s"
	... "\nbStatsActive : %s"
	... "\nbRoundActive : %s"
	... "\niMapTimerSeconds : %i"
	, bLoaded ? "true" : "false"
	, bStatsActive ? "true" : "false"
	, bRoundActive ? "true" : "false"
	, iMapTimerSeconds);
	#endif
	
	int client = 0;
	while((client = FindEntityByClassname(client, "player")) > 0)
	{
		#if defined updater_info
		SMStatsInfo.SavePlayerStats(client, g_Player[client]);
		#endif
		#if defined updater_gamestats
		SMStatsInfo.SaveGameStats(client, g_Game[client]);
		#endif
		
		if(IsClientInGame(client))
		{
			if(!IsFakeClient(client))
			{
				CPrintToChat(client, "{lightgreen}%s {default}%T", core_chattag, "#SMStats_UpdateFound", client);
			}
		}
	}
}

Action Timer_CheckForUpdate(Handle timer)
{
	Updater_ForceUpdate();
	return Plugin_Continue;
}