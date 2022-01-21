/* For experimental assister function. */
int PlayerDamaged[MAXPLAYERS][MAXPLAYERS];

Action Assister_OnTakeDamage(int victim, int &client, int &inflictor, float &damage, int &damagetype)	{
	if(Tklib_IsValidClient(victim) && Tklib_IsValidClient(client, true))	{
		//Turn the float into a valid integer.
		char getdmg[96];
		FloatToString(damage, getdmg, sizeof(getdmg));
		SplitString(getdmg, ".", getdmg, sizeof(getdmg));
		int dmg = StringToInt(getdmg);
		
		PlayerDamaged[victim][client] += dmg;

		Session[client].DamageDone += dmg;
	}
}

/**
 *	Resets the assisted array.
 */
void ResetAssister()	{
	for(int i = 1; i < MaxClients; i++)	{
		for(int x = 1; x < MaxClients; x++)
			PlayerDamaged[i][x] = 0;
	}
}

/**
 *	Returns the user which done the most damage in the active round.
 *
 *	@param	victim	The victim that was damaged to check.
 *	@param	client	The attacker that gave damage to check.
 */
int GetLatestAssister(int victim, int client)	{
	int userid = 0;
	for(int i = 1; i < MaxClients; i++)	{
		//Make sure the user is in the game.
		if(Tklib_IsValidClient(i))	{
			//Make sure to not return the attacker if he did the most damage.
			if(client != i && PlayerDamaged[victim][i] > 50)
				userid = GetClientUserId(i);
		}
	}
	
	return userid;
}