/*****************************************\
 *			Tk Libraries (Tklib)		 *
 *										 *
 * 		Made by Tk /id/Teamkiller324	 *
\*****************************************/

#if defined _smlib_included
	#error SM Libraries may not be paired with Tk Libraries as they will clash on another
#endif

#if defined _tklib_included
	#error Tk Libraries is already included
	#endinput
#endif

#define _tklib_included
#define _tklib_author "Tk /id/Teamkiller324"
#define _tklib_author_url "https://steamcommunity.com/id/Teamkiller324"
#define SetPluginInfo(%1,%2,%3,%4,%5) public Plugin myinfo = {name = %1, author = %2, description = %3, version = %4, url = %5}

#if defined _tklib_no_includes
	#define _tklib_no_core_includes
	#define _tklib_no_game_includes
	#define _tklib_no_sdktools
	#define _tklib_no_sdkhooks
#endif

#if defined _tklib_no_core_includes
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_weapons
	#define _tklib_disable_clients
	#define _tklib_disable_entities
	#define _tklib_disable_additional
	#define _tklib_disable_events
	#define _tklib_disable_usermessages
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_weapons
	#define _tklib_disable_clients
	#define _tklib_disable_entities
	#define _tklib_disable_additional
	#define _tklib_disable_events
	#define _tklib_disable_usermessages
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_resize
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_weapons
	#define _tklib_disable_clients
	#define _tklib_disable_entities
	#define _tklib_disable_additional
	#define _tklib_disable_events
	#define _tklib_disable_usermessages
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_weapons
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_clients
	#define _tklib_disable_entities
	#define _tklib_disable_additional
	#define _tklib_disable_events
	#define _tklib_disable_usermessages
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_clients
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_weapons
	#define _tklib_disable_entities
	#define _tklib_disable_additional
	#define _tklib_disable_events
	#define _tklib_disable_usermessages
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_entities
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_weapons
	#define _tklib_disable_clients
	#define _tklib_disable_additional
	#define _tklib_disable_events
	#define _tklib_disable_usermessages
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_additional
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_weapons
	#define _tklib_disable_clients
	#define _tklib_disable_entities
	#define _tklib_disable_events
	#define _tklib_disable_usermessages
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_events
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_weapons
	#define _tklib_disable_clients
	#define _tklib_disable_entities
	#define _tklib_disable_additional
	#define _tklib_disable_usermessages
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_usermessages
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_weapons
	#define _tklib_disable_clients
	#define _tklib_disable_entities
	#define _tklib_disable_additional
	#define _tklib_disable_events
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_usermessages
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_weapons
	#define _tklib_disable_clients
	#define _tklib_disable_entities
	#define _tklib_disable_additional
	#define _tklib_disable_events
	#define _tklib_disable_strings
#endif

#if defined _tklib_only_strings
	#define _tklib_disable_gameidentifier
	#define _tklib_disable_resize
	#define _tklib_disable_weapons
	#define _tklib_disable_clients
	#define _tklib_disable_entities
	#define _tklib_disable_additional
	#define _tklib_disable_events
	#define _tklib_disable_usermessages
#endif

#if defined _tklib_no_game_includes
	#define _tklib_no_tf2
	#define _tklib_no_cstrike
	#define _tklib_no_csgo
	#define _tklib_disable_tf2
	#define _tklib_disable_cstrike
	#define _tklib_disable_l4d
	#define _tklib_disable_dods
	#define _tklib_disable_fortress_forever
	#define _tklib_disable_contagion
#endif

#if defined _tklib_only_tf2
	#define _tklib_no_cstrike
	#define _tklib_no_csgo
	#define _tklib_disable_cstrike
	#define _tklib_disable_l4d
	#define _tklib_disable_dods
	#define _tklib_disable_fortress_forever
	#define _tklib_disable_contagion
#endif

#if defined _tklib_only_cstrike
	#define _tklib_no_tf2
	#define _tklib_disable_tf2
	#define _tklib_disable_l4d
	#define _tklib_disable_dods
	#define _tklib_disable_fortress_forever
	#define _tklib_disable_contagion
#endif

