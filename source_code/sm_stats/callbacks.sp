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