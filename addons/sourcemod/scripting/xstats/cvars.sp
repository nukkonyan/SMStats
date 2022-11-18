void PrepareCvars() {
	CreateConVar("xstats_version", Version, "XStats - Version.").AddChangeHook(VersionChanged);
	Cvars.PluginActive = CreateConVarBool("xstats_enabled", true, "XStats - Should the tracking plugin be enabled?.");
	Cvars.Debug = CreateConVarBool("xstats_debug", false, "XStats - Debug. (For development purposes)", FCVAR_DEVELOPMENTONLY);
	Cvars.AllowBots = CreateConVarBool("xstats_allow_bots", false, "XStats - Should bots be allowed to be tracked as a valid opponent?.");
	Cvars.AllowWarmup = CreateConVarBool("xstats_allow_warmup", false, "XStats - Should warmup be a valid round to track?.");
	Cvars.ServerID = CreateConVarInt("xstats_serverid", 1, "XStats - Server ID the server should be identified as.", _, true, 1);
	Cvars.MinimumPlayers = CreateConVarInt("xstats_minimumplayers", 4, "XStats - Minimum amount of players required.", _, true, 1);
	Cvars.DisableAfterWin = CreateConVarBool("xstats_disableafterwin", true, "XStats - Should tracking be disabled when a team wins/round ends?.");
	Cvars.ConnectMsg = CreateConVarBool("xstats_connectmsg", true, "XStats - Should connect messages be enabled?");
	Cvars.RemoveOldPlayers = CreateConVarInt("xstats_removeoldplayers", 0, "XStats - Number of days of days to keep players in the database. (Since last connection). 0 Disables check.");
	Cvars.AntiAbuse = CreateConVarBool("xstats_antiabuse", true, "XStats - Should abusing players be avoided to make sure the event was legit? (Noclipping, sv_cheats, etc)");
	Cvars.Update = CreateConVarBool("xstats_update", true, "XStats - If updater is detected running and this value is enabled, auto-update is active.");
	
	//Cvars.Weapons = new ArrayList(64); //ConVar weapon array list.
	
	Cvars.PrefixCvar = CreateConVar("xstats_prefix", "{green}XStats", "XStats - Prefix to be used ingame texts.");
	Cvars.PrefixCvar.AddChangeHook(PrefixCallback);
	Cvars.PrefixCvar.GetString(Global.Prefix, sizeof(Global.Prefix));
	Format(Global.Prefix, sizeof(Global.Prefix), "%s{default}", Global.Prefix);
	
	Cvars.MinimumPlayers.AddChangeHook(PlayerCvarUpdated);
	Cvars.AllowBots.AddChangeHook(PlayerCvarUpdated);
	
	if(GetEngineVersion() != Engine_TF2) Cvars.Death = CreateConVar("xstats_points_death", "5", "XStats - Points to remove from the player who died.", _, true);
	
	Cvars.AssistKill = CreateConVar("xstats_points_assist",	"3", "XStats - Points to give the assister.", _, true);
}

void VersionChanged(ConVar cvar, const char[] oldvalue, const char[] newvalue) { if(!StrEqual(newvalue, Version)) cvar.SetString(Version); }
void PrefixCallback(ConVar cvar, const char[] oldvalue, const char[] newvalue) {
	cvar.GetString(Global.Prefix, sizeof(Global.Prefix));
	Format(Global.Prefix, sizeof(Global.Prefix), "%s{default}", Global.Prefix);
	PreparePrefixUpdatedForward();
}
void PlayerCvarUpdated(ConVar cvar, const char[] oldvalue, const char[] newvalue) { CheckActivePlayers(); }