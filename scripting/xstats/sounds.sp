/**
 *	Initialize Player connect sounds.
 */
void PrepareSounds()	{
	ConnectSnd[0] = CreateConVar("xstats_connectsound_generic",	"buttons/blip1.wav", "Xstats - Should sound be played when player connects?.");
	ConnectSnd[1] = CreateConVar("xstats_connectsound_top10",	"xstats/top10.wav", "Xstats - Should sound be played when top 10 player connects? (overrides generic)");
	
	ConnectSnd[0].AddChangeHook(SndHook);
	ConnectSnd[0].GetString(ConnectSound[0], sizeof(ConnectSound[]));
	if(!StrEqual(ConnectSound[0], NULL_STRING))	{
		PrecacheSound(ConnectSound[0]);
		AddFileToDownloadsTableEx("sound/%s", ConnectSound[0]);
	}
	
	ConnectSnd[1].AddChangeHook(SndHook);
	ConnectSnd[1].GetString(ConnectSound[1], sizeof(ConnectSound[]));
	if(!StrEqual(ConnectSound[1], NULL_STRING))	{
		PrecacheSound(ConnectSound[1]);
		AddFileToDownloadsTableEx("sound/%s", ConnectSound[1]);
	}
}

void SndHook(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	/* pls make cvars available on switches, it'll make things much easier. >_< */
	
	if(cvar == ConnectSnd[0])
		cvar.GetString(ConnectSound[0], sizeof(ConnectSnd[]));
	
	if(cvar == ConnectSnd[1])
		cvar.GetString(ConnectSound[1], sizeof(ConnectSnd[]));
	
	if(!StrEqual(newvalue, NULL_STRING))	{
		PrecacheSound(newvalue);
		AddFileToDownloadsTableEx("sound/%s", newvalue);
	}
}