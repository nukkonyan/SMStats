//===========================================//
// xstats__OnRoundBegin
//===========================================//

public void Xstats_OnRoundBegin()	{
	CheckActivePlayers();
}

//===========================================//
// xstats_OnRoundEnds
//===========================================//

public void Xstats_OnRoundEnd()	{
	CheckActivePlayers();
}

//===================================================================================//
// Xstats_TF2_CTF_Event
//===================================================================================//

//Lets prevent points farming exploit capability.
float	CTF_Float	=	30.0;
bool	CTF_CapAllowed[MAXPLAYERS+1]	=	{true, ...};
bool	CTF_DefendAllowed[MAXPLAYERS+1]	=	{true, ...};
bool	CTF_PickupAllowed[MAXPLAYERS+1]	=	{true, ...};

public void Xstats_TF2_CTF_Event(int client, int carrier, int eventtype, bool home, TFTeam team)	{
	if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() != TF2_GameMode_CTF)
		return;
	
	if(xstats.IsValidClient(client, true) && IsValidProcedure())	{
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
	
		if(xstats.IsValidClient(carrier) && IsFakeClient(client) && !xstats.CountBots())
			return;
		
		//Make sure the flag was atleast part of red or blue team.
		if(team < TFTeam_Red)
			return;
		
		switch(eventtype)	{
			case	TFFlag_Captured:	{
				if(!CTF_CapAllowed[client])
					return;
				
				CTF_CapAllowed[client] = false;
				CreateTimer(CTF_Float, CTF_CapReset, client);
				
			}
			case	TFFlag_Defended:	{
				if(!CTF_DefendAllowed[client])
					return;
				
				CTF_DefendAllowed[client] = false;
				CreateTimer(CTF_Float, CTF_DefendReset, client);
			}
			case	TFFlag_PickedUp:	{
				if(!CTF_PickupAllowed[client])
					return;
				
				CTF_PickupAllowed[client] = false;
				CreateTimer(CTF_Float, CTF_PickupReset, client);
			}
		}
		
		char client_name[64], carrier_name[64], flag_event[128], auth_client[64], auth_carrier[64];
		GetClientAuth(client, auth_client, sizeof(auth_client));
		GetClientAuth(carrier, auth_carrier, sizeof(auth_carrier));
		GetClientTeamString(client, client_name, sizeof(client_name));
		GetClientTeamString(carrier, carrier_name, sizeof(carrier_name));
		
		switch(eventtype)	{
			case	TFFlag_PickedUp:	Format(flag_event, sizeof(flag_event), "%t{default}", home ? "CTF Event Type 1":"CTF Event Type 2");
			case	TFFlag_Captured:	Format(flag_event, sizeof(flag_event), "%t{default}", "CTF Event Type 3");
			case	TFFlag_Defended:	Format(flag_event, sizeof(flag_event), "%t{default}", "CTF Event Type 4");
		}
		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
		
		switch(eventtype)	{
			//Picked up.
			case	TFFlag_PickedUp:	{
				ApplyUpdate("FlagsTaken", true, 1, auth_client);
				
				if(CTF_Event[1].IntValue > 0)	{
					ApplyUpdate("Points", true, CTF_Event[1].IntValue, auth_client);
					CPrintToChat(client, "%s %t", Prefix, "CTF Event 1", client_name, client_points, CTF_Event[1].IntValue, flag_event, Xstats_TF2_TeamName[team]);
				}
			}
			//Captured.
			case	TFFlag_Captured:	{
				ApplyUpdate("FlagsCaptured", true, 1, auth_client);
				
				if(CTF_Event[2].IntValue > 0)	{
					ApplyUpdate("Points", true, CTF_Event[1].IntValue, auth_client);
					CPrintToChat(client, "%s %t", Prefix, "CTF Event 1", client_name, client_points, CTF_Event[2].IntValue, flag_event, Xstats_TF2_TeamName[team]);
				}
			}
			//Defended.
			case	TFFlag_Defended:	{
				if(xstats.IsValidClient(carrier))	{
					ApplyUpdate("FlagsDefended", true, 1, auth_client);
					
					if(CTF_Event[3].IntValue > 0)	{
						ApplyUpdate("Points", true, CTF_Event[3].IntValue, auth_client);
							
						switch(IsFakeClient(carrier))	{
							//The carrier was a bot.
							case	true:
								CPrintToChat(client, "%s %t",
								Prefix, "CTF Event 2", client_name, client_points, CTF_Event[3].IntValue, flag_event, Xstats_TF2_TeamName[team], carrier_name, "Bot");
							
							//The carrier was not a bot.
							case	false:	{
								int carrier_points = xstats.GetClientPoints(carrier, Xstats_playerstats_tf2);
										
								CPrintToChat(client, "%s %t",
								Prefix, "CTF Event 2", client_name, client_points, CTF_Event[3].IntValue, flag_event, Xstats_TF2_TeamName[team], carrier_name, carrier_points);
										
								CPrintToChat(carrier, "%s %t",
								Prefix, "CTF Event 2", client_name, client_points, CTF_Event[3].IntValue, flag_event, Xstats_TF2_TeamName[team], carrier_name, carrier_points);
							}
						}
					}
				}
			}
				//Dropped. This will be presumabely populated later on.
			case	TFFlag_Dropped:	{
				//PrintToChatAll("flag was dropped.");
			}
		}
	}
}

Action CTF_CapReset(Handle timer, int client)	{
	CTF_CapAllowed[client] = true;
}

Action CTF_DefendReset(Handle timer, int client)	{
	CTF_DefendAllowed[client] = true;
}

Action CTF_PickupReset(Handle timer, int client)	{
	CTF_PickupAllowed[client] = true;
}

//===================================================================================//
// Xstats_TF2_CP_OnPlayerCaptureBlocked
//===================================================================================//

float	CapBlockedFloat	=	30.0;
bool	CapBlockedAllowed[MAXPLAYERS+1]	=	{true, ...};

public void Xstats_TF2_CP_OnPlayerCaptureBlocked(int client, int victim, char[] cpname)	{
	if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() != TF2_GameMode_CP)
		return;
	
	if(xstats.IsValidClient(client, true) && xstats.IsValidClient(victim) && IsValidProcedure())	{		
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
		
		if(CP_Event[1].IntValue < 0)
			return;
		
		if(!CapBlockedAllowed[client])
			return;
		
		CapBlockedAllowed[client] = false;
		CreateTimer(CapBlockedFloat, CapBlocked_Reset, client);
		
		char client_name[64], victim_name[64], auth_client[64], auth_victim[64];
		GetClientTeamString(client, client_name, sizeof(client_name));
		GetClientTeamString(victim, victim_name, sizeof(victim_name));
		GetClientAuth(client, auth_client, sizeof(auth_client));
		GetClientAuth(victim, auth_victim, sizeof(auth_victim));
		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
		
		switch(IsFakeClient(victim))	{
			//Victim is a bot.
			case	true:	CPrintToChat(client, "%s %t", Prefix, "CP Event 1", client_name, client_points, CP_Event[1].IntValue, cpname, victim_name, "Bot");
			//Victim is not a bot.
			case	false:	{
				char victim_points[128];
				IntToString(xstats.GetClientPoints(victim, Xstats_playerstats_tf2), victim_points, sizeof(victim_points));
						
				CPrintToChat(client, "%s %t", Prefix, "CP Event 1", client_name, client_points, CP_Event[1].IntValue, cpname, victim_name, victim_points);
				CPrintToChat(victim, "%s %t", Prefix, "CP Event 1", client_name, client_points, CP_Event[1].IntValue, cpname, victim_name, victim_points);
			}
		}
	}
}

