methodmap MenuEx < Menu {
	public MenuEx(MenuHandler handler) { return view_as<MenuEx>(new Menu(handler)); }
	
	/*
	 *	Displays a menu to a user.
	 *
	 *	@param	client	The users index.
	 *	@param	time	Maximum time to leave menu on the screen.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool Display(int client, int time = MENU_TIME_FOREVER) { return view_as<Menu>(this).Display(client, time); }

	/*
	 *	Displays a menu to a user, starting from the given item.
	 *
	 *	@param	client		The users index.
	 *	@param	first_item	First item to begin drawing from.
	 *	@param	time		Maximum time to leave menu on the screen.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool DisplayAt(int client, int first_item, int time = MENU_TIME_FOREVER) { return view_as<Menu>(this).DisplayAt(client, first_item, time); }
	
	public void SetTitle(const char[] fmt, any ...) {
		int maxlen = strlen(fmt)+65;
		char[] format = new char[maxlen];
		VFormat(format, maxlen, fmt, 3);
		view_as<Menu>(this).SetTitle(format);
	}
	
	public void GetTitle(char[] buffer, int maxlen) { view_as<Menu>(this).GetTitle(buffer, maxlen); }
	
	public bool AddItem(const char[] info, const char[] display, int style = ITEMDRAW_DEFAULT) { return view_as<Menu>(this).AddItem(info, display, style); }
	
	public bool AddItemEx(const char[] info, const char[] display, int style = ITEMDRAW_DEFAULT, any ...) {
		int maxlen = strlen(display)+128;
		char[] format = new char[maxlen++];
		VFormat(format, maxlen, display, 5);
		return view_as<Menu>(this).AddItem(info, format, style);
	}
	
	public bool AddItemInt(int info, const char[] display, int style = ITEMDRAW_DEFAULT) {
		char dummy[16];
		IntToString(info, dummy, sizeof(dummy));
		return view_as<Menu>(this).AddItem(dummy, display, style);
	}
	
	public bool AddItemIntEx(int info, const char[] display, int style = ITEMDRAW_DEFAULT, any ...) {
		char dummy[16];
		IntToString(info, dummy, sizeof(dummy));
		int maxlen = strlen(display)*3;
		char[] format = new char[maxlen++];
		VFormat(format, maxlen, display, 5);
		return view_as<Menu>(this).AddItem(dummy, format, style);
	}
	
	public bool AddItemAny(any info, const char[] display, int style = ITEMDRAW_DEFAULT) {
		char dummy[16];
		IntToString(info, dummy, sizeof(dummy));
		return view_as<Menu>(this).AddItem(dummy, display, style);
	}
	
	public bool AddItemAnyEx(any info, const char[] display, int style = ITEMDRAW_DEFAULT, any ...) {
		char dummy[16];
		IntToString(info, dummy, sizeof(dummy));
		int maxlen = strlen(display)*3;
		char[] format = new char[maxlen++];
		VFormat(dummy, maxlen, display, 5);
		return view_as<Menu>(this).AddItem(dummy, format, style);
	}
	
	public bool AddItemFloat(float info, const char[] display, int style = ITEMDRAW_DEFAULT) {
		char dummy[16];
		FloatToString(info, dummy, sizeof(dummy));
		return view_as<Menu>(this).AddItem(dummy, display, style);
	}
	
	public bool AddItemFloatEx(float info, const char[] display, int style = ITEMDRAW_DEFAULT, any ...) {
		char dummy[16];
		FloatToString(info, dummy, sizeof(dummy));
		int maxlen = strlen(display)*3;
		char[] format = new char[maxlen++];
		VFormat(format, maxlen, display, 5);
		return view_as<Menu>(this).AddItem(dummy, format, style);
	}
	
	public bool VoteMenuAll(int time, int flags = 0) { return VoteMenuToAll(view_as<Menu>(this), time, flags); }
	
	public int GetItemIndex(int position, int &style=0, char[] dispBuf="", int dispBufLen=0) {
		char dummy[16];
		view_as<Menu>(this).GetItem(position, dummy, sizeof(dummy), style, dispBuf, dispBufLen);
		return StringToInt(dummy);
	}
	
	public float GetItemFloat(int position, int &style=0, char[] dispBuf="", int dispBufLen=0) {
		char dummy[16];
		view_as<Menu>(this).GetItem(position, dummy, sizeof(dummy), style, dispBuf, dispBufLen);
		return StringToFloat(dummy);
	}
	
	public any GetItemAny(int position, int &style=0, char[] dispBuf="", int dispBufLen=0) {
		char dummy[16];
		view_as<Menu>(this).GetItem(position, dummy, sizeof(dummy), style, dispBuf, dispBufLen);
		return StringToInt(dummy);
	}
	
	/**
	 *	Returns if the item position contains string.
	 *
	 *	@param	position		The item position.
	 *	@param	substr			The substring used to check if item contains defined string value.
	 *	@param	caseSensitive	If true, search is case sensitive.
	 */
	public bool ItemStrContains(int position, const char[] substr, bool caseSensitive=false) {
		char dummy[128];
		view_as<Menu>(this).GetItem(position, dummy, sizeof(dummy));
		return (StrContains(dummy, substr, caseSensitive) > 0);
	}
}

