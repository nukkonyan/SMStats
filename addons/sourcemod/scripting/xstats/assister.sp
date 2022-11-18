/* For experimental assister function. */
int PlayerDamaged[MaxPlayers+1][MaxPlayers+1];

stock Action Assister_OnTakeDamage(int victim, int &client, int &inflictor, float &damage, int &damagetype)	{
	if(Tklib_IsValidClient(victim) && Tklib_IsValidClient(client, true) && !IsSameTeam(victim, client))	{
		//Turn the float into a valid integer.
		char getdmg[96];
		FloatToString(damage, getdmg, sizeof(getdmg));
		SplitString(getdmg, ".", getdmg, sizeof(getdmg));
		int dmg = StringToInt(getdmg);
		
		//PrintToChatAll("[%s] Damage done: %i", Player[client].Playername, dmg);
		
		PlayerDamaged[victim][client] += dmg;
		Player[client].Session.DamageDone += dmg;
	}
}

void Assister_PlayerHurt(Event event, const char[] event_name, bool dontBroadcast) {	
	int client = GetClientOfUserId(event.GetInt(EVENT_STR_ATTACKER));
	int victim = GetClientOfUserId(event.GetInt(EVENT_STR_USERID));
	
	if(!Tklib_IsValidClient(client, true) || !Tklib_IsValidClient(client) || IsSamePlayers(victim, client)) return;
	
	int dmg;
	
	switch(GetEngineVersion()) {
		case Engine_TF2: dmg = event.GetInt("damageamount");
		case Engine_CSS, Engine_CSGO: dmg = event.GetInt(EVENT_STR_DMG_HEALTH);
	}
	
	PlayerDamaged[victim][client] += dmg;
	
	if(!IsValidStats()) return;
	if(IsFakeClient(victim) && !Cvars.AllowBots.BoolValue) return;
	
	Player[client].Session.DamageDone += dmg;
}

/**
 *	Resets the assisted array.
 */
void ResetAssister() { TargetLoopEx(client) TargetLoopEx(target) PlayerDamaged[client][target] = 0; }

/**
 *	Returns the user which done the most damage in the active round.
 *
 *	@param	victim	The victim that was damaged to check.
 *	@param	client	The attacker that gave damage to check.
 */
int GetLatestAssister(int victim, int client) {
	int userid = 0;
	TargetLoopEx(i) {
		//Make sure the user is in the game.
		if(Tklib_IsValidClient(i))	{
			//Make sure to not return the attacker if he did the most damage.
			if(!IsSamePlayers(client, i) && PlayerDamaged[victim][i] > 50)
				userid = GetClientUserId(i);
		}
	}
	
	return userid;
}