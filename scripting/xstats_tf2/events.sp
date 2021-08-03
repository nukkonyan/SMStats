void LoadEvents()	{
	//==================================//
	//				Events				//
	//////////////////////////////////////
	
	//============================================================================//
	// Rounds
	//============================================================================//
	
	HookEvent("teamplay_round_active", Event_RoundStart, EventHookMode_Pre);
		//When the round begins.
	
	HookEvent("teamplay_round_win", Event_RoundEnds, EventHookMode_Pre);
		//When the round begins.
	
	//============================================================================//
	// CTF events
	//============================================================================//
	
	HookEvent("teamplay_flag_event", Event_CTF_Event, EventHookMode_Pre);
		//Called when the flag is updated (taken, captured, dropped, etc).
		
	//============================================================================//
	// CP events
	//============================================================================//
	
	HookEvent("teamplay_capture_blocked", Event_CP_CaptureBlocked, EventHookMode_Pre);
		//Called when a capture point was blocked by opponent from capturing.
	
	HookEvent("teamplay_point_captured", Event_CP_Captured, EventHookMode_Pre);
		//Called when a capture point was captured.
	
	//============================================================================//
	// MvM events
	//============================================================================//
	
	HookEvent("mvm_kill_robot_delivering_bomb", Event_MvM_DefendBomb, EventHookMode_Pre);
		//Called when the player kills a robot wielding the bomb.
	
	//============================================================================//
	// Kill events
	//============================================================================//
	
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);
		//When a player dies. (Duh, Obviously).
	
	//============================================================================//
	// Buildings and/or Objects.
	//============================================================================//
	
	HookEvent("object_destroyed", Event_ObjectDestroyed, EventHookMode_Pre);
		//When a building is destroyed.
	
	HookEvent("player_builtobject", Event_ObjectBuilding, EventHookMode_Pre);
		//When a building is being built.
	
	//============================================================================//
	// Other events
	//============================================================================//
	HookEvent("item_found", Event_ItemFound, EventHookMode_Pre);
		//When an item was found, achieved or traded.
	
	HookEvent("player_invulned", Event_PlayerInvulned, EventHookMode_Pre);
		//When a medic übercharges their teammate/enemy spy.
	
	HookEvent("player_stealsandvich", Event_StealSandvich, EventHookMode_Pre);
		//When a sandvich gets stolen.
	
	//================================================================================================//
	//================================================================================================//
	//================================================================================================//
	
	
	//==================================//
	//			User messages			//
	//==================================//
	
	HookUserMessage(GetUserMessageId("PlayerJarated"), Event_PlayerJarated);
		//When a player throws a jarate on a target, used over the event action since it is broken/unused.
	
	HookUserMessage(GetUserMessageId("PlayerExtinguished"), Event_PlayerExtinguished);
		//When a player extinguishes their teammate, used over the event action since it is broken/unused.
	
	//============================================================================//
}

//==========================================================================//
//////////////////////////| teamplay_round_active |///////////////////////////
//==========================================================================//

void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)	{
	GlobalForward roundbegun = new GlobalForward("Xstats_OnRoundBegin", ET_Event);
	Call_StartForward(roundbegun);
	Call_Finish();
	delete roundbegun;
}

//==========================================================================//
////////////////////////////| teamplay_round_win |////////////////////////////
//==========================================================================//

void Event_RoundEnds(Event event, const char[] name, bool dontBroadcast)	{
	GlobalForward roundended = new GlobalForward("Xstats_OnRoundEnd", ET_Event);
	Call_StartForward(roundended);
	Call_Finish();
	delete roundended;
}

//==========================================================================//
///////////////////////////| teamplay_flag_event |////////////////////////////
//==========================================================================//

void Event_CTF_Event(Event event, const char[] name, bool dontBroadcast)	{
	GlobalForward flag = new GlobalForward("Xstats_TF2_CTF_Event", ET_Event, Param_Cell, Param_Cell, Param_Cell, Param_Cell, Param_Cell);
	Call_StartForward(flag);
	Call_PushCell(event.GetInt("player"));
	Call_PushCell(event.GetInt("carrier"));
	Call_PushCell(event.GetInt("eventtype"));
	Call_PushCell(event.GetInt("home"));
	Call_PushCell(event.GetInt("team"));
	Call_Finish();
	delete flag;
}

