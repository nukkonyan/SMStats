//==========================================//
// Tklib / Entities.
//==========================================//
#if !defined _tklib_disable_entities

enum Entity {
	Entity_Unsupported = -2,
	Entity_Invalid = -1,
	Entity_Empty = 0
}

#define Ent(%1) view_as<Entity>(%1)
#define EntityWhileLoop(%1,%2) while((%1 = Entity.FindByClassname(%1, %2)).Valid())

/**
 *	Returns the absolute origin of an entity.
 *
 *	@param	entity		The entity index.
 *	@param	vec			3 dimensional vector array.
 *
 *	@error	If entity is invalid, this returns false.
 */
stock bool GetEntityAbsOrigin(int entity, float vec[3])	{ return GetEntPropVectorEx(entity, Prop_Send, "m_vecOrigin", vec); }

/**
 *	Set the entity's absolute origin.
 *
 *	@param	entity		The entity index.
 *	@param	vec			3 dimensional vector array.
 *
 *	@error	If entity is invalid, this returns false.
 */
stock bool SetEntityAbsOrigin(int entity, const float vec[3]) { return SetEntPropVectorEx(entity, Prop_Send, "m_vecOrigin", vec); }

/**
 *	Returns the entity name
 *
 *	@param	entity	Entity index.
 *	@param	buffer	Buffer storage.
 *	@param	maxlen	Buffer max length.
 *
 *	@return	Number of non-null bytes written.
 */
stock int GetEntityName(int entity, char[] buffer, int maxlen) { return GetEntPropStringEx(entity, Prop_Data, "m_iName", buffer, maxlen); }

/**
 *	Sets the entity's name.
 *
 *	@param	entity	Entity index.
 *	@param	name	Entity name.
 *	@param	...		Additional name parameters.
 *
 *	@return	Number of non-null bytes written.
 */
stock int SetEntityName(int entity, const char[] name, any ...) {
	int maxlen = (strlen(name)+1)*3;
	char[] dummy = new char[maxlen];
	VFormat(dummy, maxlen, name, 3);
	return SetEntPropStringEx(entity, Prop_Data, "m_iName", dummy);
}

/**
 *	Retrieves the entity's global name.
 *
 *	@param	entity	The entity index.
 *	@param	name	The name to store.
 *	@param	maxlen	Maximum length of the name.
 *
 *	@return	Number of non-null bytes written.
 */
stock int GetEntityGlobalName(int entity, char[] name, int maxlen) { return GetEntPropStringEx(entity, Prop_Data, "m_iGlobalname", name, maxlen); }

/**
 *	Sets the entity's global name.
 *
 *	@param	entity	The entity index.
 *	@param	name	The name to set.
 *	@param	...		Additional name parameters.
 *
 *	@return	Number of non-null bytes written.
 */
stock int SetEntityGlobalName(int entity, const char[] name, any ...) {
	int maxlen = (strlen(name)+1)*3;
	char[] dummy = new char[maxlen];
	VFormat(dummy, maxlen, name, 3);
	return SetEntPropStringEx(entity, Prop_Data, "m_iGlobalname", dummy);
}

/**
 *	Find entity via classname if it exists.
 *
 *	@param	classname	Entity classname.
 *
 *	@error	If the entity is invalid, this will return false.
 */
stock bool FindEntity(const char[] classname) { return FindEntityByClassname(-1, classname) != INVALID_ENT_REFERENCE; }

/**
 *	Creates an entity by string name but does not spawn it (see DispatchSpawn).
 *	If ForceEdictIndex is not -1, then it will use an edict by that index. If the index is
 *	invalid or there is already an edict using that index, it will error out.
 *	this provides additional ability to force name on the entity you created.
 *
 *	@param	classname		Entity classname.
 *	@param	name			Entity name it will be referred as.
 *	@param	ForceEdictIndex	Edict index used by the created entity (Ignored on Orangebox and above).
 *
 *	@error	Invalid edict index, or no mod support.
 */
stock int CreateEntityByNameEx(const char[] classname, const char[] name="", int ForceEdictIndex=-1) {
	int entity = CreateEntityByName(classname, ForceEdictIndex);
	if(!StrEqual(name, "")) SetEntityName(entity, name);
	return entity;
}

/**
 *	Should entity start disabled?
 *
 *	@param	entity		Entity index.
 *	@param	disabled	If true, starts disabled, else enabled if false
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool SetEntityDisabled(int entity, bool disabled)	{ return IsValidEntityEx(entity) ? DispatchKeyValue(entity, "StartDisabled", disabled ? "true":"false"):false; }

/**
 *	Returns if the entity is disabled.
 *
 *	@param	entity		Entity index.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool GetEntityDisabled(int entity) { return GetEntPropBool(entity, Prop_Send, "m_bDisabled"); }

/**
 *	Sets the entity's model name path
 *
 *	@param	entity		Entity index.
 *	@param	model		Model path.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool SetEntityModelEx(int entity, const char[] model)	{ return (SetEntPropStringEx(entity, Prop_Data, "m_ModelName", model) > 0); }

/**
 *	Returns the entity's model name path
 *
 *	@param	entity		Entity index.
 *	@param	buffer		Buffer storage.
 *	@param	maxlen		Length of the buffer.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool GetEntityModel(int entity, char[] buffer, int maxlen) { return (GetEntPropStringEx(entity, Prop_Data, "m_ModelName", buffer, maxlen) > 0); }

/* Finally added to SDKTools - SM 1.12
**
 *	Set the entity owner.
 *
 *	@param	entity		The entity index.
 *	@param	client		The users index.
 *
 *	@error	If the index of the entity owner is invalid, it will return -1.
 *
stock bool SetEntityOwner(int entity, int client) { return SetEntPropEntEx(entity, Prop_Data, "m_hOwnerEntity", client); }
*/

/**
 *	Returns an index of the entity owner.
 *
 *	@param	entity		The entity index.
 *
 *	@error	If the index of the entity owner is invalid, it will return -1.
 */
stock int GetEntityOwner(int entity) { return GetEntPropEntEx(entity, Prop_Data, "m_hOwnerEntity"); }

/**
 *	Kills the entity and its "children".
 *	Same as AcceptEntityInput but with "KillHierarchy".
 *	this one makes sure if the entity is valid or not.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If entity is invalid, this returns false.
 */
stock bool KillEntity(int entity, int activator=-1, int caller=-1, int outputid=0) { return IsValidEntityEx(entity) ? AcceptEntityInput(entity, "KillHierarchy", activator, caller, outputid):false; }

/**
 *	Set the entitys skin.
 *
 *	@param	entity	Entity index.
 *	@param	skin	Skin index.
 *
 *	@error	If the entity is invalid, nothing will happen.
 */
stock bool SetEntitySkin(int entity, int skin) { return SetEntPropEx(entity, Prop_Send, "m_nSkin", skin); }

/**
 *	Returns the entity's skin
 *
 *	@param	entity	Entity index.
 *
 *	@error	If entity is invalid, this will return -1.
*/
stock int GetEntitySkin(int entity) { return GetEntPropEx(entity, Prop_Send, "m_nSkin"); }

/**
 *	Set the entitys body.
 *
 *	@param	entity	Entity index.
 *	@param	body	nBody index.
 *
 *	@error	If the entity is invalid, nothing will happen.
 */
stock bool SetEntityBody(int entity, int body) { return SetEntPropEx(entity, Prop_Send, "m_nBody", body); }

/**
 *	Returns the entitys skin
 *
 *	@param	entity	Entity index.
 *
 *	@error	If entity is invalid, this will return -1.
*/
stock int GetEntityBody(int entity) { return GetEntPropEx(entity, Prop_Send, "m_nBody"); }

/**
 *	Sets the classname of an entity.
 *
 *	@param	entity		Index of the entity.
 *	@param	clsname		Buffer to store the classname.
 *	@param	maxlength	Maximum length of the buffer.
 *
 *	@return				True on success, false if there is no classname set.
 *
 *	@error	If the entity has no valid classname, this returns false.
 */
stock bool SetEntityClassname(int entity, const char[] clsname)	{ return SetEntPropStringEx(entity, Prop_Data, "m_iClassname", clsname); }

/**
 *	Retrieves the classname of an entity.
 *	this is like GetEdictClassname(), except it works for ALL
 *	entities, not just edicts.
 *
 *	@param	entity		Index of the entity.
 *	@param	clsname		Buffer to store the classname.
 *	@param	maxlength	Maximum length of the buffer.
 *
 *	@return				True on success, false if there is no classname set or has no valid classname/invalid entity.
 */
stock bool GetEntityClassnameEx(int entity, char[] clsname, int maxlength) { return view_as<bool>(GetEntPropStringEx(entity, Prop_Data, "m_iClassname", clsname, maxlength) > 0); }

/**
 *	Returns the entity's parent attachment.
 *
 *	@param	entity	Entity index.
 *	@param	parent	Entity index to parent.
 *
 *	@error	If the entities is invalid, this returns false.
 */
stock bool SetEntityParentAttachment(int entity, any parent) { return SetEntPropEx(entity, Prop_Send, "m_iParentAttachment", parent); }

/**
 *	Returns the entity's parent attachment.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock any GetEntityParentAttachment(any entity)	{ return GetEntPropEx(entity, Prop_Send, "m_iParentAttachment"); }

/**
 *	Returns the entity's parent entity.
 *
 *	@param	entity	Entity index.
 *	@param	parent	Entity index to parent.
 *
 *	@error	If the entities is invalid, this returns false.
 */
