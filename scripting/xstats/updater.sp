#define UpdateUrl "https://raw.githubusercontent.com/Teamkiller324/Xstats/main/XstatsUpdater.txt"

/**
 *	Initialize updater addition.
 */
public void PrepareUpdater()
{

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

public void OnAllPluginsLoaded()
{
	if(LibraryExists("updater"))	{
		Updater_AddPlugin(UpdateUrl);
		Updater_ForceUpdate();
	}
}