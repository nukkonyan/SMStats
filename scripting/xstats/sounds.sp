/**
 *	Initialize Player connect sounds.
 */
void PrepareSounds()	{
	Sound[0].cvar = CreateConVar("xstats_connectsound_generic",	"buttons/blip1.wav", "Xstats - Should sound be played when player connects?.");
	Sound[1].cvar = CreateConVar("xstats_connectsound_top10",	"xstats/top10.wav", "Xstats - Should sound be played when top 10 player connects? (overrides generic)");
	
	for(int c = 0; c < 1; c++)	{
		Sound[c].cvar.AddChangeHook(SndHook);
		Sound[c].cvar.GetString(Sound[c].path, sizeof(Sound[].path));
		if(!StrEqual(Sound[c].path, NULL_STRING))	{
			PrecacheSound(Sound[c].path);
			AddFileToDownloadsTableEx("sound/%s", Sound[c].path);
		}
	}
}

void SndHook(ConVar cvar, const char[] oldvalue, const char[] newvalue)	{
	/* pls make cvars available on switches, it'll make things much easier. >_< */
	
	if(cvar == Sound[0].cvar)
		cvar.GetString(Sound[0].path, sizeof(Sound[].path));
	
	if(cvar == Sound[1].cvar)
		cvar.GetString(Sound[1].path, sizeof(Sound[].path));
	
	if(!StrEqual(newvalue, NULL_STRING))	{
		PrecacheSound(newvalue);
		AddFileToDownloadsTableEx("sound/%s", newvalue);
	}
}