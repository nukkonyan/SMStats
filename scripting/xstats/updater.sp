#define UpdateUrl "https://github.com/Teamkiller324/Xstats/XstatsUpdater.txt"

/**
 *	Initialize updater addition.
 */
public void PrepareUpdater()
{
	if(LibraryExists("updater"))
		Updater_AddPlugin(UpdateUrl);
}

public void OnLibraryAdded(const char[] name)
{
	if(StrEqual(name, "updater"))	{
		PrintToServer("[xstats Updater] Updater plugin was detected, adding plugin to update list..");
		Updater_AddPlugin(UpdateUrl);
	}
}

public void Updater_OnPluginUpdated()
{
	PrintToServer("[xStats Updater] New update found and installed, Restarting plugin..");
	ReloadPlugin();
}