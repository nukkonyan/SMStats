#include	<gameidentifier>

#if defined Xstats_Included
	#endinput
#endif

#define	Xstats_Included

#define		XSTATS_DBNAME	"xstats"

/**
 *	Used for making sure the results were found.
 *	Returns true or false depending if the results were found and fetched or not.
 */
stock bool IsValidResults(DBResultSet results)	{
	if(results != null && results.FetchRow())
		return	true;
	if(results != null)
		return	true;
	if(results.FetchRow())
		return	true;
	return	false;
}

/**
 *	Checks through the player if the player is 'abusive'.
 *
 *	@param		client		The client index to check.
 *	@param		SvCheats	If true, if sv_cheats value is nonzero, it counts as 'abusive'.
 *	Returns true if abusive, else false.
 */
native bool Xstats_IsClientAbusive(int client, bool SvCheats=false);

//============================================================================================//

/**
 *	Called when the database is connected succesfully.
 *
 *	@param		database		The database connection.
 */
forward void Xstats_OnDatabaseConnected(Database database);

/**
 *	Called when stats command is triggered.
 *
 *	@param		client			The client who triggered the stats command.
 *	@return		Returns the command action
 */
forward Action Xstats_OnStatsCommand(int client);

/**
 *	Called when the menu command is triggered.
 *
 *	@param		client			The client who triggered the menu command.
 *	@return		Returns the command ection.
 */
forward Action Xstats_OnMenuCommand(int client);

/**
 *	Called when the prefix tag is updated.
 *
 *	@param		prefix			The new updated prefix tag.
 */
forward void Xstats_OnPrefixTagUpdated(char[] prefix);

/**
 *	Called when the player disconnects.
 *
 *	@param		client			The client index who left.
 *	@param		reason			The reason why the player left.
 *	@param		auth			The clients steamid.
 *	@return		If returning Plugin_Handled, the ingame disconnect message will be silenced.
 */
forward Action Xstats_OnClientDisconnect(int client, char[] reason, char[] auth);

/**
 *	Called when the round begun.
 */
forward void Xstats_OnRoundBegin();

/**
 *	Called when the round ended.
 **/
forward void Xstats_OnRoundEnd();

//============================================================================================//

/**
 *	Get the database connection from xstats
 */
native Database Xstats_GetDatabaseConnection();

/**
 *	Forces to re-establish a database connection. (Can break somethings, be aware.)
 *
 *	@return		If true, the database was established, otherwise if it failed it returns false.
 */
native bool Xstats_EstablishDatabaseConnection();

/**
 *	Returns if the client specified is valid or not.
 *
 *	@param		client		Client index.
 *	@param		IgnoreBots	If true, this will count bots as 'invalid' (return false).
 */
native bool Xstats_IsValidClient(int client, bool IgnoreBots=false);

/**
 * 	Returns if the client specified is valid or not.
 *	Same as IsValidClient but ignores IsClientInGame check as that will cause client to be 'invalid' at certain events.
 *
 *	@param		client		Client index.
 *	@param		IgnoreBots	If true, this will count bots as 'invalid' (return false).
 */
native bool Xstats_IsValidClientEx(int client, bool IgnoreBots=false);

/**
 * 	Returns if the client specified is valid or not.
 *	Same as IsValidClient but ignores IsClientInGame and IsClientConnected check as that will cause client to be 'invalid' at certain events.
 *
 *	@param		client		Client index.
 *	@param		IgnoreBots	If true, this will count bots as 'invalid' (return false).
 */
native bool Xstats_IsValidClientEx2(int client, bool IgnoreBots=false);

/**
 *	Returns the minimum needed players to have statistics tracking enabled.
 */
native int Xstats_MinimumPlayers();

/**
 *	Returns if the statistics tracking should be disable upon a team winning a round.
 */
native bool Xstats_DisableOnWin();

/**
 *	Returns if bots should be counted as players.
 */
native bool Xstats_CountBots();

/**
 *	Returns if the debug should be enabled.
 */
native bool Xstats_Debug();

/**
 *	Returns if the round is active or not.
 */
native bool Xstats_RoundActive();

/**
 *	Returns if the ranking statistics is active or not.
 */
native bool Xstats_RankingActive();

/**
 *	Returns the amount of active players.
 *
 *	@param		bots		If true, the bots will be counted.
 */
native bool Xstats_GetActivePlayers(bool bots);

/**
 *	Returns the xstats prefix tag.
 *
 *	@param		buffer		The source where to store the prefix.
 *	@param		maxlen		The source length.
 */
native void Xstats_GetPrefixTag(char[] buffer, int maxlen);

/**
 *	Returns the country name of the client.
 *
 *	@param		client		The client index to request the country name of.
 *	@param		country		The name of the country.
 *	@param		maxlen		The string buffer length.
 *	@return		Returns true if success, false otherwise.
 */
native bool Xstats_GetClientCountry(int client, char[] country, int maxlen);

/**
 *	Returns the clients points.
 *
 *	@param		client			The client index to request points from.
 *	@param		players_table	The playerstats table to get points from.
 */
