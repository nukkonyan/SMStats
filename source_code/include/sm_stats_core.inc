#define StatsSize 112
bool DEBUG = false;

enum struct SMStats_StatsInfo
{
	/* core */
	int PlayTime;
	int Points;
	int Frags;
	int Deaths;
	int Suicides;
	int Assists;
	int DamageDone;
	
	int Achievements;
	
	/* add & remove session points. just to make it easier :) */
	void AddPoints(int value) { this.Points += value; }
	void RemovePoints(int value) { this.Points -= value; }
	
	/* generic */
	int Dominations;
	int Revenges;
	int Airshots;
	int Headshots;
	int Noscopes;
	int Collaterals;
	int MidAirFrags;
	int GrenadeFrags;
	
	/* TF2 */
	int ScoutFrags;
	int SoldierFrags;
	int PyroFrags;
	int DemoFrags;
	int HeavyFrags;
	int EngieFrags;
	int MedicFrags;
	int SniperFrags;
	int SpyFrags;
	int CivilianFrags; /* TF2 Classic */
	
	int ScoutDeaths;
	int SoldierDeaths;
	int PyroDeaths;
	int DemoDeaths;
	int HeavyDeaths;
	int EngieDeaths;
	int MedicDeaths;
	int SniperDeaths;
	int SpyDeaths;
	int CivilianDeaths; /* TF2 Classic */
	
	int Backstabs;
	int TauntFrags;
	int GibFrags;
	int Deflects;
	int Ubercharged;
	int SandvichesStolen;
	int Coated;
	int Extinguished;
	int TeleFrags;
	
	int SentryFrags;
	int MiniSentryFrags;
	int SentryLVL1Frags;
	int SentryLVL2Frags;
	int SentryLVL3Frags;
	
	int MiniCritFrags;
	int CritFrags;
	
	int PointsCaptured;
	int PointsDefended;
	
	int FlagsStolen;
	int FlagsPickedUp;
	int FlagsCaptured;
	int FlagsDefended;
	int FlagsDropped;
	
	int PassBallsGotten;
	int PassBallsScored;
	int PassBallsDropped;
	int PassBallsCatched;
	int PassBallsStolen;
	int PassBallsBlocked;
	
	int BuildingsPlaced;
	int SentryGunsPlaced;
	int DispensersPlaced;
	int MiniSentryGunsPlaced;
	int TeleporterEntrancesPlaced;
	int TeleporterExitsPlaced;
	int TeleportersPlaced;
	int SappersPlaced;
	
	int BuildingsDestroyed;
	int SentryGunsDestroyed;
	int DispensersDestroyed;
	int MiniSentryGunsDestroyed;
	int TeleporterEntrancesDestroyed;
	int TeleporterExitsDestroyed;
	int TeleportersDestroyed;
	int SappersDestroyed;
	
	int Teleported;
	int PlayersTeleported;
	
	int StunnedPlayers;
	int MoonShotStunnedPlayers;
	
	int HHHFragged;
	int MonoculusFragged;
	int MerasmusFragged;
	int SkeletonKingsFragged;
	
	int MonoculusStunned;
	int MerasmusStunned;
	
	int MadMilked;
	int Jarated;
	int Ignited;
	
	/* TF2 MvM */
	int TanksDestroyed;
	int SentryBustersFragged;
	int BombsResetted;
	
	/* CS:GO */
	int BlindedFrags;
	int ThroughSmokeFrags;
	int Wipes;
	int ChickenFrags;
	
	/* counter-strike overall */
	int MVPs;
	int BombsPlanted;
	int BombsDefused;
	int BombsExploded;
	int BombFrags;
	int MoneySpent;
	int FlashedOpponents;
	int KnifeFrags;
	int HostagesRescued;
	int HostagesFragged;
	
