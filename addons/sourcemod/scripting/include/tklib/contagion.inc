//==========================================//
// Tklib / Contagion.
//==========================================//
#if !defined _tklib_disable_contagion

//Include originally by JonnyBoy0719, updated by Tk /id/Teamkiller324

/**
 * Smlib fix
 */
#define CE_MAX_WEAPONS 48	// Max number of weapons available

/**
 * Maximum length of a weapon name string
 */
#define CE_WEAPONS_MAX_LENGTH 32

/**
 * Number of weapon slots
 */
#define CE_WEAPONS_SLOTS_MAX 4

/**
 * Weapon slots.
 */
enum CE_WeaponsSlot {
	Slot_Invalid	= -1,	/** Invalid weapon (slot). */
	Slot_Primary	= 0,	/** Primary weapon slot. */
	Slot_Secondary	= 1,	/** Secondary weapon slot. */
	Slot_Third		= 2,	/** 3rd weapon slot. */
	Slot_Forth		= 3,	/** 4th weapon slot. */
}

/**
 * Team numbers.
 */
enum CETeam {
	CETeam_Invalid		= -1,
	CETeam_Unassigned	= 0,
	CETeam_Spectator	= 1,
	CETeam_Survivor		= 2,
	CETeam_Zombie		= 3	
}

/**
 *	Returns the users current team.
 *
 *	@param	client		The users index.
 *
 *	@return	Current CETeam of client.
 *
 *	@error	If the user is invalid, this returns CETeam_Unassigned.
 */
stock CETeam CE_GetClientTeam(int client) {
	return Tklib_IsValidClient(client) ? view_as<CETeam>(GetClientTeam(client)):CETeam_Unassigned;
}

/**
 *	Changes the users current team.
 *
 *	@param	client		The users index.
 *	@param	team		CETeam team symbol.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CE_ChangeClientTeam(int client, CETeam team)	{
	if(Tklib_IsValidClient(client))	{
		ChangeClientTeam(client, view_as<int>(team));
		return true;
	}
	
	return false;
}

/**
 *	Returns if the user is infected and how long until he gets infected.
 * 
 *	@param	client		The users index.
 *
 *	@return	Infection Status.
 *
 *	@error	If the user is invalid, this returns -1.0.
 */
stock float CE_GetInfectionTime(int client)	{
	return GetEntPropFloatEx(client, Prop_Send, "m_TimeTillInfection");
}

/**
 *	Sets users infection status.
 * 
 *	@param	client		The users index.
 *
 *	@param	infection		Set infection status
 *
 *	@error	If the user is invalid or procedure failed, this returns false.
 */
stock bool CE_SetInfectionTime(int client, float infection)	{
	return SetEntPropFloatEx(client, Prop_Send, "m_TimeTillInfection", infection);
}

/**
 *	Returns how much stamina the users has.
 * 
 *	@param	client		The users index.
 *
 *	@return	Stamina Status.
 *
 *	@error	If the user is invalid, this returns -1.0.
 */
stock float CE_GetStamina(int client)	{
	return GetEntPropFloatEx(client, Prop_Send, "m_flStamina");
}

/**
 *	Sets the users stamina.
 * 
 *	@param	client		The users index.
 *	@param	stamina		Set stamina
 *
 *	@error	If the user is invalid or procedure failed, this returns false.
 */
stock bool CE_SetStamina(int client, float stamina)	{
	return SetEntPropFloatEx(client, Prop_Send, "m_flStamina", stamina);
}

/**
 *	Sets extra ammunition for any weapon
 *	Note: This doesn't apply for melee weapons
 *
 *	@param	weapon		Weapon entity index.
 *	@param	ammo		Set extra ammunition
 *
 *	@error	If the weapon entity is invalid, this returns false.
 */
stock int CE_SetExtraAmmo(any weapon, int ammo)	{
	return SetWeaponAmmo(weapon, GetWeaponAmmo(weapon) + ammo);
}

/**
 *	Sets ammunition for any weapon
 *	Note: This doesn't apply for melee weapons
 *	Look at SetWeaponAmmo as alternative.
 *
 *	@param	weapon		Entity Index.
 *	@param	ammo		Set extra ammunition
 *
 *	@error	If the weapon and/or user is invalid, this returns false.
 */
stock bool CE_SetAmmo(int client, any weapon, int ammo)	{
	if(Tklib_IsValidClient(client, _, true) && IsValidEntityEx(weapon))	{
		int offset_ammo	= FindDataMapInfo(client, "m_iAmmo");
		int offset = offset_ammo + (GetWeaponAmmoType(weapon) * 4);
		SetEntData(client, offset, ammo, 4, true);
		
		return true;
	}
	
	return	false;
}

/**
 *	Returns the survivor character
 * 
 *	@param	client		The users index.
 *
 *	@return				Returns the survivor character
 *
 *	@error	If the user is invalid, this returns -1.
 */
stock int CE_GetSurvivorCharacter(int client) {
	return GetEntPropEx(client, Prop_Send, "m_survivorCharacter");
}

/**
 *	Set the users survivor character
 * 
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock int CE_SetSurvivorCharacter(int client, int index) {
	return SetEntPropEx(client, Prop_Send, "m_survivorCharacter", index);
}

/**
 * 	Give the user a specified weapon.
 * 
 *	@param	client	The client index.
 *	@param	weapon	The weapon classname.
 *
 *	@error	If the user is invalid, this return false.
 */
