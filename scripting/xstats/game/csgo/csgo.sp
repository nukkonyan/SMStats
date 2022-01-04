/**
 *	Functions.
 */

/**
 *	Initializes includes for this game.
 */
#include	"xstats/game/csgo/database.sp"
#include	"xstats/game/csgo/forwards.sp"

/**
 *	Initialize: Counter-Strike Global Offensive.
 */
void PrepareGame_CSGO()	{
	//Weapon cvars
	Weapon[CSGO_Weapon_Deagle]		= CreateConVar("xstats_weapon_deagle",	"5", "xStats: CSGO - Points given when killing with Deagle.", _, true, 0.0);
	Weapon[CSGO_Weapon_Glock]		= CreateConVar("xstats_weapon_glock",	"5", "xStats: CSGO - Points given when killing with Glock.", _, true, 0.0);
	Weapon[CSGO_Weapon_Ak47]		= CreateConVar("xstats_weapon_ak47",	"5", "xStats: CSGO - Points given when killing with Ak47.", _, true, 0.0);
	Weapon[CSGO_Weapon_Aug]			= CreateConVar("xstats_weapon_aug",		"5", "xStats: CSGO - Points given when killing with Aug.", _, true, 0.0);
	Weapon[CSGO_Weapon_AWP]			= CreateConVar("xstats_weapon_awp",		"5", "xStats: CSGO - Points given when killing with Awp.", _,true, 0.0);
	Weapon[CSGO_Weapon_Famas]		= CreateConVar("xstats_weapon_famas",	"5", "xStats: CSGO - Points given when killing with Famas.", _, true, 0.0);
	Weapon[CSGO_Weapon_G3SG1]		= CreateConVar("xstats_weapon_g3sg1",	"5", "xStats: CSGO - Points given when killing with G3sg1.", _, true, 0.0);
	Weapon[CSGO_Weapon_GalilAR]		= CreateConVar("xstats_weapon_galilar",	"5", "xStats: CSGO - Points given when killing with Galilar.", _, true, 0.0);
	Weapon[CSGO_Weapon_M249]		= CreateConVar("xstats_weapon_m249",	"5", "xStats: CSGO - Points given when killing with M249.", _, true, 0.0);
	Weapon[CSGO_Weapon_M4A4]		= CreateConVar("xstats_weapon_m4a4",	"5", "xStats: CSGO - Points given when killing with M4a4.", _, true, 0.0);
	Weapon[CSGO_Weapon_Mac10]		= CreateConVar("xstats_weapon_mac10",	"5", "xStats: CSGO - Points given when killing with Mac10.", _, true, 0.0);
	Weapon[CSGO_Weapon_P90]			= CreateConVar("xstats_weapon_p90",		"5", "xStats: CSGO - Points given when killing with P90.", _, true, 0.0);
	Weapon[CSGO_Weapon_MP5]			= CreateConVar("xstats_weapon_mp5",		"5", "xStats: CSGO - Points given when killing with MP5.", _, true, 0.0);
	Weapon[CSGO_Weapon_UMP45]		= CreateConVar("xstats_weapon_ump45",	"5", "xStats: CSGO - Points given when killing with UMP45.", _, true, 0.0);
	Weapon[CSGO_Weapon_XM1014]		= CreateConVar("xstats_weapon_xm1014",	"5", "xStats: CSGO - Points given when killing with XM1014.", _, true, 0.0);
	Weapon[CSGO_Weapon_Bizon]		= CreateConVar("xstats_weapon_bizon",	"5", "xStats: CSGO - Points given when killing with Bizon.", _, true, 0.0);
	Weapon[CSGO_Weapon_MAG7]		= CreateConVar("xstats_weapon_mag7",	"5", "xStats: CSGO - Points given when killing with MAG-7", _, true, 0.0);
	Weapon[CSGO_Weapon_Negev]		= CreateConVar("xstats_weapon_negev",	"5", "xStats: CSGO - Points given when killing with Negev.", _, true, 0.0);
	Weapon[CSGO_Weapon_SawedOff]	= CreateConVar("xstats_weapon_sawedoff","5", "xStats: CSGO - Points given when killing with Sawed-Off.", _, true, 0.0);
	Weapon[CSGO_Weapon_Tec9]		= CreateConVar("xstats_weapon_tec9",	"5", "xStats: CSGO - Points given when killing with Tec9.", _, true, 0.0);
	Weapon[CSGO_Weapon_Taser]		= CreateConVar("xstats_weapon_taser",	"5", "xStats: CSGO - Points given when killing with Taser.", _, true, 0.0);
	Weapon[CSGO_Weapon_P2000]		= CreateConVar("xstats_weapon_hkp2000",	"5", "xStats: CSGO - Points given when killing with P2000.", _, true, 0.0);
	Weapon[CSGO_Weapon_MP7]			= CreateConVar("xstats_weapon_mp7",		"5", "xStats: CSGO - Points given when killing with MP7.", _, true, 0.0);
	Weapon[CSGO_Weapon_MP9]			= CreateConVar("xstats_weapon_mp9",		"5", "xStats: CSGO - Points given when killing with MP9.", _, true, 0.0);
	Weapon[CSGO_Weapon_Nova]		= CreateConVar("xstats_weapon_nova",	"5", "xStats: CSGO - Points given when killing with Nova.", _, true, 0.0);
	Weapon[CSGO_Weapon_P250]		= CreateConVar("xstats_weapon_p250",	"5", "xStats: CSGO - Points given when killing with P250.", _, true, 0.0);
	Weapon[CSGO_Weapon_Scar20]		= CreateConVar("xstats_weapon_scar20",	"5", "xStats: CSGO - Points given when killing with Scar-20.", _, true, 0.0);
	Weapon[CSGO_Weapon_SG556]		= CreateConVar("xstats_weapon_sg556",	"5", "xStats: CSGO - Points given when killing with SG556.", _, true, 0.0);
	Weapon[CSGO_Weapon_SSG08]		= CreateConVar("xstats_weapon_ssg08",	"5", "xStats: CSGO - Points given when killing with Scout.", _, true, 0.0);
	Weapon[CSGO_Knife_CT]			= CreateConVar("xstats_weapon_knife",	"5", "xStats: CSGO - Points given when killing with Knife.", _, true, 0.0);
	Weapon[CSGO_Knife_Gold]			= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_T]			= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Weapon_M4A1_S]		= CreateConVar("xstats_weapon_m4a1_silencer",	"5", "xStats: CSGO - Points given when killing with M4A1-S.", _, true, 0.0);
	Weapon[CSGO_Weapon_USP_S]		= CreateConVar("xstats_weapon_usp_silencer",	"5", "xStats: CSGO - Points given when killing with USP-S", _, true, 0.0);
	Weapon[CSGO_Weapon_CZ75_A]		= CreateConVar("xstats_weapon_cz75a",	"5", "xStats: CSGO - Points given when killing with CZ75-A", _, true, 0.0);
	Weapon[CSGO_Weapon_Revolver]	= CreateConVar("xstats_weapon_revolver",		"5", "xStats: CSGO - Points given when killing with Revolver.", _, true, 0.0);
	Weapon[CSGO_Knife_Ghost]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Bayonet]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Classic]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Flip]			= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Gut]			= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Karambit]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_M9_Bayonet]	= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Huntsman]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Falchion]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Bowie]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Butterfly]	= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_ButtPlugs]	= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Paracord]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Survival]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Ursus]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Navaja]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Nomad]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Stiletto]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Talon]		= Weapon[CSGO_Knife_CT];
	Weapon[CSGO_Knife_Skeleton]		= Weapon[CSGO_Knife_CT];
	
	AutoExecConfig(false, "xstats.csgo.cfg");
}