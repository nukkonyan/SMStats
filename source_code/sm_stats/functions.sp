enum TFBuilding
{
	TFBuilding_Invalid = -1,
	TFBuilding_Sentrygun = 0,
	TFBuilding_Dispenser = 1,
	TFBuilding_Teleporter_Entrance = 2,
	TFBuilding_Teleporter_Exit = 3,
	TFBuilding_MiniSentry = 4,
	TFBuilding_Sapper = 5
}

stock bool IsValidClient(int client, bool bIsFakeClient=true, bool bIsValidEntity=false)
{
	if(client < 1 || client > MaxPlayers)
	{
		return false;
	}
	
	if(bIsValidEntity)
	{
		if(!IsValidEntity(client))
		{
			return false;
		}
	}
	
	if(!IsClientConnected(client))
	{
		return false;
	}
	
	if(IsClientReplay(client))
	{
		return false;
	}
	
	if(IsClientSourceTV(client))
	{
		return false;
	}
	
	if(bIsFakeClient)
	{
		if(IsFakeClient(client))
		{
			return false;
		}
	}
	
	return true;
}

/**
 *	Returns the users m_fFlags status.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid or has no m_fFlags property, this returns -1.
 */
stock int GetClientFlags(int client)
{
	return GetEntProp(client, Prop_Send, "m_fFlags");
}

/**
 *	Returns if the user is mid-air.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool IsClientMidAir(int client)
{
	return (GetClientFlags(client) == 256 || GetClientFlags(client) == 258 || GetClientFlags(client) == 262);
}

stock int GetPlayerWeaponSlotItemdef(int client, int slot)
{
	int weapon = GetPlayerWeaponSlot(client, slot);
	
	if(IsValidEntity(weapon))
	{
		return GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");
	}
	
	return -1;
}

stock void PanelItem(Panel panel, const char[] text, any ...)
{
	char vformat[512];
	VFormat(vformat, sizeof(vformat), text, 3);
	
	panel.DrawItem(vformat);
}

stock void PanelText(Panel panel, const char[] text, any ...)
{
	char vformat[512];
	VFormat(vformat, sizeof(vformat), text, 3);
	
	panel.DrawText(vformat);
}

/* ============================================================== */

stock int GetClientPosition(const char[] auth)
{
	int position = -1;
	
	if(!!sql)
	{
		// lock database as it's non-threaded.
		SQL_LockDatabase(sql);
		
		char query[256];
		Format(query, sizeof(query), "select Points from `%s` where SteamID = '%s' and ServerID = %i", sql_table_playerlist, auth, g_ServerID);
		DBResultSet results = SQL_Query(sql, query);
		
		switch(!!results && results.FetchRow())
		{
			case false:
			{
				delete results;
				
				char error[256];
				SQL_GetError(sql, error, sizeof(error));
				SQL_UnlockDatabase(sql);
				
				LogError("[SM Stats] GetClientPosition error: Failed retrieving points for steam auth '%s' of sql table '%s' (%s)", auth, sql_table_playerlist, error);
				return -1;
			}
			
			case true:
			{
				int points = results.FetchInt(0);
				
				Format(query, sizeof(query), "select count(*) from `%s` where Points >= %i and ServerID = %i", sql_table_playerlist, points, g_ServerID);
				results = SQL_Query(sql, query);
				
				if(!results)
				{
					delete results;
					
					char error[256];
					SQL_GetError(sql, error, sizeof(error));
					SQL_UnlockDatabase(sql);
					
					LogError("[SM Stats] GetClientPosition error: Failed retrieving position for steam auth '%s' of sql table '%s' (%s)", auth, sql_table_playerlist, error);
					return -1;
				}
				
				while(results.FetchRow())
				{
					position = results.FetchInt(0);
				}
			}
		}
		
		delete results;
		SQL_UnlockDatabase(sql);
	}
	
	return position;
}

/**
 *	Returns the total player count in a database table.
 */
