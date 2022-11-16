//==========================================//
// Tklib / CSGO.
//==========================================//
#if !defined _tklib_no_csgo

const int MaxCSGOWepLength = 16;
const int MaxCSGOItemDefinition = 526;

stock char
CSGO_TeamNameEx[][] = {"{grey}Unassigned{default}","{grey}Spectators{default}","{yellow}Terrorists{default}","{bluegrey}Counter-Terrorists{default}"},
CSGO_TeamColour[][] = {"{grey}","{grey}","{yellow}","{bluegrey}"},
CSGO_RankName[][] = {"Unranked","Silver I","Silver II","Silver III","Silver IV","Silver Elite","Silver Elite Master","Gold Nova I","Gold Nova II","Gold Nova III","Gold Nova Master","Master Guardian I","Master Guardian II","Master Guardian Elite","Distinguished Master Guardian","Legendary Eagle","Legendary Eagle Master","Supreme Master First Class","The Global Elite"};

enum CSGORank {
	CSGORank_Recalibrated = -2,
	CSGORank_Expired = -1,
	CSGORank_None = 0,
	CSGORank_Silver1 = 1,
	CSGORank_S1 = 1,
	CSGORank_Silver2 = 2,
	CSGORank_S2 = 2,
	CSGORank_Silver3 = 3,
	CSGORank_S3 = 3,
	CSGORank_Silver4 = 4,
	CSGORank_S4 = 4,
	CSGORank_SilverElite = 5,
	CSGORank_SE = 5,
	CSGORank_SilverEliteMaster = 6,
	CSGORank_SEM = 6,
	CSGORank_GoldNova1 = 7,
	CSGORank_GN1 = 7,
	CSGORank_GoldNova2 = 8,
	CSGORank_GN2 = 8,
	CSGORank_GoldNova3 = 9,
	CSGORank_GN3 = 9,
	CSGORank_GoldNovaMaster = 10,
	CSGORank_GNM = 10,
	CSGORank_MasterGuardian1 = 11,
	CSGORank_MG1 = 11,
	CSGORank_MasterGuardian2 = 12,
	CSGORank_MG2 = 12,
	CSGORank_MasterGuardianElite = 13,
	CSGORank_MGE = 13,
	CSGORank_DistinguishedMasterGuardian = 14,
	CSGORank_DMG = 14,
	CSGORank_LegendaryEagle = 15,
	CSGORank_LE = 15,
	CSGORank_LegendaryEagleMaster = 16,
	CSGORank_LEM = 16,
	CSGORank_SupremeMasterFirstClass = 17,
	CSGORank_SMFC = 17,
	CSGORank_TheGlobalElite = 18,
	CSGORank_GE = 18
}