stock void CE_GiveClientWeapon(int client, const char[] weapon, int ammo=0)	{
	GivePlayerItem(client, weapon);
	int	GetWeapon = GetClientWeaponClassname(client, weapon);
	if(ammo > 0)
		CE_SetAmmo(client, GetWeapon, ammo);
}

/**
 *	Returns if the user has the specified weapon.
 * 
 *	@param	client	The users index.
 *	@param	weapon	The weapon classname.
 *
 *	@return	If the user has the weapon, it returns true. False otherwise.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CE_ClientHasWeapon(int client, const char[] weapon)	{
	if(!Tklib_IsValidClient(client, _, true))
		return	false;
	
	// Get all of the users current weapons.
	int	weapons[4];
	CE_GetClientWeapons(client, weapons);
	char classname[64];
	
	// x = slot index
	for(int x = 0; x < CE_MAX_WEAPONS; x++) {
		// If slot is empty, then stop.
		if(weapons[x] == -1)
			continue;
		
		// If the weapon's classname matches, then return true.
		GetEdictClassname(weapons[x], classname, sizeof(classname));
		ReplaceString(classname, sizeof(classname), "weapon_", "");
		if(StrEqual(weapon, classname, false))
			return true;
	}
	
	return false;
}

/**
 *	Return an array that contains all of the users weapon indexes.
 * 
 *	@param	client	The users index.
 *	@param	weapons	The weapon index array.
 *
 *	@noreturn.
 */
stock void CE_GetClientWeapons(int client, int weapons[4]) {
	// x = Weapon slot.
	for(int x = 0; x < CE_WEAPONS_SLOTS_MAX; x++) {
		weapons[x] = GetPlayerWeaponSlot(client, x);
	}
}

/**
 *	Removes all weapons from a client's weapon slot
 *
 *	@param	client		The users index.
 *	@param	slot		Slot index (0-5).
 *
 *	@error				If invalid user, invalid slot or lack of mod support, this returns false.
 */
stock bool CE_RemoveWeaponSlot(int client, int slot)	{
	if(Tklib_IsValidClient(client, _, true))	{
		int	weaponIndex;
		while((weaponIndex = GetPlayerWeaponSlot(client, slot)) != -1)	{
			RemovePlayerItem(client, weaponIndex);
			AcceptEntityInput(weaponIndex, "Kill");
		}
		
		return	true;
	}
	
	return	false;
}

/**
 *	Removes all firearms from the user
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CE_RemoveAllFirearms(int client)	{
	if(!Tklib_IsValidClient(client, _, true))
		return false;
	
	int	weapons[4];
	CE_GetClientWeapons(client, weapons);
	
	char classname[64];
	
	for(int x = 0; x < CE_WEAPONS_SLOTS_MAX; x++) {
		if(weapons[x] == -1)
			continue;
		
		GetEntityClassname(weapons[x], classname, sizeof(classname));
		
		if(StrEqual(classname, "weapon_melee", false) || StrEqual(classname, "weapon_phone", false)
			|| StrEqual(classname, "weapon_boltcutter", false) || StrEqual(classname, "weapon_coin", false)
			|| StrEqual(classname, "weapon_ied", false) || StrEqual(classname, "weapon_grenade", false)
			|| StrEqual(classname, "weapon_key", false) || StrEqual(classname, "weapon_firstaid", false)
			|| StrEqual(classname, "weapon_keycard", false) || StrEqual(classname, "weapon_nailgun", false)
			|| StrEqual(classname, "weapon_plight", false) || StrEqual(classname, "weapon_zombie", false))
			return false; // Do nothing
		else {
	//		PrintToServer("[[ delete: %s ]]", classname);
	//		PrintToServer("[[ delete: %d ]]", weapons[x]);
			RemovePlayerItem(client, weapons[x]);
			AcceptEntityInput(weapons[x], "Kill");
		}
	}
	
	return true;
}

/**
 *	Removes all weapons from the user
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CE_RemoveAllWeapons(int client)	{
	if(!Tklib_IsValidClient(client, _, true))
		return	false;

	for(int i = 0; i <= 5; i++)	{
		CE_RemoveWeaponSlot(client, i);
	}
	
	return	true;
}

/*
 *	Returns the users specified weapon via its classname.
 *
 *	@param	client		The users index.
 *	@param	classname	The classname to search.
 *
 *	@error	If the user is invalid, this returns -1.
*/
stock int CE_GetClientWeapon(int client, const char[] classname)	{
	if(!Tklib_IsValidClient(client, _, true))
		return	INVALID_ENT_REFERENCE;
	
	int	offset = GetClientWeaponsOffset(client) - 4;

	for(int i = 0; i < CE_MAX_WEAPONS; i++) {
		offset += 4;

		int	weapon = GetEntDataEnt2(client, offset);
		
		if(!IsValidEntityEx(weapon))
			continue;
		
		if(IsEntityClassnameMatching(weapon, classname))
			return	weapon;
	}
	
	return INVALID_ENT_REFERENCE;
}

/**
 *	Returns a random CETeam team (Survivor or Zombie)
 *
 *	@return	Returns a CETeam team.
 */
stock CETeam CE_GetRandomTeam()	{
	return view_as<CETeam>(GetRandomInt(2, 3));
}

#endif