Action CapBlocked_Reset(Handle timer, int client)	{
	CapBlockedAllowed[client] = true;
}

//===================================================================================//
// Xstats_TF2_CP_OnPlayerCaptured
//===================================================================================//

float	CapturedFloat	=	30.0;
bool	CapturedAllowed[MAXPLAYERS+1]	=	{true, ...};

public void Xstats_TF2_CP_OnPlayerCaptured(TFTeam team, char[] cpname, const char[] cappers)	{	
	if(!IsValidProcedure())
		return;	//Make sure it is first, since we don't want looping with this integrated, can cause minor lagspike(s).
	
	if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() != TF2_GameMode_CP)
		return;
	
	int len = strlen(cappers);
	for(int i = 0; i < len; i++)	{
		int client = cappers[i];
		
		//Make sure to 100% target the correct player.
		if(xstats.IsValidClient(client, true)  && TF2_GetClientTeam(client) == team && CP_Event[2].IntValue > 0)	{
			if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
				return;
			
			if(!CapturedAllowed[client])
				return;
			
			CapturedAllowed[client] = false;
			CreateTimer(CapturedFloat, Captured_Reset, client);
			
			char client_name[64], auth[64], capture[128];
			GetClientAuth(client, auth, sizeof(auth));
			GetClientTeamString(client, client_name, sizeof(client_name));
			Format(capture, sizeof(capture), "%t{default}", "CP Event Type 2");
			
			int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
				
			ApplyUpdate("Points", true, CP_Event[2].IntValue,  auth);				
			CPrintToChat(client, "%s %t", Prefix, "CP Event 2", client_name, client_points, CP_Event[2].IntValue, capture, cpname);
		}
	}
}

Action Captured_Reset(Handle timer, int client)	{
	CapturedAllowed[client] = true;
}

//===================================================================================//
// Xstats_TF2_MvM_OnBombDefended
//===================================================================================//

public void Xstats_TF2_MvM_OnBombDefended(int client)	{
	if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() != TF2_GameMode_MvM)
		return;
	
	if(xstats.IsValidClient(client) && !IsFakeClient(client) && MvM_Event[1].IntValue > 0 && IsValidProcedure())	{		
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
		
		char client_name[64], auth[64];
		GetClientAuth(client, auth, sizeof(auth));
		GetClientTeamString(client, client_name, sizeof(client_name));
		
		ApplyUpdate("Points", true, MvM_Event[1].IntValue, auth);
		ApplyUpdate("BombsDefended", true, 1, auth);

		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
		
		CPrintToChat(client, "%s %t", Prefix, "MvM Event 1", client_name, client_points, MvM_Event[1].IntValue);
	}
}

//===================================================================================//
// Xstats_TF2_OnPlayerDeath
//===================================================================================//

public void Xstats_TF2_OnPlayerDeath(int client,
									int victim,
									int assister,
									int customkill,
									int deathflags,
									int defindex,
									int weaponid,
									char[] classname,
									TFCritType crittype,
									bool rocketjump,
									bool headshot,
									bool backstab,
									bool noscope,
									bool suicide,
									bool tauntkill,
									bool domination,
									bool revenge,
									bool gibkill,
									bool silentkill,
									bool fakedeath,
									bool bleedkill,
									bool deflectkill)	{
	if(Feature[2].BoolValue && (Xstats_TF2_GetGameMode() == TF2_GameMode_Unknown || Xstats_TF2_GetGameMode() == TF2_GameMode_MvM))
		return;
	
	if(xstats.IsValidClient(client, true) && xstats.IsValidClient(victim) && !fakedeath && IsValidProcedure())	{
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
		
		if(IsFakeClient(victim) && !xstats.CountBots())
			return;
			
		char auth_client[64], auth_victim[64], auth_assister[64];
		GetClientAuth(client, auth_client, sizeof(auth_client));
		GetClientAuth(victim, auth_victim, sizeof(auth_victim));
		GetClientAuth(assister, auth_assister, sizeof(auth_assister));
		
		ApplyUpdate("Deaths", true, 1, auth_victim);
			
		switch(suicide)	{
			//The kill event was a suicide
			case	true:	{
				if(Kill_Event[7].IntValue > 0)	{
					ApplyUpdate("Points", false, Kill_Event[7].IntValue, auth_client);
					ApplyUpdate("Suicides", true, 1, auth_client);
					
					char client_name[128];
					GetClientTeamString(client, client_name, sizeof(client_name));
					
					int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
					
					CPrintToChat(client, "%s %t", Prefix, "Suicide Event", client_name, client_points, Kill_Event[7].IntValue);
				}
			}
			//The kill event wasn't a suicide.
			case	false:	{
				if(Kill_Weapon[defindex] == null && (!IsSentrygun(classname) || !IsMiniSentry(classname)))	{
					if(xstats.Debug())
						PrintToServer("[%s] Event Error: %N Killed %N with an unknown weapon with definition index of %d!", PLUGIN_NAME, client, victim, defindex);
					return;
				}
							
				if(xstats.IsValidClient(assister))	{
					ApplyUpdate("Assists", true, 1, auth_assister);
					if(Kill_Event[1].IntValue > 0)
						ApplyUpdate("Points", true, Kill_Event[1].IntValue, auth_assister);
				}
				
				switch(TF2_GetPlayerClass(victim))	{
					case	TFClass_Scout:		ApplyUpdate("ScoutsKilled",		true, 1, auth_client);
					case	TFClass_Soldier:	ApplyUpdate("SoldiersKilled",	true, 1, auth_client);
					case	TFClass_Pyro:		ApplyUpdate("PyrosKilled",		true, 1, auth_client);
					case	TFClass_DemoMan:	ApplyUpdate("DemosKilled",		true, 1, auth_client);
					case	TFClass_Heavy:		ApplyUpdate("HeaviesKilled",	true, 1, auth_client);
					case	TFClass_Engineer:	ApplyUpdate("EngineersKilled",	true, 1, auth_client);
					case	TFClass_Medic:		ApplyUpdate("MedicsKilled",		true, 1, auth_client);
					case	TFClass_Sniper:		ApplyUpdate("SnipersKilled",	true, 1, auth_client);
					case	TFClass_Spy:		ApplyUpdate("SpiesKilled",		true, 1, auth_client);
				}
				
				int class = view_as<int>(TF2_GetPlayerClass(victim));
				
				if(Kill_Class[class].IntValue > 0)
					ApplyUpdate("Points", false, Kill_Class[class].IntValue, auth_victim);
				
				if(headshot)	{
					ApplyUpdate("Headshots", true, 1, auth_client);
					
					if(Kill_Event[2].IntValue > 0)
						ApplyUpdate("Points", true, Kill_Event[2].IntValue, auth_client);
				}
			
				if(backstab)	{
					ApplyUpdate("Backstabs", true, 1, auth_client);
					
					if(Kill_Event[3].IntValue > 0)
						ApplyUpdate("Points", true, Kill_Event[3].IntValue, auth_client);
				}
				
				if(noscope)	{
					ApplyUpdate("Noscopes", true, 1, auth_client);
					
					if(Kill_Event[4].IntValue > 0)
						ApplyUpdate("Points", true, Kill_Event[4].IntValue, auth_client);
				}
		
				if(domination)	{
					ApplyUpdate("Dominations", true, 1, auth_client);
					
					if(Kill_Event[5].IntValue > 0)
						ApplyUpdate("Points", true, Kill_Event[5].IntValue, auth_client);
				}
				
				if(revenge)	{
					ApplyUpdate("Revenges", true, 1, auth_client);
					
					if(Kill_Event[6].IntValue > 0)
						ApplyUpdate("Points", true, Kill_Event[6].IntValue, auth_client);
				}
				
				switch(crittype)	{
					case	TFCritType_Minicrit:	ApplyUpdate("MiniCritKills", true, 1, auth_client);
					case	TFCritType_Crit:		ApplyUpdate("CritKills", true, 1, auth_client);
				}
				
				ApplyUpdate("Kills", true, 1, auth_client);
				UpdateWeaponStats(client, defindex, classname);
				
				//Now.. lets format the whole thing into a message for both the victim and client to see
				FormatKillMessage(client, victim, assister, defindex, classname, crittype, headshot, backstab, noscope, tauntkill, rocketjump, bleedkill, deflectkill);
			}
		}
	}
	
	if(xstats.Debug())	{
		for(int i = 0; i < MaxClients; i++)	{
			if(!xstats.IsValidClient(i))
				continue;
			
			if(IsClientOwner(i))	{
				char weaponname[128];
				libraries.GetWeaponName(weaponname, sizeof(weaponname), defindex);
				CPrintToChat(i, "%s Kill Event Debug Information: \nDefinition Index: %d \nWeapon name: %s \nWeapon Id: %d \nClassname: %s \nCustomkill: %d \nDeathflags: %d",
				Prefix, defindex, weaponname, weaponid, classname, customkill, deathflags);
			}
		}
	}
}

