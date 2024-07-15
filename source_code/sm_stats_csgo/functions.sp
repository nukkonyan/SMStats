void GetPlayerName(int client, char[] name, int maxlen, char[] name2, int maxlen2)
{
	switch(IsValidDeveloperType(client))
	{
		case 1: Format(name, maxlen, "{purple}%N{default}", client);
		case 2: Format(name, maxlen, "{cyan}%N{default}", client);
		case 3: Format(name, maxlen, "{orange}%N{default}", client);
		case 4: Format(name, maxlen, "{lightgreen}%N{default}", client);
		default:
		{
			if(!IsClientInGame(client))
			{
				Format(name, maxlen, "{grey}%N{default}", client);
				return;
			}
			//int team = GetEntProp(client, Prop_Send, "m_iTeamNum");
			int team = GetClientTeam(client);
			
			switch(team)
			{
				case 2: Format(name, maxlen, "{yellow}%N{default}", client);
				case 3: Format(name, maxlen, "{blue}%N{default}", client);
				default: Format(name, maxlen, "{grey}%N{default}", client);
			}
		}
	}
	
	Format(name2, maxlen2, "%N", client);
}

/**
 *	Fix the classnames & definition indexes to be correct.
 *
 *	@param	weapon		The string to copy to.
 *	@param	maxlen		The maximum length of the string.
 *	@param	itemdef		The weapon definition index to read.
 *	@param	classname	The weapon classname to read.
 */
