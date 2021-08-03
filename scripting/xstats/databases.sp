Database db = null;

bool	Native_DB_Succeed = false, Native_DB_Initiated = false;
	//These are regarding the native database calls.

void LoadDB()	{
	if(db == null)
		Database.Connect(DBConnect, XSTATS_DBNAME);
}

void DBConnect(Database database, const char[] error, int data)	{
	switch(database)	{
		case	null:	{
			CreateTimer(10.0, DBConnect_RetryTimer);
			switch(StrContains(error, "Could not find database config", false) != -1)	{
				case	true:	SetFailState("[Xstats] Database connection to \"xstats\" has failed! (%s)", error);
				case	false:	PrintToServer("[Xstats] Database connection to \"xstats\" has failed! (%s), retrying in 10 seconds..", error);
			}
			
			if(Native_DB_Initiated)
				Native_DB_Succeed = false;
		}
		default:	{
			PrintToServer("[Xstats] Database connection to \"xstats\" was successful!");
			db = database;
			db.SetCharset("utf8mb4");
			
			if(Native_DB_Initiated)
				Native_DB_Succeed = true;
			
			GlobalForward connection = new GlobalForward("xstats_OnDatabaseConnected", ET_Event, Param_Any);
			Call_StartForward(connection);
			Call_PushCell(database);
			Call_Finish();
			delete connection;
			
		}
	}
}

Action DBConnect_RetryTimer(Handle timer)	{
	Database.Connect(DBConnect, XSTATS_DBNAME);
	PrintToServer("[Xstats] Retrying database connection..");
}