/**
 *	Returns true or false if the classname is a sentrygun.
 */
bool IsSentrygun(char[] classname)	{
	if(StrContains(classname, "obj_sentrygun", false) != -1)
		return	true;
	return	false;
}

/*
 *	Returns true or false if the classname is a minisentrygun.
 */
bool IsMiniSentry(char[] classname)	{
	if(StrContains(classname, "obj_minisentry", false) != -1)
		return	true;
	return	false;
}

void UpdateWeaponStats(int client, int defindex, char[] classname)	{			
	char auth[64];
	GetClientAuth(client, auth, sizeof(auth));
	
	if(IsSentrygun(classname))	{
		ApplyWeapon("SentrygunKills",										auth);	//Sentrygun.
		ApplyUpdate("Points",			true,	Kill_Weapon[7].IntValue,	auth);
		return;
	}
	
	if(IsMiniSentry(classname))	{
		ApplyWeapon("MiniSentryKills",										auth);	//Mini-Sentry.
		ApplyUpdate("Points",			true,	Kill_Weapon[142].IntValue,	auth);
		return;
	}
	
	//This is one hell of a list to manage..
	switch(defindex)	{
		case	0,190,660:		ApplyWeapon("BatKills",						auth);	//Bat.
		case	1,191:			ApplyWeapon("BottleKils",					auth);	//Botle.
		case	2,192:			ApplyWeapon("FireAxeKills",					auth);	//Fire Axe.
		case	3,193:			ApplyWeapon("KukriKills",					auth);	//Kukri.
		case	4,194:			ApplyWeapon("KnifeKills",					auth);	//Knife.
		case	5,195:			ApplyWeapon("FistsKills",					auth);	//Fists.
		case	6,196:			ApplyWeapon("ShovelKills",					auth);	//Shovel.
		case	7,197,662,795,804,884,893,902,911,960,969:			ApplyWeapon("WrenchKills",				auth);	//Wrench.
		case	8,198,1143:		ApplyWeapon("BonesawKills",					auth);	//Bonesaw.
		case	9,10,11,12,199,1141:								ApplyWeapon("ShotgunKills",				auth);	//Shotgun.
		case	13,200,669,799,808,888,897,906,915,964,973:			ApplyWeapon("ScattergunKills",			auth);	//Scattergun.
		case	14,201,664,792,801,881,890,899,908,957,966:			ApplyWeapon("SniperRifleKills",			auth);	//Sniper Rifle.
		case	15,202,654,793,802,850,882,891,900,909,958,967:		ApplyWeapon("MinigunKills",				auth);	//Minigun.
		case	16,203,1149:	ApplyWeapon("SMGKills",						auth);	//SMG.
		case	17,204:			ApplyWeapon("SyringeGunKills",				auth);	//Syringe Gun.
		case	18,205,237,658,800,809,889,898,907,916,965,974:		ApplyWeapon("RocketLauncherKills",		auth);	//Rocket Launcher.
		case	19,206,1007:	ApplyWeapon("GrenadeLauncherKills",			auth);	//Grenade Launcher.
		case	20,207,265,661,797,806,886,895,904,913,962,971:		ApplyWeapon("StickybombLauncherKills",	auth);	//Stickybomb Launcher.
		case	21,208,659,798,807,887,896,905,914,963,972:			ApplyWeapon("FlameThrowerKills",		auth);	//Flame Thrower.
		case	22,23,209:		ApplyWeapon("PistolKills",					auth);	//Pistol.
		case	24,210,1142:	ApplyWeapon("RevolverKills",				auth);	//Revolver.
		case	36:				ApplyWeapon("BlutsaugerKills",				auth);	//Blutsauger.
		case	37,1003:		ApplyWeapon("UbersawKills",					auth);	//Ubersaw.
		case	38,1000:		ApplyWeapon("AxtinguisherKills",			auth);	//Axtinguisher.
		case	39,1081:		ApplyWeapon("FlareGunKills",				auth);	//Flare Gun.
		case	40:				ApplyWeapon("BackBurnerKills",				auth);	//Back Burner.
		case	41:				ApplyWeapon("NataschaKills",				auth);	//Natascha.
		case	43:				ApplyWeapon("KGBKills",						auth);	//Killer Gloves of Boxing.
		case	44:				ApplyWeapon("SandmanKills",					auth);	//Sandman.
		case	45,1078:		ApplyWeapon("ForceANatureKills",			auth);	//Force-A-Nature.
		case	56,1005:		ApplyWeapon("HuntsmanKills",				auth);	//Huntsman.
		case	61,1006:		ApplyWeapon("AmbassadorKills",				auth);	//Ambassador.
		case	127:			ApplyWeapon("DirectHitKills",				auth);	//Direct-Hit.
		case	128:			ApplyWeapon("EqualizerKills",				auth);	//Equalizer.
		case	130:			ApplyWeapon("ScottishResistanceKills",		auth);	//Scottish Resistance.
		case	131,1144:		ApplyWeapon("CharginTargeKills",			auth);	//Chargin' Targe.
		case	132,1082:		ApplyWeapon("EyelanderKills",				auth);	//Eyelander.
		case	140,1086:		ApplyWeapon("WranglerKills",				auth);	//WranglerKills.
		case	141,1004:		ApplyWeapon("FrontierJusticeKills",			auth);	//Frontier Justice.
		case	142:			ApplyWeapon("GunslingerKills",				auth);	//Gunslinger.
		case	153:			ApplyWeapon("HomewreckerKills",				auth);	//Homewrecker.
		case	154:			ApplyWeapon("PainTrainKills",				auth);	//Pain Train.
		case	155:			ApplyWeapon("SouthernHospitality",			auth);	//Southern Hospitality.
		case	160,294:		ApplyWeapon("LugermorphKills",				auth);	//Lugermorph.
		case	161:			ApplyWeapon("BigKillKills",					auth);	//Big Kill.
		case	169:			ApplyWeapon("GoldenWrenchKills",			auth);	//Golden Wrench.
		case	171:			ApplyWeapon("TribalmansShivKills",			auth);	//Tribalman's Shiv.
		case	172:			ApplyWeapon("ScotmansSkullcutterKills",		auth);	//Scotman's Skullcutter.
		case	173:			ApplyWeapon("VitaSawKills",					auth);	//Vita-Saw.
		case	214:			ApplyWeapon("PowerjackKills",				auth);	//Powerjack.
		case	215:			ApplyWeapon("DegreaserKills",				auth);	//Degreaser.
		case	220:			ApplyWeapon("ShortstopKills",				auth);	//Shortstop.
		case	221,999:		ApplyWeapon("HolyMackerel",					auth);	//Holy Mackerel.
		case	224:			ApplyWeapon("LetrangerKills",				auth);	//L'etranger.
		case	225:			ApplyWeapon("YourEternalRewardKills",		auth);	//Your Eternal Reward.
		case	228,1085:		ApplyWeapon("BlackBoxKills",				auth);	//Black Box.
		case	230:			ApplyWeapon("SydneySleeperKills",			auth);	//Sydney Sleeper.
		case	232:			ApplyWeapon("BushwackaKills",				auth);	//Bushwacka.
		case	239,1084:		ApplyWeapon("GRUKills",						auth);	//Gloves of Running Urgently.
		case	264:			ApplyWeapon("FryingPanKills",				auth);	//Frying Pan.
		case	266:			ApplyWeapon("HHHHKills",					auth);	//Horseless Headless Horsemann's Headtaker.
		case	298:			ApplyWeapon("IronCurtainKills",				auth);	//Iron Curtain.
		case	304:			ApplyWeapon("AmputatorKills",				auth);	//Amputator.
		case	305,1079:		ApplyWeapon("CrusadersCrossbowKills",		auth);	//Crusader's Crossbow.
		case	307:			ApplyWeapon("UllapoolCaberKills",			auth);	//Ullapool Caber.
		case	308:			ApplyWeapon("LochNLoadKills",				auth);	//Loch-n-Load.
		case	310:			ApplyWeapon("WarriorsSpiritKills",			auth);	//Warror's Spirit.
		case	312:			ApplyWeapon("BrassBeastKills",				auth);	//Brass Beast.
		case	317:			ApplyWeapon("CandyCaneKills",				auth);	//Candy Cane.
		case	325:			ApplyWeapon("BostonBasherKills",			auth);	//Boston Basher.
		case	326:			ApplyWeapon("BackScratcherKills",			auth);	//Back Scratcher.
		case	327:			ApplyWeapon("ClaidheamhMorKills",			auth);	//Claidheamh Mór.
		case	329:			ApplyWeapon("JagKills",						auth);	//Jag.
		case	331:			ApplyWeapon("FistsOfSteelKills",			auth);	//Fists Of Steel.
		case	348:			ApplyWeapon("SharpenedVolcanoFragmentKills",auth);	//Sharpened Volcano Fragment.
		case	355:			ApplyWeapon("FanOWarKills",					auth);	//Fan O' War.
		case	357:			ApplyWeapon("HalfZatoichiKills",			auth);	//Half-Zatoichi.
		case	401:			ApplyWeapon("ShahanshahKills",				auth);	//Shahanshah.
		case	402:			ApplyWeapon("BazaarBargainKills",			auth);	//Bazaar Bargain.
		case	406:			ApplyWeapon("SplendidScreenKills",			auth);	//Splendid Screen.
		case	412:			ApplyWeapon("OverdoseKills",				auth);	//Overdose.
		case	413:			ApplyWeapon("SolemnVowKills",				auth);	//Solemn Vow.
		case	414:			ApplyWeapon("LiberyLauncherKills",			auth);	//Liberty Launcher.
		case	415:			ApplyWeapon("ReserveShooterKills",			auth);	//Reserve Shooter.
		case	416:			ApplyWeapon("MarketGardenerKills",			auth);	//Market Gardener.
		case	423:			ApplyWeapon("SaxxyKills",					auth);	//Saxxy.
		case	424:			ApplyWeapon("TomislavKills",				auth);	//Tomislav.
		case	425:			ApplyWeapon("FamilyBusinessKills",			auth);	//Family Business.
		case	426:			ApplyWeapon("EvictionsNoticeKills",			auth);	//Eviction's Notice.
		case	441:			ApplyWeapon("CowMangler6000Kills",			auth);	//Cow Mangler 6000.
		case	444:			ApplyWeapon("MantreadsKills",				auth);	//Mantreads.
		case	447:			ApplyWeapon("DisciplinaryActionKills",		auth);	//Disciplinary Action.
		case	448:			ApplyWeapon("SodaPopperKills",				auth);	//Soda Popper.
		case	449:			ApplyWeapon("WingerKills",					auth);	//Winger.
		case	450:			ApplyWeapon("AtomizerKills",				auth);	//Atomizer.
		case	452:			ApplyWeapon("ThreeRuneBladeKills",			auth);	//Three Rune Blade.
		case	457:			ApplyWeapon("PostalPummelerKills",			auth);	//Postal Pummeler.
		case	460:			ApplyWeapon("EnforcerKills",				auth);	//Enforcer.
		case	466:			ApplyWeapon("MaulKills",					auth);	//Maul.
		case	474:			ApplyWeapon("ConscentiousObjectorKills",	auth);	//Conscentious Objector.
		case	482:			ApplyWeapon("NessiesNineIron",				auth);	//Nessie's Nine Iron.
		case	513:			ApplyWeapon("OriginalKills",				auth);	//Original.
		case	525:			ApplyWeapon("DiamondbackKills",				auth);	//DiamondbackKills.
		case	526:			ApplyWeapon("MachinaKills",					auth);	//Machina.
		case	527:			ApplyWeapon("WidowmakerKills",				auth);	//Widowmaker.
		case	528:			ApplyWeapon("ShortCircuitKills",			auth);	//Short Circuit.
		case	572:			ApplyWeapon("UnarmedCombatKills",			auth);	//Unarmed Combat.
		case	587:			ApplyWeapon("ApocoFistsKills",				auth);	//Apoco-Fists.
		case	588:			ApplyWeapon("Pomson6000Kills",				auth);	//Pomson 6000.
		case	589:			ApplyWeapon("EurekaEffectKills",			auth);	//Eureka Effect.
		case	593:			ApplyWeapon("ThirdDegreeKills",				auth);	//Third Degree.
		case	595:			ApplyWeapon("ManmelterKills",				auth);	//Manmelter.
		case	609:			ApplyWeapon("ScottishHandshakeKills",		auth);	//Scottish Handshake.
		case	648:			ApplyWeapon("WrapAssassinKills",			auth);	//Wrap Assassin.
		case	656:			ApplyWeapon("HolidayPunchKills",			auth);	//Holiday Punch.
		case	730:			ApplyWeapon("BeggarsBazooka",				auth);	//Beggars Bazooka.
		case	739:			ApplyWeapon("LollichopKills",				auth);	//Lollichop.
		case	741:			ApplyWeapon("RainblowerKills",				auth);	//Rainblower.
		case	751:			ApplyWeapon("CleanersCarbineKills",			auth);	//Cleaner's Carbine.
		case	752:			ApplyWeapon("HitmansHeatmakerKills",		auth);	//Hitman's Heatmaker.
		case	772:			ApplyWeapon("BabyFacesBlasterKills",		auth);	//Baby Face's Blaster.
		case	773:			ApplyWeapon("PrettyBoysPocketPistolKills",	auth);	//Pretty Boy's Pocket Pistol.
		case	775:			ApplyWeapon("EscapePlanKills",				auth);	//Escape Plan.
		case	811,832:		ApplyWeapon("HuoLongHeaterKills",			auth);	//Huo-Long-Heater.
		case	812,833:		ApplyWeapon("FlyingGuillotineKills",		auth);	//Flying Guillotine.
		case	813,834:		ApplyWeapon("NeonAnnihilatorKills",			auth);	//Neon Annihilator.
		case	851:			ApplyWeapon("AWPerHandKills",				auth);	//AWPer Hand.
		case	880:			ApplyWeapon("FreedomStaffKills",			auth);	//Freedom Staff.
		case	939:			ApplyWeapon("BatOuttaHellKills",			auth);	//Bat Outta Hell.
		case	954:			ApplyWeapon("MemoryMakerKills",				auth);	//Memory Maker.
		case	996:			ApplyWeapon("LooseCannonKills",				auth);	//Loose Cannon.
		case	997:			ApplyWeapon("RescueRangerKills",			auth);	//Rescue Ranger.
		case	1013:			ApplyWeapon("HamShankKills",				auth);	//Ham Shank.
		case	1071:			ApplyWeapon("GoldenFryingPanKills",			auth);	//Golden Frying Pan.
		case	1092:			ApplyWeapon("FortifiedCompoundKills",		auth);	//Fortified Compound.
		case	1098:			ApplyWeapon("ClassicKills",					auth);	//Classic.
		case	1099:			ApplyWeapon("TideTurnerKills",				auth);	//Tide Turner.
		case	1100:			ApplyWeapon("BreadBiteKills",				auth);	//Bread Bite.
		case	1103:			ApplyWeapon("BackScatterKills",				auth);	//Back Scatter.
		case	1104:			ApplyWeapon("AirStrikeKills",				auth);	//Air Strike.
		case	1123:			ApplyWeapon("NecroSmasherKills",			auth);	//Necro Smasher.
		case	1150:			ApplyWeapon("QuickiebombLauncherKills",		auth);	//Quickiebomb Launcher.
		case	1151:			ApplyWeapon("IronBomberKills",				auth);	//Iron Bomber.
		case	1153:			ApplyWeapon("PanicAttackKills",				auth);	//Panic Attack.
		case	1178:			ApplyWeapon("DragonsFuryKills",				auth);	//Dragon's Fury.
		case	1179:			ApplyWeapon("ThermalThrusterKills",			auth);	//Thermal Thruster.
		case	1181:			ApplyWeapon("HotHandKills",					auth);	//Hot Hand.
		case	30474:			ApplyWeapon("NostromoNapalmerKills",		auth);	//Nostromo Napalmer.
		case	30665:			ApplyWeapon("ShootingStarKills",			auth);	//Shooting Star.
		case	30666:			ApplyWeapon("CapperKills",					auth);	//C.A.P.P.E.R.
		case	30668:			ApplyWeapon("GigarCounterKills",			auth);	//Gigar Counter.
		case	30758:			ApplyWeapon("PrinnyMacheteKills",			auth);	//Prinny Machete.
	}
	
	if(Kill_Weapon[defindex].IntValue > 0)
		ApplyUpdate("Points", true, Kill_Weapon[defindex].IntValue, auth);
}

