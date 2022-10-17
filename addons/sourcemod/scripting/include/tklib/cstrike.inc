//==========================================//
// Tklib / CStrike.
//==========================================//
#if !defined _tklib_no_cstrike

stock char
CSS_GetTeamStringName[][] = {"{grey}Unassigned{default}","{grey}Spectators{default}","{red}Terrorists{default}","{blue}Counter-Terrorists{default}"},
CSS_GetTeamColour[][] = {"{grey}","{grey}","{red}","{blue}"},
CS_TeamName[][] = {"Unassigned","Spectators","Terrorists","Counter-Terrorists"},
CS_TeamNameEx[][] = {"Unassigned","Spec","T","CT"},
CS_GetSlotName[][] = {"Primary","Secondary","Knife","Grenade","C4 Bomb","Slot 5","Slot 6","Slot 7","Slot 8","Slot 9","Slot 10","Shield"},
CS_GetWeaponTypeName[][] = {"Knife","Pistol","SMG","Rifle","Shotgun","Sniper","Machine Gun","C4 Bomb","Zeus Taser","Grenade","Weapon Type 10","Health Shot"};

//CS Slots
enum CSSlot {
	CSSlot_Primary = 0,
	CSSlot_Secondary = 1,
	CSSlot_Knife = 2,
	CSSlot_Grenade = 3,
	CSSlot_C4 = 4,
	CSSlot_Shield = 11
}

enum CSWeaponType {
	CSWeaponType_Unknown =	-1,
	CSWeaponType_Knife = 0,
	CSWeaponType_Pistol = 1,
	CSWeaponType_SMG = 2,
	CSWeaponType_Rifle = 3,
	CSWeaponType_Shotgun = 4,
	CSWeaponType_Sniper = 5,
	CSWeaponType_MachineGun = 6,
	CSWeaponType_C4 = 7,
	CSWeaponType_Taser = 8,
	CSWeaponType_Grenade = 9,
	CSWeaponType_Healthshot = 11
}

//Might be combined with the csgo enum struct into one later on.
enum {
	CSS_Weapon_Deagle =	1,
	CSS_Weapon_Glock = 2,
	CSS_Weapon_Ak47 = 3,
	CSS_Weapon_Aug = 4,
	CSS_Weapon_AWP = 5,
	CSS_Weapon_Famas = 6,
	CSS_Weapon_G3SG1 = 7,
	CSS_Weapon_Galil = 8,
	CSS_Weapon_M249 = 9,
	CSS_Weapon_M4A1 = 10,
	CSS_Weapon_Mac10 = 11,
	CSS_Weapon_P90 = 12,
	CSS_Weapon_MP5 = 13,
	CSS_Weapon_MP5Navy = 13,
	CSS_Weapon_UMP45 =	14,
	CSS_Weapon_XM1014 =	15,
	CSS_Weapon_M3 =	16,
	CSS_Weapon_USP = 17,
	CSS_Weapon_P228 = 18,
	CSS_Weapon_SG550 = 19,
	CSS_Weapon_Scar20 = 19,
	CSS_Weapon_SG552 = 20,
	CSS_Weapon_Krieg = 20,
	CSS_Weapon_SSG08 = 21,
	CSS_Weapon_Scout = 21,
	CSS_Weapon_Knife = 22,
	CSS_Grenade_Flashbang = 23,
	CSS_Grenade_HEGrenade = 24,
	CSS_Grenade_SmokeGrenade = 25,
	CSS_Weapon_C4 =	26
}

//I made this because TFTeam enum exists and cs doesn't have it :)
enum CSTeam {
	CSTeam_Invalid = -1,
	CSTeam_Unassigned = 0,
	CSTeam_Spectator = 1,
	CSTeam_Terrorist = 2,
	CSTeam_T = 2,
	CSTeam_CTerrorist = 3,
	CSTeam_CT = 3
}

//Bombsites
enum Bombsite {
	Bombsite_Invalid = -1,
	BombsiteA = 1,
	BombsiteB = 2,
	BombsiteC = 3
}

#define	CSSlot(%1) view_as<CSSlot>(%1)
#define	CSWeaponType(%1) view_as<CSWeaponType>(%1)
#define	CSTeam(%1) view_as<CSTeam>(%1)
#define	Bombsite(%1) view_as<Bombsite>(%1)

