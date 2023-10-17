stock any Native_GetPlayerSessionInfo(Handle plugin, int params)
{
	int client = GetNativeCell(1);
	SMStats_Type type = GetNativeCell(2);
	Function callback = GetNativeFunction(3);
	
	g_GetPlayerSessionInfoFwd.AddFunction(plugin, callback);
	Call_StartForward(g_GetPlayerSessionInfoFwd);
	Call_PushCell(client);
	Call_PushCell(g_Player[client].session[type]);
	Call_PushCell(type);
	Call_Finish();
	
	return 0;
}

/* ============================================================== */