stock int GetTablePlayerCount()
{
	int players = 0;
	
	if(!!sql)
	{
		SQL_LockDatabase(sql);
		
		char query[256];
		Format(query, sizeof(query), "select count(*) from `%s` where ServerID = %i", sql_table_playerlist, g_ServerID);
		
		DBResultSet results = SQL_Query(sql, query);
		
		while(!!results && results.FetchRow())
		{
			players = results.FetchInt(0);
		}
		
		delete results;
		
		SQL_UnlockDatabase(sql);
	}
	
	return players;
}

/* ============================================================== */

stock int GetPlayerCount(bool count_bots=false)
{
	int count = 0;
	
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) > 0)
	{
		if(!IsClientConnected(player))
		{
			continue;
		}
		
		if(!count_bots)
		{
			if(IsFakeClient(player))
			{
				continue;
			}
		}
		
		count++;
	}
	
	return count;
}

stock bool IsWarmupActive()
{
	switch(GetEngineVersion())
	{
		case Engine_CSGO:
		{
			return view_as<bool>(GameRules_GetProp("m_bWarmupPeriod"));
		}
		
		case Engine_TF2:
		{
			return view_as<bool>(GameRules_GetProp("m_bInWaitingForPlayers"));
		}
	}
	
	return false;
}

/* Called as soon the round has started. */
stock void OnRoundStarted(Event event, const char[] event_name, bool dontBroadcast)
{
	bRoundActive = true;
	
	if((bWarmupActive = IsWarmupActive()))
	{
		int player = 0;
		while(IsValidClient((player = FindEntityByClassname(player, "player"))))
		{
			CPrintToChat(player, "%s %T", g_ChatTag, "#SMStats_RoundStart_Warmup", player);
		}
		
		return;
	}
	
	if(_sm_stats_get_disableafterroundend())
	{
		int needed = g_MinPlayers;
		int players = GetPlayerCount(bAllowBots);
		
		if(needed <= players)
		{
			bStatsActive = true;
			
			int player = 0;
			while((player = FindEntityByClassname(player, "player")) > 0)
			{
				if(IsValidClient(player))
				{
					CPrintToChat(player, "%s %T", g_ChatTag, "#SMStats_RoundStart", player);
				}
			}
		}
	}
}

/* Called as soon as the round has ended. */
stock void OnRoundEnded(Event event, const char[] event_name, bool dontBroadcast)
{
	bRoundActive = false;
	
	if((bWarmupActive = IsWarmupActive()))
	{
		if(_sm_stats_get_disableafterroundend())
		{
			bStatsActive = false;
			
			int player = 0;
			while((player = FindEntityByClassname(player, "player")) > 0)
			{
				if(IsValidClient(player))
				{
					CPrintToChat(player, "%T", "#SMStats_RoundEnd", player);
				}
			}
		}
	}
}

void CheckActivePlayers()
{
	int needed = g_MinPlayers;
	int players = GetPlayerCount(bAllowBots);
	
	switch(bStatsActive)
	{
		case false:
		{
			if(players >= needed && bRoundActive)
			{
				bStatsActive = true;
				
				int player = 0;
				while((player = FindEntityByClassname(player, "player")) > 0)
				{
					if(IsValidClient(player))
					{
						CPrintToChat(player, "%s %T"
						, g_ChatTag
						, "#SMStats_EnoughPlayers", player
						, players
						, needed);
					}
				}
			}
		}
		
		case true:
		{
			if(players < needed)
			{
				bStatsActive = false;
				
				int player = 0;
				while((player = FindEntityByClassname(player, "player")) > 0)
				{
					if(IsValidClient(player))
					{
						CPrintToChat(player, "%s %T"
						, g_ChatTag
						, "#SMStats_NotEnoughPlayers", player
						, players
						, needed);
					}
				}
			}
		}
	}
	
	if(DEBUG) PrintToServer("CheckActivePlayers() : %i players out of required %i"
	... "\n bStatsActive : %s"
	... "\n bRoundActive : %s"
	, players, needed
	, bStatsActive ? "true" : "false"
	, bRoundActive ? "true" : "false");
}