stock bool SetEntityParentEntity(int entity, any parent) { return SetEntPropEntEx(entity, Prop_Data, "m_hParent", parent); }

/**
 *	Returns the entity's parent entity.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock any GetEntityParentEntity(int entity)	{ return GetEntPropEntEx(entity, Prop_Data, "m_hParent"); }

/**
 *	Set the entity moving parent entity.
 *
 *	@param	entity	Entity index.
 *	@param	parent	Entity parent index.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool SetEntityMoveParent(int entity, int parent) { return SetEntPropEntEx(entity, Prop_Data, "m_hMoveParent", parent); }

/**
 *	Returns the entity's moving parent entity.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock int GetEntityMoveParent(int entity) { return GetEntPropEntEx(entity, Prop_Data, "m_hMoveParent"); }

/**
 *	Set the entity to be initialized.
 *
 *	@param	entity			Entity index.
 *	@param	initialized		If true, the entity will be 'initialized'.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool SetEntityInitialized(int entity, bool initialized) { return SetEntDataOffset(entity, "m_bInitialized", initialized); }

/**
 *	Returns if the entity is initialized.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity is invalid, this will return false.
 */
stock bool IsEntityInitialized(int entity) { return GetEntDataOffset(entity, "m_bInitialized"); }

/**
 *	Set the entity's definition index value
 *
 *	@param	entity		Entity index.
 *	@param	defindex	Definition index value.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool SetEntityDefinitionIndex(int entity, int defindex) { return SetEntDataOffset(entity, "m_iItemDefinitionIndex", defindex); }

/**
 *	Returns the entity's definition index value
 *
 *	@param	entity		Entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock int GetEntityDefinitionIndex(int entity) { return GetEntDataOffset(entity, "m_iItemDefinitionIndex"); }

/**
 *	Returns if the entity classname is fully or partially matching.
 *
 *	@param	entity			Entity index.
 *	@param	classname		Classname to check.
 *	@param	partialMatch	If true, it will return true if match was partial.
 *
 *	@return	Returns if the match was found.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool IsEntityClassnameMatching(int entity, const char[] classname, bool partialMatch=false) {
	if(!IsValidEntityEx(entity)) return false;
	
	//Credits JonnyBoy0719 - Contagion include.
	char entity_clsname[64];
	GetEntityClassname(entity, entity_clsname, sizeof(clsname));

	if(partialMatch) return (StrContains(entity_clsname, classname) != -1);
	
	return StrEqual(entity_clsname, classname);
}

/**
 *	Returns the entity's team index.
 *	Can be paired with game's team enum such as TFTeam_Red or CSTeam_CT.
 *
 *	@param	entity	The entity index.
 *
 *	@return	The team index of the entity.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock any GetEntityTeamNum(int entity) { return GetEntDataOffset(entity, "m_iTeamNum"); }

/**
 *	Set the entity's team index.
 *	Can be paired with game's team enum such as TFTeam_Red or CSTeam_CT.
 *
 *	@param	entity	The entity index.
 *
 *	@return	The team index of the entity.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool SetEntityTeamNum(int entity, any team) { return SetEntDataOffset(entity, "m_iTeamNum", team); }

/**
 *	Set the entity effect.
 *
 *	@param	entity		The entity index.
 *	@param	effect		The effect value.
 *
 *	@error	If the index of the entity owner is invalid, it will return -1.
 */
stock bool SetEntityEffect(int entity, int value) { return SetEntPropEntEx(entity, Prop_Data, "m_hEffectEntity", value); }

/**
 *	Returns a value of the entity effect.
 *
 *	@param	entity		The entity index.
 *
 *	@error	If the index of the entity owner is invalid, it will return -1.
 */
stock int GetEntityEffect(int entity) { return GetEntPropEntEx(entity, Prop_Data, "m_hEffectEntity"); }

/**
 *	Returns the distance between 2 entities in meters.
 *	this is experimental and may be incorrect.
 *	In CS:GO, use "distance" from event "player_death" for more accurate numbers.
 *	this one is very similiar to that one but incorrect at times.
 *
 *	@param	entity		The entity index.
 *	@param	target		The target entity index.
 *
 *	@error	If the entity we use or the one we compare with is invalid, this returns -1.0.
 */
stock float GetEntityDistance(int entity, any target) {
	if(IsValidEntityEx(entity) && IsValidEntityEx(target)) {
		float pos[2][3];
		GetEntPropVectorEx(entity, Prop_Send, "m_vecOrigin", pos[0]);
		GetEntPropVectorEx(target, Prop_Send, "m_vecOrigin", pos[1]);
		
		//return ((pos[0][0] / pos[1][0]) * 5);
		return (GetVectorDistance(pos[1], pos[0]) / 41.0);
	}
	
	return -1.0;
}

/**
 *	Returns the entity's absolute velocity.
 *
 *	@param	entity		Entity index.
 *	@param	velocity	The velocity.
 *
 *	@error	If the entity is invalid or has no absolute velocity, this returns -1.0.
 */
stock bool GetEntityAbsVelocity(int entity, float velocity[3]) { return GetEntPropVectorEx(entity, Prop_Data, "m_vecAbsVelocity", velocity); }

/**
 *	Set the entity's absolute velocity.
 *
 *	@param	entity		Entity index.
*	@param	velocity	The velocity.
 *
 *	@error	If the entity is invalid or has no absolute velocity, this returns -1.0.
 */
stock bool SetEntityAbsVelocity(int entity, const float velocity[3]) { return SetEntPropVectorEx(entity, Prop_Data, "m_vecAbsVelocity", velocity); }

/**
 *	Returns the entity's base velocity.
 *
 *	@param	entity		Entity index.
 *	@param	velocity	The velocity.
 *
 *	@error	If the entity is invalid or has no base velocity, this returns -1.0.
 */
stock bool GetEntityBaseVelocity(int entity, float velocity[3])	{ return GetEntPropVectorEx(entity, Prop_Data, "m_vecBaseVelocity", velocity); }

/**
 *	Set the entity's base velocity.
 *
 *	@param	entity		Entity index.
*	@param	velocity	The velocity.
 *
 *	@error	If the entity is invalid or has no base velocity, this returns -1.0.
 */
stock bool SetEntityBaseOrigin(int entity, const float velocity[3])	{ return SetEntPropVectorEx(entity, Prop_Data, "m_vecBaseVelocity", velocity); }

/**
 *	Returns the entity's velocity.
 *
 *	@param	entity		Entity index.
 *	@param	velocity	The velocity.
 *
 *	@error	If the entity is invalid or has no velocity, this returns -1.0.
 */
stock bool GetEntityVelocity(int entity, float velocity[3])	{ return GetEntPropVectorEx(entity, Prop_Data, "m_vecVelocity", velocity); }

/**
 *	Set the entity's velocity.
 *
 *	@param	entity		Entity index.
 *	@param	velocity	The velocity.
 *
 *	@error	If the entity is invalid or has no velocity, this returns -1.0.
 */
stock bool SetEntityVelocity(int entity, const float velocity[3]) { return SetEntPropVectorEx(entity, Prop_Data, "m_vecVelocity", velocity); }