/**
 *	Returns the users current team.
 *
 *	@param	client        The users The users index.
 *
 *	@error	If the client is invalid, this returns CSTeam_Unassigned.
 */
stock CSTeam CS_GetClientTeam(int client) { return IsClientConnected(client) ? CSTeam(GetClientTeam(client)):CSTeam_Unassigned; }

/**
 *	Changes a users current team.
 *
 *	@param	client        The users The users index.
 *	@param	team          CSTeam team symbol.
 *
 *	@error	If the client is not connected, this returns false.
 */
stock bool CS_ChangeClientTeam(int client, CSTeam team)	{
	if(IsClientConnected(client))	{
		ChangeClientTeam(client, view_as<int>(team));
		return true;
	}
	
	return false;
}

/**
 *	Returns the teams client count.
 *
 *	@param team		CSTeam team.
 */
stock int CS_GetTeamClientCount(CSTeam team) { return GetTeamClientCount(view_as<int>(team)); }

/**
 *	Set the users pending new team. (CS:GO)
 *
 *	@param	client		The users index.
 *	@param	team		The new team index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CS_SetClientPendingTeam(int client, CSTeam team)	{ return SetClientPendingTeam(client, view_as<int>(team)); }

/**
 *	Returns the users pending new team. (CS:GO)
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns CSTeam_Unassigned.
 */
stock CSTeam CS_GetClientPendingTeam(int client) { return view_as<CSTeam>(GetClientPendingTeam(client)); }

#if !defined _tklib_no_sdktools
/**
 *	Returns if the warmup is currently ongoing
 */
stock bool CS_IsWarmupRound() { return view_as<bool>(GameRules_GetProp("m_bWarmupPeriod")); }

/**
 *	If true, warmup will start, else will be ended. (CS:GO Only)
 *
 *	@param	warmup	If true, match will be on warmup mode, else warmup will be forced to end.
 *
 *	@noreturn
 */
stock void CS_SetWarmupRound(bool warmup) { GameRules_SetProp("m_bWarmupPeriod", warmup); }

/**
 *	Returns if the match is currently paused/is in freezetime (CS:GO Only)
 *
 *	@noreturn
 */
stock bool CS_IsMatchPaused() { return view_as<bool>(GameRules_GetProp("m_bMatchWaitingForResume") == 1); }

/**
 *	Set if the match should be paused. (CS:GO Only)
 *
 *	@param	pause	If true, match will be paused, else unpaused.
 *
 *	@noreturn
 */
stock void CS_SetMatchPaused(bool pause) { GameRules_SetProp("m_bMatchWaitingForResume", pause); }

/**
 *	Returns if the bomb is planted.
 */
stock bool CS_IsBombPlanted() { return view_as<bool>(GameRules_GetProp("m_bBombPlanted")); }

/**
 *	Set if the bomb should be planted.
 *
 *	@param	planted	If true, the bomb will be forced to be 'planted', else forced to be 'not planted'. (Experimental)
 *
 *	@noreturn
 */
stock void CS_SetBombPlanted(bool planted) { GameRules_SetProp("m_bBombPlanted", planted); }
#endif

/**
 *	Sets the users current account/cash/money balance
 *
 *	@param	client		The users index.
 *	@param	value		Money amount.
 *
 *	@error	If the user is invalid, this will return false.
 */
stock bool CS_SetClientMoney(int client, int value)	{ return SetEntPropEx(client, Prop_Send, "m_iAccount", value); }

/**
 *	Returns the users current account/cash/money balance
 *
 *	@param	client        The users index.
 *
 *	@error	If the user is invalid, this will return -1.
 */
stock int CS_GetClientMoney(int client)	{ return GetEntPropEx(client, Prop_Send, "m_iAccount"); }

/**
 *	Set the users flash duration, 0.0 or 0 is basically disabled
 *
 *	@param	client		The users index.
 *	@param	value		Flash duration.
 *
 *	@error	If the user is invalid, nothing will happen.
 */
stock bool CS_SetClientFlashDuration(int client, float value) { return SetEntPropFloatEx(client, Prop_Send, "m_flFlashDuration", value); }

/**
 *	Returns the users flash duration
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this will return -1.0.
 */
stock float CS_GetClientFlashDuration(int client) { return GetEntPropFloatEx(client, Prop_Send, "m_flFlashDuration"); }