stock bool IsValidStats()
{
	if(!bLoaded)
	{
		if(DEBUG) PrintToServer("IsValidStats() - bLoaded : false");
		return false;
	}
	else if(!bStatsActive)
	{
		if(DEBUG) PrintToServer("IsValidStats() - bStatsActive : false");
		return false;
	}
	else if(!bRoundActive)
	{
		if(DEBUG) PrintToServer("IsValidStats() - bRoundActive : false");
		return false;
	}
	else if(bWarmupActive)
	{
		if(!_sm_stats_get_allowwarmup())
		{
			if(DEBUG) PrintToServer("IsValidstats() - bWarmupActive : false (not allowed)");
			return false;
		}
	}
	
	return true;
}

/*
 *	Returns wheter abuse is active.
 *	Such as user using Noclip or sv_cheats is active during the event.
 */
stock bool IsValidAbuse(int client)
{
	if(bAllowAbuse)
	{
		return false;
	}
	
	ConVar cvar;
	
	if(!!(cvar = FindConVar("sv_cheats")))
	{
		if(cvar.BoolValue)
		{
			return true;
		}
	}
	else if(client > 0)
	{
		if(GetEntityMoveType(client) == MOVETYPE_NOCLIP)
		{
			return true;
		}
	}
	
	return false;
}

/* ============================================================== */

/*
 ========================
 ========================
 ========================
 ========================
*/

enum
{
	Frag_MidAir = 0,
	Frag_ThroughSmoke = 1,
	Frag_NoscopeHS = 2,
	Frag_Headshot = 3,
	Frag_Noscope = 4,
	Frag_Backstab = 5,
	Frag_Airshot = 6,
	Frag_Deflect = 7,
	Frag_TeleFrag = 8,
	Frag_TauntFrag = 9,
	Frag_Collateral = 10,
	Frag_Grenade = 11,
	Frag_Bomb = 12,
	Frag_Blinded = 13,
}

/**
 *	Frag scenario | Used for translations.
 *	The kill events will be merged together automatically.
 *	Example: Headshot whilst Mid-Air or Headshot Through Smoke whilst Mid-Air, etc.. (You get it)
 */
char Frag_Type[][] = {
/*0*/"#SMStats_FragEvent_Type0", //Mid-Air.
/*1*/"#SMStats_FragEvent_Type1", //Through Smoke.
/*2*/"#SMStats_FragEvent_Type2", //Noscope Headshot.
/*3*/"#SMStats_FragEvent_Type3", //Headshot.
/*4*/"#SMStats_FragEvent_Type4", //Noscope.
/*5*/"#SMStats_FragEvent_Type5", //Backstab.
/*6*/"#SMStats_FragEvent_Type6", //Airshot.
/*7*/"#SMStats_FragEvent_Type7", //Deflect frag.
/*8*/"#SMStats_FragEvent_Type8", //Telefrag.
/*9*/"#SMStats_FragEvent_Type9", //Taunt frag.
/*10*/"#SMStats_FragEvent_Type10", //Collateral.
/*11*/"#SMStats_FragEvent_Type11", //Grenade frag.
/*12*/"#SMStats_FragEvent_Type12", //Bomb frag.
/*13*/"#SMStats_FragEvent_Type13", //Blinded frag.
};

/**
 *	Prepare the kill message.
 *
 *	@param	client	The client who killed.
 *	@param	victim	The victim who died.
 *	@param	points	The points the client was given
 */
