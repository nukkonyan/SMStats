void PrepareDatabase()	{
	Database.Connect(DBConnect, "xstats");
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