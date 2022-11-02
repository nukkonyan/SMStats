//==========================================//
// Tklib / Strings.
//==========================================//
#if !defined _tklib_disable_strings

/**
 *	Tests whether a string is found in another string.
 *	This is same as StrContains but no need to use the -1 at the end, now just returns true or false.
 *
 *	@param	str				String to search in.
 *	@param	substr			Substring to find inside the original string.
 *	@param	caseSensitive	if true (by default), search is case sensitive. If false, search is case insensitive.
 */
stock bool StrContainsEx(const char[] str, const char[] substr, bool caseSensitive=true) {
	if(StrContains(str, substr, caseSensitive) > -1)
		return true;
	return false;
}

/**
 *	Alternative to strcopy, adds ability to use extra parameters.
 *	Pretty much does the same as Format.
 *
 *	@param	dest		Destination buffer to copy to.
 *	@param	destLen		Destination buffer length (includes null terminator).
 *	@param	source		Source string to copy from.
 *
 *	@return				Number of cells written.
 */
stock int strcopyEx(char[] dest, int destLen, const char[] source, any...) { return VFormat(dest, destLen, source, 4); }

/**
 *	Turns a string into a boolean.
 *
 *	@param	str		String to convert.
 *	@param	nBase	Numerical base to use. 10 is default.
 *
 *	@return	Boolean conversion of string or false on failure.
 */
stock bool StringToBool(const char[] str, int nBase=10) { return view_as<bool>(StringToInt(str, nBase)); }

/**
 *	Returns if the string is valid and not NULL.
 *
 *	@param	str	The string to check.
 *
 *	@return	If the string is empty, this returns false.
 */
stock bool IsValidString(const char[] str) { return (!StrEqual(str, "") && StrLen(str) > 0); }

/**
 *	Retrieves the string value via integer.
 *	This value is passed through as a string to the StringMap array handle.
 *
 *	@param	map		The StringMap array handle.
 *	@param	value	The value to retrieve value from.
 *
 *	@error	If the handle is invalid, this returns false.
 */
stock bool GetTrieStringInt(Handle map, int key, char[] value, int max_size, int &size=0) {
	if(!map) return false;
	
	char[] val = new char[64];
	Format(val, 64, "%i", key);
	return view_as<StringMap>(map).GetString(val, value, max_size, size);
}

/**
 *	Retrieves the integer value from a value passed as string via integer.
 *	This value is passed through as a string to the StringMap array handle.
 *
 *	@param	map		The StringMap array handle.
 *	@param	value	The value to retrieve value from.
 *
 *	@error	If the handle is invalid, this returns -1.
 */
stock int GetTrieStringIntEx(Handle map, int key, int &size=0) {
	if(!map) return -1;
	
	char[] buffer = new char[96];
	char[] val = new char[64];
	Format(val, 64, "%i", key);
	view_as<StringMap>(map).GetString(val, buffer, 96, size);
	return StringToInt(buffer);
}

/**
 *	Set a string via integer in the map, either inserting a new entry or replacing and old one.
 *	This value is passed through as a string to the StringMap array handle.
 *
 *	@param	map			The StringMap array handle.
 *	@param	key			Key string via integer.
 *	@param	value		String via integer to store.
 *	@param	replace		If false, operation will fail if they key is already set.
 *
 *	@return	True on success, false on failure.
 *
 *	@error	If the handle is invalid, this returns false.
 */
stock bool SetTrieStringInt(Handle map, int key, int value, bool replace=true) {
	if(!map) return false;
	
	char[] fmt = new char[64];
	char[] val = new char[64];
	Format(fmt, 64, "%i", key);
	Format(val, 64, "%i", value);
	return view_as<StringMap>(map).SetString(fmt, val, replace);
}

/**
 *	Returns if the string contains an integer.
 *
 *	@param	str		The string.
 *	@param	value	The integer to check.
 */
stock bool StrContainsInt(const char[] str, int value) {
	char fmt[24];
	IntToString(value, fmt, sizeof(fmt));
	return view_as<bool>(StrContains(str, fmt, false) != -1);
}

/**
 *	Returns if the entity is equal to the entity classname.
 *
 *	@param	entity	The entity index.
 *	@param	clsname	The entity classname.
 *
 *	@return	If matched, returns true. False otherwise.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool StrEqualEntity(int entity, const char[] clsname) {
	if(!IsValidEntityEx(entity)) return false;
	
	char temp[64];
	return view_as<bool>(GetEntPropStringEx(entity, Prop_Data, "m_iClassname", temp, sizeof(temp)) && StrEqual(temp, clsname));
}

/**
 *	Returns if the entity contains the entity classname
 *
 *	@param	entity	The entity index.
 *	@param	clsname	The entity classname.
 *
 *	@return	If containing, returns true. False otherwise.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool StrContainsEntity(int entity, const char[] clsname) {
	if(!IsValidEntityEx(entity)) return false;
	
	char temp[64];
	return view_as<bool>(GetEntPropStringEx(entity, Prop_Data, "m_iClassname", temp, sizeof(temp) && StrContains(temp, clsname, false) != -1));
}

/**
 *	Converts a string to any.
 *
 *	@param	str		String to convert.
 *	@param	nBase	Numerical base to use.  10 is default.
 *
 *	@return			Any conversion of string, or 0 on failure.
 */
stock any StringToAny(const char[] str, int nBase=10) { return view_as<any>(StringToInt(str, nBase)); }

/**
 *	Returns if the string contains a number.
 *
 *	@param	str	The string to check.
 */
stock bool StrHasNumbers(const char[] str) {
	return (StrContainsEx(str, "1", false) || StrContainsEx(str, "2", false)
	|| StrContainsEx(str, "3", false) || StrContainsEx(str, "4", false)
	|| StrContainsEx(str, "5", false) || StrContainsEx(str, "6", false)
	|| StrContainsEx(str, "7", false) || StrContainsEx(str, "8", false)
	|| StrContainsEx(str, "9", false) || StrContainsEx(str, "0", false));
}

/**
 *	Returns the string length properly.
 *	Use this over strlen().
 *
 *	@param	str		The string to get the length of.
 *
 *	@return	Returns the string length.
 */
stock int StrLen(const char[] str) { return strlen(str)+1; }

/**
 * Converts an integer to a string.
 *
 *	@param num           Boolean to convert.
 *	@param str           Buffer to store string in.
 *	@param maxlength     Maximum length of string buffer.
 *
 *	@return              Number of cells written to buffer.
 */
stock int BoolToString(bool num, char[] str, int maxlength) { return IntToString(view_as<int>(num), str, maxlength); }

/**
 *	Converts the string into lowercase
 *	Certain alphabetic characters such as Üü Åå Ää Öö aren't supported ...
 *	as SourceMod will be confused about em'.
 *
 *	@param	str		The string to convert.
 *	@param	subStr	The string to store.
 *	@param	len		The length of the string.
 *
 *	@return void
 */
stock void StrToLower(const char[] str, char[] subStr, int len) {
	len--;
	int i = 0;
	while(str[i] != '\0' && i < len) { subStr[i] = CharToLower(str[i++]); }
	subStr[i] = '\0';
}

#endif