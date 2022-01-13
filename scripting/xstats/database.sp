void PrepareDatabase()	{
	if(db != null)
		return; /* no need to gather new connection since we already have one, prevent corruption. */
	
	Database.Connect(DBConnect, Xstats);
}

void DBConnect(Database database, const char[] error, any data)	{
	if(!IsValidDatabase(database))	{
		delete database;
		SetFailState("%s Database connection failed! (%s)", LogTag, error);
		return;
	}
	
	db = database;
	db.SetCharset("utf8mb4"); //Fix characters.
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