methodmap PanelEx < Panel {
	/*
	 *	Constructor for a new Panel.
	 *
	 *	@param	hStyle	MenuStyle Handle, or null to use the default style.
	 */
	public PanelEx(Handle hStyle=null) {return view_as<PanelEx>(new Panel(hStyle));}
	
	/*
	 *	Sets the panel's title.
	 *
	 *	@param	text	Text to set as the title.
	 *	@param	...		Additional parameters.
	 */
	public bool SetTitle(const char[] text, any ...) {
		int maxlen = strlen(text)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, text, 3); /* 1 is the panel, 2 is the input, 3 is the parameters */
		view_as<Panel>(this).SetTitle(dummy);
	}
	
	/*
	 *	Draws an item on a panel.  If the item takes up a slot, the position is returned.
	 *
	 *	@param	text	Display text to use.  If not a raw line,
	 *					the style may automatically add color markup.
	 *					No numbering or newlines are needed.
	 *
	 *	@param	...		Additional parameters.
	 *
	 *	@return			A slot position, or 0 if item was a rawline or could not be drawn.
	 */
	public int DrawItem(const char[] text, any ...) {
		int maxlen = strlen(text)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, text, 3);
		return view_as<Panel>(this).DrawItem(dummy);
	}
	
	/*
	 *	Draws an item on a panel.  If the item takes up a slot, the position is returned.
	 *
	 *	@param	text	Display text to use.  If not a raw line,
	 *					the style may automatically add color markup.
	 *					No numbering or newlines are needed.
	 *
	 *	@param	style	ITEMDRAW style flags.
	 *	@param	...		Additional parameters.
	 *
	 *	@return			A slot position, or 0 if item was a rawline or could not be drawn.
	 */
	public int DrawItemEx(const char[] text, int style=ITEMDRAW_DEFAULT, any ...) {
		int maxlen = strlen(text)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, text, 4);
		return view_as<Panel>(this).DrawItem(dummy, style);
	}
	
	/*
	 *	Draws a raw line of text on a panel, without any markup other than a newline.
	 *
	 *	@param	text	Display text to use.
	 *	@param	...		Additional parameters.
	 *
	 *	@return			True on success, false if raw lines are not supported.
	 */
	public bool DrawText(const char[] text, any ...) {
		int maxlen = strlen(text)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, text, 3);
		return view_as<Panel>(this).DrawText(dummy);
	}
	
	/*
	 *	Draws a space on a panel.
	 *
	 *	@return			True on success, false if raw lines are not supported.
	 */
	public bool DrawSpace() { return view_as<Panel>(this).DrawText(" "); }
	
	/*
	 *	Returns whether or not the given drawing flags are supported by the menu style.
	 *
	 *	@param	style	ITEMDRAW style flags.
	 *
	 *	@return		True if item is drawable, false otherwise.
	 */
	public bool CanDrawFlags(int style) { return view_as<Panel>(this).CanDrawFlags(style); }
	
	/*
	 *	Sets the selectable key map of a panel. This is not supported by
	 *											all styles (only by Radio, as of this writing).
	 *
	 *	@param	keys	An integer where each bit N allows key
	 *					N+1 to be selected.  If no keys are selectable,
	 *					then key 0 (bit 9) is automatically set.
	 *
	 *	@return			True if supported, false otherwise.
	 */
	public bool SetKeys(int keys) { return view_as<Panel>(this).SetKeys(keys); }
	
	/*
	 *	Sends a panel to a client.	Unlike full menus, the handler
	 *								function will only receive the following actions, both of
	 *								which will have null for a menu, and the client as param1.
	 *
	 *	MenuAction_Select (param2 will be the key pressed)
	 *	MenuAction_Cancel (param2 will be the reason)
	 *
	 *	Also, if the menu fails to display, no callbacks will be called.
	 *
	 *	The panel will be automatically destroyed after being sent.
	 *
	 *	@param	client		A client to draw to.
	 *	@param	handler		The MenuHandler function to catch actions with.
	 *	@param	time		Time to hold the menu for.
	 *
	 *	@return				True on success, false on failure.
	 */
	public void Send(int client, MenuHandler handler, int time=MENU_TIME_FOREVER)	{
		view_as<Panel>(this).Send(client, handler, time);
		delete view_as<Panel>(this);
	}
	
	/*
	 *	Returns the amount of text the menu can still hold.  If this is
	 *	limit is reached or overflowed, the text is silently truncated.
	 *
	 *	Radio menus: Currently 511 characters (512 bytes).
	 *	Valve menus: Currently -1 (no meaning).
	 */
	property int TextRemaining {
		public get() { return view_as<Panel>(this).TextRemaining; }
	}
	
	/*
	 *	Returns or sets the current key position, starting at 1. This cannot be
	 *	used to traverse backwards.
	 */
	property int CurrentKey {
		public get() { return view_as<Panel>(this).CurrentKey; }
		public set(int key) { view_as<Panel>(this).CurrentKey = key; }
	}
	
	/*
	 *	Returns the panel's style. Style handles are global and cannot be closed.
	 */
	property Handle Style {
		public get() { return view_as<Panel>(this).Style; }
	}
}

