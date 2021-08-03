#if defined Xstats_Libraries_Included
	#endinput
#endif

#define	Xstats_Libraries_Included

/**
 *	Xstats Libraries.
 *	Retrieve the weaponname of a weapon via its definition index.
 *	This auto-detects the game, no need to worry about that.
 *
 *	@param		buffer		Buffer to store the string.
 *	@param		maxlen		Maximum length of the string.
 *	@param		defindex	The definition index of the weapon to gain name from.
 */
native int Xstats_Libraries_GetWeaponName(char[] buffer, int maxlen, int defindex);

methodmap	Xstats_Libraries	{
	public int GetWeaponName(char[] buffer, int maxlen, int defindex)	{
		Xstats_Libraries_GetWeaponName(buffer, maxlen, defindex);
	}
}

public	SharedPlugin	__pl_Xstats_Libraries	=	{
	name	=	"Xstats: Libraries",
	file	=	"xstats_libraries.smx",
#if defined REQUIRE_PLUGIN
	required	=	1,
#else
	required	=	0,
#endif
};

#if !defined REQUIRE_PLUGIN
	public void __pl_Xstats_Libraries_SetNTVOptional()	{
		MarkNativeAsOptional("Xstats_Libraries_GetWeaponName");
		MarkNativeAsOptional("Xstats_Libraries.GetWeaponName");
	}
#endif