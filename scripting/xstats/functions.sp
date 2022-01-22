/**
 *	Returns the amount of points a player has.
 *
 *	@param	auth	The players steam authentication id.
 */
stock int GetClientPoints(const char[] auth)	{
	int points = 0;
	Database database = SQL_Connect2(Xstats, false);
	
	if(database != null)	{
		DBResultSet results = SQL_QueryEx(database, "select Points from `%s` where SteamID='%s' and ServerID='%i'", playerlist, auth, ServerID.IntValue);
		points = (results != null && results.FetchRow()) ? results.FetchInt(0) : 0;
		delete results;
	}
	
	delete database;
	return points;
}

/**
 *	Returns the position of the player.
 *
 *	@param	auth	The players steam authentication id.
 */
stock int GetClientPosition(const char[] auth)	{
	int position = 0;
	int points = 0;
	Database database = SQL_Connect2(Xstats, false);
	
	if(database != null)	{
		DBResultSet results = SQL_QueryEx(database, "select Points from `%s` where SteamID='%s' and ServerID='%i'", playerlist, auth, ServerID.IntValue);
		while(results != null && results.FetchRow())	{
			points = results.FetchInt(0);
			
			results = SQL_QueryEx(database, "select count(*) from `%s` where Points >='%i' and ServerID='%i'", playerlist, points, ServerID.IntValue);
			while(results.FetchRow())
				position = results.FetchInt(0);
		}
		
		delete results;
	}
	
	delete database;
	return position;
}

/**
 *	Returns the total player count in a database table.
 */
stock int GetTablePlayerCount()	{
	int playercount = 0;
	Database database = SQL_Connect2(Xstats, false);
	
	if(database != null)	{
		DBResultSet results = SQL_QueryEx(database, "select count(*) from `%s` where ServerID='%i'", playerlist, ServerID.IntValue);
		while(results != null && results.FetchRow())
			playercount = results.FetchInt(0);
		
		delete results;
	}
	
	delete database;
	return playercount;
}

/**
 *	Returns the amount of playtime in minutes a player has.
 *
 *	@param	auth	The players steam authentication id.
 */
stock int GetClientPlayTime(const char[] auth)	{
	int playtime = 0;
	Database database = SQL_Connect2(Xstats, false);
	
	if(database != null)	{
		DBResultSet results = SQL_QueryEx(database, "select PlayTime from `%s` where SteamID='%s' and ServerID='%i'", playerlist, auth, ServerID.IntValue);
		playtime = (results != null && results.FetchRow()) ? results.FetchInt(0) : 0;
		delete results;
	}
	
	delete database;
	return playtime;
}

/**
 *	Returns the KDR (Kill-Death-Ratio)
 *
 *	@param	kills	The kill count to check.
 *	@param	deaths	The death count to check.
 *	@param	assists	The assist count to check.
 */
stock float GetKDR(int kills, int deaths, int assists)	{
	float kdr = 1.00;
	float fkills = float(kills);
	float fdeaths = float(deaths);
	float fassists = float(assists);
	
	fkills = fkills + (fassists / 2.0);
	
	if(Debug.BoolValue)	{
		PrintToServer("//===== GetKDR =====//");
		PrintToServer("kills: %i", kills);
		PrintToServer("deaths: %i", deaths);
		PrintToServer("assists: %i", assists);
		PrintToServer("fkills: %.2f", float(kills));
		PrintToServer("fkills = fkills + (fassists / 2.0): %.2f", fkills);
		PrintToServer("fdeaths: %.2f", fdeaths);
		PrintToServer("fassists: %.2f", fassists);
	}
	
	if(fdeaths == 0.0)
		fdeaths = 1.0;
	
	if(Debug.BoolValue)
		PrintToServer("after fdeaths check: %.2f", fdeaths);
	
	kdr = fkills / fdeaths;
	if(Debug.BoolValue)	{
		PrintToServer("kdr: %.2f", kdr);
		PrintToServer(" ");
	}
	
	kdr = kdr / 100.0; /* Fix the KDR To be correct. 120.0 -> 1.20 */
	
	if(kdr == 0.00)
		kdr = 1.00;
	
	return kdr;
}

/**
 *	Add session points. Just to make it easier :)
 */
stock void AddSessionPoints(int client, int value)	{
	Session[client].Points += value;
}

/**
 *	Remove session points. Just to make it easier :)
 */
stock void RemoveSessionPoints(int client, int value)	{
	Session[client].Points -= value;
}

