#if defined _xstats_included
	#error Xstats is already included.
	#endinput
#endif

#define _xstats_included
#define Xstats "xstats"
#define XstatsAchievements "xstats_achievements"

enum	XStats	{
	XStats_Invalid = -1
}

#include <xstats/functions>

/**
 *	Returns the amount of points a user has.
 *
 *	@param	auth	The players steam authentication id.
 *
 *	@return	Returns the points from the server's current game playerlist table.
 */
native int XStats_GetClientPoints(const char[] auth);

/**
 *	Returns the amount of playtime a user has.
 *
 *	@param	auth	The players steam authentication id.
 *
 *	@return	Returns the total playtime in minutes the user has.
 */
native int XStats_GetClientPlayTime(const char[] auth);

/*
 *	Returns the session stats count via Xstats_SessionType.
 *
 *	@param	client		The users index.
 *	@param	type		Type of Session stat to return.
 *	@param	callback	The callback.
 *
 *	@noreturn
 */
native void XStats_GetClientSession(int client, XStats_SessionType type, XStatsSessionCallback callback);

/*
 *	Returns the prefix.
 *
 *	@param	prefix	The string buffer to store.
 *	@param	maxlen	The maximum length of the string buffer.
 *
 *	@noreturn
 */
native void XStats_GetPrefix(char[] prefix, int maxlen);

/**
 *	Returns if XStats is enabled.
 */
native bool XStats_Enabled();
	
/**
 *	Returns if XStats is active.
 */
native bool XStats_Active();

/**
 *	Returns if the bots are allowed.
 */
native bool XStats_AllowBots();

/**
 *	Return if debug is active.
 */
native bool XStats_Debug();

/**
 *	Called as soon the prefix has been updated.
 *
 *	@param	prefix	The prefix.
 *
 *	@noreturn
 */
forward void XStats_OnPrefixUpdated(const char[] prefix);

/**
 *	Called as soon someone kills an opponent.
 *
 *	@param	client	The attackers user index.
 *	@param	victim	The victims user index.
 *	@param	assist	The assisters user index.
 *
 *	@noreturn
 */
forward void XStats_OnDeathEvent(int client, int victim, int assist);

/**
 *	Called as soon someone suicides. (Ignores bots)
 *
 *	@param	client	The users index.
 *
 *	@noreturn
 */
forward void XStats_OnSuicideEvent(int client);

/**
 *	Called as soon a flag event is fired.
 *
 *	@param	client		The players user index.
 *	@param	carrier		The carrier user index.
 *	@param	flag		The flag event type.
 *	@param	home		Was the flag/intelligence stolen?
 *
 *	@noreturn
 */
forward void XStats_TF2_OnFlagEvent(int client, int carrier, TFFlag flag, bool home);

methodmap XStats __nullable__	{
	/**
	 *	Returns the amount of points a user has.
	 *
	 *	@param	auth	The players steam authentication id.
	 *
	 *	@return	Returns the points from the server's current game playerlist table.
	 */
	public native int GetPoints(const char[] auth);
	
	/**
	 *	Returns the amount of playtime a user has.
	 *
	 *	@param	auth	The players steam authentication id.
	 *
	 *	@return	Returns the total playtime in minutes the user has.
	 */
	public native int GetPlayTime(const char[] auth);
	
	/*
	 *	Returns the session stats count via Xstats_SessionType.
	 *
	 *	@param	client		The users index.
	 *	@param	type		Type of Session stat to return.
	 *	@param	callback	The callback.
	 */
	public native void GetSession(int client, XStats_SessionType type, XStatsSessionCallback callback);
	
	/*
	 *	Returns the prefix.
	 *
	 *	@param	prefix	The string buffer to store.
	  *	@param	maxlen	The maximum length of the string buffer.
	 */
	public native void GetPrefix(char[] prefix, int maxlen);
	
	/**
	 *	Returns if XStats is enabled.
	 */
	property bool Enabled	{
		public native get();
	}
	
	/**
	 *	Returns if XStats is active.
	 */
	property bool Active	{
		public native get();
	}
	
	/**
	 *	Returns if the bots are allowed.
	 */
	property bool AllowBots	{
		public native get();
	}
	
	/**
	 *	Return if debug is active.
	 */
	property bool Debug	{
		public native get();
	}
}

public SharedPlugin __pl_Xstats = {
	name = "Xstats",
	file = "xstats.smx",
#if defined REQUIRE_PLUGIN
	required = 1,
#else
	required = 0,
#endif
}

#if !defined REQUIRE_PLUGIN
public void __pl_Xstats_SetNTVOptional()	{
	MarkNativeAsOptional("Xstats_GetClientPoints");
	MarkNativeAsOptional("Xstats.GetPoints");
	MarkNativeAsOptional("Xstats_GetClientPlayTime");
	MarkNativeAsOptional("Xstats.GetPlayTime");
	MarkNativeAsOptional("Xstats_GetClientSession");
	MarkNativeAsOptional("Xstats.GetSession");
	MarkNativeAsOptional("xStats_Debug");
	MarkNativeAsOptional("Xstats.Debug.get");
}
#endif