/**
 *	Set the users armor.
 *
 *	@param	client	The users index.
 *	@param	value	The armor points.
 *
 *	@error	If the user is invalid, returns false.
 */
stock bool CS_SetClientArmor(int client, int value)	{ return SetEntPropEx(client, Prop_Send, "m_ArmorValue", value); }

/**
 *	Returns the users armor value.
 *
 *	@param client	The users index.
 *	@param value	The value you specify.
 *
 *	@error			If the user is invalid, this will return -1.
 */
stock int CS_GetClientArmor(int client)	{ return GetEntPropEx(client, Prop_Send, "m_ArmorValue"); }

/**
 *	Set the users armor.
 *
 *	@param	client	The users index.
 *	@param	value	If true, user will have a helmet.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CS_SetClientHelmet(int client, bool value) { return SetEntPropEx(client, Prop_Send, "m_bHasHelmet", value); }

/**
 *	Returns if the user has helmet.
 *
 *	@param client	The users index.
 *	@param value	The value you specify.
 *	@error			If the user is invalid, this will return false.
 */
stock bool CS_ClientHasHelmet(int client) { return GetEntPropBool(client, Prop_Send, "m_bHasHelmet"); }

/**
 *	Set the users armor.
 *
 *	@param	client	The users index.
 *	@param	value	The armor points.
 *
 *	@error	If the user is invalid, returns false.
 */
stock bool CS_SetClientHeavyArmor(int client, int value) { return SetEntPropEx(client, Prop_Send, "m_bHasHeavyArmor", value); }

/**
 *	Returns if the user has heavy armor.
 *
 *	@param client	The users index.
 *	@param value	The value you specify.
 *	@error			If client is invalid, it will return false.
 */
stock bool CS_ClientHasHeavyArmor(int client) { return GetEntPropBool(client, Prop_Send, "m_bHasHeavyArmor"); }

/**
 *	Set if the user should have defuser kit.
 *
 *	@param	client		The users index.
 *	@param	defusekit	If true, the user will have a defuse kit.
 *
 *	@param	If the user is invalid, this returns false.
 */
stock bool CS_SetClientDefuserKit(int client, bool defusekit) { return SetEntPropEx(client, Prop_Send, "m_bHasDefuser", defusekit); }

/**
 *	Returns if the user has a defuser kit.
 *
 *	@param	client	The users index.
 *
 *	@param	If the user is invalid, this returns false.
 */
stock bool CS_ClientHasDefuserKit(int client) { return GetEntPropBool(client, Prop_Send, "m_bHasDefuser"); }

/**
 *	Returns the users weapon entity name via slot
 *
 *	@param	client		The users index.
 *	@param	slot		Target CSSlot slot.
 *	@param	output		Buffer to store the weapon entity name.
 *	@param	maxlen		The maximum length for the buffer.
 
 *	@error	If the user or users active weapon is invalid, this returns false.
 */
stock bool CS_GetPlayerWeaponSlotName(int client, CSSlot slot, char[] output, int maxlen) {
	if(!(Tklib_IsValidClient(client, false, true) && IsValidEntityEx(CS_GetPlayerWeaponSlot(client, slot))))
		return false;
	
	return GetEdictClassname(CS_GetPlayerWeaponSlot(client, slot), output, sizeof(maxlen));
}

/**
 *	Give the user a weapon and delete their slot & set primary and secondary ammo
 *
 *	@param	client		The users index.
 *	@param	weapon		Weapon entity name.
 *	@param	slot		Players slot to be removed.
 *	@param	primary		Amount of primary ammo for the weapon selected.
 *	@param	secondary	Amount of secondary ammo for the weapon selected.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CS_GiveClientWeaponEx2(int client, const char[] weapon, CSSlot slot, int primary, int secondary)	{
	if(Tklib_IsValidClient(client, false, true))	{
		CS_RemovePlayerWeaponSlot(client, slot);
		GivePlayerItem(client, weapon);
		SetWeaponAmmoEx(GetClientActiveWeapon(client), primary, secondary);
		return true;
	}
	
	return false;
}

/**
 *	Remove a users weapon in a specified slot
 *
 *	@param	client		The users index.
 *	@param	slot		CSSlot slot.
 *
 *	@error	If the user or weapon in the specified slot is invalid, this returns false.
 */