//==========================================================================//
///////////////////////| teamplay_capture_blocked |///////////////////////////
//==========================================================================//

void Event_CP_CaptureBlocked(Event event, const char[] name, bool dontBroadcast)	{
	GlobalForward blocked = new GlobalForward("Xstats_TF2_CP_OnPlayerCaptureBlocked", ET_Event, Param_Cell, Param_Cell, Param_String);
	Call_StartForward(blocked);
	Call_PushCell(event.GetInt("blocker"));
	Call_PushCell(event.GetInt("victim"));
	char cpname[128];
	event.GetString("cpname", cpname, sizeof(cpname));
	Call_PushString(cpname);
	Call_Finish();
	delete blocked;
}

//==========================================================================//
////////////////////////| teamplay_point_captured |///////////////////////////
//==========================================================================//

void Event_CP_Captured(Event event, const char[] name, bool dontBroadcast)	{
	GlobalForward captured = new GlobalForward("Xstats_TF2_CP_OnPlayerCaptured", ET_Event, Param_Cell, Param_String, Param_String);
	Call_StartForward(captured);
	Call_PushCell(event.GetInt("team"));
	char cpname[128];
	event.GetString("cpname", cpname, sizeof(cpname));
	Call_PushString(cpname);
	char cappers[MAXPLAYERS+1] = "";
	event.GetString("cappers", cappers, sizeof(cappers));
	Call_PushString(cappers);
	Call_Finish();
	delete captured;
}

//==========================================================================//
///////////////////////| mvm_kill_robot_delivering_bomb |////////////////////
//==========================================================================//

void Event_MvM_DefendBomb(Event event, const char[] name, bool dontBroadcast)	{
	GlobalForward defend = new GlobalForward("Xstats_TF2_MvM_OnBombDefended", ET_Event, Param_Cell);
	Call_StartForward(defend);
	Call_PushCell(event.GetInt("player"));
	Call_Finish();
	delete defend;
}

//==========================================================================//
//////////////////////////////| player_death |////////////////////////////////
//==========================================================================//