/**
 *	Update players last connected time state.
 *
 *	@param	auth	The players steam authentication id.
 */
stock void UpdateLastConnectedState(const char[] auth)	{
	char query[512];
	Format(query, sizeof(query), "update `%s` set LastConnected='%i' where SteamID='%s' and ServerID='%i'",
	playerlist, GetTime(), auth, ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
	
	Format(query, sizeof(query), "update `%s` set LastConnectedServerID='%i' where SteamID='%s'",
	playerlist, ServerID.IntValue, auth);
	db.Query(DBQuery_Callback, query);
}

/**
 *	Remove players from the database table if found too old.
 *
 *	@param	days	If the player has not been in this many days, the player gets removed.
 */
stock void RemoveOldConnectedPlayers(int days = 30)	{
	int time = GetTime() - (days * 86400);
	char query[512];
	Format(query, sizeof(query), "select SteamID from `%s` where LastConnected < '%i' and ServerID='%i'",
	playerlist, time, ServerID.IntValue);
	
	DataPack pack = new DataPack();
	pack.WriteCell(time);
	pack.WriteCell(days);
	db.Query(DBQuery_RemoveOldPlayers_1, query, days);
}

stock void DBQuery_RemoveOldPlayers_1(Database database, DBResultSet results, const char[] error, DataPack pack)	{
	pack.Reset();
	int time = pack.ReadCell();
	int days = pack.ReadCell();
	delete pack;
	
	if(results == null)
		SetFailState("%s Deleting old players failed! (%s)", LogTag, error);
	
	int count = 0;
	while(results.FetchRow())	{
		count++;
		
		char auth[64];
		results.FetchString(0, auth, sizeof(auth));
		if(Debug.BoolValue)
			PrintToServer("%s [%i] Deleted %s from database after %i days of no activity",
			LogTag, count, auth, days);
	}
	
	/* Avoid spamming this in the while loop */
	if(count > 0)	{
		char query[512];
		Format(query, sizeof(query), "delete from `%s` where LastLastConnectedServerID='%i'",
		playerlist, time, ServerID.IntValue);
		db.Query(DBQuery_RemoveOldPlayers_2, query);
	}
}

stock void DBQuery_RemoveOldPlayers_2(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		SetFailState("%s Deleting old players failed! (%s)", LogTag, error);
}

//====================//
// Database stuff.
//====================//

/**
 *	Callback query for death events.
 */
stock void DBQuery_Callback(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		SetFailState("%s Updating table \"%s\" failed! (%s)", logprefix, playerlist, error);
}

/**
 *	Callback query for kill log.
 */
stock void DBQuery_Kill_Log(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)
		SetFailState("%s Adding kill log event to \"%s\" failed! (%s)", logprefix, kill_log, error);
}

/**
 *	Callback query for playtimer.
 */
stock void DBQuery_IntervalPlayTimer(Database database, DBResultSet results, const char[] error, int client)	{
	if(!IsClientConnected(client))
		return;
	
	if(results == null)
		SetFailState("%s Updating playtime by 1 minute for client index %i to \"%s\" failed! (%s)", logprefix, client, playerlist, error);
}

/**
 *	Callback query for database query insertions.
 */
stock void DBQuery_DB(Database database, DBResultSet results, const char[] error, int data)	{
	if(results == null)
		SetFailState("%s Creating query for database table id %i failed! (%s)", logprefix, data, error);
}

/**
 *	Callback for the panel.
 */
stock int PanelCallback(Menu menu, MenuAction action, int client, int selection)	{}

/**
 *	Check active players.
 */
stock void CheckActivePlayers()	{
	int needed = MinimumPlayers.IntValue;
	int players = GetClientCountEx(!AllowBots.BoolValue);
	//PrintToServer("Players: [%i/%i]", players, needed);
	
	switch(RankActive)	{
		case	true:	{
			if(needed > players)	{
				RankActive = false;
				
				CPrintToChatAll("%s %t", Prefix, "Not Enough Players", players, needed);
				if(Debug.BoolValue)
					PrintToServer("%s Not enough players [%i/%i], disabling..", Prefix, players, needed);
			}
		}
		case	false:	{
			if(needed <= players)	{
				if(RoundActive)	{
					RankActive = true;
					CPrintToChatAll("%s %t", Prefix, "Enough Players", players, needed);
					if(Debug.BoolValue)
						PrintToServer("%s Enough players [%i/%i], enabling..", Prefix, players, needed);
				}
			}
		}
	}
}

