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
	bool Gibbed;
	bool TeleFrag;
	bool Taunt;
	bool Sentry;
	bool MiniSentry;
	bool Wrangled;
	bool Collateral;
	bool Grenade;
	bool Bomb;
	bool Blinded;
	bool PumpkinBomb;
	bool Quickscope;
	bool Wallbang;
	bool Burned;
	bool Knifed;
	
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
		this.Gibbed = false;
		this.TeleFrag = false;
		this.Taunt = false;
		this.Sentry = false;
		this.MiniSentry = false;
		this.Wrangled = false;
		this.Collateral = false;
		this.Grenade = false;
		this.Bomb = false;
		this.Blinded = false;
		this.PumpkinBomb = false;
		this.Quickscope = false;
		this.Wallbang = false;
		this.Burned = false;
		this.Knifed = false;
	}
}

enum struct SMStats_PlayerInfo
{
	int userid;
	int iTeam;
	char auth[AUTH_LENGTH];
	char profileid[24];
	char name[64];
	char name2[64];
	char team[11];
	char ip[16];
	//bool bAlreadyConnected;
	bool bPenalty;
	int points;
	int position;
	int active_page_mainmenu;
	int active_page_menu;
	int active_page_session;
	int active_page_activestats;
	int active_page_topstats;
	bool bMenuCheckPosition;
	
	// settings
	bool bPlayConSnd;
	bool bPlayConSndUpdated;
	bool bShowConMsg;
	bool bShowConMsgUpdated;
	bool bShowTopConMsg;
	bool bShowTopConMsgUpdated;
	bool bShowFragMsg;
	bool bShowFragMsgUpdated;
	bool bShowAssistMsg;
	bool bShowAssistMsgUpdated;
	bool bShowDeathMsg;
	bool bShowDeathMsgUpdated;
	
	int session[SMStats_StatsSize];
	int menustats[SMStats_StatsSize];
	char menustats_name[64];
	char menustats_auth[28];
	char menustats_ip[16];
	int menustats_pos;
	int menustats_lastconnected;
	bool menustats_penalty;
	SMStats_FragMsgInfo fragmsg;
	
	void Reset()
	{
		this.userid = -1;
		this.auth = "";
		this.profileid = ""
		this.name = "";
		this.name2 = "";
		this.bPenalty = false;
		//this.bAlreadyConnected = false;
		this.points = -1;
		this.position = -1;
		this.active_page_menu = -1;
		
		this.bPlayConSnd = false;
		this.bPlayConSndUpdated = false;
		
		this.bShowConMsg = false;
		this.bShowConMsgUpdated = false;
		
		this.bShowTopConMsg = false;
		this.bShowTopConMsgUpdated = false;
		
		this.bShowFragMsg = false;
		this.bShowFragMsgUpdated = false;
		
		this.bShowAssistMsg = false;
		this.bShowAssistMsgUpdated = false;
		
		this.bShowDeathMsg = false;
		this.bShowDeathMsgUpdated = false;
		
		this.ResetMenuStats()
		this.fragmsg.Reset();
	}
	
	void ResetMenuStats()
	{
		this.active_page_mainmenu = -1;
		this.active_page_session = -1;
		this.active_page_activestats = -1;
		this.active_page_topstats = -1;
		this.menustats_name = "";
		this.menustats_auth = "";
		this.menustats_ip = "";
		this.menustats_pos = -1;
		this.menustats_lastconnected = -1;
		this.menustats_penalty = false;
		for(int type = 0; type < SMStats_StatsSize; type++)
		{
			this.menustats[type] = -1;
		}
	}
}

enum struct SMStats_TF2GameInfo
{
	ArrayList aFragEvent;
	ArrayList aItemEvent;
	
	bool bObjectPlaced[6];
	ArrayList aObjectPlaced;
	Action tObjectPlaced(Handle timer, DataPack pack)
	{
		int objects = pack.ReadCell();
		any[] list = new any[objects];
		pack.ReadCellArray(list, objects);
		
		for(int i = 0; i < objects; i++)
		{
			int obj = list[i];
			this.bObjectPlaced[obj] = false;
		}
		
		return Plugin_Continue;
	}
	
	bool bObjectDestroyed[6];
	ArrayList aObjectDestroyed;
	
	bool bUbercharged;
	
	bool bUsedTeleporter;
	bool bPlayerUsedTeleporter;
	
	bool bStolenSandvich;
	
	bool bStunned;
	
	bool bPassBallEvent[6];
	
	int iRobotFragEvent;
	
	int iFrameFeignDeaths;
	int iFrameHealPoints;
	
	//
	
	bool bPlayerJarated;
	bool bPlayerMilked;
	bool bPlayerGasPassed;
	ArrayList aJarEvent;
	
	bool bExtEvent;
	ArrayList aExtEvent;
	
	//
	