stock bool CS_DropPlayerWeaponSlot(int client, CSSlot slot)	{
	if(Tklib_IsValidClient(client, false, true))	{
		int weapon = -1;
		if(IsValidEntityEx((weapon = CS_GetPlayerWeaponSlot(client, slot))))
			CS_DropWeapon(client, weapon, true, true);
		
		return true;
	}
	
	return false;
}

/**
 *	Remove a users weapon in a specified slot
 *
 *	@param	client		The users index.
 *	@param	slot		CSSlot weapon slot.
 *
 *	@error	If the user or weapon in the specified slot is invalid, this returns false.
 */
stock bool CS_RemovePlayerWeaponSlot(int client, CSSlot slot)	{
	if(IsClientInGame(client) && IsPlayerAlive(client))	{
		int weapon = -1;
		if(IsValidEntityEx((weapon = CS_GetPlayerWeaponSlot(client,	slot))))	{
			RemovePlayerItem(client, weapon);
			RemoveEdict(weapon);
		}
		
		return true;
	}
	
	return false;
}

/**
 *	Give the user a weapon and delete their current slot
 *
 *	@param	client		The users index.
 *	@param	weapon		Weapon entity name.
 *	@param	slot		Players slot to be removed.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CS_GiveClientWeapon(int client, char[] weapon, CSSlot slot) {
	if(Tklib_IsValidClient(client, _, true)) {
		CS_RemovePlayerWeaponSlot(client, slot);
		GivePlayerItem(client, weapon);
		return true;
	}
	
	return false;
}

/**
 *	Return the users weapon entity.
 *
 *	@param	client		The users index.
 *	@param	slot		CSSlot value.
 *
 *	@error	If the user is invalid, this returns -1.
 */
stock int CS_GetPlayerWeaponSlot(int client, CSSlot slot) { return Tklib_IsValidClient(client, false, true) ? GetPlayerWeaponSlot(client, view_as<int>(slot)):-1; } 

/**
 *	Return if the weapon is in silenced mode.
 *
 *	@param	weapon		Weapon entity.
 *
 *	@error	If the weapon is invalid, this returns false.
*/
stock bool CS_IsWeaponSilenced(int weapon) { return GetEntPropBool(weapon, Prop_Data, "m_bSilencerOn"); }

/**
 *	Set the sniper's scope level.
 *
 *	@param	weapon		Weapon entity.
 *	@param	value		Value amount.
 *
 *	@error	If the weapon entity is invalid, nothing will happen.
 */
stock bool CS_SetSniperZoomLevel(int weapon, int value)	{ return SetEntPropEx(weapon, Prop_Send, "m_zoomLevel", value); }

/**
 *	Returns the sniper's scope level.
 *
 *	@param	weapon	Weapon entity.
 *
 *	@error	If the weapon entity is invalid, this returns -1.
 */
stock int CS_GetSniperZoomLevel(int weapon)	{ return GetEntPropEx(weapon, Prop_Send, "m_zoomLevel"); }

/**
 *	Force the weapon to be in burst mode.
 *
 *	@param	weapon	Weapon entity.
 *	@param	value	If true, this forces burst mode on.
 *
 *	@error	If the weapon entity is invalid, this returns false.
 */
stock bool CS_SetWeaponInBurstMode(int weapon, bool value) { return SetEntPropEx(weapon, Prop_Send, "m_bBurstMode", value); }

/**
 *	Returns if the weapon is in burst mode.
 *
 *	@param	weapon	Weapon entity.
 *
 *	@error	If the weapon entity is invalid, this returns false.
 */
stock bool CS_IsWeaponInBurstMode(int weapon) { return GetEntPropBool(weapon, Prop_Send, "m_bBurstMode"); }

/**
 *	Get the actual name of the users weapon.
 *
 *	@param weapon		Weapon entity name.
 *	@param name			Buffer to store in.
 *	@param maxlen		Maximum length of the buffer.
 *
 *	@noreturn
 */
