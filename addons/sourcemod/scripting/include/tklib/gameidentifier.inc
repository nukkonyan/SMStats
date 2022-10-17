//==========================================//
// Tklib / Game Identifier.
//==========================================//
#if !defined _tklib_disable_gameidentifier

enum GameIdentifier	{
	Game_Unknown		= -1,
	Game_SDK2006		= 0,
	Game_SDK2007		= 1,
	Game_SDK2013		= 2,
	Game_AlienSwarm		= 3,
	Game_BGT			= 4,
	Game_BloodyGoodTime	= 4,
	Game_DarkMessiah	= 5,
	Game_Eye			= 6,
	Game_Dota			= 7,
	Game_Dota2			= 7,
	Game_Blade			= 8,
	Game_Insurgency		= 9,
	Game_Contagion		= 10,
	Game_BlackMesa		= 11,
	Game_DOI			= 12,
	Game_HL2DM			= 13,
	Game_DODS			= 14,
	Game_Portal1		= 15,
	Game_Portal2		= 16,
	Game_L4D1			= 17,
	Game_L4D2			= 18,
	Game_CSGO			= 19,
	Game_CSCO			= 20,
	Game_CSS			= 21,
	Game_TF2			= 22,
	Game_TF2B			= 23,
	Game_TF2Beta		= 23,
	Game_TF2C			= 24,
	Game_TF2Classic		= 24,
	Game_TF2V			= 25,
	Game_TF2Vintage		= 25,
	Game_TF2OP			= 26,
	Game_TF2OpenFortress= 26,
	Game_OpenFortress	= 26,
	Game_CSPro			= 27,
	Game_CSPromod		= 27
}

/**
 *	This is to make game identification much easier.
 *
 *	@return			Returns as example Game_TF2Vintage, Game_CSPromod, etc.
 */
stock GameIdentifier IdentifyGame()	{
	char checkgame[64];
	GetGameFolderName(checkgame, sizeof(checkgame));
	switch(GetEngineVersion())	{
		case Engine_Unknown: return Game_Unknown;
		case Engine_AlienSwarm: return Game_AlienSwarm;
		case Engine_BloodyGoodTime: return Game_BloodyGoodTime;
		case Engine_DarkMessiah: return Game_DarkMessiah;
		case Engine_EYE: return Game_Eye;
		case Engine_DOTA: return Game_Dota2;
		case Engine_Blade: return Game_Blade;
		case Engine_Insurgency: return Game_Insurgency;
		case Engine_Contagion: return Game_Contagion;
		case Engine_BlackMesa: return Game_BlackMesa;
		case Engine_DOI: return Game_DOI;
		case Engine_HL2DM: return Game_HL2DM;
		case Engine_DODS: return Game_DODS;
		case Engine_Portal2: return Game_Portal2;
		//case Engine_Left4Dead: return Game_L4D1;
		case Engine_Left4Dead2: return Game_L4D2;
		case Engine_CSGO:	{
			if(StrEqual(checkgame, "csgo"))
				return Game_CSGO;
			if(StrEqual(checkgame, "csco"))
				return Game_CSCO;
		}
		case Engine_CSS: return Game_CSS;
		case Engine_TF2:	{
			if(StrEqual(checkgame, "tf"))
				return Game_TF2;
			if(StrEqual(checkgame, "tfbeta"))
				return Game_TF2Beta;
			if(StrEqual(checkgame, "tf2classic"))
				return Game_TF2Classic;
			if(StrEqual(checkgame, "tf2vintage"))
				return Game_TF2Vintage;
			if(StrEqual(checkgame, "open_fortress"))
				return Game_TF2OpenFortress;
		}
		case Engine_SourceSDK2006: return Game_SDK2006;
		case Engine_SourceSDK2007:	{
			if(StrEqual(checkgame, "portal"))
				return Game_Portal1;
			else if(StrEqual(checkgame, "cspromod"))
				return Game_CSPromod;
			else
				return Game_SDK2007;
		}
		case Engine_SDK2013: return Game_SDK2013;
	}
	
	return Game_Unknown;
}

