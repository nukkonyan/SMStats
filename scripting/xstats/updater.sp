#define UpdateUrl "https://raw.githubusercontent.com/Teamkiller324/XStats/main/XStatsUpdater.txt"

/**
 *	Initialize updater addition.
 */
void PrepareUpdater()	{
	if(IsUpdaterLoaded())	{
		Updater_AddPlugin(UpdateUrl);
		Updater_ForceUpdate();
	}
}

public void OnLibraryAdded(const char[] name)	{
	if(StrEqual(name, "updater"))	{
		XStats_DebugText(false, "Updater plugin was detected, adding plugin to update list..");
		Updater_AddPlugin(UpdateUrl);
		
		if(Global.UpdateTimer == null)	{
			XStats_DebugText(false, "Creating 5 minute long automatic update checker.");
			Global.UpdateTimer = CreateTimer(300.0, Timer_CheckForUpdate, _, TIMER_REPEAT);
		}
	}
}

public void Updater_OnPluginUpdated()	{
	XStats_DebugText(false, "New update found and installed, Restarting plugin..");
	ReloadPlugin();
}

stock Action Timer_CheckForUpdate(Handle timer)	{	
	XStats_DebugText(false, "Checking for new update..");
	XStats_DebugText(false, "Current version: %s", Version);
	XStats_DebugText(false, " ");
	Updater_ForceUpdate();
}

/**
 *	Returns if the updater is loaded.
 */
stock bool IsUpdaterLoaded()	{
	return view_as<bool>(GetFeatureStatus(FeatureType_Native, "Updater_AddPlugin") == FeatureStatus_Available);
}