enum {
	CSGO_Weapon_Invalid = -1,
	CSGO_Weapon_Deagle = 1,
	CSGO_Weapon_FiveSeven = 3,
	CSGO_Weapon_Glock = 4,
	CSGO_Weapon_Ak47 = 7,
	CSGO_Weapon_Aug = 8,
	CSGO_Weapon_AWP = 9,
	CSGO_Weapon_Famas = 10,
	CSGO_Weapon_G3SG1 = 11,
	CSGO_Weapon_GalilAR = 13,
	CSGO_Weapon_M249 = 14,
	CSGO_Weapon_M4A4 = 16,
	CSGO_Weapon_Mac10 = 17,
	CSGO_Weapon_P90 = 19,
	CSGO_Weapon_MP5 = 23,
	CSGO_Weapon_MP5SD = 23,
	CSGO_Weapon_UMP45 = 24,
	CSGO_Weapon_XM1014 = 25,
	CSGO_Weapon_Bizon = 26,
	CSGO_Weapon_MAG7 = 27,
	CSGO_Weapon_Negev = 28,
	CSGO_Weapon_SawedOff = 29,
	CSGO_Weapon_Tec9 = 30,
	CSGO_Weapon_Zeus = 31,
	CSGO_Weapon_Taser = 31,
	CSGO_Weapon_P2000 = 32,
	CSGO_Weapon_MP7 = 33,
	CSGO_Weapon_MP9 = 34,
	CSGO_Weapon_Nova = 35,
	CSGO_Weapon_P250 = 36,
	CSGO_Weapon_Scar20 = 38,
	CSGO_Weapon_SG556 = 39,
	CSGO_Weapon_SSG08 = 40,
	CSGO_Weapon_Scout = 40,
	CSGO_Knife_CT = 41,
	CSGO_Knife_Gold = 42,
	CSGO_Grenade_Flashbang = 43,
	CSGO_Grenade_HEGrenade = 44,
	CSGO_Grenade_SmokeGrenade = 45,
	CSGO_Grenade_Molotov = 46,
	CSGO_Grenade_Decoy = 47,
	CSGO_Grenade_Incendiary = 48,
	CSGO_Weapon_C4 = 49,
	CSGO_Item_DefuserKit = 55,
	CSGO_Knife_T = 59,
	CSGO_Weapon_M4A1_S = 60,
	CSGO_Weapon_USP_S = 61,
	CSGO_Weapon_CZ75_A = 62,
	CSGO_Weapon_Revolver = 64,
	CSGO_Grenade_TAGrenade = 68,
	CSGO_Grenade_TacticalAwareness = 68,
	CSGO_Grenade_BreachCharge = 70,
	CSGO_Knife_Spectral = 80,
	CSGO_Knife_Ghost = 80,
	CSGO_Knife_Bayonet = 500,
	CSGO_Knife_Classic = 503,
	CSGO_Knife_Flip = 505,
	CSGO_Knife_Gut = 506,
	CSGO_Knife_Karambit = 507,
	CSGO_Knife_M9_Bayonet = 508,
	CSGO_Knife_Huntsman = 509,
	CSGO_Knife_Falchion = 512,
	CSGO_Knife_Bowie = 514,
	CSGO_Knife_Butterfly = 515,
	CSGO_Knife_ShadowDaggers = 516,
	CSGO_Knife_ButtPlugs = 516,
	CSGO_Knife_Paracord = 517,
	CSGO_Knife_Survival = 518,
	CSGO_Knife_Ursus = 519,
	CSGO_Knife_Navaja = 520,
	CSGO_Knife_Nomad = 521,
	CSGO_Knife_Stiletto = 522,
	CSGO_Knife_Talon = 523,
	CSGO_Knife_Skeleton = 525,
	CSGO_Gloves_BrokenFang = 4725,
	CSGO_Gloves_Bloodhound = 5027,
	CSGO_Gloves_Sport = 5030,
	CSGO_Gloves_Driver = 5031,
	CSGO_Gloves_HandWraps = 5032,
	CSGO_Gloves_Moto = 5033,
	CSGO_Gloves_Specialist = 5034,
	CSGO_Gloves_Hydra = 5035
}

enum CSGORankType {
	CSGORankType_Competitive = 0,
	CSGORankType_Wingman = 50,
	CSGORankType_DangerZone = 70
}

#define	CSGORank(%1) view_as<CSGORank>(%1)
#define	CSGORankType(%1) view_as<CSGORankType>(%1)

