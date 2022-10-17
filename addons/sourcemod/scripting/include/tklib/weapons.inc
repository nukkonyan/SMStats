//==========================================//
// Tklib / Weapons.
//==========================================//
#if !defined _tklib_disable_weapons

#define MAX_WEAPONS 48

/**
 *	Removes all weapons from the user.
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool RemoveAllWeapons(int client)	{
	if(Tklib_IsValidClient(client, _, true)) {
		for(int i = 0; i < 10; i++)	{
			int wep = -1;
			if((wep = GetPlayerWeaponSlot(client, i)) != -1) {
				RemovePlayerItem(client, wep);
				RemoveEdict(wep);
			}
		}
		return true;
	}
	
	return false;
}

/**
 *	Returns the users current active weapon.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid or has no active weapon, this returns -1.
 */
stock int GetClientActiveWeapon(int client)	{
	return GetEntPropEntEx(client, Prop_Send, "m_hActiveWeapon");
}

/**
 *	Forces the users current active weapon.
 *
 *	@param	client	The users index.
 *	@param	weapon	The users weapon entity index.
 *
 *	@error	If the user is invalid or has no active weapon, this returns false.
 */
stock bool SetClientActiveWeapon(int client, any weapon)	{
	bool valid = false;
	if((valid = SetEntPropEntEx(client, Prop_Send, "m_hActiveWeapon", weapon)))
		ChangeEdictState(client, FindDataMapInfo(client, "m_hActiveWeapon"));
	return valid;		
}

/**
 *	Set the users wielding weapon ammo.
 *
 *	@param	client	The users index.
 *	@param	ammo	Primary ammo amount.
 *
 *	@error	If the user is invalid, nothing will happen.
 */
stock bool SetClientActiveWeaponAmmo(int client, int ammo)	{
	return SetEntPropEx(GetClientActiveWeapon(client), Prop_Send, "m_iClip1", ammo);
}

/**
 *	Set the users current active primary and secondary weapon ammo.
 *
 *	@param	client		The users index.
 *	@param	primary		Primary ammo amount. Zero amount input will do nothing.
 *	@param	secondary	Secondary ammo amount. Zero amount input will do nothing.
 *
 *	@noreturn
 *
 *	@error	If the user is invalid, nothing will happen.
 */
stock void SetClientActiveWeaponAmmoEx(int client, int primary, int secondary) {
	SetWeaponAmmoEx(GetClientActiveWeapon(client), primary, secondary);
}

/**
 *	Set the weapon primary ammo
 *
 *	@param weapon		Weapon entity.
 *	@param value		Amount value.
 *
 *	@error	If the weapon entity is invalid, this returns false.
 */
stock bool SetWeaponAmmo(any weapon, int value)	{
	return SetEntPropEx(weapon, Prop_Send, "m_iClip1", value);
}

/**
 *	Set the weapon primary and secondary ammo.
 *
 *	@param	weapon		Weapon entity.
 *	@param	primary		Primary ammo amount.
 *	@param	secondary	Secondary ammo amount.
 *
 *	@noreturn
 *
 *	@error	If the weapon is invalid, this returns false.
 */
stock bool SetWeaponAmmoEx(any weapon, int primary, int secondary) {
	if(!IsValidEntityEx(weapon))
		return false;
	
	SetWeaponAmmo(weapon, primary);
	SetWeaponReserveAmmo(weapon, secondary);
	
	return true;
}

/**
 *	Returns the weapons primary ammo
 *
 *	@param	weapon	Weapon entity.
 *
 *	@error	If the weapon is invalid, it returns -1.
 */
stock int GetWeaponAmmo(any weapon)	{
	return GetEntPropEx(weapon, Prop_Send, "m_iClip1");
}

/**
 *	Returns the clients current active weapon primary ammo
 *
 *	@param	client		The users index.
 *
 *	@error	If the client is invalid, this returns -1.
 */
stock int GetClientActiveWeaponAmmo(int client)	{
	return GetWeaponAmmo(GetClientActiveWeapon(client));
}

/**
 *	Set the users current active weapon reserve ammo.
 *
 *	@param	client		The users index.
 *	@param	value		Secondary ammo amount.
 *
 *	@error	If the user is invalid or has no active weapon, this returns false.
 */
stock bool SetClientActiveWeaponReserveAmmo(int client, int value)	{
	return SetWeaponAmmo(GetClientActiveWeapon(client), value);
}

