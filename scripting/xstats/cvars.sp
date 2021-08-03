ConVar	MinimumPlayers, DisableOnWin, CountBots, PrefixTag, Debug;

char Prefix[256];

void LoadCvars()	{
	MinimumPlayers		=	CreateConVar("xstats_needed_players",	"4",	"Xstats - Minimum players needed to have statistics tracking enabled. 0 Disables this check.",	_,	true,	0.0);
	DisableOnWin		=	CreateConVar("xstats_disable_on_win",	"1",	"Xstats - Should tracking be disable upon team winning a round?",								_,	true,	0.0,	true,	1.0);
	Debug				=	CreateConVar("xstats_debug",			"0",	"Xstats - Should debugging be enabled?. 0 Disables it.",										_,	true,	0.0,	true,	1.0);
	CountBots			=	CreateConVar("xstats_countbots",		"1",	"Xstats - Should bots be counted?",																_,	true,	0.0,	true,	1.0);
	
	PrefixTag			=	CreateConVar("xstats_prefixtag",		"{green}Xstats",	"Xstats - The prefix tag. Emptying this out disables the tag");
	PrefixTag.AddChangeHook(PrefixTagHook);
	PrefixTag.GetString(Prefix, sizeof(Prefix));
	Format(Prefix, sizeof(Prefix), "%s{default}", Prefix);
}

void PrefixTagHook(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	Format(Prefix, sizeof(Prefix), "%s{default}", newvalue);
	GlobalForward prefix = new GlobalForward("xstats_OnPrefixTagUpdated", ET_Event, Param_String);
	Call_StartForward(prefix);
	Call_PushString(newvalue);
	Call_Finish();
	delete prefix;
}