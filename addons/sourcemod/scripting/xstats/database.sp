void PrepareDatabase(bool PluginLoad = false)	{
	if(!SQL_CheckConfig("xstats"))
		XStats_DebugText(true, "FATAL ERROR 404 DATABASE_NOT_CONFIGURED: \"xstats\" was not found in the /configs/databases.cfg file, make sure you've entered it and correctly, must be matching \"xstats\" or else it'll fail.");
	
	/* Avoid double-connections. */
	CreateTimer(PluginLoad ? 0.0 : 0.5, Timer_PrepareDatabase);
}

/* May seem like a duplicate from PrepareDatabase but this is to make sure the direct database connection is available.*/
stock bool DatabaseDirect()	{
	if(DB.Direct != null)
		return true;
	
	XStats_DebugText(false, "[DatabaseDirect] Detected invalid direct database connection, establishing new one..");
	
	char error[512];
	DB.Direct = SQL_Connect(Xstats, false, error, sizeof(error));
	
	switch(DB.Direct = null)	{
		case true:	{
			DB.Direct.SetCharset("utf8mb4"); /* Fix characters */
			XStats_DebugText(false, "[DatabaseDirect] Direct database connection was succesful!");
			return true;
		}
		case false:	{
			XStats_DebugText(false, "[DatabaseDirect] Establishing direct database connection has failed (%s)", error);
			return false;
		}
	}
	
	return false;
}

Action Timer_PrepareDatabase(Handle timer) {
	if(DB.Threaded == null) /* If it's not null, we don't need to gather new connection since we already have one, prevent corruption. */
		Database.Connect(DBConnect, Xstats);
	
	char error[512];
	if(DB.Direct == null)	{
		switch((DB.Direct = SQL_Connect(Xstats, false, error, sizeof(error))) != null)	{
			case true:	{
				DB.Direct.SetCharset("utf8mb4"); /* Fix characters */
				XStats_DebugText(false, "[PrepareDatabase] Direct database connection was successful!");
			}
			case false: XStats_DebugText(false, "[PrepareDatabase] Establishing direct database connection has failed (%s)", error);
		}
	}
}

void DBConnect(Database database, const char[] error, any data)	{
	if(database == null) {
		delete database;
		XStats_DebugText(true, "Database connection failed! (%s)", error);
		return;
	}
	
	DB.Threaded = database;
	DB.Threaded.SetCharset("utf8mb4"); //Fix characters.
	XStats_DebugText(false, "Database connection was successful!");
	Games_DatabaseConnected();
}

/* Unused */
stock void GetNewDBConnection()	{
	if(DB.Threaded != null)
		return; /* no need to gather new connection since we already have one, prevent corruption. */
	
	CreateTimer(10.0, RetryDBConnection);
}

Action RetryDBConnection(Handle timer)	{
	PrepareDatabase();
}