stock void PrepareFragMessage(int client, const char[] victim, int points, int frags)
{
	if(DEBUG) PrintToServer("%s PrepareFragMessage(client %i, victim '%s', points %i, frags %i)", core_chattag, client, victim, points, frags);
	char buffer[196];
	
	/* Lë ol' messy code but has to be it. */
	
	/* Deflect kill */
	if(g_Player[client].fragmsg.Deflected)
	{
		/* Airshot deflect kill */
		if(g_Player[client].fragmsg.Airshot)
		{
			switch(g_Player[client].fragmsg.Headshot)
			{
				/* Headshot airshot deflect kill */
				case true:
				{
					Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
					, Frag_Type[Frag_Headshot], client
					, Frag_Type[Frag_Airshot], client
					, Frag_Type[Frag_Deflect], client);
				}
				/* Airshot deflect kill */
				case false:
				{
					Format(buffer, sizeof(buffer), "%T{default} %T{default}"
					, Frag_Type[Frag_Airshot], client
					, Frag_Type[Frag_Deflect], client);
				}
			}
		}
		else
		{
			switch(g_Player[client].fragmsg.Headshot)
			{
				/* Headshot deflect kill */
				case true:
				{
					Format(buffer, sizeof(buffer), "%T{default} %T{default}"
					, Frag_Type[Frag_Headshot], client
					, Frag_Type[Frag_Deflect], client);
				}
				/* Deflect kill */
				case false:
				{
					Format(buffer, sizeof(buffer), "%T{default}"
					, Frag_Type[Frag_Deflect], client);
				}
			}
		}
	}
	/* Collateral */
	else if(g_Player[client].fragmsg.Collateral)
	{
		switch(g_Player[client].fragmsg.Headshot)
		{
			/* Headshot collateral kill */
			case true:
			{
				Format(buffer, sizeof(buffer), "%T{default} %T{default}"
				, Frag_Type[Frag_Headshot], client
				, Frag_Type[Frag_Collateral], client);
			}
			/* Colllateral kill */
			case false:
			{
				Format(buffer, sizeof(buffer), "%T{default}"
				, Frag_Type[Frag_Collateral], client);
			}
		}
	}
	/* Airshot kill */
	else if(g_Player[client].fragmsg.Airshot)
	{
		/* Mid air airshot kill */
		if(g_Player[client].fragmsg.MidAir)
		{
			switch(g_Player[client].fragmsg.Headshot)
			{
				/* Mid air airshot headshot kill */
				case true:
				{
					Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
					, Frag_Type[Frag_Headshot], client
					, Frag_Type[Frag_Airshot], client
					, Frag_Type[Frag_MidAir], client);
				}
				/* Mid air airshot kill */
				case false:
				{
					Format(buffer, sizeof(buffer), "%T{default} %T{default}"
					, Frag_Type[Frag_Airshot], client
					, Frag_Type[Frag_MidAir], client);
				}
			}
		}
		/* Airshot kill */
		else
		{
			switch(g_Player[client].fragmsg.Headshot)
			{
				/* Airshot headshot kill */
				case true:
				{
					Format(buffer, sizeof(buffer), "%T{default}"
					, Frag_Type[Frag_Headshot], client
					, Frag_Type[Frag_Airshot], client);
				}
				/* Airshot kill */
				case false:
				{
					Format(buffer, sizeof(buffer), "%T{default}"
					, Frag_Type[Frag_Airshot], client);
				}
			}
		}
	}
	/* Backstab kill */
	else if(g_Player[client].fragmsg.Backstab)
	{
		switch(g_Player[client].fragmsg.MidAir)
		{
			/* Mid air backstab kill */
			case true:
			{
				Format(buffer, sizeof(buffer), "%T{default} %T{default}"
				, Frag_Type[Frag_Backstab], client
				, Frag_Type[Frag_MidAir], client);
			}
			/* backstab kill */
			case false:
			{
				Format(buffer, sizeof(buffer), "%T{default}"
				, Frag_Type[Frag_Backstab], client);
			}
		}
	}
	/* Noscope kill */
	else if(g_Player[client].fragmsg.Noscope)
	{
		/* Noscope headshot kill */
		if(g_Player[client].fragmsg.Headshot)
		{
			/* Noscope headshot kill through smoke */
			if(g_Player[client].fragmsg.ThroughSmoke)
			{
				/* Noscope headshot through smoke whilst blinded */
				if(g_Player[client].fragmsg.Blinded)
				{
					switch(g_Player[client].fragmsg.MidAir)
					{
						/* Mid air noscope headshot kill through smoke whilst blinded */
						case true:
						{
							Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default} %T{default}"
							, Frag_Type[Frag_NoscopeHS], client
							, Frag_Type[Frag_ThroughSmoke], client
							, Frag_Type[Frag_Blinded], client
							, Frag_Type[Frag_MidAir], client);
						}
						/* Noscope headshot through smoke whilst blinded */
						case false:
						{
							Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
							, Frag_Type[Frag_NoscopeHS], client
							, Frag_Type[Frag_ThroughSmoke], client
							, Frag_Type[Frag_Blinded], client);
						}
					}
				}
				/* Noscope headshot kill through smoke */
				else
				{
					switch(g_Player[client].fragmsg.MidAir)
					{
						/* Mid air noscope headshot kill through smoke */
						case true:
						{
							Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
							, Frag_Type[Frag_NoscopeHS], client
							, Frag_Type[Frag_ThroughSmoke], client
							, Frag_Type[Frag_MidAir], client);
						}
						/* Noscope headshot kill through smoke */
						case false:
						{
							Format(buffer, sizeof(buffer), "%T{default} %T{default}"
							, Frag_Type[Frag_NoscopeHS], client
							, Frag_Type[Frag_ThroughSmoke], client);
						}
					}
				}
			}
			/* Noscope headshot kill */
			else
			{
				switch(g_Player[client].fragmsg.MidAir)
				{
					/* Mid air noscope headshot */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default}"
						, Frag_Type[Frag_NoscopeHS], client
						, Frag_Type[Frag_MidAir], client);
					}
					/* Noscope headshot kill */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default}"
						, Frag_Type[Frag_NoscopeHS], client);
					}
				}

			}
		}
		/* Mid air noscope kill */
		else if(g_Player[client].fragmsg.MidAir)
		{
			/* Mid air noscope kill through smoke */
			if(g_Player[client].fragmsg.ThroughSmoke)
			{
				switch(g_Player[client].fragmsg.Blinded)
				{
					/* Mid air noscope kill through smoke whilst blinded */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Noscope], client
						, Frag_Type[Frag_ThroughSmoke], client
						, Frag_Type[Frag_Blinded], client
						, Frag_Type[Frag_MidAir], client);
					}
					/* Mid air noscope kill through smoke */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Noscope], client
						, Frag_Type[Frag_ThroughSmoke], client
						, Frag_Type[Frag_MidAir], client);
					}
				}
			}
			/* Mid air headshot kill */
			else
			{
				switch(g_Player[client].fragmsg.Blinded)
				{
					/* Mid air noscope headshot kill while blinded */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
						, Frag_Type[Frag_NoscopeHS], client
						, Frag_Type[Frag_Blinded], client
						, Frag_Type[Frag_MidAir], client);
					}
					/* Mid air noscope headshot kill */
					case false:
					{
						Format(buffer, sizeof(buffer), "%t{default} %t{default}"
						, Frag_Type[Frag_NoscopeHS], client
						, Frag_Type[Frag_MidAir], client);
					}
				}
			}
		}
		/* Noscope kill */
		else
		{
			/* Noscope kill through smoke */
			if(g_Player[client].fragmsg.ThroughSmoke)
			{
				switch(g_Player[client].fragmsg.Blinded)
				{
					/* Noscope kill through smoke while blinded */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Noscope], client
						, Frag_Type[Frag_ThroughSmoke], client
						, Frag_Type[Frag_Blinded], client);
					}
					/* Noscope kill through smoke */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default}"
						, Frag_Type[Frag_Noscope], client
						, Frag_Type[Frag_ThroughSmoke], client);
					}
				}
			}
			/* Noscope kill */
			else
			{
				switch(g_Player[client].fragmsg.Blinded)
				{
					/* Noscope kill whilst blinded */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %t{default}"
						, Frag_Type[Frag_Noscope], client
						, Frag_Type[Frag_Blinded], client);
					}
					/* Noscope kill */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default}"
						, Frag_Type[Frag_Noscope], client);
					}
				}
			}
		}
	}
	/* Headshot kill */
	else if(g_Player[client].fragmsg.Headshot)
	{
		/* Headshot kill through smoke */
		if(g_Player[client].fragmsg.ThroughSmoke)
		{
			/* Headshot through smoke whilst blinded */
			if(g_Player[client].fragmsg.Blinded)
			{
				switch(g_Player[client].fragmsg.MidAir)
				{
					/* Mid air headshot kill through smoke whilst blinded */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_ThroughSmoke], client
						, Frag_Type[Frag_Blinded], client
						, Frag_Type[Frag_MidAir], client);
					}
					/* Headshot through smoke whilst blinded */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_ThroughSmoke], client
						, Frag_Type[Frag_Blinded], client);
					}
				}
			}
			/* Headshot kill through smoke */
			else
			{
				switch(g_Player[client].fragmsg.MidAir)
				{
					/* Mid air headshot kill through smoke */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_ThroughSmoke], client
						, Frag_Type[Frag_MidAir], client);
					}
					/* Headshot kill through smoke */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_ThroughSmoke], client);
					}
				}
			}
		}
		/* Mid air headshot kill */
		else if(g_Player[client].fragmsg.MidAir)
		{
			/* Mid air headshot kill through smoke */
			if(g_Player[client].fragmsg.ThroughSmoke)
			{
				switch(g_Player[client].fragmsg.Blinded)
				{
					/* Mid air headshot kill through smoke whilst blinded */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_ThroughSmoke], client
						, Frag_Type[Frag_Blinded], client
						, Frag_Type[Frag_MidAir], client);
					}
					/* Mid air headshot kill through smoke */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_ThroughSmoke], client
						, Frag_Type[Frag_MidAir], client);
					}
				}
			}
			/* Mid air headshot kill */
			else
			{
				switch(g_Player[client].fragmsg.Blinded)
				{
					/* Mid air headshot kill while blinded */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_Blinded], client
						, Frag_Type[Frag_MidAir], client);
					}
					/* Mid air headshot kill */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_MidAir], client);
					}
				}
			}
		}
		/* Headshot kill */
		else
		{
			/* Headshot kill through smoke */
			if(g_Player[client].fragmsg.ThroughSmoke)
			{
				switch(g_Player[client].fragmsg.Blinded)
				{
					/* Headshot kill through smoke while blinded */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_ThroughSmoke], client
						, Frag_Type[Frag_Blinded], client);
					}
					/* Headshot kill through smoke */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_ThroughSmoke], client);
					}
				}
			}
			/* Headshot kill */
			else
			{
				switch(g_Player[client].fragmsg.Blinded)
				{
					/* Headshot kill whilst blinded */
					case true:
					{
						Format(buffer, sizeof(buffer), "%T{default} %T{default}"
						, Frag_Type[Frag_Headshot], client
						, Frag_Type[Frag_Blinded], client);
					}
					/* Headshot kill */
					case false:
					{
						Format(buffer, sizeof(buffer), "%T{default}"
						, Frag_Type[Frag_Headshot], client);
					}
				}
			}
		}
	}
	/* Telefrag */
	else if(g_Player[client].fragmsg.TeleFrag)
	{
		Format(buffer, sizeof(buffer), "%T{default}"
		, Frag_Type[Frag_TeleFrag], client);
	}
	/* Taunt Kill */
	else if(g_Player[client].fragmsg.TauntFrag)
	{
		Format(buffer, sizeof(buffer), "%T{default}"
		, Frag_Type[Frag_TauntFrag], client);
	}
	/* Grenade Frag */
	else if(g_Player[client].fragmsg.Grenade)
	{
		Format(buffer, sizeof(buffer), "%T{default}"
		, Frag_Type[Frag_Grenade], client);
	}
	/* Bomb Kill */
	else if(g_Player[client].fragmsg.Bomb)
	{
		Format(buffer, sizeof(buffer), "%T{default}"
		, Frag_Type[Frag_Bomb], client);
	}
	/* Blinded Kill */
	else if(g_Player[client].fragmsg.Blinded)
	{
		switch(g_Player[client].fragmsg.MidAir)
		{
			/* Mid air blinded kill */
			case true:
			{
				Format(buffer, sizeof(buffer), "%T{default} %T{default}"
				, Frag_Type[Frag_Blinded], client
				, Frag_Type[Frag_MidAir], client);
			}
			/* Blinded kill */
			case false:
			{
				Format(buffer, sizeof(buffer), "%T{default}"
				, Frag_Type[Frag_Blinded], client);
			}
		}
	}
	/* Mid air kill */
	else if(g_Player[client].fragmsg.MidAir)
	{
		Format(buffer, sizeof(buffer), "%T{default}"
		, Frag_Type[Frag_MidAir], client);
	}
	
	switch(strlen(buffer) > 0)
	{
		case false:
		{
			char str_counter[12];
			if(frags > 4)
			{
				Format(str_counter, sizeof(str_counter), "%T", "#SMStats_Counter", client, frags);
			}
			
			CPrintToChat(client, "%s %T%s"
			, g_ChatTag
			, "#SMStats_FragEvent_Default", client
			, g_Player[client].name
			, g_Player[client].points-points
			, points
			, victim
			, (strlen(str_counter) > 0) ? str_counter : "");
		}
		case true:
		{
			if(frags > 4)
			{
				Format(buffer, sizeof(buffer), "%s%T", buffer, "#SMStats_Counter", client, frags);
			}
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_FragEvent_Special", client
			, g_Player[client].name
			, g_Player[client].points-points
			, points
			, victim
			, buffer);
		}
	}
	
	g_Player[client].fragmsg.Reset();
}

