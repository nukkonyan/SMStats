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

stock bool IsValidClient(int client, bool bIsFakeClient=true)
{
	if(client < 1 || client > MaxPlayers)
	{
		return false;
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
	int flags = GetClientFlags(client);
	return (flags == 256 || flags == 258 || flags == 262);
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
		char query[256];
		Format(query, sizeof(query), "select Points from `"...sql_table_playerlist..."` where SteamID = '%s' and ServerID = %i", auth, g_ServerID);
		SQL_LockDatabase(sql); // lock database as it's non-threaded.
		DBResultSet results = SQL_Query(sql, query);
		SQL_UnlockDatabase(sql);
		
		switch(!!results && results.FetchRow())
		{
			case false:
			{
				char error[256];
				SQL_GetError(sql, error, sizeof(error));
				LogError("%s GetClientPosition error: Failed retrieving points for steam auth '%s' of sql table '"...sql_table_playerlist..."' (%s)", core_chattag, auth, error);
			}
			
			case true:
			{
				int points = results.FetchInt(0);
				
				Format(query, sizeof(query), "select count(*) from `"...sql_table_playerlist..."` where Points >= %i and ServerID = %i", points, g_ServerID);
				SQL_LockDatabase(sql);
				results = SQL_Query(sql, query);
				SQL_UnlockDatabase(sql);
				
				switch(!!results)
				{
					case false:
					{
						char error[256];
						SQL_GetError(sql, error, sizeof(error));
						LogError("%s GetClientPosition error: Failed retrieving position for steam auth '%s' of sql table '"...sql_table_playerlist..."' (%s)", core_chattag, auth, error);
					}
					case true:
					{
						while(results.FetchRow())
						{
							position = results.FetchInt(0);
						}
					}
				}
			}
		}
		
		delete results;
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
		char query[256];
		Format(query, sizeof(query), "select * from `"...sql_table_playerlist..."` where ServerID = %i", g_ServerID);
		
		SQL_LockDatabase(sql);
		DBResultSet results = SQL_Query(sql, query);
		SQL_UnlockDatabase(sql);
		
		switch(!!results)
		{
			case false:
			{
				char error[256];
				SQL_GetError(sql, error, sizeof(error));
				LogError("%s GetTablePlayerCount error: Failed getting playercount of sql table '"...sql_table_playerlist..."' (%s)", core_chattag, error);
			}
			case true: players = results.RowCount;
		}
		
		delete results;
	}
	
	return players;
}

/* ============================================================== */

