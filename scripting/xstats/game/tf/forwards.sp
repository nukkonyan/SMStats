public void EM_Player_Death_TF2(int attacker,
								 int userid,
								 int assister,
								 const char[] weapon,
								 const char[] weapon_classname,
								 int weapon_defindex,
								 int inflictor,
								 int customkill,
								 int stun_flags,
								 int death_flags,
								 bool silent_kill,
								 int playerpenetrate,
								 int crit_type,
								 bool rocket_jump,
								 const char[] killstreak,
								 const char[] duckstreak,
								 float distance)	{
	if(!PluginActive.BoolValue || !RoundActive)
		return;
	
	if(StrEqual(weapon_classname, "player")
	|| StrEqual(weapon_classname, "world"))
		return;
	
	int defindex = weapon_defindex;
	
	if(Weapon[defindex] == null)	{
		PrintToServer("%s weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.", logprefix, weapon, defindex);
		return;
	}
	
	int client = GetClientOfUserId(attacker);
	int victim = GetClientOfUserId(userid);
	int assist = GetClientOfUserId(assister);
	int points = 0;
	
	switch(TF2_GetBuildingType(inflictor))	{
		case	TFBuilding_Sentrygun:	points = TF2_SentryKill.IntValue;
		case	TFBuilding_MiniSentry:	points = TF2_MiniSentryKill.IntValue;
		case	TFBuilding_Invalid:		points = Weapon[defindex].IntValue;
	}

	bool headshot = (customkill == 1);
	bool backstab = (customkill == 2);
	bool noscope = false;
	
	bool midair = IsClientMidAir(client);
	
	bool dominated = false;
	bool revenge = false;
	

	GetClientNameEx(client, Playername[client], sizeof(Playername[]));
	GetClientNameEx(victim, Playername[victim], sizeof(Playername[]));
	GetClientNameEx(assist, Playername[assist], sizeof(Playername[]));
	GetClientTeamString(client, Name[client], sizeof(Name[]));
	GetClientTeamString(victim, Name[victim], sizeof(Name[]));
	GetClientTeamString(assist, Name[assist], sizeof(Name[]));
	
	if(IsFakeClient(victim) && !AllowBots.BoolValue)
		return;
	
	char query[1024];
	
	if(Tklib_IsValidClient(client, true) && Tklib_IsValidClient(victim, true))	{		
		if(IsSamePlayers(client, victim))	{
			Session[client].Suicides++;
			Format(query, sizeof(query), "update `%s` set Suicides = Suicides+1 where SteamID='%s'", playerlist, SteamID[victim]);
			db.Query(DBQuery_Death, query);
		}
	}
	
	if(Tklib_IsValidClient(client, true) && Tklib_IsValidClient(victim) && !IsSamePlayers(client, victim) && !IsSameTeam(client, victim))	{
		//There was an assist.
		if(Tklib_IsValidClient(assist, true))	{
			Session[assist].Assists++;
			Format(query, sizeof(query), "update `%s` set Assists = Assists+1 where SteamID='%s'", playerlist, SteamID[assist]);
			db.Query(DBQuery_Death, query);
			
			if(AssistKill.IntValue > 0)
			{
				Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", playerlist, SteamID[assist]);
				db.Query(DBQuery_Death, query);
				
					//Optimize the servers performance, combining the callback inside the chat print may lag the server for a slight second.
				int assist_points = GetClientPoints(SteamID[assist]);
				
				CPrintToChat(client, "%s %t", Prefix, "Assist Kill Event", assist_points, points, Name[victim]);
			}
		}
		
		//Make sure to not query updates on a bot, the database wont be happy about that.
		if(!IsFakeClient(victim))	{
			Format(query, sizeof(query), "update `%s` set Deaths = Deaths+1 where SteamID='%s'", playerlist, SteamID[victim]);
			db.Query(DBQuery_Death, query);
			
			if(Death.IntValue > 0)	{
				Format(query, sizeof(query), "update `%s` set Points = Points-%i where SteamID='%s'", playerlist, Death.IntValue, SteamID[victim]);
				db.Query(DBQuery_Death, query);
			}
		}
		
		Session[client].Kills++;
		Format(query, sizeof(query), "update `%s` set Kills = Kills+1 where SteamID='%s'", playerlist, SteamID[client]);
		db.Query(DBQuery_Death, query);
		
		//If the inflictor entity is a building.
		switch(TF2_GetBuildingType(inflictor))	{
			case	TFBuilding_Sentrygun:	{
				Session[client].MiniSentryKills++;
				Format(query, sizeof(query), "update `%s` set SentryKills = SentryKills+1 where SteamID='%s'", playerlist, SteamID[client]);
				db.Query(DBQuery_Death, query);
			}
			case	TFBuilding_MiniSentry:	{
				Session[client].SentryKills++;
				Format(query, sizeof(query), "update `%s` set MiniSentryKills = MiniSentryKills+1 where SteamID='%s'", playerlist, SteamID[client]);
				db.Query(DBQuery_Death, query);
			}
			case	TFBuilding_Invalid:	{
				char why_weapon_class[96];
				TF2_whyWeaponClassname(why_weapon_class, sizeof(why_weapon_class), weapon_defindex, weapon);
				
				Format(query, sizeof(query), "update `%s` set Kills_%s = Kills_%s+1 where SteamID='%s'", playerlist, why_weapon_class, why_weapon_class, SteamID[client]);
				db.Query(DBQuery_Death, query);
			}
		}
		
		if(headshot)	{
			Session[client].Headshots++;
			Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s'", playerlist, SteamID[client]);
			db.Query(DBQuery_Death, query);
		}
		
		if(backstab)	{
			Session[client].Backstabs++;
			Format(query, sizeof(query), "update `%s` set Backstabs = Backstabs+1 where SteamID='%s'", playerlist, SteamID[client]);
			db.Query(DBQuery_Death, query);
		}
		
		if(dominated)	{
			Session[client].Dominations++;
			Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s'", playerlist, SteamID[client]);
			db.Query(DBQuery_Death, query);
		}
		
		if(revenge)	{
			Session[client].Revenges++;
			Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s'", playerlist, SteamID[client]);
			db.Query(DBQuery_Death, query);
		}
		
		if(noscope)	{
			Session[client].Noscopes++;
			Format(query, sizeof(query), "update `%s` set Noscopes = Noscopes+1 where SteamID='%s'", playerlist, SteamID[client]);
			db.Query(DBQuery_Death, query);
		}
		
		if(points > 0)	{
			Session[client].Points = Session[client].Points+points;
			Format(query, sizeof(query), "update `%s` set Points = Points+%i", playerlist, points);
			db.Query(DBQuery_Death, query);
			
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
			else if(backstab)
				Kill_Scenario = 6;
			
			char scenario[64];
			
			if(Kill_Scenario > 0)	{
				//why the format.
				Format(scenario, sizeof(scenario), "%t{default}", Kill_Type[Kill_Scenario]);
			}
			
			//whyes the distance float.
			char dist[64];
			Format(dist, sizeof(dist), "%.2f", distance);
			
			switch(IsValidString(scenario))	{
				case	true:	CPrintToChat(client, "%s %t", Prefix, "Kill Event 1", Name[client], points_client, points, Name[victim], scenario, dist);
				case	false:	CPrintToChat(client, "%s %t", Prefix, "Kill Event 2", Name[client], points_client, points, Name[victim], dist);
			}
		}
		
		if(!IsFakeClient(victim))	{
			char log[2048];
			int len = 0;
			len += Format(log[len], sizeof(log)-len, "insert into `%s`", kill_log);
			len += Format(log[len], sizeof(log)-len, "(Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, Midair, CritType)");
			len += Format(log[len], sizeof(log)-len, "values");
			len += Format(log[len], sizeof(log)-len, "('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', `%i`, `%i`)",
			Playername[client], SteamID[client], Playername[victim], SteamID[victim], Playername[assist], SteamID[assist], weapon, headshot, noscope, midair, crit_type);
			db.Query(DBQuery_Kill_Log, log);
		}
	}
}

public void EM_Teamplay_Point_Captured(int cp, const char[] cpname, int team, const char[] cappers)	{
	if(!PluginActive.BoolValue || !RoundActive)
		return;
	
}

public void EM_Teamplay_Capture_Blocked(int cp, const char[] cpname, int blocker, int victim)	{
	if(!PluginActive.BoolValue || !RoundActive)
		return;
	
}

public void EM_Teamplay_Flag_Event(int client, int carrier, int eventtype, bool home, int team)	{
	if(!PluginActive.BoolValue || !RoundActive)
		return;
	
	if(!Tklib_IsValidClient(client, true))
		return;
	
}