/**
 *	Returns the title/game name.
 *
 *	@param	game_name	String buffer to store.
 *	@param	maxlen		The maximum length of the buffer.
 */
stock void GetGameName(char[] game_name, int maxlen) {
	switch(IdentifyGame())	{
		case Game_Unknown: strcopy(game_name, maxlen, "Unknown Game");
		case Game_SDK2006: strcopy(game_name, maxlen, "Source SDK Base 2006");
		case Game_SDK2007: strcopy(game_name, maxlen, "Source SDK Base 2007");
		case Game_SDK2013: strcopy(game_name, maxlen, "Source SDK Base 2013");
		case Game_AlienSwarm: strcopy(game_name, maxlen, "Alien Swarm");
		case Game_BGT: strcopy(game_name, maxlen, "Bloody Good Time");
		case Game_DarkMessiah: strcopy(game_name, maxlen, "Dark Messiah");
		case Game_Eye: strcopy(game_name, maxlen, "E.Y.E. Divine Cybermancy");
		case Game_Dota2: strcopy(game_name, maxlen, "Dota 2");
		case Game_Blade: strcopy(game_name, maxlen, "Blade Symphony");
		case Game_Insurgency: strcopy(game_name, maxlen, "Insurgency");
		case Game_Contagion: strcopy(game_name, maxlen, "Contagion");
		case Game_BlackMesa: strcopy(game_name, maxlen, "Black Mesa");
		case Game_DOI: strcopy(game_name, maxlen, "Day Of Infamy");
		case Game_HL2DM: strcopy(game_name, maxlen, "Half-Life 2: Deathmatch");
		case Game_DODS: strcopy(game_name, maxlen, "Day Of Defeat: Source");
		case Game_Portal1: strcopy(game_name, maxlen, "Portal 1");
		case Game_Portal2: strcopy(game_name, maxlen, "Portal 2");
		case Game_L4D1: strcopy(game_name, maxlen, "Left 4 Dead 1");
		case Game_L4D2: strcopy(game_name, maxlen, "Left 4 Dead 2");
		case Game_CSGO: strcopy(game_name, maxlen, "Counter-Strike: Global Offensive");
		case Game_CSCO: strcopy(game_name, maxlen, "Counter-Strike: Classic Offensive");
		case Game_CSS: strcopy(game_name, maxlen, "Counter-Strike: Source");
		case Game_TF2: strcopy(game_name, maxlen, "Team Fortress 2");
		case Game_TF2B: strcopy(game_name, maxlen, "Team Fortress 2: Beta");
		case Game_TF2C: strcopy(game_name, maxlen, "Team Fortress 2: Classic");
		case Game_TF2V: strcopy(game_name, maxlen, "Team Fortress 2: Vintage");
		case Game_TF2OP: strcopy(game_name, maxlen, "Team Fortress 2: Open Fortress");
		case Game_CSPromod: strcopy(game_name, maxlen, "Counter-Strike: Promod");
	}
}

/**
 *	Returns if the game is the game you you specified.
 *	This can be quite useful for checking things and not take too much space.
 *
 *	@param	gameversion		The GameIdentifier game you specify.
 *
 *	@return	If true, game you specified is active, else false.
 */
stock bool IsCurrentGame(GameIdentifier gameversion)	{
	return (IdentifyGame() == gameversion);
}

/**
 *	Returns if the engine is the engine you you specified.
 *	This can be quite useful for checking things and not take too much space.
 *
 *	@param	engineversion	The EngineVersion engine you specify.
 *
 *	@return				If true, game you specified is active, else false.
 */
stock bool IsCurrentEngine(EngineVersion engineversion)	{
	return (GetEngineVersion() == engineversion);
}

#endif