/**
 *	Make sure the stats is properly configured.
 */
stock bool IsValidStats()	{
	return	!(!PluginActive.BoolValue || !RoundActive || !RankActive || WarmupActive && !AllowWarmup.BoolValue);
}

/**
 *	Make sure the event wasn't abused.
 *
 *	@param	client	The users index to read. (0 disables reading the client)
 */
stock bool IsValidAbuse(int client=0)	{
	bool abuse = false;
	
	if(AntiAbuse.BoolValue)	{
		ConVar cvar = FindConVar("sv_cheats");
		if(cvar != null && cvar.BoolValue)
			abuse = true;
		
		delete cvar;
		
		if(client > 0)	{
			if(IsClientNoclipping(client))
				abuse = true;
		}
	}
	
	return	abuse;
}

/**
 *	Returns if the client is inside a smoke.
 *	Used as alternative for CS:S since 'thrusmoke' is only available in CS:GO.
 *
 *	@param	client	The users index.
 */
stock bool CS_IsClientInsideSmoke(int client)	{
	Entity entity = Entity_Empty;
	while((entity = Entity.FindByClassname(entity, "env_particlesmokegrenade")) != Entity_Invalid)	{
		if(entity.GetDistance(client) <= 3.0)
			return true;
	}
	
	return false;
}

/* Forwards */

/**
 *	Prepare prefix forward.
 *
 *	@noreturn
 */
stock void PreparePrefixUpdatedForward()	{
	Call_StartForward(Fwd_Prefix);
	Call_PushString(Prefix);
	Call_Finish();
}

/**
 *	Prepare OnDeath forward.
 *
 *	@param	client		The players user index.
 *	@param	victim		The killed users index.
 *	@param	assist		The assisting users index.
 *	@param	weapon		The weapon string to forward.
 *	@param	defindex	The weapon definition index. (0 if invalid for the game)
 *
 *	@noreturn
 */
stock void PrepareOnDeathForward(int client, int victim, int assist, const char[] weapon, int defindex)	{
	Call_StartForward(Fwd_Death);
	Call_PushCell(client);
	Call_PushCell(victim);
	Call_PushCell(assist);
	Call_PushString(weapon);
	Call_PushCell(defindex);
	Call_Finish();
}

/**
 *	Prepare OnSuicide forward.
 *
 *	@param	client		The players user index.
 *
 *	@noreturn
 */
stock void PrepareOnSuicideForward(int client)	{
	Call_StartForward(Fwd_Suicide);
	Call_PushCell(client);
	Call_Finish();
}

/**
 *	Prepare flag event forward.
 *
 *	@param	client		The players user index.
 *	@param	carrier		The carriers user index.
 *	@param	flag		The flag event type.
 *	@param	home		The flag was stolen.
 *
 *	@noreturn
 */
stock void PrepareTF2FlagEventForward(int client, int carrier, TFFlag flag, bool home)	{
	Call_StartForward(Fwd_TF2_FlagEvent);
	Call_PushCell(client);
	Call_PushCell(carrier);
	Call_PushCell(flag);
	Call_PushCell(home);
	Call_Finish();
}

/* Stuff */
 
/**
 *	Assisted kill event.
 *
 *	@param	assist	Assisters user index.
 *	@param	client	The client that was assisted.
 *	@param	victim	The victim that was killed.
 *
 *	@return	Returns if the assister is valid.
 */