void FormatKillMessage(int client,
						int victim,
						int assister,
						int defindex,
						char[] classname,
						TFCritType crittype,
						bool headshot,
						bool backstab,
						bool noscope,
						bool tauntkill,
						bool rocketjump,
						bool bleedkill,
						bool deflectkill)	{		
	if(Kill_Weapon[defindex].IntValue > 0)	{		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2), kill_type = 0, points = Kill_Weapon[defindex].IntValue;
		
		if(deflectkill)
			kill_type = 1;
		else if(xstats.IsClientMidAir(victim))	{
			kill_type = 2;
			if(Kill_Event[9].IntValue > 0)
				points = points+Kill_Event[9].IntValue;
		}
		else if(headshot && xstats.IsClientMidAir(victim))	{
			kill_type = 2;
			if(Kill_Event[2].IntValue > 0)
				points = points+Kill_Event[2].IntValue;
			if(Kill_Event[9].IntValue > 0)
				points = points+Kill_Event[9].IntValue;
		}
		else if(headshot)	{
			kill_type = 3;
			if(Kill_Event[2].IntValue > 0)
				points = points+Kill_Event[2].IntValue;
		}
		else if(backstab)	{
			kill_type = 4;
			if(Kill_Event[3].IntValue > 0)
				points = points+Kill_Event[3].IntValue;
		}
		else if(noscope)	{
			kill_type = 5;
			if(Kill_Event[4].IntValue > 0)
				points = points+Kill_Event[4].IntValue;
		}
		else if(tauntkill)	{
			kill_type = 6;
			if(Kill_Event[8].IntValue > 0)
				points = points+Kill_Event[8].IntValue;
		}
		else if(rocketjump)
			kill_type = 7;
		else if(bleedkill)
			kill_type = 8;
		
		//Translation fixing.
		
		//Lets make sure the client names are teamcoloured. Cleans up the code quite a bit..
		char client_name[64], victim_name[64], assister_name[64], auth_assister[64], kill_msg[128], weapon_name[128], victim_points[128];
		GetClientTeamString(client, client_name, sizeof(client_name));
		GetClientTeamString(victim, victim_name, sizeof(victim_name));
		GetClientTeamString(assister, assister_name, sizeof(assister_name));
		GetClientAuth(assister, auth_assister, sizeof(auth_assister));
		libraries.GetWeaponName(weapon_name, sizeof(weapon_name), defindex);
		
		//Makes sure what the player killed with was a sentry or not.
		if(IsSentrygun(classname))
			Format(weapon_name, sizeof(weapon_name), "Sentrygun");
		if(IsMiniSentry(classname))
			Format(weapon_name, sizeof(weapon_name), "Mini-Sentry");
		
		
		if(Feature[1].BoolValue && crittype > TFCritType_None)	{
			char Colour[3][64];
			CritTexts[crittype].GetString(Colour[crittype], sizeof(Colour[]));
			Format(weapon_name, sizeof(weapon_name), "%s%s{default}", Colour[crittype], weapon_name);
		}

		switch(kill_type)	{
			case	1:	Format(kill_msg, sizeof(kill_msg), "%t{default}", "Kill Event Type 1");
			case	2:	Format(kill_msg, sizeof(kill_msg), "%t{default}", "Kill Event Type 2");
			case	3:	Format(kill_msg, sizeof(kill_msg), "%t{default}", "Kill Event Type 3");
			case	4:	Format(kill_msg, sizeof(kill_msg), "%t{default}", "Kill Event Type 4");
			case	5:	Format(kill_msg, sizeof(kill_msg), "%t{default}", "Kill Event Type 5");
			case	6:	Format(kill_msg, sizeof(kill_msg), "%t{default}", "Kill Event Type 6");
			case	7:	Format(kill_msg, sizeof(kill_msg), "%t{default}", "Kill Event Type 7");
			case	8:	Format(kill_msg, sizeof(kill_msg), "%t{default}", "Kill Event Type 8");
		}
		
		//The message process.
		
		if(xstats.IsValidClient(assister, true))
			ApplyUpdate("Points", true, Kill_Event[1].IntValue, auth_assister);
		
		switch(IsFakeClient(victim))	{
			//The victim is a bot.
			case	true:	{
				switch(kill_type == 0)	{
					case	false:	CPrintToChat(client, "%s %t", Prefix, "Kill Event 1", client_name, client_points, points, victim_name, "Bot", kill_msg, weapon_name);
					case	true:	CPrintToChat(client, "%s %t", Prefix, "Kill Event 1.5", client_name, client_points, points, victim_name, "Bot", weapon_name);
				}
					
				//Make sure the assister isn't a bot. Could cause errors.
				if(xstats.IsValidClient(assister, true) && Kill_Event[1].IntValue > 0)	{
					int assister_points = xstats.GetClientPoints(assister, Xstats_playerstats_tf2);
					
					switch(kill_type == 0)	{
						case	false:	CPrintToChat(assister, "%s %t", Prefix, "Kill Event 1 Assister", assister_name, assister_points, Kill_Event[1].IntValue, victim_name, "Bot", kill_msg);
						case	true:	CPrintToChat(assister, "%s %t", Prefix, "Kill Event 1.5 Assister", assister_name, assister_points, Kill_Event[1].IntValue, victim_name, "Bot");
					}
				}
			}
				
			//The victim is not a bot.
			case	false:	{
				IntToString(xstats.GetClientPoints(victim, Xstats_playerstats_tf2), victim_points, sizeof(victim_points));
				
				switch(kill_type == 0)	{
					case	false:	{
						CPrintToChat(client, "%s %t", Prefix, "Kill Event 1", client_name, client_points, points, victim_name, victim_points, kill_msg, weapon_name);
						CPrintToChat(victim, "%s %t", Prefix, "Kill Event 1", client_name, client_points, points, victim_name, victim_points, kill_msg, weapon_name);
					}
					case	true:	{
						CPrintToChat(client, "%s %t", Prefix, "Kill Event 1.5", client_name, client_points, points, victim_name, victim_points, weapon_name);
						CPrintToChat(victim, "%s %t", Prefix, "Kill Event 1.5", client_name, client_points, points, victim_name, victim_points, weapon_name);
					}
				}
							
				//Once again make sure the assister isn't a bot. Could cause errors.
				if(xstats.IsValidClient(assister) && !IsFakeClient(assister) && Kill_Event[1].IntValue > 0)	{
					int assister_points = xstats.GetClientPoints(assister, Xstats_playerstats_tf2);
					
					switch(kill_type == 0)	{
						case	false:	CPrintToChat(assister, "%s %t", Prefix, "Kill Event 1 Assister", assister_name, assister_points, Kill_Event[1].IntValue, victim_name, victim_points, kill_msg);
						case	true:	CPrintToChat(assister, "%s %t", Prefix, "Kill Event 1.5 Assister", assister_name, assister_points, Kill_Event[1].IntValue, victim_name, victim_points);
					}
				}
			}
		}
	}
}

