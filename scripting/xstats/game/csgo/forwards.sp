public void EM_Player_Death_CSGO(int attacker,
								  int userid,
								  int assister,
								  int assistedflash,
								  const char[] weapon,
								  int penetrated,
								  bool headshot,
								  bool dominated,
								  bool revenge,
								  bool wipe,
								  bool noscope,
								  bool thrusmoke,
								  bool attackerblind,
								  float distance)	{
	if(!PluginActive.BoolValue || !RoundActive || WarmupActive && !AllowWarmup.BoolValue)
		return;
	
	int defindex = CSGO_GetWeaponDefindex(weapon);
	
	if(Weapon[defindex] == null)	{
		PrintToServer("%s weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.", logprefix, weapon, defindex);
		return;
	}
	
	int client = GetClientOfUserId(attacker);
	int victim = GetClientOfUserId(userid);
	int assist = GetClientOfUserId(assist);
	int points = Weapon[defindex].IntValue;

	GetClientNameEx(client, Playername[client], sizeof(Playername[]));
	GetClientNameEx(victim, Playername[victim], sizeof(Playername[]));
	GetClientNameEx(assist, Playername[assist], sizeof(Playername[]));
	GetClientTeamString(client, Name[client], sizeof(Name[]));
	GetClientTeamString(victim, Name[victim], sizeof(Name[]));
	GetClientTeamString(assist, Name[assist], sizeof(Name[]));
	
	char query[1024];
	if(Tklib_IsValidClient(client, true) && Tklib_IsValidClient(victim, true))	{		
		if(IsSamePlayers(client, victim))
		{
			Session[client].Suicides++;
			Format(query, sizeof(query), "update `%s` set Suicides = Suicides+1 where SteamID='%s'", playerlist, SteamID[victim]);
			db.Query(DBQuery_Death, query);
		}
	}
	
	if(Tklib_IsValidClient(client, true) && Tklib_IsValidClient(victim) && !IsSamePlayers(client, victim) && !IsSameTeam(client, victim))	{
		if(IsFakeClient(victim) && !AllowBots.BoolValue)
			return;
		
		if(Tklib_IsValidClient(assist, true))	{
			Session[assist].Assists++;
			Format(query, sizeof(query), "update `%s` set Assists = Assists+1 where SteamID='%s'", playerlist, SteamID[assist]);
			db.Query(DBQuery_Death, query);
			
			if(AssistKill.IntValue > 0)	{
				Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s'", playerlist, SteamID[assist]);
				db.Query(DBQuery_Death, query);
				
					//Optimize the servers performance, combining the callback inside the chat print may lag the server for a slight second.
				int assist_points = GetClientPoints(SteamID[assist]);
				
				CPrintToChat(client, "%s %t", Prefix, "Assist Kill Event", assist_points, points, Name[victim]);
			}
		}
		
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
		
		Format(query, sizeof(query), "update `%s` set Kills_%s = Kills_%s+1 where SteamID='%s'", playerlist, weapon, weapon, SteamID[client]);
		db.Query(DBQuery_Death, query);
		
		if(headshot)	{
			Session[client].Headshots++;
			Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s'", playerlist, SteamID[client]);
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
		
		if(thrusmoke)	{
			Session[client].SmokeKills++;
			Format(query, sizeof(query), "update `%s` set ThruSmokes = ThruSmokes+1 where SteamID='%s'", playerlist, SteamID[client]);
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
			else if(headshot)
				Kill_Scenario = 5;
			else if(thrusmoke)
				Kill_Scenario = 7;
			
			char scenario[64];
			
			if(Kill_Scenario > 0)	{
				//Fix the format.
				Format(scenario, sizeof(scenario), "%t{default}", Kill_Type[Kill_Scenario]);
			}
			
			//Fixes the distance float.
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
			len += Format(log[len], sizeof(log)-len, "(Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, ThruSmoke, BlindedKill)");
			len += Format(log[len], sizeof(log)-len, "values");
			len += Format(log[len], sizeof(log)-len, "('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', '%i', '%i')",
			Playername[client], SteamID[client], Playername[victim], SteamID[victim], Playername[assist], SteamID[assist], weapon, headshot, noscope, thrusmoke, attackerblind);
			db.Query(DBQuery_Kill_Log, log);
		}
	}
}