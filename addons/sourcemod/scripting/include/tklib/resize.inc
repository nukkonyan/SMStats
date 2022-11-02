//==========================================//
// Tklib / Resize.
//==========================================//
#if !defined _tklib_disable_resize

enum ResizeType {
	ResizeType_Head = 0,
	ResizeType_Torso = 1,
	ResizeType_Hand = 2,
	ResizeType_Model = 3,
	ResizeType_Steps = 4
}

/**
 *	Resize a users body part.
 *
 *	@param	client		The players client index.
 *	@param	type		ResizeType type.
 *	@param	value		The specified resize value.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool SetClientSize(int client, ResizeType type, float value) {
	bool rtrn = false;
	
	switch(type) {
		case ResizeType_Head: rtrn = SetClientHeadScale(client, value);
		case ResizeType_Torso: rtrn = SetClientTorsoScale(client, value);
		case ResizeType_Hand: rtrn = SetClientHandScale(client, value);
		case ResizeType_Model: rtrn = SetEntityModelScale(client, value);
		case ResizeType_Steps: rtrn = SetClientStepSize(client, value);
	}
	
	return rtrn;
}

/**
 *	Returns the size of a users body part.
 *
 *	@param	client	The users index.
 *	@param	type	ResizeType type.
 *
 *	@error	If the user is invalid, this returns -1.0.
 */
stock float GetClientSize(int client, ResizeType type) {
	float scale = -1.0;
	
	switch(type) {
		case ResizeType_Head: scale = GetClientHeadScale(client);
		case ResizeType_Torso: scale = GetClientTorsoScale(client);
		case ResizeType_Hand: scale = GetClientHandScale(client);
		case ResizeType_Model: scale = GetEntityModelScale(client);
		case ResizeType_Steps: scale = GetClientStepSize(client);
	}
	
	return scale;
}

/**
 *	Set the users head scale.
 *
 *	@param	client	The users index.
 *	@param	scale	Head scale.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool SetClientHeadScale(int client, float scale) { return SetEntPropFloatEx(client, Prop_Send, "m_flHeadScale", scale); }

/**
 *	Returns the users head scale.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this return -1.0.
 */
stock float GetClientHeadScale(int client) { return GetEntPropFloatEx(client, Prop_Send, "m_flHeadScale"); }

/**
 *	Set the users torso scale.
 *
 *	@param	client	The users index.
 *	@param	scale	Torso scale.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool SetClientTorsoScale(int client, float scale) { return SetEntPropFloatEx(client, Prop_Send, "m_flTorsoScale", scale); }

/**
 *	Returns the users torso scale.
 *
 *	@param	client	The users index.
 *
 *	@param	If the user is invalid, this returns 0.0.
 */
stock float GetClientTorsoScale(int client)	{ return GetEntPropFloatEx(client, Prop_Send, "m_flTorsoScale"); }

/**
 *	Set the users hand scale.
 *
 *	@param	client	The users index.
 *	@param	scale	Hand scale.
 *
 *	@error	If the client is invalid, this returns false.
 */
stock bool SetClientHandScale(int client, float scale) { return SetEntPropFloatEx(client, Prop_Send, "m_flHandScale", scale); }

/**
 *	Returns the users hand scale.
 *
 *	@param	client	The users index.
 *
 *	@error	If the client is invalid, this returns -1.0.
 */
stock float GetClientHandScale(int client) { return GetEntPropFloatEx(client, Prop_Send, "m_flHandScale"); }

/**
 *	Set the entitys model scale/size.
 *
 *	@param	entity	Entity index.
 *	@param	scale	The model scale.
 *
 *	@error	If the entity or user is invalid, this returns false.
 */
stock bool SetEntityModelScale(int entity, float scale)	{ return SetEntPropFloatEx(entity, Prop_Send, "m_flModelScale", scale); }

/**
 *	Returns the entitys model scale/size.
 *
 *	@param	entity	Entity index.
 *
 *	@error	If the entity or user is invalid, this returns -1.0.
 */
stock float GetEntityModelScale(int entity)	{ return GetEntPropFloatEx(entity, Prop_Send, "m_flModelScale"); }

/**
 *	Set the users step scale/size.
 *
 *	@param	client	The users index.
 *	@param	scale	The size/scale.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool SetClientStepSize(int client, float scale) { return SetEntPropFloatEx(client, Prop_Send, "m_flStepSize", scale); }

/**
 *	Returns the users step size.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this returns -1.0.
 */
stock float GetClientStepSize(int client) { return GetEntPropFloatEx(client, Prop_Send, "m_flStepSize"); }

#endif