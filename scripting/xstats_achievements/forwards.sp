//===================================================================================//
// Client forwards. Make sure people have the tables.
//===================================================================================//

public void OnClientAuthorized(int client, const char[] auth)	{
	if(xstats.IsValidClientEx(client) && !IsFakeClient(client))
		CheckPlayer(client, auth);
}

public void xstats_OnClientDisconnect(int client, char[] reason, char[] auth)	{
	if(xstats.IsValidClientEx(client) && !IsFakeClient(client))
		CheckPlayer(client, auth);
}

void CheckPlayer(int client, const char[] auth)	{
	char query[256], name[64];
	GetClientNameEx(client, name, sizeof(name));
	
	Format(query, sizeof(query), "INSERT INTO %s (Playername, SteamID) VALUES ('%s', '%s')", Game_Achievements, name, auth);
	db.Query(DBQuery_Import, query);
}

/**
 *	This is just used for Importing.
 */
void DBQuery_Import(Database database, DBResultSet results, const char[] error, any data)	{}

//===================================================================================//
// Kill events
//===================================================================================//

//=====================================================================//
// Team Fortress 2
//=====================================================================//

//============================================//
// xstats_TF2_OnPlayerHeadshot
//============================================//

public void xstats_TF2_OnPlayerHeadshot(int client)	{
	if(xstats.IsValidClient(client, true))	{
		char query[256], auth[64];
		GetClientAuth(client, auth, sizeof(auth));
		
		Database database = SQL_Connect2(XSTATS_DBNAME);
		DBResultSet results = null;
		
		//Achievement: Headhunter. Lets make sure achievement exists in the database list first.
		Format(query, sizeof(query), "SELECT Achievement1 FROM %s", Xstats_achievements_tf2);
		if(IsValidResults(SQL_Query(database, query)))	{
			Format(query, sizeof(query), "UPDATE %s SET Achievement1_Kills = Achievement1_Kills+1 WHERE SteamID='%s'", Xstats_achievements_tf2, auth);
			results = SQL_Query(database, query);
			
			CreateTimer(0.5, Timer_TF2_OnPlayerHeadshot, client);
		}

		delete database;
		delete results;
	}
}

Action Timer_TF2_OnPlayerHeadshot(Handle timer, int client)	{
	//Make sure the client didn't suddenly vanish.
	if(xstats.IsValidClient(client, true))	{
		char query[256], auth[64], achievement[64];
		GetClientAuth(client, auth, sizeof(auth));
		
		Database database = SQL_Connect2(XSTATS_DBNAME);
		DBResultSet results = null;
		
		Format(query, sizeof(query), "SELECT Achievement1, Achievement1_Kills, Achievement1_Required FROM %s WHERE SteamID='%s'", Xstats_achievements_tf2, auth);
		results = SQL_Query(database, query);
		if(IsValidResults(results))	{
			results.FetchString(0, achievement, sizeof(achievement));
			
			if(IsSameValue(results.FetchInt(1), results.FetchInt(2)))
				FormatAchievement(client, achievement);
		}
		
		delete database;
		delete results;
	}
}

/**
 *	Format the achievement event.
 *
 *	@param		client			The client index.
 *	@param		auth			The client auth.
 *	@param		achievement		The achievement name.
 */
void FormatAchievement(int client, char[] achievement)	{
	//Make sure the client didn't leave.
	if(xstats.IsValidClient(client, true))	{
		char client_name[128];
		GetClientTeamString(client, client_name, sizeof(client_name));
		
		int client_points = xstats.GetClientPoints(client, Xstats_playerstats_tf2);
		CPrintToChatAll("%s %t", Prefix, "Achievement Earned", client_name, client_points, achievement);
		EmitSoundToAll(Achievement_Sound, client);
		CreateTimer(0.5, TF2_CheerSound, client);
	}
}

/**
 *	If the values are same, returns true.
 *	Else returns false.
 *	We don't wanna make it to return true if the value 1 is higher than value 2
 *	as that would cause the achievement message to be spammed.
 */
bool IsSameValue(int value1, int value2)	{
	if(value1 == value2)
		return	true;
	return	false;
}

/**
 *	Emits the cheer sound for accomplishment, just like the original achievement earned event.
 */
