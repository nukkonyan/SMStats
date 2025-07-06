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
		LogToGame(core_chattag..." : Adding plugin to updater..");
		Updater_AddPlugin(UpdaterURL);
		Updater_ForceUpdate();
		bUpdaterURLAdded = true;
	}
	
	return Plugin_Continue;
}

public void OnLibraryAdded(const char[] name)
{
	if(strcmp(name, "updater") == 0)
	{
		if(!bUpdaterURLAdded)
		{
			LogToGame(core_chattag..." : Adding plugin to updater..");
			Updater_AddPlugin(UpdaterURL);
		}
		
		if(!g_CheckUpdateTimer)
		{
			PrintToServer(core_chattag..." : Adding 5 minute timer update check repeater");
			g_CheckUpdateTimer = CreateTimer(300.0, Timer_CheckForUpdate, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
		}
	}
}

public void Updater_OnPluginUpdating()
{
	int client = 0;
	while((client = FindEntityByClassname(client, "player")) > 0)
	{
		#if defined updater_info
		SMStatsInfo.SavePlayerInfo(client, g_Player[client]);
		#endif
		#if defined updater_gamestats
		SMStatsInfo.SaveGameStats(client, g_Game[client]);
		#endif
		
		if(!IsFakeClient(client))
		{
			CPrintToChat(client, "{lightgreen}%s {default}%T", core_chattag, "#SMStats_UpdateFound", client);
		}
	}
}

Action Timer_CheckForUpdate(Handle timer)
{
	Updater_ForceUpdate();
	return Plugin_Continue;
}