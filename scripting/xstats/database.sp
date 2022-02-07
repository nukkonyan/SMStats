void PrepareDatabase()	{
	if(DB.Threaded == null) /* If it's not null, we don't need to gather new connection since we already have one, prevent corruption. */
		Database.Connect(DBConnect, Xstats);
	
	if(DB.Direct == null)	{
		if((DB.Direct = SQL_Connect2(Xstats, false)) != null)
			DB.Direct.SetCharset("utf8mb4"); /* Fix characters */
	}
}

void DBConnect(Database database, const char[] error, any data)	{
	if(!IsValidDatabase(database))	{
		delete database;
		SetFailState("%s Database connection failed! (%s)", LogTag, error);
		return;
	}
	
	DB.Threaded = database;
	DB.Threaded.SetCharset("utf8mb4"); //Fix characters.
	PrintToServer("%s Database connection was successful!", LogTag);
	
	Games_DatabaseConnected();
}

stock void GetNewDBConnection()	{
	if(db != null)
		return; /* no need to gather new connection since we already have one, prevent corruption. */
	
	CreateTimer(10.0, RetryDBConnection);
}

Action RetryDBConnection(Handle timer)	{
	PrepareDatabase();
}