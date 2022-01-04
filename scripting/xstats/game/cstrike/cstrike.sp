/**
 *	Functions.
 */

/**
 *	Initializes includes for this game.
 */
#include	"xstats/game/cstrike/database.sp"
#include	"xstats/game/cstrike/forwards.sp"

/**
 *	Initialize: Counter-Strike Source.
 */
void PrepareGame_CSS()
{
	//Weapon cvars
	Weapon[CSS_Weapon_Deagle]	= CreateConVar("xstats_weapon_deagle",	"5", "xStats: CSS - Points given when killing with Deagle.", _, true, 0.0);
	Weapon[CSS_Weapon_Glock]	= CreateConVar("xstats_weapon_glock",	"5", "xStats: CSS - Points given when killing with Glock.", _, true, 0.0);
	Weapon[CSS_Weapon_Ak47]		= CreateConVar("xstats_weapon_ak47",	"5", "xStats: CSS - Points given when killing with Ak47.", _, true, 0.0);
	Weapon[CSS_Weapon_Aug]		= CreateConVar("xstats_weapon_aug",		"5", "xStats: CSS - Points given when killing with Aug.", _, true, 0.0);
	Weapon[CSS_Weapon_AWP]		= CreateConVar("xstats_weapon_awp",		"5", "xStats: CSS - Points given when killing with Awp.", _,true, 0.0);
	Weapon[CSS_Weapon_Famas]	= CreateConVar("xstats_weapon_famas",	"5", "xStats: CSS - Points given when killing with Famas.", _, true, 0.0);
	Weapon[CSS_Weapon_G3SG1]	= CreateConVar("xstats_weapon_g3sg1",	"5", "xStats: CSS - Points given when killing with G3SG1.", _, true, 0.0);
	Weapon[CSS_Weapon_Galil]	= CreateConVar("xstats_weapon_galil",	"5", "xStats: CSS - Points given when killing with Galil.", _, true, 0.0);
	Weapon[CSS_Weapon_M249]		= CreateConVar("xstats_weapon_m249",	"5", "xStats: CSS - Points given when killing with M249.", _, true, 0.0);
	Weapon[CSS_Weapon_M4A1]		= CreateConVar("xstats_weapon_m4a1",	"5", "xStats: CSS - Points given when killing with M4a1.", _, true, 0.0);
	Weapon[CSS_Weapon_Mac10]	= CreateConVar("xstats_weapon_mac10",	"5", "xStats: CSS - Points given when killing with Mac10.", _, true, 0.0);
	Weapon[CSS_Weapon_P90]		= CreateConVar("xstats_weapon_p90",		"5", "xStats: CSS - Points given when killing with P90.", _, true, 0.0);
	Weapon[CSS_Weapon_MP5]		= CreateConVar("xstats_weapon_mp5",		"5", "xStats: CSS - Points given when killing with MP5.", _, true, 0.0);
	Weapon[CSS_Weapon_UMP45]	= CreateConVar("xstats_weapon_ump45",	"5", "xStats: CSS - Points given when killing with UMP45.", _, true, 0.0);
	Weapon[CSS_Weapon_XM1014]	= CreateConVar("xstats_weapon_xm1014",	"5", "xStats: CSS - Points given when killing with XM1014.", _, true, 0.0);
	Weapon[CSS_Weapon_M3]		= CreateConVar("xstats_weapon_m3",		"5", "xStats: CSS - Points given when killing with M3.", _, true, 0.0);
	Weapon[CSS_Weapon_USP]		= CreateConVar("xstats_weapon_usp",		"5", "xStats: CSS - Points given when killing with P2000.", _, true, 0.0);
	Weapon[CSS_Weapon_P228]		= CreateConVar("xstats_weapon_p250",	"5", "xStats: CSS - Points given when killing with P250.", _, true, 0.0);
	Weapon[CSS_Weapon_SG550]	= CreateConVar("xstats_weapon_sg550",	"5", "xStats: CSS - Points given when killing with SG550.", _, true, 0.0);
	Weapon[CSS_Weapon_SG552]	= CreateConVar("xstats_weapon_sg552",	"5", "xStats: CSS - Points given when killing with SG552.", _, true, 0.0);
	Weapon[CSS_Weapon_Scout]	= CreateConVar("xstats_weapon_scout",	"5", "xStats: CSS - Points given when killing with Scout.", _, true, 0.0);
}