stock void CS_GetWeaponName(const char[] weapon, char[] output, int maxlen)	{
	//Rifles
	if(StrEqual(weapon,	"weapon_ak47"))	//They talk about my 1taps, aiming is so easy
		strcopy(output, maxlen, "Ak-47");
	if(StrEqual(weapon,	"weapon_m4a1_silencer"))
		strcopy(output, maxlen, "M4A1 Silenced");
	if(StrEqual(weapon,	"weapon_galilar"))
		strcopy(output, maxlen, "Galil Automatic Rifle");
	if(StrEqual(weapon,	"weapon_famas"))
		strcopy(output, maxlen, "Famas");
	if(StrEqual(weapon,	"weapon_sg556"))
		strcopy(output, maxlen, "Krieg SG556");
	if(StrEqual(weapon,	"weapon_sg552"))
		strcopy(output, maxlen, "Krieg SG552");
	if(StrEqual(weapon,	"weapon_aug"))
		strcopy(output, maxlen, "AUG");
	
	//Sub-Machine-Guns
	if(StrEqual(weapon,	"weapon_mp5sd"))
		strcopy(output, maxlen, "MP5 Silenced");
	if(StrEqual(weapon,	"weapon_mp5navy"))
		strcopy(output, maxlen, "MP5 Navy");
	if(StrEqual(weapon,	"weapon_mac10"))
		strcopy(output, maxlen, "MAC-10");
	if(StrEqual(weapon,	"weapon_p90"))	//Suka rush b fast no stop
		strcopy(output, maxlen, "P90");
	
	//Shotguns
	if(StrEqual(weapon,	"weapon_m3"))
		strcopy(output, maxlen, "M3");
	if(StrEqual(weapon,	"weapon_xm1014"))
		strcopy(output, maxlen, "XM1014");
	if(StrEqual(weapon,	"weapon_sawedoff"))
		strcopy(output, maxlen, "Sawed-Off");
	if(StrEqual(weapon,	"weapon_mag7"))
		strcopy(output, maxlen, "Mag-7");
	
	//Pistols
	if(StrEqual(weapon,	"weapon_deagle"))	//Aka Pocket AWP
		strcopy(output, maxlen, "Desert Eagle");
	if(StrEqual(weapon,	"weapon_p250"))
		strcopy(output, maxlen, "P250");
	if(StrEqual(weapon,	"weapon_p228"))
		strcopy(output, maxlen, "P228");
	if(StrEqual(weapon,	"weapon_cz75a"))	//Used to be known as pocket-ak47 in 2016-2018
		strcopy(output, maxlen, "CZ75-Auto");
	if(StrEqual(weapon,	"weapon_glock"))	//Glawks (Reference to GoDaZeD if you remember him)
		strcopy(output, maxlen, "Glock");
	if(StrEqual(weapon,	"weapon_hkp2000"))
		strcopy(output, maxlen, "P2000");
	if(StrEqual(weapon,	"weapon_usp_silencer"))
		strcopy(output, maxlen, "USP Silenced");
	if(StrEqual(weapon,	"weapon_usp"))
		strcopy(output, maxlen, "USP");
	if(StrEqual(weapon,	"weapon_tec9"))	//Rush b fast no stop
		strcopy(output, maxlen, "Tec-9");
	
	//Snipers
	if(StrEqual(weapon,	"weapon_awp"))
		strcopy(output, maxlen, "AWP");
	if(StrEqual(weapon,	"weapon_ssg08"))	//Oldschool jumping scout ftw
		strcopy(output, maxlen, "SSG08 Scout");
	if(StrEqual(weapon,	"weapon_scout"))
		strcopy(output, maxlen, "Scout");
	if(StrEqual(weapon,	"weapon_g3sg1"))
		strcopy(output, maxlen, "G3SG1");
	if(StrEqual(weapon,	"weapon_scar20"))
		strcopy(output, maxlen, "SCAR-20");
	
	//Machine Guns
	if(StrEqual(weapon,	"weapon_m249"))
		strcopy(output, maxlen, "M249");
	if(StrEqual(weapon,	"weapon_negev"))	//Laser beam
		strcopy(output, maxlen, "Negev");
	
	//Grenades
	if(StrEqual(weapon,	"weapon_hegrenade"))
		strcopy(output, maxlen, "High-Explosive Grenade");
	if(StrEqual(weapon,	"weapon_flashgrenade"))
		strcopy(output, maxlen, "Flashbang Grenade");
	if(StrEqual(weapon,	"weapon_smokegrenade"))
		strcopy(output, maxlen,	"Smoke Grenade");
	if(StrEqual(weapon,	"weapon_tacgrenade"))
		strcopy(output, maxlen, "Tactical Grenade");
	if(StrEqual(weapon,	"weapon_incgrenade"))
		strcopy(output, maxlen, "Incendiary Grenade");
	if(StrEqual(weapon,	"weapon_molotov"))
		strcopy(output, maxlen, "Molotov Grenade");
	
	//Other
	if(StrEqual(weapon,	"weapon_zeus"))	//Ingame called X27 but model calls itself X21, volvo pls fix
		strcopy(output, maxlen, "Zeus-X21");
	
	if(StrEqual(weapon,	"weapon_m4a1"))
		strcopy(output, maxlen, (GetEngineVersion() == Engine_CSS || GetEngineVersion() == Engine_SourceSDK2007) ? "M4A1":"M4A4");
}

