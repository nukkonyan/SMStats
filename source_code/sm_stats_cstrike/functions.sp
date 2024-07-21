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