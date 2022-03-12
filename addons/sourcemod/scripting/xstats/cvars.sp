void PrepareCvars()	{
	CreateConVar("xstats_version", Version, "XStats - Version.").AddChangeHook(VersionChanged);
	Cvars.PluginActive		= CreateConVar("xstats_enabled",		"1", "XStats - Should the tracking plugin be enabled?.", _, true, _, true, 1.0);
	Cvars.Debug				= CreateConVar("xstats_debug",			"0", "XStats - Debug. (For development purposes)", FCVAR_DEVELOPMENTONLY, true, _, true, 1.0);
	Cvars.AllowBots			= CreateConVar("xstats_allow_bots",		"0", "XStats - Should bots be allowed to be tracked as a valid opponent?.", _, true, _, true, 1.0);
	Cvars.AllowWarmup		= CreateConVar("xstats_allow_warmup",	"0", "XStats - Should warmup be a valid round to track?.", _, true, _, true, 1.0);
	Cvars.ServerID			= CreateConVar("xstats_serverid",		"1", "XStats - Server ID the server should be identified as.", _, true);
	Cvars.MinimumPlayers	= CreateConVar("xstats_minimumplayers",	"4", "XStats - Minimum amount of players required.", _, true, 1.0);
	Cvars.DisableAfterWin	= CreateConVar("xstats_disableafterwin","1", "XStats - Should tracking be disabled when a team wins/round ends?.", _, true, _, true, 1.0);
	Cvars.ConnectMsg		= CreateConVar("xstats_connectmsg",		"1", "XStats - Should connect messages be enabled?", _, true, _, true, 1.0);
	Cvars.RemoveOldPlayers	= CreateConVar("xstats_removeoldplayers", "0", "XStats - Number of days of days to keep players in the database. (Since last connection). 0 Disables check.");
	Cvars.AntiAbuse			= CreateConVar("xstats_antiabuse",		"1", "XStats - Should abusing players be avoided to make sure the event was legit? (Noclipping, sv_cheats, etc)", _, true, _, true, 1.0);
	
	Cvars.PrefixCvar = CreateConVar("xstats_prefix", "{green}XStats", "XStats - Prefix to be used ingame texts.");
	Cvars.PrefixCvar.AddChangeHook(PrefixCallback);
	Cvars.PrefixCvar.GetString(Global.Prefix, sizeof(Global.Prefix));
	Format(Global.Prefix, sizeof(Global.Prefix), "%s{default}", Global.Prefix);
	
	Cvars.MinimumPlayers.AddChangeHook(PlayerCvarUpdated);
	Cvars.AllowBots.AddChangeHook(PlayerCvarUpdated);
	
	if(GetEngineVersion() != Engine_TF2)
		Cvars.Death	= CreateConVar("xstats_points_death", "5", "XStats - Points to remove from the player who died.", _, true);
	
	Cvars.AssistKill = CreateConVar("xstats_points_assist",	"3", "XStats - Points to give the assister.", _, true);
}

void VersionChanged(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	if(!StrEqual(newvalue, Version))
		cvar.SetString(Version);
}

void PrefixCallback(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	cvar.GetString(Global.Prefix, sizeof(Global.Prefix));
	Format(Global.Prefix, sizeof(Global.Prefix), "%s{default}", Global.Prefix);
	
	PreparePrefixUpdatedForward();
}

void PlayerCvarUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	CheckActivePlayers();
}