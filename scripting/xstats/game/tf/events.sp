stock void Player_Death_TF2(Event event, const char[] event_name, bool dontBroadcast)	{
	//if(!PluginActive.BoolValue || !RoundActive /* || TF2_GetGameType() != TFGameType_MvM */)
	//	return;
	
	//It's a fake death.
	if(event.GetInt(EVENT_STR_DEATH_FLAGS) == 32)	{
		if(Debug.BoolValue)	{
			PrintToServer("//===== Player_Death_TF2 =====//");
			PrintToServer("Detected fake death, ignoring.");
		}
		return;
	}
	
	char weapon[96];
	event.GetString(EVENT_STR_WEAPON_LOGCLASSNAME, weapon, sizeof(weapon));
	
	/* Get the values early for lowest delay. */
	
	int inflictor = event.GetInt(EVENT_STR_INFLICTOR_ENTINDEX);
	int defindex = event.GetInt(EVENT_STR_WEAPON_DEF_INDEX);
	int customkill = event.GetInt(EVENT_STR_CUSTOMKILL);
	int deathflags = event.GetInt(EVENT_STR_DEATH_FLAGS);
	TFCritType crits = TFCritType(event.GetInt(EVENT_STR_CRIT_TYPE));
	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	int assist = GetClientOfUserId(event.GetInt(EVENT_STR_ASSISTER));
	int points = 0;
	
	if(StrEqual(weapon, "player")
	|| StrEqual(weapon, "world"))
		return;	
	
	switch(TF2_GetBuildingType(inflictor))	{
		case	TFBuilding_Sentrygun:	points = TF2_SentryKill.IntValue;
		case	TFBuilding_MiniSentry:	points = TF2_MiniSentryKill.IntValue;
		case	TFBuilding_Invalid:		points = Weapon[defindex].IntValue;
	}
	
	bool headshot = (customkill == 1 || customkill == 51);
	bool backstab = (customkill == 2);
	bool noscope = (customkill == 11);
	bool dominated = (deathflags == 1);
	bool revenge = (deathflags == 4);
	bool bleedkill = (customkill == 34);
	bool gibkill = (deathflags == 128 || deathflags == 129);
	bool deflectkill = (StrContains(weapon, "deflect", false) != -1);
	bool tauntkill = ((StrContains(weapon, "taunt", false) != -1)
	/* Rainblower tauntkill */
	|| (StrEqual(weapon, "armageddon", false))
	/* Thermal thruster taunt kill */
	|| (StrEqual(weapon, "gas_blast", false))
	/* Spy knife taunt kill */
	|| customkill == 13);
	bool telefrag = StrEqual(weapon, "telefrag", false);
	bool midair = IsClientMidAir(client);
		
	// The 'weapon_def_index' on the player_death is same as if you're gathering the killers
	// current active weapon definition index and is NOT gathering the correct definition index at the time of the event.
	// So we need to manually correct them.
	// This happens when example throwing out a grenade launcher pill and then switch to your stickybomb launcher or melee, it'll pull the definition index out of that weapon instead.
	// This also just happens on certain weapons. Just dumb. tf2 team pls fix this bug.
	
	// PrintToServer("weaponid: %d", event.GetInt("weaponid"));
	
	if(bleedkill)
		defindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Melee)).DefinitionIndex;	//Only part of melee weapons.
	
	// Lets fix these since when you swap weapons just before the kill on some weapons,
	// it'll pick definition index out of that weapon instead.
	
	/* Rocket Launcher */
	if(StrEqual(weapon, "tf_projectile_rocket", false))	{
		int getindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Primary)).DefinitionIndex;
		/* If the gathered index is invalid (left or died during process), this returns 18 for safety. */
		defindex = getindex != -1 ? getindex : 18;
	}
	
	/* Grenade Launcher */
	if(StrEqual(weapon, "tf_projectile_pipe", false))
		defindex = 19;
	
	/* StickyBomb Launcher */
	if(StrEqual(weapon, "tf_projectile_pipe_remote", false))
		defindex = 20;
	
	/* Sandman */
	if(StrEqual(weapon, "ball", false))	{
		int getindex = 0;
		switch(TF2_GetPlayerClass(client))	{
			case	TFClass_Scout:	getindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Melee)).DefinitionIndex;
			case	TFClass_Pyro:	getindex = Ent(TF2_GetPlayerWeaponSlot(client, TFSlot_Primary)).DefinitionIndex;	//Pyro deflected the ball.
		}
		
		/* If the returned index is -1, return 44 for safety */
		defindex = getindex != -1 ? getindex : 44;
	}
	
	/* Scottish Resistance */
	if(StrEqual(weapon, "sticky_resistance", false))
		defindex = 130;
	
	/* Loch-N-Load */
	if(StrEqual(weapon, "loch_n_load", false))
		defindex = 308;
	
	/* QuickieBomb Launcher */
	if(StrEqual(weapon, "quickiebomb_launcher", false))
		defindex = 1150;
	
	/* Iron Bomber */
	if(StrEqual(weapon, "iron_bomber", false))
		defindex = 1151;
	
	/* The database query upload ("bat" -> "weapon_bat") */
	char fix_weapon[96];
	if(!telefrag)
		TF2_FixWeaponClassname(fix_weapon, sizeof(fix_weapon), defindex, weapon);
	
	/* Debug */
	if(Debug.BoolValue)	{
		PrintToServer("//===== Player_Death_TF2 =====//");
		PrintToServer("client %i", client);
		PrintToServer("victim %i", victim);
		PrintToServer("assist %i", assist);
		PrintToServer("inflictor %i", inflictor);
		PrintToServer(" ");
		PrintToServer("weapon \"%s\"", weapon);
		PrintToServer("defindex %i", defindex);
		PrintToServer("customkill %i", customkill);
		PrintToServer("deathflags %i", deathflags);
		PrintToServer(" ");
		PrintToServer("crit type \"%s\"", TF2_GetCritTypeName[crits]);
		PrintToServer(" ");
		PrintToServer("Midair %s", Bool[IsClientMidAir(client)]);
		PrintToServer(" ");
		PrintToServer("Points %i", points);
	}
	
	/* Make sure the weapon definition index exists on the array */
	if(Weapon[defindex] == null)	{
		PrintToServer("%s weapon \"%s\" (%i defindex) has invalid cvar handle, stopping event from further errors.", logprefix, weapon, defindex);
		return;
	}
	
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
			Format(query, sizeof(query), "update `%s` set Suicides = Suicides+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[victim], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
		}
	}
	
	if(Tklib_IsValidClient(client, true) && Tklib_IsValidClient(victim) && !IsSamePlayers(client, victim) && !IsSameTeam(client, victim))	{
		//There was an assist.
		if(Tklib_IsValidClient(assist, true))	{
			Session[assist].Assists++;
			Session[assist].Points = Session[assist].Points+AssistKill.IntValue;
			Format(query, sizeof(query), "update `%s` set Assists = Assists+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[assist], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(AssistKill.IntValue > 0)	{
				Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%s' and ServerID='%i'",
				playerlist, SteamID[assist], ServerID.IntValue);
				db.Query(DBQuery_Callback, query);
				
					//Optimize the servers performance, combining the callback inside the chat print may lag the server for a slight second.
				int assist_points = GetClientPoints(SteamID[assist]);
				CPrintToChat(client, "%s %t", Prefix, "Assist Kill Event", Name[assist], assist_points, points, Name[client], Name[victim]);
			}
		}
		
		//Make sure to not query updates on a bot, the database wont be happy about that.
		if(!IsFakeClient(victim))	{
			Format(query, sizeof(query), "update `%s` set Deaths = Deaths+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[victim], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Death.IntValue > 0)	{
				Session[victim].Points = Session[victim].Points-Death.IntValue;
				Format(query, sizeof(query), "update `%s` set Points = Points-%i where SteamID='%s' and ServerID='%i'",
				playerlist, Death.IntValue, SteamID[victim], ServerID.IntValue);
				db.Query(DBQuery_Callback, query);
			}
		}
		
		Session[client].Kills++;
		Format(query, sizeof(query), "update `%s` set Kills = Kills+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
		
		//If the inflictor entity is a building.
		switch(TF2_IsEntityBuilding(inflictor))	{
			case	true:	{
				switch(TF2_GetBuildingType(inflictor))	{
					case	TFBuilding_Dispenser:	{
						if(Debug.BoolValue)	{
							PrintToServer(" ");
							PrintToServer("Building: Dispenser (?!)");
						}
					}
					case	TFBuilding_Sentrygun:	{
						Session[client].MiniSentryKills++;
						Format(query, sizeof(query), "update `%s` set SentryKills = SentryKills+1 where SteamID='%s' and ServerID='%i'",
						playerlist, SteamID[client], ServerID.IntValue);
						db.Query(DBQuery_Callback, query);
						
						if(Debug.BoolValue)	{
							PrintToServer(" ");
							PrintToServer("Building: Sentry");
						}
					}
					case	TFBuilding_MiniSentry:	{
						Session[client].SentryKills++;
						Format(query, sizeof(query), "update `%s` set MiniSentryKills = MiniSentryKills+1 where SteamID='%s' and ServerID='%i'",
						playerlist, SteamID[client], ServerID.IntValue);
						db.Query(DBQuery_Callback, query);
						
						if(Debug.BoolValue)	{
							PrintToServer(" ");
							PrintToServer("Building: Mini-Sentry");
						}
					}
				}
			}
			case	false:	{
				switch(telefrag)	{
					case	true:	{
						Session[client].TeleFrags++;
						Format(query, sizeof(query), "update `%s` set TeleFrags = TeleFrags+1 where SteamID='%s' and ServerID='%i'",
						playerlist, SteamID[client], ServerID.IntValue);
						db.Query(DBQuery_Callback, query);
						
						if(Debug.BoolValue)	{
							PrintToServer(" ");
							PrintToServer("Telefrag");
						}
					}
					case	false:	{
						Format(query, sizeof(query), "update `%s` set Kills_%s = Kills_%s+1 where SteamID='%s' and ServerID='%i'",
						playerlist, fix_weapon, fix_weapon, SteamID[client], ServerID.IntValue);
						db.Query(DBQuery_Callback, query);
					}
				}
			}
		}
		
		if(headshot)	{
			Session[client].Headshots++;
			Format(query, sizeof(query), "update `%s` set Headshots = Headshots+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Headshot");
			}
		}
		
		if(backstab)	{
			Session[client].Backstabs++;
			Format(query, sizeof(query), "update `%s` set Backstabs = Backstabs+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Backstab");
			}
		}
		
		if(dominated)	{
			Session[client].Dominations++;
			Format(query, sizeof(query), "update `%s` set Dominations = Dominations+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Dominated");
			}
		}
		
		if(revenge)	{
			Session[client].Revenges++;
			Format(query, sizeof(query), "update `%s` set Revenges = Revenges+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Backstab");
			}
		}
		
		if(noscope)	{
			Session[client].Noscopes++;
			Format(query, sizeof(query), "update `%s` set Noscopes = Noscopes+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Noscope");
			}
		}
		
		if(tauntkill)	{
			Session[client].TauntKills++;
			Format(query, sizeof(query), "update `%s` set TauntKills = TauntKills+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Tauntkill");
			}
		}
		
		if(deflectkill)	{
			Session[client].DeflectKills++;
			Format(query, sizeof(query), "update `%s` set DeflectKills = DeflectKills+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Deflectkill");
			}
		}
		
		if(gibkill)	{
			Session[client].GibKills++;
			Format(query, sizeof(query), "update `%s` set GibKills = GibKills+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
			
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Gibkill");
			}
		}
		
		switch(crits)	{
			case	TFCritType_Minicrit:	{
				Session[client].MiniCritKills++;
				Format(query, sizeof(query), "update `%s` set MiniCritKills = MiniCritKills+1 where SteamID='%s' and ServerID='%i'",
				playerlist, SteamID[client], ServerID.IntValue);
				db.Query(DBQuery_Callback, query);
				
				if(Debug.BoolValue)	{
					PrintToServer(" ");
					PrintToServer("Mini-Crit");
				}
			}
			case	TFCritType_Crit:	{
				Session[client].CritKills++;
				Format(query, sizeof(query), "update `%s` set CritKills = CritKills+1 where SteamID='%s' and ServerID='%i'",
				playerlist, SteamID[client], ServerID.IntValue);
				db.Query(DBQuery_Callback, query);
				
				if(Debug.BoolValue)	{
					PrintToServer(" ");
					PrintToServer("Crit");
				}
			}
		}
		
		Session[client].Points = Session[client].Points+points;
		
		if(points > 0)	{
			if(Debug.BoolValue)	{
				PrintToServer(" ");
				PrintToServer("Processing kill message..");
			}
			
			Format(query, sizeof(query), "update `%s` set Points = Points+%i where SteamID='%i' and ServerID='%i'",
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
			else if(backstab)
				Kill_Scenario = 6;
			else if(telefrag)
				Kill_Scenario = 8;
			
			char scenario[64];
			if(Kill_Scenario > 0)	{
				//fix the format.
				Format(scenario, sizeof(scenario), "%t{default}", Kill_Type[Kill_Scenario]);
			}
			
			switch(IsValidString(scenario))	{
				case	true:	CPrintToChat(client, "%s %t", Prefix, "Kill Event 1", Name[client], points_client, points, Name[victim], scenario);
				case	false:	CPrintToChat(client, "%s %t", Prefix, "Kill Event 2", Name[client], points_client, points, Name[victim]);
			}
		}
		
		if(!IsFakeClient(victim))	{
			char log[2048];
			int len = 0;
			len += Format(log[len], sizeof(log)-len, "insert into `%s`", kill_log);
			len += Format(log[len], sizeof(log)-len, "(ServerID, Playername, SteamID, Victim_Playername, Victim_SteamID, Assister_Playername, Assister_SteamID, Weapon, Headshot, Noscope, Midair, CritType)");
			len += Format(log[len], sizeof(log)-len, "values");
			len += Format(log[len], sizeof(log)-len, "('%i', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%i', '%i', `%i`, `%i`)",
			ServerID.IntValue, Playername[client], SteamID[client], Playername[victim], SteamID[victim], Playername[assist], SteamID[assist], weapon, headshot, noscope, midair, crits);
			db.Query(DBQuery_Kill_Log, log);
		}
	}
}