stock int CSGO_Item[] = {
	CSGO_Weapon_Deagle,
	CSGO_Weapon_FiveSeven,
	CSGO_Weapon_Glock,
	CSGO_Weapon_Ak47,
	CSGO_Weapon_Aug,
	CSGO_Weapon_AWP,
	CSGO_Weapon_Famas,
	CSGO_Weapon_G3SG1,
	CSGO_Weapon_GalilAR,
	CSGO_Weapon_M249,
	CSGO_Weapon_M4A4,
	CSGO_Weapon_Mac10,
	CSGO_Weapon_P90,
	CSGO_Weapon_MP5,
	CSGO_Weapon_UMP45,
	CSGO_Weapon_XM1014,
	CSGO_Weapon_Bizon,
	CSGO_Weapon_MAG7,
	CSGO_Weapon_Negev,
	CSGO_Weapon_SawedOff,
	CSGO_Weapon_Tec9,
	CSGO_Weapon_Zeus,
	CSGO_Weapon_P2000,
	CSGO_Weapon_MP7,
	CSGO_Weapon_MP9,
	CSGO_Weapon_Nova,
	CSGO_Weapon_P250,
	CSGO_Weapon_Scar20,
	CSGO_Weapon_SG556,
	CSGO_Weapon_SSG08,
	CSGO_Knife_CT,
	CSGO_Knife_Gold,
	CSGO_Grenade_Flashbang,
	CSGO_Grenade_HEGrenade,
	CSGO_Grenade_SmokeGrenade,
	CSGO_Grenade_Molotov,
	CSGO_Grenade_Decoy,
	CSGO_Grenade_Incendiary,
	CSGO_Weapon_C4,
	CSGO_Item_DefuserKit,
	CSGO_Knife_T,
	CSGO_Weapon_M4A1_S,
	CSGO_Weapon_USP_S,
	CSGO_Weapon_CZ75_A,
	CSGO_Weapon_Revolver,
	CSGO_Grenade_TAGrenade,
	CSGO_Grenade_BreachCharge,
	CSGO_Knife_Spectral,
	CSGO_Knife_Bayonet,
	CSGO_Knife_Classic,
	CSGO_Knife_Flip,
	CSGO_Knife_Gut,
	CSGO_Knife_Karambit,
	CSGO_Knife_M9_Bayonet,
	CSGO_Knife_Huntsman,
	CSGO_Knife_Falchion,
	CSGO_Knife_Bowie,
	CSGO_Knife_Butterfly,
	CSGO_Knife_ShadowDaggers,
	CSGO_Knife_Paracord,
	CSGO_Knife_Survival,
	CSGO_Knife_Ursus,
	CSGO_Knife_Navaja,
	CSGO_Knife_Nomad,
	CSGO_Knife_Stiletto,
	CSGO_Knife_Talon,
	CSGO_Knife_Skeleton,
	CSGO_Gloves_BrokenFang,
	CSGO_Gloves_Bloodhound,
	CSGO_Gloves_Sport,
	CSGO_Gloves_Driver,
	CSGO_Gloves_HandWraps,
	CSGO_Gloves_Moto,
	CSGO_Gloves_Specialist,
	CSGO_Gloves_Hydra
};
stock char CSGO_ItemName[][] = {
	"Deagle",
	"Five-SeveN",
	"Glock-18",
	"Ak-47",
	"AUG",
	"AWP",
	"Famas",
	"G3SG1",
	"Galil-AR",
	"M249",
	"M4A4",
	"MAC-10",
	"P90",
	"MP5-SD",
	"UMP-45",
	"XM1014",
	"PP-Bizon",
	"MAG-7",
	"Negev",
	"Sawed-Off",
	"Tec-9",
	"Zeus X29",
	"P2000",
	"MP7",
	"MP9",
	"Nova",
	"P250",
	"Scar-20",
	"SG556",
	"SSG08",
	"CT Knife",
	"Golden Knife",
	"Flashbang",
	"High-Explosive Grenade",
	"Smokegrenade",
	"Molotov",
	"Decoy Grenade",
	"Incendiary",
	"C4",
	"Defuser Kit",
	"T Knife",
	"M4A1-S",
	"USP-S",
	"CZ75-A",
	"R8 Revolver",
	"Tactical-Awareness Grenade",
	"Breach Charge",
	"Spectral Knife",
	"Bayonet",
	"Classic Knife",
	"Flip Knife",
	"Gut Knife",
	"Karambit",
	"M9 Bayonet",
	"Huntsman Knife",
	"Falchion Knife",
	"Bowie Knife",
	"Butterfly Knife",
	"Shadow Daggers Knife",
	"Paracord Knife",
	"Survival Knife",
	"Ursus Knife",
	"Navaja Knife",
	"Nomad Knife",
	"Stiletto Knife",
	"Talon Knife",
	"Skeleton Knife",
	"Broken Fang Gloves",
	"Bloodhound Gloves",
	"Sport Gloves",
	"Driver Gloves",
	"Hand Wraps Gloves",
	"Moto Gloves",
	"Specialist Gloves",
	"Hydra Gloves"
}, CSGO_ItemClassname[][] = {
	"weapon_deagle",
	"weapon_fiveseven",
	"weapon_glock",
	"weapon_ak47",
	"weapon_aug",
	"weapon_awp",
	"weapon_famas",
	"weapon_g3sg1",
	"weapon_galilar",
	"weapon_m249",
	"weapon_m4a1",
	"weapon_mac10",
	"weapon_p90",
	"weapon_mp5sd",
	"weapon_ump45",
	"weapon_xm1014",
	"weapon_bizon",
	"weapon_mag7",
	"weapon_negev",
	"weapon_sawedoff",
	"weapon_tec9",
	"weapon_taser",
	"weapon_hkp2000",
	"weapon_mp7",
	"weapon_mp9",
	"weapon_nova",
	"weapon_p250",
	"weapon_scar20",
	"weapon_sg556",
	"weapon_ssg08",
	"weapon_knife_ct",
	"weapon_knifegg",
	"weapon_flashbang",
	"weapon_hegrenade",
	"weapon_smokegrenade",
	"weapon_molotov",
	"weapon_decoy",
	"weapon_incendiary",
	"weapon_c4",
	"item_defuser_kit",
	"weapon_knife_t",
	"weapon_m4a1_silencer",
	"weapon_usp_silencer",
	"weapon_cz75a",
	"weapon_revolver",
	"weapon_tagrenade",
	"weapon_breach_charge",
	"weapon_knife_ghost",
	"weapon_bayonet",
	"weapon_knife_css",
	"weapon_knife_flip",
	"weapon_knife_gut",
	"weapon_knife_karambit",
	"weapon_knife_m9_bayonet",
	"weapon_knife_tactical",
	"weapon_knife_falchion",
	"weapon_knife_survival_bowie",
	"weapon_knife_butterfly",
	"weapon_knife_push",
	"weapon_knife_cord",
	"weapon_knife_canis",
	"weapon_knife_ursus",
	"weapon_knife_gypsy_jackknife",
	"weapon_knife_outdoor",
	"weapon_knife_stiletto",
	"weapon_knife_widowmaker",
	"weapon_knife_skeleton",
	"wearable_item",
	"wearable_item",
	"wearable_item",
	"wearable_item",
	"wearable_item",
	"wearable_item",
	"wearable_item",
	"wearable_item"
};
const int MaxCSGOItems = sizeof(CSGO_Item);