	void Reset()
	{
		if(!!this.aFragEvent)
		{
			delete this.aFragEvent;
		}
		
		if(!!this.aItemEvent)
		{
			delete this.aItemEvent;
		}
		
		if(!!this.aObjectPlaced)
		{
			delete this.aObjectPlaced;
		}
		
		if(!!this.aObjectDestroyed)
		{
			delete this.aObjectDestroyed;
		}
		
		if(!!this.aJarEvent)
		{
			delete this.aJarEvent;
		}
		
		if(!!this.aExtEvent)
		{
			delete this.aExtEvent;
		}
		
		for(int i = 0; i < 6; i++)
		{
			this.bObjectPlaced[i] = false;		
			this.bObjectDestroyed[i] = false;
			this.bPassBallEvent[i] = false;
		}
		
		this.bUbercharged = false;
		this.bUsedTeleporter = false;
		this.bPlayerUsedTeleporter = false;
		this.bStolenSandvich = false;
		this.bStunned = false;
		this.bPlayerJarated = false;
		this.bPlayerMilked = false;
		this.bPlayerGasPassed = false;
		this.bExtEvent = false;
		this.iRobotFragEvent = 0;
		this.iFrameFeignDeaths = 0;
		this.iFrameHealPoints = -1;
	}
}

enum struct SMStats_CSSGameInfo
{
	int work_in_progress;
}

enum struct SMStats_CSGOGameInfo
{
	ArrayList aFragEvent;
	ArrayList aFrameBlinded;
	ArrayList aChickenFragEvent;
	
	void Reset()
	{
		if(!!this.aFragEvent)
		{
			delete this.aFragEvent;
		}
		
		if(!!this.aFrameBlinded)
		{
			delete this.aFrameBlinded;
		}
		
		if(!!this.aChickenFragEvent)
		{
			delete this.aChickenFragEvent;
		}
	}
}

enum struct SMStatsInfo_CrucialStuff
{
	bool bLoaded;
	bool bStatsActive;
	bool bRoundActive;
	int iMapTimerSeconds;
}

methodmap SMStatsInfo __nullable__
{
	/*
	 *	SourceMod Statistics.
	 *	Obtain the current player info.
	 *
	 *	@param client		The user index.
	 *	@param player_info	The SMStats_PlayerInfo array to store the obtained statistics.
	 */
	public static native void GetPlayerInfo(int client, any[] player_info);
	
	/*
	 *	SourceMod Statistics.
	 *	Save the current player info.
	 *
	 *	@param client		The user index.
	 *	@param player_info	The SMStats_PlayerInfo array to obtain the statistics.
	 */
	public static native void SavePlayerInfo(int client, any[] player_info);
	
	/*
	 *	SourceMod Statistics.
	 *	Resets the player stats.
	 *
	 *	@param client		The user index.
	 */
	public static native void ResetPlayerInfo(int client);
	
	
	/*
	 *	SourceMod Statistics.
	 *	Obtain the current player game stats.
	 *
	 *	@param client		The user index.
	 *	@param game_stats	The SMStats GameInfo array to store the obtained statistics.
	 */
	public static native void GetGameStats(int client, any[] game_stats);
	
	/*
	 *	SourceMod Statistics.
	 *	Save the current player game stats.
	 *
	 *	@param client		The user index.
	 *	@param game_stats	The SMStats GameInfo array to obtain the statistics.
	 */
	public static native void SaveGameStats(int client, any[] game_stats);
	
	/*
	 *	SourceMod Statistics.
	 *	Resets the player game stats.
	 *
	 *	@param client		The user index.
	 */
	public static native void ResetGameStats(int client);
	
	public static bool IsLoaded()
	{
		return LibraryExists("SMStatsInfo");
	}
}

public SharedPlugin __pl_sm_stats_info =
{
	name = "SMStats",
	file = "sm_stats_info.smx",
#if defined REQUIRE_PLUGIN
	required = 1
#else
	required = 0
#endif
}

#if !defined REQUIRE_PLUGIN
public void __pl_sm_stats_info_SetNTVOptional()
{
	MarkNativeAsOptional("SMStatsInfo.GetPlayerInfo");
	MarkNativeAsOptional("SMStatsInfo.SavePlayerInfo");
	MarkNativeAsOptional("SMStatsInfo.ResetPlayerInfo");
	
	MarkNativeAsOptional("SMStatsInfo.GetGameStats");
	MarkNativeAsOptional("SMStatsInfo.SaveGameStats");
	MarkNativeAsOptional("SMStatsInfo.ResetGameStats");
	
	MarkNativeAsOptional("_sm_stats_info_update_stats_active");
	MarkNativeAsOptional("_sm_stats_info_update_round_active");
	MarkNativeAsOptional("_sm_stats_info_update_maptimer");
	MarkNativeAsOptional("_sm_stats_info_get_crucial_stuff");
	MarkNativeAsOptional("_sm_stats_info_save_crucial_stuff");
}