stock void Teamplay_Point_Captured(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!PluginActive.BoolValue || !RoundActive || TF2_PointCaptured.IntValue < 0)
		return;
	
	char query[256], cpname[64], cappers[MAXPLAYERS];
	event.GetString(EVENT_STR_CPNAME, cpname, sizeof(cpname));
	event.GetString(EVENT_STR_CAPPERS, cappers, MAXPLAYERS);
	int points = TF2_PointCaptured.IntValue;
	
	for(int i = 0; i < strlen(cappers); i++)	{
		int client = cappers[i];
		
		if(Tklib_IsValidClient(client, true))	{
			GetClientAuth(client, SteamID[client], sizeof(SteamID[]));
			GetClientNameEx(client, Playername[client], sizeof(Playername[]));
			GetClientTeamString(client, Name[client], sizeof(Name[]));
			
			int points_client = GetClientPoints(SteamID[client]);
			CPrintToChat(client, "%s %t", Prefix, "Point Captured", Name[client], points_client, points, cpname);
			
			Format(query, sizeof(query), "update `%s` set PointsCaptured = PointsCaptured+1 where SteamID='%s' and ServerID='%i'",
			playerlist, SteamID[client], ServerID.IntValue);
			db.Query(DBQuery_Callback, query);
		}
	}
}

