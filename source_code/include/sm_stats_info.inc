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
	bool Collateral;
	bool Grenade;
	bool Bomb;
	bool Blinded;
	bool PumpkinBomb;
	
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
		this.Collateral = false;
		this.Grenade = false;
		this.Bomb = false;
		this.Blinded = false;
		this.PumpkinBomb = false;
	}
}

enum struct SMStats_PlayerInfo
{
	int userid;
	char auth[28];
	char profileid[24];
	char name[64];
	char name2[64];
	char ip[16];
	//bool bAlreadyConnected;
	int points;
	int position;
	int active_page_mainmenu;
	int active_page_menu;
	int active_page_session;
	int active_page_total;
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
	int totalstats[SMStats_StatsSize];
	int topstats[SMStats_StatsSize];
	char topstatsname[64];
	char topstatsauth[64];
	char topstatsip[16];
	int toppos;
	int toplastconnected;
	SMStats_FragMsgInfo fragmsg;
	
	void Reset()
	{
		this.userid = -1;
		this.auth = "";
		this.profileid = ""
		this.name = "";
		this.name2 = "";
		//this.bAlreadyConnected = false;
		this.points = -1;
		this.position = -1;
		this.active_page_mainmenu = -1;
		this.active_page_menu = -1;
		this.active_page_session = -1;
		this.active_page_total = -1;
		this.active_page_topstats = -1;
		this.topstatsname = "";
		this.topstatsauth = "";
		this.topstatsip = "";
		this.toppos = -1;
		this.toplastconnected = -1;
		
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
		
		for(int type = 0; type < SMStats_StatsSize; type++)
		{
			this.session[type] = -1;
			this.totalstats[type] = -1;
			this.topstats[type] = -1;
		}
		this.fragmsg.Reset();
	}
	
	void ResetTopStats()
	{
		this.topstatsname = "";
		this.topstatsauth = "";
		this.topstatsip = "";
		this.toppos = -1;
		this.toplastconnected = -1;
		for(int type = 0; type < SMStats_StatsSize; type++)
		{
			this.topstats[type] = -1;
		}
	}
}

enum struct SMStats_TF2GameInfo
{
	ArrayList aFragEvent;
	
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
		this.iRobotFragEvent = -1;
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
	 *	Obtain the current player stats.
	 *
	 *	@param client		The user index.
	 *	@param player_stats	The SMStats_PlayerInfo array to store the obtained statistics.
	 */
	public static native void GetPlayerStats(int client, any[] player_stats);
	
	/*
	 *	SourceMod Statistics.
	 *	Save the current player stats.
	 *
	 *	@param client		The user index.
	 *	@param player_stats	The SMStats_PlayerInfo array to obtain the statistics.
	 */
	public static native void SavePlayerStats(int client, any[] player_stats);
	
	/*
	 *	SourceMod Statistics.
	 *	Resets the player stats.
	 *
	 *	@param client		The user index.
	 */
	public static native void ResetPlayerStats(int client);
	
	
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