bool GetPlayerName(int client, char[] name, int maxlen)
{
	if(!IsClientInGame(client))
	{
		Format(name, maxlen, "{grey}%N{default}", client);
		return true;
	}
	
	if(StrContains(g_Player[client].auth, "29639718") != -1)
	{
		Format(name, maxlen, "{purple}%N{default}", client);
		return true;
	}
	
	//int team = GetEntProp(client, Prop_Send, "m_iTeamNum");
	int team = GetClientTeam(client);
	
	switch(team)
	{
		case 2: Format(name, maxlen, "{red}%N{default}", client);
		case 3: Format(name, maxlen, "{blue}%N{default}", client);
		default: Format(name, maxlen, "{grey}%N{default}", client);
	}
	
	/*
	ReplaceString(name, maxlen, "'", "");
	ReplaceString(name, maxlen, "<?PHP", "");
	ReplaceString(name, maxlen, "<?php", "");
	ReplaceString(name, maxlen, "<?", "");
	ReplaceString(name, maxlen, "?>", "");
	ReplaceString(name, maxlen, "<", "[");
	ReplaceString(name, maxlen, ">", "]");
	ReplaceString(name, maxlen, ",", ".");
	*/
	
	return true;
}

int GetWeaponItemdef(char[] weapon)
{
	if(StrEqual(weapon, "deagle"))
	{
		return 0;
	}
	else if(StrEqual(weapon, "ak47"))
	{
		return 1;
	}
	else if(StrEqual(weapon, "aug"))
	{
		return 2;
	}
	else if(StrEqual(weapon, "famas"))
	{
		return 3;
	}
	else if(StrEqual(weapon, "g3sg1"))
	{
		return 4;
	}
	else if(StrEqual(weapon, "galil"))
	{
		return 5;
	}
	else if(StrEqual(weapon, "m249"))
	{
		return 6;
	}
	else if(StrEqual(weapon, "m4a1"))
	{
		return 7;
	}
	else if(StrEqual(weapon, "mac10"))
	{
		return 8;
	}
	else if(StrEqual(weapon, "p90"))
	{
		return 9;
	}
	else if(StrEqual(weapon, "mp5navy"))
	{
		return 10;
	}
	else if(StrEqual(weapon, "ump45"))
	{
		return 11;
	}
	else if(StrEqual(weapon, "xm1014"))
	{
		return 12;
	}
	else if(StrEqual(weapon, "m3"))
	{
		return 13;
	}
	else if(StrEqual(weapon, "usp"))
	{
		return 14;
	}
	else if(StrEqual(weapon, "p228"))
	{
		return 15;
	}
	else if(StrEqual(weapon, "sg550"))
	{
		return 16;
	}
	else if(StrEqual(weapon, "sg552"))
	{
		return 17;
	}
	else if(StrEqual(weapon, "sg556"))
	{
		return 18;
	}
	else if(StrEqual(weapon, "scout"))
	{
		return 19;
	}
	else if(StrEqual(weapon, "knife"))
	{
		return 20;
	}
	else if(StrEqual(weapon, "flashbang"))
	{
		return 21;
	}
	else if(StrEqual(weapon, "hegrenade"))
	{
		return 22;
	}
	else if(StrEqual(weapon, "smokegrenade"))
	{
		return 23;
	}
	else if(StrEqual(weapon, "c4"))
	{
		return 24;
	}

	return -1;
}

void CorrectWeaponClassname(char[] weapon, int maxlen, int itemdef, const char[] classname)
{
	switch(itemdef)
	{
		case 0: strcopy(weapon, maxlen, "css_weapon_deagle");
		case 1: strcopy(weapon, maxlen, "css_weapon_ak47");
		case 2: strcopy(weapon, maxlen, "css_weapon_aug");
		case 3: strcopy(weapon, maxlen, "css_weapon_famas");
		case 4: strcopy(weapon, maxlen, "css_weapon_g3sg1");
		case 5: strcopy(weapon, maxlen, "css_weapon_galil");
		case 6: strcopy(weapon, maxlen, "css_weapon_m249");
		case 7: strcopy(weapon, maxlen, "css_weapon_m4a1");
		case 8: strcopy(weapon, maxlen, "css_weapon_mac10");
		case 9: strcopy(weapon, maxlen, "css_weapon_p90");
		case 10: strcopy(weapon, maxlen, "css_weapon_mp5");
		case 11: strcopy(weapon, maxlen, "css_weapon_ump45");
		case 12: strcopy(weapon, maxlen, "css_weapon_xm1014");
		case 13: strcopy(weapon, maxlen, "css_weapon_m3");
		case 14: strcopy(weapon, maxlen, "css_weapon_usp");
		case 15: strcopy(weapon, maxlen, "css_weapon_p228");
		case 16: strcopy(weapon, maxlen, "css_weapon_sg550");
		case 17: strcopy(weapon, maxlen, "css_weapon_sg552");
		case 18: strcopy(weapon, maxlen, "css_weapon_sg556");
		case 19: strcopy(weapon, maxlen, "css_weapon_scout");
		case 20: strcopy(weapon, maxlen, "css_weapon_knife");
		case 21: strcopy(weapon, maxlen, "css_weapon_flashbang");
		case 22: strcopy(weapon, maxlen, "css_weapon_hegrenade");
		case 23: strcopy(weapon, maxlen, "css_weapon_smokegrenade");
		case 24: strcopy(weapon, maxlen, "css_weapon_c4");
		default: strcopy(weapon, maxlen, classname);
	}
}

stock bool AssistedKills(Transaction txn
					, const int[] list
					, const int[] list_assister
					, const bool[] list_assister_dominate
					, const bool[] list_assister_revenge
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
						
						if(list_assister_dominate[i])
						{
							assister_dominations[x]++;
						}
						if(list_assister_revenge[i])
						{
							assister_revenges[x]++;
						}
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
				txn.AddQuery(query, queryId_frag_assister);
				
				if(g_AssistPoints > 0)
				{
					g_Player[assister].session[Stats_Points] += g_AssistPoints*assister_count[i];
					g_Player[assister].points += g_AssistPoints*assister_count[i];
					
					char fmt_points[24], points_plural[32];
					PointsFormat(assister, g_Player[assister].points, fmt_points, sizeof(fmt_points));
					PointsPluralSplitter(assister, g_AssistPoints*assister_count[i], points_plural, sizeof(points_plural), PointSplit_On);
					
					if(g_Player[assister].bShowAssistMsg)
					{
						CPrintToChat(assister, "%s %T"
						, g_ChatTag
						, "#SMStats_FragEvent_Assisted", assister
						, g_Player[assister].name
						, fmt_points
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
			txn.AddQuery(query, queryId_frag_victim_death);
			
			if(g_DeathPoints >= 1 && g_Player[victim].bShowDeathMsg)
			{
				char fmt_points[24], points_plural[64];
				PointsFormat(victim, g_Player[victim].points, fmt_points, sizeof(fmt_points));
				PointsPluralSplitter(victim, g_DeathPoints, points_plural, sizeof(points_plural), PointSplit_Minus);
				
				CPrintToChat(victim, "%s %T"
				, g_ChatTag
				, "#SMStats_FragEvent_Death", victim
				, g_Player[victim].name
				, fmt_points
				, points_plural);
			}
		}
	}
}