/**
 *	Gather the name of the team clan(s).
 *
 *	@param	team	CSTeam team symbol.
 *	@param	buffer	String to store in.
 *	@param	maxlen	Maximum length of the string.
 *
 *	@error	If the procedure failed, this returns false.
 */
stock bool CS_GetTeamName(CSTeam team, char[] buffer, int maxlen) {
	int index = -1;
	while((index = FindEntityByClassname(index, "cs_team_manager")) != -1) {
		if(view_as<CSTeam>(GetEntPropEx(index, Prop_Send, "m_iTeamNum")) == team) {
			char checkname[96];
			bool success = GetEntPropStringEx(index, Prop_Send, "m_szClanTeamname", buffer, maxlen);
			
			if(StrEqual(checkname, "")) {
				switch(team) {
					case CSTeam_T:	{
						strcopy(buffer, maxlen, "Terrorists");
						success = true;
					}
					case CSTeam_CT:	{
						strcopy(buffer, maxlen, "Counter-Terrorists");
						success = true;
					}
				}
			}
			
			return success;
		}
	}
	
	return false;
}

/**
 *	Returns the bombsite count.
 *
 *	@error	If no bombsites were found, this returns 0.
 */
stock int CS_GetBombsiteCount()	{
	int site = -1, count = 0;
	while((site = FindEntityByClassname(site, "func_bomb_target")) != -1)
		count++;
	
	return count;
}

/**
 *	Returns the closest bombsite to the entity.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity is invalid, this returns Bombsite_Invalid.
 */
stock Bombsite CS_GetBombsite(int entity)	{
	if(!IsValidEntityEx(entity))
		return	Bombsite_Invalid;
	
	int index = view_as<int>(FindEntity("cs_player_manager"));
	if(!FindEntity("cs_player_manager"))
		return Bombsite_Invalid;
	
	float Site_A[3], Site_B[3];
	GetEntPropVector(index, Prop_Send, "m_bombsiteCenterA", Site_A);
	GetEntPropVector(index, Prop_Send, "m_bombsiteCenterB", Site_B);
	
	int site = -1;
	while((site = FindEntityByClassname(site, "func_bomb_target")) != -1)	{
		float VecMin[3], VecMax[3];
		
		GetEntPropVector(site, Prop_Send, "m_vecMins", VecMin);
		GetEntPropVector(site, Prop_Send, "m_vecMax", VecMax);
		
		if(VecMin[0] <= Site_A[0] <= VecMax[0] && VecMin[1] <= Site_A[1] <= VecMax[1] && VecMin[2] <= Site_A[2] <= VecMax[2])
			return BombsiteA;
		else if(VecMin[0] <= Site_B[0] <= VecMax[0] && VecMin[1] <= Site_B[1] <= VecMax[1] && VecMin[2] <= Site_B[2] <= VecMax[2])
			return BombsiteB;
	}
	
	return BombsiteC;
}

/**
 *	Returns if the user is in the buy-zone.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CS_IsClientInBuyZone(int client)	{ return GetEntPropBool(client, Prop_Send, "m_bInBuyZone"); }

/**
 *	Set if the user should be seen as if the user is in the buy-zone.
 *
 *	@param	client		The users index.
 *	@param	buyzone		If true, the user will be seen as if being inside the buy-zone.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CS_SetClientInBuyZone(int client, bool buyzone) { return SetEntPropEx(client, Prop_Send, "m_bInBuyZone", buyzone); }

/**
 *	Returns if the user is defusing.
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool CS_IsClientDefusing(int client) { return GetEntPropBool(client, Prop_Send, "m_bIsDefusing"); }

/**
 *	Set the defusing status on the user.
 *
 *	@param	client		The users index.
 *	@param	status		The defusing status to set.
 *
 *	@error	If the user is invalid or procedure failed, this returns false.
 */