//May seem useless, just StringMap with additional functions
methodmap StringMapEx < StringMap {
	/*
	 *	Creates a hash map. A hash map is a container that can map strings (called
	 *	"keys") to arbitrary values (cells, arrays, or strings). Keys in a hash map
	 *	are unique. That is, there is at most one entry in the map for a given key.
	 *
	 *	Insertion, deletion, and lookup in a hash map are all considered to be fast
	 *	operations, amortized to O(1), or constant time.
	 *
	 *	The word "Trie" in this API is historical. As of SourceMod 1.6, tries have
	 *	been internally replaced with hash tables, which have O(1) insertion time
	 *	instead of O(n).
	 *
	 *	The StringMap must be freed via delete or CloseHandle().
	 */
	public StringMapEx() { return view_as<StringMapEx>(new StringMap()); }
	
	/*
	 *	Clones a string map, returning a new handle with the same size and data.
	 *	This should NOT be confused with CloneHandle. This is a completely new
	 *	handle with the same data but no relation to the original. It should be
	 *	closed when no longer needed with delete or CloseHandle().
	 *
	 *	@return	New handle to the cloned string map
	 */
	public StringMapEx Clone() { return view_as<StringMapEx>(view_as<StringMap>(this).Clone()); }
	
	/*
	 *	Sets a value in a hash map, either inserting a new entry or replacing an old one.
	 *
	 *	@param	key			Key string.
	 *	@param	value		Value to store at this key.
	 *	@param	replace		If false, operation will fail if the key is already set.
	 *	@param	...			Additional key parameters.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool SetValue(const char[] key, any value, bool replace=true, any ...) {
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 4);
		return view_as<StringMap>(this).SetValue(dummy, value, replace);
	}
	
	/*
	 *	Retrieves a value in a Map.
	 *
	 *	@param	key		Key string.
	 *	@param	size	Optional parameter to store the number of elements written to the buffer.
	 *	@param	...		Additional key parameters.
	 *
	 *	@return	True on success. False if the key is not set, or the key is set as an array or string (not a value).
	 */
	public bool GetValue(const char[] key, int &size=0, any ...) {
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 3);
		return view_as<StringMap>(this).GetValue(dummy, size);
	}
	
	/*
	 *	Sets an array value in a Map, either inserting a new entry or replacing an old one.
	 *
	 *	@param	key			Key string.
	 *	@param	array		Array to store.
	 *	@param	array_size	Number of items in the array. (Array size)
	 *	@param	replace		If false, operation will fail if the key is already set.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool SetArray(const char[] key, const any[] array, int array_size, bool replace=true, any ...) {
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 5);
		return view_as<StringMap>(this).SetArray(dummy, array, array_size, replace);
	}
	
	/*
	 *	Retrieves an array in a Map.
	 *	
	 *	@param	key			Key string.
	 *	@param	array		Buffer to store array.
	 *	@param	array_size	Maximum size of array buffer. (Array size)
	 *	@param	size		Optional parameter to store the number of elements written to the buffer.
	 *	@param	...			Additional key parameters.
	 *
	 *	@return	True on success.  False if the key is not set, or the key is set as a value or string (not an array).
	 */
	public bool GetArray(const char[] key, any[] array, int array_size, int &size=0, any ...) {
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 5);
		return view_as<StringMap>(this).GetArray(dummy, array, array_size, size);
	}
	
	/*
	 *	Sets a string value in a Map, either inserting a new entry or replacing an old one.
	 *
	 *	@param	key			Key string.
	 *	@param	value		String to store.
	 *	@param	replace		If false, operation will fail if the key is already set.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool SetString(const char[] key, const char[] value, bool replace=true) { return view_as<StringMap>(this).SetString(key, value, replace); }
	
	/*
	 *	Sets an index in a Map.
	 *
	 *	@param	key		Key string.
	 *	@param	value	Index to store.
	 *	@param	replace	If false, operation will fail if the key is already set.
	 *	@param	...		Additional key parameters.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool SetStringIndex(const char[] key, int index, bool replace=true, any ...) {
		char value[16];
		IntToString(index, value, sizeof(value));
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 4);
		return view_as<StringMap>(this).SetString(dummy, value, replace);
	}
	
	/*
	 *	Sets a value in a Map.
	 *
	 *	@param	key		Key string.
	 *	@param	value	Value to store.
	 *	@param	replace	If false, operation will fail if the key is already set.
	 *	@param	...		Additional key parameters.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool SetStringValue(const char[] key, any value, bool replace=true, any ...) {
		char val[16];
		IntToString(value, val, sizeof(val));
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 4);
		return view_as<StringMap>(this).SetString(dummy, val, replace);
	}
	
	/*
	 *	Sets a boolean value in a Map.
	 *
	 *	@param	key		Key string.
	 *	@param	size	Optional parameter to store the number of bytes written to the buffer.
	 *	@param	...		Additional key parameters.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool SetStringBool(const char[] key, bool value, bool replace=true, any ...) {
		char val[16];
		IntToString(view_as<int>(value), val, sizeof(val));
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 4);
		return view_as<StringMap>(this).SetString(dummy, val, replace);
	}
	
	/*
	 *	Sets a string value in a Map, either inserting a new entry or replacing an old one.
	 *
	 *	@param	index	Key index.
	 *	@param	value	String to store.
	 *	@param	replace	If false, operation will fail if the key is already set.
	 *	@param	...		Additional value parameters.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool SetIndexString(int index, const char[] value, bool replace=true, any ...) {
		char key[16];
		IntToString(index, key, sizeof(key));
		int maxlen = strlen(value)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, value, 4);
		return view_as<StringMap>(this).SetString(key, dummy, replace);
	}
	
	/*
	 *	Sets a string value in a Map, either inserting a new entry or replacing an old one.
	 *
	 *	@param	index	Key index.
	 *	@param	value	Index to store.
	 *	@param	replace	If false, operation will fail if the key is already set.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool SetIndex(int index, int value, bool replace=true) {
		char key[16], val[16];
		IntToString(index, key, sizeof(key));
		IntToString(value, val, sizeof(val));
		return view_as<StringMap>(this).SetString(key, val, replace);
	}
	
	/*
	 *	Sets an array value in a Map, either inserting a new entry or replacing an old one.
	 *
	 *	@param	index		Key index.
	 *	@param	array		Array to store.
	 *	@param	array_size	Number of items in the array.
	 *	@param	replace		If false, operation will fail if the key is already set.
	 *
	 *	@return	True on success, false on failure.
	 */
	public bool SetIndexArray(int index, const any[] array, int array_size, bool replace=true) {
		char key[16];
		IntToString(index, key, sizeof(key));
		return view_as<StringMap>(this).SetArray(key, array, array_size, replace);
	}
	
	/*
	 *	Retrieves a string in a Map.
	 *
	 *	@param	key		Key string.
	 *	@param	value	Buffer to store value.
	 *	@param	maxlen	Maximum size of string buffer.
	 *	@param	size	Optional parameter to store the number of bytes written to the buffer.
	 *	@param	...		Additional key parameters.
	 *
	 *	@return	True on success.  False if the key is not set, or the key is set as a value or array (not a string).
	 */
	public bool GetString(const char[] key, char[] value, int maxlen, int &size=0, any ...) {
		int len = strlen(key)*3;
		char[] dummy = new char[len++];
		VFormat(dummy, len, key, 5);
		return view_as<StringMap>(this).GetString(dummy, value, maxlen, size);
	}
	
	/*
	 *	Retrieves an index in a Map.
	 *
	 *	@param	key		Key string.
	 *	@param	size	Optional parameter to store the number of bytes written to the buffer.
	 *	@param	...		Additional key parameters.
	 *
	 *	@return	Value on success. -1 if the key is not set, or the key is set as a value or array (not a string).
	 */
	public int GetStringIndex(const char[] key, int &size=0, any ...) {
		char value[16];
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 3);
		if(!view_as<StringMap>(this).GetString(dummy, value, sizeof(value), size)) return -1;
		return StringToInt(value);
	}
	
	/*
	 *	Retrieves a value in a Map.
	 *
	 *	@param	key		Key string.
	 *	@param	size	Optional parameter to store the number of bytes written to the buffer.
	 *	@param	...		Additional key parameters.
	 *
	 *	@return	Value on success. -1 if the key is not set, or the key is set as a value or array (not a string).
	 */
	public any GetStringValue(const char[] key, int &size=0, any ...) {
		char value[16];
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 3);
		if(!view_as<StringMap>(this).GetString(dummy, value, sizeof(value), size)) return -1;
		return StringToInt(value);
	}
	
	/*
	 *	Retrieves a value in a Map.
	 *
	 *	@param	key		Key string.
	 *	@param	size	Optional parameter to store the number of bytes written to the buffer.
	 *	@param	...		Additional key parameters.
	 *
	 *	@return	Value on success. false if the key is not set, or the key is set as a value or array (not a string).
	 */
	public bool GetStringBool(const char[] key, int &size=0, any ...) {
		char value[16];
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 3);
		if(!view_as<StringMap>(this).GetString(dummy, value, sizeof(value), size)) return false;
		return view_as<bool>(StringToInt(value));
	}
	
	/*
	 *	Retrieves an index in a Map.
	 *
	 *	@param	index	Key index.
	 *	@param	size	Optional parameter to store the number of bytes written to the buffer.
	 *
	 *	@return	value on success. 0 if the key is not set, or the key is set as a value or array (not a string).
	 */
	public int GetIndex(int index, any &size=0) {
		char key[16], value[16];
		IntToString(index, key, sizeof(key));
		view_as<StringMap>(this).GetString(key, value, sizeof(value), size);
		return StringToInt(value);
	}
	
	/*
	 *	Retrieves a string in a Map.
	 *
	 *	@param	index	Key index.
	 *	@param	value	Buffer to store value.
	 *	@param	maxlen	Maximum size of string buffer.
	 *	@param	size	Optional parameter to store the number of bytes written to the buffer.
	 *	@param	...		Additional value parameters
	 *
	 *	@return	True on success.  False if the key is not set, or the key is set as a value or array (not a string).
	 */
	public bool GetIndexString(int index, char[] value, int maxlen, int &size=0, any ...) {
		char key[16];
		IntToString(index, key, sizeof(key));
		int len = strlen(value)*3;
		char[] dummy = new char[len++];
		VFormat(dummy, len, value, 5);
		return view_as<StringMap>(this).GetString(key, dummy, maxlen, size);
	}
	
	/*
	 *	Retrieves an array in a Map.
	 *	
	 *	@param	index		Key index.
	 *	@param	array		Buffer to store array.
	 *	@param	array_size	Maximum size of array buffer.
	 *	@param	size		Optional parameter to store the number of elements written to the buffer.
	 *
	 *	@return	True on success.  False if the key is not set, or the key is set as a value or string (not an array).
	 */
	public bool GetIndexArray(int index, any[] array, int array_size, int &size=0) {
		char key[16];
		IntToString(index, key, sizeof(key));
		return view_as<StringMap>(this).GetArray(key, array, array_size, size);
	}
	
	/*
	 *	Checks whether a key is present in a Map.
	 *
	 *	@param	key	Key string.
	 *
	 *	@return	True if the key has been found, else false.
	 */
	public bool ContainsKey(const char[] key) { return view_as<StringMap>(this).ContainsKey(key); }
	
	/*
	 *	Checks whether a key is present in a Map.
	 *
	 *	@param	index	Key index.
	 *
	 *	@return	True if the key has been found, else false.
	 */
	public bool ContainsIndex(int index) {
		char key[16];
		IntToString(index, key, sizeof(key));
		return view_as<StringMap>(this).ContainsKey(key);
	}
	
	/*
	 *	Removes a key entry from a Map.
	 *
	 *	@param	key	Key string.
	 *	@param	...	Additional key parameters.
	 *
	 *	@return	True on success, false if the value was never set.
	 */
	public bool Remove(const char[] key, any ...) {
		int maxlen = strlen(key)*3;
		char[] dummy = new char[maxlen++];
		VFormat(dummy, maxlen, key, 2);
		return view_as<StringMap>(this).Remove(dummy);
	}
	
	/*
	 *	Removes a key entry from a Map.
	 *
	 *	@param	index	Key index.
	 *
	 *	@return	True on success, false if the value was never set.
	 */
	public bool RemoveIndex(int index) {
		char key[16];
		IntToString(index, key, sizeof(key));
		return view_as<StringMap>(this).Remove(key);
	}

	/*
	 *	Clears all entries from a Map.
	 */
	public void Clear() { view_as<StringMap>(this).Clear(); }

	/*
	 *	Create a snapshot of the map's keys. See StringMapSnapshot.
	 */
	public Handle Snapshot() { view_as<StringMap>(this).Snapshot(); }

	/*
	 *	Retrieves the number of elements in a map.
	 */
	property int Size {
		public get() { return view_as<StringMap>(this).Size; }
	}
}