/**
 *	Fixes the StatTrak and Skins function not working.
 *
 *	@param entity	Entity index.
 *
 *	@return	Returns false on failure, true otherwise.
 */
stock bool CSGO_FixId(any entity) {
	if(!IsValidEntityEx(entity))
		return false;
	
	//Fixes skin not appearing.
	static int IDHigh = 16384;
	return (SetEntPropEx(entity, Prop_Send, "m_iItemIDHigh", IDHigh++) && SetEntPropEx(entity, Prop_Send, "m_iItemIDLow", -1));
}

/**
 *	Set the skin.
 *
 *	@param	entity	Entity index.
 *	@param	index	The skin index.
 *
 *	@return	If the entity is invalid, this returns false.
 */
stock bool CSGO_SetSkin(any entity, int index) { return SetEntPropEx(entity, Prop_Send, "m_nFallbackPaintKit", index); }

/**
 *	Returns the skin.
 *
 *	@param entity	Entity index.
 *	@param index	The Skin index.
 *
 *	@error	If the entity or painkit is invalid, this returns -1.
 */
stock int CSGO_GetSkin(any entity) { return GetEntPropEx(entity, Prop_Send, "m_nFallbackPaintKit"); }

/**
 *	Set the weapon's pattern/seed.
 *
 *	@param	entity	Entity index.
 *	@param	pattern	The pattern to set.
 *
 *	@error	If the entity is invalid or procedure failed, this returns false.
 */
