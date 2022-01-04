#define UpdateUrl "https://raw.githubusercontent.com/Teamkiller324/Xstats/main/XstatsUpdater.txt"

/**
 *	Initialize updater addition.
 */
void PrepareUpdater()
{
	if(LibraryExists("updater"))	{
		Updater_AddPlugin(UpdateUrl);
		Updater_ForceUpdate();
	}
}

public void OnLibraryAdded(const char[] name)
{
	if(StrEqual(name, "updater"))	{
		PrintToServer("[xStats Updater] Updater plugin was detected, adding plugin to update list..");
		Updater_AddPlugin(UpdateUrl);
	}
}

public void Updater_OnPluginUpdated()
{
	PrintToServer("[xStats Updater] New update found and installed, Restarting plugin..");
	ReloadPlugin();
}