methodmap StringMapSnapshotEx < StringMapSnapshot {
	/**
	 *	Create a snapshot of the maps's keys. See StringMapSnapshot.
	 *	Same as StringMap.Snapshot(), but more 'straightforward' (?)
	 *
	 *	@param	stringmap	The map you want to clone its keys from.
	 */
	public StringMapSnapshotEx(Handle stringmap) { return view_as<StringMapSnapshotEx>(view_as<StringMap>(stringmap).Snapshot()); }
	
	/*
	 *	Returns the number of keys in the map snapshot.
	 */
	property int Length {
		public get() { return view_as<StringMapSnapshot>(this).Length; }
	}
	
	/*
	 *	Returns the buffer size required to store a given key. That is, it
	 *	returns the length of the key plus one.
	 *	
	 *	@param	index	Key index (starting from 0).
	 *
	 *	@return	Buffer size required to store the key string.
	 *
	 *	@error	Index out of range.
	 */
	public int KeyBufferSize(int index) { return view_as<StringMapSnapshot>(this).KeyBufferSize(index); }
	
	/*
	 *	Retrieves the key string of a given key in a map snapshot.
	 *	
	 *	@param	index		Key index (starting from 0).
	 *	@param	buffer		String buffer.
	 *	@param	maxlength	Maximum buffer length.
	 *
	 *	@return	Number of bytes written to the buffer.
	 *
	 *	@error	Index out of range.
	 */
	public int GetKey(int index, char[] buffer, int maxlength) { return view_as<StringMapSnapshot>(this).GetKey(index, buffer, maxlength); }
	
	/*
	 *	Retrieves the key string of a given key in a map snapshot.
	 *	
	 *	@param	index		Key index (starting from 0).
	 *
	 *	@return	Index value.
	 *
	 *	@error	Index out of range.
	 */
	public int GetIndex(int index) {
		char dummy[16], val[16];
		IntToString(index, dummy, sizeof(dummy));
		view_as<StringMapSnapshot>(this).GetKey(index, val, sizeof(val));
		return StringToInt(val);
	}
}

