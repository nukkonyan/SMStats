Database	db = null;

void UploadDB(Database database)	{
	if(xstats.Debug())
		PrintToServer("[%s] Uploading database tables..", PLUGIN_NAME);
	
	char query[8192];
	int len = 0;
	
		//Upload the player stats table.
	len += Format(query[len], sizeof(query)-len, "CREATE TABLE IF NOT EXISTS `%s`", Xstats_playerstats_tf2);
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`Playername`				varchar(64)		NOT NULL	DEFAULT	''		COMMENT 	'Players name.',");
	len += Format(query[len], sizeof(query)-len, "`SteamID`					varchar(64)		NOT NULL	DEFAULT	''		COMMENT		'Players SteamID.',");
	len += Format(query[len], sizeof(query)-len, "`Points`					int(64)			NOT NULL	DEFAULT	'1000'	COMMENT 	'Players points.',");
	len += Format(query[len], sizeof(query)-len, "`IPAddress`				varchar(64)		NOT NULL	DEFAULT ''		COMMENT		'Players IP Address.',");
	len += Format(query[len], sizeof(query)-len, "`PlayTime`				int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Players playtime.',");
	len += Format(query[len], sizeof(query)-len, "`LastOnline`				TIMESTAMP		NOT NULL	DEFAULT	CURRENT_TIMESTAMP,");
	
	len += Format(query[len], sizeof(query)-len, "`Deaths`					int(64)			NOT NULL	DEFAULT	'0'		COMMENT 	'Amount of deaths.',");
	len += Format(query[len], sizeof(query)-len, "`Assists`					int(64)			NOT NULL	DEFAULT	'0'		COMMENT 	'Amount of assists.',");
	len += Format(query[len], sizeof(query)-len, "`Kills`					int(64)			NOT NULL	DEFAULT	'0'		COMMENT 	'Amount of kills.',");
	len += Format(query[len], sizeof(query)-len, "`Suicides`				int(64)			NOT NULL	DEFAULT	'0'		COMMENT 	'Amount of suicides.',");
	
	len += Format(query[len], sizeof(query)-len, "`Airshots`				int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Amount of airshots.',");
	len += Format(query[len], sizeof(query)-len, "`Headshots`				int(64)			NOT NULL	DEFAULT	'0'		COMMENT 	'Amount of headshots.',");
	len += Format(query[len], sizeof(query)-len, "`Backstabs`				int(64)			NOT NULL	DEFAULT	'0'		COMMENT 	'Amount of backstabs.',");
	len += Format(query[len], sizeof(query)-len, "`Noscopes`				int(64)			NOT NULL	DEFAULT	'0'		COMMENT 	'Amount of noscopes.',");
	
	len += Format(query[len], sizeof(query)-len, "`Dominations`				int(64)			NOT NULL	DEFAULT	'0'		COMMENT		'Amount of dominations.',");
	len += Format(query[len], sizeof(query)-len, "`Revenges`				int(64)			NOT NULL	DEFAULT	'0'		COMMENT		'Amount of revenges.',");
	
	len += Format(query[len], sizeof(query)-len, "`ScoutsKilled`			int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Scouts killed.',");
	len += Format(query[len], sizeof(query)-len, "`SoldiersKilled`			int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Soldiers killed.',");
	len += Format(query[len], sizeof(query)-len, "`PyrosKilled`				int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Pyros killed.',");
	len += Format(query[len], sizeof(query)-len, "`DemosKilled`				int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Demos killed.',");
	len += Format(query[len], sizeof(query)-len, "`HeaviesKilled`			int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Heavies killed.',");
	len += Format(query[len], sizeof(query)-len, "`EngineersKilled`			int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Engineers killed.',");
	len += Format(query[len], sizeof(query)-len, "`MedicsKilled`			int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Medics killed.',");
	len += Format(query[len], sizeof(query)-len, "`SnipersKilled`			int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Snipers killed.',");
	len += Format(query[len], sizeof(query)-len, "`SpiesKilled`				int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Spies killed.',");
	
	len += Format(query[len], sizeof(query)-len, "`CritKills`				int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Amount of crit kills.',");
	len += Format(query[len], sizeof(query)-len, "`MiniCritKills`			int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Amount of mini crit kills.',");
	len += Format(query[len], sizeof(query)-len, "`GibKills`				int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Amount of gib kills.',");
	
	len += Format(query[len], sizeof(query)-len, "`ExtinguishedTeammates`	int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Amount of times youve extinguished teammates.',");
	len += Format(query[len], sizeof(query)-len, "`CoatedEnemies`			int(64)			NOT NULL	DEFAULT '0'		COMMENT		'Amount of times youve coated the enemies with a jar',");
	
	len += Format(query[len], sizeof(query)-len, "PRIMARY KEY (`SteamID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	database.Query(DBQuery_UploadDB, query, 0);
	
	len = 0;
	Format(query, sizeof(query), "");
		//Wiping the results so a new query can be prepared, no need for extra string buffers & integers.
	
		//Upload the item found table.
	len += Format(query[len], sizeof(query)-len, "CREATE TABLE IF NOT EXISTS `%s`", Xstats_itemfound_tf2);
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ID`						int(64)			NOT NULL	AUTO_INCREMENT,");
	len += Format(query[len], sizeof(query)-len, "`SteamID`					varchar(64)		NOT NULL	DEFAULT ''		COMMENT		'The players SteamID',");
	len += Format(query[len], sizeof(query)-len, "`DefIndex`				int(64)			NOT NULL	DEFAULT '0'		COMMENT		'The items definition index.',");
	len += Format(query[len], sizeof(query)-len, "`QualityIndex`			int(64)			NOT NULL	DEFAULT '0'		COMMENT		'The items quality index.',");
	len += Format(query[len], sizeof(query)-len, "`Quality`					varchar(64)		NOT NULL	DEFAULT '0'		COMMENT		'The items quality name',");
	len += Format(query[len], sizeof(query)-len, "`MethodIndex`				int(64)			NOT NULL	DEFAULT '0'		COMMENT		'The items method index.',");
	len += Format(query[len], sizeof(query)-len, "`Method`					varchar(64)		NOT NULL	DEFAULT '0'		COMMENT		'The items method name',");
	len += Format(query[len], sizeof(query)-len, "PRIMARY KEY (`ID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	len += Format(query[len], sizeof(query)-len, "AUTO_INCREMENT=1");
	database.Query(DBQuery_UploadDB, query, 1);
	
	len = 0;
	Format(query, sizeof(query), "");
}

void DBQuery_UploadDB(Database database, DBResultSet results, const char[] error, int data)	{
	if(results == null)	{
		switch(data)	{
			case	0:	{
				PrintToServer("[%s] Creation of table \"%s\" were unsuccessfull (%s)", PLUGIN_NAME, Xstats_playerstats_tf2 ,error);
				SetFailState("[%s] Fatal error has occured! ERR_TABLE_COULD_NOT_BE_CREATED", PLUGIN_NAME);
			}
			case	1:	{
				PrintToServer("[%s] Creation of table \"%s\" were unsuccessfull (%s)", PLUGIN_NAME, Xstats_itemfound_tf2, error);
				SetFailState("[%s] Fatal error has occured! ERR_TABLE_COULD_NOT_BE_CREATED", PLUGIN_NAME);
			}
		}
	}
}

//==================================//

public void OnClientAuthorized(int client)	{
	if(xstats.IsValidClientEx(client) && !IsFakeClient(client))	{
		char auth[64];
		GetClientAuth(client, auth, sizeof(auth));
		
		char query[256];
		Format(query, sizeof(query), "SELECT * FROM %s WHERE SteamID='%s'", Xstats_playerstats_tf2, auth);
		db.Query(DBQuery_CheckClient, query, client);
	}
}

void DBQuery_CheckClient(Database database, DBResultSet results, const char[] error, int client)	{
	if(results == null)	{
		if(xstats.Debug())
			PrintToServer("[Xstats: Team Fortress 2] Checking if client is on stats table list failed! (%s)", error);
		return;
	}
	
	if(!results.FetchRow())	{
		if(xstats.IsValidClientEx(client) && !IsFakeClient(client))	{
			char query[256], auth[64], name[64];
			GetClientAuth(client, auth, sizeof(auth));
			GetClientNameEx(client, name, sizeof(name));
			
			Format(query, sizeof(query), "INSERT INTO %s (Playername, SteamID) VALUES ('%s', '%s')", Xstats_playerstats_tf2, name, auth);
			db.Query(DBQuery_AddClient, query, client);
		}
	}
}

void DBQuery_AddClient(Database database, DBResultSet results, const char[] error, int client)	{
	if(results == null)	{
		PrintToServer("[%s] Adding the client %N to stats table list failed! (%s)", PLUGIN_NAME, client, error);
		return;
	}
	
	if(xstats.Debug())
		PrintToServer("[%s] Adding client %N to stats table list succeded!", PLUGIN_NAME, client);
}

//==================================//

void ApplyWeapon(char[] target, char[] steamid)	{
	ApplyUpdate(target, true, 1, steamid);
}

void ApplyUpdate(char[] target, bool addition, int change, char[] steamid)	{
	//Lets check if the table exists.
	char query[1024];
	Format(query, sizeof(query), "SELECT %s FROM %s", target, Xstats_playerstats_tf2);
	
	//Important to send over.
	DataPack pack = new DataPack();
	pack.WriteString(target);
	pack.WriteCell(addition);
	pack.WriteCell(change);
	pack.WriteString(steamid);
	
	db.Query(DBQuery_ApplyUpdate, query, pack);
}

void DBQuery_ApplyUpdate(Database database, DBResultSet results, const char[] error, DataPack pack)	{
	pack.Reset();
	
	char target[512];
	pack.ReadString(target, sizeof(target));
	
	bool addition = pack.ReadCell();
	int change = pack.ReadCell();
	
	char steamid[64];
	pack.ReadString(steamid, sizeof(steamid));
	delete pack;
	
	switch(results == null)	{
		//Table was found, lets apply the changes.
		case	false:	{
			char query[1024];
			switch(addition)	{
				case	true:	Format(query, sizeof(query), "UPDATE %s SET %s = %s+%d WHERE SteamID='%s'", Xstats_playerstats_tf2, target, target, change, steamid);
				case	false:	Format(query, sizeof(query), "UPDATE %s SET %s = %s-%d WHERE SteamID='%s'", Xstats_playerstats_tf2, target, target, change, steamid);
			}
			database.Query(DBQuery_ApplyUpdateTableReport, query);
		}
		//Table wasn't found, lets add it and apply the changs.
		case	true:	{
			char query[1024];
			Format(query, sizeof(query), "ALTER TABLE %s ADD %s int(64) NOT NULL DEFAULT '0'", Xstats_playerstats_tf2, target);
			database.Query(DBQuery_ApplyUpdateTableReport, query);
			
			switch(addition)	{
				case	true:	Format(query, sizeof(query), "UPDATE %s SET %s = %s+%d WHERE SteamID='%s'", Xstats_playerstats_tf2, target, target, change, steamid);
				case	false:	Format(query, sizeof(query), "UPDATE %s SET %s = %s-%d WHERE SteamID='%s'", Xstats_playerstats_tf2, target, target, change, steamid);
			}
			database.Query(DBQuery_ApplyUpdateTableReport, query);
		}
	}
}

void DBQuery_ApplyUpdateTableReport(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null)	{
		bool avoid = view_as<bool>(StrContains(error, "Duplicate column name", false) != -1);
		if(!avoid && xstats.Debug())
			PrintToServer("[%s] Apply Update Table Report has failed! (%s)", PLUGIN_NAME, error);
		return;
	}
}