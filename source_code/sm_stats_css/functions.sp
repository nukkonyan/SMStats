/* weapons */
enum struct CvarWeapon
{
	int itemdef;
	ConVar cvar;
}

ArrayList g_arrayWeapons;

stock void array_InitializeWeapons()
{
	g_arrayWeapons = new ArrayList(sizeof(CvarWeapon));
}
stock void array_AddWeapon(int itemdef, const char[] cvar_name, int value, char[] description)
{
	char str_value[11];
	IntToString(value, str_value, sizeof(str_value));
	
	int maxlen = strlen(description)+52;
	char[] fixed = new char[maxlen];
	Format(fixed, maxlen, "%s - Points earned when fragging using %s.", core_chattag2, description);
	
	CvarWeapon array;
	array.itemdef = itemdef;
	array.cvar = CreateConVar(cvar_name, str_value, fixed, _, true);
	g_arrayWeapons.PushArray(array, sizeof(array));
}
stock void array_AddSameWeapon(int itemdef1, int itemdef2)
{
	int index = -2;
	
	if((index = g_arrayWeapons.FindValue(itemdef2)) != -1)
	{
		CvarWeapon get_array;
		g_arrayWeapons.GetArray(index, get_array, sizeof(get_array));
		
		CvarWeapon array;
		array.itemdef = itemdef1;
		array.cvar = get_array.cvar;
		g_arrayWeapons.PushArray(array, sizeof(array));
	}
}
stock ConVar array_GetWeapon(int itemdef)
{
	int index = -2;
	
	if((index = g_arrayWeapons.FindValue(itemdef)) != -1)
	{
		CvarWeapon array;
		g_arrayWeapons.GetArray(index, array, sizeof(array));
		
		return array.cvar;
	}
	
	return null;
}

//

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

void CorrectWeaponClassname(char[] weapon, int maxlen, int itemdef)
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
	}
}

bool AssistedKills(Transaction txn, const int[] list_assister, int frags, int client, FragEventInfo event)
{
	int victim = GetClientOfUserId(event.userid);
	if(!IsValidClient(victim, false))
	{
		return false;
	}
	
	int assist_points = 10;
	
	// needs to be further optimized for sql.
	for(int i = 0; i < frags; i++)
	{
		int assister = list_assister[i];
		int assist = GetClientOfUserId(assister);
		
		if(assist == client 
		|| assister == event.userid)
		{
			continue;
		}
		
		if(IsValidClient(assist))
		{
			g_Player[assist].session[Stats_Assists]++;
			
			char query[1024];
			int len = 0;
			
			len += Format(query[len], sizeof(query)-len, "update `%s` set ", sql_table_playerlist);
			len += Format(query[len], sizeof(query)-len, "Assists = Assists+1");
			
			if(event.dominated_assister)
			{
				len += Format(query[len], sizeof(query)-len, ", Dominations = Dominations+1");
			}
			else if(event.revenge_assister)
			{
				len += Format(query[len], sizeof(query)-len, ", Revenges = Revenges+1");
			}
			
			// a little optimization.
			if(assist_points > 0)
			{
				g_Player[assist].points += assist_points;
				
				CPrintToChat(assist, "%s %T"
				, g_ChatTag
				, "#SMStats_FragEvent_Assisted", client
				, g_Player[assist].name
				, g_Player[assist].points
				, assist_points
				, g_Player[client].name
				, g_Player[victim].name);
				
				len += Format(query, sizeof(query), ", Points = Points+%i", assist_points);
			}
			
			len += Format(query[len], sizeof(query)-len, " where SteamID = '%s' and ServerID = %i", g_Player[assist].auth, g_ServerID);

			txn.AddQuery(query, queryId_frag_assister);
		}
	}
	
	return true;
}