#if defined _tklib_only_csgo
	#define _tklib_no_cstrike
	#define _tklib_no_tf2
	#define _tklib_disable_tf2
	#define _tklib_disable_l4d
	#define _tklib_disable_dods
	#define _tklib_disable_fortress_forever
	#define _tklib_disable_contagion
#endif

#if defined _tklib_only_l4d
	#define _tklib_no_tf2
	#define _tklib_no_cstrike
	#define _tklib_no_csgo
	#define _tklib_disable_tf2
	#define _tklib_disable_cstrike
	#define _tklib_disable_dods
	#define _tklib_disable_fortress_forever
	#define _tklib_disable_contagion
#endif

#if defined _tklib_only_dods
	#define _tklib_no_tf2
	#define _tklib_no_cstrike
	#define _tklib_no_csgo
	#define _tklib_disable_tf2
	#define _tklib_disable_cstrike
	#define _tklib_disable_l4d
	#define _tklib_disable_fortress_forever
	#define _tklib_disable_contagion
#endif

#if defined _tklib_only_fortress_forever
	#define _tklib_no_tf2
	#define _tklib_no_cstrike
	#define _tklib_no_csgo
	#define _tklib_disable_tf2
	#define _tklib_disable_cstrike
	#define _tklib_disable_l4d
	#define _tklib_disable_dods
	#define _tklib_disable_contagion
#endif

#if defined _tklib_only_contagion
	#define _tklib_no_tf2
	#define _tklib_no_cstrike
	#define _tklib_no_csgo
	#define _tklib_disable_tf2
	#define _tklib_disable_cstrike
	#define _tklib_disable_l4d
	#define _tklib_disable_dods
	#define _tklib_disable_fortress_forever
#endif


//SM Includes
#if !defined _tklib_no_sdktools
	#include <sdktools>
#endif

#if !defined _tklib_no_sdkhooks
	#include <sdkhooks>
#endif

#if !defined _tklib_no_cstrike
	#undef REQUIRE_EXTENSIONS
	#undef REQUIRE_PLUGIN
	#include <cstrike>
#endif

#if !defined _tklib_no_tf2
	#undef REQUIRE_EXTENSIONS
	#undef REQUIRE_PLUGIN
	#include <tf2_stocks>
#endif

#if defined _tklib_definitions
//Extra things that should be part of SourceMod, making it easier.
#define	int(%1) view_as<int>(%1)
#define	any(%1) view_as<any>(%1)
#define	float(%1) view_as<float>(%1) // doesn't break float(int value) function.
#define	bool(%1) view_as<bool>(%1) // %1 means it is the first parameter,
#define	char(%1) view_as<char>(%1) // %2 would be second, and so on (you get it).
#define	Handle(%1) view_as<Handle>(%1)
#define	Database(%1) view_as<Database>(%1)
#define	DBResult(%1) view_as<DBResult>(%1)
#define	DBResultSet(%1) view_as<DBResultSet(%1)
#define	APLRes(%1) view_as<APLRes>(%1)
#define	AdminFlag(%1) view_as<AdminFlag>(%1)
#define	PropFieldType(%1) view_as<PropFieldType>(%1)
#define	PropType(%1) view_as<PropType>(%1)
#define	Address(%1) view_as<Address>(%1)

#define This view_as<any>(this)
#define Bot(%1) IsFakeClient(%1)
#define boolean bool
#define integer int
const int Console = 0;
const int MaxPlayers = 33; // Clients will never reach above index 33, maximum players available is only to 32 or 33, each counting as entity index 1 to 32/33. Excluding zombie gamemode?
#endif

//Includes
#include <tklib/gameidentifier>
#include <tklib/clients>
#include <tklib/additional>
#include <tklib/contagion>
#include <tklib/csgo>
#include <tklib/cstrike>
#include <tklib/dods>
#include <tklib/entities>
#include <tklib/events>
#include <tklib/fortress_forever>
#include <tklib/l4d>
#include <tklib/resize>
#include <tklib/tf2>
#include <tklib/usermessages>
#include <tklib/strings>
#include <tklib/weapons>
#include <tklib/handles>