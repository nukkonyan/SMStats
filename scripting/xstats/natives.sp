/**
 *	Prepare the natives.
 */
void PrepareNatives()
{
	CreateNative("xStats_GetClientPoints", Native_GetClientPoints);
	CreateNative("Xstats.GetPoints", Public_GetClientPoints);
	
	CreateNative("xStats_GetClientPlayTime", Native_GetClientPlayTime);
	CreateNative("Xstats.GetPlayTime", Public_GetClientPlayTime);
}

any Native_GetClientPoints(Handle plugin, int params)
{
	char auth[64];
	GetNativeString(1, auth, sizeof(auth));
	return GetClientPoints(auth);
}
any Public_GetClientPoints(Handle plugin, int params)
{
	char auth[64];
	GetNativeString(2, auth, sizeof(auth));
	return GetClientPoints(auth);
}

any Native_GetClientPlayTime(Handle plugin, int params)
{
	char auth[64];
	GetNativeString(1, auth, sizeof(auth));
	return GetClientPlayTime(auth);
}
any Public_GetClientPlayTime(Handle plugin, int params)
{
	char auth[64];
	GetNativeString(2, auth, sizeof(auth));
	return GetClientPlayTime(auth);
}