stock bool CS_SetClientDefusing(int client, bool status) { return SetEntPropEx(client, Prop_Send, "m_bDefusing", status); }

/**
 *	Returns a random CSTeam team (CT or T)
 *
 *	@return	Returns a CSTeam team.
 */
stock CSTeam CS_GetRandomTeam() { return view_as<CSTeam>(GetRandomInt(2, 3)); }

/**
 *	Returns if the weapon is zoomed in.
 *
 *	@param	weapon	The weapon entity.
 */
stock bool CS_IsWeaponZoomedIn(any weapon) { return GetEntPropBool(weapon, Prop_Send, "m_weaponMode"); }

/**
 *	Returns the weapon definition index by its entity name.
 *
 *	@param	weapon	The weapon entity name.
 *
 *	@returns	CSS_* enum (integer). 0 if invalid entity.
 */
stock int CSS_GetWeaponDefindex(const char[] weapon) {
	if(StrEqual(weapon, "weapon_ak47", false))
		return	CSS_Weapon_Ak47;
	
	if(StrEqual(weapon, "weapon_m4a1", false))
		return	CSS_Weapon_M4A1;
	
	if(StrEqual(weapon, "weapon_galil", false))
		return	CSS_Weapon_Galil;
	
	if(StrEqual(weapon, "weapon_famas", false))
		return	CSS_Weapon_Famas;
	
	if(StrEqual(weapon, "weapon_sg552", false))
		return	CSS_Weapon_SG552;
	
	if(StrEqual(weapon, "weapon_aug", false))
		return	CSS_Weapon_Aug;
	
	if(StrEqual(weapon, "weapon_scout", false))
		return	CSS_Weapon_SSG08;
	
	if(StrEqual(weapon, "weapon_awp", false))
		return	CSS_Weapon_AWP;
	
	if(StrEqual(weapon, "weapon_sg550", false))
		return	CSS_Weapon_SG550;
	
	if(StrEqual(weapon, "weapon_g3sg1", false))
		return	CSS_Weapon_G3SG1;
	
	if(StrEqual(weapon, "weapon_m3", false))
		return	CSS_Weapon_M3;
	
	if(StrEqual(weapon, "weapon_xm1014", false))
		return	CSS_Weapon_XM1014;
	
	if(StrEqual(weapon, "weapon_m249", false))
		return	CSS_Weapon_M249;
	
	if(StrEqual(weapon, "weapon_c4", false))
		return	CSS_Weapon_C4;
	
	if(StrEqual(weapon, "weapon_hegrenade", false))
		return	CSS_Grenade_HEGrenade;
	
	if(StrEqual(weapon, "weapon_flashbang", false))
		return	CSS_Grenade_Flashbang;
	
	if(StrEqual(weapon, "weapon_smokegrenade", false))
		return	CSS_Grenade_SmokeGrenade;
	
	if(StrEqual(weapon, "weapon_glock", false))
		return	CSS_Weapon_Glock;
	
	if(StrEqual(weapon, "weapon_usp", false))
		return	CSS_Weapon_USP;
	
	if(StrEqual(weapon, "weapon_p228", false))
		return	CSS_Weapon_P228;
	
	if(StrEqual(weapon, "weapon_deagle", false))
		return	CSS_Weapon_Deagle;
	
	if(StrEqual(weapon, "weapon_p90", false))
		return	CSS_Weapon_P90;
	
	if(StrEqual(weapon, "weapon_ump45", false))
		return	CSS_Weapon_UMP45;
	
	if(StrEqual(weapon, "weapon_mp5navy", false))
		return	CSS_Weapon_MP5;
	
	if(StrEqual(weapon, "weapon_knife", false))
		return	CSS_Weapon_Knife;
	
	return 0;
}

/**
 *	Returns the price of the weapon entity name.
 *	Price varies from different CS Versions.
 *	Useful when using CS_OnBuyCommand.
 *
 *	@param	weapon	The weapon entity name to read.
 *
 *	@return	Returns the price of the specified weapon ("weapon_"-type). 0 if not found.
 */