//===================================================================================//
// Xstats_TF2_OnPlayerTauntKill
//===================================================================================//

public void Xstats_TF2_OnPlayerTauntKill(int client, int victim, int assister, int defindex)	{
	if(Feature[2].BoolValue && (Xstats_TF2_GetGameMode() == TF2_GameMode_Unknown || Xstats_TF2_GetGameMode() == TF2_GameMode_MvM))
		return;
		
	if(xstats.IsValidClient(client) && !IsFakeClient(client) && xstats.IsValidClient(victim) && IsValidProcedure())	{		
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
		
		if(IsFakeClient(victim) && !xstats.CountBots())
			return;
		
		char auth[64];
		GetClientAuth(client, auth, sizeof(auth));
	
		ApplyUpdate("TauntKills", true, 1, auth);
	}
}

//===================================================================================//
// Xstats_TF2_OnBuildingDestroyed
//===================================================================================//

public void Xstats_TF2_OnBuildingDestroyed(int owner, int client, int assister, int defindex, TFBuilding building, bool beingbuilt)	{
	if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() == TF2_GameMode_Unknown)
		return;
	
	if(xstats.IsValidClient(client, true) && IsValidProcedure() && Building_Event[1].IntValue > 0)	{							
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
		
		if(xstats.IsValidClient(owner) && IsFakeClient(owner) && !xstats.CountBots())
			return;
			
		char buildingname[64], weaponname[64], owner_name[128], client_name[128], assister_name[128], auth_client[64], auth_assister[64];
		TF2_GetBuildingName(building, buildingname, sizeof(buildingname));
		GetClientTeamString(owner, owner_name, sizeof(owner_name));
		GetClientTeamString(client, client_name, sizeof(client_name));
		GetClientTeamString(assister, assister_name, sizeof(assister_name));
		GetClientAuth(client, auth_client, sizeof(auth_client));
		GetClientAuth(assister, auth_assister, sizeof(auth_assister));
		libraries.GetWeaponName(weaponname, sizeof(weaponname), defindex);
		
		switch(building)	{
			case	TFBuilding_Dispenser:				ApplyUpdate("DispensersDestroyed",			true, 1, auth_client);
			case	TFBuilding_Sentrygun:				ApplyUpdate("SentrygunsDestroyed",			true, 1, auth_client);
			case	TFBuilding_Teleporter_Entrance:		ApplyUpdate("TeleporterEntrancesDestroyed",	true, 1, auth_client);
			case	TFBuilding_Teleporter_Exit:			ApplyUpdate("TeleporterExitsDesstroyed",	true, 1, auth_client);
			case	TFBuilding_MiniSentry:				ApplyUpdate("MiniSentriesDestroyed",		true, 1, auth_client);
		}
		
		if(Building_Event[1].IntValue < 0)
			return;			
		
		ApplyUpdate("Points", true, Building_Event[1].IntValue, auth_client);
		
		if(xstats.IsValidClient(assister, true))
			ApplyUpdate("Points", true, Building_Event[1].IntValue, auth_assister);
		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
		
		switch(xstats.IsValidClient(owner))	{			
			//The owner is ingame/has an owner.
			case	true:	{
				switch(IsFakeClient(owner))	{
					//Owner is a bot.
					case	true:	CPrintToChat(client, "%s %t", Prefix, "Building Event 1", client_name, client_points, Building_Event[1].IntValue, buildingname, owner_name, "Bot", weaponname);
					
					//Owner is not a bot.
					case	false:	{
						char owner_points[128];
						IntToString(xstats.GetClientPoints(owner, Xstats_playerstats_tf2), owner_points, sizeof(owner_points));
											
						CPrintToChat(client, "%s %t", Prefix, "Building Event 1", client_name, client_points, Building_Event[1].IntValue, buildingname, owner_name, owner_points, weaponname);
						CPrintToChat(owner,  "%s %t", Prefix, "Building Event 1", client_name, client_points, Building_Event[1].IntValue, buildingname, owner_name, owner_points, weaponname);
					}
				}
				
				if(xstats.IsValidClient(assister, true))	{
					int assister_points = xstats.GetClientPoints(assister, Xstats_playerstats_tf2);
					
					char owner_points[128];
					IntToString(xstats.GetClientPoints(owner, Xstats_playerstats_tf2), owner_points, sizeof(owner_points));
					
					switch(IsFakeClient(owner))	{
						case	true:
							CPrintToChat(assister, "%s %t", Prefix, "Building Event 1 Assister", assister_name, assister_points, Building_Event[1].IntValue, buildingname, owner_name, "Bot");
						case	false:
							CPrintToChat(assister, "%s %t", Prefix, "Building Event 1 Assister", assister_name, assister_points, Building_Event[1].IntValue, buildingname, owner_name, owner_points);
					}
				}
			}
			
			//The owner is not ingame/no owner.
			case	false:	{
				CPrintToChat(client, "%s %t", Prefix, "Building Event 1.5", client_name, client_points, Building_Event[1].IntValue, buildingname, weaponname);
				
				if(xstats.IsValidClient(assister, true))	{
					int assister_points = xstats.GetClientPoints(assister, Xstats_playerstats_tf2);
					
					CPrintToChat(assister, "%s %t", Prefix, "Building Event 1.5 Assister", assister_name, assister_points, Building_Event[1].IntValue, buildingname);
				}
			}
		}
	}
}