/**
 *	Set the weapon reserve ammo
 *
 *	@param	weapon		Weapon entity.
 *	@param	value		Secondary ammo amount.
 *
 *	@error	If the weapon entity is invalid, this returns false.
 */
stock bool SetWeaponReserveAmmo(any weapon, int value)	{
	return SetEntPropEx(weapon, Prop_Send, "m_iPrimaryReserveAmmoCount", value);
}

/**
 *	Return the weapon reserve ammo
 *
 *	@param	weapon		Weapon entity.
 *
 *	@error	If the weapon entity is invalid, this returns -1.
 */
stock int GetWeaponReserveAmmo(any weapon)	{
	return GetEntPropEx(weapon, Prop_Send, "m_iPrimaryReserveAmmoCount");
}

/**
 *	Return the weapon reserve ammo
 *
 *	@param	client		The users index.
 *	@error	If the client is invalid, this returns -1.
 */
stock int GetClientActiveWeaponReserveAmmo(int client)	{
	return GetWeaponReserveAmmo(GetClientActiveWeapon(client));
}

/**
 *	Returns the ammotype of the weapon.
 *
 *	@param	weapon		The weapon entity.
 *
 *	@error	If weapon is invalid, this returns -1.
 */
stock int GetWeaponAmmoType(any weapon)	{
	return GetEntPropEx(weapon, Prop_Send, "m_iPrimaryAmmoType");
}

/**
 *	Returns the array size of weapons of the specified user.
 *
 *	@param	client		The users index.
 *
 *	@error	If user is invalid, this returns -1.
 */
stock int GetClientActiveWeaponsArraySize(int client)	{
	return GetEntPropArraySizeEx(client, Prop_Send, "m_hMyWeapons");
}

/**
 *	Returns the weapon entity of a specified user via element.
 *
 *	@param	client		The users index.
 *	@param	element		The element to gain weapon entity from.
 *
 *	@error	If user or weapon entity is invalid, this returns -1.
 */
stock int GetClientWeaponEntity(int client, int element)	{
	return GetEntPropEntEx(client, Prop_Send, "m_hMyWeapons", element);
}

/**
 *	Returns the users weapon offsets.
 *
 *	@param	client		The users index.
 *
 *	@error	If the user or offset is invalid, this returns -1.
 */
stock int GetClientWeaponsOffset(int client)	{
	return Tklib_IsValidClient(client) ? FindDataMapInfo(client, "m_hMyWeapons"):-1;
}

/**
 *	Returns if the weapon is valid.
 *
 *	@param	weapon	Weapon entity index.
 *
 *	@error	If the weapon is invalid, this returns false.
 */
stock bool IsValidWeapon(any weapon)	{
	return IsEntityClassnameMatching(weapon, "weapon_", true);
}

/**
 *	Equips a players weapon.
 *	This is an alternative to that, this method fixes 0 clip magazine and glitchy reload animations because
 *	it was being spawned onto the user too early when using CreateEntityByName.
 *
 *	@param	client		The users index.
 *	@param	weapon		Weapon entity.
 *
 *	@error	If the user is invalid or weapon is invalid, this returns false.
 */
stock bool EquipPlayerWeaponEx(int client, any weapon)	{
	if(!(Tklib_IsValidClient(client, _, true) && IsValidEntityEx(weapon)))
		return false;
	
	//Credits to Bacardi for part of the code.
	
	float origin[3];
	GetClientAbsOrigin(client, origin);
	//origin[2] += 100.0;
	
	TeleportEntity(weapon, origin, NULL_VECTOR, NULL_VECTOR);
	SetEntPropVector(weapon, Prop_Send, "m_vecOrigin", origin);
	
	//Lets force the weapon to never respawn.
	int SF_NORESPAWN = (1 << 30);
	int flags = GetEntProp(weapon, Prop_Data, "m_spawnflags");
	flags |= SF_NORESPAWN;
	
	SetEntProp(weapon, Prop_Data, "m_spawnflags", flags);
	DispatchSpawn(weapon);
	return true;
}

/**
 *	Returns the weapon of the users weapon array.
 *
 *	@param	client		The users index.
 *	@param	array		The slot array index to get weapon entity from.
 */
stock int GetClientActiveWeaponSlot(any client, int array)	{
	return GetEntPropEntEx(client, Prop_Send, "m_hMyWeapons", array);
}

#endif