//

/*
 * Same as CPrintToChatAll() but uses player entity while() loop instead of for() loop.
 * More efficient and faster.
 */
stock void CPrintToChatAll2(const char[] message, any ...)
{
	int maxlen = MAX_BUFFER_LENGTH;
	char[] msg = new char[maxlen];
	VFormat(msg, maxlen, message, 2);
	
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) != -1)
	{
		if(!IsValidClient(player))
		{
			continue;
		}
		
		CPrintToChat(player, msg);
	}
}

//

stock void Send_Player_Connected(SMStats_PlayerInfo info)
{
	int position = GetClientPosition(info.auth);
	
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) > 0)
	{
		if(IsValidClient(player))
		{
			char country_name[64];
			GeoipCountryName(player, info.ip, country_name, sizeof(country_name));
			
			CPrintToChat(player, "%s %T"
			, g_ChatTag
			, "#SMStats_Player_Connected", player
			, info.name
			, position
			, info.points
			, country_name);
		}
	}
}

stock void Send_Player_Disconnected(SMStats_PlayerInfo info, const char[] event_reason)
{
	int position = GetClientPosition(info.auth);
	
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) > 0)
	{
		if(IsValidClient(player))
		{
			char country_name[64];
			GeoipCountryName(player, info.ip, country_name, sizeof(country_name));
			
			CPrintToChat(player, "%s %T"
			, g_ChatTag
			, "#SMStats_Player_Disconnected", player
			, info.name
			, position
			, info.points
			, country_name
			, event_reason);
		}
	}
}

