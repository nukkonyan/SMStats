void LoadCommands()	{
	//RegAdminCmd("sm_addachievement", AddAchievementCmd, ADMFLAG_ROOT, "Xstats: Achievements - Create a custom achievement.");
	
}

//public Action AddAchievementCmd(int client, int args)	{
//	switch(IdentifyGame())	{
//		case	Game_TF2, Game_TF2C:	{
//			char arg[22][256];
//			for(int i = 1; i < 23; i++)	{
//				GetCmdArg(i, arg[i], sizeof(arg[]));
//			}
//			
//			int	AchievementID		=	StringToInt(arg[1]);
//			int	AchievementType		=	StringToInt(arg[2]);
//			
//			int	RequiredClass		=	StringToInt(arg[3]);
//			int	Kills				=	StringToInt(arg[4]);
//			int	KillsRequired		=	StringToInt(arg[5]);
//			int	Backstabs			=	StringToInt(arg[6]);
//			int	BackstabsRequired	=	StringToInt(arg[7]);
//			int	Headshots			=	StringToInt(arg[8]);
//			
//		}
//	}
//}