stock int CS_GetPriceFromWeapon(const char[] weapon) {
	int price = 0;
	
	/* Incase GameIdentifier wasn't included */
	char folder[32];
	GetGameFolderName(folder, sizeof(folder));
	
	switch(GetEngineVersion()) {
		case Engine_CSS: {
			/* To be added */
		}
		case Engine_CSGO: {
			switch(StrEqual(folder, "csgo")) {
				/* CS:GO */
				case	true:	{
					if(StrEqual(weapon, "weapon_ak47", false))
						price = 2700;
					
					if(StrEqual(weapon, "weapon_m4a1", false))
						price = 3100;
					
					if(StrEqual(weapon, "weapon_m4a1_silencer", false))
						price = 2900;
					
					if(StrEqual(weapon, "weapon_galilar", false))
						price = 1800;
					
					if(StrEqual(weapon, "weapon_famas", false))
						price = 2050;
					
					if(StrEqual(weapon, "weapon_sg556", false))
						price = 3000;
					
					if(StrEqual(weapon, "weapon_aug", false))
						price = 3300;
					
					if(StrEqual(weapon, "weapon_ssg08", false))
						price = 1700;
					
					if(StrEqual(weapon, "weapon_awp", false))
						price = 4750;
					
					if(StrEqual(weapon, "weapon_scar20", false))
						price = 5000;
					
					if(StrEqual(weapon, "weapon_g3sg1", false))
						price = 5000;
					
					if(StrEqual(weapon, "weapon_nova", false))
						price = 1050;
					
					if(StrEqual(weapon, "weapon_sawedoff", false))
						price = 1100;
					
					if(StrEqual(weapon, "weapon_mag7", false))
						price = 1300;
					
					if(StrEqual(weapon, "weapon_xm1014", false))
						price = 2000;
					
					if(StrEqual(weapon, "weapon_m249", false))
						price = 5200;
					
					if(StrEqual(weapon, "weapon_negev", false))
						price = 1700;
					
					if(StrEqual(weapon, "weapon_taser", false))
						price = 200;
					
					if(StrEqual(weapon, "weapon_hegrenade", false))
						price = 300;
					
					if(StrEqual(weapon, "weapon_flashbang", false))
						price = 200;
					
					if(StrEqual(weapon, "weapon_decoy", false))
						price = 50;
					
					if(StrEqual(weapon, "weapon_smokegrenade", false))
						price = 300;
					
					if(StrEqual(weapon, "weapon_incgrenade", false))
						price = 600;
					
					if(StrEqual(weapon, "weapon_molotov", false))
						price = 600;
					
					if(StrEqual(weapon, "weapon_glock", false))
						price = 200;
					
					if(StrEqual(weapon, "weapon_usp_silencer", false))
						price = 200;
					
					if(StrEqual(weapon, "weapon_hkp2000", false))
						price = 200;
					
					if(StrEqual(weapon, "weapon_p250", false))
						price = 300;
					
					if(StrEqual(weapon, "weapon_deagle", false))
						price = 700;
					
					if(StrEqual(weapon, "weapon_tec9", false))
						price = 500;
					
					if(StrEqual(weapon, "weapon_revolver", false))
						price = 700;
					
					if(StrEqual(weapon, "weapon_fiveseven", false))
						price = 500;
					
					if(StrEqual(weapon, "weapon_elites", false))
						price = 300;
					
					if(StrEqual(weapon, "weapon_p90", false))
						price = 2350;
					
					if(StrEqual(weapon, "weapon_ump45", false))
						price = 1200;
					
					if(StrEqual(weapon, "weapon_mp7", false))
						price = 1500;
					
					if(StrEqual(weapon, "weapon_mp9", false))
						price = 1250;
					
					if(StrEqual(weapon, "weapon_mp5sd", false))
						price = 2700;
					
					if(StrEqual(weapon, "weapon_bison", false))
						price = 1400;
					
					if(StrEqual(weapon, "weapon_shield", false))
						price = 1100;
				}
				/* CS:CO */
				case false: {
					/* To be added */
				}
			}
		}
		case Engine_SourceSDK2007: {
			if(StrEqual(folder, "cspromod")) {
				
			}
		}
	}
	
	return price;
}

#endif