stock int GetPlayerCount(bool count_bots=false)
{
	int count, player = 0;
	while((player = FindEntityByClassname(player, "player")) != -1)
	{
		if(IsValidClient(player, !count_bots))
		{
			count++;
		}
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
	_sm_stats_info_update_round_active(true);
	
	if((bWarmupActive = IsWarmupActive()) && !bAllowWarmup)
	{
		int player = 0;
		while((player = FindEntityByClassname(player, "player")) != -1)
		{
			if(IsValidClient(player))
			{
				CPrintToChat(player, "%s %T", g_ChatTag, "#SMStats_RoundStart_Warmup", player);
			}
		}
		return;
	}
	
	if(bDisableAfterRoundEnd)
	{
		int needed = g_MinPlayers;
		int players = GetPlayerCount(bAllowBots);
		
		if(needed <= players)
		{
			bStatsActive = true;
			
			int player = 0;
			while((player = FindEntityByClassname(player, "player")) != -1)
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
	_sm_stats_info_update_round_active(false);
	
	if((bWarmupActive = IsWarmupActive()) && !bAllowWarmup)
	{
		return;
	}
	
	if(bDisableAfterRoundEnd)
	{
		bStatsActive = false;
		
		int player = 0;
		while((player = FindEntityByClassname(player, "player")) != -1)
		{
			if(IsValidClient(player))
			{
				CPrintToChat(player, "%T", "#SMStats_RoundEnd", player);
			}
		}
	}
}

void CheckActivePlayers()
{
	int players = GetPlayerCount(bAllowBots);
	
	switch(bStatsActive)
	{
		case false:
		{
			if(players >= g_MinPlayers && bRoundActive)
			{
				bStatsActive = true;
				_sm_stats_info_update_stats_active(true);
				
				int player = 0;
				while((player = FindEntityByClassname(player, "player")) != -1)
				{
					if(IsValidClient(player))
					{
						CPrintToChat(player, "%s %T"
						, g_ChatTag
						, "#SMStats_EnoughPlayers", player
						, players
						, g_MinPlayers);
					}
				}
			}
		}
		
		case true:
		{
			if(players < g_MinPlayers)
			{
				bStatsActive = false;
				_sm_stats_info_update_stats_active(false);
				
				int player = 0;
				while((player = FindEntityByClassname(player, "player")) != -1)
				{
					if(IsValidClient(player))
					{
						CPrintToChat(player, "%s %T"
						, g_ChatTag
						, "#SMStats_NotEnoughPlayers", player
						, players
						, g_MinPlayers);
					}
				}
			}
		}
	}
	
	if(DEBUG) PrintToServer("CheckActivePlayers() : %i players out of required %i"
	... "\n bStatsActive : %s"
	... "\n bRoundActive : %s"
	, players, g_MinPlayers
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
		if(!bAllowWarmup)
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

stock void GetMultipleTargets(int client, const int[] list, int counter, char[] dummy, int maxlen)
{
	if(counter == 1)
	{
		int userid = list[0];
		int target = GetClientOfUserId(userid);
		strcopy(dummy, maxlen, g_Player[target].name);
	}
	else if(counter == 2)
	{
		int userid1 = list[0];
		int target1 = GetClientOfUserId(userid1);
		
		int userid2 = list[1];
		int target2 = GetClientOfUserId(userid2);
		
		Format(dummy, maxlen, "%s%T%s%T", g_Player[target1].name, "#SMStats_And", client, g_Player[target2].name, "#SMStats_Counter", client, counter);
	}
	else if(counter > 2 && counter < 4)
	{
		for(int i = 0; i < counter-1; i++)
		{
			int userid = list[i];
			int target = GetClientOfUserId(userid);
			
			if(dummy[0] != '\0')
			{
				Format(dummy, maxlen, "%s%T", dummy, "#SMStats_Comma", client);
			}
			
			Format(dummy, maxlen, "%s%s", dummy, g_Player[target].name);
		}
		
		int target = GetClientOfUserId(list[counter-1]);
		Format(dummy, maxlen, "%s%T%s%T", dummy, "#SMStats_And", client, g_Player[target].name, "#SMStats_Counter", client, counter);
		// outputs the "and last player".
	}
	else
	{
		Format(dummy, maxlen, "%T", "#SMStats_MultiplePlayers", client);
	}
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
	Frag_Taunt = 9,
	Frag_PumpkinBomb = 10,
	Frag_Collateral = 11,
	Frag_Grenade = 12,
	Frag_Bomb = 13,
	Frag_Blinded = 14,
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
/*10*/"#SMStats_FragEvent_Type10", //Pumpkin Bomb frag.
/*11*/"#SMStats_FragEvent_Type11", //Collateral.
/*12*/"#SMStats_FragEvent_Type12", //Grenade frag.
/*13*/"#SMStats_FragEvent_Type13", //Bomb frag.
/*14*/"#SMStats_FragEvent_Type14", //Blinded frag.
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
						Format(buffer, sizeof(buffer), "%T{default} %T{default}"
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
						Format(buffer, sizeof(buffer), "%T{default} %T{default}"
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
	else if(g_Player[client].fragmsg.Taunt)
	{
		Format(buffer, sizeof(buffer), "%T{default}"
		, Frag_Type[Frag_Taunt], client);
	}
	/* Pumpkin Bomb Frag */
	else if(g_Player[client].fragmsg.PumpkinBomb)
	{
		Format(buffer, sizeof(buffer), "%T{default}"
		, Frag_Type[Frag_PumpkinBomb], client);
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
	
	char points_plural[32];
	PointsPluralSplitter(client, points, points_plural, sizeof(points_plural));
	
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
			, points_plural
			, victim
			, (frags > 4) ? str_counter : "");
		}
		case true:
		{
			if(frags >= 4)
			{
				Format(buffer, sizeof(buffer), "%s%T", buffer, "#SMStats_Counter", client, frags);
			}
			
			CPrintToChat(client, "%s %T"
			, g_ChatTag
			, "#SMStats_FragEvent_Special", client
			, g_Player[client].name
			, g_Player[client].points-points
			, points_plural
			, victim
			, buffer);
		}
	}
	
	g_Player[client].fragmsg.Reset();
}

stock void PointsPluralSplitter(int client, int points, char[] translation, int maxlen)
{
	char fmt_plural[64];
	Format(fmt_plural, sizeof(fmt_plural), "%T", "#SMStats_Points_PluralSplitter", client);
	switch(StrContains(fmt_plural, "#|#") != -1)
	{
		// this language defies the 'point' and 'points' with one word as both singular and plural.
		case false:
		{
			Format(translation, maxlen, "%i%s", points, fmt_plural);
		}
		// this language defies the 'point' and 'points' with one word as inflection-based singular and plural.
		case true:
		{
			bool bPlural = (points < -1 || points > 1);
			char szPlural[2][16];
			if(ExplodeString(fmt_plural, "#|#", szPlural, sizeof(szPlural), 16) == 2)
			{
				ReplaceString(szPlural[0], sizeof(szPlural[]), "#|#", "");
			}
			Format(translation, maxlen, "%i%s", points, szPlural[view_as<int>(bPlural)]);
		}
	}
}

stock void OnOffPluralSplitter(int client, bool OffOn, char[] translation, int maxlen)
{
	char fmt_onoff_plural[24]
	Format(fmt_onoff_plural, sizeof(fmt_onoff_plural), "%T", "#SMStats_OffOn", client);
	if(StrContains(fmt_onoff_plural, "#|#") != -1)
	{
		char onoff_plural[2][24];
		ExplodeString(fmt_onoff_plural, "#|#", onoff_plural, sizeof(onoff_plural), 24);
		ReplaceString(onoff_plural[0], sizeof(onoff_plural[]), "#|#", "");
		strcopy(translation, maxlen, onoff_plural[view_as<int>(OffOn)]);
	}
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

stock void Send_Player_Connected(int client)
{
	char auth[28], ip[16], name[64];
	strcopy(auth, sizeof(auth), g_Player[client].auth);
	strcopy(ip, sizeof(ip), g_Player[client].ip);
	strcopy(name, sizeof(name), g_Player[client].name);
	int points = g_Player[client].points;
	
	char query[256];
	Format(query, sizeof(query), "select `SteamID` from `"...sql_table_playerlist..."` where `ServerID`='%i'", g_ServerID);
	DataPack pack = new DataPack();
	pack.WriteCell(points);
	pack.WriteCell(strlen(auth)+1);
	pack.WriteString(auth);
	pack.WriteCell(strlen(ip)+1);
	pack.WriteString(ip);
	pack.WriteCell(strlen(name)+1);
	pack.WriteString(name);
	pack.Reset();
	sql.Query(DBQuery_Send_Player_Connected, query, pack);
}

stock void DBQuery_Send_Player_Connected(Database database, DBResultSet results, const char[] error, DataPack pack)
{
	int points = pack.ReadCell();
	
	int maxlen1 = pack.ReadCell();
	char[] auth = new char[maxlen1];
	pack.ReadString(auth, maxlen1);
	
	int maxlen2 = pack.ReadCell();
	char[] ip = new char[maxlen2];
	pack.ReadString(ip, maxlen2);
	
	int maxlen3 = pack.ReadCell();
	char[] name = new char[maxlen3];
	pack.ReadString(name, maxlen3);
	
	delete pack;
	
	//
	
	if(results == null)
	{
		return;
	}
	
	int position = 0;
	while(results.FetchRow())
	{
		position++;
		
		char row_auth[28];
		results.FetchString(0, row_auth, sizeof(row_auth));
		
		if(StrEqual(row_auth, auth))
		{
			break;
		}
	}
	
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) != -1)
	{
		if(IsValidClient(player))
		{
			if(g_Player[player].bShowConMsg)
			{
				char country_name[64], points_plural[32];
				GeoipCountryName(player, ip, country_name, sizeof(country_name));
				PointsPluralSplitter(player, points, points_plural, sizeof(points_plural));
				
				CPrintToChat(player, "%s %T"
				, g_ChatTag
				, "#SMStats_Player_Connected", player
				, name
				, position
				, points_plural
				, country_name);
			}
		}
	}
}

stock void Send_Player_Connected_CheckTop10(int client)
{
	int position;
	if((position = g_Player[client].position) < 1)
	{
		PrintToServer("%s Send_Player_Connected_CheckTop10 : client index %i have invalid position %i", core_chattag, client, position);
		return;
	}
	
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) != -1)
	{
		if(IsValidClient(player))
		{
			if(g_Player[player].bPlayConSnd)
			{
				if(position == 1)
				{
					if(strlen(g_sndConnectedTop1) > 0)
					{
						EmitSoundToClient(player, g_sndConnectedTop1, _, _, SNDLEVEL_LIBRARY);
					}
				}
				else if(position <= 10)
				{
					if(strlen(g_sndConnectedTop10) > 0)
					{
						EmitSoundToClient(player, g_sndConnectedTop10, _, _, SNDLEVEL_LIBRARY);
					}
				}
				else
				{
					if(strlen(g_sndConnectedGeneric) > 0)
					{
						EmitSoundToClient(player, g_sndConnectedGeneric, _, _, SNDLEVEL_RUSTLE);
					}
				}
			}
			
			if(position >= 1 && position <= 10)
			{
				if(g_Player[player].bShowTopConMsg)
				{
					char country_name[64];
					GeoipCountryName(player, g_Player[client].ip, country_name, sizeof(country_name));
					CPrintToChat(player, "%s %T"
					, g_ChatTag
					, "#SMStats_Player_Connected_TopPlayer", player
					, g_Player[client].position
					, g_Player[client].name
					, country_name);
				}
			}
		}
	}
}

stock void Send_Player_Disconnected(int client, const char[] event_reason)
{
	char auth[28], ip[16], name[64];
	strcopy(auth, sizeof(auth), g_Player[client].auth);
	strcopy(ip, sizeof(ip), g_Player[client].ip);
	strcopy(name, sizeof(name), g_Player[client].name);
	
	char query[256];
	Format(query, sizeof(query), "select `SteamID`,`Points` from `"...sql_table_playerlist..."` where `ServerID`='%i'", g_ServerID);
	DataPack pack = new DataPack();
	pack.WriteCell(strlen(auth)+1);
	pack.WriteString(auth);
	pack.WriteCell(strlen(ip)+1);
	pack.WriteString(ip);
	pack.WriteCell(strlen(name)+1);
	pack.WriteString(name);
	pack.WriteCell(strlen(event_reason)+1);
	pack.WriteString(event_reason);
	pack.Reset();
	sql.Query(DBQuery_Send_Player_Disconnected, query, pack);
}

stock void DBQuery_Send_Player_Disconnected(Database database, DBResultSet results, const char[] error, DataPack pack)
{
	int maxlen1 = pack.ReadCell();
	char[] auth = new char[maxlen1];
	pack.ReadString(auth, maxlen1);
	
	int maxlen2 = pack.ReadCell();
	char[] ip = new char[maxlen2];
	pack.ReadString(ip, maxlen2);
	
	int maxlen3 = pack.ReadCell();
	char[] name = new char[maxlen3];
	pack.ReadString(name, maxlen3);
	
	int maxlen4 = pack.ReadCell();
	char[] event_reason = new char[maxlen4];
	pack.ReadString(event_reason, maxlen4);
	
	delete pack;
	
	//
	
	if(results == null)
	{
		return;
	}
	
	int position = 0;
	int points = 0;
	while(results.FetchRow())
	{
		position++;
		
		char row_auth[28];
		results.FetchString(0, row_auth, sizeof(row_auth));
		
		if(StrEqual(row_auth, auth))
		{
			points = results.FetchInt(1);
			break;
		}
	}
	
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) > 0)
	{
		if(IsValidClient(player))
		{
			if(g_Player[player].bShowConMsg)
			{
				char country_name[64], points_plural[32];
				GeoipCountryName(player, ip, country_name, sizeof(country_name));
				PointsPluralSplitter(player, points, points_plural, sizeof(points_plural));
				
				CPrintToChat(player, "%s %T"
				, g_ChatTag
				, "#SMStats_Player_Disconnected", player
				, name
				, position
				, points_plural
				, country_name
				, event_reason);
			}
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
 * 1 - owner & founder.
 * 2 - contributor.
 * 3 - tester.
 * 4 - translator.
 */
stock int IsValidDeveloperType(int client)
{
	//char profile_id[24]; // safest way to check
	//GetClientAuthId(client, AuthId_SteamID64, profile_id, sizeof(profile_id));
	
	// founder and creator.
	if(StrEqual(g_Player[client].profileid, "76561198019545164"))
	{
		return 1;
	}
	
	// contributor
	
	// tester
	
	// translator
	if(StrEqual(g_Player[client].profileid, "76561197962831152")) // Neigeflocon
	{
		return 4;
	}
	
	return -1;
}

// time formats, these needs to be fixed and corrected.

stock int TimeFormat_ConvertSeconds(int seconds)
{
	int minutes = ( seconds / 60 );
	int minutes_sec = ( seconds - ( minutes * 60 ) );
	
	if(minutes_sec < 1)
	{
		minutes_sec = 0;
	}
	
	return minutes_sec;
}
stock int TimeFormat_ConvertMinutes(int seconds)
{
	int minutes;
	
	while(seconds >= 60)
	{
		minutes++;
		seconds -= 60;
	}
	
	return minutes;
}
stock int TimeFormat_ConvertHours(int &minutes)
{
	int hours;
	
	while(minutes >= 60)
	{
		hours++;
		minutes -= 60;
	}
	
	return hours;
}
stock int TimeFormat_ConvertDays(int &hours)
{
	int days;
	
	while(hours >= 24) // temporary workaround spaghetti code.
	{
		days++;
		hours -= 24;
	}
	
	return days;
}
stock int TimeFormat_ConvertMonths(int &days)
{
	// workaround needed, cuz we need to detect correct months.
	int months;
	
	while(days >= 31)
	{
		months++;
		days -= 31;
	}
	
	return months;
}
stock int TimeFormat_ConvertYears(int &months)
{
	int years;
	
	while(months >= 12)
	{
		years++;
		months -= 12;
	}
	
	return years;
}
stock void TimeFormat_GetCountStr(int count, char[] yes, int no)
{
	IntToString(count, yes, no);
	if(strlen(yes) == 1)
	{
		Format(yes, no, "0%s", yes);
	}
}
stock void GetTimeFormat(int client, int time_seconds, char[] time_format, int maxlen)
{
	// convert seconds into Year/s Day/s Hour/s Minute/s Second/s
	
	int seconds = TimeFormat_ConvertSeconds(time_seconds);
	int minutes = TimeFormat_ConvertMinutes(time_seconds);
	int hours = TimeFormat_ConvertHours(minutes);
	int days = TimeFormat_ConvertDays(hours);
	int months = TimeFormat_ConvertMonths(days);
	int years = TimeFormat_ConvertYears(months);
	
	//PrintToServer("%i seconds %i minutes %i hours %i days", seconds, minutes, hours, days);
	
	char szYear[16];
	Format(time_format, maxlen, "%T", "#SMStats_TimeFormat_Year", client);
	switch(StrContains(time_format, "#|#") != -1)
	{
		case false: Format(szYear, sizeof(szYear), "%i%s", years, time_format);
		case true:
		{
			bool bPlural = (years < -1 || years > 1);
			char szPlural[2][16];
			if(ExplodeString(time_format, "#|#", szPlural, sizeof(szPlural), 16) == 2)
			{
				ReplaceString(szPlural[0], sizeof(szPlural[]), "#|#", "");
			}
			Format(szYear, sizeof(szYear), "%i%s", years, szPlural[view_as<int>(bPlural)]);
		}
	}
	
	char szMonth[16];
	Format(time_format, maxlen, "%T", "#SMStats_TimeFormat_Month", client);
	switch(StrContains(time_format, "#|#") != -1)
	{
		case false: Format(szMonth, sizeof(szMonth), "%i%s", months, time_format);
		case true:
		{
			bool bPlural = (months < -1 || months > 1);
			char szPlural[2][16];
			if(ExplodeString(time_format, "#|#", szPlural, sizeof(szPlural), 16) == 2)
			{
				ReplaceString(szPlural[0], sizeof(szPlural[]), "#|#", "");
			}
			Format(szMonth, sizeof(szMonth), "%i%s", months, szPlural[view_as<int>(bPlural)]);
		}
	}
	
	char szDay[16];
	Format(time_format, maxlen, "%T", "#SMStats_TimeFormat_Day", client);
	switch(StrContains(time_format, "#|#") != -1)
	{
		case false: Format(szDay, sizeof(szDay), "%i%s", days, time_format);
		case true:
		{
			bool bPlural = (days < -1 || days > 1);
			char szPlural[2][16];
			if(ExplodeString(time_format, "#|#", szPlural, sizeof(szPlural), 16) == 2)
			{
				ReplaceString(szPlural[0], sizeof(szPlural[]), "#|#", "");
			}
			Format(szDay, sizeof(szDay), "%i%s", days, szPlural[view_as<int>(bPlural)]);
		}
	}
	
	char szHour[16];
	Format(time_format, maxlen, "%T", "#SMStats_TimeFormatShort_Hour", client);
	switch(StrContains(time_format, "#|#") != -1)
	{
		case false: Format(szHour, sizeof(szHour), "%i%s", hours, time_format);
		case true:
		{
			bool bPlural = (hours < -1 || hours > 1);
			char szPlural[2][16];
			if(ExplodeString(time_format, "#|#", szPlural, sizeof(szPlural), 16) == 2)
			{
				ReplaceString(szPlural[0], sizeof(szPlural[]), "#|#", "");
			}
			Format(szDay, sizeof(szDay), "%i%s", hours, szPlural[view_as<int>(bPlural)]);
		}
	}
	
	char szMinute[16];
	Format(time_format, maxlen, "%T", "#SMStats_TimeFormatShort_Minute", client);
	switch(StrContains(time_format, "#|#") != -1)
	{
		case false: Format(szMinute, sizeof(szMinute), "%i%s", minutes, time_format);
		case true:
		{
			bool bPlural = (minutes < -1 || minutes > 1);
			char szPlural[2][16];
			if(ExplodeString(time_format, "#|#", szPlural, sizeof(szPlural), 16) == 2)
			{
				ReplaceString(szPlural[0], sizeof(szPlural[]), "#|#", "");
			}
			Format(szDay, sizeof(szDay), "%i%s", minutes, szPlural[view_as<int>(bPlural)]);
		}
	}
	
	char szSecond[16];
	Format(time_format, maxlen, "%T", "#SMStats_TimeFormatShort_Second", client);
	switch(StrContains(time_format, "#|#") != -1)
	{
		case false: Format(szSecond, sizeof(szSecond), "%i%s", seconds, time_format);
		case true:
		{
			bool bPlural = (seconds < -1 || seconds > 1);
			char szPlural[2][16];
			if(ExplodeString(time_format, "#|#", szPlural, sizeof(szPlural), 16) == 2)
			{
				ReplaceString(szPlural[0], sizeof(szPlural[]), "#|#", "");
			}
			Format(szSecond, sizeof(szSecond), "%i%s", seconds, szPlural[view_as<int>(bPlural)]);
		}
	}
	
	//
	
	if(years > 0
	&& months > 0
	&& days > 0
	&& hours > 0
	&& minutes > 0
	&& seconds >= 0)
	{
		Format(time_format, maxlen, "%T", "#SMStats_PlayTimeFormat_Scenario0", client);
		if(StrContains(time_format, "{YEARS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{YEARS}", szYear, false);
		}
		if(StrContains(time_format, "{MONTHS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{MONTHS}", szMonth, false);
		}
		if(StrContains(time_format, "{DAYS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{DAYS}", szDay, false);
		}
		if(StrContains(time_format, "{HOURS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{HOURS}", szHour, false);
		}
		if(StrContains(time_format, "{MINUTES}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{MINUTES}", szMinute, false);
		}
		if(StrContains(time_format, "{SECONDS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{SECONDS}", szSecond, false);
		}
	} else
	if(months > 0
	&& days > 0
	&& hours > 0
	&& minutes > 0
	&& seconds >= 0)
	{
		Format(time_format, maxlen, "%T", "#SMStats_PlayTimeFormat_Scenario1", client);
		if(StrContains(time_format, "{MONTHS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{MONTHS}", szMonth, false);
		}
		if(StrContains(time_format, "{DAYS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{DAYS}", szDay, false);
		}
		if(StrContains(time_format, "{HOURS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{HOURS}", szHour, false);
		}
		if(StrContains(time_format, "{MINUTES}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{MINUTES}", szMinute, false);
		}
		if(StrContains(time_format, "{SECONDS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{SECONDS}", szSecond, false);
		}
	} else
	if(days > 0
	&& hours > 0
	&& minutes > 0
	&& seconds >= 0)
	{
		Format(time_format, maxlen, "%T", "#SMStats_PlayTimeFormat_Scenario2", client);
		if(StrContains(time_format, "{DAYS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{DAYS}", szDay, false);
		}
		if(StrContains(time_format, "{HOURS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{HOURS}", szHour, false);
		}
		if(StrContains(time_format, "{MINUTES}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{MINUTES}", szMinute, false);
		}
		if(StrContains(time_format, "{SECONDS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{SECONDS}", szSecond, false);
		}
	}
	else
	if(hours > 0
	&& minutes > 0
	&& seconds >= 0)
	{
		Format(time_format, maxlen, "%T", "#SMStats_PlayTimeFormat_Scenario3", client);
		if(StrContains(time_format, "{HOURS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{HOURS}", szHour, false);
		}
		if(StrContains(time_format, "{MINUTES}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{MINUTES}", szMinute, false);
		}
		if(StrContains(time_format, "{SECONDS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{SECONDS}", szSecond, false);
		}
	}
	else
	if(minutes > 0
	&& seconds >= 0)
	{
		Format(time_format, maxlen, "%T", "#SMStats_PlayTimeFormat_Scenario4", client);
		if(StrContains(time_format, "{MINUTES}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{MINUTES}", szMinute, false);
		}
		if(StrContains(time_format, "{SECONDS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{SECONDS}", szSecond, false);
		}
	}
	else
	{
		Format(time_format, maxlen, "%T", "#SMStats_PlayTimeFormat_Scenario5", client);
		if(StrContains(time_format, "{SECONDS}", false) != -1)
		{
			ReplaceString(time_format, maxlen, "{SECONDS}", szSecond, false);
		}
	}
	
	//PrintToServer(time_format);
}

stock void GetLastConnectedFormat(int client, char[] timezone_ip, int last_connected, char[] time_format, int maxlen)
{
	Format(time_format, maxlen, "%T", "#SMStats_TimeFormat_LastConnected", client);
	
	int timezone = UT_TIMEZONE_SERVER;
	char str_timezone[32];
	switch(GeoipTimezone(timezone_ip, str_timezone, sizeof(str_timezone)))
	{
		case false:
		{
			PrintToServer("%s GetLastConnectedFormat() Error: Failed to get timezone, using server timezone instead.", core_chattag);
		}
		case true:
		{
			// we need a way to convert the time to the clients timezone.
			//PrintToServer("%s GetLastConnectedFormat() Timezone : %s", core_chattag, str_timezone);
		}
	}
	
	int year, month, day, hour, minute, second;
	UnixToTime(last_connected, year, month, day, hour, minute, second, timezone);
	
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
			hour -= hour-12;
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

//

stock int SecondsCheckPenalty(int timestamp)
{
	int time = timestamp - GetTime();
	return time - 60 * (time / 60);
}

//

stock int GetFieldValue(DBResultSet results, char[] field_name)
{
	int field;
	if(results.FieldNameToNum(field_name, field))
	{
		return results.FetchInt(field);
	}
	
	return -2;
}

stock bool GetFieldBoolValue(DBResultSet results, char[] field_name)
{
	int field;
	if(results.FieldNameToNum(field_name, field))
	{
		return view_as<bool>(results.FetchInt(field));
	}
	
	return false;
}

stock int GetFieldString(DBResultSet results, char[] field_name, char[] output, int maxlen)
{
	int field;
	if(results.FieldNameToNum(field_name, field))
	{
		return results.FetchString(field, output, maxlen);
	}
	
	return -2;
}