void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)	{
	int		client		= GetClientOfUserId(event.GetInt("attacker")),
			victim		= GetClientOfUserId(event.GetInt("userid")),
			assist		= GetClientOfUserId(event.GetInt("assister")),
			customkill	= event.GetInt("customkill"),
			defindex	= event.GetInt("weapon_def_index"),
			weaponid	= event.GetInt("weaponid"),
			crittype	= event.GetInt("crit_type"),
			deathflags	= event.GetInt("death_flags");
			
	bool	rocketjump	= event.GetBool("rocket_jump"),
			silentkill	= event.GetBool("silent_kill"),
			suicide		= (IsSamePlayers(client, victim) && IsSameTeam(client, victim) || customkill == 6),
			headshot	= (customkill == 1 || customkill == 51),
			backstab	= (customkill == 2),
			tauntkill	= (customkill == 7),
			noscope		= (customkill == 11),
			bleedkill	= (customkill == 34),
			domination	= (deathflags == 1),
			revenge		= (deathflags == 4),
			fakedeath	= (deathflags == 32),
			gibkill		= (deathflags == 128 || deathflags == 129),
			deflectkill = false;
	
	char classname[128];
	event.GetString("weapon_logclassname", classname, sizeof(classname));
	
	//The 'weapon_def_index' on the player_death is same as if you're gathering the killers current active weapon definition index and is NOT gathering the correct definition index at the time of the event.
	//So we need to manually correct them.
	//This happens when example throwing out a grenade launcher pill and then switch to your stickybomb launcher or melee, it'll pull the definition index out of that weapon instead.
	//This also just happens on certain weapons. Just dumb. tf2 team pls fix this bug.
	//PrintToServer("weaponid: %d", event.GetInt("weaponid"));
	
	switch(weaponid)	{
		//Kill event has no weapon id (for some reason).
		case	0:	{
			if(StrContains(classname, "taunt", false) != -1)
				tauntkill = true;
			if(StrEqual(classname, "armageddon", false))
				tauntkill = true;
			if(StrEqual(classname, "gas_blast", false))
				tauntkill = true;
			if(StrEqual(classname, "ball", false))	{
				switch(TF2_GetPlayerClass(client))	{
					case	TFClass_Scout:	defindex = GetWeaponDefinitionIndex(TF2_GetPlayerWeaponSlot(client, TFSlot_Melee));
					case	TFClass_Pyro:	defindex = GetWeaponDefinitionIndex(TF2_GetPlayerWeaponSlot(client, TFSlot_Primary));	//Pyro deflected the ball.
				}
			}
			if(StrEqual(classname, "loch_n_load", false))
				defindex = 308;
			if(StrEqual(classname, "tide_turner", false))
				defindex = 1099;
			if(StrEqual(classname, "quickiebomb_launcher", false))
				defindex = 1150;
			if(StrEqual(classname, "iron_bomber", false))
				defindex = 1151;
		}
		//Sandman.
		case	13:		defindex = 44;
		//Grenade Launcher.
		case	53:		defindex = 19;
		//Stickybomb Launcher.
		case	35:		{
			if(StrEqual(classname, "tf_projectile_pipe_remote", false))
				defindex = 20;
			if(StrEqual(classname, "sticky_resistance", false))
				defindex = 130;
		}
		case	61:	defindex = GetWeaponDefinitionIndex(TF2_GetPlayerWeaponSlot(client, TFSlot_Primary));
		default:	{
			//Make sure the event is really a deflect kill or not. We're not letting errors slip by freely, are we?.
			if(!deflectkill && (StrContains(classname, "deflect", false) != -1))
				deflectkill = true;
		}
	}
	
	if(bleedkill)
		defindex = GetWeaponDefinitionIndex(TF2_GetPlayerWeaponSlot(client, TFSlot_Melee));	//Only part of melee weapons.
	
	if(headshot)	{
		GlobalForward kill = new GlobalForward("Xstats_TF2_OnPlayerHeadshot", ET_Event,
		Param_Cell,		//client
		Param_Cell,		//victim
		Param_Cell,		//assist
		Param_Cell);	//defindex
		Call_StartForward(kill);
		Call_PushCell(client);
		Call_PushCell(victim);
		Call_PushCell(assist);
		Call_PushCell(defindex);
		Call_Finish();
		delete kill;
	}
	
	if(backstab)	{
		GlobalForward kill = new GlobalForward("Xstats_TF2_OnPlayerBackstab", ET_Event,
		Param_Cell,		//client
		Param_Cell,		//victim
		Param_Cell,		//assist
		Param_Cell);	//defindex
		Call_StartForward(kill);
		Call_PushCell(client);
		Call_PushCell(victim);
		Call_PushCell(assist);
		Call_PushCell(defindex);
		Call_Finish();
		delete kill;
	}
	
	if(tauntkill)	{
		GlobalForward kill = new GlobalForward("Xstats_TF2_OnPlayerTauntKill", ET_Event,
		Param_Cell,		//client
		Param_Cell,		//victim
		Param_Cell,		//assist
		Param_Cell);	//defindex
		Call_StartForward(kill);
		Call_PushCell(client);
		Call_PushCell(victim);
		Call_PushCell(assist);
		Call_PushCell(defindex);
		Call_Finish();
		delete kill;
	}
	
	if(noscope)	{
		GlobalForward kill = new GlobalForward("Xstats_TF2_OnPlayerNoscope", ET_Event, 
		Param_Cell,		//client
		Param_Cell,		//victim
		Param_Cell,		//assist
		Param_Cell);	//defindex
		Call_StartForward(kill);
		Call_PushCell(client);
		Call_PushCell(victim);
		Call_PushCell(assist);
		Call_PushCell(defindex);
		Call_Finish();
		delete kill;
	}
	
	GlobalForward death = new GlobalForward("Xstats_TF2_OnPlayerDeath", ET_Event,
	Param_Cell,		//client
	Param_Cell,		//victim
	Param_Cell,		//assist
	Param_Cell,		//customkill
	Param_Cell,		//deathflags
	Param_Cell,		//defindex
	Param_Cell,		//weaponid
	Param_String,	//classname
	Param_Cell,		//crittype
	Param_Cell,		//rocketjump
	Param_Cell,		//headshot
	Param_Cell,		//backstab
	Param_Cell,		//noscope
	Param_Cell,		//suicide
	Param_Cell,		//tauntkill
	Param_Cell,		//domination
	Param_Cell,		//revenge
	Param_Cell,		//gibkill
	Param_Cell,		//silentkill
	Param_Cell,		//fakedeath
	Param_Cell,		//bleedkill
	Param_Cell);	//deflectkill
	Call_StartForward(death);
	Call_PushCell(client);
	Call_PushCell(victim);
	Call_PushCell(assist);
	Call_PushCell(customkill);
	Call_PushCell(deathflags);
	Call_PushCell(defindex);
	Call_PushCell(weaponid);
	Call_PushString(classname);
	Call_PushCell(crittype);
	Call_PushCell(rocketjump);
	Call_PushCell(headshot);
	Call_PushCell(backstab);
	Call_PushCell(noscope);
	Call_PushCell(suicide);
	Call_PushCell(tauntkill);
	Call_PushCell(domination);
	Call_PushCell(revenge);
	Call_PushCell(gibkill);
	Call_PushCell(silentkill);
	Call_PushCell(fakedeath);
	Call_PushCell(bleedkill);
	Call_PushCell(deflectkill);
	Call_Finish();
	delete death;
}