stock bool CSGO_SetPattern(any entity, int pattern) { return SetEntPropEx(entity, Prop_Send, "m_nFallbackSeed", pattern); }

/**
 *	Returns the weapon's pattern/seed.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity is invalid or procedure failed, this returns false.
 */
stock int CSGO_GetPattern(any entity) { return GetEntPropEx(entity, Prop_Send, "m_nFallbackSeed"); }

/**
 *	Set the StatTrak.
 *
 *	@param	entity	Entity index.
 *	@param	value	The 'kill' track amount. If -1 (by default), will be disabled.
 *
 *	@return	Returns false on failure, true otherwise.
 *
 *	@error	If the entity is invalid or procedure failed, this returns false.
 */
stock bool CSGO_SetStatTrak(any entity, int value=-1) { return SetEntPropEx(entity, Prop_Send, "m_nFallbackStatTrak", value); }

/**
 *	Returns the StatTrak.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If entity or stattrak module is invalid, it will return -1.
 */
stock int CSGO_GetStatTrak(any entity) { return GetEntPropEx(entity, Prop_Send, "m_nFallbackStatTrak"); }

/**
 *	Set the weapon owner.
 *
 *	@param	entity	Entity index.
 *	@param	client	Users index.
 *
 *	@return	Returns false on failure, true otherwise.
 */
stock bool CSGO_SetOwner(any entity, int client) {
	SetEntPropEx(entity, Prop_Send, "m_iAccountID", GetSteamAccountID(client));
	SetEntPropEntEx(entity, Prop_Send, "m_hOwnerEntity", client);
	SetEntPropEnt(entity, Prop_Send, "m_hPrevOwner", -1);
	return true;
}

/**
 *	Set the weapon quality.
 *
 *	@param	entity	Entity index.
 *	@param	index	Quality index value. By default set to 3, adding a star to the weapon name.
 *
 *	@error	If the entity is invalid or procedure failed, this returns false.
 */
stock bool CSGO_SetQuality(any entity, int index=3) { return SetEntPropEx(entity, Prop_Send, "m_iEntityQuality", index); }

/**
 *	Retrieves the weapon quality.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity is invalid or procedure failed, this returns -1.
 */
stock int CSGO_GetQuality(any entity) { return SetEntPropEx(entity, Prop_Send, "m_iEntityQuality", index); }

/**
 *	Set the name tag
 *
 *	@param	entity	Entity index.
 *	@param	nametag	A name tag or string of characters you specify.
 *	@param	maxlen	Max character length for the string buffer.
 *
 *	@return	Returns false on failure, true otherwise.
 */
stock bool CSGO_SetNameTag(any entity, const char[] nametag) {
	if(!IsValidEntityEx(entity)) return false;
	
	char netclass[32];
	GetEntityNetClass(entity, netclass, sizeof(netclass));
	SetEntDataString(entity, FindSendPropInfo(netclass, "m_szCustomName"), nametag, strlen(nametag)+1);
	return true;
}

/**
 *	Returns the nametag
 *
 *	@param	entity	Entity index.
 *	@param	buffer	The source to store at.
 *	@param	maxlen	Length of the buffer.
 *
 *	@return	Returns false on failure, true otherwise.
 */