	/**
	 * resets the stats.
	 */
	void Reset()
	{
		/* Core */
		this.PlayTime = 0;
		this.Points = 0;
		this.Frags = 0;
		this.Deaths = 0;
		this.Suicides = 0;
		this.Assists = 0;
		this.DamageDone = 0;
		
		/* Generic */
		this.Dominations = 0;
		this.Revenges = 0;
		this.Airshots = 0;
		this.Headshots = 0;
		this.Noscopes = 0;
		this.Collaterals = 0;
		this.MidAirFrags = 0;
		this.GrenadeFrags = 0;
		
		/* TF2 */
		this.ScoutFrags = 0;
		this.SoldierFrags = 0;
		this.PyroFrags = 0;
		this.DemoFrags = 0;
		this.HeavyFrags = 0;
		this.EngieFrags = 0;
		this.MedicFrags = 0;
		this.SniperFrags = 0;
		this.SpyFrags = 0;
		this.CivilianFrags = 0; /* TF2 Classic */
		
		this.ScoutDeaths = 0;
		this.SoldierDeaths = 0;
		this.PyroDeaths = 0;
		this.DemoDeaths = 0;
		this.HeavyDeaths = 0;
		this.EngieDeaths = 0;
		this.MedicDeaths = 0;
		this.SniperDeaths = 0;
		this.SpyDeaths = 0;
		this.CivilianDeaths = 0; /* TF2 Classic */
		
		this.Backstabs = 0;
		this.TauntFrags = 0;
		this.GibFrags = 0;
		this.Deflects = 0;
		this.Ubercharged = 0;
		this.SandvichesStolen = 0;
		this.Coated = 0;
		this.Extinguished = 0;
		this.TeleFrags = 0;
		
		this.SentryFrags = 0;
		this.MiniSentryFrags = 0;
		this.SentryLVL1Frags = 0;
		this.SentryLVL2Frags = 0;
		this.SentryLVL3Frags = 0;
		
		this.MiniCritFrags = 0;
		this.CritFrags = 0;
		
		this.PointsCaptured = 0;
		this.PointsDefended = 0;
		
		this.FlagsStolen = 0;
		this.FlagsPickedUp = 0;
		this.FlagsCaptured = 0;
		this.FlagsDefended = 0;
		this.FlagsDropped = 0;
		
		this.PassBallsGotten = 0;
		this.PassBallsScored = 0;
		this.PassBallsDropped = 0;
		this.PassBallsCatched = 0;
		this.PassBallsStolen = 0;
		this.PassBallsBlocked = 0;
		
		this.BuildingsPlaced = 0;
		this.SentryGunsPlaced = 0;
		this.DispensersPlaced = 0;
		this.MiniSentryGunsPlaced = 0;
		this.TeleporterEntrancesPlaced = 0;
		this.TeleporterExitsPlaced = 0;
		this.TeleportersPlaced = 0;
		this.SappersPlaced = 0;
		
		this.BuildingsDestroyed = 0;
		this.SentryGunsDestroyed = 0;
		this.DispensersDestroyed = 0;
		this.MiniSentryGunsDestroyed = 0;
		this.TeleporterEntrancesDestroyed = 0;
		this.TeleporterExitsDestroyed = 0;
		this.TeleportersDestroyed = 0;
		this.SappersDestroyed = 0;
		
		this.Teleported = 0;
		this.PlayersTeleported = 0;
		
		this.StunnedPlayers = 0;
		this.MoonShotStunnedPlayers = 0;
		
		this.HHHFragged = 0;
		this.MonoculusFragged = 0;
		this.MerasmusFragged = 0;
		this.SkeletonKingsFragged = 0;
		
		this.MonoculusStunned = 0;
		this.MerasmusStunned = 0;
		
		this.MadMilked = 0;
		this.Jarated = 0;
		this.Ignited = 0;
		
		/* TF2 MvM */
		this.TanksDestroyed = 0;
		this.SentryBustersFragged = 0;
		this.BombsResetted = 0;
		
		/* CS:GO */
		this.BlindedFrags = 0;
		this.ThroughSmokeFrags = 0;
		this.Wipes = 0;
		this.ChickenFrags = 0;
		
		/* Counter-Strike Overall */
		this.MVPs = 0;
		this.BombsPlanted = 0;
		this.BombsDefused = 0;
		this.BombsExploded = 0;
		this.BombFrags = 0;
		this.MoneySpent = 0;
		this.FlashedOpponents = 0;
		this.KnifeFrags = 0;
		this.HostagesRescued = 0;
		this.HostagesFragged = 0;
	}
}

enum struct SMStats_FragMsgInfo
{
	bool Domination;
	bool Revenge;
	bool MidAir;
	bool ThroughSmoke;
	bool Headshot;
	bool Noscope;
	bool Backstab;
	bool Airshot;
	bool Deflected;
	bool GibFrag;
	bool TeleFrag;
	bool TauntFrag;
	bool Collateral;
	bool Grenade;
	bool Bomb;
	bool Blinded;
	
