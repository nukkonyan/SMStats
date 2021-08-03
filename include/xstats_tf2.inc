#if defined Xstats_TF2_Included
	#endinput
#endif

#define	Xstats_TF2_Included

#if defined Xstats_TF2_Included
	#define Xstats_playerstats_tf2		"tf2_playerstats"
	#define Xstats_itemfound_tf2		"tf2_itemfound"
	#define	Xstats_achievements_tf2		"tf2_achievements"
#endif

stock char Xstats_TF2_TeamName[][]	=	{
	"{grey}Unassigned{default}",
	"{grey}Spectators{default}",
	"{red}RED{default}",
	"{blue}BLU{default}",
};	

enum	Xstats_TF2_GameMode	{
	TF2_GameMode_Unknown	=	0,
	TF2_GameMode_Arena		=	1,
	TF2_GameMode_KOTH		=	2,
	TF2_GameMode_CP			=	3,
	TF2_GameMode_CTF		=	4,
	TF2_GameMode_PL			=	5,
	TF2_GameMode_PLR		=	6,
	TF2_GameMode_MvM		=	7,
	TF2_GameMode_RD			=	8,
	TF2_GameMode_Trade		=	9,
	TF2_GameMode_DR			=	10,
	TF2_GameMode_DeathRun	=	10
}

//=============================================//

/**
 *	Get the current game mode active.
 */
stock Xstats_TF2_GameMode Xstats_TF2_GetGameMode()	{
	char mapname[96];
	GetCurrentMap(mapname, sizeof(mapname));
	
	if(StrContainsEx(mapname, "arena_", false))
		return	TF2_GameMode_Arena;
	else if(StrContainsEx(mapname, "koth_", false))
		return	TF2_GameMode_KOTH;
	else if(StrContainsEx(mapname, "cp_", false))
		return	TF2_GameMode_CP;
	else if(StrContainsEx(mapname, "ctf_", false))
		return	TF2_GameMode_CTF;
	else if(StrContainsEx(mapname, "pl_", false))
		return	TF2_GameMode_PL;
	else if(StrContainsEx(mapname, "plr", false))
		return	TF2_GameMode_PLR;
	else if(StrContainsEx(mapname, "mvm_", false))
		return	TF2_GameMode_MvM;
	else if(StrContains(mapname, "rd_", false))
		return	TF2_GameMode_RD;
	else if(StrContains(mapname, "trade_", false))
		return	TF2_GameMode_Trade;
	else if(StrContains(mapname, "dr_", false))
		return	TF2_GameMode_DR;
	
	return	TF2_GameMode_Unknown;
}

/**
 *	Called upon player kill event.
 *
 *	@param		client		The Players client index.
 *	@param		victim		The Victims client index.
 *	@param		assister	The Assisters client index (if invalid, 0 is used).
 *	@param		customkill	The Customkill index.
 *	@param		deathflags	The Deathflags index.
 *	@param		defindex	The Definition index of the weapon the player used.
 *	@param		weaponid	The Weaponid of the weapon used.
 *	@param		classname	The classname of the weapon the player used.
 *	@param		crittype	The TFCritType of kill, non-crit, mini-crit or full-crit.
 *	@param		rocketjump	Was the victim rocket jumping?.
 *	@param		headshot	Was the kill event a headshot?.
 *	@param		noscope		Was the kill event a noscope?.
 *	@param		backstab	Was the kill event a backstab?.
 *	@param		suicide		Was the kill event a suicide?.
 *	@param		tauntkill	Was the kill event a tauntkill?.
 *	@param		domination	Was the kill event a domination?.
 *	@param		revenge		Was the kill event a revenge?.
 *	@param		gibkill		Was the kill event a gibkill?.
 *	@param		silentkill	Was the kill event a silent kill?.
 *	@param		fakedeath	Was the kill event a faked death?.
 *	@param		bleedkill	Was the kill event a bleed-to-death kill?.
 *	@param		deflectkill	Was the kill event a deflect kill?.
 *	@noreturn
 */
forward void Xstats_TF2_OnPlayerDeath(int client,
										int victim,
										int assister,
										int customkill,
										int deathflags,
										int defindex,
										int weaponid,
										char[] classname,
										TFCritType crittype,
										bool rocketjump,
										bool headshot,
										bool noscope,
										bool backstab,
										bool suicide,
										bool tauntkill,
										bool domination,
										bool revenge,
										bool gibkill,
										bool silentkill,
										bool fakedeath,
										bool bleedkill,
										bool deflectkill);

/**
 *	Called upon flag event. (flag captured, taken, dropped, etc)
 *
 *	@param		client		The Players client index.
 *	@param		carrier		The carrier index.
 *	@param		eventtype	The Event type index.
 *	@param		home		Returns true/false if the flag event was taken at base.
 *	@param		team		The TFTeam index.
 *	@noreturn
 */
forward void Xstats_TF2_CTF_Event(int client, int carrier, int eventtype, bool home, TFTeam team);