//==========================================================================//
/////////////////////////| object_destroyed |/////////////////////////////////
//==========================================================================//

void Event_ObjectDestroyed(Event event, const char[] name, bool dontBroadcast)	{	
	GlobalForward destroyed = new GlobalForward("Xstats_TF2_OnBuildingDestroyed", ET_Event, Param_Cell, Param_Cell, Param_Cell, Param_Cell, Param_Cell, Param_Cell);
	Call_StartForward(destroyed);
	Call_PushCell(GetClientOfUserId(event.GetInt("userid")));
	Call_PushCell(GetClientOfUserId(event.GetInt("attacker")));
	Call_PushCell(GetClientOfUserId(event.GetInt("assister")));
	Call_PushCell(GetWeaponDefinitionIndex(GetClientActiveWeapon(GetClientOfUserId(event.GetInt("attacker")))));
	Call_PushCell(TF2_GetBuildingType(event.GetInt("index")));
	Call_PushCell(event.GetBool("was_building"));
	Call_Finish();
	delete destroyed;
}

//==========================================================================//
/////////////////////////| player_buildobject |///////////////////////////////
//==========================================================================//

void Event_ObjectBuilding(Event event, const char[] name, bool dontBroadcast)	{
	GlobalForward built = new GlobalForward("Xstats_TF2_OnBuildingBuilt", ET_Event, Param_Cell, Param_Cell);
	Call_StartForward(built);
	Call_PushCell(GetClientOfUserId(event.GetInt("userid")));
	Call_PushCell(TF2_GetBuildingType(event.GetInt("index")));
	Call_Finish();
	delete built;
}

//==========================================================================//
////////////////////////////| item_found |////////////////////////////////////
//==========================================================================//
void Event_ItemFound(Event event, const char[] name, bool dontBroadcast)	{
	if(event.GetBool("isfake"))	//Item is fake
		return; //This event bool doesn't exist in the game in general but you can force this event and use this.
		
	char quality[64];
	int item_quality = event.GetInt("quality");
	switch(item_quality)	{
		case	0:	quality = "Normal";
		case	1:	quality = "Genuine";
		case	3:	quality = "Vintage";
		case	5:	quality = "Unusual";
		case	6:	quality = "Unique";
		case	7:	quality = "Community";
		case	8:	quality = "Valve";
		case	9:	quality = "Self-Made";
		case	11:	quality = "Strange";
		case	12:	quality = "Unusual";
		case	13:	quality = "Haunted";
		case	14:	quality = "Collector's";
		//If the quality is unknown, lets make it into a digit string instead.
		default:	IntToString(item_quality, quality, sizeof(quality));
	}
	
	char method[64];
	int item_method = event.GetInt("method");
	switch(item_method)	{
		case	-1:	method = "Achieved";
		case	0:	method = "Found";
		case	1:	method = "Crafted";
		case	2:	method = "Traded";
		case	4:	method = "Unboxed";
		case	5:	method = "Gifted";
		case	8:	method = "Earned";
		case	9:	method = "Refunded";
		case	10:	method = "Wrapped Gift";
		//If the method is unknown, lets make it into a digit string instead.
		default:	IntToString(item_method, method, sizeof(method));
	}
	
	GlobalForward founditem = new GlobalForward("Xstats_TF2_ItemFound", ET_Event, Param_Cell, Param_Cell, Param_Cell, Param_String, Param_Cell, Param_String);
	Call_StartForward(founditem);
	Call_PushCell(event.GetInt("player"));
	Call_PushCell(event.GetInt("itemdef"));
	Call_PushCell(item_quality);
	Call_PushString(quality);
	Call_PushCell(item_method);
	Call_PushString(method);
	Call_Finish();
	delete founditem;
}