/**
 *	Set the entity spawn flags.
 *
 *	@param	entity		The entity index.
 *	@param	spawnflags	The spawn flags to set.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool SetEntitySpawnFlags(int entity, int spawnflags) { return SetEntPropEx(entity, Prop_Data, "m_spawnflags", spawnflags); }

/**
 *	Returns the entity spawn flags.
 *
 *	@param	entity	The entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock int GetEntitySpawnFlags(int entity) { return GetEntPropEx(entity, Prop_Send, "m_spawnflags"); }

/**
 *	Returns the Account ID of the entity index.
 *	Likely duplicate of GetSteamAccountId().
 *
 *	@param	entity	The entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock int GetEntitySteamAccountID(int entity) { return GetEntDataOffset(entity, "m_iAccountID"); }

/**
 *	Set the entity's Steam Account ID.
 *
 *	@param	entity		The entity index.
 *	@param	accountid	The Steam Account ID to set.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool SetEntitySteamAccountID(int entity, int accountid) { return SetEntDataOffset(entity, "m_iAccountID", accountid); }

/**
 *	Retrieves the entity's health.
 *
 *	@param	entity	The entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock int GetEntityHealth(int entity) { return GetEntDataOffset(entity, "m_iHealth"); }

//Methodmap
methodmap Entity __nullable__ {
	/**
	 *	Creates an entity by string name but does not spawn it (see DispatchSpawn).
	 *	If ForceEdictIndex is not -1, then it will use an edict by that index. If the index is
	 *	invalid or there is already an edict using that index, it will error out.
	 *	this provides additional ability to force name on the entity you created.
	 *
	 *	@param	classname		Entity classname.
	 *	@param	name			Entity name it will be referred as.
	 *	@param	ForceEdictIndex	Edict index used by the created entity (Ignored on Orangebox and above).
	 *
	 *	@error	Invalid edict index, or no mod support.
	 */
	public Entity(const char[] classname="", const char[] name="", int ForceEdictIndex=-1) { return view_as<Entity>(CreateEntityByNameEx(classname, name, ForceEdictIndex)); }
	
	/**
	 *	Gives an entity to a player.
	 *
	 *	@param	client		The users index.
	 *	@param	clasname	Item classname (such as weapon_ak47).
	 *	@param	iSubType	Unknown.
	 *
	 *	@error	If invalid client or client not in game, or lack of mod support, this returns Entity_Invalid or Entity_NotSupported.
	 */
	public any GiveItem(int client, const char[] classname, int iSubType=0) { return GivePlayerItem(client, classname, iSubType); }
	
	/**
	 *	Returns the absolute origin of an entity.
	 *
	 *	@param	vec		3 dimensional vector array.
	 *
	 *	@error	If entity is invalid, this returns false.
	 */
	public bool GetAbsOrigin(float vec[3]) { return GetEntityAbsOrigin(view_as<int>(this), vec); }
	
	/**
	 *	Retrieves the entity's name.
	 *
	 *	@param buffer	Buffer storage.
	 *	@param maxlen	Buffer max length.
	 *
	 *	@return	Number of non-null bytes written.
	 */
	public int GetName(char[] name, int maxlen) { return GetEntityName(view_as<int>(this), name, maxlen); }
	
	/**
	 *	Sets the entity's name
	 *
	 *	@param	name	Entity name.
	 *	@param	...		Additional name parameters.
	 *
	 *	@return	Number of non-null bytes written.
	 */
	public int SetName(const char[] name, any ...) {
		int maxlen = (strlen(name)+1)*3;
		char[] dummy = new char[maxlen];
		VFormat(dummy, maxlen, name, 2);
		return SetEntityName(view_as<int>(this), dummy);
	}
	
	/**
	 *	Retrieves the entity's global name.
	 *
	 *	@param	name	The name to store.
	 *	@param	maxlen	Maximum length of the name.
	 *
	 *	@return	Number of non-null bytes written.
	 */
	public int GetGlobalName(char[] name, int maxlen) { return GetEntityGlobalName(view_as<int>(this), name, maxlen); }
	
	/**
	 *	Sets the entity's global name.
	 *
	 *	@param	name	The name to set.
	 *	@param	...		Additional name parameters.
	 *
	 *	@return	Number of non-null bytes written.
	 */
	public int SetGlobalName(const char[] name, any ...) {
		int maxlen = (strlen(name)+1)*3;
		char[] dummy = new char[maxlen];
		VFormat(dummy, maxlen, name, 2);
		return SetEntityGlobalName(view_as<int>(this), dummy);
	}
	
	public static any FindByClassname(const char[] classname) { return FindEntityByClassname(0, classname); }
	
	/**
	 *	Find entity via classname if it exists.
	 *
	 *	@param	classname	Entity classname.
	 *
	 *	@error	If the entity is invalid, this will return false.
	 */
	public static bool Find(const char[] classname) { return FindEntity(classname); }
	
	/**
	 *	Entity's disabled status.
	 */
	property bool Disabled {
		public set(bool value) { SetEntityDisabled(view_as<int>(this), value); }
		public get() { return GetEntityDisabled(view_as<int>(this)); }
	}
	
	/**
	 *	Sets the entity's model name path
	 *
	 *	@param	model	Model path.
	 *
	 *	@error	If the entity is invalid, this returns false.
	 */
	public bool SetModel(const char[] model) { return SetEntityModelEx(view_as<int>(this), model); }
	
	/**
	 *	Returns the entity's model name path
	 *
	 *	@param	buffer	Buffer storage.
	 *	@param	maxlen	Length of the buffer.
	 *
	 *	@error	If the entity is invalid, this returns false.
	 */
	public bool GetModel(char[] buffer, int maxlen) { return GetEntityModel(view_as<int>(this), buffer, maxlen); }
	
	/**
	 *	The entity's owner entity index.
	 */
	property int Owner {
		public set(int client) { SetEntityOwner(view_as<int>(this), client); }
		public get() { return GetEntityOwner(view_as<int>(this)); }
	}
	
	/**
	 *	The entity health amount
	 */
	property int Health {
		public set(int value) { SetEntityHealth(view_as<int>(this), value); }
		public get() { return GetEntityHealth(view_as<int>(this)); }
	}
	
	/**
	 *	Returns if the entity or edict is valid.
	 *	Use this over IsValidEntity and IsValidEdict as this combines them.
	 *
	 *	@error	If the entity/edict is invalid, this returns false.
	 */
	public bool Valid() { return IsValidEntityEx(view_as<int>(this)); }
	
	/**
	 *	Kills the entity and its "children".
	 *	Same as AcceptEntityInput with "KillHierarchy".
	 *	this one makes sure if the entity is valid or not.
	 *
	 *	@error	If entity is invalid, this returns false.
	 */
	public bool Kill(int activator=-1, int caller=-1, int outputid=0) { return KillEntity(view_as<int>(this), activator, caller, outputid); }
	
	/**
	 *	Marks an entity for deletion.
	 *
	 *	@error		If invalid entity, this returns false.
	 */
	public bool Remove() {
		if(!IsValidEntityEx(view_as<int>(this))) return false;
		RemoveEntity(view_as<int>(this));
		return true;
	}
	
	/**
	 *	Marks an edict for deletion.
	 *
	 *	@error		If invalid dict, this returns false.
	 */
	public bool RemoveEx() {
		if(!IsValidEdict(view_as<int>(this))) return false;
		RemoveEdict(view_as<int>(this));
		return true;
	}
	
	/**
	 *	The entity's Skin index.
	 */
	property int Skin {
		public set(int skin) { SetEntitySkin(view_as<int>(this), skin); }
		public get() { return GetEntitySkin(view_as<int>(this)); }
	}
	
	/**
	 *	The entity's Body index.
	 */
	property int Body {
		public set(int body) { SetEntityBody(view_as<int>(this), body); }
		public get() { return GetEntityBody(view_as<int>(this)); }
	}
	
	/**
	 *	The entity's parent entity index.
	 */
	property any Parent {
		public set(any parent) { SetEntityParentEntity(view_as<int>(this), parent); }
		public get() { return GetEntityParentEntity(view_as<int>(this)); }
	}
	
	/**
	 *	The entity's initialized status.
	 */
	property bool Initialized {
		public set(bool initialized) { SetEntityInitialized(view_as<int>(this), initialized); }
		public get() { return IsEntityInitialized(view_as<int>(this)); }
	}
	
	/**
	 *	The entity's item definition index.
	 */
	property int DefinitionIndex {
		public set(int defindex) { SetEntityDefinitionIndex(view_as<int>(this), defindex); }
		public get() { return GetEntityDefinitionIndex(view_as<int>(this)); }
	}
	
	//Netprops
	
	/**
	 *	Returns if the entity is valid and has the network property.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property to check.
	 *
	 *	@error	If entity or property is invalid/not found, this returns false.
	 */
	public bool HasProp(PropType type, const char[] prop) { return HasEntPropEx(view_as<int>(this), type, prop); }
	
	/**
	 *	Sets an integer value in the entity's property.
	 *
	 *	This function is considered safer and more robust over SetEntData,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property name.
	 *	@param	value	Value to set.
	 *	@param	size	Number of bytes to write (valid values are 1, 2, or 4).
	 *					this value is auto-detected, and the size parameter is
	 *					only used as a fallback in case detection fails.
	 *
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds or property not found will return false.
	 */
	public bool SetProp(PropType type, const char[] prop, any value, int size=4, int element=0) { return SetEntPropEx(view_as<int>(this), type, prop, value, size, element); }
	
	/**
	 *	Retrieves an integer value from the entity's property.
	 *
	 *	This function is considered safer and more robust over GetEntData,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property name.
	 *	@param	size	Number of bytes to write (valid values are 1, 2, or 4).
	 *					this value is auto-detected, and the size parameter is
	 *					only used as a fallback in case detection fails.
	 *
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@return	Integer value at the given property offset.
	 *
	 *	@error	If the entity is invalid or property not found, this returns -1.
	 */
	public any GetProp(PropType type, const char[] prop, int size=4, int element=0) { return GetEntPropEx(view_as<int>(this), type, prop, size, element); }
	
	/**
	 *	Sets an entity index in the entity's property.
	 *
	 *	This function is considered safer and more robust over SetEntDataEnt*,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property name.
	 *	@param	other	Entity index to set, or -1 to unset.
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@error	If invalid entity or offset out of reasonable bounds or property not found, this will return false.
	 */
	public bool SetPropEnt(PropType type, const char[] prop, any other, int element=0) { return SetEntPropEntEx(view_as<int>(this), type, prop, other, element); }
	
	/**
	 *	Retrieves an integer value from the entity's property.
	 *
	 *	This function is considered safer and more robust over GetEntDataEnt*,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property name.
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@return	Entity index at the given offset.
	 *
	 *	@error	If entity is invalid or property not found, this returns -1.
	 */
	public any GetPropEnt(PropType type, const char[] prop, int element=0) { return GetEntPropEntEx(view_as<int>(this), type, prop, element); }
	
	/**
	 *	Retrieves the count of values that the entity property's array can store.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property name.
	 *
	 *	@return	Size of array (in elements) or 1 if property is not an array.
	 *
	 *	@error	If invalid entity or property not found, this returns -1.
	 */
	public int GetPropArraySize(PropType type, const char[] prop) { return GetEntPropArraySizeEx(view_as<int>(this), type, prop); }
	
	/**
	 *	Sets a boolean value from the entity's property.
	 *
	 *	This function is considered safer and more robust over GetEntData,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property name.
	 *	@param	value	The value to set.
	 *	@param	size	Number of bytes to write (valid values are 1, 2, or 4).
	 *					this value is auto-detected, and the size parameter is
	 *					only used as a fallback in case detection fails.
	 *
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@return	Boolean value at the given property offset.
	 *
	 *	@error	If entity is invalid or property not found, this returns false.
	 */
	public bool SetPropBool(PropType type, const char[] prop, bool value, int size=4, int element) { return SetEntPropEx(view_as<int>(this), type, prop, value, size, element); }
	
	/**
	 *	Retrieves a boolean value from the entity's property.
	 *
	 *	This function is considered safer and more robust over GetEntData,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property name.
	 *	@param	size	Number of bytes to write (valid values are 1, 2, or 4).
	 *					this value is auto-detected, and the size parameter is
	 *					only used as a fallback in case detection fails.
	 *
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@error	If entity, offset or property is not valid, this returns false. (if out of bounds, this becomes angry and spits out an error >:c).
	 */
	public bool GetPropBool(PropType type, const char[] prop, int size=4, int element=0) { return GetEntPropBool(view_as<int>(this), type, prop, size, element); }
	
	/**
	 *	Sets a float value in the entity's property.
	 *	This function is considered safer and more robust over SetEntDataFloat,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property name.
	 *	@param	value	The value to set.
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@error	If entity, offset or property is not valid, this returns false. (if out of bounds, this becomes angry and spits out an error >:c).
	 */
	public void SetPropFloat(PropType type, const char[] prop, float value, int element=0) { SetEntPropFloatEx(view_as<int>(this), type, prop, value, element); }
	
	/**
	 *	Retrieves a float value from the entity's property.
	 *	This function is considered safer and more robust over GetEntDataFloat,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property name.
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@return	Value at the given property offset.
	 *
	 *	@error	If entity is invalid, offset out of reasonable bounds or invalid property, this returns -1.0.
	 */
	public float GetPropFloat(PropType type, const char[] prop, int element=0) { return GetEntPropFloatEx(view_as<int>(this), type, prop, element); }
	
	/**
	 *	Sets a network property as a string.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property to use.
	 *	@param	buffer	String to set.
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@return	Returns number of non-null bytes written.
	 *
	 *	@error	If entity, offset out of reasonable bounds, or property is not a valid string, this returns 0.
	 */
	public int SetPropString(PropType type, const char[] prop, const char[] buffer, int element=0) { return SetEntPropStringEx(view_as<int>(this), type, prop, buffer, element); }
	
	/**
	 *	Retrieves a network property as a string.
	 *
	 *	@param	type	Property type.
	 *	@param	prop	Property to use.
	 *	@param	buffer	Destination string buffer.
	 *	@param	maxlen	Maximum length of output string buffer.
	 *	@param	element	Element # (starting from 0) if property is an array.
	 *
	 *	@return	Returns number of non-null bytes written.
	 *
	 *	@error	If entity, offset out of reasonable bounds, or property is not a valid string, this returns 0.
	 */
	public int GetPropString(PropType type, const char[] prop, char[] buffer, int maxlen, int element=0) { return GetEntPropStringEx(view_as<int>(this), type, prop, buffer, maxlen, element); }
	
	/**
	 *	Sets a vector of floats in the entity, given a named network property.
	 *
	 *	This function is considered safer and more robust over SetEntDataVector,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type		Property type.
	 *	@param	prop		Property name.
	 *	@param	vec			Vector to set.
	 *	@param	element		Element # (starting from 0) if property is an array.
	 *
	 *	@error	If entity is invalid, property not found, or property not
	 *			actually a vector data type, this returns false.
	 */
	public bool SetPropVector(PropType type, const char[] prop, const float vec[3], int element) { return SetEntPropVectorEx(view_as<int>(this), type, prop, vec, element); }
	
	/**
	 *	Retrieves a vector of floats from the entity, given a named network property.
	 *
	 *	This function is considered safer and more robust over GetEntDataVector,
	 *	because it performs strict offset checking and typing rules.
	 *
	 *	@param	type		Property type.
	 *	@param	prop		Property name.
	 *	@param	vec			Vector buffer to store data in.
	 *	@param	element		Element # (starting from 0) if property is an array.
	 *
	 *	@error	If entity is invalid, property not found, or property not
	 *			actually a vector data type, this returns false.
	 */
	public bool GetPropVector(PropType type, const char[] prop, float vec[3], int element=0) { return GetEntPropVectorEx(view_as<int>(this), type, prop, vec, element); }
	
	/**
	 *	Peeks into an entity's object data and sets the integer value at the given offset.
	 *
	 *	@param	offset		Offset to use.
	 *	@param	value		Value to set.
	 *	@param	size		Number of bytes to write (valid values are 1, 2, or 4).
	 *	@param	changeState	If true, change will be sent over the network.
	 *
	 *	@noreturn
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public void SetData(int offset, any value, int size=4, bool changeState=false) { SetEntData(view_as<int>(this), offset, value, size, changeState); }
	
	/**
	 *	Peeks into the entity's object data and retrieves the integer value at the given offset.
	 *
	 *	@param	offset	Offset to use.
	 *	@param	size	Number of bytes to read (valid values are 1, 2, or 4).
	 *
	 *	@return	Value at the given memory location.
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public any GetData(int offset, int size=4) { return GetEntData(view_as<int>(this), offset, size); }
	
	/**
	 *	Peeks into this entity's object data and sets the integer value at
	 *	the given prop.
	 *	This is alternative to SetEntData, considered 'safer',
	 *	gets the offset manually of the prop.
	 *	
	 *	@param	prop		Property to get offset out of to use.
	 *	@param	value		Value to set.
	 *	@param	size		Number of bytes to write (valid values are 1, 2, or 4).
	 *	@param	changeState	If true, change will be sent over the network.
	 *	
	 *	@error	If offset is out of reasonable bounds or invalid entity, this returns false.
	 */
	public bool SetDataOffset(const char[] prop, any value, int size=4, bool changeState=false) { return SetEntDataOffset(view_as<int>(this), prop, value, size, changeState); }
	
	/**
	 *	Peeks into this entity's object data and retrieves the integer value at
	 *	the given offset.
	 *	This is alternative to GetEntData, considered 'safer',
	 *	gets the offset manually of the prop.
	 *	
	 *	@param	prop	Property to get offset out of to use.
	 *	@param	size	Number of bytes to read (valid values are 1, 2, or 4).
	 *
	 *	@return	Value at the given memory location.
	 *
	 *	@error	If offset is out of reasonable bounds or invalid entity, this returns -1.
	 */
	public any GetDataOffset(const char[] prop, int size=4) { return GetEntDataOffset(view_as<int>(this), prop, size); }
	
	/**
	 *	Peeks into this entity's object data and sets the integer value at
	 *	the given prop.
	 *	This is alternative to SetEntData, considered 'safer',
	 *	gets via offset found from netclass.
	 *
	 *	@param	entity		The entity index
	 *	@param	netclass	The entity netclass.
	 *	@param	prop		Property to get offset out of to use.
	 *	@param	value		Value to set.
	 *	@param	size		Number of bytes to write (valid values are 1, 2, or 4).
	 *	@param	changeState	If true, change will be sent over the network.
	 *	
	 *	@error	If offset is out of reasonable bounds or invalid entity, this returns false.
	 */
	public bool SetDataNetClass(const char[] netclass, char[] prop, any value, int size=4, bool changeState=false) { return SetEntDataNetClass(view_as<int>(this), netclass, prop, value, size, changeState); }
	
	/**
	 *	Peeks into this entity's object data and retrieves the integer value at
	 *	the given offset.
	 *	This is alternative to GetEntData, considered 'safer',
	 *	gets via offset found from netclass.
	 *
	 *	@param	entity		The entity index
	 *	@param	netclass	The entity netclass.
	 *	@param	prop		Property to get offset out of to use.
	 *	@param	size		Number of bytes to read (valid values are 1, 2, or 4).
	 *
	 *	@return	Value at the given memory location.
	 *
	 *	@error	If offset is out of reasonable bounds or invalid entity, this returns -1.
	 */
	public any GetDataNetClass(const char[] netclass, const char[] prop, int size=4) { return GetEntDataNetClass(view_as<int>(this), netclass, prop, size); }
	
	/**
	 *	Peeks into an entity's object data and sets the entity index at the given offset.
	 *
	 *	Note: This will only work on offsets that are stored as "entity
	 *	handles" (which usually looks like m_h* in properties).  These
	 *	are not SourceMod Handles, but internal Source structures.
	 *
	 *	@param	offset		Offset to use.
	 *	@param	other		Entity index to set, or -1 to clear.
	 *	@param	changeState	If true, change will be sent over the network.
	 *
	 *	@noreturn
	 *
	 *	@error	Invalid input entity, or offset out of reasonable bounds.
	 */
	public void SetDataEnt2(int offset, int other, bool changeState=false) { SetEntDataEnt2(view_as<int>(this), offset, other, changeState); }
	
	/**
	 *	Peeks into the entity's object data and retrieves the entity index at the given offset.
	 *
	 *	Note: This will only work on offsets that are stored as "entity
	 *	handles" (which usually looks like m_h* in properties).  These
	 *	are not SourceMod Handles, but internal Source structures.
	 *
	 *	@param	offset	Offset to use.
	 *
	 *	@return	Entity index at the given location.  If there is no entity,
	 *			or the stored entity is invalid, then -1 is returned.
	 *
	 *	@error	Invalid input entity, or offset out of reasonable bounds.
	 */
	public any GetDataEnt2(int offset) { return GetEntDataEnt2(view_as<int>(this), offset); }
	
	/**
	 *	Peeks into the entity's object data and sets the float value at the given offset.
	 *
	 *	@param	offset		Offset to use.
	 *	@param	value		Value to set.
	 *	@param	changeState	If true, change will be sent over the network.
	 *
	 *	@noreturn
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public void SetDataFloat(int offset, float value, bool changeState=false) { SetEntDataFloat(view_as<int>(this), offset, value, changeState); }
	
	/**
	 *	Peeks into the entity's object data and retrieves the float value at the given offset.
	 *
	 *	@param	offset	Offset to use.
	 *
	 *	@return	Value at the given memory location.
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public float GetDataFloat(int offset) { return GetEntDataFloat(view_as<int>(this), offset); }
	
	/**
	 *	Peeks into the entity's object data and sets the string at the given offset.
	 *
	 *	@param	offset		Offset to use.
	 *	@param	buffer		String to set.
	 *	@param	maxlen		Maximum length of bytes to write.
	 *	@param	changeState	If true, change will be sent over the network.
	 *
	 *	@return	Number of non-null bytes written.
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public int SetDataString(int offset, const char[] buffer, int maxlen, bool changeState=false) { return SetEntDataString(view_as<int>(this), offset, buffer, maxlen, changeState); }
	
	/**
	 *	Peeks into the entity's object data and retrieves the string at the given offset.
	 *
	 *	@param	offset	Offset to use.
	 *	@param	buffer	Destination string buffer.
	 *	@param	maxlen	Maximum length of output string buffer.
	 *
	 *	@return	Number of non-null bytes written.
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public int GetDataString(int offset, char[] buffer, int maxlen) { return GetEntDataString(view_as<int>(this), offset, buffer, maxlen); }

	/**
	 *	Peeks into the entity's object data and sets the vector at the given offset.
	 *	@note Both a Vector and a QAngle are three floats.  This is a convenience function and will work with both types.
	 *
	 *	@param	offset		Offset to use.
	 *	@param	vec			Vector to set.
	 *	@param	changeState	If true, change will be sent over the network.
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public void SetDataVector(int offset, const float vec[3], bool changeState=false) { SetEntDataVector(view_as<int>(this), offset, vec, changeState); }
	
	/**
	 *	Peeks into the entity's object data and retrieves the vector at the given offset.
	 *	@note Both a Vector and a QAngle are three floats.  This is a convenience function and will work with both types.
	 *
	 *	@param	offset	Offset to use.
	 *	@param	vec		Vector buffer to store data in.
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public void GetDataVector(int offset, float vec[3]) { GetEntDataVector(view_as<int>(this), offset, vec); }
	
	/**
	 *	Copies an array of cells to the entity at a given offset.
	 *
	 *	@param	offset		Offset to use.
	 *	@param	array		Array of values to copy.
	 *	@param	arraySize	Number of values to copy.
	 *	@param	dataSize	Size of each value in bytes (1, 2, or 4).
	 *	@param	changeState	True to set the network state as changed; false otherwise.
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public void SetDataArray(int offset, const int[] array, int arraySize, int dataSize=4, bool changeState=false) { SetEntDataArray(view_as<int>(this), offset, array, arraySize, dataSize, changeState); }
	
	/**
	 *	Copies an array of cells from the entity at a given offset.
	 *
	 *	@param	offset		Offset to use.
	 *	@param	array		Array to read into.
	 *	@param	arraySize	Number of values to read.
	 *	@param	dataSize	Size of each value in bytes (1, 2, or 4).
	 *
	 *	@error	Invalid entity or offset out of reasonable bounds.
	 */
	public void GetDataArray(int offset, int[] array, int arraySize, int dataSize=4) { GetEntDataArray(view_as<int>(this), offset, array, arraySize, dataSize); }
	
	/**
	 *	Wrapper function for finding a send property for a particular entity.
	 *
	 *	@param	prop		Property name.
	 *	@param	actual		Defaults to false for backwards compatibility.
	 *						If true, the newer FindSendPropInfo() function
	 *						is used instead.
	 *
	 *	@return	An offset, or -1 on failure.
	 */
	public int GetSendPropOffs(const char[] prop, bool actual=false) { return GetEntSendPropOffs(view_as<int>(this), prop, actual); }
	
	//Other
	
	/**
	 *	Returns the entity's absolute velocity.
	 *
	 *	@param	velocity	The velocity.
	 *
	 *	@error	If the entity is invalid or has no absolute velocity, this returns -1.0.
	 */
	public bool GetAbsVelocity(float velocity[3]) { return GetEntityVelocity(view_as<int>(this), velocity); }
	
	/**
	 *	Set the entity's absolute velocity.
	 *
	 *	@param	velocity	The velocity.
	 *
	 *	@error	If the entity is invalid or has no absolute velocity, this returns -1.0.
	 */
	public bool SetAbsVelocity(const float velocity[3]) { return SetEntityAbsVelocity(view_as<int>(this), velocity); }
	
	/**
	 *	Returns the entity's base velocity.
	 *
	 *	@param	velocity	The velocity.
	 *
	 *	@error	If the entity is invalid or has no base velocity, this returns -1.0.
	 */
	public bool GetBaseVelocity(float velocity[3]) { return GetEntityBaseVelocity(view_as<int>(this), velocity); }
	
	/**
	 *	Set the entity's base velocity.
	 *
	*	@param	velocity	The velocity.
	 *
	 *	@error	If the entity is invalid or has no base velocity, this returns -1.0.
	 */
	public bool SetBaseOrigin(const float velocity[3]) { return SetEntityBaseOrigin(view_as<int>(this), velocity); }
	
	/**
	 *	Returns the entity's velocity.
	 *
	 *	@param	velocity	The velocity.
	 *
	 *	@error	If the entity is invalid or has no velocity, this returns -1.0.
	 */
	public bool GetVelocity(float velocity[3]) { return GetEntityVelocity(view_as<int>(this), velocity); }
	
	/**
	 *	Set the entity's velocity.
	 *
	 *	@param	velocity	The velocity.
	 *
	 *	@error	If the entity is invalid or has no velocity, this returns -1.0.
	 */
	public bool SetVelocity(const float velocity[3]) { return SetEntityVelocity(view_as<int>(this), velocity); }
	
	/**
	 *	Entity's flags.
	 */
	property int Flags {
		public set(int flags) { SetEntityFlags(view_as<int>(this), flags); }
		public get() { return GetEntityFlags(view_as<int>(this)); }
	}
	
	/**
	 *	Entity's edict flags.
	 *	Set/GetEdictFlags probably same as Set/GetEntityFlags?.
	 */
	property int FlagsEdict {
		public set(int flags) { SetEdictFlags(view_as<int>(this), flags); }
		public get() { return GetEdictFlags(view_as<int>(this)); }
	}
	
	/*
	 *	Entity's steam account id.
	 */
	property int SteamAccountID {
		public set(int id) { SetEntitySteamAccountID(view_as<int>(this), id); }
		public get() { return GetEntitySteamAccountID(view_as<int>(this)); }
	}
	
	/**
	 *	Entity's gravity.
	 */
	property float Gravity {
		public set(float amount) { SetEntityGravity(view_as<int>(this), amount); }
		public get() { return GetEntityGravity(view_as<int>(this)); }
	}
	
	/**
	 *	Entity's movetype.
	 */
	property MoveType moveType {
		public set(MoveType mt) { SetEntityMoveType(view_as<int>(this), mt); }
		public get() { return GetEntityMoveType(view_as<int>(this)); }
	}
	
	/**
	 *	Sets the entity's color.
	 *
	 *	@param	r	Amount of red (0-255)
	 *	@param	g	Amount of green (0-255)
	 *	@param	b	Amount of blue (0-255)
	 *	@param	a	Amount of alpha (0-255)
	 *
	 *	@error	Invalid entity index, or lack of mod compliance.
	 */
	public void SetRenderColor(int r=255, int g=255, int b=255, int a=255) { SetEntityRenderColor(view_as<int>(this), r, g, b, a); }
	
	/**
	 *	Get the entity's color.
	 *
	 *	@param	r	Amount of red (0-255)
	 *	@param	g	Amount of green (0-255)
	 *	@param	b	Amount of blue (0-255)
	 *	@param	a	Amount of alpha (0-255)
	 *
	 *	@error	Invalid entity index, or lack of mod compliance.
	 */
	public void GetRenderColor(int& r, int& g, int& b, int& a) { GetEntityRenderColor(view_as<int>(this), r, g, b, a); }
	
	property RenderFx RenderFX {
		public set(RenderFx fx ) { SetEntityRenderFx(view_as<int>(this), fx); }
		public get() { return GetEntityRenderFx(view_as<int>(this)); }
	}
	
	/**
	 *	Retrieve or set render mode.
	 *
	 *	@error	Invalid entity index, or lack of mod compliance.
	 */
	property RenderMode Rendermode {
		public set(RenderMode mode) { SetEntityRenderMode(view_as<int>(this), mode); }
		public get() { return GetEntityRenderMode(view_as<int>(this)); }
	}
	
	#if defined _sdktools_included
	/**
	 *	Invokes a named input method this entity.
	 *
	 *	After completion (successful or not), the current global variant is re-initialized.
	 *
	 *	@param	input		Input action.
	 *	@param	activator	Entity index which initiated the sequence of actions (-1 for a NULL entity).
	 *	@param	caller		Entity index from which this event is sent (-1 for a NULL entity).
	 *	@param	outputid	Unknown.
	 *
	 *	@return	True if successful otherwise false.
	 *
	 *	@error	Invalid entity index or no mod support.
	 */
	public bool AcceptInput(const char[] input, any activator=-1, any caller=-1, int outputid=0) { return AcceptEntityInput(view_as<int>(this), input, activator, caller, outputid); }
	
	/**
	 *	Sets an entity in the global variant object.
	 *
	 *	@error	Invalid entity index.
	 */
	public void SetVariant() { SetVariantEntity(view_as<int>(this)); }
	
	/**
	 *	Fire a named output this entity.
	 *	After completion (successful or not), the current global variant is re-initialized.
	 *
	 *	@param	output		Output name.
	 *	@param	activator	Entity index which initiated the sequence of actions (-1 for a NULL entity).
	 *	@param	delay		Delay before firing the output.
	 *
	 *	@error	Invalid entity index or no mod support.
	 */
	public void FireOutput(const char[] output, int activator=-1, float delay=0.0) { FireEntityOutput(view_as<int>(this), output, activator, delay); }
	
	/**
	 *	Activates the entity (CBaseAnimating:Activate)
	 */
	public void Activate() { ActivateEntity(view_as<int>(this)); }
	
	/**
	 *	Extinguishes the entity that's on fire.
	 */
	public void Extinguish() { ExtinguishEntity(view_as<int>(this)); }
	#endif
	
	//Put 'any' to support team enums.
	property any Team {
		public set(any value) { SetEntityTeamNum(view_as<int>(this), value); }
		public get() { return GetEntityTeamNum(view_as<int>(this)); }
	}
	
	public bool IsClassnameMatching(const char[] classname, bool partialMatch=false) { return IsEntityClassnameMatching(view_as<int>(this), classname, partialMatch); }
	
	#if defined _sdktools_included
	public void Ignite(float time, bool npc=false, float size=0.0, bool level=false) { IgniteEntity(view_as<int>(this), time, npc, size, level); }
	
	/**
	 *	Teleports the entity to a destination.
	 *
	 *	@param	origin		The entity origin.
	 *	@param	angles		The entity angles.
	 *	@param	velocity	The entity velocity.
	 */
	public bool Teleport(const float origin[3]=NULL_VECTOR, const float angles[3]=NULL_VECTOR, const float velocity[3]=NULL_VECTOR) { if(!IsValidEntityEx(view_as<int>(this))) return false; TeleportEntity(view_as<int>(this), origin, angles, velocity); return true; }
	
	
	/**
	 *	Dispatches a KeyValue into the entity using string value.
	 *
	 *	@param	keyName		The name of the key.
	 *	@param	value		The string value.
	 */
	public void Kv(const char[] keyName, const char[] value) { DispatchKeyValue(view_as<int>(this), keyName, value); }
	
	/**
	 *	Dispatches a KeyValue into the entity using integer value.
	 *
	 *	@param	keyName		The name of the key.
	 *	@param	value		The integer value.
	 */
	public void KvNum(const char[] keyName, int value) { char val[8]; IntToString(value, val, sizeof(val)); DispatchKeyValue(view_as<int>(this), keyName, val); }
	
	/**
	 *	Dispatches a KeyValue into the entity using boolean value.
	 *
	 *	@param	keyName		The name of the key.
	 *	@param	value		The boolean value.
	 */
	public void KvBool(const char[] keyName, bool value) { char val[8]; IntToString(view_as<bool>(value), val, sizeof(val)); DispatchKeyValue(view_as<int>(this), keyName, val); }
	
	/**
	 *	Dispatches a KeyValue into the entity using a floating point value.
	 *
	 *	@param	keyName		The name of the key.
	 *	@param	value		The float value.
	 */
	public void KvFloat(const char[] keyName, float value) { DispatchKeyValueFloat(view_as<int>(this), keyName, value); }
	
	/**
	 *	Dispatches a KeyValue into the entity using a vector value.
	 *
	 *	@param	keyName		The name of the key.
	 *	@param	value		The vector value.
	 */
	public void KvVec(const char[] keyName, const float vec[3]) { DispatchKeyValueVector(view_as<int>(this), keyName, vec); }
	
	/**
	 *	Spawns the entity.
	 *
	 *	@param	keyName		The name of the key.
	 *	@param	value		The string value.
	 */
	public bool Spawn() { return DispatchSpawn(view_as<int>(this)); }
	#endif
	
	/**
	 *	Returns wheter the entity has any networkable edict.
	 *
	 *	@param	keyName		The name of the key.
	 *	@param	value		The string value.
	 */
	public bool IsNetworkable() { return IsEntNetworkable(view_as<int>(this)); }
	
	/**
	 *	Sets the classname of the entity.
	 *
	 *	@param	clsname		The classname to set.
	 */
	public bool SetClassname(char[] clsname) { return SetEntityClassname(view_as<int>(this), clsname); }
	
	/**
	 *	Returns the classname of the entity.
	 *
	 *	@param	clsname		The buffer to store the classname.
	 *	@param	maxlen		The maximum length of the buffer.
	 */
	public bool GetClassname(char[] clsname, int maxlen) { return GetEntityClassnameEx(view_as<int>(this), clsname, maxlen); }
	
	/**
	 *	Retrieves this entity's networkable serverclass name.
	 *	This is not the same as the classname and is used for networkable state changes.
	 *
	 *	@param	clsname		Buffer to store the serverclass name.
	 *	@param	maxlength	Maximum length of the buffer.
	 *	
	 *	@return	True on success, false if the edict is not networkable.
	 *	
	 *	@error	Invalid entity.
	 */
	public bool GetNetClass(char[] clsname, int maxlen) { return GetEntityNetClass(view_as<int>(this), clsname, maxlen); }
	
	/*
	 *	Returns this entity's memory address.
	 */
	public Address GetAddress() { return GetEntityAddress(view_as<int>(this)); }
	
	/**
	 *	Marks this entity as state changed.  This can be useful if you set an offset
	 *	and wish for it to be immediately changed over the network.  By default this
	 *	is not done for offset setting functions.
	 *
	 *	@param	offset	Offset to mark as changed.  If 0,
	 *					The entire edict is marked as changed.
	 *
	 * @error	Invalid entity or offset out of bounds.
	 */
	public void ChangeState(int offset=0) { ChangeEdictState(view_as<int>(this), offset); }
	
	/**
	 *	Entity moving parent entity.
	 */
	property int MoveParent {
		public set(int parent) { SetEntityMoveParent(view_as<int>(this), parent); 	}
		public get() { return GetEntityMoveParent(view_as<int>(this)); }
	}
	
	/*
	 *	Entity effect value.
	 */
	property int Effect {
		public set(int value) { SetEntityEffect(view_as<int>(this), value); }
		public get() { return GetEntityEffect(view_as<int>(this)); }
	}
	
	#if defined _sdktools_included
	/**
	 *	Equip's the weapon CBaseWeapon entity.
	 *
	 *	@param	client	The users index.
	 *
	 *	@error	Invalid client or entity, lack of mod support, or client not in game.
	 */
	public bool EquipWeapon(int client) {
		if(!IsValidEntityEx(view_as<int>(this))) return false;
		EquipPlayerWeapon(client, view_as<int>(this));
		return true;
	}
	#endif
	
	#if defined _tklib_disable_weapons
	/**
	 *	Equips the weapon entity.
	 *	This is an alternative to EquipPlayerWeapon (.EquipWeapon), this method fixes 0 clip magazine and glitchy reload animations because
	 *	it was being spawned onto the user too early when using CreateEntityByName.
	 *
	 *	@param	client		The users index.
	 *
	 *	@error	If the user is invalid or weapon is invalid, this returns false.
	 */
	public bool EquipWeaponEx(int client) { return EquipPlayerWeaponEx(client, view_as<int>(this)); }
	#else
	
	/**
	 *	Returns the entity distance.
	 *
	 *	@param	target	The entity target.
	 *
	 *	@error	If neither entities are invalid, this returns -1.0.
	 */
	public float GetDistance(any target) { return GetEntityDistance(view_as<int>(this), target); }
	
	#if defined _tf2_included
	/**
	 *	Equips the user the cosmetic entity.
	 *
	 *	@param	client	The users index.
	 *
	 *	@error	If the user or offset is invalid, this returns -1.
	 *
	 *	@return	Returns the offset.
	 */
	public int TF2EquipCosmetic(int client) { return TF2_EquipPlayerCosmetic(client, view_as<int>(this)); }
	
	/**
	 *	The entity's quality. [TF2]
	 *
	 *	@param	quality	The quality.
	 */
	property any TF2Quality {
		public set(any quality) { TF2_SetEntityQuality(view_as<int>(this), quality); }
		public get() { return TF2_GetEntityQuality(view_as<int>(this)); }
	}
	
	/**
	 *	The entity's level. [TF2]
	 *
	 *	@param	level	The level.
	 */
	property int TF2Level {
		public set(int level) { TF2_SetEntityLevel(view_as<int>(this), level); }
		public get() { return TF2_GetEntityLevel(view_as<int>(this)); }
	}
	
	/**
	 *	The entity's validity.
	 *	
	 *	@param	valid	If true, this item is visible for everybody.
	 */
	 property bool TF2Validated {
	 	public set(bool valid) { TF2_SetValidatedAttachedEntity(view_as<int>(this), valid); }
	 	public get() { TF2_IsValidatedAttachedEntity(view_as<int>(this)); }
	 }
	
	/**
	 *	Creates a cosmetic entity.
	 *
	 *	@param	name				The entity name.
	 *	@param	ForceEdictIndex		Edict index used by the created entity (Ignored on Orangebox and above).
	 *
	 *	@return	Returns the entity index of the cosmetic entity.
	 */
	public Entity TF2_Cosmetic(const char[] name, int ForceEdictIndex=-1) { return view_as<Entity>(TF2_CreateCosmetic(name, ForceEdictIndex)); }
	
	/**
	 *	Creates a demoshield weapon entity.
	 *
	 *	@param	name				The entity name.
	 *	@param	ForceEdictIndex		Edict index used by the created entity (Ignored on Orangebox and above).
	 *
	 *	@return	Returns the entity index of the cosmetic demoshield entity.
	 */
	public Entity TF2_CosmeticDemoShield(const char[] name, int ForceEdictIndex=-1) { return view_as<Entity>(TF2_CreateCosmeticDemoShield(name, ForceEdictIndex)); }
	
	/**
	 *	Creates a razorback weapon entity.
	 *	Used for the 'Razorback' weapon.
	 *
	 *	@param	name				The entity name.
	 *	@param	ForceEdictIndex		Edict index used by the created entity (Ignored on Orangebox and above).
	 *
	 *	@return	Returns the entity index of the cosmetic razorback entity.
	 */
	public Entity TF2_CosmeticRazorback(const char[] name, int ForceEdictIndex=-1) { return view_as<Entity>(TF2_CreateCosmeticRazorback(name, ForceEdictIndex)); }
	
	/**
	 *	Creates a videomaker entity.
	 *	Used for taunts.
	 *
	 *	@param	name				The entity name.
	 *	@param	ForceEdictIndex		Edict index used by the created entity (Ignored on Orangebox and above).
	 *
	 *	@return	Returns the entity index of the cosmetic videomaker entity.
	 */
	public Entity TF2_CosmeticVideoMaker(const char[] name, int ForceEdictIndex=-1) { return view_as<Entity>(TF2_CreateCosmeticVideoMaker(name, ForceEdictIndex)); }
	
	/**
	 *	Creates a robot arm viewmodel.
	 *	Used for the 'Gunslinger' weapon.
	 *
	 *	@param	name				The entity name.
	 *	@param	ForceEdictIndex		Edict index used by the created entity (Ignored on Orangebox and above).
	 *
	 *	@return	Returns the entity index of the robot arm viewmodel entity.
	 */
	public Entity TF2_CosmeticRobotArm(const char[] name, int ForceEdictIndex=-1) { return view_as<Entity>(TF2_CreateCosmeticRobotArm(name, ForceEdictIndex)); }
	
	/**
	 *	Creates a levelable cosmetic item.
	 *	Used for cosmetics updating its model based on its owner's current killstreak.
	 *
	 *	@param	name				The entity name.
	 *	@param	ForceEdictIndex		Edict index used by the created entity (Ignored on Orangebox and above).
	 *
	 *	@return	Returns the entity index of the levelable cosmetic entity.
	 */
	public Entity TF2_CosmeticLevelable(const char[] name, int ForceEdictIndex=-1) { return view_as<Entity>(TF2_CreateCosmeticLevelable(name, ForceEdictIndex)); }
	
	/**
	 *	Creates a cosmetic campaign item.
	 *
	 *	@param	name				The entity name.
	 *	@param	ForceEdictIndex		Edict index used by the created entity (Ignored on Orangebox and above).
	 *
	 *	@return	Returns the entity index of the cosmetic campaign item entity.
	 */
	public Entity TF2_CosmeticCampaignItem(const char[] name, int ForceEdictIndex=-1) { return view_as<Entity>(TF2_CreateCosmeticCampaignItem(name, ForceEdictIndex)); }
	
	/**
	 *	Creates a viewmodel entity.
	 *	Used for showing your arms.
	 *
	 *	@param	name				The entity name.
	 *	@param	ForceEdictIndex		Edict index used by the created entity (Ignored on Orangebox and above).
	 *
	 *	@return	Returns the entity index of the cosmetic viewmodel entity.
	 */
	public Entity TF2_Viewmodel(const char[] name, int ForceEdictIndex=-1) { return view_as<Entity>(TF2_CreateViewmodel(name, ForceEdictIndex)); }
	#endif
	
	#if !defined _tklib_no_csgo
	/**
	 *	Fixes the StatTrak and Skins function not working.
	 *
	 *	@return	Returns false on failure, true otherwise.
	 */
	public bool CSGOFixId() { return CSGO_FixId(view_as<int>(this)); }
	
	/**
	 *	Sets or retrieves the skin.
	 *
	 *	@param	index	The skin index.
	 *
	 *	@return	If the entity is invalid, nothing will happen.
	 */
	property int CSGOSkin {
		public set(int index) { CSGO_SetSkin(view_as<int>(this), index); }
		public get() { return CSGO_GetSkin(view_as<int>(this)); }
	}
	
	/**
	 *	Sets or retrieves the pattern/seed.
	 *
	 *	@param	pattern	The pattern to set.
	 *
	 *	@error	If the entity is invalid or procedure failed, this returns -1.
	 */
	property int CSGOPattern {
		public set(int pattern) { CSGO_SetPattern(view_as<int>(this), pattern); }
		public get() { return CSGO_GetPattern(view_as<int>(this)); }
	}
	
	/**
	 *	Set the StatTrak.
	 *
	 *	@param	value	The 'kill' track amount. If -1, stattrak will be disabled.
	 *
	 *	@return	Returns false on failure, true otherwise.
	 *
	 *	@error	If the entity is invalid or procedure failed, returns -1.
	 */
	property int CSGOStatTrak {
		public set(int value) { CSGO_SetStatTrak(view_as<int>(this), value); }
		public get() { return CSGO_GetStatTrak(view_as<int>(this)); }
	}
	
	/**
	 *	Set the weapon quality.
	 *
	 *	@param	entity	Entity index.
	 *	@param	index	Quality index value. By default set to 3, adding a star to the weapon name.
	 *
	 *	@error	If the entity is invalid or procedure failed, this returns -1.
	 */
	property int CSGOQuality {
		public set(int quality) { CSGO_SetQuality(view_as<int>(this), quality); }
		public get() { return CSGO_GetQuality(view_as<int>(this)); }
	}
	
	/**
	 *	Sets or retrieves the wear.
	 *
	 *	@param	wear	The wear float value.
	 *
	 *	@error	If the entity is invalid or procedure failed, this returns -1.0.
	 */
	property float CSGOWear {
		public set(float wear) { CSGO_SetWear(view_as<int>(this), wear); }
		public get() { return CSGO_GetWear(view_as<int>(this)); }
	}
	
	/**
	 *	Set the weapon owner.
	 *
	 *	@param	client	Users index.
	 *
	 *	@noreturn.
	 */
	public void CSGOSetOwner(int client) {
		this.SetProp(Prop_Send, "m_iAccountID", GetSteamAccountID(client));
		this.SetPropEnt(Prop_Send, "m_hOwnerEntity", client);
		this.SetPropEnt(Prop_Send, "m_hPrevOwner", -1);
	}
	
	/**
	 *	Set the name tag
	 *
	 *	@param	nametag	A name tag or string of characters you specify.
	 *	@param	maxlen	Max character length for the string buffer.
	 *
	 *	@return	Returns false on failure, true otherwise.
	 */
	public bool CSGOSetNameTag(const char[] nametag) { return CSGO_SetNameTag(view_as<int>(this), nametag); }
	
	/**
	 *	Retrieves the nametag
	 *
	 *	@param	name	The source to store at.
	 *	@param	maxlen	Length of the buffer.
	 *
	 *	@return	Returns false on failure, true otherwise.
	 */
	public bool CSGOGetNameTag(char[] name, int maxlen) { return CSGO_GetNameTag(view_as<int>(this), name, maxlen); }
	#endif
}