// Lil' alternative to Database handle.

/**
 * Callback for receiving asynchronous database connections.
 *
 *	@param	db		Handle to the database connection.
 *	@param	error	Error string if there was an error.  The error could be 
 *					empty even if an error condition exists, so it is important 
 *					to check the actual Handle value instead.
 *	@param	data	Data passed in via the original threaded invocation.
 */
typeset SQLConnectCallbackEx {
	function void (DatabaseEx db, const char[] error);
	function void (Database db, const char[] error);
	function void (DatabaseEx db, const char[] error, any data);
	function void (Database db, const char[] error, any data);
}

/**
 *	Callback for receiving asynchronous database query results.
 *
 *	@param	db			Cloned handle to the database connection.
 *	@param	results		Result object, or null on failure.
 *	@param	error		Error string if there was an error.  The error could be 
 *						empty even if an error condition exists, so it is important 
 *						to check the actual results value instead.
 * @param	data		Data passed in via the original threaded invocation.
 */
typeset SQLQueryCallbackEx {
	function void (DatabaseEx db, DBResultSet results, const char[] error);
	function void (Database db, DBResultSet results, const char[] error);
	function void (DatabaseEx db, DBResultSet results, const char[] error, any data);
	function void (Database db, DBResultSet results, const char[] error, any data);
}