//==========================================================================//
//////////////////////////////| player_invulned |/////////////////////////////
//==========================================================================//

void Event_PlayerInvulned(Event event, const char[] name, bool dontBroadcast)	{
	GlobalForward ubercharge = new GlobalForward("Xstats_TF2_OnPlayerUbercharged", ET_Event, Param_Cell, Param_Cell, Param_Cell);
	Call_StartForward(ubercharge);
	Call_PushCell(GetClientOfUserId(event.GetInt("medic_userid")));
	Call_PushCell(GetClientOfUserId(event.GetInt("userid")));
	Call_PushCell(GetWeaponDefinitionIndex(TF2_GetPlayerWeaponSlot(GetClientOfUserId(event.GetInt("medic_userid")), TFSlot_Secondary)));
	Call_Finish();
	delete ubercharge;
}

//==========================================================================//
/////////////////////////////| player_stealsandvich |/////////////////////////
//==========================================================================//

void Event_StealSandvich(Event event, const char[] name, bool dontBroadcast)	{
	GlobalForward sandvich = new GlobalForward("Xstats_TF2_OnSandvichStolen", ET_Event, Param_Cell, Param_Cell);
	Call_StartForward(sandvich);
	Call_PushCell(GetClientOfUserId(event.GetInt("target")));
	Call_PushCell(GetClientOfUserId(event.GetInt("owner")));
	Call_Finish();
	delete sandvich;
}

//=========================================================================================================================================//
//User messages
//=========================================================================================================================================//

//==========================================================================//
//////////////////////////////| PlayerJarated |///////////////////////////////
//==========================================================================//
Action Event_PlayerJarated(UserMsg msg_id, Handle read, const players[], int playersNum, bool reliable, bool init)	{
	int client = BfReadByte(read);
	int victim = BfReadByte(read);
	
	//Need to use timer, otherwise it'll cause errors.
	DataPack pack = new DataPack();
	pack.WriteCell(client);
	pack.WriteCell(victim);
	CreateTimer(0.0, Timer_PlayerJarated, pack);
}

Action Timer_PlayerJarated(Handle timer, DataPack pack)	{
	pack.Reset();
	int client = pack.ReadCell();
	int victim = pack.ReadCell();
	
	GlobalForward dont_eat_the_yellow_snow = new GlobalForward("Xstats_TF2_OnPlayerJarated", ET_Event, Param_Cell, Param_Cell, Param_Cell);
	Call_StartForward(dont_eat_the_yellow_snow);
	
	Call_PushCell(client);
	Call_PushCell(victim);
	
	int defindex = 0;
	
	//Make sure no error will go through the servers console.
	if(xstats.IsValidClient(client))	{
		int jar = -1;
		if((jar = TF2_GetPlayerWeaponSlot(client, TFSlot_Secondary)) != -1)
			defindex = GetWeaponDefinitionIndex(jar);
	}
	Call_PushCell(defindex);
	
	Call_Finish();
	delete dont_eat_the_yellow_snow;
	delete pack;
}

//==========================================================================//
////////////////////////////| PlayerExtinguished |////////////////////////////
//==========================================================================//
Action Event_PlayerExtinguished(UserMsg msg_id, Handle read, const players[], int playersNum, bool reliable, bool init)	{
	int client = BfReadByte(read);
	int victim = BfReadByte(read);
	
	//Lets do the same trick on the OnPlayerJarated, seems to be an issue where if you activate a forward as soon the usermessage is called, it is 'invalid'. (Bug?)
	DataPack pack = new DataPack();
	pack.WriteCell(client);
	pack.WriteCell(victim);
	CreateTimer(0.0, Timer_PlayerExtinguished, pack);
}

