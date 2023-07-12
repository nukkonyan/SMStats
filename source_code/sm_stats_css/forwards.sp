public void OnEntityCreated(int entity, const char[] classname)
{
	/* Need a short delay so we can get the entity owner. */
	if(StrEqual(classname, "flashbang_projectile")
	|| StrEqual(classname, "hegrenade_projectile")
	|| StrEqual(classname, "smokegrenade_projectile"))
	{
		DataPack pack;
		CreateDataTimer(0.01, Timer_OnEntityCreated, pack);
		pack.WriteCell(EntIndexToEntRef(entity));
		pack.WriteCell(strlen(classname)+1);
		pack.WriteString(classname);
		pack.Reset();
	}
}

Action Timer_OnEntityCreated(Handle timer, DataPack pack)
{
	int ref = pack.ReadCell();
	int maxlen = pack.ReadCell();
	char[] classname = new char[maxlen];
	pack.ReadString(classname, maxlen);
	
	int entity = EntRefToEntIndex(ref);
	
	if(IsValidEntity(entity))
	{
		int client = GetEntPropEnt(entity, Prop_Send, "m_hThrower");
		
		if(StrEqual(classname, "flashbang_projectile"))
		{
			m_hLastFlashBangGrenade = client;
		}
		
		if(StrEqual(classname, "hegrenade_projectile"))
		{
			m_hLastHEGrenade = client;
		}
		
		if(StrEqual(classname, "smokegrenade_projectile"))
		{
			m_hLastSmokeGrenade = client;
		}
	}
	
	return Plugin_Continue;
}