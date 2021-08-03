Database db = null;

void UploadDB(Database database)	{
	if(xstats.Debug())
		PrintToServer("[%s] Uploading database tables..", PLUGIN_NAME);
	
	char query[8192];
	int len = 0;
	
	len	+=	Format(query[len], sizeof(query)-len, "CREATE TABLE IF NOT EXISTS `%s`", Game_Achievements);
	len	+=	Format(query[len], sizeof(query)-len, "(");
	len	+=	Format(query[len], sizeof(query)-len, "`Playername`					varchar(64)		NOT NULL	DEFAULT ''				COMMENT	'Players name.',");
	len	+=	Format(query[len], sizeof(query)-len, "`SteamID`					varchar(64)		NOT NULL	DEFAULT ''				COMMENT 'Players SteamID',");
	len	+=	Format(query[len], sizeof(query)-len, "PRIMARY KEY (`SteamID`)");
	len	+=	Format(query[len], sizeof(query)-len, ")");
	len +=	Format(query[len], sizeof(query)-len, "AUTO_INCREMENT=1");
	database.Query(DBQuery_UploadDB, query);
	
	UploadTables();
	
	//Incase something is gonna get added here.
	len = 0;
	query = "";
}

void DBQuery_UploadDB(Database database, DBResultSet results, const char[] error, any data)	{
	if(results == null && xstats.Debug())
		PrintToServer("[%s] Error Uploading Database: %s", PLUGIN_NAME, error);
}

void AddTable(char[] table_name="", bool integer=false, char[] default_value, char[] comment)	{
	char query[8192];
	switch(integer)	{
		case	true:	Format(query, sizeof(query), "ALTER TABLE %s ADD %s	int(64)		DEFAULT '%d' COMMENT '%s'", Game_Achievements, table_name, default_value, comment);
		case	false:	Format(query, sizeof(query), "ALTER TABLE %s ADD %s	varchar(64)	DEFAULT '%s' COMMENT '%s'", Game_Achievements, table_name, default_value, comment);
	}
	db.Query(DBQuery_Import, query);
}

/**
 *	Always makes sure the achievements are up-to-date. (This will be updated over time.)
 */
void UploadTables()	{
	if(xstats.Debug())
		PrintToServer("[%s] Upload achievement tables..", PLUGIN_NAME);
	
	switch(IdentifyGame())	{
		case	Game_TF2:	{
			AddTable("Achievement1",			false,	"Headhunter",	"Achievement Headhunter");
			AddTable("Achievement1_Kills",		true,	"0",			"Achievement Headhunter: Amount of headshots");
			AddTable("Achievement1_Required",	true,	"50",			"Achievement Headhunter: Required kills");
		}
	}
}