Action Timer_PlayerExtinguished(Handle timer, DataPack pack)	{
	pack.Reset();
	int client = pack.ReadCell();
	int victim = pack.ReadCell();
	int defindex = -1;
	
	GlobalForward extinguish = new GlobalForward("Xstats_TF2_OnPlayerExtinguished", ET_Event, Param_Cell, Param_Cell, Param_Cell);
	Call_StartForward(extinguish);
	
	Call_PushCell(client);
	Call_PushCell(victim);	

	//Make sure no error will go through the servers console.
	if(xstats.IsValidClient(client))	{
		int weapon = -1;
		switch(TF2_GetPlayerClass(client))	{
			case	TFClass_Scout:	{
				//Mad milk is the answer. (Ceejaey reference.)
				if((weapon = TF2_GetPlayerWeaponSlot(client, TFSlot_Secondary)) != -1)
					defindex = GetWeaponDefinitionIndex(weapon);
			}
			case	TFClass_Soldier:	{
				//We'll see. (Buff banner or Concheror?)
				if((weapon = TF2_GetPlayerWeaponSlot(client, TFSlot_Secondary)) != -1)
					defindex = GetWeaponDefinitionIndex(weapon);
			}
			case	TFClass_Pyro:	{
				//Airblast :D (Or used manmelter)
				weapon = GetWeaponDefinitionIndex(GetClientActiveWeapon(client));
			}
			case	TFClass_DemoMan:	{
				//Nothin' here. (yet) :(
			}
			case	TFClass_Heavy:	{
				//Om nom nom, om nom. Sandvich makes me strong!.
				if((weapon = TF2_GetPlayerWeaponSlot(client, TFSlot_Secondary)) != -1)
					defindex = GetWeaponDefinitionIndex(weapon);
			}
			case	TFClass_Engineer:	{
				//Unknown, maybe perhaps dispenser?. /(That'd make it the pda index.)
				if((weapon = TF2_GetPlayerWeaponSlot(client, TFSlot_PDA)) != -1)
					defindex = GetWeaponDefinitionIndex(weapon);
			}
			case	TFClass_Medic:	{
				//Crossbow & mediguns can both extinguish.
				switch(GetWeaponDefinitionIndex(GetClientActiveWeapon(client)))	{
						//Crusader's Crossbow.
					case	305:	defindex = 305;
						//Festive Crusader's Crossbow.
					case	1079:	defindex = 1079;
						//The other mediguns.
					default:	{
						if((weapon = TF2_GetPlayerWeaponSlot(client, TFSlot_Secondary)) != -1)
							defindex = GetWeaponDefinitionIndex(weapon);
					}
				}
				
				
			}
			case	TFClass_Sniper:	{
				//Piss can extinguish.
				if((weapon = TF2_GetPlayerWeaponSlot(client, TFSlot_Secondary)) != -1)
					defindex = GetWeaponDefinitionIndex(weapon);
			}
			case	TFClass_Spy:	{
				//Nope. Lol. Imagine spy being able to extinguish teammates. That'd make him a broken class.
			}
		}
	}
	Call_PushCell(defindex);
	
	Call_Finish();
	delete extinguish;
	delete pack;
}


//=========================================================================================================================================//
// Other SourceMod-related events
//=========================================================================================================================================//


public void OnClientConnected(int client)	{
	if(xstats.IsValidClientEx(client, true))
		UpdatePlayerInfo(client);
}

public void OnClientDisconnect(int client)	{
	if(xstats.IsValidClientEx2(client, true))
		UpdatePlayerInfo(client);
}

void UpdatePlayerInfo(int client)	{
	char query[256], auth[64], name[64], ip[32];
	GetClientAuth(client, auth, sizeof(auth));
	GetClientNameEx(client, name, sizeof(name));
	GetClientIP(client, ip, sizeof(ip));
	Format(query, sizeof(query), "UPDATE %s SET LastOnline = CURRENT_TIMESTAMP, Playername = '%s', IPAddress = '%s' WHERE SteamID='%s'", Xstats_playerstats_tf2, name, ip, auth);
	db.Query(DBQuery_UpdatePlayerInfo, query);
}

void DBQuery_UpdatePlayerInfo(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)	{
		PrintToServer("[%s] Updating player info failed! (%s)", PLUGIN_NAME, error);
		return;
	}
}