stock void CorrectWeaponClassname(char[] weapon, int maxlen, int itemdef, const char[] classname)
{
	switch(itemdef)
	{
		case 1: strcopy(weapon, maxlen, "weapon_deagle");
		case 2: strcopy(weapon, maxlen, "weapon_elites");
		case 3: strcopy(weapon, maxlen, "weapon_fiveseven");
		case 4: strcopy(weapon, maxlen, "weapon_glock");
		case 7: strcopy(weapon, maxlen, "weapon_ak47");
		case 8: strcopy(weapon, maxlen, "weapon_aug");
		case 9: strcopy(weapon, maxlen, "weapon_awp");
		case 10: strcopy(weapon, maxlen, "weapon_famas");
		case 11: strcopy(weapon, maxlen, "weapon_g3sg1");
		case 13: strcopy(weapon, maxlen, "weapon_galilar");
		case 14: strcopy(weapon, maxlen, "weapon_m249");
		case 16: strcopy(weapon, maxlen, "weapon_m4a4");
		case 17: strcopy(weapon, maxlen, "weapon_mac10");
		case 19: strcopy(weapon, maxlen, "weapon_p90");
		case 23: strcopy(weapon, maxlen, "weapon_mp5sd");
		case 24: strcopy(weapon, maxlen, "weapon_ump45");
		case 25: strcopy(weapon, maxlen, "weapon_xm1014");
		case 26: strcopy(weapon, maxlen, "weapon_bizon");
		case 27: strcopy(weapon, maxlen, "weapon_mag7");
		case 28: strcopy(weapon, maxlen, "weapon_negev");
		case 29: strcopy(weapon, maxlen, "weapon_sawedoff");
		case 30: strcopy(weapon, maxlen, "weapon_tec9");
		case 31: strcopy(weapon, maxlen, "weapon_taser");
		case 32: strcopy(weapon, maxlen, "weapon_p2000");
		case 33: strcopy(weapon, maxlen, "weapon_mp7");
		case 34: strcopy(weapon, maxlen, "weapon_mp9");
		case 35: strcopy(weapon, maxlen, "weapon_nova");
		case 36: strcopy(weapon, maxlen, "weapon_p250");
		//case 37: strcopy(weapon, maxlen, "weapon_shield");
		case 38: strcopy(weapon, maxlen, "weapon_scar20");
		case 39: strcopy(weapon, maxlen, "weapon_sg553");
		case 40: strcopy(weapon, maxlen, "weapon_ssg08");
		case 41: strcopy(weapon, maxlen, "weapon_knife_gg");
		case 42: strcopy(weapon, maxlen, "weapon_knife_ct");
		case 43: strcopy(weapon, maxlen, "weapon_flashbang");
		case 44: strcopy(weapon, maxlen, "weapon_hegrenade");
		case 45: strcopy(weapon, maxlen, "weapon_smokegrenade");
		case 46: strcopy(weapon, maxlen, "weapon_molotov");
		case 47: strcopy(weapon, maxlen, "weapon_decoy");
		case 48: strcopy(weapon, maxlen, "weapon_incendiary");
		//case 49: strcopy(weapon, maxlen, "weapon_c4");
		//case 55: strcopy(weapon, maxlen, "defuser");
		//case 57: strcopy(weapon, maxlen, "medishot")
		case 59: strcopy(weapon, maxlen, "weapon_knife_t");
		case 60: strcopy(weapon, maxlen, "weapon_m4a1");
		case 61: strcopy(weapon, maxlen, "weapon_usp");
		case 62: strcopy(weapon, maxlen, "weapon_cz75a");
		case 64: strcopy(weapon, maxlen, "weapon_revolver");
		//case 68: strcopy(weapon, maxlen, "weapon_tagrenade");
		case 69: strcopy(weapon, maxlen, "weapon_dz_barehands");
		//case 70: strcopy(weapon, maxlen, "weapon_breachcharge");
		//case 72: strcopy(weapon, maxlen, "tablet");
		case 80: strcopy(weapon, maxlen, "weapon_knife_spectral");
		case 500: strcopy(weapon, maxlen, "weapon_knife_bayonet");
		case 503: strcopy(weapon, maxlen, "weapon_knife_classic");
		case 505: strcopy(weapon, maxlen, "weapon_knife_flip");
		case 506: strcopy(weapon, maxlen, "weapon_knife_gut");
		case 507: strcopy(weapon, maxlen, "weapon_knife_karambit");
		case 508: strcopy(weapon, maxlen, "weapon_knife_m9_bayonet");
		case 509: strcopy(weapon, maxlen, "weapon_knife_huntsman");
		case 512: strcopy(weapon, maxlen, "weapon_knife_falchion");
		case 514: strcopy(weapon, maxlen, "weapon_knife_bowie");
		case 515: strcopy(weapon, maxlen, "weapon_knife_butterfly");
		case 516: strcopy(weapon, maxlen, "weapon_knife_shadowdaggers");
		case 517: strcopy(weapon, maxlen, "weapon_knife_paracord");
		case 518: strcopy(weapon, maxlen, "weapon_knife_survival");
		case 519: strcopy(weapon, maxlen, "weapon_knife_ursus");
		case 520: strcopy(weapon, maxlen, "weapon_knife_navaja");
		case 521: strcopy(weapon, maxlen, "weapon_knife_nomad");
		case 522: strcopy(weapon, maxlen, "weapon_knife_stiletto");
		case 523: strcopy(weapon, maxlen, "weapon_knife_talon");
		case 525: strcopy(weapon, maxlen, "weapon_knife_skeleton");
		default:
		{
			strcopy(weapon, maxlen, classname);
		}
	}
}