	void Reset()
	{
		this.Domination = false;
		this.Revenge = false;
		this.MidAir = false;
		this.ThroughSmoke = false;
		this.Headshot = false;
		this.Noscope = false;
		this.Backstab = false;
		this.Airshot = false;
		this.Deflected = false;
		this.GibFrag = false;
		this.TeleFrag = false;
		this.TauntFrag = false;
		this.Collateral = false;
		this.Grenade = false;
		this.Bomb = false;
		this.Blinded = false;
	}
}

enum struct SMStats_PlayerInfo
{
	int userid;
	char auth[64];
	char name[64];
	char ip[16];
	//bool bAlreadyConnected;
	int points;
	int position;
	int active_page_session;
	int active_page_total;
	
	int session[StatsSize];
	int totalstats[StatsSize];
	SMStats_FragMsgInfo fragmsg;
	
	void Reset()
	{
		this.userid = -1;
		this.auth = "";
		this.name = "";
		//this.bAlreadyConnected = false;
		this.points = -1;
		this.position = -1;
		this.active_page_session = -1;
		this.active_page_total = -1;
		
		for(int type = 0; type < StatsSize; type++)
		{
			this.session[type] = -1;
			this.totalstats[type] = -1;
		}
		this.fragmsg.Reset();
	}
}

stock char str_cmdMenu[][] =
{
	"sm_stats",
	"sm_stat",
	"sm_rank",
	"sm_ranks"
};

//

#define queryId_frag_assister 0
#define queryId_frag_weapon 1
#define queryId_frag_victim_death 2
#define queryId_frag_playerlist 3

stock char g_strTXNqueryId[][] = 
{
	/*0*/"frag event: assister",
	/*1*/"frag event: weapon",
	/*2*/"frag event: victim death",
	/*3*/"frag event: playerlist",
};

//

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active chat tag.
 *
 *	@param	tag		The buffer to store the tag.
 *	@param	maxlen	The maximum length of the tag.
 *	@noreturn
 */
native void _sm_stats_get_chattag(char[] tag, int maxlen);

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active server id.
 */
native int _sm_stats_get_serverid();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active database connection.
 */
native Database _sm_stats_get_sql();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the boolean status of bots being allowed.
 */
native bool _sm_stats_get_allowbots();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active death points.
 */
native int _sm_stats_get_deathpoints();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the boolean status of warmup being allowed.
 */
native bool _sm_stats_get_allowwarmup();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the boolean status of abuse being allowed. (Noclip, etc)
 */
native bool _sm_stats_get_allowabuse();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the boolean status if stats are disabled after win.
 */
native bool _sm_stats_get_disableafterroundend();

/*
 *	SourceMod Stats: Core.
 *	Retrieve the active minimum players required to track statistics.
 */
native int _sm_stats_get_minplayers();

/*
 *	SourceMod Stats: Core.
 *	Call the player death forward.
 */
native void _sm_stats_player_death_fwd(int attacker, int frags, int[] userids, int[] assisters, const char[] classname, int itemdef);

// default important things

#define sql_table_playerlist "playerlist_" ... GameTag
#define sql_table_weapons "weapons_" ... GameTag
#define sql_table_kill_log "kill_log_" ... GameTag
#define sql_table_item_found "item_found_" ... GameTag
#define sql_table_maps_log "maps_log_" ... GameTag
#define sql_table_achievements "achievements_" ... GameTag
#define game_translation "sm_stats_" ... GameTag ... ".phrases"

char g_ChatTag[96];
Database sql = null;
bool bLoaded = false;
bool bStatsActive = false;
bool bRoundActive = false;
bool bWarmupActive = false;
bool bAllowBots = false;
bool bAllowAbuse = false;
int g_ServerID = -1;
int g_TotalTablePlayers = -1;
int g_MinPlayers = -1;

SMStats_PlayerInfo g_Player[MaxPlayers+1];

PrivateForward g_GetPlayerSessionInfoFwd;

public void _sm_stats_core_loaded()
{
	LoadTranslations("sm_stats.phrases");
	LoadTranslations(game_translation);
	LoadTranslations("sm_country_geoip.phrases");
	
	PrintToServer("%s loading..", core_chattag);
	bLoaded = true;
	
	_sm_stats_get_chattag(g_ChatTag, sizeof(g_ChatTag));
	g_ServerID = _sm_stats_get_serverid();
	bAllowBots = _sm_stats_get_allowbots();
	g_MinPlayers = _sm_stats_get_minplayers();
	
	CreateTimer(5.0, Timer_LoadCurrentInGamePlayers);
}

public void _sm_stats_chattag_updated(const char[] tag)
{
	strcopy(g_ChatTag, sizeof(g_ChatTag), tag);
}

