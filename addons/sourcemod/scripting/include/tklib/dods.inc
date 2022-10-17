//==========================================//
// Tklib / Day of Defeat: Source.
//==========================================//
#if !defined _tklib_disable_dods

stock char
DOD_GetTeamStringName[][] = {
	"{grey}Unassigned{default}",
	"{grey}Spectators{defualt}",
	"{red}Wehrmacht{default}",
	"{blue}U.S Army{default}"
}, DODS_GetTeamColour[][] = {
	"{grey}",
	"{grey}",
	"{red}",
	"{blue}"
};

//Day Of Defeat: Source enum
enum DODTeam {
	DODTeam_Invalid = -1,
	DODTeam_Unassigned = 0,
	DODTeam_Spectator = 1,
	DODTeam_Red = 2,
	DODTeam_Blue = 3
}

enum DODSlot {
	DODSlot_Primary		= 0,
	DODSlot_Secondary	= 1,
	DODSlot_Slot3		= 2,
	DODSlot_Slot4		= 3,
	DOSSlot_Slot5		= 4
}

enum {
	DOD_Weapon_K98K				= 1,
	DOD_Weapon_Spade			= 2,
	DOD_Weapon_RifleGrenade_Ger	= 3,
	DOD_Weapon_MP40				= 4,
	DOD_Weapon_P38				= 5,
	DOD_Weapon_FragGrenade_Ger	= 6,
	DOD_Weapon_STG44			= 7,
	DOD_Weapon_K98_Sniper		= 8,
	DOD_Weapon_MG42				= 9,
	DOD_Weapon_PanzerSchreck	= 10,
	DOD_Weapon_C96				= 11,
}

#define	DODTeam(%1) view_as<DODTeam>(%1)

/**
 *	Returns the users current team.
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is not connected, this returns DODTeam_Unassigned.
 */
stock DODTeam DOD_GetClientTeam(int client)	{ return Tklib_IsValidClient(client) ? view_as<DODTeam>(GetClientTeam(client)):DODTeam_Unassigned; }

/**
 *	Changes the users current team.
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool DOD_ChangeClientTeam(int client, DODTeam team) {
	if(Tklib_IsValidClient(client, _, _, false)) {
		ChangeClientTeam(client, view_as<int>(team));
		return true;
	}
	
	return false;
}

/**
 *	Returns a random DODTeam team (Red or Blue)
 *
 *	@return	Returns a DODTeam team.
 */
stock DODTeam DOD_GetRandomTeam() { return view_as<DODTeam>(GetRandomInt(2, 3)); }

/**
 *	Returns the weapon name from entity name.
 *
 *	@param	weapon		Weapon entity name.
 *	@param	buffer		The string buffer to store.
 *	@param	maxlen		Maximum length of the buffer string.
 *
 *	@noreturn
 */
stock void DOD_GetWeaponName(const char[] weapon, char[] buffer, int maxlen) {
	if(StrContains(weapon, "k98", false) != -1)
		strcopy(buffer, maxlen, "K98K");
	
	if(StrContains(weapon, "spade", false) != -1)
		strcopy(buffer, maxlen, "Spade");
	
	if(StrContains(weapon, "riflegren_ger", false) != -1)
		strcopy(buffer, maxlen, "Rifle Grenade (Ger)");
	
	if(StrContains(weapon, "mp40", false) != -1)
		strcopy(buffer, maxlen, "MP40");
	
	if(StrContains(weapon, "p38", false) != -1)
		strcopy(buffer, maxlen, "P38");
	
	if(StrContains(weapon, "frag_ger", false) != -1)
		strcopy(buffer, maxlen, "Frag Grenade (Ger)");
	
	if(StrContains(weapon, "mp44", false) != -1)
		strcopy(buffer, maxlen, "STG44");
	
	if(StrContains(weapon, "k98_scoped", false) != -1)
		strcopy(buffer, maxlen, "K98 Sniper");
	
	if(StrContains(weapon, "mg42", false) != -1)
		strcopy(buffer, maxlen, "MG42");
	
	if(StrContains(weapon, "pschreck", false) != -1)
		strcopy(buffer, maxlen, "Panzerschreck");
	
	if(StrContains(weapon, "c96", false) != -1)
		strcopy(buffer, maxlen, "C96");
}

#endif