stock bool CSGO_GetNameTag(any entity, char[] buffer, int maxlen) {
	if(!IsValidEntityEx(entity)) return false;
	
	char netclass[32];
	GetEntityNetClass(entity, netclass, sizeof(netclass));
	GetEntDataString(entity, FindSendPropInfo(netclass, "m_szCustomName"), buffer, maxlen);
	return true;
}

/**
 *	Set the wear.
 *
 *	@param	entity	Entity index.
 *	@param	wear	The wear float value.
 *
 *	@error	If the entity is invalid or procedure failed, this returns false.
 */
stock bool CSGO_SetWear(any entity, float wear) { return SetEntPropFloatEx(entity, Prop_Send, "m_flFallbackWear", wear); }

/**
 *	Returns the wear.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity is invalid or procedure failed, this returns false.
 */
stock float CSGO_GetWear(any entity) { return GetEntPropFloatEx(entity, Prop_Send, "m_flFallbackWear"); }

/**
 *	Returns the competitive ranking offset. [CS:GO]
 */
stock int CSGO_GetCompetitive() { return FindSendPropInfo("CCSPlayerResource", "m_iCompetitiveRanking"); }

/**
 *	Set the matchmaking rank. [CS:GO]
 *
 *	@param	player_ent			The GetPlayerResource() entity. (OnThinkPost)
 *	@param	client				The users index.
 *	@param	competitive_offset	The competitive ranking offset.
 *	@param	rank				The CSGORank rank.
 *	@param	ranktype			The CSGORankType rank type.
 *
 *	@noreturn
 */
stock void CSGO_SetMatchmakingRank(int player_ent, int client, CSGORank rank, CSGORankType ranktype) { SetEntData(player_ent, FindSendPropInfo("CCSPlayerResource", "m_iCompetitiveRanking") + client*4, view_as<int>(rank) + view_as<int>(ranktype)); }

/**
 *	Set the users arms model.
 *
 *	@param	client	The users index.
 *	@param	arms	The Arm model path.
 *
 *	@return	Returns number of non-null bytes written.
 */
stock int CSGO_SetClientArmModel(int client, const char[] arms) { return SetEntPropStringEx(client, Prop_Send, "m_szArmsModel", arms); }

/**
 *	Return the users arms model.
 *
 *	@param	client	The users index.
 *	@param	model	The Arm model path.
 *	@param	maxlen	The maximum length of the arm model.
 *
 *	@return	Returns number of non-null bytes written.
 */
stock int CSGO_GetClientArmModel(int client, char[] buffer, int maxlen) { return GetEntPropStringEx(client, Prop_Send, "m_szArmsModel", buffer, maxlen); }

/**
 *	Returns the item definition index by its entity classname.
 *
 *	@param	clsname	The item entity classname.
 *
 *	@returns	CSGO_* enum (integer). -1 if invalid item classname.
 */
stock int CSGO_GetItemDefindex(const char[] clsname) { for(int i = 0; i < MaxCSGOItems; i++) if(StrEqual(clsname, CSGO_ItemClassname[i], false)) return CSGO_Item[i]; return -1; }

/**
 *	Returns the item name by its entity classname.
 *
 *	@param	clsname	The item entity classname.
 *	@param	name	The weapon's name.
 *	@param	maxlen	The maximum length of the name.
 *
 *	@return	Number of non-null bytes written.
 */
stock int CSGO_GetItemName(const char[] clsname, char[] name, int maxlen) { for(int i = 0; i < MaxCSGOItemDefinition; i++) if(StrEqual(clsname, CSGO_ItemClassname[i], false)) return strcopy(name, maxlen, CSGO_ItemsName[i]); return 0; }

/**
 *	Returns the item name by its definition index.
 *
 *	@param	defindex	The weapon definition index.
 *	@param	name		The weapon's name.
 *	@param	maxlen		The maximum length of the name.
 *
 *	@return	Number of non-null bytes written.
 */