stock void Teamplay_Capture_Blocked(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!PluginActive.BoolValue || !RoundActive || TF2_PointBlocked.IntValue < 0)
		return;
	
	char query[256], cpname[64];
	event.GetString(EVENT_STR_CPNAME, cpname, sizeof(cpname));
	
	int client = event.GetInt(EVENT_STR_BLOCKER);
	int victim = event.GetInt(EVENT_STR_VICTIM);
	int points = TF2_PointBlocked.IntValue;
	
	if(Tklib_IsValidClient(client, true) && Tklib_IsValidClient(victim) && (TF2_GetGameType() == TFGameType_CP || TF2_GetGameType() == TFGameType_Arena))	{
		if(IsFakeClient(victim) && !AllowBots.BoolValue)
			return;
		
		GetClientAuth(client, SteamID[client], sizeof(SteamID[]));
		GetClientNameEx(client, Playername[client], sizeof(Playername[]));
		GetClientTeamString(client, Name[client], sizeof(Name[]));
		GetClientTeamString(victim, Name[victim], sizeof(Name[]));
		
		int points_client = GetClientPoints(SteamID[client]);
		CPrintToChat(client, "%s %t", Prefix, "Point Defended", Name[client], points_client, points, cpname, Name[victim]);
		
		Format(query, sizeof(query), "update `%s` set PointsDefended = PointsDefended+1 where SteamID='%s' and ServerID='%i'",
		playerlist, SteamID[client], ServerID.IntValue);
		db.Query(DBQuery_Callback, query);
	}
}

