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

methodmap SMStatsInfo __nullable__
{
	/*
	 *	SourceMod Statistics.
	 *	Obtain the current player stats.
	 *
	 *	@param client		The user index.
	 *	@param player_info	The SMStats_PlayerInfo array to store the obtained information.
	 */
	public static native void Get(int client, any[] player_info);
	
	/*
	 *	SourceMod Statistics.
	 *	Save the current player stats.
	 *
	 *	@param client		The user index.
	 *	@param player_info	The SMStats_PlayerInfo array to to obtain the information.
	 */
	public static native void Save(int client, any[] player_info);
}