stock int CSGO_GetItemNameDefindex(int defindex, char[] name, int maxlen) { for(int i = 0; i < MaxCSGOItems; i++) if(CSGO_Item[i] == defindex) return strcopy(name, maxlen, CSGO_ItemName[i]); return 0;}

/**
 *	Returns the classname by its definition index.
 *
 *	@param	defindex	The weapon definition index.
 *	@param	name		The weapon's name.
 *	@param	maxlen		The maximum length of the name.
 *
 *	@noreturn
 */
stock int CSGO_GetItemClassnameDefindex(int defindex, char[] name, int maxlen) { for(int i = 0; i < MaxCSGOItems; i++) if(CSGO_Item[i] == defindex) return strcopy(name, maxlen, CSGO_ItemName[i]); return 0; }

/**
 *	Returns the weapon by its definition index.
 *
 *	@param	client		The users index.
 *	@param	defindex	The weapon definition index.
 *
 *	@error	If entity wasn't found or user is invalid, this returns -1.
 */
stock int CSGO_FindWeaponByDefindex(int client, int defindex) {
	if(!Tklib_IsValidClient(client, _, true)) return -1;
	
	int wep = 0, owner = 0;
	
	char clsname[64];
	CSGO_GetClassnameDefindex(defindex, clsname, sizeof(clsname));
	
	while((wep = FindEntityByClassname(wep, clsname)) != -1) if((owner = GetEntityOwner(wep)) > 0 && owner == client) return wep;
	return -1;
}

/*
 *	Sends a win-round event panel with html code support.
 *	If string parameter is left empty (by default), event is fired but panel will be removed
 *	from the users perspective. Useful if sending text or for just removing panel.
 *
 *	@param	client	The users index.
 *	@param	str		The string to pass through.
 *
 *	@error	If invalid use or event, this returns false.
 */
stock bool CSGO_WinPanelText(int client, const char[] str="") {
	if(!Tklib_IsValidClient(client, true)) return false;
	
	Event event = null;
	if((event = new Event("cs_win_panel_round")) != null) {
		event.SetString("funfact_token", str);
		event.FireToClient(client);
		event.Cancel();
		return true;
	}
	
	return false;
}

/**
 *	Returns if the definition index is valid.
 *
 *	@param	defindex	The item definition index.
 */
stock bool CSGO_IsValidItemDefinitionIndex(int defindex) { for(int i = 0; i < MaxCSGOItems; i++) if(CSGO_Item[i] == defindex) return true; return false; }

/**
 *	Returns if the item definition index is a knife.
 *
 *	@param	defindex	The item definition index.
 */
stock bool CSGO_IsItemIndexKnife(int defindex) { for(int i = 0; i < MaxCSGOItems; i++) if(StrEqual(CSGO_ItemClassname[i], "weapon_bayonet", false) || StrContainsEx(CSGO_ItemClassname[i], "weapon_knife", false)) return true; return false; }

/**
 *	Returns the condition name by the float.
 *
 *	@param	wear	The wear float.
 *	@param	str		String buffer to store the condition name.
 *	@param	maxlen	The maximum length of the string buffer.
 *
 *	@noreturn
 */
stock void CSGO_GetSkinCondition(float wear, char[] str, int maxlen) {
	if(wear < 0.07) strcopy(str, maxlen, "Factory New");
	else if(wear >= 0.07 && wear < 0.15) strcopy(str, maxlen, "Minimal Wear");
	else if(wear >= 0.15 && wear < 0.38) strcopy(str, maxlen, "Field Tested");
	else if(wear >= 0.38 && wear < 0.45) strcopy(str, maxlen, "Well Worn");
	else if(wear >= 0.45 && wear < 1.00) strcopy(str, maxlen, "Battle Scarred");
	else if(wear >= 0.99) strcopy(str, maxlen, "Worst Battle Scarred");
}
#endif