stock void TXNEvent_OnFailed(Database db, int userid, int numQueries, const char[] error, int failIndex, int[] queryId)
{
	PrintToServer("%s TXNEvent_OnFailed:\nQuery for '%s' (userid %i) failed\nError below:\n%s", core_chattag, g_strTXNqueryId[queryId[failIndex]], userid, error);
}

//

/**
 *	Returns the distance between 2 entities in meters.
 *	this is experimental and may be incorrect.
 *	In CS:GO, use "distance" from event "player_death" for more accurate numbers.
 *	this one is very similiar to that one but incorrect at times.
 *
 *	@param	entity		The entity index.
 *	@param	target		The target entity index.
 *
 *	@error	If the entity we use or the one we compare with is invalid, this returns -1.0.
 */
stock float GetEntityDistance(int entity, int target)
{
	if(IsValidEntity(entity) && IsValidEntity(target))
	{
		float pos[2][3];
		GetEntPropVector(entity, Prop_Send, "m_vecOrigin", pos[0]);
		GetEntPropVector(target, Prop_Send, "m_vecOrigin", pos[1]);
		
		//return ((pos[0][0] / pos[1][0]) * 5);
		return (GetVectorDistance(pos[1], pos[0]) / 41.0);
	}
	
	return -1.0;
}