#endif

/* These are important */

/**
 *	Returns if the entity or edict is valid.
 *	Use this over IsValidEntity and IsValidEdict as this combines them.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity/edict is invalid, this returns false.
 */
stock bool IsValidEntityEx(int entity) { return view_as<bool>(IsValidEdict(entity) || IsValidEntity(entity)); }

//Netprops

/**
 *	Sets an integer value in an entity's property.
 *
 *	This function is considered safer and more robust over SetEntData,
 *	because it performs strict offset checking and typing rules.
 *
 *	@param	entity	Entity/edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *	@param	value	Value to set.
 *	@param	size	Number of bytes to write (valid values are 1, 2, or 4).
 *					this value is auto-detected, and the size parameter is
 *					only used as a fallback in case detection fails.
 *
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@error	Invalid entity or offset out of reasonable bounds or property not found will return false.
 */
stock bool SetEntPropEx(int entity, PropType type, const char[] prop, any value, int size=4, int element=0) { if(!HasEntProp(entity, type, prop)) return false; SetEntProp(entity, type, prop, value, size, element); return true; }

/**
 *	Sets an entity index in an entity's property.
 *
 *	This function is considered safer and more robust over SetEntDataEnt*,
 *	because it performs strict offset checking and typing rules.
 *
 *	@param	entity	Entity/edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *	@param	other	Entity index to set, or -1 to unset.
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@error	Invalid entity or offset out of reasonable bounds or property not found will return false.
 */