methodmap DatabaseEx < Handle {
	/*
	 *	Connects to a database asynchronously, so the game thread is not blocked.
	 *
	 *	@param	callback	Callback. If no driver was found, the owner is null.
	 *	@param	name		Database configuration name.
	 *	@param	data		Extra data value to pass to the callback.
	 */
	public static void Connect(SQLConnectCallbackEx callback, const char[] name="default", any data=0) {
		Database.Connect(view_as<SQLConnectCallback>(callback), name, data);
	}
	
	public DatabaseEx ConnectEx(const char[] confname, bool persistent=true, char[] error, int maxlen) {
		return view_as<DatabaseEx>(SQL_Connect(confname, persistent, error, maxlen));
	}
	
	public DatabaseEx Connect2(const char[] confname, bool persistent=true, bool dbg=false) {
		return view_as<DatabaseEx>(SQL_Connect2(confname, persistent, dbg));
	}

	// Returns the driver for this database connection.
	property DBDriver Driver {
		public get() {
			return view_as<Database>(this).Driver;
		}
	}

	// Sets the character set of the connection. 
	// Like SET NAMES .. in mysql, but stays after connection problems.
	// 
	// Example: "utf8", "latin1"
	//
	// @param charset       The character set string to change to.
	// @return              True, if character set was changed, false otherwise.
	public bool SetCharset(const char[] charset="utf8mb4") {
		return view_as<Database>(this).SetCharset(charset);
	}

	// Escapes a database string for literal insertion.  This is not needed
	// for binding strings in prepared statements.  
	//
	// Generally, database strings are inserted into queries enclosed in 
	// single quotes (').  If user input has a single quote in it, the 
	// quote needs to be escaped.  This function ensures that any unsafe 
	// characters are safely escaped according to the database engine and 
	// the database's character set.
	//
	// NOTE: SourceMod only guarantees properly escaped strings when the query
	// encloses the string in single quotes. While drivers tend to allow double
	// quotes (") instead, the string may be not be escaped (for example, on SQLite)!
	//
	// @param string        String to quote.
	// @param buffer        Buffer to store quoted string in.
	// @param maxlen        Maximum length of the buffer.
	// @param written       Optionally returns the number of bytes written.
	// @return              True on success, false if buffer is not big enough.
	//                      The buffer must be at least 2*strlen(string)+1.
	public bool Escape(const char[] string, char[] buffer, int maxlen, int &written=0) {
		return view_as<Database>(this).Escape(string, buffer, maxlen, written);
	}

	// Formats a string according to the SourceMod format rules (see documentation).
	// All format specifiers are escaped (see SQL_EscapeString) unless the '!' flag is used.
	//
	// @param buffer        Destination string buffer.
	// @param maxlen        Maximum length of output string buffer.
	// @param format        Formatting rules.
	// @param ...           Variable number of format parameters.
	// @return              Number of cells written.
	public int Format(char[] buffer, int maxlen, const char[] format, any ...) {
		int len = (strlen(format)+1)*3;
		char[] fmt = new char[len];
		VFormat(fmt, len, format, 5);
		return view_as<Database>(this).Format(buffer, maxlen, fmt);
	}

	// Returns whether a database is the same connection as another database.
	public native bool IsSameConnection(Database other);

	// Executes a query via a thread. The result handle is passed through the
	// callback.
	//
	// The database handle returned through the callback is always a new Handle,
	// and if necessary, IsSameConnection() should be used to test against other
	// connections.
	//
	// The result handle returned through the callback is temporary and destroyed 
	// at the end of the callback.
	//
	// @param callback       Callback.
	// @param query          Query string.
	// @param data           Extra data value to pass to the callback.
	// @param prio           Priority queue to use.
	public void Query(SQLQueryCallbackEx callback, const char[] query, any data = 0, DBPriority prio = DBPrio_Normal) {
		view_as<Database>(this).Query(view_as<SQLQueryCallback>(callback), query, data, prio);
	}
	
	public void QueryEx(SQLQueryCallbackEx callback, const char[] query, any data = 0, DBPriority prio = DBPrio_Normal, any ...) {
		int maxlen = (strlen(query)+1)*3;
		char[] dummy = new char[maxlen];
		VFormat(dummy, maxlen, query, 6);
		view_as<Database>(this).Query(view_as<SQLQueryCallback>(callback), dummy, data, prio);
	}
	
	/**
	 *	Executes a simply query and returns a query Handle for
	 *	recieving the results.
	 *	This one is allows for additional parameters, making Format not required.
	 *
	 *	@param	query		The query string.
	 *
	 *	@return	A new Query Handle on success, else nulll.
	 *
	 *	@error	If the database is invalid, this returns null.
	 */
	public DBResultSet Query2(const char[] query, any ...) {
		if(view_as<Database>(this) != null) {
			int maxlen = (strlen(query)+1)*2;
			char[] format = new char[maxlen];
			VFormat(format, maxlen, query, 3);
			return SQL_Query(view_as<Database>(this), format);
		}
		
		return null;
	}

	// Sends a transaction to the database thread. The transaction handle is
	// automatically closed. When the transaction completes, the optional
	// callback is invoked.
	//
	// @param txn            A transaction handle.
	// @param onSuccess      An optional callback to receive a successful transaction.
	// @param onError        An optional callback to receive an error message.
	// @param data           An optional value to pass to callbacks.
	// @param prio           Priority queue to use.
	public void Execute(Transaction txn, 
						SQLTxnSuccess onSuccess = INVALID_FUNCTION, 
						SQLTxnFailure onError = INVALID_FUNCTION, 
						any data = 0, DBPriority prio = DBPrio_Normal) {
		view_as<Database>(this).Execute(txn, onSuccess, onError, data, prio);
	}
	                           
	// Returns if a named configuration is present in databases.cfg.
	//
	// @param name          Configuration name.
	// @return              True if it exists, false otherwise.
	//
	public static bool CheckConfig(const char[] name) {
		return SQL_CheckConfig(name);
	}
	
	// Locks a database so threading operations will not interrupt.
	//
	// If you are using a database Handle for both threading and non-threading,
	// this MUST be called before doing any set of non-threading DB operations.
	// Otherwise you risk corrupting the database driver's memory or network
	// connection.
	// 
	// Leaving a lock on a database and then executing a threaded query results
	// in a dead lock! Make sure to call Database.Unlock()!
	//
	// If the lock cannot be acquired, the main thread will pause until the 
	// threaded operation has concluded.
	//
	// @error               Invalid database Handle.
	//
	public void Lock() {
		SQL_LockDatabase(view_as<Database>(this));
	}
	
	// Unlocks a database so threading operations may continue.
	//
	// @error               Invalid database Handle.
	//
	public void Unlock() {
		SQL_UnlockDatabase(view_as<Database>(this));
	}
	
	public bool GetError(char[] error, int maxlen) {
		return SQL_GetError(view_as<Database>(this), error, maxlen);
	}
}