//===================================================================================//
// Xstats_TF2_OnBuildingBuilt
//===================================================================================//

public void Xstats_TF2_OnBuildingBuilt(int client, TFBuilding building)	{
	if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() == TF2_GameMode_Unknown)
		return;
	
	if(xstats.IsValidClient(client, true) && IsValidProcedure() && Building_Event[view_as<int>(building)+2].IntValue > 0)	{
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
		
		char client_name[128], auth[64], buildingname[256];
		GetClientTeamString(client, client_name, sizeof(client_name));
		GetClientAuth(client, auth, sizeof(auth));
		TF2_GetBuildingName(building, buildingname, sizeof(buildingname));
		
		ApplyUpdate("Points", true, Building_Event[view_as<int>(building)+2].IntValue, auth);
		
		switch(building)	{
			case	TFBuilding_Dispenser:			ApplyUpdate("DispensersBuilt",			true, 1, auth);
			case	TFBuilding_Sentrygun:			ApplyUpdate("SentrygunsBuilt",			true, 1, auth);
			case	TFBuilding_Teleporter_Entrance:	ApplyUpdate("TeleporterEntrancesBuilt",	true, 1, auth);
			case	TFBuilding_Teleporter_Exit:		ApplyUpdate("TeleporterExitsBuilt",		true, 1, auth);
			case	TFBuilding_MiniSentry:			ApplyUpdate("MiniSentriesBuilt",		true, 1, auth);
		}
		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
		
		CPrintToChat(client, "%s %t", Prefix, "Building Event 2", client_name, client_points, Building_Event[view_as<int>(building)+2].IntValue, buildingname);
	}
}

