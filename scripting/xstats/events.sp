void LoadEvents()	{
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);
}

void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)	{
	int client = GetClientOfUserId(event.GetInt("attacker"));
	int victim = GetClientOfUserId(event.GetInt("userid"));
	int assist = GetClientOfUserId(event.GetInt("assister"));
	if(IsSamePlayers(client, victim))	{
		GlobalForward suicide = new GlobalForward("xstats_OnPlayerSuicide", ET_Event, Param_Cell, Param_Cell, Param_Cell);
		Call_StartForward(suicide);
		Call_PushCell(client);
		Call_PushCell(IsValidClient(assist) ? assist:0);
		Call_PushCell(IsFakeClient(client));
		Call_Finish();
		delete suicide;
	}
}