/*
 *	Returns wheter the user is inside a smoke.
 *	Used as alternative for CS:S (Counter-Strike: Source) since 'thru_smoke'
 *	is only available to CS:GO (Counter-Strike: Global Offensive) in 'player_death' event.
 *
 *	@param	client	The users index.
 */
stock bool CS_IsClientInSmoke(int client)
{
	int env_particlesmokegrenade = 0;
	
	while((env_particlesmokegrenade = FindEntityByClassname(env_particlesmokegrenade, "env_particlesmokegrenade")) > 0)
	{
		float distance = GetEntityDistance(client, env_particlesmokegrenade);
		
		if(distance <= 3.0)
		{
			return true;
		}
	}
	
	return false;
}

//

stock void UpdatePlayerName(int client)
{
	if(IsValidClient(client, !bAllowBots ? true : false))
	{
		GetPlayerName(client, g_Player[client].name, sizeof(g_Player[].name));
	}
}

/*
 * Returns the developer role.
 */
stock int IsValidDeveloperType(const char[] auth)
{
	if(StrContains(auth, "29639718") != -1)
	{
		return 1; // founder
	}
	//else if(StrContains(auth, "example") != -1)
	//{
	//	return 2; // developer
	//}
	
	return false;
}

//

stock void GetPlayTimeFormat(int client, int minutes, char[] buffer, int maxlen)
{
	
}