stock bool AssistedKill(int assist, int client, int victim)	{
	if(!Tklib_IsValidClient(assist, true))
		return false;
	
	char query[512];
	Session[assist].Assists++;
	Format(query, sizeof(query), "update `%s` set Assists = Assists+1 where SteamID='%s' and ServerID='%i'",
	playerlist, SteamID[assist], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
	
	if(AssistKill.IntValue > 0)	{
		Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s' and ServerID='%i'",
		playerlist, AssistKill.IntValue, SteamID[assist], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		int assist_points = GetClientPoints(SteamID[assist]);
		CPrintToChat(client, "%s %t", Prefix, "Assist Kill Event", Name[assist], assist_points, AssistKill.IntValue, Name[client], Name[victim]);
	}
		
	return true;
}

/**
 *	Victim died.
 *
 *	@param	victim	The victims user index.
 *
 *	@return	Returns if the victim is valid.
 */
stock bool VictimDied(int victim)	{
	if(!Tklib_IsValidClient(victim, true))
		return false;
	
	char query[512];
	Format(query, sizeof(query), "update `%s` set Deaths = Deaths+1 where SteamID='%s' and ServerID='%i'",
	playerlist, SteamID[victim], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
	
	int death_points;
	
	switch(game)	{
		case	Game_TF2, Game_TF2C, Game_TF2V, Game_TF2B, Game_TF2OP:
			death_points = TF2_DeathClass[TF2_GetPlayerClass(victim)].IntValue;
		default:
			death_points = Death.IntValue;
	}
		
	int victim_points = GetClientPoints(SteamID[victim]);
	if(death_points > 0)	{
		RemoveSessionPoints(victim, death_points);
		CPrintToChat(victim, "%s %s (%i) lost %i points for dying.", Prefix, Name[victim], death_points, victim_points);
		
		Format(query, sizeof(query), "update `%s` set Points = Points-%i where SteamID='%s' and ServerID='%i'",
		playerlist, death_points, SteamID[victim], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	return true;
}

/**
 *	Prepare the kill message.
 *
 *	@param	client	The client who killed.
 *	@param	victim	The victim who died.
 *	@param	points	The points the client was given
 */
stock void PrepareKillMessage(int client, int victim, int points)	{
	int points_client = GetClientPoints(SteamID[client]);
	
	char buffer[256];
	
	/* Lë ol' messy code but has to be it. */
	
	/* Deflect kill */
	if(KillMsg[client].DeflectKill)
	{
		/* Airshot deflect kill */
		if(KillMsg[client].AirshotKill)
		{
			switch(KillMsg[client].HeadshotKill)
			{
				/* Headshot airshot deflect kill */
				case true:
					Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[6], Kill_Type[7]);
				/* Airshot deflect kill */
				case false:
					Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[6], Kill_Type[7]);
			}
		}
		else
		{
			switch(KillMsg[client].HeadshotKill)
			{
				/* Headshot deflect kill */
				case true:
					Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[7]);
				/* Deflect kill */
				case false:
					Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[7]);
			}
		}
	}
	
	/* Airshot kill */
	else if(KillMsg[client].AirshotKill)
	{
		/* Mid air airshot kill */
		if(KillMsg[client].MidAirKill)
		{
			switch(KillMsg[client].HeadshotKill)
			{
				/* Mid air airshot headshot kill */
				case true:
					Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[6], Kill_Type[0]);
				/* Mid air airshot kill */
				case false:
					Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[6], Kill_Type[0]);
			}
		}
		/* Airshot kill */
		else
		{
			switch(KillMsg[client].HeadshotKill)
			{
				/* Airshot headshot kill */
				case true:
					Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[3], Kill_Type[6]);
				/* Airshot kill */
				case false:
					Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[6]);
			}
		}
	}
	
	/* Backstab kill */
	else if(KillMsg[client].BackstabKill)
	{
		switch(KillMsg[client].MidAirKill)
		{
			/* Mid air backstab kill */
			case true:
				Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[5], Kill_Type[0]);
			case false:
				Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[5]);
		}
	}
	
	/* Noscope kill */
	else if(KillMsg[client].NoscopeKill)
	{
		/* Noscope headshot kill */
		if(KillMsg[client].HeadshotKill)
		{
			/* Noscope headshot kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				/* Noscope headshot through smoke whilst blinded */
				if(KillMsg[client].BlindedKill)
				{
					switch(KillMsg[client].MidAirKill)
					{
						/* Mid air noscope headshot kill through smoke whilst blinded */
						case true:
							Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default} %t{default}", Kill_Type[2], Kill_Type[1], Kill_Type[12], Kill_Type[0]);
						/* Noscope headshot through smoke whilst blinded */
						case false:
							Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[4], Kill_Type[1], Kill_Type[12]);
					}
				}
				/* Noscope headshot kill through smoke */
				else
				{
					switch(KillMsg[client].MidAirKill)
					{
						/* Mid air noscope headshot kill through smoke */
						case true:
							Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[2], Kill_Type[1], Kill_Type[0]);
						/* Noscope headshot kill through smoke */
						case false:
							Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[4], Kill_Type[1]);
					}
				}
			}
			/* Noscope headshot kill */
			else
			{
				switch(KillMsg[client].MidAirKill)
				{
					/* Mid air noscope headshot */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[2], Kill_Type[0]);
					/* Noscope headshot kill */
					case false:
						Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[4]);
				}

			}
		}
		/* Mid air noscope kill */
		else if(KillMsg[client].MidAirKill)
		{
			/* Mid air noscope kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Mid air noscope kill through smoke whilst blinded */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default} %t{default}", Kill_Type[2], Kill_Type[1], Kill_Type[12], Kill_Type[0]);
					/* Mid air noscope kill through smoke */
					case false:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[4], Kill_Type[1], Kill_Type[0]);
				}
			}
			/* Mid air headshot kill */
			else
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Mid air noscope kill while blinded */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[2], Kill_Type[12], Kill_Type[0]);
					/* Mid air noscope kill */
					case false:
						Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[4], Kill_Type[0]);
				}
			}
		}
		/* Noscope kill */
		else
		{
			/* Noscope kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Noscope kill through smoke while blinded */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[4], Kill_Type[1], Kill_Type[12]);
					/* Noscope kill through smoke */
					case false:
						Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[4], Kill_Type[1]);
				}
			}
			/* Noscope kill */
			else
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Noscope kill whilst blinded */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[4], Kill_Type[12]);
					/* Noscope kill */
					case false:
						Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[4]);
				}
			}
		}
	}
	
	/* Headshot kill */
	else if(KillMsg[client].HeadshotKill)
	{
		/* Headshot kill through smoke */
		if(KillMsg[client].SmokeKill)
		{
			/* Headshot through smoke whilst blinded */
			if(KillMsg[client].BlindedKill)
			{
				switch(KillMsg[client].MidAirKill)
				{
					/* Mid air headshot kill through smoke whilst blinded */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[12], Kill_Type[0]);
					/* Headshot through smoke whilst blinded */
					case false:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[12]);
				}
			}
			/* Headshot kill through smoke */
			else
			{
				switch(KillMsg[client].MidAirKill)
				{
					/* Mid air headshot kill through smoke */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[0]);
					/* Headshot kill through smoke */
					case false:
						Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[1]);
				}
			}
		}
		/* Mid air headshot kill */
		else if(KillMsg[client].MidAirKill)
		{
			/* Mid air headshot kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Mid air headshot kill through smoke whilst blinded */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[12], Kill_Type[0]);
					/* Mid air headshot kill through smoke */
					case false:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[0]);
				}
			}
			/* Mid air headshot kill */
			else
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Mid air eadshot kill while blinded */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[12], Kill_Type[0]);
					/* Mid air headshot kill */
					case false:
						Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[0]);
				}
			}
		}
		/* Headshot kill */
		else
		{
			/* Headshot kill through smoke */
			if(KillMsg[client].SmokeKill)
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Headshot kill through smoke while blinded */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default} %t{default}", Kill_Type[3], Kill_Type[1], Kill_Type[12]);
					/* Headshot kill through smoke */
					case false:
						Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[1]);
				}
			}
			/* Headshot kill */
			else
			{
				switch(KillMsg[client].BlindedKill)
				{
					/* Headshot kill whilst blinded */
					case true:
						Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[12]);
					/* Headshot kill */
					case false:
						Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[3]);
				}
			}
		}
	}
	
	/* Telefrag */
	else if(KillMsg[client].TeleFragKill)
	{
		Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[8]);
	}
	else if(KillMsg[client].CollateralKill)
	{
		switch(KillMsg[client].HeadshotKill)
		{
			/* Headshot collateral kill */
			case true:
				Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[3], Kill_Type[9]);
			/* Colllateral kill */
			case false:
				Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[9]);
		}
	}
	else if(KillMsg[client].GrenadeKill)
	{
		Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[10]);
	}
	else if(KillMsg[client].BombKill)
	{
		Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[11]);
	}
	else if(KillMsg[client].BlindedKill)
	{
		switch(KillMsg[client].MidAirKill)
		{
			/* Mid air blinded kill */
			case true:
				Format(buffer, sizeof(buffer), "%t{default} %t{default}", Kill_Type[12], Kill_Type[0]);
			/* Blinded kill */
			case false:
				Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[12]);
		}
	}
	
	/* Mid air kill */
	else if(KillMsg[client].MidAirKill)
	{
		Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[0]);
	}
	
	switch(IsValidString(buffer))	{
		case	true:	CPrintToChat(client, "%s %t", Prefix, "Special Kill Event", Name[client], points_client, points, Name[victim], buffer);
		case	false:	CPrintToChat(client, "%s %t", Prefix, "Default Kill Event", Name[client], points_client, points, Name[victim]);
	}
}