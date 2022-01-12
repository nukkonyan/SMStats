stock void Player_Death_CSGO(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!IsValidStats())
		return;

	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	if(!Tklib_IsValidClient(client, true))
		return;

	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_VICTIM));
	if(!Tklib_IsValidClient(victim))
		return;
	
	if(IsFakeClient(victim) && !AllowBots.BoolValue)
		return;
	
	if(IsSamePlayers(client, victim) || IsSameTeam(client, victim))
		return;
	
	char weapon[64];
	event.GetString(EVENT_STR_WEAPON, weapon, sizeof(weapon));
	if(StrEqual(weapon, "world")
	|| StrEqual(weapon, "player"))
		return; //Since it's not a valid killer, lets end here.
	
	/* Fix the weapon entity prefix */
	Format(weapon, sizeof(weapon), "weapon_%s", weapon);
		
	int assist = GetClientOfUserId(event.GetInt(EVENT_STR_ASSISTER));
	int defindex = CSGO_GetWeaponDefindex(weapon);
	
	bool midair = IsClientMidAir(client);
	bool headshot = event.GetBool(EVENT_STR_HEADSHOT);
	bool dominated = event.GetBool(EVENT_STR_DOMINATED);
	bool revenge = event.GetBool(EVENT_STR_REVENGE);
	bool noscope = event.GetBool(EVENT_STR_NOSCOPE);
	bool thrusmoke = event.GetBool(EVENT_STR_THRUSMOKE);
	bool attackerblind = event.GetBool(EVENT_STR_ATTACKERBLIND);
	
	if(Weapon[defindex] == null)	{
		PrintToServer("%s weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.", logprefix, weapon, defindex);
		return;
	}
	
	int points = Weapon[defindex].IntValue;
	
	/* Debug */
	if(Debug.BoolValue)	{
		PrintToServer("//===== Player_Death_CSGO =====//");
		PrintToServer("client %i", client);
		PrintToServer("victim %i", victim);
		PrintToServer("assist: %i", assist);
		PrintToServer("defindex %i", defindex);
		PrintToServer("weapon \"%s\"", weapon);
		PrintToServer(" ");
		PrintToServer("midair %s", Bool[midair]);
		PrintToServer("headshot %s", Bool[headshot]);
		PrintToServer("dominated %s", Bool[dominated]);
		PrintToServer("revenge %s", Bool[revenge]);
		PrintToServer("noscope %s", Bool[noscope]);
		PrintToServer("thrusmoke %s", Bool[thrusmoke]);
		PrintToServer("attackerblind %s", Bool[attackerblind]);
		PrintToServer(" ");
		PrintToServer("Points %i", points);
	}
	
	char query[1024];
	
	if(Tklib_IsValidClient(assist, true))	{
		Session[assist].Assists++;
		Format(query, sizeof(query), "update `%s` set Assists = Assists+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[assist], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(AssistKill.IntValue > 0)	{
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[assist], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			//Optimize the servers performance, combining the callback inside the chat print may lag the server for a slight second.
			int assist_points = GetClientPoints(SteamID[assist]);
			CPrintToChat(client, "%s %s (%i) earned %i points for assisting %s in killing %s", Prefix, assist_points, points, Name[client], Name[victim]);
		}
	}
		
	if(!IsFakeClient(victim))	{
		Format(query, sizeof(query), "update `%s` set Deaths = Deaths+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[victim], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		if(Death.IntValue > 0)	{
			Format(query, sizeof(query), "update `%s` set Points = Points-%i where SteamID='%s' and ServerID='%i'",
			playerlist, Death.IntValue, SteamID[victim], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
		}
	}
	
	Session[client].Kills++;
	Format(query, sizeof(query), "update `%s` set Kills = Kills+1 where SteamID='%s' and ServerID='%i'",
	playerlist, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
	
	Format(query, sizeof(query), "update `%s` set Kills_%s = Kills_%s+1 where SteamID='%s' and ServerID='%i'",
	playerlist, weapon, weapon, SteamID[client], ServerID.IntValue);
	db.Query(DBQuery_Callback, query);
	
	if(headshot)	{
		Session[client].Headshots++;
		Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	if(dominated)	{
		Session[client].Dominations++;
		Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
		
	if(revenge)	{
		Session[client].Revenges++;
		Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	if(noscope)	{
		Session[client].Noscopes++;
		Format(query, sizeof(query), "update `%s` set Noscopes = Noscopes+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
	
	if(thrusmoke)	{
		Session[client].SmokeKills++;
		Format(query, sizeof(query), "update `%s` set ThruSmokes = ThruSmokes+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
		
	if(points > 0)	{
		AddSessionPoints(client, points);
		Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s' and ServerID='%i'",
		playerlist, points, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		int points_client = GetClientPoints(SteamID[client]);
		
		if(noscope && headshot)
			Kill_Scenario = 1;
		else if(noscope)
			Kill_Scenario = 2;
		else if(midair && headshot)
			Kill_Scenario = 3;
		else if(midair)
			Kill_Scenario = 4;
		else if(headshot)
			Kill_Scenario = 5;
		else if(thrusmoke)
			Kill_Scenario = 7;
		else
			Kill_Scenario = 0;
		
		/*
		char scenario[64];
		
		if(Kill_Scenario > 0)	{
			//Fix the format.
			Format(scenario, sizeof(scenario), "%t{default}", Kill_Type[Kill_Scenario]);
		}
		
		switch(IsValidString(scenario))	{
			case	true:	CPrintToChat(client, "%s %t", Prefix, "Kill Event 1", Name[client], points_client, points, Name[victim], scenario);
			case	false:	CPrintToChat(client, "%s %t", Prefix, "Kill Event 2", Name[client], points_client, points, Name[victim]);
		}
		*/
		
		//Temporary
		switch(Kill_Scenario)	{
			case	0:
				CPrintToChat(client, "%s %s (%i) earned %i points for killing %s",
				Prefix, Name[client], points_client, points, Name[victim]);
			case	1:
				CPrintToChat(client, "%s %s (%i) earned %i points for killing %s with {green}Noscope Headshot{default}.",
				Prefix, Name[client], points_client, points, Name[victim]);
			case	2:
				CPrintToChat(client, "%s %s (%i) earned %i points for killing %s with {green}Noscope{default}.",
				Prefix, Name[client], points_client, points, Name[victim]);
			case	3:
				CPrintToChat(client, "%s %s (%i) earned %i points for killing %s with {green}Mid-Air Headshot{default}.",
				Prefix, Name[client], points_client, points, Name[victim]);
			case	4:
				CPrintToChat(client, "%s %s (%i) earned %i points for killing %s whilst {green}Mid-Air{default}.",
				Prefix, Name[client], points_client, points, Name[victim]);
			case	5:
				CPrintToChat(client, "%s %s (%i) earned %i points for killing %s with {green}Headshot{default}.",
				Prefix, Name[client], points_client, points, Name[victim]);
			case	7:
				CPrintToChat(client, "%s %s (%i) earned %i points for killing %s {green}Through Smoke{default}.",
				Prefix, Name[client], points_client, points, Name[victim]);
		}
		
		if(!IsFakeClient(victim))	{
			char log[2048];
			int len = 0;
			len += Format(log[len], sizeof(log)-len, "insert into `%s`", kill_log);
			len += Format(log[len], sizeof(log)-len, "(Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, ThruSmoke, BlindedKill)");
			len += Format(log[len], sizeof(log)-len, "values");
			len += Format(log[len], sizeof(log)-len, "('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', '%i', '%i')",
			Playername[client], SteamID[client], Playername[victim], SteamID[victim], Playername[assist], SteamID[assist], weapon, headshot, noscope, thrusmoke, attackerblind);
			db.Query(DBQuery_Kill_Log, log);
		}
	}
}