stock void GetLastConnectedFormat(int client, int last_connected, char[] time_format, int maxlen)
{
	Format(time_format, maxlen, "%T", "#SMStats_TimeFormat_LastConnected", client);
	
	int year, month, day, hour, minute, second;
	UnixToTime(last_connected, year, month, day, hour, minute, second, UT_TIMEZONE_SERVER);
	
	/*
	PrintToServer("LastConnect converted:"
	... "\nUNIX : %i"
	... "\nYear : %i"
	... "\nDays : %i"
	... "\nHour : %i"
	... "\nMins : %i"
	... "\nSecs : %i"
	, last_connected, year, month, day, hour, minute, second);
	*/
	
	if(StrContains(time_format, "{YEAR}") != -1)
	{
		char dummy[11];
		Format(dummy, sizeof(dummy), "%02d", year);
		ReplaceString(time_format, maxlen, "{YEAR}", dummy);
	}
	if(StrContains(time_format, "{MONTH}") != -1)
	{
		char dummy[11];
		Format(dummy, sizeof(dummy), "%02d", month);
		ReplaceString(time_format, maxlen, "{MONTH}", dummy);
	}
	if(StrContains(time_format, "{DAY}") != -1)
	{
		char dummy[11];
		Format(dummy, sizeof(dummy), "%02d", day);
		ReplaceString(time_format, maxlen, "{DAY}", dummy);
	}
	if(StrContains(time_format, "{AM_PM}") != -1)
	{
		char am_pm[64];
		Format(am_pm, sizeof(am_pm), "%T", "#SMStats_TimeFormat_AM_PM", client);
		
		if(StrContains(am_pm, "#|#") != -1)
		{
			bool PM = (hour >= 12);
			char dummy[2][11];
			ExplodeString(am_pm, "#|#", dummy, sizeof(dummy), 11);
			
			if(!PM)
			{
				ReplaceString(dummy[0], sizeof(dummy[]), "#|#", "");
			}
			
			ReplaceString(time_format, maxlen, "{AM_PM}", dummy[view_as<int>(PM)]);
		}
	}
	if(StrContains(time_format, "{12HOUR}") != -1)
	{
		if(hour > 12)
		{
			hour = hour-12;
		}
		
		char dummy[11];
		Format(dummy, sizeof(dummy), "%02d", hour);
		ReplaceString(time_format, maxlen, "{12HOUR}", dummy);
	}
	if(StrContains(time_format, "{24HOUR}") != -1)
	{
		char dummy[11];
		Format(dummy, sizeof(dummy), "%02d", hour);
		ReplaceString(time_format, maxlen, "{24HOUR}", dummy);
	}
	if(StrContains(time_format, "{MINUTE}") != -1)
	{
		char dummy[11];
		Format(dummy, sizeof(dummy), "%02d", minute);
		ReplaceString(time_format, maxlen, "{MINUTE}", dummy);
	}
	if(StrContains(time_format, "{SECOND}") != -1)
	{
		char dummy[11];
		Format(dummy, sizeof(dummy), "%02d", second);
		ReplaceString(time_format, maxlen, "{SECOND}", dummy);
	}
}