stock bool SetEntPropEntEx(int entity, PropType type, const char[] prop, any other, int element=0) { if(!HasEntProp(entity, type, prop)) return false; SetEntPropEnt(entity, type, prop, other, element); return true; }

/**
 *	Retrieves an integer value from an entity's property.
 *	Considered safer over GetEntProp.
 *
 *	This function is considered safer and more robust over GetEntData,
 *	because it performs strict offset checking and typing rules.
 *
 *	@param	entity	Entity/edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *	@param	size	Number of bytes to write (valid values are 1, 2, or 4).
 *					this value is auto-detected, and the size parameter is
 *					only used as a fallback in case detection fails.
 *
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@return	Integer value at the given property offset.
 *
 *	@error	If entity is invalid or property not found, this returns -1.
 */
stock any GetEntPropEx(int entity, PropType type, const char[] prop, int size=4, int element=0) { return !HasEntPropEx(entity, type, prop) ? -1 : GetEntProp(entity, type, prop, size, element); }

/**
 *	Retrieves an integer value from an entity's property.
 *
 *	This function is considered safer and more robust over GetEntDataEnt*,
 *	because it performs strict offset checking and typing rules.
 *
 *	@param	entity	Entity/edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@return	Entity index at the given offset.
 *
 *	@error	If entity is invalid or property not found, this returns -1.
 */
