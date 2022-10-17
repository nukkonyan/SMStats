//==========================================//
// Tklib / Fortress Forever.
//==========================================//
#if !defined _tklib_disable_fortress_forever

enum FFTeam	{
	FFTeam_Invalid = -1,
	FFTeam_Unassigned = 0,
	FFTeam_Spectators = 1,
	FFTeam_Red = 2,
	FFTeam_Blue = 3
}

enum FFClass {
	//Will be filled.
}

stock char
FF_GetTeamStringName[][] = {"Unassigned","Spectators","Red","Blue"},
FF_GetTeamStringNameEx[][] = {"{grey}Unassigned{default}","{grey}Spectators{default}","{red}Red{default}","{blue}Blue{default}"};

/**
 *	Returns the users current team.
 *
 *	@param	client        The users index.
 *
 *	@error	If the user is invalid, this returns FFTeam_Unassigned.
 */
stock FFTeam FF_GetClientTeam(int client) {
	return Tklib_IsValidClient(client) ? view_as<FFTeam>(GetClientTeam(client)):FFTeam_Unassigned;
}

/**
 *	Changes the users current team.
 *
 *	@param	client        The users index.
 *	@param	team          FFTeam team symbol.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool FF_ChangeClientTeam(int client, FFTeam team)	{
	if(Tklib_IsValidClient(client))	{
		ChangeClientTeam(client, view_as<int>(team));
		return true;
	}
	
	return	false;
}

/**
 *	Returns a random FFTeam team (Red or Blue)
 *
 *	@return	Returns a FFTeam team.
 */
stock FFTeam FF_GetRandomTeam()	{
	return view_as<FFTeam>(GetRandomInt(2, 3));
}

#endif