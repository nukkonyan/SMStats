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
	int client = 0;
	
	while((client = FindEntityByClassname(client, "player")) > 0)
	{		
		if(!IsClientInGame(client))
		{
			continue;
		}
		
		if(IsFakeClient(client))
		{
			continue;
		}
		
		CPrintToChat(client, "{lightgreen}%s {default}%T", core_chattag, "#SMStats_UpdateFound", client);
	}
}

public void Updater_OnPluginUpdated()
{
	int client = 0;
	
	while((client = FindEntityByClassname(client, "player")) > 0)
	{
		if(!IsClientInGame(client))
		{
			continue;
		}
		
		if(IsFakeClient(client))
		{
			continue;
		}
		
		CPrintToChat(client, "{lightgreen}%s {default}%T", core_chattag, "#SMStats_UpdateFinished", client, Version);
	}
}

Action Timer_CheckForUpdate(Handle timer)
{
	Updater_ForceUpdate();
	
	return Plugin_Continue;
}