stock int GetEntPropEntEx(int entity, PropType type, const char[] prop, int element=0) { return !HasEntPropEx(entity, type, prop) ? -1 : GetEntPropEnt(entity, type, prop, element); }

/**
 *	Retrieves a boolean value from an entity's property.
 *	Considered safer over GetEntProp.
 *
 *	This function is considered safer and more robust over GetEntData,
 *	because it performs strict offset checking and typing rules.
 *
 *	@param	entity	Entity/edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *	@param	size	Number of bytes to write (valid values are 1, 2, or 4).
 *					this value is auto-detected, and the size parameter is
 *					only used as a fallback in case detection fails.
 *
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@return	Bool value at the given property offset.
 *
 *	@error	If entity is invalid or property not found, this returns false.
 */
stock bool GetEntPropBool(int entity, PropType type, const char[] prop, int size=4, int element=0) { return !HasEntPropEx(entity, type, prop) ? false : view_as<bool>(GetEntProp(entity, type, prop, size, element)); }

/**
 *	Gets a network property as a string.
 *
 *	@param	entity	Entity/Edict index.
 *	@param	type	Property type.
 *	@param	prop	Property to use.
 *	@param	buffer	Destination string buffer.
 *	@param	maxlen	Maximum length of output string buffer.
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@return	Returns number of non-null bytes written.
 *
 *	@error	If entity, offset out of reasonable bounds, or property is not a valid string, this returns 0.
 */
