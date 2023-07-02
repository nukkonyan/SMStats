#if _sm_country_geoip_included
#pragma error GeoIP Country Translation is already included.
#endif

#define _sm_country_geoip_included

#if !defined _geoip_included
#include <geoip>
#endif

/*
 *	Returns the country name from sm_geoip_country.phrases.txt in the targets language.
 *
 *	@param	target	The users index to read language from.
 *	@param	ip		The ip to read country from.
 *	@param	name	The buffer to write to.
 *	@param	maxlen	The length of the buffer.
 *
 *	@noreturn 
 */
stock void GeoipCountryName(int target, const char[] ip, char[] name, int maxlen)
{
	if(!GeoipCountry(ip, name, maxlen))
	{
		Format(name, maxlen, "%T", "#SM_CountryName_ZZ", target);
		return;
	}
	
	char ccode[3];	
	switch(GeoipCode2(ip, ccode))
	{
		case false:
		{
			Format(name, maxlen, "%T", "#SM_CountryName_ZZ", target);
		}
		
		case true:
		{
			for(int i = 0; i < strlen(ccode); i++)
			{
				ccode[i] = CharToUpper(ccode[i]);
			}
			
			Format(name, maxlen, "#SM_CountryName_%s", ccode);
			Format(name, maxlen, "%T", name, target);
		}
	}
}

/*
 *	Load the translation file.
 */
stock void GeoipCountryLoadTranslation()
{
	char path[32];
	BuildPath(Path_SM, path, sizeof(path), "translations/geoip_country.phrases.txt");
	
	if(!FileExists(path))
	{
		SetFailState("Failed to load Geoip country translation file!");
	}
	
	LoadTranslations("geoip_country.phrases");
}