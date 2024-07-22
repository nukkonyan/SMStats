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

stock bool CStrike_IsSniperRifleZoomed(int weapon)
{
	char classname[64];
	GetEntityClassname(weapon, classname, sizeof(classname));
	
	if(!StrEqual(classname, "weapon_awp")
	&& !StrEqual(classname, "weapon_ssg08")
	&& !StrEqual(classname, "weapon_scout")
	&& !StrEqual(classname, "weapon_scar20")
	&& !StrEqual(classname, "weapon_g3sg1"))
	{
		return false;
	}
	
	int m_zoomLevel = GetEntProp(weapon, Prop_Send, "m_zoomLevel");
	
	return (m_zoomLevel >= 1);
}