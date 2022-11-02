//==========================================//
// Tklib / Left 4 Dead.
//==========================================//
#if !defined _tklib_disable_l4d

stock char
L4D_GetTeamStringName[][] = {
	"{grey}Unassigned{default}",
	"{grey}Spectators{default}",
	"{orange}Survivors{default}",
	"{lightred}Zombies{default}"
}, L4D_GetTeamColour[][] = {
	"{grey}",
	"{grey}",
	"{orange}",
	"{lightred}"
};

//Left 4 Dead enum
enum L4DTeam {
	L4DTeam_Invalid = -1,
	L4DTeam_Unassigned = 0,
	L4DTeam_Spectator = 1,
	L4DTeam_Survivor = 2,
	L4DTeam_Infected = 3
}

#define	L4DTeam(%1)		view_as<L4DTeam>(%1)

/**
 *	Returns the users current team.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this returns L4DTeam_Unassigned.
 */
stock L4DTeam L4D_GetClientTeam(int client)	{ return Tklib_IsValidClient(client) ? view_as<L4DTeam>(GetClientTeam(client)):L4DTeam_Unassigned; }

/**
 *	Changes the users current team.
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool L4D_ChangeClientTeam(int client, L4DTeam team)	{
	if(Tklib_IsValidClient(client))	{
		ChangeClientTeam(client, view_as<int>(team));
		return true;
	}
	
	return	false;
}

/**
 *	Returns a random L4DTeam team (Survivors or Zombies)
 *
 *	@return	Returns a L4DTeam team.
 */
stock L4DTeam L4D_GetRandomTeam() { return L4DTeam(GetRandomInt(2, 3)); }

#endif