/**
 *	Creates a new console boolean variable.
 *
 *	@param	name			Name of new convar.
 *	@param	defaultValue	The default boolean value of new convar.
 *	@param	description		Optional description of the convar.
 *	@param	flags			Optional bitstring of flags determining how the convar should be handled. See FCVAR_* constants for more details.
 *	@param	hasMin			Optional boolean that determines if the convar has a minimum value.
 *	@param	min				Minimum floating point value that the convar can have if hasMin is true.
 *	@param	hasMax			Optional boolean that determines if the convar has a maximum value.
 *	@param	max				Maximum floating point value that the convar can have if hasMax is true.
 *
 *	@return					A handle to the newly created convar. If the convar already exists, a handle to it will still be returned.
 *
 *	@error               Convar name is blank or is the same as an existing console command.
 */
stock ConVar CreateConVarBool(const char[] name, bool defaultValue, const char[] description, int flags=0) { return CreateConVar(name, defaultValue ? "1":"0", description, flags, true, 0.0, true, 1.0); }

/**
 *	Adds ConVar flag(s).
 *
 *	@param	cvar	The ConVar to change.
 *	@param	flags	The flags to add.
 *
 *	@error	If the ConVar is invalid, this returns false.
 */
stock bool AddConVarFlags(ConVar cvar, int flags)	{
	if(cvar == null) return	false;
	
	cvar.Flags |= flags;
	return true;
}

