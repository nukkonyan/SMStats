#if defined assister_func
/* For experimental assister function. */
int g_PlayerDamaged[MaxPlayers+1][MaxPlayers+1];
#endif

#if defined assister_func
stock void LoadAssisterEvents()
{
	HookEvent("player_hurt", Assister_PlayerHurt, EventHookMode_Pre);
	HookEvent("player_death", Assister_PlayerDeath, EventHookMode_Post);
}

stock void Assister_PlayerHurt(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int client, attacker = event.GetInt("attacker");
	int target, userid = event.GetInt("userid");
	if(attacker == userid
	|| !SMStats_IsValidClient(client, attacker)
	|| !SMStats_IsValidClient(target, userid, {1,2,0}))
	{
		return;
	}
	
	int dmg;
	
	switch(GetEngineVersion())
	{
		case Engine_TF2:
		{
			dmg = event.GetInt("damageamount");
		}
		case Engine_CSS, Engine_CSGO:
		{
			dmg = event.GetInt("dmg_health");
		}
	}
	
	g_PlayerDamaged[target][client] += dmg;
}

stock void Assister_PlayerDeath(Event event, const char[] event_name, bool dontBroadcast)
{
	if(!IsValidStats())
	{
		return;
	}
	
	int client, attacker = event.GetInt("attacker");
	int target, userid = event.GetInt("userid");
	if(attacker == userid
	|| !SMStats_IsValidClient(client, attacker)
	|| !SMStats_IsValidClient(target, userid, {1,2,0}))
	{
		return;
	}
	
	g_PlayerDamaged[client][target] = 0;
	g_PlayerDamaged[target][client] = 0;
}

/**
 *	Resets the assisted array.
 */
stock void ResetAssister()
{
	for(int client = 1; client <= MaxPlayers; client++)
	{
		for(int target = 1; target <= MaxPlayers; target++)
		{
			g_PlayerDamaged[client][target] = 0;
		}
	}
}

/**
 *	Returns the user which done the most damage in the active round.
 *
 *	@param	victim	The victim that was damaged to check.
 *	@param	client	The attacker that gave damage to check, to make sure this attacker isn't chosen.
 */
stock int GetLatestAssister(int victim, int client)
{
	int player = 0;
	while((player = FindEntityByClassname(player, "player")) != -1)
	{
		//Make sure the user is in the game.
		if(SMStats_IsValidClient(player, {1,2,0}))
		{
			//Make sure to not return the attacker, only return the player who did the most damage.
			if(client != player && g_PlayerDamaged[victim][player] > 50)
			{
				return g_Player[player].userid;
			}
		}
	}
	
	return -1;
}
#endif