stock int GetEntPropStringEx(int entity, PropType type, const char[] prop, char[] buffer, int maxlen, int element=0) { return !HasEntPropEx(entity, type, prop) ? 0 : GetEntPropString(entity, type, prop, buffer, maxlen, element); }

/**
 *	Sets a network property as a string.
 *
 *	@param	entity	Entity/Edict index.
 *	@param	type	Property type.
 *	@param	prop	Property to use.
 *	@param	buffer	String to set.
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@return	Returns number of non-null bytes written.
 *
 *	@error	If entity, offset out of reasonable bounds, or property is not a valid string, this returns 0.
 */
stock int SetEntPropStringEx(int entity, PropType type, const char[] prop, const char[] buffer, int element=0) { return !HasEntPropEx(entity, type, prop) ? 0 : SetEntPropString(entity, type, prop, buffer, element); }

/**
 *	Returns if the entity is valid and has the network property.
 *
 *	@param	entity	Entity/Edict index.
 *	@param	type	Property type.
 *	@param	prop	Property to check.
 *
 *	@error	If entity or property is invalid/not found, this returns false.
 */
stock bool HasEntPropEx(int entity, PropType type, const char[] prop) { return !IsValidEntityEx(entity) ? false : HasEntProp(entity, type, prop); }

/**
 *	Sets a float value in an entity's property.
 *	This function is considered safer and more robust over SetEntDataFloat,
 *	because it performs strict offset checking and typing rules.
 *
 *	@param	entity	Entity/Edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *	@param	value	Value to set.
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@error	If entity, offset or property is not valid, this returns false. (if out of bounds, view_as<int>(this) spits out an error).
 */