/**
 *	Adds ConVar flag(s).
 *
 *	@param	cvar	The ConVar name to change.
 *	@param	flags	The flags to add.
 *
 *	@error	If the ConVar is invalid, this returns false.
 */
stock bool AddConVarFlagsEx(const char[] convar, int flags)	{
	ConVar cvar = FindConVar(convar);
	if(cvar == null) {
		delete cvar;
		return false;
	}
	
	cvar.Flags |= flags;
	delete cvar;
	return true;
}

/**
 *	Removes ConVar flag(s).
 *
 *	@param	cvar	The ConVar to change.
 *	@param	flags	The flags to remove.
 *
 *	@error	If the ConVar is invalid, this returns false.
 */
stock bool RemoveConVarFlags(ConVar cvar, int flags)	{
	if(cvar == null) return false;
	
	int flag = cvar.Flags;
	flag &= ~flags;
	cvar.Flags = flag;
	return true;
}

/**
 *	Removes ConVar flag(s).
 *
 *	@param	cvar	The ConVar name to change.
 *	@param	flags	The flags to remove.
 *
 *	@error	If the ConVar is invalid, this returns false.
 */
stock bool RemoveConVarFlagsEx(const char[] convar, int flags)	{
	ConVar cvar = FindConVar(convar);
	if(cvar == null) {
		delete cvar;
		return false;
	}
	
	int flag = cvar.Flags;
	flag &= ~flags;
	cvar.Flags = flag;
	delete cvar;
	return true;
}

/**
 *	Returns if the address handle is valid.
 *
 *	@param	address		The address handle.
 *
 *	@return	If handle is valid, this returns true. Returns false otherwise.
 */
stock bool IsValidAddress(Address address) { return view_as<bool>(address != Address_Null); }

/**
 *	Same as SQL_Connect but this is if you just want a temporary connection.
 *
 *	@param	confname	The name of the database config connection.
 *	@param	persistent	If true, it will try to use a previous persistent connection.
 *	@param	dbg			If true, it will show message if the connection returned 'null' (Error) or if it succeeded.
 *
 *	@return	Returns the SQL Connection. If invalid, returns null.
 */
stock Database SQL_Connect2(const char[] confname, bool persistent=true, bool dbg=false) {
	char error[256];
	Database database = SQL_Connect(confname, persistent, error, sizeof(error));
	if(dbg) {
		switch(!database) {
			case true: PrintToServer("[Tklib: SQL_Connect2] - Connection to database \"%s\" had an error (%s)", confname, error);
			case false: PrintToServer("[Tklib: SQL_Connect2] - Connection to database \"%s\" succeeded!", confname);
		}
	}
	
	return database;
}

/**
 *	Executes a simply query and returns a query Handle for
 *	recieving the results.
 *	This one is allows for additional parameters, making Format not required.
 *
 *	@param	database	The database handle.
 *	@param	query		The query string.
 *
 *	@return	A new Query Handle on success, else nulll.
 *
 *	@error	If database is invalid, this returns null.
 */
stock DBResultSet SQL_QueryEx(Handle database, const char[] query, any ...) {
	if(database != null) {
		int maxlen = (strlen(query)+1)*2;
		char[] format = new char[maxlen];
		VFormat(format, maxlen, query, 3);
		return SQL_Query(database, format);
	}
	
	return null;
}