public void _sm_stats_serverid_updated(int server_id)
{
	g_ServerID = server_id;
}

public void _sm_stats_allowbots_updated(bool value)
{
	bAllowBots = value;
	
	CheckActivePlayers();
}

public void _sm_stats_minplayers_updated(int value)
{
	g_MinPlayers = value;
	
	CheckActivePlayers();
}

public void _sm_stats_allowabuse_updated(bool value)
{
	bAllowAbuse = value;
}

public void OnPluginStart()
{
	PrepareGame();
	LoadMenus();
	LoadForwardEvents();
}

//

char g_strTableName[][] =
{
	/*0*/sql_table_playerlist
	/*1*/,sql_table_weapons
	/*2*/,sql_table_kill_log
	/*3*/,sql_table_item_found
	/*4*/,sql_table_maps_log
	/*5*/,sql_table_achievements
};

public void _sm_stats_sql_loaded(Database database, bool bOnPluginStart)
{
	sql = database;
	
	PrintToServer("%s Caught database connection.", core_chattag);
	
	if(bOnPluginStart)
	{
		File file;
		char path[96], query[16177], table[128];
		int len;
		
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql_table_playerlist);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				SetFailState("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for statistical tracking.), Did you install it correctly?", sql_table_playerlist);
			}
			
			case true:
			{
				while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))
				{
					ReplaceString(table, sizeof(table), "\n", "");
					ReplaceString(table, sizeof(table), "\r", "");
					ReplaceString(table, sizeof(table), "\t", "");
					
					len += Format(query[len], sizeof(query)-len, table);
				}
				
				sql.Query(DBQuery_InsertTables, query, 0);
				
				query = "";
				len = 0;
			}
		}
		
		BuildPath(Path_SM, path, sizeof(path), "/configs/sm_stats/%s.sm_stats", sql_table_weapons);
		switch(!!(file = OpenFile(path, "r")))
		{
			case false:
			{
				SetFailState("Failed loading database file '/configs/sm_stats/%s.sm_stats' (Required for tracking weapon frags.), Did you install it correctly?", sql_table_weapons);
			}
			
			case true:
			{
				while(!file.EndOfFile() && file.ReadLine(table, sizeof(table)))
				{
					ReplaceString(table, sizeof(table), "\n", "");
					ReplaceString(table, sizeof(table), "\r", "");
					ReplaceString(table, sizeof(table), "\t", "");
					
					len += Format(query[len], sizeof(query)-len, table);
				}
				
				sql.Query(DBQuery_InsertTables, query, 1);
				
				query = "";
				len = 0;
			}
		}
		
		//
		
		int client = 0;
		while((client = FindEntityByClassname(client, "player")) > 0)
		{
			if(!IsValidClient(client))
			{
				continue;
			}
			
			OnClientConnected(client);
		}
	}
}

void DBQuery_InsertTables(Database database, DBResultSet results, const char[] error, int query_id)
{
	if(!results)
	{
		LogError("%s Failed to insert database table '%s'"
		... "\nMake sure the database connection is available or file is correct."
		... "\nError: %s", core_chattag, g_strTableName[query_id], error);
	}
}

stock void CallbackQuery(const char[] query, int unique_query_id, any ...)
{
	int maxlen = strlen(query)+1025;
	char[] format = new char[maxlen];
	VFormat(format, maxlen, query, 3);
	sql.Query(DBQuery_Callback, format, unique_query_id);
}
stock void DBQuery_Callback(Database database, DBResultSet results, const char[] error, int unique_query_id)
{	
	if(!results)
	{
		LogError("\n%s Failed to query id %i"
		... "\nMake sure the database connection is available."
		... "\nError reason below:"
		... "\n%s", core_chattag, unique_query_id, error);
	}
}
stock void TXN_Callback_Failure(Database db, int unique_query_id, int numQueries, const char[] error, int failIndex, any[] queryData)
{
	LogError("\n%s Failed to query id %i"
	... "\nMake sure the database connection is available."
	... "\nError reason below:"
	... "\n%s", core_chattag, unique_query_id, error);
}

//

Action Timer_LoadCurrentInGamePlayers(Handle timer)
{
	// plugin may have just reloaded.
	
	int client = 0;
	while((client = FindEntityByClassname(client, "player")) != -1)
	{
		if(IsValidClient(client, false, true))
		{
			// obtain the names.
			GetPlayerName(client, g_Player[client].name, sizeof(g_Player[].name));
		}
	}
	
	return Plugin_Continue;
}