stock bool SetEntPropFloatEx(int entity, PropType type, const char[] prop, float value, int element=0) { if(!HasEntPropEx(entity, type, prop)) return false; SetEntPropFloat(entity, type, prop, value, element); return true; }

/**
 *	Retrieves a float value from an entity's property.
 *
 *	This function is considered safer and more robust over GetEntDataFloat,
 *	because it performs strict offset checking and typing rules.
 *
 *	@param	entity	Entity/edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@return	Value at the given property offset.
 *
 *	@error	If entity is invalid, offset out of reasonable bounds or invalid property, this returns -1.0.
 */
stock float GetEntPropFloatEx(int entity, PropType type, const char[] prop, int element=0) { return HasEntPropEx(entity, type, prop) ? GetEntPropFloat(entity, type, prop, element):-1.0; }

/**
 *	Retrieves a vector of floats from an entity, given a named network property.
 *
 *	This function is considered safer and more robust over GetEntDataVector,
 *	because it performs strict offset checking and typing rules.
 *
 *	@param	entity	Entity/edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *	@param	vec		Vector buffer to store data in.
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@error	If entity is invalid, property not found, or property not
 *			actually a vector data type, this returns false.
 */
stock bool GetEntPropVectorEx(int entity, PropType type, const char[] prop, float vec[3], int element=0) { if(!HasEntPropEx(entity, type, prop)) return false; GetEntPropVector(entity, type, prop, vec, element); return true; }

/**
 *	Sets a vector of floats in an entity, given a named network property.
 *
 *	This function is considered safer and more robust over SetEntDataVector,
 *	because it performs strict offset checking and typing rules.
 *
 *	@param	entity	Entity/edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *	@param	vec		Vector to set.
 *	@param	element	Element # (starting from 0) if property is an array.
 *
 *	@error	If entity is invalid, property not found, or property not
 *			actually a vector data type, this returns false.
 */
stock bool SetEntPropVectorEx(int entity, PropType type, const char[] prop, const float vec[3], int element=0) { if(!HasEntPropEx(entity, type, prop)) return false; SetEntPropVector(entity, type, prop, vec, element); return true; }

/**
 *	Retrieves the count of values that an entity property's array can store.
 *
 *	@param	entity	Entity/edict index.
 *	@param	type	Property type.
 *	@param	prop	Property name.
 *
 *	@return	Size of array (in elements) or 1 if property is not an array.
 *
 *	@error	If invalid entity or property not found, this returns -1.
 */
stock int GetEntPropArraySizeEx(int entity, PropType type, const char[] prop) { return !HasEntPropEx(entity, type, prop) ? -1 : GetEntPropArraySize(entity, type, prop); }

/**
 *	Peeks into an entity's object data and sets the integer value at
 *	the given prop.
 *	This is alternative to SetEntData, considered 'safer',
 *	gets the offset manually of the prop.
 *	
 *	@param	entity		Edict index.
 *	@param	prop		Property to get offset out of to use.
 *	@param	value		Value to set.
 *	@param	size		Number of bytes to write (valid values are 1, 2, or 4).
 *	@param	changeState	If true, change will be sent over the network.
 *	
 *	@error	If invalid entity, offset out of reasonable bounds or invalid, this returns false.
 */
stock bool SetEntDataOffset(int entity, const char[] prop, any value, int size=4, bool changeState=false) {
	if(!IsValidEntityEx(entity)) return false;
	char netclass[96];
	GetEntityNetClass(entity, netclass, sizeof(netclass));
	int offset = FindSendPropInfo(netclass, prop);
	if(offset < 1) return false;
	SetEntData(entity, offset, value, size, changeState);
	return true;
}

/**
 *	Peeks into an entity's object data and retrieves the integer value at
 *	the given offset.
 *	This is alternative to GetEntData, considered 'safer',
 *	gets the offset manually of the prop.
 *	
 *	@param	entity	Edict index.
 *	@param	prop	Property to get offset out of to use.
 *	@param	size	Number of bytes to read (valid values are 1, 2, or 4).
 *
 *	@return	Value at the given memory location.
 *
 *	@error	If invalid entity, offset out of reasonable bounds or invalid, this returns -1.
 */
stock any GetEntDataOffset(int entity, const char[] prop, int size=4) {
	if(!IsValidEntityEx(entity)) return -1;
	char netclass[96];
	GetEntityNetClass(entity, netclass, sizeof(netclass));
	int offset = FindSendPropInfo(netclass, prop);
	if(offset < 1) return -1;
	return GetEntData(entity, offset, size);
}

/**
 *	Peeks into an entity's object data and sets the integer value at
 *	the given prop.
 *	This is alternative to SetEntData, considered 'safer',
 *	Sets via offset found from netclass.
 *
 *	@param	entity		The entity index.
 *	@param	netclass	The entity netclass.
 *	@param	prop		Property to get offset out of to use.
 *	@param	value		Value to set.
 *	@param	size		Number of bytes to write (valid values are 1, 2, or 4).
 *	@param	changeState	If true, change will be sent over the network.
 *	
 *	@error	If invalid entity, offset out of reasonable bounds or invalid, this returns false.
 */
stock bool SetEntDataNetClass(int entity, const char[] netclass, const char[] prop, any value, int size=4, bool changeState=false) {
	int offset = FindSendPropInfo(netclass, prop);
	if(offset < 1) return false;
	SetEntData(entity, offset, value, size, changeState);
	return true;
}

/**
 *	Peeks into an entity's object data and retrieves the integer value at
 *	the given offset.
 *	This is alternative to GetEntData, considered 'safer',
 *	Sets via offset found from netclass.
 *
 *	@param	entity		The entity index.
 *	@param	netclass	The entity netclass.
 *	@param	prop		Property to get offset out of to use.
 *	@param	size		Number of bytes to read (valid values are 1, 2, or 4).
 *
 *	@return	Value at the given memory location.
 *
 *	@error	If invalid entity, offset out of reasonable bounds or invalid, this returns -1.
 */
stock any GetEntDataNetClass(int entity, const char[] netclass, const char[] prop, int size=4) {
	int offset = FindSendPropInfo(netclass, prop);
	if(offset < 1) return -1;
	return GetEntData(entity, offset, size);
}