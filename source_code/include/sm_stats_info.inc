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
	char name2[64];
	char ip[16];
	//bool bAlreadyConnected;
	int points;
	int position;
	int active_page_menu;
	int active_page_session;
	int active_page_total;
	int active_page_topstats;
	
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
		this.name = "";
		this.name2 = "";
		//this.bAlreadyConnected = false;
		this.points = -1;
		this.position = -1;
		this.active_page_menu = -1;
		this.active_page_session = -1;
		this.active_page_total = -1;
		this.active_page_topstats = -1;
		this.topstatsname = "";
		this.topstatsauth = "";
		this.topstatsip = "";
		this.toppos = -1;
		this.toplastconnected = -1;
		
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
		this.bExtEvent = false;
		this.iRobotFragEvent = -1;
	}
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
	public static native void GetStats(int client, any[] player_stats);
	
	/*
	 *	SourceMod Statistics.
	 *	Save the current player stats.
	 *
	 *	@param client		The user index.
	 *	@param player_stats	The SMStats_PlayerInfo array to obtain the statistics.
	 */
	public static native void SaveStats(int client, any[] player_stats);
	
	/*
	 *	SourceMod Statistics.
	 *	Resets the player stats.
	 *
	 *	@param client		The user index.
	 */
	public static native void ResetStats(int client);
	
	
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
}