/**
 *	Called upon opponent blocking capturing event.
 *
 *	@param		client		The Blockers client index.
 *	@param		victim		The Victims client index.
 *	@param		cpname		The Capture point name.
 *	@noreturn
 */
forward void Xstats_TF2_CP_OnPlayerCaptureBlocked(int client, int victim, char[] cpname);

/**
 *	Called when a capture point was captured.
 *
 *	@param		team		The TFTeam who captured the point.
 *	@param		cpname		The Name of the captured point.
 *	@param		cappers		The String of players who captured the point.
 */
forward void Xstats_TF2_CP_OnPlayerCaptured(TFTeam team, char[] cpname, const char[] cappers);

/**
 *	Called when the bomb carrier was killed by a player.
 *
 *	@param		client		The Players client index.
 */
forward void Xstats_TF2_MvM_OnBombDefended(int client);

/**
 *	Called when someone finds an item.
 *
 *	@param		client			The Players client index.
 *	@param		defindex		The Items definition index.
 *	@param		qualityindex	The Items quality index.
 *	@param		quality			The Items quality string name.
 *	@param		methodindex		The Items method index.
 *	@param		method			The Items method string name.
 *	@noreturn
*/
forward void Xstats_TF2_ItemFound(int client, int defindex, int qualityindex, char[] quality, int methodindex, char[] method);

/**
 *	Called when a medic übercharges their teammate/enemy spy.
 *
 *	@param		client		The Medic who übercharged.
 *	@param		victim		The Player who the medic übercharged.
 *	@param		defindex	The Definition index of the med igun the medic used to übercharge.
 *	@noreturn
 */
forward void Xstats_TF2_OnPlayerUbercharged(int client, int victim, int defindex);

/**
 *	Called when a sandvich gets stolen.
 *
 *	@param		client		The Player who stole the sandvich.
 *	@param		victim		The Sandvich's owner.
 */
forward void Xstats_TF2_OnSandvichStolen(int client, int victim);

/**
 *	Called when someone pulls a headshot.
 *
 *	@param		client		The Players client index.
 *	@param		victim		The Victims client index.
 *	@param		assister	The Assisters client index (if invalid, 0 is used).
 *	@param		defindex	The definition index of the weapon the player used.
 *	@noreturn
 */
forward void Xstats_TF2_OnPlayerHeadshot(int client, int victim, int assister, int defindex);

/**
 *	Called when someone pulls a backstab.
 *
 *	@param		client		The Players client index.
 *	@param		victim		The Victims client index.
 *	@param		assister	The Assisters client index.
 *	@param		defindex	The definition index of the weapon the player used.
 *	@noreturn
 */
forward void Xstats_TF2_OnPlayerBackstab(int client, int victim, int assister, int defindex);

/**
 *	Called when someone pulls a tauntkill.
 *	@param		client		The Players client index.
 *	@param		victim		The Victims client index.
 *	@param		assister	The Assisters client index.
 *	@noreturn
 */
forward void Xstats_TF2_OnPlayerTauntKill(int client, int victim, int assister, int defindex);

/**
 *	Called when someone throws a jar on someone.
 *
 *	@param		client		The Players client index.
 *	@param		victim		The Victims client index.
 *	@param		defindex	The definition index of the jar the player used.
 *	@noreturn
 */
forward void Xstats_TF2_OnPlayerJarated(int client, int victim, int defindex);

/**
 *	Called when someone extinguishes their teammate.
 *
 *	@param		client		The Players client index.
 *	@param		victim		The Victims client index.
 *	@param		defindex	The definition index of the weapon the player used to extinguish.
 *	@noreturn
 */
forward void Xstats_TF2_OnPlayerExtinguished(int client, int victim, int defindex);

/**
 *	Called when a building was destroyed by someone.
 *
 *	@param		owner		The Building owners client index.
 *	@param		client		The Building destroyers client index.
 *	@param		assister	The Assister client index.
 *	@param		defindex	The Weapon definition index used to destroy the building.
 *	@param		building	The TFBuilding.
 *	@param		beingbuilt	Returns true or false if the building was being built in the process.
 *	@noreturn
 */
forward void Xstats_TF2_OnBuildingDestroyed(int owner, int client, int assister, int defindex, TFBuilding building, bool beingbuilt);

/**
 *	Called when a building is built.
 *
 *	@param		client		The building owner client index who built the building.
 *	@param		building	The TFBuilding.
 *	@noreturn
 */
forward void Xstats_TF2_OnBuildingBuilt(int client, TFBuilding building);

public	SharedPlugin	__pl_Xstats_TF2	=	{
	name	=	"Xstats: Team Fortress 2",
	file	=	"xstats_tf2.smx",
#if defined REQUIRE_PLUGIN
	required	=	1,
#else
	required	=	0,
#endif
};

#if !defined REQUIRE_PLUGIN
	public void __pl_Xstats_SetNTVOptional()	{
		MarkNativeAsOptional("Xstats_GetDatabaseConnection");
		MarkNativeAsOptional("Xstats.GetDatabaseConnection");
	}
#endif