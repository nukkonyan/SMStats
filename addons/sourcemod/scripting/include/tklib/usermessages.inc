//==========================================//
// Tklib / User Messages.
//==========================================//
#if !defined _tklib_disable_usermessages

/**
 *	Hooks a user message.
 *
 *	@param	msg_id		Message index.
 *	@param	hook		Function to use as a hook.
 *	@param	intercept	If intercept is true, message will be fully intercepted,
 *						allowing the user to block the message.  Otherwise,
 *						the hook is normal and ignores the return value.
 *	@param post			Notification function.
 *
 *	@error				If invalid usermessage id, this returns false.
 */
stock bool HookUserMessageEx(UserMsg msg_id,
							MsgHook hook,
							bool intercept=false,
							MsgPostHook post=INVALID_FUNCTION)	{
	char temp[8];
	if(GetUserMessageName(msg_id, temp, sizeof(temp)))	{
		HookUserMessage(msg_id, hook, intercept, post);
		return	true;
	}
	
	return	false;
}

#endif