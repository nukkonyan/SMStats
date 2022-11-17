void PrepareDatabase(bool PluginLoad = false)	{
	if(!DatabaseEx.CheckConfig("xstats"))
		XStats_DebugText(true, "FATAL ERROR 404 DATABASE_NOT_CONFIGURED: \"xstats\" was not found in the /configs/databases.cfg file, make sure you've entered it and correctly, must be matching \"xstats\" or else it'll fail.");
	
	/* Avoid double-connections. */
	CreateTimer(PluginLoad ? 0.0 : 0.5, Timer_PrepareDatabase);
}

Action Timer_PrepareDatabase(Handle timer) {
	if(!SQL) /* If it's not null, we don't need to gather new connection since we already have one, prevent corruption. */
		DatabaseEx.Connect(DBConnect, Xstats);
}

void DBConnect(DatabaseEx database, const char[] error) {
	if(database == null) {
		delete database;
		XStats_DebugText(true, "Database connection failed! (%s)", error);
		return;
	}
	
	SQL = database;
	SQL.SetCharset("utf8mb4"); //Fix characters.
	XStats_DebugText(false, "Database connection was successful!");
	Games_DatabaseConnected();
}

/* Unused */
stock void GetNewDBConnection()	{
	if(SQL != null) return; /* no need to gather new connection since we already have one, prevent corruption. */
	
	CreateTimer(10.0, RetryDBConnection);
}

Action RetryDBConnection(Handle timer) { PrepareDatabase(); }