//===================================================================================//
// Xstats_TF2_ItemFound
//===================================================================================//

public void Xstats_TF2_ItemFound(int client, int defindex, int qualityindex, char[] quality, int methodindex, char[] method)	{
	char query[256], auth[64];
	GetClientAuth(client, auth, sizeof(auth));
	int len = 0;
	len += Format(query[len], sizeof(query)-len, "INSERT INTO %s", Xstats_itemfound_tf2);
	len += Format(query[len], sizeof(query)-len, "(SteamID, DefIndex, QualityIndex, Quality, MethodIndex, Method)");
	len += Format(query[len], sizeof(query)-len, "VALUES");
	len += Format(query[len], sizeof(query)-len, "('%s', '%d', '%d', '%s', '%d', '%s')", auth, defindex, qualityindex, quality, methodindex, method);
	db.Query(DBQuery_ItemFound, query);
}

void DBQuery_ItemFound(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null && xstats.Debug())
		PrintToServer("[Xstats: Team Fortress 2] Inserting table onto item found table failed! (%s)", error);
}

//===================================================================================//
// Xstats_TF2_OnSandvichStolen
//===================================================================================//

//Lets prevent abusive points farming.
float	SandvichStolenFloat = 30.0;
bool	SandvichStolenAllow[MAXPLAYERS+1] = {true, ...};

public void Xstats_TF2_OnSandvichStolen(int client, int victim)	{
	if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() == TF2_GameMode_Unknown)
		return;
	
	if(xstats.IsValidClient(client, true) && xstats.IsValidClient(victim) && !IsSamePlayers(client, victim) && IsValidProcedure())	{
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
		
		if(IsFakeClient(victim) && !xstats.CountBots())
			return;
		
		if(!SandvichStolenAllow[client])
			return;
		
		SandvichStolenAllow[client] = false;
		CreateTimer(SandvichStolenFloat, SandvichStolenTimer_Reset, client);
		
		char client_name[64], victim_name[64];
		GetClientTeamString(client, client_name, sizeof(client_name));
		GetClientTeamString(victim, victim_name, sizeof(victim_name));
		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
		
		switch(IsFakeClient(victim))	{
			//Victim is a bot.
			case	true:	CPrintToChat(client, "%s %t", Prefix, "Sandvich Stolen Event", client_name, client_points, SandvichStolen.IntValue, victim_name, "Bot");
			//Victim isn't a bot.
			case	false:	{
				char victim_points[128];
				IntToString(xstats.GetClientPoints(victim, Xstats_playerstats_tf2), victim_points, sizeof(victim_points));
				
				CPrintToChat(client, "%s %t", Prefix, "Sandvich Stolen Event", client_name, client_points, SandvichStolen.IntValue, victim_name, victim_points);
				//CPrintToChat(victim, "%s %t", Prefix, "Sandvich Stolen Event", client_name, client_points, SandvichStolen.IntValue, victim_name, victim_points);
			}
		}
	}
}

Action SandvichStolenTimer_Reset(Handle plugin, int client)	{
	SandvichStolenAllow[client] = true;
}

//===================================================================================//
// Xstats_TF2_OnPlayerUbercharged
//===================================================================================//

//Lets prevent abusive points farming.
float	UberchargedFloat = 30.0;
bool	UberchargedAllow[MAXPLAYERS+1] = {true, ...};