stock bool AssistedKills(Transaction txn
					, const int[] list
					, const int[] list_assister
					, int frags
					, int client
					, char[] list_steamid_assister
					, int list_steamid_assister_len)
{
	// spaghetti code
	
	ArrayList assisters;
	for(int i = 0; i < frags; i++)
	{
		int assist = list_assister[i];
		if(assist > 0)
		{
			if(assisters == null)
			{
				assisters = new ArrayList();
			}
			
			if(assisters.FindValue(assist) == -1)
			{
				assisters.Push(assist);
			}
		}
	}
	
	if(assisters != null)
	{
		// create arrays per assisters domination and revenge count.
		int[] assister_count = new int[assisters.Length];
		int[] assister_dominations = new int[assisters.Length];
		int[] assister_revenges = new int[assisters.Length];
		
		for(int i = 0; i < frags; i++)
		{
			int assist = list_assister[i];
			if(assist > 0)
			{
				for(int x = 0; x < assisters.Length; x++)
				{
					if(assisters.Get(x) == assist)
					{
						assister_count[x]++;
					}
				}
			}
		}
		
		// loop information and obtain if the assister did dominate or revenge somebody.
		for(int i = 0; i < assisters.Length; i++)
		{
			int assist = assisters.Get(i);
			int assister = GetClientOfUserId(assist);
			if(IsValidClient(assister))
			{
				g_Player[assister].session[Stats_Assists]++;
				
				char dummy[256];
				GetMultipleTargets(assister, list, frags, dummy, sizeof(dummy));
				
				switch(strlen(list_steamid_assister) < 1)
				{
					case false: Format(list_steamid_assister, list_steamid_assister_len, "%s;%s", list_steamid_assister, g_Player[assister].auth);
					case true: strcopy(list_steamid_assister, list_steamid_assister_len, g_Player[assister].auth);
				}
				
				char query[1024];
				int len = 0;
				len += Format(query[len], sizeof(query)-len, "update `%s` set `Assists`=`Assists`+%i", sql_table_playerlist, assister_count[i]);
				if(assister_dominations[i] > 0)
				{
					len += Format(query[len], sizeof(query)-len, ",`Dominations`=`Dominations`+%i", assister_dominations[i]);
				}
				if(assister_revenges[i] > 0)
				{
					len += Format(query[len], sizeof(query)-len, ",`Revenges`=`Revenges`+%i", assister_revenges[i]);
				}
				if(g_AssistPoints > 0)
				{
					len += Format(query[len], sizeof(query)-len, ",`Points`=`Points`+%i", g_AssistPoints*assister_count[i]);
				}
				len += Format(query[len], sizeof(query)-len, " where `SteamID`='%s' and `StatsID`='%i'", g_Player[assister].auth, g_StatsID);
				txn.AddQuery(query, queryId_kill_assister);
				
				if(g_AssistPoints > 0)
				{
					g_Player[assister].session[Stats_Points] += g_AssistPoints*assister_count[i];
					g_Player[assister].points += g_AssistPoints*assister_count[i];
					
					char points_plural[32];
					PointsPluralSplitter(assister, g_AssistPoints*assister_count[i], points_plural, sizeof(points_plural), PointSplit_On);
					
					if(g_Player[assister].bShowAssistMsg)
					{
						CPrintToChat(assister, "%s %T"
						, g_ChatTag
						, "#SMStats_FragEvent_Assisted", assister
						, points_plural
						, g_Player[client].name
						, dummy);
					}
				}
			}
		}
		
		delete assisters;
	}
	
	return true;
}

// will be re-done and optimized.
stock void VictimDied(Transaction txn, const int[] list, int frags)
{
	for(int i = 0; i < frags; i++)
	{
		int victim;
		if(IsValidClient((victim = GetClientOfUserId(list[i]))))
		{			
			int len = 0;
			char query[1024];
			len += Format(query[len], sizeof(query)-len, "update `" ... sql_table_playerlist ... "` set `Deaths`=`Deaths`+1");
			
			g_Player[victim].session[Stats_Deaths]++;
			
			if(g_DeathPoints >= 1)
			{
				len += Format(query[len], sizeof(query)-len, ",`Points`=`Points`-%i", g_DeathPoints);
				
				g_Player[victim].session[Stats_Points] -= g_DeathPoints;
				g_Player[victim].points -= g_DeathPoints;
			}
			
			len += Format(query[len], sizeof(query)-len, " where `SteamID`='%s' and `StatsID`='%i'", g_Player[victim].auth, g_StatsID);
			txn.AddQuery(query, queryId_kill_victim_death);
			
			if(g_DeathPoints >= 1 && g_Player[victim].bShowDeathMsg)
			{
				char points_plural[64];
				PointsPluralSplitter(victim, g_DeathPoints, points_plural, sizeof(points_plural), PointSplit_Minus);
				
				CPrintToChat(victim, "%s %T"
				, g_ChatTag
				, "#SMStats_FragEvent_Death", victim
				, points_plural);
			}
		}
	}
}

//