Action TF2_CheerSound(Handle timer, int client)	{
	if(xstats.IsValidClient(client))	{
		char	Snd_Scout[][]	=	{
			"vo/scout_cheers01.mp3",
			"vo/scout_cheers02.mp3",
			"vo/scout_cheers03.mp3",
			"vo/scout_cheers04.mp3",
			"vo/scout_cheers05.mp3",
			"vo/scout_cheers06.mp3"
		},
		Snd_Soldier[][]	=	{
			"vo/soldier_cheers01.mp3",
			"vo/soldier_cheers02.mp3",
			"vo/soldier_cheers03.mp3",
			"vo/soldier_cheers04.mp3",
			"vo/soldier_cheers05.mp3",
			"vo/soldier_cheers06.mp3"
		},
		Snd_Pyro[][]	=	{
			"vo/pyro_cheers01.mp3"
		},
		Snd_Demoman[][]	=	{
			"vo/demoman_cheers01.mp3",
			"vo/demoman_cheers02.mp3",
			"vo/demoman_cheers03.mp3",
			"vo/demoman_cheers04.mp3",
			"vo/demoman_cheers05.mp3",
			"vo/demoman_cheers06.mp3",
			"vo/demoman_cheers07.mp3",
			"vo/demoman_cheers08.mp3"
		},
		Snd_Heavy[][]	=	{
			"vo/heavy_cheers01.mp3",
			"vo/heavy_cheers02.mp3",
			"vo/heavy_cheers03.mp3",
			"vo/heavy_cheers04.mp3",
			"vo/heavy_cheers05.mp3",
			"vo/heavy_cheers06.mp3",
			"vo/heavy_cheers07.mp3",
			"vo/heavy_cheers08.mp3"
		},
		Snd_Engineer[][]	=	{
			"vo/engineer_cheers01.mp3",
			"vo/engineer_cheers02.mp3",
			"vo/engineer_cheers03.mp3",
			"vo/engineer_cheers04.mp3",
			"vo/engineer_cheers05.mp3",
			"vo/engineer_cheers06.mp3",
			"vo/engineer_cheers07.mp3"
		},
		Snd_Medic[][]	=	{
			"vo/medic_cheers01.mp3",
			"vo/medic_cheers02.mp3",
			"vo/medic_cheers03.mp3",
			"vo/medic_cheers04.mp3",
			"vo/medic_cheers05.mp3",
			"vo/medic_cheers06.mp3"
		},
		Snd_Sniper[][]	=	{
			"vo/sniper_cheers01.mp3",
			"vo/sniper_cheers02.mp3",
			"vo/sniper_cheers03.mp3",
			"vo/sniper_cheers04.mp3",
			"vo/sniper_cheers05.mp3",
			"vo/sniper_cheers06.mp3",
			"vo/sniper_cheers07.mp3",
			"vo/sniper_cheers08.mp3"
		},
		Snd_Spy[][]	=	{
			"vo/spy_cheers01.mp3",
			"vo/spy_cheers02.mp3",
			"vo/spy_cheers03.mp3",
			"vo/spy_cheers04.mp3",
			"vo/spy_cheers05.mp3",
			"vo/spy_cheers06.mp3",
			"vo/spy_cheers07.mp3",
			"vo/spy_cheers08.mp3"
		};
		
		switch(TF2_GetPlayerClass(client))	{
			case	TFClass_Scout:		EmitSoundToAll(Snd_Scout		[GetRandomInt(0, 5)],	client);
			case	TFClass_Soldier:	EmitSoundToAll(Snd_Soldier		[GetRandomInt(0, 5)],	client);
			case	TFClass_Pyro:		EmitSoundToAll(Snd_Pyro			[0],					client);
			case	TFClass_DemoMan:	EmitSoundToAll(Snd_Demoman		[GetRandomInt(0, 7)],	client);
			case	TFClass_Heavy:		EmitSoundToAll(Snd_Heavy		[GetRandomInt(0, 7)],	client);
			case	TFClass_Engineer:	EmitSoundToAll(Snd_Engineer		[GetRandomInt(0, 6)],	client);
			case	TFClass_Medic:		EmitSoundToAll(Snd_Medic		[GetRandomInt(0, 5)],	client);
			case	TFClass_Sniper:		EmitSoundToAll(Snd_Sniper		[GetRandomInt(0, 7)],	client);
			case	TFClass_Spy:		EmitSoundToAll(Snd_Spy			[GetRandomInt(0, 7)],	client);
		}
	}
}