native int Xstats_GetClientPoints(int client, char[] players_table);

/**
 *	Returns the clients position.
 *
 *	@param		client			The client index to request rank from.
 *	@param		players_table	The playerstats table to get rank from.
 */
native int Xstats_GetClientPos(int client, char[] players_table);

/**
 *	Returns the player count of the database table list.
 *
 *	@param		players_table	The playerstats table to get player count from.
 *	@return		If the results were invalid, it will return 0.
 */
native int Xstats_GetPlayerCount(char[] players_table);

/**
 *	Returns if the client is midair.
 *
 *	@param		client			The client index.
 */
native bool Xstats_IsClientMidAir(int client);

methodmap	Xstats	{
	public Database GetDatabaseConnection()	{
		return Xstats_GetDatabaseConnection();
	}
	
	public bool IsValidClient(int client, bool IgnoreBots=false)	{
		return Xstats_IsValidClient(client);
	}
	
	public bool IsValidClientEx(int client, bool IgnoreBots=false)	{
		return Xstats_IsValidClientEx(client);
	}
	
	public bool IsValidClientEx2(int client, bool IgnoreBots=false)	{
		return Xstats_IsValidClientEx2(client);
	}
	
	public bool IsClientAbusive(int client, bool SvCheats=false)	{
		return Xstats_IsClientAbusive(client, SvCheats);
	}
	
	public int MinimumPlayers()	{
		return Xstats_MinimumPlayers();
	}
	
	public int DisableOnWin()	{
		return Xstats_DisableOnWin();
	}
	
	public bool CountBots()	{
		return Xstats_CountBots();
	}
	
	public bool Debug()	{
		return Xstats_Debug();
	}
	
	public bool RoundActive()	{
		return Xstats_RoundActive();
	}
	
	public bool RankingActive()	{
		return Xstats_RankingActive();
	}
	
	public int GetActivePlayers(bool bots)	{
		return Xstats_GetActivePlayers(bots);
	}
	
	public bool GetPrefixTag(char[] buffer, int maxlen)	{
		Xstats_GetPrefixTag(buffer, maxlen);
	}
	
	public bool GetClientCountry(int client, char[] country, int maxlen)	{
		return Xstats_GetClientCountry(client, country, maxlen);
	}
	
	public int GetClientPoints(int client, char[] players_table)	{
		return Xstats_GetClientPoints(client, players_table);
	}
	
	public int GetClientPos(int client, char[] players_table)	{
		return Xstats_GetClientPos(client, players_table);
	}
	
	public int GetPlayerCount(char[] players_table)	{
		return Xstats_GetPlayerCount(players_table);
	}
	
	public bool IsClientMidAir(int client)	{
		return Xstats_IsClientMidAir(client);
	}
}

public	SharedPlugin	__pl_Xstats	=	{
	name	=	"Xstats: Core",
	file	=	"xstats.smx",
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
		
		MarkNativeAsOptional("Xstats_IsValidClient");
		MarkNativeAsOptional("Xstats.IsValidClient");
		
		MarkNativeAsOptional("Xstats_IsValidClientEx");
		MarkNativeAsOptional("Xstats.IsValidClientEx");
		
		MarkNativeAsOptional("Xstats_IsValidClientEx2");
		MarkNativeAsOptional("Xstats.IsValidClientEx2");
		
		MarkNativeAsOptional("Xstats_IsClientAbusive");
		MarkNativeAsOptional("Xstats.IsClientAbusive");
		
		MarkNativeAsOptional("Xstats_MinimumPlayers");
		MarkNativeAsOptional("Xstats.MinimimPlayers");
		
		MarkNativeAsOptional("Xstats_DisableOnWin");
		MarkNativeAsOptional("Xstats.DisableOnWin");
		
		MarkNativeAsOptional("Xstats_CountBots");
		MarkNativeAsOptional("Xstats.CountBots");
		
		MarkNativeAsOptional("Xstats_Debug");
		MarkNativeAsOptional("Xstats.Debug");
		
		MarkNativeAsOptional("Xstats_RoundActive");
		MarkNativeAsOptional("Xstats.RoundActive");
		
		MarkNativeAsOptional("Xstats_RankingActive");
		MarkNativeAsOptional("Xstats.RankingActive");
		
		MarkNativeAsOptional("Xstats_GetActivePlayers");
		MarkNativeAsOptional("Xstats.GetActivePlayers");
		
		MarkNativeAsOptional("Xstats_GetPrefixTag");
		MarkNativeAsOptional("Xstats.GetPrefixTag");
		
		MarkNativeAsOptional("Xstats_GetClientCountry");
		MarkNativeAsOptional("Xstats.GetClientCountry");
		
		MarkNativeAsOptional("Xstats_GetClientPos");
		MarkNativeAsOptional("Xstats.GetClientPos");
		
		MarkNativeAsOptional("Xstats_GetPlayerCount");
		MarkNativeAsOptional("Xstats.GetPlayerCount");
		
		MarkNativeAsOptional("Xstats_IsClientMidAir");
		MarkNativeAsOptional("Xstats.IsClientMidAir");
	}
#endif