public void Xstats_TF2_OnPlayerUbercharged(int client, int victim, int defindex)	{
	if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() == TF2_GameMode_Unknown)
		return;
	
	if(xstats.IsValidClient(client, true) && xstats.IsValidClient(victim) && OnPlayerUbercharged[defindex] == null)	{
		if(xstats.Debug())
			PrintToServer("[%s] Event error: Client %N has Ubercharged %N with an unknown weapon with definition index: %d!", PLUGIN_NAME, client, victim, defindex);
		return;
	}
		
	if(xstats.IsValidClient(client, true) && xstats.IsValidClient(victim) && IsValidProcedure() && OnPlayerUbercharged[defindex].IntValue > 0)	{			
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
		
		if(!OnPlayerUbercharged_Spy.BoolValue && !IsSameTeam(client, victim))
			return;
			
		if(IsFakeClient(victim) && !xstats.CountBots())
			return;
		
		if(!UberchargedAllow[client])
			return;
		
		UberchargedAllow[client] = false;
		CreateTimer(UberchargedFloat, UberchargedTimer_Reset, client);
			
		char client_name[128], victim_name[128], auth_client[64], auth_victim[64], weaponname[128];
		GetClientAuth(client, auth_client, sizeof(auth_client));
		GetClientAuth(victim, auth_victim, sizeof(auth_victim));
		GetClientTeamString(client, client_name, sizeof(client_name));
		GetClientTeamString(victim, victim_name, sizeof(victim_name));
		libraries.GetWeaponName(weaponname, sizeof(weaponname), defindex);
		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
		ApplyUpdate("Points", true, OnPlayerUbercharged[defindex].IntValue, auth_client);
			
		switch(IsFakeClient(victim))	{
			//The victim is a bot.
			case	true:	CPrintToChat(client, "%s %t", Prefix, "Ubercharged Player", client_name, client_points, OnPlayerUbercharged[defindex].IntValue, victim_name, "Bot", weaponname);
			//The victim is not a bot.
			case	false:	{
				char victim_points[128];
				IntToString(xstats.GetClientPoints(victim, Xstats_playerstats_tf2), victim_points, sizeof(victim_points));
						
				CPrintToChat(client, "%s %t", Prefix, "Ubercharged Player", client_name, client_points, OnPlayerUbercharged[defindex].IntValue, victim_name, victim_points, weaponname);
				CPrintToChat(victim, "%s %t", Prefix, "Ubercharged Player", client_name, client_points, OnPlayerUbercharged[defindex].IntValue, victim_name, victim_points, weaponname);
			}
		}
	}
}

Action UberchargedTimer_Reset(Handle plugin, int client)	{
	UberchargedAllow[client] = true;
}

//===================================================================================//
// Xstats_TF2_OnPlayerJarated
//===================================================================================//

//Lets prevent abusive points farming.
float	JaratedFloat = 30.0;
bool	JaratedAllow[MAXPLAYERS+1] = {true, ...};

public void Xstats_TF2_OnPlayerJarated(int client, int victim, int defindex)	{
	if(xstats.IsValidClient(client, true) && xstats.IsValidClient(victim) && OnPlayerJarated[defindex] == null)	{
		if(xstats.Debug())
			PrintToServer("[%s] Event error: Client %N has Coated %N with an unknown jar with definition index: %d!", PLUGIN_NAME, client, victim, defindex);
		return;
	}
	
	if(xstats.IsValidClient(client, true) && xstats.IsValidClient(victim) && IsValidProcedure() && OnPlayerJarated[defindex].IntValue > 0)	{		
		if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() == TF2_GameMode_Unknown)
			return;
		
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client, (Feature[3].IntValue == 2)))
			return;
		
		if(IsFakeClient(victim) && !xstats.CountBots())
			return;
		
		if(!JaratedAllow[client])
			return;
		
		//Make it possible to get multiple ones at once.
		CreateTimer(0.25, JaratedTimer_Disable, client);
		
		if(JaratedAllow[client])
			CreateTimer(JaratedFloat, JaratedTimer_Reset, client);
		
		char client_name[128], victim_name[128], auth_client[64], weaponname[128];
		GetClientTeamString(client, client_name, sizeof(client_name));
		GetClientTeamString(victim, victim_name, sizeof(victim_name));
		GetClientAuth(client, auth_client, sizeof(auth_client));
		libraries.GetWeaponName(weaponname, sizeof(weaponname), defindex);
		
		ApplyUpdate("Points", true, OnPlayerJarated[defindex].IntValue, auth_client);
		ApplyUpdate("CoatedEnemies", true, 1, auth_client);
		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);

		switch(IsFakeClient(victim))	{
			//It's a bot.
			case	true:	CPrintToChat(client, "%s %t", Prefix, "Coated Event", client_name, client_points, OnPlayerJarated[defindex].IntValue, victim_name, "Bot", weaponname);
			//It's not a bot.
			case	false:	{
				char victim_points[128];
				IntToString(xstats.GetClientPoints(victim, Xstats_playerstats_tf2), victim_points, sizeof(victim_points));
						
				CPrintToChat(client, "%s %t", Prefix, "Coated Event", client_name, client_points, OnPlayerJarated[defindex].IntValue, victim_name, victim_points, weaponname);
				CPrintToChat(victim, "%s %t", Prefix, "Coated Event", client_name, client_points, OnPlayerJarated[defindex].IntValue, victim_name, victim_points, weaponname);
			}
		}
	}
}

Action JaratedTimer_Disable(Handle timer, int client)	{
	JaratedAllow[client] = false;
}

Action JaratedTimer_Reset(Handle timer, int client)	{
	JaratedAllow[client] = true;
}

//===================================================================================//
// Xstats_TF2_OnPlayerExtinguished
//===================================================================================//

public void Xstats_TF2_OnPlayerExtinguished(int client, int victim, int defindex)	{
	if(xstats.IsValidClient(client, true) && xstats.IsValidClient(victim) && OnPlayerExtinguished[defindex] == null)	{
		if(xstats.Debug())
			PrintToServer("[%s] Event error: Client %N has Extinguished %N with an unknown weapon with definition index: %d!", PLUGIN_NAME, client, victim, defindex);
		return;
	}
	
	if(xstats.IsValidClient(client, true) && xstats.IsValidClient(victim) && IsValidProcedure() && OnPlayerExtinguished[defindex].IntValue > 0)	{			
		if(Feature[2].BoolValue && Xstats_TF2_GetGameMode() == TF2_GameMode_Unknown)
			return;
		
		if(Feature[3].IntValue > 0 && xstats.IsClientAbusive(client))
			return;
		
		if(IsFakeClient(victim) && !xstats.CountBots())
			return;
	
		char client_name[64], victim_name[64], auth_client[64], auth_victim[64];
		GetClientAuth(client, auth_client, sizeof(auth_client));
		GetClientAuth(victim, auth_victim, sizeof(auth_victim));
		GetClientTeamString(client, client_name, sizeof(client_name));
		GetClientTeamString(victim, victim_name, sizeof(victim_name));
		
		ApplyUpdate("Points", true, OnPlayerExtinguished[defindex].IntValue, auth_client);
		ApplyUpdate("ExtinguishedTeammates", true, 1, auth_client);
		
		char weaponname[256];
		libraries.GetWeaponName(weaponname, sizeof(weaponname), defindex);
		
		//If extinguished by an engineer's dispenser.
		if(StrContains(weaponname, "PDA", false) != -1)
			Format(weaponname, sizeof(weaponname), "Dispenser");
		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
		
		switch(IsFakeClient(victim))	{
			//It's a bot.
			case	true:	CPrintToChat(client, "%s %t", Prefix, "Extinguished Event", client_name, client_points, OnPlayerExtinguished[defindex].IntValue, victim_name, "Bot", weaponname);
			//It's not a bot.
			case	false:	{
				char victim_points[128];
				IntToString(xstats.GetClientPoints(victim, Xstats_playerstats_tf2), victim_points, sizeof(victim_points));
				
				CPrintToChat(client, "%s %t", Prefix, "Extinguished Event", client_name, client_points, OnPlayerExtinguished[defindex].IntValue, victim_name, victim_points, weaponname);
				CPrintToChat(victim, "%s %t", Prefix, "Extinguished Event", client_name, client_points, OnPlayerExtinguished[defindex].IntValue, victim_name, victim_points, weaponname);
			}
		}
	}
}