stock void Teamplay_Flag_Event(Event event, const char[] event_name, bool dontBroadcast)	{
	if(!PluginActive.BoolValue || !RoundActive || TF2_GetGameType() != TFGameType_CTF)
		return;
	
	char query[512];
	int client = event.GetInt(EVENT_STR_PLAYER);
	int carrier = event.GetInt(EVENT_STR_CARRIER);
	int eventtype = event.GetInt(EVENT_STR_EVENTTYPE);
	bool home = event.GetBool(EVENT_STR_HOME);
	TFTeam team = TFTeam(event.GetInt(EVENT_STR_TEAM));
	
	if(Debug.BoolValue)	{
		char teamname[][] = {
			/* 0 */ "Unassigned",
			/* 1 */ "SPEC",
			/* 2 */ "BLU",
			/* 3 */ "RED"
		};
		
		PrintToServer("//===== Teamplay_Flag_Event =====//");
		PrintToServer("player %N (%i)", client, client);
		PrintToServer("carrier %N (%i)", carrier, carrier);
		PrintToServer("eventtype %s", TF2_GetFlagTypeName[eventtype]);
		PrintToServer("home %s", Bool[home]);
		PrintToServer("teamname %s", teamname[team]);
		PrintToServer(" ");
	}
	
	if(Tklib_IsValidClient(client, true) && TF2_FlagEvent[eventtype].IntValue > 0)	{
		GetClientAuth(client, SteamID[client], sizeof(SteamID[]));
		GetClientTeamString(client, Name[client], sizeof(Name[]));
		int points = TF2_FlagEvent[eventtype].IntValue;
		int points_client = GetClientPoints(SteamID[client]);
		
		switch(TFFlag(eventtype))	{
			/* Flag was picked up */
			case	TFFlag_PickedUp:	{
				switch(home)	{
					/* Flag was stolen */
					case	true:	{
						points = points+TF2_FlagStolen.IntValue;
						Session[client].FlagsStolen++;
						Session[client].FlagsPickedUp++;
						Session[client].Points = Session[client].Points+points;
						CPrintToChat(client, "%s %t", Prefix, "Flag Stolen", Name[client], points_client, points);
						
						Format(query, sizeof(query), "update `%s` Points = Points+%i, FlagsPickedUp = FlagsPickedUp+1, FlagsStolen = FlagsStolen+1 where SteamID='%s' and ServerID='%i'",
						playerlist, points, SteamID[client], ServerID.IntValue); 
						db.Query(DBQuery_Callback, query);
					}
					/* Flag was not stolen (phew, that was close) */
					case	false:	{
						Session[client].FlagsPickedUp++;
						Session[client].Points = Session[client].Points+points;
						CPrintToChat(client, "%s %t", Prefix, "Flag Picked Up", Name[client], points_client, points);
						
						Format(query, sizeof(query), "update `%s` Points = Points+%i, FlagsPickedUp = FlagsPickedUp+1 where SteamID='%s' and ServerID='%i'",
						playerlist, points, SteamID[client], ServerID.IntValue); 
						db.Query(DBQuery_Callback, query);
					}
				}
			}
			/* Flag was captured */
			case	TFFlag_Captured:	{
				Session[client].FlagsCaptured++;
				Session[client].Points = Session[client].Points+points;
				CPrintToChat(client, "%s %t", Prefix, "Flag Captured", Name[client], points_client, points);
				
				Format(query, sizeof(query), "update `%s` Points = Points+%i, FlagsCaptured = FlagsCaptured+1 where SteamID='%s' and ServerID='%i'",
				playerlist, points, SteamID[client], ServerID.IntValue);
				db.Query(DBQuery_Callback, query);
			}
			/* Flag was defended */
			case	TFFlag_Defended:	{
				Session[client].FlagsDefended++;
				Session[client].Points = Session[client].Points+points;
				CPrintToChat(client, "%s %t", Prefix, "Flag Defended", Name[client], points_client, points);
				
				Format(query, sizeof(query), "update `%s` Points = Points+%i, FlagsDefended = FlagsCaptured+1 where SteamID='%s' and ServerID='%i'",
				playerlist, points, SteamID[client], ServerID.IntValue);
				db.Query(DBQuery_Callback, query);
			}
			/* Flag was dropped */
			case	TFFlag_Dropped:	{
				Session[client].FlagsDropped++;
				Session[client].Points = Session[client].Points+points;
				CPrintToChat(client, "%s %t", Prefix, "Flag Dropped", Name[client], points_client, points);
				
				Format(query, sizeof(query), "update `%s` Points = Points-%i where SteamID='%s' and ServerID='%i'",
				playerlist, points, SteamID[client], ServerID.IntValue);
				db.Query(DBQuery_Callback, query);
			}
		}
	}
}