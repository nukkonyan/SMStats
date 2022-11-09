#define UpdateUrl "https://raw.githubusercontent.com/Teamkiller324/XStats/main/addons/sourcemod/XStatsUpdater.txt"

/**
 *	Initialize updater addition.
 */
public void Updater_OnLoaded() {	
	CreateTimer(5.0, Timer_PrepareUpdater);
	XStats_DebugText(false, "Initializing 5 second delay for the update check on plugin startup.");
}

Action Timer_PrepareUpdater(Handle timer)	{
	if(!IsUpdaterAvailable()) {
		KillTimerEx(timer);
		return Plugin_Handled;
	}
	
	Updater_AddPlugin(UpdateUrl);
	Updater_ForceUpdate();
	
	return Plugin_Handled;
}

public void OnLibraryAdded(const char[] name)	{
	if(StrEqual(name, "updater")) {
		XStats_DebugText(false, "Updater plugin was detected, adding plugin to update list..");
		Updater_AddPlugin(UpdateUrl);
		
		if(Global.UpdateTimer == null)	{
			XStats_DebugText(false, "Creating 5 minute long automatic update checker.");
			Global.UpdateTimer = CreateTimer(300.0, Timer_CheckForUpdate, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
		}
	}
}

public void Updater_OnPluginUpdated()	{
	XStats_DebugText(false, "New update found and installed, Restarting plugin..");	
	TargetLoop(client) {
		if(Tklib_IsValidClient(client, true))
			CPrintToChat(client, "%s %t", Global.Prefix, "Update Found");
	}
	
	Updater_ReloadPlugin();
}

stock Action Timer_CheckForUpdate(Handle timer)	{	
	XStats_DebugText(false, "Checking for new update..");
	XStats_DebugText(false, "Current version: %s\n", Version);
	Updater_ForceUpdate();
}