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
	//int penetrated = event.GetInt(EVENT_STR_PENETRATED);
	bool midair = IsClientMidAir(client);
	bool headshot = event.GetBool(EVENT_STR_HEADSHOT);
	bool dominated = event.GetBool(EVENT_STR_DOMINATED);
	bool revenge = event.GetBool(EVENT_STR_REVENGE);
	bool noscope = event.GetBool(EVENT_STR_NOSCOPE);
	bool thrusmoke = event.GetBool(EVENT_STR_THRUSMOKE);
	bool attackerblind = event.GetBool(EVENT_STR_ATTACKERBLIND);
	//bool collateral = (penetrated > 0);
	
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
	
	AssistedKill(assist, client, victim);
	VictimDied(victim);
	
	char query[1024];
	
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
		
		char buffer[96];
		if(midair)
		{
			Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[0]);
		}
		else if(midair && noscope)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "%t %t %t{default}", Kill_Type[4], Kill_Type[0], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "%t %t{default}", Kill_Type[4], Kill_Type[0]);
			}
		}
		else if(midair && noscope && headshot)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "%t %t %t{default}", Kill_Type[2], Kill_Type[0], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "%t %t{default}", Kill_Type[2], Kill_Type[0]);
			}
		}
		else if(midair && headshot)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "%t %t %t{default}", Kill_Type[3], Kill_Type[0], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "%t %t{default}", Kill_Type[3], Kill_Type[0]);
			}
		}
		/*
		else if(collateral)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "%t %t{default}", Kill_Type[10], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[10]);
			}
		}
		*/
		else if(noscope && headshot)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "%t %t{default}", Kill_Type[2], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[2]);
			}
		}
		else if(headshot)
		{
			switch(thrusmoke)
			{
				case	true:	Format(buffer, sizeof(buffer), "%t %t{default}", Kill_Type[3], Kill_Type[1]);
				case	false:	Format(buffer, sizeof(buffer), "%t{default}", Kill_Type[3]);
			}
		}
		
		switch(IsValidString(buffer))	{
			case	true:	CPrintToChat(client, "%s %t", Prefix, "Special Kill Event", Name[client], points_client, points, Name[victim], buffer);
			case	false:	CPrintToChat(client, "%s %t", Prefix, "Default Kill Event", Name[client], points_client, points, Name[victim]);
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