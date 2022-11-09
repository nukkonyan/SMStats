//==========================================//
// Tk Libraries / Team Fortress 2.
//==========================================//
#if !defined _tklib_no_tf2

//May seem useless, but for just incase.
const TFTeam TFTeam_Invalid = view_as<TFTeam>(-1);
const TFTeam TFTeam_Green = view_as<TFTeam>(4);
const TFTeam TFTeam_Yellow = view_as<TFTeam>(5);
const TFClassType TFClass_Invalid = view_as<TFClassType>(-1);
const TFClassType TFClass_Demoman = view_as<TFClassType>(4);
const TFClassType TFClass_Civilian = view_as<TFClassType>(10);

#if !defined _tf2_included && defined _tklib_only_tf2
const TFClassType TFClass_Unknown = view_as<TFClassType>(0);
const TFClassType TFClass_Scout = view_as<TFClassType>(1);
const TFClassType TFClass_Sniper = view_as<TFClassType>(2);
const TFClassType TFClass_Soldier = view_as<TFClassType>(3);
const TFClassType TFClass_DemoMan = view_as<TFClassType>(4);
const TFClassType TFClass_Medic = view_as<TFClassType>(5);
const TFClassType TFClass_Heavy = view_as<TFClassType>(6);
const TFClassType TFClass_Pyro = view_as<TFClassType>(7);
const TFClassType TFClass_Spy = view_as<TFClassType>(8);
const TFClassType TFClass_Engineer = view_as<TFClassType>(9);
const TFTeam TFTeam_Unassigned = view_as<TFTeam>(0);
const TFTeam TFTeam_Spectator = view_as<TFTeam>(1);
const TFTeam TFTeam_Red = view_as<TFTeam>(2);
const TFTeam TFTeam_Blue = view_as<TFTeam>3);
#endif

const int MAX_TF2_CLASSES = 9;
const int MAX_TF2C_CLASSES = 10;
const int MAX_TF2_PLAYERS = 34; // TF2 Clients will never reach above index 33, maximum players available is only to 32 or 33, each counting as entity index 1 to 32/33. Excluding zombie gamemode?

const TFClassType TFClass_All = TFClass_Scout|TFClass_Soldier|TFClass_Pyro|TFClass_DemoMan|TFClass_Heavy|TFClass_Engineer|TFClass_Medic|TFClass_Sniper|TFClass_Spy|TFClass_Civilian;

//Get the team name via strings for colored chat purpose (Usage example: TF2_GetTeamStringNameEx[GetClientTeam(client)] will return the correct team name)
stock char
TF2_TeamName[][] = {"Unassigned","Spectators","RED","BLU","GRN","YLW"},
TF2_TeamNameEx[][] = {"{grey}Unassigned{default}","{grey}Spectators{default}","{red}RED{default}","{blue}BLU{default}","{lightgreen}GRN{default}","{orange}YLW{default}"},
TF2_TeamColour[][] = {"{grey}","{grey}","{red}","{blue}","{lightgreen}","{orange}"},
TF2_FlagTypeName[][] = {"None","Picked up","Captured","Defended","Dropped","Carrier"},
TF2_GameTypeName[][] = {"Unknown","Capture-The-Flag","Capture Points","Payload / Payload Race","Arena","Unknown","Unknown","Passball"},
TF2_CritTypeName[][] = {"None","Mini-Crit","Crit"},
TF2_ClassTypeName[][] = {"Unknown","Scout","Sniper","Soldier","Demoman","Medic","Heavy","Pyro","Spy","Engineer","Civilian"},
TF2_ClassTypeNameLC[][] = {"unknown","scout","sniper","soldier","demoman","medic","heavy","pyro","spy","engineer","civilian"},
TF2_BuildingTypeName[][] = {"Sentrygun","Dispenser","Teleporter Entrance","Teleporter Exit","Mini-Sentry","Sapper"},
TF2_RobotPlayerModel[][] = {"","models/bots/scout/bot_scout.mdl","models/bots/sniper/bot_sniper.mdl","models/bots/soldier/bot_soldier.mdl","models/bots/demoman/bot_demoman.mdl","models/bots/medic/bot_medic.mdl","models/bots/heavy/bot_heavy.mdl","models/bots/pyro/bot_pyro.mdl","models/bots/spy/bot_spy.mdl","models/bots/engineer/bot_engineer.mdl"},
TF2_PlayerZombieModel[][] = {"","models/player/items/scout/scout_zombie.mdl","models/player/items/sniper/sniper_zombie.mdl","models/player/items/soldier/soldier_zombie.mdl","models/player/items/demo/demo_zombie.mdl","models/player/items/medic/medic_zombie.mdl","models/player/items/heavy/heavy_zombie.mdl","models/player/items/pyro/pyro_zombie.mdl","models/player/items/spy/spy_zombie.mdl","models/player/items/engineer/engineer_zombie.mdl"},
TF2_DefaultPlayerModel[][] = {"","models/player/scout.mdl","models/player/sniper.mdl","models/player/soldier.mdl","models/player/demoman.mdl","models/player/medic.mdl","models/player/heavy.mdl","models/player/pyro.mdl","models/player/spy.mdl","models/player/engineer.mdl"},
TF2_StockWeaponTypeClassnamePrimary[][] = {"","tf_weapon_scattergun","tf_weapon_sniperrifle","tf_weapon_rocketlauncher","tf_weapon_grenadelauncher","tf_weapon_syringegun_medic","tf_weapon_minigun","tf_weapon_flamethrower","tf_weapon_revolver","tf_weapon_shotgun_primary"},
TF2_StockWeaponTypeClassnameSecondary[][] = {"","tf_weapon_pistol_scout","tf_weapon_smg","tf_weapon_shotgun_soldier","tf_weapon_pipebomblauncher","tf_weapon_medigun","tf_weapon_shotgun_hwg","tf_weapon_shotgun_pyro","tf_weapon_sapper","tf_weapon_pistol"},
TF2_StockWeaponTypeClassnameMelee[][] = {"","tf_weapon_bat","tf_weapon_club","tf_weapon_shovel","tf_weapon_bottle","tf_weapon_bonesaw","tf_weapon_fists","tf_weapon_fireaxe","tf_weapon_knife","tf_weapon_wrench"},
TF2_PDATypeClassname[][] = {"","","","","","","","","tf_weapon_pda_spy","tf_weapon_pda_engineer_build"},
TF2_PDA2TypeClassname[][] = {"","","","","","","","","tf_weapon_invis","tf_weapon_pda_engineer_destroy"},
TF2_PDA3TypeClassname[][] = {"","","","","","","","","","tf_weapon_builder"},
TF2_SlotName[][] = {"Primary","Secondary","Melee","Construction PDA / Disguise Kit","Demolition PDA / Invis Watch","Slot5","Slot6","Slot7","Slot8","Slot9","Slot10"},
TF2_ConditionName[][] = {"Revving Minigun, Sniper Rifle. Gives zoomed/revved pose"
,"Sniper Rifle zooming"
,"Disguise smoke"
,"Disguise"
,"Cloak Effect"
,"Invulnerability, removed when being healed or by another Über effect"
,"Teleport trail"
,"Used for taunting, can remove to stop taunting"
,"Invulnerability expiration effect"
,"Cloak flickering effect"
,"Used for teleporting, does nothing applying"
,"Crit boost, removed when being healed or another Über effect"
,"Temporary damage buff, something along with attribute 19"
,"Dead Ringer damage resistance, gives TFCond_Cloaked"
,"Bonk! Atomic Punch effect"
,"Slow effect, can remove to remove stun effects"
,"Buff Banner mini-crits, icon and glow"
,"Forced forward, charge effect"
,"Eyelander eye glow"
,"Mini-crit effect"
,"Ring effect, rings disappear after a taunt ends"
,"Used for healing, does nothing applying"
,"Ignite sound and vocals, can remove to remove afterburn"
,"Used for overheal, does nothing applying"
,"Jarate effect"
,"Bleed effect"
,"Battalion's Backup's defense, icon and glow"
,"Mad Milk effect"
,"Quick-Fix Übercharge's knockback/stun immunity and visual effect"
,"Concheror's speed boost, heal on hit, icon and glow"
,"Fan o'War marked-for-death effect"
,"Mini-crits, blocks healing, glow, no weapon mini-crit effects"
,"Disciplinary Action speed boost"
,"Halloween pumpkin crit-boost"
,"Crit-boost and doubles Sentry Gun fire-rate"
,"Crit glow, adds TFCond_Charging when charge meter is below 75%"
,"Soda popper multi-jump effect"
,"Arena first blood crit-boost"
,"End-of-round crit-boost"
,"Intelligence capture crit-boost"
,"Crit boost from crit-on-kill weapons"
,"Prevents switching once melee is out"
,"MvM Bomb Carrier defense buff (TFCond_DefenseBuff without crit resistance)"
,"No longer functions"
,"Phlogistinator crit-boost"
,"Old Phlogistinator defense buff"
,"Hitman's Heatmaker no-unscope and faster Sniper charge"
,"Enforcer damage bonus removed"
,"Marked-for-death without sound effect"
,"Dispenser disguise when crouching, max movement speed, sentries ignore player"
,"Sapper sparkle effect in MvM"
,"Out-of-bounds robot invulnerability effect"
,"Invulnerability effect and Sentry Gun damage resistance"
,"Bomb head effect (does not explode)"
,"Forced Thriller taunting"
,"Radius Healing, adds TFCond_InHealRadius, TFCond_Healing. Removed when a taunt ends, but this condition stays but does nothing"
,"Miscellaneous crit-boost"
,"Miscellaneous invulnerability"
,"Vaccinator Über bullet resistance"
,"Vaccinator Über blast resistance"
,"Vaccinator Über fire resistance"
,"Vaccinator Über fire resistance"
,"Vaccinator Über healing bullet resistance"
,"Vaccinator Über healing blast resistance"
,"Cloaked until next attack"
,"Medigun debuff"
,"Cloaked, will appear for a few seconds on attack and cloak again"
,"Full bullet immunity"
,"Full blast immunity"
,"Full fire immunity"
,"Survive to 1 health, then the condition is removed"
,"Stuns bots and applies radio effect"
,"Speed boost, non-melee fire rate and reload, infinite air jumps"
,"Healing effect, adds TFCond_Healing along with TFCond_MegaHeal temporarily"
,"Double size, x10 max health increase, ammo regeneration and forced thirdperson"
,"Half size and increased head size"
,"Applies TFCond_HalloweenGhostMode when the player dies"
,"Becomes a ghost unable to attack but can fly"
,"Mini-crits effect, Does nothing, condition does not exist"
,"75% chance to doge an attack"
,"Parachute effect, removed when touching the ground"
,"Player is blast jumping"
,"Player forced into a halloween kart"
,"Player forced into a halloween kart"
,"Big head and lowered gravity"
,"Forced melee, along with TFCond_SpeedBuffAlly and TFCond_HalloweenTiny"
,"Swim in the air with Jarate overlay"
,"Locked and cannot turn, attack or switch weapons but still can taunt"
,"Puts a cage around the player if in TFCond_HalloweenKart, otherwise crashes"
,"Has a powerup"
,"Double damage and no damage falloff"
,"Double fire rate, reload speed, clip and ammo size and 30% faster movement speed"
,"Regen ammo, health and metal"
,"Takes 1/2 damage and critical immunity"
,"Takes 3/4 damage, gain health on damage and 40% increase in max health"
,"Attacker takes damage and knockback on hitting the player and 50% increase in max health"
,"Less bullet spread, no damage falloff, 250% faster projectiles, and double damage, faster charge, and faster re-zoom for Sniper Rifles"
,"Increased movement speed, grappling hook speed, jump height and instant weapon switch"
,"Used when player fires their grappling hook, no effect applying or removing"
,"Used when a player is pulled by their grappling hook, no effect applying or removing"
,"Used when a player latches onto a wall, no effect applying or removing"
,"Used when a player is hit by attacker's grappling hook, does no effect applying or removing"
,"Deadringer afterburn immunity"
,"Melee and grappling hook only, increased max health, knockback immunity, x4 more damage against buildings, and knockbacks a powerup off a victim on hit"
,"Prevents gaining a crit-boost or Über powerups"
,"Crit-boost effect"
,"Used when a player intercepts the Jack/Ball, does nothing applying or removing"
,"Swimming in the air without animations or overlay"
,"Refills max health, short Über, escaped the underworld message on removal"
,"Increased max health and applies TFCond_KingAura"
,"Radius health kit stealing, increased max health, TFCond_Plague on touching a victim"
,"Charge meter passively increasing, when charge activated causes radius Bonk stun"
,"Plague sound effect and message, blocks King powerup health regen"
,"Increased fire rate, reload speed, and health regen to players in a radius"
,"Outline and health meter of teammates (and disguised spies)"
,"Used when a player is airblasted, does nothing when applying or removing"
,"Applied when the player is on the competitive winner's podium, does nothing on applying or removing"
,"Applied when the player is on the loser team in competitive match summary, prevents taunting"
,"Healing debuff from Medics and dispensers"
,"Marked-for-death effect"
,"Prevents taunting and some Grappling Hook actions"
,"Unknown, checked when attempting to set the target for a grappling hook"
,"Parachute deloyed, prevents reopening it"
,"Gas Passer effect"
,"Dragon's Fury afterburn on Pyros"
,"Thermal Thruster launched effects, prevents reusing"
,"Less ground friction"
,"Reduced air control and friction"
,"Used whenever a player gets teleported to Hell, does nothing applied but stops the gradual healing from the teleport when removed"
,"Used in Mannpower when a player has a high kill count compared to the rest of the players in the game. Reduces the strength of the currently equipped powerup"},
TF2_SpellPaintName[][] = {"Die Job","Chromatic Corruption","Putrescent Pigmentation","Spectral Spectrum","Sinister Staining","Unnamed Unused"},
TF2_KillstreakerSheenName[][] = {"None","Team Shine","Deadly Daffodil","Manndarin","Mean Green","Agonizing Emerald","Villainous Violet","Hot Rod"},
TF2_KillstreakerEffectName[][] = {"Fire Horns","Cerebral Discharge","Tornado","Flames","Singularity","Incinerator","Hypno-Beam"};

stock TFClassType TF2_TauntsClassType[] = {TFClass_All,TFClass_All,TFClass_All,TFClass_Medic,TFClass_All,TFClass_All,TFClass_All,TFClass_Spy,TFClass_Medic,TFClass_All,TFClass_All,TFClass_Pyro,TFClass_Soldier,TFClass_Demoman,TFClass_Engineer,TFClass_Sniper,TFClass_Scout,TFClass_All,TFClass_Scout,TFClass_Demoman,TFClass_All,TFClass_All,TFClass_All,TFClass_Heavy,TFClass_All,TFClass_All,TFClass_Soldier,TFClass_Scout,TFClass_Pyro,TFClass_Scout,TFClass_Sniper,TFClass_Sniper,TFClass_Spy,TFClass_Heavy,TFClass_Engineer,TFClass_All,TFClass_Demoman,TFClass_All,TFClass_Soldier,TFClass_Soldier,TFClass_Spy,TFClass_Pyro,TFClass_All,TFClass_Sniper,TFClass_Demoman,TFClass_Engineer,TFClass_Heavy,TFClass_Heavy,TFClass_Engineer,TFClass_Pyro,TFClass_Scout,TFClass_Medic,TFClass_Pyro,TFClass_Scout,TFClass_Scout,TFClass_Spy,TFClass_Demoman,TFClass_Medic,TFClass_Soldier,TFClass_Scout,TFClass_Pyro,TFClass_Engineer,TFClass_Scout,TFClass_All,TFClass_Demoman,TFClass_Soldier,TFClass_Medic,TFClass_Heavy,TFClass_Scout,TFClass_Medic,TFClass_Sniper,TFClass_Pyro};

stock int
TF2_ClassDefaultHealth[] = {125,200,175,175,300,125,150,125,125,175},
TF2_Taunts[] = {167,438,463,477,1015,1106,1107,1108,1109,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119,1120,1157,1162,1172,1174,1182,1183,1196,1197,30570,30572,30609,30614,30615,30616,30618,30621,30671,30672,30673,30761,30762,30763,30816,30839,30840,30842,30843,30844,30845,30876,30917,30918,30919,30920,30921,30922,31153,31154,31155,31156,31157,31160,31161,31162,31201,31202,31203,31207,31233,31236,31237,31239},
TF2_Australiums[] = {4,7,13,14,15,16,18,19,20,21,29,36,38,45,61,132,141,194,197,200,201,202,203,205,206,207,208,211,228,264,424},
TF2_Conditions[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129},
TF2_Warpaints[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,217,218,220,221,223,224,225,226,228,230,232,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,275,276,277,278,279,280,281,282,283,284,285,286,287,289,290,291,292,293,294,295,296,297,300,301,302,303,304,305,306,307,308,309,310,390,391},
TF2_Paints[] = {1315860,2960676,3100495,3329330,3874595,4345659,4732984,5322826,6637376,6901050,7511618,8154199,8208497,8289918,8400928,8421376,10843461,11049612,12073019,12807213,13595446,14204632,15132390,15185211,15308410,12377523,12955537,15787660,16738740},
TF2_UnusualEffects[] = {
1 //Particle 1
,2 //Flying Bits.
,3 //Nemesis Burst.
,4 //Community Sparkle.
,5 //Holy Glow.
,6 //Green Confetti.
,7 //Purple Confetti.
,8 //Haunted Ghosts.
,9 //Green Energy.
,10 //Purple Energy.
,11 //Circling TF Logo.
,12 //Massed Flies.
,13 //Burning Flames.
,14 //Scorching Flames
,15 //Searing Plasma.
,16 //Vivid Plasma.
,17 //Sunbeams.
,18 //Circling Peace Sign.
,19 //Circling Heart.
,20 //Map Stamps.
,28 //Genteel Smoke.
,29 //Stormy Storm.
,30 //Blizzardy Storm.
,31 //Nuts n' Bolts.
,32 //Orbiting Planets.
,33 //Orbiting Fire.
,34 //Bubbling.
,35 //Smoking.
,36 //Steaming.
,37 //Flaming Lantern.
,38 //Cloudy Moon.
,39 //Cauldron Bubbles.
,40 //Eerie Orbiting Fire.
,43 //Knifestorm.
,44 //Misty Skull.
,45 //Harvest Moon.
,46 //It's A Secret To Everybody.
,47 //Stormy 13th Hour.
,55 //Attrib_Particle55. (Aces High)
,56 //Kill-A-Watt.
,57 //Terror-Watt.
,58 //Cloud 9.
,59 //Aces High.
,60 //Dead Presidents.
,61 //Miami Nights.
,62 //Disco Beat Down.
,63 //Phosphorous.
,64 //Sulphurous.
,65 //Memory Leak.
,66 //Overclocked.
,67 //Electrostatic.
,68 //Power Surge.
,69 //Anti-Freeze. nice.
,70 //Time Warp.
,71 //Green Black Hole.
,72 //Roboactive.
,73 //Arcana.
,74 //Spellbound.
,75 //Chiroptera Venenata.
,76 //Poisoned Shadows.
,77 //Something Burning This Way Comes.
,78 //Hellfire.
,79 //Darkblaze.
,80 //Demonflame.
,81 //Bonzo THe All-Gnawing.
,82 //Amaranthine.
,83 //Stare From Beyond.
,84 //The Ooze.
,85 //Ghastly Ghosts Jr.
,86 //Haunted Phantasm Jr.
,87 //Frostbite.
,88 //Molten Mallard.
,89 //Morning Glory.
,90 //Death at Dusk.
,91 //Abduction.
,92 //Atomic.
,93 //Subatomic.
,94 //Electric Hat Protector.
,95 //Magnetic Hat Protector.
,96 //Voltaic Hat Protector.
,97 //Galactic Codex.
,98 //Ancient Codex.
,99 //Nebula.
,100 //Death by Disco.
,101 //It's A Mystery To Everyone.
,102 //It's A Puzzle To Me.
,103 //Ether Trail.
,104 //Nether Trail.
,105 //Ancient Eldritch.
,106 //Eldritch Flame.
,107 //Neutron Star.
,108 //Tesla Coil.
,109 //Starstorm Insomnia.
,110 //Starstorm Slumber.
,111 //Brain Drain.
,112 //Open Mind.
,113 //Head of Steam.
,114 //Galactic Gateway.
,115 //The Eldritch Opening.
,116 //The Dark Doorway.
,117 //Ring Of Fire.
,118 //Vicious Circle.
,119 //White Lightning.
,120 //Omniscient Orb.
,121 //Clairvoyance.
,122 //Fifth Dimension.
,123 //Vicious Vortex.
,124 //Menacing Miasma.
,125 //Abyssal Aura.
,126 //Wicked Wood.
,127 //Ghastly Grove.
,128 //Mystical Medley.
,129 //Ethereal Essence.
,130 //Twisted Radiance.
,131 //Violet Vortex.
,132 //Verdant Vortex.
,133 //Valiant Vortex.
,134 //Sparkling Lights.
,135 //Frozen Icefall.
,136 //Fragmented Gluons.
,137 //Fragmented Quarks.
,138 //Fragmented Photons.
,139 //Defragmenting Reality.
,141 //Fragmenting Reality.
,142 //Refragmenting Reality.
,143 //Snowfallen.
,144 //Snowblinded.
,145 //Pyroland Daydream.
,147 //Verdatica.
,148 //Aromatica.
,149 //Chromatica.
,150 //Prismatica.
,151 //Bee Swarm.
,152 //Frisky Fireflies
,153 //Smoldering Spirits.
,154 //Wandering Wisps.
,155 //Kaleidoscope.
,156 //Green Giggler.
,157 //Laugh-O-Lantern.
,158 //Plum Prankster.
,159 //Pyroland Nightmare.
,160 //Gravelly Ghoul.
,161 //Vexed Volcanics.
,162 //Gourdian Angel.
,163 //Pumpkin Party.
,164 //Frozen Fractals.
,165 //Lavender Landfall.
,166 //Special Snowfall.
,167 //Divine Desire.
,168 //Distant Dream.
,169 //Violent Wintertide.
,170 //Blighted Snowstorm.
,171 //Pale Nimbus.
,172 //Genus Plasmos.
,173 //Serenus Lumen.
,174 //Ventum Maris.
,175 //Mirthful Mistletoe.
,177 //Resonation.
,178 //Aggradation.
,179 //Lucidation.
,180 //Stunning.
,181 //Ardentum Saturnalis.
,182 //Fragrancium Elementalis.
,183 //Reverium Irregularius.
,185 //Perennial Petals.
,186 //Flavorsome Sunset.
,187 //Raspberry Bloom.
,188 //Iridesensce.
,189 //Tempered Thorns.
,190 //Devilish Diablo.
,191 //Severed Serration.
,192 //Shrieking Shades.
,193 //Restless Wraiths.
,195 //Infernal Wraith.
,196 //Phantom Crown.
,197 //Ancient Specter.
,198 //Viridescent Peeper.
,199 //Eyes of Molten.
,200 //Ominous Stars.
,201 //Pumpkin Moon.
,202 //Frantic Spooker.
,203 //Frightened Poltergeist.
,204 //Energetic Haunter.
,205 //Smissmass Tree.
,206 //Hospitable Festivity.
,207 //Condescending Embrace.
,209 //Sparkling Spruce.
,210 //Glittering Juniper.
,211 //Prismatic Pine.
,212 //Spiraling Lights.
,213 //Twisting Lights.
,214 //Stardust Pathway.
,215 //Flurry Rush.
,216 //Spark of Smissmass.
,218 //Polar Forecast.
,219 //Shining Stag.
,220 //Holiday Horns.
,221 //Ardent Antlers.
,223 //Festive Lights.
,224 //Crustacean Sensation.
,226 //Frosted Decadence.
,228 //Sprinkled Delights.
,229 //Terrestrial Favor.
,230 //Tropical Thrill.
,231 //Flourishing Passion.
,232 //Dazzling Fireworks.
,233 //Blazing Fireworks.
,234 //Shimmering Fireworks.
,235 //Twinkling Fireworks.
,236 //Sparkling Fireworks.
,237 //Glowing Fireworks.
,238 //Glimmering Fireworks.
,239 //Flying Lights.
,241 //Limelight.
,242 //Shining Star.
,243 //Cold Cosmos.
,244 //Refracting Fractals.
,245 //Startrance.
,247 //Starlush.
,248 //Starfire.
,249 //Stardust.
,250 //Contagious Eruption.
,251 //Daydream Eruption.
,252 //Volcanic Eruption.
,253 //Divine Sunlight.
,254 //Audiophile.
,255 //Soundwave.
,256 //Synesthesia.
,257 //Haunted Kraken.
,258 //Eerie Kraken.
,259 //Soulful Slice.
,260 //Horsemann's Hack.
,261 //Haunted Forever.
,263 //Forever And Forever!.
,264 //Cursed Forever!.
,265 //Moth Plague.
,266 //Malevolent Monoculi.
,267 //Haunted Wick.
,269 //Wicked Wick.
,270 //Spectral Wick.
,701 //Hot.
,702 //Isotope.
,703 //Cool
,704 //Energy Orb.
,3001 //Showstopper.
,3003 //Holy Grail.
,3004 //'72.
,3005 //Fountain of Delight.
,3006 //Screaming Tiger.
,3007 //Skill Gotten Gains.
,3008 //Midnight Whirlwind.
,3009 //Silver Cyclone.
,3010 //Mega Strike.
,3011 //Haunted Phantasm.
,3012 //Ghastly Ghosts.
,3013 //Hellish Inferno.
,3014 //Spectral Swirl.
,3015 //Infernal Flames.
,3016 //Infernal Smoke.
,3017 //Acidic Bubbles of Envy.
,3018 //Flammable Bubbles of Attraction.
,3019 //Poisonous Bubbles of Regret.
,3020 //Roaring Rockets.
,3021 //Spooky Night.
,3022 //Ominous Night.
,3023 //Bewitched.
,3024 //Accursed.
,3025 //Enchanted.
,3026 //Static Mist.
,3027 //Eerie Lightning.
,3028 //Terrifying Thunder.
,3029 //Jarate Shock.
,3030 //Nether Void.
,3031 //Good-Hearted Goodies.
,3032 //Wintery Wisp.
,3033 //Arctic Aurora.
,3034 //Winter Spirit.
,3035 //Festive Spirit.
,3036 //Magic Spirit.
,3037 //Spectral Escort.
,3038 //Astral Presence.
,3039 //Arcane Assistance.
,3041 //Emerald Allurement.
,3042 //Pyrophoric Pesonality.
,3043 //Spellbound Aspect.
,3044 //Static Shock.
,3045 //Veno Shock.
,3046 //Toxic Terrors.
,3047 //Arachnid Assault.
,3048 //Creepy Crawlies.
,3049 //Delightful Star.
,3050 //Frosted Star.
,3051 //Apotheosis.
,3052 //Ascension.
,3053 //Reindoonicorn Rancher.
,3055 //Twinkling Lights.
,3056 //Shimmering Lights.
,3059 //Spectral Shackles.
,3060 //Cursed Confinement.
,3061 //Cavalier de Carte.
,3063 //Hollow Flourish.
,3064 //Magic Shuffle.
,3065 //Vigorous Pulse.
,3066 //Thundering Spirit.
,3067 //Galvanic Defiance.
,3068 //Wispy Halos.
,3069 //Nether Wisps.
,3070 //Aurora Borealis.
,3071 //Aurora Australis.
,3072 //Aurora Polaris.
,3073 //Amethyst Winds.
,3074 //Golden Gusts.
,3075 //Smissmass Swirls.
,3077 //Minty Cypress.
,3078 //Pristine Pine.
,3079 //Sparkly Spruce.
,3081 //Festive Fever.
,3083 //Golden Glimmer.
,3084 //Frosty Silver.
,3085 //Glamorous Dazzle.
,3087 //Sublime Snowstorm.
,3088 //Marigold Ritual.
,3090 //Pungent Poison.
,3091 //Blazed Brew.
,3092 //Mysterious Mixture.
,3093 //Linguistic Deviation.
,3094 //Aurelian Seal.
,3095 //Runic Imprisonment.
,3097 //Prismatic Haze.
,3098 //Rising Ritual.
,3100 //Bloody Grip.
,3102 //Toxic Grip.
,3103 //Infernal Grip.
,3104 //Death Grip.
},
TF2_Weapons[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,35,36,37,38,39,40,41,42,43,44,45,46,56,57,58,59,60,61,127,128,129,130,131,132,133,140,141,142,153,154,155,160,161,169,171,172,173,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,212,214,215,220,221,222,224,225,228,230,231,232,237,239,264,265,266,294,297,298,304,305,307,308,310,312,317,325,326,327,329,331,348,349,351,355,356,357,401,402,404,406,411,412,413,414,415,416,423,424,425,426,441,442,444,447,448,449,450,452,457,460,461,466,474,482,513,525,526,527,528,572,574,587,588,589,593,594,595,609,638,642,648,649,654,656,658,659,660,661,662,663,664,665,669,727,737,739,740,741,751,752,772,773,775,792,793,794,795,796,797,798,799,800,801,802,803,804,805,806,808,808,809,811,812,813,832,833,834,850,851,880,881,882,883,884,885,886,887,888,889,890,891,892,893,894,895,896,897,898,899,900,901,902,903,904,905,906,907,908,909,910,911,912,913,914,915,916,939,947,954,957,958,959,960,961,962,963,964,965,966,967,968,969,971,972,973,974,996,997,999,1000,1003,1004,1005,1006,1007,1013,1071,1078,1079,1081,1082,1083,1084,1085,1092,1098,1099,1100,1101,1102,1103,1104,1105,1121,1123,1127,1141,1142,1143,1144,1145,1146,1149,1150,1151,1153,1178,1179,1180,1181,1184,15000,15001,15002,15003,15004,15005,15006,15007,15008,15009,15110,15011,15012,15013,15014,15015,15016,15017,15018,15019,15020,15021,15022,15023,15024,15125,15026,15027,15028,15029,15030,15031,15032,15033,15034,15035,15036,15037,15038,15139,15040,15041,15042,15043,15044,15045,15046,15047,15048,15049,15050,15051,15052,15053,15054,15055,15056,15057,15058,15059,15060,15061,15062,15063,15064,15065,15066,15067,15068,15069,15070,15071,15072,15073,15074,15075,15076,15077,15078,15079,15080,15081,15082,15083,15084,15085,15086,15087,15088,15089,15090,15091,15092,15094,15095,15096,15097,15098,15099,15100,15101,15102,15103,15104,15105,15106,15107,15108,15109,15110,15111,15112,15113,15114,15115,15116,15117,15118,15119,15120,15121,15122,15123,15124,15125,15126,15127,15128,15129,15130,15131,15132,15133,15134,15135,15136,15137,15138,15139,15140,15141,15142,15143,15144,15145,15146,15147,15148,15149,15150,15151,15152,15153,15154,15155,15156,15157,15158,30474,30665,30666,30667,30668,30758},
TF2_KillstreakerEffect[] = {2002,2003,2004,2005,2006,2007,2008},
TF2_KillstreakerSheen[] = {0,1,2,3,4,5,6,7};

const int MAX_TF2_TAUNTS = sizeof(TF2_Taunts);
const int MAX_TF2_CONDITIONS = sizeof(TF2_Conditions);
const int MAX_TF2_WARPAINTS = sizeof(TF2_Warpaints);
const int MAX_TF2_PAINTS = sizeof(TF2_Paints);
const int MAX_TF2_UNUSUALS = sizeof(TF2_UnusualEffects);
const int MAX_TF2_WEAPONS = sizeof(TF2_Weapons);
const int MAX_TF2_KILLSTREAKER_SHEENS = sizeof(TF2_KillstreakerEffect);
const int MAX_TF2_KILLSTREAKER_EFFECTS = sizeof(TF2_KillstreakerSheen);

//TF2 Flag Event
enum TFFlag {
	TFFlag_None = 0,
	TFFlag_PickedUp = 1,
	TFFlag_Captured = 2,
	TFFlag_Defended	= 3,
	TFFlag_Dropped = 4,
	TFFlag_Carrier = 5
}

//TF Slots
enum TFSlot {
	TFSlot_Invalid = -1,
	TFSlot_Primary = 0,
	TFSlot_Secondary = 1,
	TFSlot_Melee = 2,
	TFSlot_PDA = 3,
	TFSlot_PDA2 = 4,
	TFSlot_Slot6 = 5,
	TFSlot_Slot7 = 6,
	TFSlot_Slot8 = 7,
	TFSlot_Slot9 = 8,
	TFSlot_Slot10 = 9,
	TFSlot_Slot11 = 10
}

enum TFCritType {
	TFCritType_None = 0,
	TFCritType_Minicrit = 1,
	TFCritType_Crit = 2
}

enum TFBuilding	{
	TFBuilding_Invalid = -1,
	TFBuilding_Sentrygun = 0,
	TFBuilding_Dispenser = 1,
	TFBuilding_Teleporter_Entrance = 2,
	TFBuilding_Teleporter_Exit = 3,
	TFBuilding_MiniSentry = 4,
	TFBuilding_Sapper = 5
}

enum TFQuality {
	TFQuality_Invalid = -1,
	TFQuality_Normal = 0,
	TFQuality_Genuine = 1,
	TFQuality_Rarity2 = 2,
	TFQuality_Vintage = 3,
	TFQuality_Rarity4 = 4,
	TFQuality_Unusual = 5,
	TFQuality_Unique = 6,
	TFQuality_Community = 7,
	TFQuality_Valve = 8,
	TFQuality_SelfMade = 9,
	TFQuality_Rarity10 = 10,
	TFQuality_Strange = 11,
	TFQuality_Completed = 12,
	TFQuality_Haunted = 13,
	TFQuality_Collectors = 14,
	TFQuality_Skins = 15
}

/* Look up "item_found" event */
enum TFMethod {
	TFFound_Achieved = -1,
	TFFound_Found = 0,
	TFFound_Crafted = 1,
	TFFound_Traded = 2,
	TFFound_Unboxed = 4,
	TFFound_Gifted = 5,
	TFFound_Earned = 8,
	TFFound_Refunded = 9,
	TFFound_WrappedGift = 10
}

enum TFGameType	{
	TFGameType_Unknown = 0,
	TFGameType_CTF = 1,
	TFGameType_CP = 2,
	TFGameType_PL = 3,
	TFGameType_Arena = 4,
	TFGameType_MvM = 5, /*?*/
	TFGameType_RD = 6, /*?*/
	TFGameType_PassBall = 7
}

/* See event "halloween_boss_killed" for more info */
enum {
	TFBoss_Killed_HHH = 1,
	TFBoss_Killed_Monoculus = 2,
	TFBoss_Killed_Merasmus = 3
}

// Achievement id's
enum {
	TF2AchID_SentryGunner = 127,
	TF2AchID_Nemesis = 128,
	TF2AchID_HardToKill = 129,
	TF2AchID_MasterOfDisguise = 130,
	TF2AchID_WithFriendsLikeThese = 131,
	TF2AchID_Dynasty = 132,
	TF2AchID_Hardcore = 133,
	TF2AchID_PowerhouseOffense = 134,
	TF2AchID_LightningOffense = 135,
	TF2AchID_RelentlessOffense = 136,
	TF2AchID_ImpenetrableDefense = 137,
	TF2AchID_ImpossibleDefense = 138,
	TF2AchID_HeadOfTheClass = 139,
	TF2AchID_WorldTraveler = 140,
	TF2AchID_TeamDoctor = 141,
	TF2AchID_Flamethrower = 142,
	TF2AchID_GreyMatter = 145,
	TF2AchID_Riftwalker = 150,
	TF2AchID_ReadyForDuty = 151,
	TF2AchID_EscapeTheHeat = 152,
	TF2AchID_TheGreatDeflate = 153,
	TF2AchID_BFF2 = 154,
	TF2AchID_MassHysteria = 155,
	TF2AchID_AFreshPairOfEyes = 156,
	TF2AchID_NoseDive = 157,
	TF2AchID_PunchingBag = 158,
	TF2AchID_EmergencyBrake = 159,
	TF2AchID_PartyCrasher = 160,
	TF2AchID_CongaLine = 161,
	TF2AchID_OnTheRocks = 162,
	TF2AchID_RunningWithScissors = 163,
	TF2AchID_MayICutInToo = 164,
	TF2AchID_Showboat = 165,
	TF2AchID_TuneMerasmusMultDimensionalTelevision = 166,
	TF2AchID_Jackpot = 167,
	TF2AchID_FirstBlood = 1001,
	TF2AchID_FirstBloodPart2 = 1002,
	TF2AchID_QuickHook = 1003,
	TF2AchID_AYearToRemember = 1004,
	TF2AchID_TheCycle = 1005,
	TF2AchID_Closer = 1006,
	TF2AchID_IfYouBuildIt = 1007,
	TF2AchID_GunDown = 1008,
	TF2AchID_BatterUp = 1009,
	TF2AchID_DoctoringTheBall = 1010,
	TF2AchID_Dodgers1Giants0 = 1011,
	TF2AchID_BattingTheDoctor = 1012,
	TF2AchID_ImBatMan = 1013,
	TF2AchID_TripleSteal = 1014,
	TF2AchID_PopFly = 1015,
	TF2AchID_RoundTripper = 1016,
	TF2AchID_ArtfulDodger = 1017,
	TF2AchID_FallClassic = 1018,
	TF2AchID_StrikeZone = 1019,
	TF2AchID_FoulTerritory = 1020,
	TF2AchID_TheBigHurt = 1021,
	TF2AchID_Brushback = 1022,
	TF2AchID_MoonShot = 1023,
	TF2AchID_Beanball = 1024,
	TF2AchID_RetireTheRunner = 1025,
	TF2AchID_CaughtNapping = 1026,
	TF2AchID_SideRetired = 1027,
	TF2AchID_TriplePlay = 1028,
	TF2AchID_StealingHome = 1029,
	TF2AchID_SetTheTable = 1030,
	TF2AchID_BlockThePlate = 1031,
	TF2AchID_BelittledBeleaguer = 1032,
	TF2AchID_NoHitter = 1033,
	TF2AchID_RaceForThePennant = 1034,
	TF2AchID_OutOfThePark = 1035,
	TF2AchID_ScoutMilestone1 = 1036,
	TF2AchID_ScoutMilestone2 = 1037,
	TF2AchID_ScoutMilestone3 = 1038,
	TF2AchID_BackInBusiness = 1039,
	TF2AchID_Back2Back = 1040,
	TF2AchID_SeveredTies = 1041,
	TF2AchID_RodeHardPutAwayWet = 1101,
	TF2AchID_BePolite = 1102,
	TF2AchID_BeEfficient = 1103,
	TF2AchID_HaveAPlan = 1104,
	TF2AchID_KillEveryoneYouMeet = 1105,
	TF2AchID_TriplePrey = 1106,
	TF2AchID_SelfDestructSequence = 1107,
	TF2AchID_DeSentrylized = 1108,
	TF2AchID_ShootTheBreeze = 1109,
	TF2AchID_DroppedDead = 1110,
	TF2AchID_TheLastWave = 1111,
	TF2AchID_AustralianRules = 1112,
	TF2AchID_KookTheSpook = 1112,
	TF2AchID_SocketToHim = 1113,
	//More to be added.
}

//attributes id's - To be be continually updated.
enum {
	TF2Attr_DamagePenalty = 1,
	TF2Attr_DamageBonus = 2,
	TF2Attr_ClipSizePenalty = 3,
	TF2Attr_ClipSizeBonus = 4,
	TF2Attr_FireRatePenalty = 5,
	TF2Attr_FireRateBonus = 6,
	TF2Attr_HealRatePenalty = 7,
	TF2Attr_HealRateBonus = 8,
	TF2Attr_UberRatePenalty = 9,
	TF2Attr_UberRateBonus = 10,
	TF2Attr_OverhealBonus = 11,
	TF2Attr_OverhealDecayPenalty = 12,
	TF2Attr_OverhealDecayBonus = 13,
	TF2Attr_OverhealDecayDisabled = 14,
	TF2Attr_NoRandomCrits = 15,
	TF2Attr_HealOnHitForRapidfire = 16,
	TF2Attr_AddUberHit = 17,
	TF2Attr_MedigunChargeCrits = 18,
	TF2Attr_DmmgBonusHit = 19,
	TF2Attr_CritsVsBurning = 20,
	TF2Attr_DmgPenaltyVsNonBurning = 21,
	TF2Attr_NoCritsVsNonBurning = 22,
	TF2Attr_CompressionBlast = 23,
	TF2Attr_FlameCritsFromBehind = 24,
	TF2Attr_HiddenSecMaxAmmoPenality = 25,
	TF2Attr_MaxHealthBonus = 26,
	TF2Attr_AltFireDisabled = 27,
	TF2Attr_HiddenNoRandomCrits = 28,
	TF2Attr_FistsRadialBuff = 30,
	TF2Attr_CritboostKill = 31,
	TF2Attr_SlowEnemyHit = 32,
	TF2Attr_CloakFeignDeath = 33,
	TF2Attr_CloakConsumeRate = 34,
	TF2Attr_CloakRegenRate = 35,
	TF2Attr_SpreadPenalty = 36,
	TF2Attr_HiddenPriMaxAmmoBonus = 37,
	TF2Attr_Sandman = 38,
	TF2Attr_DmgPenaltyVsNonStunned = 39,
	TF2Attr_ZoomMoveSpeedDisabled = 40,
	TF2Attr_SniperChargeRate = 41,
	TF2Attr_NoHeadshots = 42,
	TF2Attr_ScattergunFAN = 43,
	TF2Attr_ScattergunKnockback = 44,
	TF2Attr_BulletsPerShot = 45,
	TF2Attr_ZoomPenalty = 46,
	TF2Attr_NoZoom = 47,
	TF2Attr_CloakMovementBased = 48,
	TF2Attr_NoDoubleJump = 49,
	TF2Attr_CloakAbsorbDmg = 50,
	TF2Attr_CritHeadshot = 51,
	TF2Attr_Razorback = 52,
	TF2Attr_WearerCannotIgnite = 53,
	TF2Attr_MoveSpeedPenalty = 54,
	TF2Attr_JarateDesc = 56,
	TF2Attr_HealthRegen = 57,
	TF2Attr_SelfDmgPushForceIncrease = 58,
	TF2Attr_SelfDmgPushForceDecrease = 59,
	TF2Attr_DmgTakenFireDecrease = 60,
	TF2Attr_DmgTakenFireIncrease = 61,
	TF2Attr_DmgTakenCritDecrease = 62,
	TF2Attr_DmgTakenCritIncrease = 63,
	TF2Attr_DmgTakenBlastDecrease = 64,
	TF2Attr_DmgTakenBlastIncrease = 65,
	TF2Attr_DmgTakenBulletsDecrease = 66,
	TF2Attr_DmgTakenBulletsIncrease = 67,
	TF2Attr_IncreaseCapValue = 68,
	TF2Attr_HealthFromHealerDecrease = 69,
	TF2Attr_HealthFromHealerIncrease = 70,
	TF2Attr_AfterburnDmgIncrease = 71,
	TF2Attr_AfterburnDmgDecrease = 72,
	TF2Attr_AfterburnDurationIncrease = 73,
	TF2Attr_AfterburnDurationDecrease = 74,
	TF2Attr_MoveSpeedDeployIncrease = 75,
	TF2Attr_MaxAmmoPrWearerIncrease = 76,
	TF2Attr_MaxAmmoPriWearerDecrease = 77,
	TF2Attr_MaxAmmoSecWearerIncrease = 78,
	TF2Attr_MaxAmmoSecWearerDecrease = 79,
	TF2Attr_MaxMetalWearerIncrease = 80,
	TF2Attr_MaxMetalWearerDecrease = 81,
	TF2Attr_CloakDurationIncrease = 82,
	TF2Attr_CloakDurationDecrease = 83,
	TF2Attr_CloakRegenRateIncrease = 84,
	TF2Attr_CloakRegenRateDecrease = 85,
	TF2Attr_MinigunSpinupTimeIncrease = 86,
	TF2Attr_MinigunSpinupTimeDecrease = 87,
	TF2Attr_MaxStickybombsIncrease = 88,
	TF2Attr_MaxStickybombsincrease = 89,
	TF2Attr_SniperZoomChargeRateIncrease = 90,
	TF2Attr_SniperZoomChargeRateDecrease = 91,
	TF2Attr_ConstructionRateIncrease = 92,
	TF2Attr_ConstructionRateDecrease = 93,
	TF2Attr_RepairRateIncrease = 94,
	TF2Attr_RepairRateDecrease = 95,
	TF2Attr_ReloadTimeIncrease = 96,
	TF2Attr_ReloadTimeDecrease = 97,
	TF2Attr_SelfDmgHitForRapidfire = 98,
	TF2Attr_BlastRadiusIncrease = 99,
	TF2Attr_BlastRadiusDecrease = 100,
	TF2Attr_UnusualEffect = 134,
	TF2Attr_SelfMadeDesc = 141,
	TF2Attr_PaintRGB1 = 142,
	TF2Attr_TurnToGold = 150,
	TF2Attr_Purchased = 172,
	TF2Attr_PaintRGB2 = 261,
	TF2Attr_TwoWayTeleporter = 276,
	TF2Attr_PDAPipBoyInterface = 295,
	TF2Attr_DispenserRadiusIncreased = 345,
	TF2Attr_HeadScale = 444,
	TF2Attr_UnusualEffectVerticalOffset = 519,
	TF2Attr_UnusualEffectUseHeadOrigin = 520,
	TF2Attr_ItemStyleOverride = 542,
	TF2Attr_TorsoScale = 620,
	TF2Attr_LimitedQuantityItem = 692,
	TF2Attr_HandScale = 699,
	TF2Attr_WarpaintWear = 725,
	TF2Attr_Warpaint = 834,
	TF2Attr_SpellPaint = 1004,
	TF2Attr_SpellFootprints = 1005,
	TF2Attr_SpellVoicesFromBelow = 1006,
	TF2Attr_SpellPumpkinExplosions = 1007,
	TF2Attr_SpellGreenFlames = 1008,
	TF2Attr_SpellExorcism = 1009,
	TF2Attr_KillstreaksEffect = 2013,
	TF2Attr_KillstreaksSheen = 2014,
	TF2Attr_LootRarity = 2022,
	TF2Attr_Killstreaks = 2025,
	TF2Attr_Australium = 2027,
	TF2Attr_Marketable = 2028,
	TF2Attr_OnTauntUnusualEffect = 2041,
	TF2Attr_Festivized = 2053,
	TF2Attr_ItemDropWave = 3018,
}

#define	TFTeam(%1) view_as<TFTeam>(%1)
#define	TFFlag(%1) view_as<TFFlag>(%1)
#define	TFSlot(%1) view_as<TFSlot>(%1)
#define	TFCritType(%1) view_as<TFCritType>(%1)
#define	TFBuilding(%1) view_as<TFBuilding>(%1)
#define	TFQuality(%1) view_as<TFQuality>(%1)
#define	TFMethod(%1) view_as<TFMethod>(%1)
#define	TFGameType(%1) view_as<TFGameType>(%1)

/**
 *	Set the users mvm currency/cash.
 *
 *	@param	client		The users index.
 *	@param	value		Currency value.
 *
 *	@error	If the user is invalid or has no currency property, this returns false.
 */
stock bool TF2_SetClientMvMCurrency(int client, int value) { return SetEntPropEx(client, Prop_Send, "m_nCurrency", value); }

/**
 *	Returns the users mvm currency/cash
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid or has no currency property, this returns -1.
 */
stock int TF2_GetClientMvMCurrency(int client) { return GetEntPropEx(client, Prop_Send, "m_nCurrency"); }

/**
 *	Set the users taunt cam on/off, useful for thirdperson plugin.
 *
 *	@param	client		The users index.
 *	@param	value		Bool value.
 *
 *	@error	If the user is invalid or has no taunt cam property, this returns false.
 */
stock bool TF2_SetClientTauntCam(int client, bool value) { return SetEntPropEx(client, Prop_Send, "m_nForceTauntCam", value); }

/**
 *	Returns the users taunt cam.
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid or has no taunt cam property, this returns false.
 */
stock bool TF2_GetClientTauntCam(int client) { return GetEntPropBool(client, Prop_Send, "m_nForceTauntCam"); }

//Set or get the users killstreak count
/**
 *	Set the clients killstreak count
 *
 *	@param	client		The users index.
 *	@param	value		Killstreak count.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool TF2_SetClientKillstreak(int client, int value=5) { return SetEntPropEx(client, Prop_Send, "m_nStreaks", value); }

/**
 *	Returns the users killstreak count
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns -1.
 */
stock int TF2_GetClientKillstreak(int client) { return GetEntPropEx(client, Prop_Send, "m_nStreaks"); }

/**
 *	Returns the users cloak meter.
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid or has no cloak, this returns -1.0.
 */
stock float TF2_GetClientCloakMeter(int client) { return GetEntPropFloatEx(client, Prop_Send, "m_flCloakMeter"); }

/**
 *	Set the users cloak meter.
 *
 *	@param	client		The users index.
 *	@param	value		Cloak duration.
 *
 *	@error	If the user is invalid or has no cloak, this returns false.
 */
stock bool TF2_SetClientCloakMeter(int client, float value=1.0) { return SetEntPropFloatEx(client, Prop_Send, "m_flCloakMeter", value); }

/**
 *	Returns the users glow value.
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid, this returns false.
*/
stock bool TF2_GetClientGlow(int client) { return GetEntPropBool(client, Prop_Send, "m_bGlowEnabled"); }

/**
 *	Toggle the users glow value.
 *
 *	@param	client		The users index.
 *	@param	value		Glow value.
 *
 *	@error	If the user is invalid, this returns.
 */
stock bool TF2_SetClientGlow(int client, bool value) { return SetEntPropEx(client, Prop_Send, "m_bGlowEnabled", value); }

/**
 *	Returns the users ubercharge value,
 *
 *	@param	client		The users index.
 *
 *	@error	If the user is invalid or has no medigun, this will return -1.0.
*/
stock float TF2_GetClientUbercharge(int client)	{ return GetEntPropFloatEx(client, Prop_Send, "m_flChargeLevel"); }

/**
 *	Set the users ubercharge value,
 *
 *	@param	client	The users index.
 *	@param	value	Ubercharge value, Defaulted to 1.0.
 *
 *	@error	If the user is invalid or has no medigun, this returns false.
*/
stock bool TF2_SetClientUbercharge(int client, float value=1.0)	{ return SetEntPropFloatEx(client, Prop_Send, "m_flChargeLevel", value); }

/**
 *	Returns the users charge value,
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this returns -1.0.
*/
stock float TF2_GetClientChargeMeter(int client) { return GetEntPropFloatEx(client, Prop_Send, "m_flChargeMeter"); }

/**
 *	Set the users charge value,
 *
 *	@param client	The users index.
 *	@param value	Charge value.
 *
 *	@error	If the user is invalid or has no charge-weapon, this returns -1.0.
*/
stock bool TF2_SetClientChargeMeter(int client, float value=1.0) { return SetEntPropFloatEx(client, Prop_Send, "m_flChargeMeter", value); }

/**
 *	Returns the users metal value,
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid or has no metal-property, this returns -1.
*/
stock int TF2_GetClientMetal(int client) { return GetEntPropEx(client, Prop_Data, "m_iAmmo", 4, 3); }

/**
 *	Set the users metal value,
 *
 *	@param	client	The users index.
 *	@param	metal	Metal amount.
 *
 *	@error	If the user is invalid or has no metal-property, this returns false.
*/
stock bool TF2_SetClientMetal(int client, int metal=200) { return SetEntPropEx(client, Prop_Data, "m_iAmmo", metal, 4, 3); }

/**
 *	Returns the users decapitations value,
 *
 *	@param	client		The users index.
 *
 *	@error	If the client is invalid or has no decapitation-property, this returns -1.
*/
stock int TF2_GetClientDecapitations(int client) { return GetEntPropEx(client, Prop_Send, "m_iDecapitations"); }

/**
 *	Set the users decapitations value,
 *
 *	@param	client		The users index.
 *	@param	value		Decapitations amount.
 *
 *	@error	If the user is invalid or has no decapitation-property, this returns false.
*/
stock bool TF2_SetClientDecapitations(int client, int value=10) { return SetEntPropEx(client, Prop_Send, "m_iDecapitations", value); }

/**
 *	Returns the TF2 Weapon Slot
 *
 *	@param	client		The users index.
 *	@param	slot		TFSlot slot.
 *
 *	@error	If the user or slot is invalid, this returns -1.
 */
stock int TF2_GetPlayerWeaponSlot(int client, TFSlot slot) { return Tklib_IsValidClient(client, _, true) ? GetPlayerWeaponSlot(client, view_as<int>(slot)):-1; }

/**
 *	Returns the name of the building.
 *
 *	@param	building		The TFBuilding.
 *	@param	buildingname	String to store the building name to.
 *
 *	@param	maxlen			Maximum length of the string.
 */
stock void TF2_GetBuildingName(TFBuilding building, char[] buildingname, int maxlen) {
	switch(building) {
		case TFBuilding_Dispenser: strcopy(buildingname, maxlen, "Dispenser");
		case TFBuilding_Sentrygun: strcopy(buildingname, maxlen, "Sentrygun");
		case TFBuilding_Teleporter_Entrance: strcopy(buildingname, maxlen, "Teleporter Entrance");
		case TFBuilding_Teleporter_Exit: strcopy(buildingname, maxlen, "Teleporter Exit");
		case TFBuilding_MiniSentry: strcopy(buildingname, maxlen, "Mini-Sentry");
		case TFBuilding_Sapper: strcopy(buildingname, maxlen, "Sapper");
	}
}

/**
 *	Returns the TFBuilding type.
 *
 *	@param	entity	The building to get TFBuilding type from.
 *
 *	@error	If the building is invalid, this returns TFBuilding_Invalid.
 */
stock TFBuilding TF2_GetBuildingType(any entity) {
	char classname[64];
	GetEntityClassname(entity, classname, sizeof(classname));
	
	if(StrEqual(classname, "obj_dispenser")) return TFBuilding_Dispenser;
	if(StrEqual(classname, "obj_sentrygun")) return TFBuilding_Sentrygun;
	if(StrEqual(classname, "obj_teleporter"))	{
		switch(TF2_GetObjectMode(entity)) {
			case TFObjectMode_Entrance: return TFBuilding_Teleporter_Entrance;
			case TFObjectMode_Exit: return TFBuilding_Teleporter_Exit;
		}
	}
	if(StrEqual(classname, "obj_minisentry")) return TFBuilding_MiniSentry;
	if(StrContainsEx(classname, "sapper", false)) return TFBuilding_Sapper;
	
	return TFBuilding_Invalid;
}

/**
 *	Sets if the users current class-model should be forced using its class animations.
 *
 *	@param	client	The users index.
 *	@param	value	The bool on/off value.
 *
 *	@error	If the user is invalid or has no class animations, this returns false.
 */
stock bool TF2_SetClassAnimations(int client, bool value) { return SetEntPropEx(client, Prop_Send, "m_bUseClassAnimations", value); }

/**
 *	Sets the clients model.
 *	This is the alternative to SetClientModel, as this actually puts the model.
 *	This is paired with GetClientModel.
 *
 *	@param	client				The users index.
 *	@param	model				The model path.
 *	@param	UseClassAnimations	If true, this will force the model to use the class animations.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool TF2_SetClientModel(int client, const char[] model, bool UseClassAnimations)	{
	if(Tklib_IsValidClient(client, _, true))	{
		SetVariantString(model);
		AcceptEntityInput(client, "SetCustomModel");
		TF2_SetClassAnimations(client, UseClassAnimations);
		return true;
	}
	
	return	false;
}

/**
 *	Removes a weapon from the users specified weapon slot.
 *	Use this over TF2_RemoveWeaponSlot.
 *
 *	@param	client		The users index.
 *	@param	slot		The weapon slot to target.
 *
 *	@error	If the procedure failed, this returns false.
 */
stock bool TF2_RemovePlayerWeaponSlot(int client, TFSlot slot) {
	if(Tklib_IsValidClient(client, _, true)) {
		int weapon = -1;
		if((weapon = GetPlayerWeaponSlot(client, view_as<int>(slot))) != -1) {
			RemovePlayerItem(client, weapon);
			RemoveEdict(weapon);
			return true;
		}
	}
	
	return false;
}

/**
 *	Returns if the entity is a building.
 *
 *	@param	entity	The building entity index.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool TF2_IsEntityBuilding(int building) { return GetEntPropBool(building, Prop_Send, "m_bBuilding"); }

/**
 *	Returns if the entity is a mini-building.
 *
 *	@param	entity	The building entity index.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool TF2_IsEntityMiniBuilding(int building) { return GetEntPropBool(building, Prop_Send, "m_bMiniBuilding"); }

/**
 *	Returns the buildings builder.
 *	Otherwise use GetEntityOwner.
 *
 *	@param	entity	The building entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock bool TF2_SetBuildingOwner(int building, int client) { return SetEntPropEntEx(building, Prop_Send, "m_hBuilder", client); }

/**
 *	Returns the buildings builder.
 *	Otherwise use GetEntityOwner.
 *
 *	@param	entity	The building entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock int TF2_GetBuildingOwner(int building) { return GetEntPropEntEx(building, Prop_Send, "m_hBuilder"); }

/**
 *	Set the buildings upgrade level.
 *
 *	@param	entity	The building entity index.
 *	@param	level	The level to set.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool TF2_SetBuildingLevel(int entity, int level=1) { return SetEntPropEx(entity, Prop_Send, "m_iUpgradeLevel", level); }

/**
 *	Returns the buildings upgrade level.
 *
 *	@param	entity	The building entity index.
 *	@error	If the entity is invalid, this returns -1.
 */
stock int TF2_GetBuildingLevel(int entity) { return GetEntPropEx(entity, Prop_Send, "m_iUpgradeLevel"); }

/**
 *	Set the buildings max upgrade level.
 *
 *	@param	entity	The building entity index.
 *	@param	level	The maximum upgrade level to set.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool TF2_SetBuildingMaxLevel(any entity, int level=3)	{ return SetEntPropEx(entity, Prop_Send, "m_iHighestUpgradeLevel", level); }

/**
 *	Returns the buildings max upgrade level.
 *
 *	@param	entity	The building entity index.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock int TF2_GetBuildingMaxLevel(any entity) { return GetEntPropEx(entity, Prop_Send, "m_iHighestUpgradeLevel"); }

/**
 *	Set the buildings required metal to upgrade to next upgrade level.
 *
 *	@param	building	The building entity index.
 *	@param	metal		The metal required.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingMetalRequired(any building, int metal) { return SetEntPropEx(building, Prop_Send, "m_iUpgradeMetalRequired", metal); }

/**
 *	Returns the buildings required metal to upgrade to next upgrade level.
 *
 *	@param	building	The building entity index.
 *
 *	@error	If the building is invalid, this returns -1.
 */
stock int TF2_GetBuildingMetalRequired(any building) { return GetEntPropEx(building, Prop_Send, "m_iUpgradeMetalRequired"); }

/**
 *	Destroys the building.
 *
 *	@param	building The building entity index.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_DestroyBuilding(any building) {
	if(HasEntPropEx(building, Prop_Send, "m_hBuilder"))	{
		SetVariantInt(999999);
		AcceptEntityInput(building, "RemoveHealth");
		return true;
	}
	
	return	false;
}

/**
 *	Returns the percentage of the building constructed.
 *
 *	@param	building The building entity index.
 *
 *	@error	If the building is invalid, this returns -1.0.
 */
stock float TF2_GetBuildingConstructionPercentage(int building) { return GetEntPropFloatEx(building, Prop_Send, "m_flPercentageConstructed"); }

/**
 *	Set the percentage of the building contructed.
 *
 *	@param	building	The building entity index.
 *	@param	percentage	The percentage to set. 0-100.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingConstructionPercentage(int building, float percentage) { return SetEntPropFloatEx(building, Prop_Send, "m_flPercentageConstructed", percentage); }

/**
 *	Returns the entity the building was built on.
 *
 *	@param	building The building entity index.
 *
 *	@error	If the building is invalid, this returns -1.
 */
stock int TF2_GetBuildingEntityBuiltOn(int building) { return GetEntPropEntEx(building, Prop_Send, "m_hBuiltOnEntity"); }

/**
 *	Set the entity building should be seen as built on.
 *
 *	@param	building	The building entity index.
 *	@param	entity		The entity to be seen as built on.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingEntityBuiltOn(int building, int entity) { return SetEntPropEntEx(building, Prop_Send, "m_hBuiltOnEntity", entity); }

/**
 *	Returns the building object flags.
 *
 *	@param	building The building entity index.
 *
 *	@error	If the building is invalid, this returns -1.
 */
stock int TF2_GetBuildingObjectFlags(int building) { return GetEntPropEx(building, Prop_Send, "m_fObjectFlags"); }

/**
 *	Set the building object flags.
 *
 *	@param	building	The building entity index.
 *	@param	objectflags	The object flags to modify/set.
 *
 *	@error	If the building is invalid, this returns -1.
 */
stock bool TF2_SetBuildingObjectFlags(int building, int objectflags) { return SetEntPropEx(building, Prop_Send, "m_fObjectFlags", objectflags); }

/**
 *	Returns if the building is a mini building.
 *
 *	@param	building	The building entity index.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_IsMiniBuilding(int building)	{ return GetEntPropBool(building, Prop_Send, "m_bMiniBuilding"); }

/**
 *	Set the building to be seen as mini variant.
 *
 *	@param	building	The building entity index.
 *	@param	mini		If true, sets building as 'mini'. Else if false, it's set as 'normal'.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetMiniBuilding(int building, bool mini) { return SetEntPropEx(building, Prop_Send, "m_bMiniBuilding", mini); }

/**
 *	Set the building default upgrade value.
 *
 *	@param	building	The building entity index.
 *	@param	upgrade		The upgrade value.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingDefaultUpgrade(int building, int upgrade=1)	{
	if(!HasEntPropEx(building, Prop_Send, "m_iUpgradeLevel"))
		return false;
	
	char[] val = new char[16];
	Format(val, 16, "%i", upgrade);
	DispatchKeyValue(building, "defaultupgrade", val);
	return true;
}

/**
 *	Returns if the builing has a sapper.
 *
 *	@param	building	The building entity index.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_BuildingHasSapper(int building) { return GetEntPropBool(building, Prop_Send, "m_bHasSapper"); }

/**
 *	Set the building to have a sapper active.
 *
 *	@param	building	The building entity index.
 *	@param	sapper		If true, building will be seen as having a sapper.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingSapper(int building, bool sapper) { return SetEntPropEx(building, Prop_Send, "m_bHasSapper", sapper); }

/**
 *	Set the building object mode.
 *
 *	@param	building	The building entity index.
 *	@param	objectmode	The building TFObject mode.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetObjectMode(int building, TFObjectMode objectmode) { return view_as<bool>(SetEntPropEx(building, Prop_Send, "m_iObjectMode", objectmode) && SetEntPropEx(building, Prop_Send, "m_iTeleportType", objectmode)); }

/**
 *	Returns the building entity by type.
 *	Creates a building entity by type.
 *
 *	@param	type	The building type.
 *
 *	@error	If the entity is invalid, this returns -1.
 */
stock int TF2_CreateBuildingByType(TFBuilding type)	{
	int building = -1;
	
	switch(type)	{
		case TFBuilding_Invalid: return -1;
		case TFBuilding_Sentrygun: {
			building = CreateEntityByName("obj_sentrygun");
			SetEntPropVectorEx(building, Prop_Send, "m_vecMins", view_as<float>({-13.0, -13.0, 0.0}));
			SetEntPropVectorEx(building, Prop_Send, "m_vecMaxs", view_as<float>({13.0, 13.0, 42.9}));
		}
		case TFBuilding_Dispenser: building = CreateEntityByName("obj_dispenser");
		case TFBuilding_Teleporter_Entrance: {
			building = CreateEntityByName("obj_teleporter");
			SetEntPropEx(building, Prop_Send, "m_iObjectMode", 0);
		}
		case TFBuilding_Teleporter_Exit: {
			building = CreateEntityByName("obj_teleporter");
			SetEntPropEx(building, Prop_Send, "m_iObjectMode", 1);
		}
		case TFBuilding_MiniSentry: {
			building = CreateEntityByName("obj_sentrygun");
			SetEntityModelScale(building, 0.75);
			TF2_SetMiniBuilding(building, true);
			SetEntPropVectorEx(building, Prop_Send, "m_vecMins", view_as<float>({-15.0, -15.0, 0.0}));
			SetEntPropVectorEx(building, Prop_Send, "m_vecMaxs", view_as<float>({15.0, 15.0, 42.5}));
		}
	}
	
	TF2_SetBuildingActive(building, true);
	return building;
}

/**
 *	Returns if the building is disposable.
 *
 *	@param	building	The building entity index.
 *
 *	@error	If the building entity is invalid, returns false.
 */
stock bool TF2_IsBuildingDisposable(int building) { return GetEntPropBool(building, Prop_Send, "m_bDisposableBuilding"); }

/**
 *	Set the builing to be disposable.
 *
 *	@param	building	The building entity index.
 *	@param	disposable	If true, the building will be disposable.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingDisposable(int building, bool disposable) { return SetEntPropEx(building, Prop_Send, "m_bDisposableBuilding", disposable); }

/**
 *	Returns if the building was map placed.
 *
 *	@param	building	The building entity index.
 *
 *	@error	If the building entity is invalid, returns false.
 */
stock bool TF2_IsBuildingMapPlaced(int building) { return GetEntPropBool(building, Prop_Send, "m_bWasMapPlaced"); }

/**
 *	Set the builing to be seen as map placed.
 *
 *	@param	building	The building entity index.
 *	@param	map_placed	If true, the building will be seen as map placed.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingMapPlaced(int building, bool map_placed) { return SetEntPropEx(building, Prop_Send, "m_bWasMapPlaced", map_placed); }

/**
 *	Returns if the building is being placed.
 *
 *	@param	building	The building entity index.
 *
 *	@error	If the building entity is invalid, returns false.
 */
stock bool TF2_IsBuildingBeingPlaced(int building) { return GetEntPropBool(building, Prop_Send, "m_bPlacing"); }

/**
 *	Set the builing to be seen as map placed.
 *
 *	@param	building	The building entity index.
 *	@param	placing		If true, the building will be seen as being placed.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingBeingPlaced(int building, bool placing) { return SetEntPropEx(building, Prop_Send, "m_bPlacing", placing); }

/**
 *	Returns if the building is being carried.
 *
 *	@param	building	The building entity index.
 *
 *	@error	If the building entity is invalid, returns false.
 */
stock bool TF2_IsBuildingBeingCarried(int building)	{ return GetEntPropBool(building, Prop_Send, "m_bCarried"); }

/**
 *	Set the builing to be seen as being carried.
 *
 *	@param	building	The building entity index.
 *	@param	placing		If true, the building will be seen as being carried.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingBeingCarried(int building, bool carried) { return SetEntPropEx(building, Prop_Send, "m_bCarried", carried); }

/**
 *	Returns if the building is being carried and deployed.
 *
 *	@param	building	The building entity index.
 *
 *	@error	If the building entity is invalid, returns false.
 */
stock bool TF2_IsBuildingBeingCarriedDeploy(int building) { return GetEntPropBool(building, Prop_Send, "m_bCarryDeploy"); }

/**
 *	Set the builing to be seen as being carried and deployed.
 *
 *	@param	building	The building entity index.
 *	@param	deployed	If true, the building will be seen as being carried and deloyed.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_SetBuildingBeingCarriedDeploy(int building, bool deployed) { return SetEntPropEx(building, Prop_Send, "m_bCarryDeploy", deployed); }

/**
 *	Returns if the building is active.
 *
 *	@param	building	The building entity index.
 *
 *	@error	If the building is invalid, this returns false.
 */
stock bool TF2_IsBuildingActive(int building) { return GetEntPropBool(building, Prop_Send, "m_bBuilding"); }

/**
 *	Set the building to be active.
 *
 *	@param	building	The building entity index.
 *	@param	active		If true, the building will be active.
 *
 *	@error	If the building is invalid, this reutrns false.
 */
stock bool TF2_SetBuildingActive(int building, bool active)	{ return SetEntPropEx(building, Prop_Send, "m_bBuilding", active); }

#if !defined _tklib_no_sdktools
/**
 *	Returns if MvM (Mann-Vs-Machine) mode is active.
 */
stock bool TF2_IsMvMGameMode() { return view_as<bool>(GameRules_GetProp("m_bPlayingMannVsMachine")); }
#endif

/**
 *	Returns a random TFTeam team (Red or Blue) (Including Green or Yellow if TF2 Classic)
 *
 *	@return	Returns a TFTeam team.
 */
#if !defined _tklib_disable_gameidentifier
stock TFTeam TF2_GetRandomTeam() { return view_as<TFTeam>(IsCurrentGame(Game_TF2C) ? GetRandomInt(2, 5) : GetRandomInt(2, 3)); }
#endif

/**
 *	Returns the gametype of the server.
 */
stock TFGameType TF2_GetGameType() { return TFGameType(GameRules_GetProp("m_nGameType")); }

/**
 *	Set the gametype of the server.
 *
 *	@param	gametype	TFGameType gametype to set.
 */
stock void TF2_SetGameType(TFGameType gametype) { GameRules_SetProp("m_nGameType", gametype); }

/**
 *	Returns if Waiting For Players phase is active.
 */
stock bool TF2_IsWaitingForPlayers() { return view_as<bool>(GameRules_GetProp("m_bInWaitingForPlayers")); }

/**
 *	Set the Waiting For Players phase.
 *
 *	@param	value	If true, this forces waiting for players phase to be active.
 */
stock void TF2_SetWarmupForPlayers(bool value) { GameRules_SetProp("m_bInWaitingForPlayers", value); }

/**
 *	Returns if Powerup Mode is active.
 */
stock bool TF2_IsPowerupMode() { return view_as<bool>(GameRules_GetProp("m_bPowerupMode")); }

/**
 *	Set the Powerup Mode.
 *
 *	@param	value	If true, this forces Powerup Mode to be active.
 */
stock void TF2_SetPowerupMode(bool value) { GameRules_SetProp("m_bPowerupMode", value); }

/**
 *	Returns if Truce is active.
 */
stock bool TF2_IsTruceActive() { return view_as<bool>(GameRules_GetProp("m_bTruceActive")); }

/**
 *	Set the Truce.
 *
 *	@param	value	If true, this forces Truce to be active.
 */
stock void TF2_SetTruce(bool value)	{ GameRules_SetProp("m_bTruceActive", value); }

/**
 *	Get users airdash count.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this returns -1.
 */
stock int TF2_GetClientAirDash(any client) { return GetEntPropEx(client, Prop_Send, "m_iAirDash"); }

/**
 *	Set users airdash count.
 *
 *	@param	client	The users index.
 *	@param	value	The value to set.
 *
 *	@error	If the user is invalid or has no m_iAirDash property, this returns false.
 */
stock bool TF2_SetClientAirDash(int client, int value) { return SetEntPropEx(client, Prop_Send, "m_iAirDash", value); }

/**
 *	Returns if TF2Attributes is available.
 */
stock bool IsTF2AttributesLoaded() { return LibraryExists("tf2attributes"); }

/**
 *	Returns if TF2Econ Data is available.
 */
stock bool IsTF2EconDataLoaded() { return LibraryExists("tf_econ_data"); }

/**
 *	Returns the Footprint name type.
 *
 *	@param	index	The footprint index.
 *	@param	type	The buffer to store the name.
 *	@param	maxlen	The maximum length of the buffer.
 *
 *	@noreturn.
 */
stock void TF2_GetFootprintName(int defindex, char[] type, int maxlen) {
	switch(defindex) {
		case 1: strcopy(type, maxlen, "Team Based");
		case 2: strcopy(type, maxlen, "Purple");
		case 3: strcopy(type, maxlen, "4 8 15 16 23 42");
		case 7777: strcopy(type, maxlen, "Blue");
		case 83552: strcopy(type, maxlen, "Ghost in the Machine");
		case 300000: strcopy(type, maxlen, "Satan's Blue");
		case 933333: strcopy(type, maxlen, "Light Blue");
		case 3100495: strcopy(type, maxlen, "Dark Green");
		case 4552221: strcopy(type, maxlen, "Corrupted Green");
		case 5322826: strcopy(type, maxlen, "Brown");
		case 8208497: strcopy(type, maxlen, "Cream");
		case 8355220: strcopy(type, maxlen, "Oak Tree Brown");
		case 8421376: strcopy(type, maxlen, "Yellow");
		case 13595446: strcopy(type, maxlen, "Flames");
		case 41234123: strcopy(type, maxlen, "Pink");
		case 51234123: strcopy(type, maxlen, "Lime");
	}
}

/**
 *	Attach an effect particle onto an entity.
 *
 *	@param	entity			The entity index to target.
 *	@param	particle_name	Particle name to set.
 *	@param	offset			Offset by Z-Angle.
 *
 *	@return	Returns the particle entity.
 */
stock int TF2_AttachParticle(any entity, const char[] particle_name, float offset=0.0)	{
	int particle = CreateEntityByName("info_particle_system");
	if(!IsValidEntityEx(particle))
		return -1;
	
	float pos[3];
	GetEntityAbsOrigin(entity, pos);
	pos[2] += offset;
	
	TeleportEntity(particle, pos, NULL_VECTOR, NULL_VECTOR);
	DispatchKeyValue(particle, "effect_name", particle_name);
	DispatchSpawn(particle);
	SetVariantString("!activator");
	AcceptEntityInput(particle, "SetParent", entity);
	ActivateEntity(particle);
	AcceptEntityInput(particle, "start");
	
	return particle;
}

#if defined __tf_econ_data_included
/**
 *	Spawns an item.
 *	The item spawned are visible to everyone.
 *	Requires TF2Econ Data plugin.
 *	TF2Attributes for golden frying pan to be corrected.
 *
 *	@param	client		The users index.
 *	@param	defindex	The item definition index.
 *	@param	quality		The item quality.
 *	@param	level		The item level. Level -1 results in random level.
 *	@param	style		The item style index. Example style 0 is "No Glasses".
 *	@param	effect		The item unusual effect.
 *	@param	remwep		If true, if valid weapon, weapon equipped in the same slot as the item given is destroyed.
 *	@param	debug		If true, prints a debug message in server console.
 *
 *	@return	Returns the item entity index. If invalid user or entity is invalid returns -1.
 */
stock int TF2_GiveItem(int client,
						int defindex,
						TFQuality quality=TFQuality_Unique,
						int level=-1,
						int style=0,
						int effect=0,
						bool remwep=true,
						bool dbg=false) {
	char classname[128];
	TF2Econ_GetItemClassName(defindex, classname, sizeof(classname));
	TF2Econ_TranslateWeaponEntForClass(classname, sizeof(classname), TF2_GetPlayerClass(client));
	if(StrEqual(classname, "no_entity")) classname = "tf_wearable_vm";
	
	if(dbg) PrintToServer("[Tklib:TF2] TF2_GiveItem(client %i, defindex %i, classname '%s', quality %i, level %i, style %i, effect %i, remwep %s)",
	client, defindex, classname, quality, level, style, effect, OnOff[remwep]);
	
	Entity item = new Entity(classname);
	if(!item.Valid()) return -1;
	
	/* Credits to PC Gamer for most of the code. */
	if(Tklib_IsValidClient(client, _, true)) {
		item.Owner = client;
		item.SteamAccountID = GetSteamAccountID(client);
		item.DefinitionIndex = defindex;
		item.Initialized = true;
		item.TF2Level = (level == -1) ? GetRandomInt(0, 100) : level;
		item.TF2Quality = quality;
		item.TF2Validated = true;
		
		switch(defindex) {
			case 735,736,810,831,933,1080,1102: {
				item.SetProp(Prop_Send, "m_iObjectType", 3);
				item.SetProp(Prop_Data, "m_iSubType", 3);
				item.SetProp(Prop_Send, "m_aBuildableObjectTypes", 0, _, 0);
				item.SetProp(Prop_Send, "m_aBuildableObjectTypes", 0, _, 1);
				item.SetProp(Prop_Send, "m_aBuildableObjectTypes", 0, _, 2);
				item.SetProp(Prop_Send, "m_aBuildableObjectTypes", 1, _, 3);
			}
			case 998: item.SetDataOffset("m_nChargeResistType", GetRandomInt(0,2));
			#if defined _tf2attributes_included
			case 1071: {
				TF2Attrib_SetByName(view_as<int>(item), "item style override", 0.0);
				TF2Attrib_SetByName(view_as<int>(item), "loot rarity", 1.0);
				TF2Attrib_SetByName(view_as<int>(item), "turn to gold", 1.0);
			}
			#endif
		}
		
		#if defined _tf2attributes_included
		if(style >= 0) TF2Attrib_SetByName(view_as<int>(item), "item style override", IntToFloat(style));
		if(effect > 0) TF2Attrib_SetByName(view_as<int>(item), "attach particle effect", IntToFloat(effect));
		#endif
		
		item.Spawn();
		
		if(remwep) {
			TFSlot slot = view_as<TFSlot>(TF2Econ_GetItemDefaultLoadoutSlot(defindex));
			if(slot >= TFSlot_Primary) TF2_RemovePlayerWeaponSlot(client, slot);
		}
		
		switch(StrContainsEx(classname, "tf_wearable", false)) {
			case true: item.TF2EquipCosmetic(client);
			default: item.EquipWeapon(client);
		}
		
		switch(defindex) {
			case 237, 265: {
				int ammoType = item.GetProp(Prop_Send, "m_iPrimaryAmmoType");	
				if(ammoType != -1) {
					int amount = 0;
					
					switch(defindex) {
						case 237: amount = 60;
						case 265: amount = 72;
					}
					view_as<Entity>(client).SetProp(Prop_Send, "m_iAmmo", amount, 4, ammoType);				
				}
			}
		}
	}
	
	return view_as<int>(item);
}

/**
 *	Spawns an item via customized classname.
 *	The items spawned are visible to everyone.
 *	Requires TF2Econ Data plugin.
 *	TF2Attributes to set style, effect and for the golden frying pan to be corrected.
 *
 *	@param	client		The users index.
 *	@param	classname	The item classname.
 *	@param	defindex	The item definition index.
 *	@param	quality		The item quality.
 *	@param	level		The item level. Level -1 results in random level.
 *	@param	style		The item style index. Example style 0 is "No Glasses".
 *	@param	effect		The item unusual effect.
 *	@param	remwep		If true, if valid weapon, weapon equipped in the same slot as the item given is destroyed.
 *	@param	debug		If true, prints a debug message in server console.
 *
 *	@return	Returns the item entity index. If invalid user or entity is invalid returns -1.
 */
stock int TF2_GiveItemEx(int client,
						const char[] classname,
						int defindex,
						TFQuality quality=TFQuality_Unique,
						int level=-1,
						int style=0,
						int effect=0,
						bool remwep=true,
						bool dbg=false)	{
	if(dbg) PrintToServer("[Tklib:TF2] TF2_GiveItemEx(client %i, classname '%s', defindex %i, quality %i, level %i, style %i, effect %i, remwep %s)",
	client, classname, defindex, quality, level, style, effect, OnOff[remwep]);
	
	Entity item = new Entity(classname);
	if(!item.Valid()) return -1;
	
	/* Credits to PC Gamer for most of the code. */
	if(Tklib_IsValidClient(client, _, true)) {
		item.Owner = client;
		item.SteamAccountID = GetSteamAccountID(client);
		item.DefinitionIndex = defindex);
		item.Initialized = true;
		item.TF2Validated = true;
		item.TF2Level = (level == -1) ? GetRandomInt(0, 100) : 100;
		item.TF2Quality = quality;
		
		switch(defindex) {
			case 735,736,810,831,933,1080,1102: {
				item.SetProp(Prop_Send, "m_iObjectType", 3);
				item.SetProp(Prop_Data, "m_iSubType", 3);
				item.SetProp(Prop_Send, "m_aBuildableObjectTypes", 0, _, 0);
				item.SetProp(Prop_Send, "m_aBuildableObjectTypes", 0, _, 1);
				item.SetProp(Prop_Send, "m_aBuildableObjectTypes", 0, _, 2);
				item.SetProp(Prop_Send, "m_aBuildableObjectTypes", 1, _, 3);
			}
			case 998: item.SetDataOffset("m_nChargeResistType", GetRandomInt(0,2));
			#if defined _tf2attributes_included
			case 1071: {
				TF2Attrib_SetByName(view_as<int>(item), "item style override", 0.0);
				TF2Attrib_SetByName(view_as<int>(item), "loot rarity", 1.0);
				TF2Attrib_SetByName(view_as<int>(item), "turn to gold", 1.0);
			}
			#endif
		}
		
		#if defined _tf2attributes_included
		if(style >= 0) TF2Attrib_SetByName(view_as<int>(item), "item style override", IntToFloat(style));
		if(effect > 0) TF2Attrib_SetByName(view_as<int>(item), "attach particle effect", IntToFloat(effect));
		#endif
		
		item.Spawn();
		
		if(remwep) {
			TFSlot slot = view_as<TFSlot>(TF2Econ_GetItemDefaultLoadoutSlot(defindex));
			if(slot >= TFSlot_Primary) TF2_RemovePlayerWeaponSlot(client, slot);
		}
		
		switch(StrContainsEx(classname, "tf_wearable", false)) {
			case true: item.TF2EquipCosmetic(client);
			default: item.EquipWeapon(client);
		}
		
		switch(defindex) {
			case 237, 265: {
				int ammoType = item.GetProp(Prop_Send, "m_iPrimaryAmmoType");
				if(ammoType != -1) {
					int amount = 0;
					
					switch(defindex) {
						case 237: amount = 60;
						case 265: amount = 72;
					}
					
					view_as<Entity>(client).SetProp(Prop_Send, "m_iAmmo", amount, 4, ammoType);
				}
			}
		}
	}
	
	return view_as<int>(item);
}
#endif

/**
 *	Strips all cosmetics from the user.
 *
 *	@param	client		The users index.
 *	@param	defindex	If greather than -1 and valid, only strips out
 *						the cosmetics with matching definition index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool TF2_StripCosmetics(int client, int defindex=-1)	{
	if(!Tklib_IsValidClient(client, _, true)) return false;
	
	int cosmetic = 0;
		
	while((cosmetic = FindEntityByClassname(cosmetic, "tf_wearable")) != -1)	{
		if(IsValidEntityEx(cosmetic))	{
			if(GetEntityOwner(cosmetic) == client && GetEntityDefinitionIndex(cosmetic) == cosmetic)
				AcceptEntityInput(cosmetic, "Kill");
		}
	}
	
	return true;
}

/**
 *	Strips all levelable cosmetics from the user.
 *
 *	@param	client		The users index.
 *	@param	defindex	If greather than -1 and valid, only strips out
 *						the cosmetics with matching definition index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool TF2_StripCosmeticsLevelable(int client, int defindex=-1) {
	if(!Tklib_IsValidClient(client, _, true))
		return false;
	
	int cosmetic = 0;
		
	while((cosmetic = FindEntityByClassname(cosmetic, "tf_wearable_levelable_item")) != -1) {
		if(IsValidEntityEx(cosmetic)) {
			if(GetEntityOwner(cosmetic) == client && GetEntityDefinitionIndex(cosmetic) == cosmetic)
				AcceptEntityInput(cosmetic, "Kill");
		}
	}
	
	return true;
}

/**
 *	Returns wheter the definition index has an australium variant available.
 *
 *	@param	defindex	The weapon definition index.
 */
stock bool TF2_IsValidAustralium(int defindex) { for(int i = 0; i < sizeof(TF2_Australiums); i++) { if(TF2_Australiums[i] == defindex) return true; } return false; }

/**
 *	Turns the weapon into australium variant.
 *	Requires TF2Attributes to set the attributes.
 *
 *	@param	weapon	The weapon entity index.
 *
 *	@noreturn.
 */
stock void TF2_TurnAustralium(any weapon) {
	if(!IsValidEntityEx(weapon)) return;
	if(!IsTF2AttributesLoaded()) return;
	
	int defindex = GetEntityDefinitionIndex(weapon);
	if(!TF2_IsValidAustralium(defindex)) return;
	
	/* Force the stock weapons to be 'upgradable' version. */
	TF2_TurnDefaultDefIndexToUpgraded(weapon);
	
	/* Turn the weapon to strange quality and random level. */
	SetEntDataOffset(weapon, "m_iEntityQuality", TFQuality_Strange); /* Strange. */
	SetEntDataOffset(weapon, "m_iEntityLevel", GetRandomInt(0, 100)); /* Random level between 0 and 100. */
	
	/* Frying Pan. */
	switch(defindex == 264)	{
		case true: {
			SetEntDataOffset(weapon, "m_iItemDefinitionIndex", 1071); /* Turn to golden frying pan. */
			#if defined _tf2attributes_included
			TF2Attrib_SetByDefIndex(weapon, 150, 1.0);
			TF2Attrib_SetByDefIndex(weapon, 2025, 1.0);
			TF2Attrib_SetByDefIndex(weapon, 2013, view_as<float>(GetRandomInt(2002, 2008)));
			TF2Attrib_SetByDefIndex(weapon, 2014, view_as<float>(GetRandomInt(1, 7)));
			TF2Attrib_SetByDefIndex(weapon, 542, 0.0);
			#endif
		}
		/* Turn the weapon to australium. */
		case false: {
			#if defined _tf2attributes_included
			TF2Attrib_SetByDefIndex(weapon, 542, 1.0);
			#endif
		}
	}
	
	#if defined _tf2attributes_included
	TF2Attrib_SetByDefIndex(weapon, 2027, 1.0);
	TF2Attrib_SetByDefIndex(weapon, 3018, 1.0);
	#endif
}

/**
 *	Returns the killstreaker effect name.
 *
 *	@param	index	The effect index.
 *	@param	buffer	Buffer to store the killstreaker name.
 *	@param	maxlen	Maximum length of the buffer.
 *
 *	@noreturn. 
 */
stock void TF2_GetKillstreakerName(int index, char[] buffer, int maxlen) {
	switch(index) {
		case 2002: strcopy(buffer, maxlen, "Fire Horns");
		case 2003: strcopy(buffer, maxlen, "Cerebral Discharge");
		case 2004: strcopy(buffer, maxlen, "Tornado");
		case 2005: strcopy(buffer, maxlen, "Flames");
		case 2006: strcopy(buffer, maxlen, "Singularity");
		case 2007: strcopy(buffer, maxlen, "Incinerator");
		case 2008: strcopy(buffer, maxlen, "Hypno-Beam");
		default: strcopy(buffer, maxlen, "None"); /* Invalid. */
	}
}

#if defined _tf2attributes_included
/**
 *	Returns an attribute's value of an entity.
 *	Requires TF2Attributes.
 *
 *	@param	entity		Entity index to get the attribute from. Must have m_AttributeList.
 *	@param	defindex	Definition index of the attribute, as from the number on the attribute entry in items_game.
 *
 *	@return				True if the attribute was added successfully, false if entity does not have m_AttributeList.
 *
 *	@error				Invalid entity index or attribute name will return -1.0.
 */
stock float TF2Attrib_GetByDefIndexEx(any entity, int defindex) {
	if(!IsValidEntityEx(entity)) return -1.0;
	
	int indice[16];
	float value[16];
	
	for(int i = 0; i < TF2Attrib_GetSOCAttribs(entity, indice, value); i++) {
		if(indice[i] == defindex) return value[i];
	}
	
	return -1.0;
}
#endif

/**
 *	Forces the default weapon definition index
 *	to be turned into the 'upgraded' one.
 *
 *	@param	weapon	The weapon entity index.
 *
 *	@error	If the weapon entity or offset is invalid, this returns false.
 */
stock bool TF2_TurnDefaultDefIndexToUpgraded(any weapon) {
	// Fix the default weapons to be forced as an 'upgraded' variant so they can be festivized variant, be australium, have war paint, etc.
	if(!IsValidEntityEx(weapon)) return false;
	
	char netclass[64];
	GetEntityNetClass(weapon, netclass, sizeof(netclass));
	
	int offset = FindSendPropInfo(netclass, "m_iItemDefinitionIndex");
	if(offset < 1) return false;
	
	switch(GetEntData(weapon, offset)) {
		case 0: SetEntData(weapon, offset, 190);
		case 1: SetEntData(weapon, offset, 191);
		case 2: SetEntData(weapon, offset, 192);
		case 3: SetEntData(weapon, offset, 193);
		case 4: SetEntData(weapon, offset, 194);
		case 5: SetEntData(weapon, offset, 195);
		case 6: SetEntData(weapon, offset, 196);
		case 7: SetEntData(weapon, offset, 197);
		case 8: SetEntData(weapon, offset, 198);
		case 9: SetEntData(weapon, offset, 199);
		case 10: SetEntData(weapon, offset, 199);
		case 11: SetEntData(weapon, offset, 199);
		case 12: SetEntData(weapon, offset, 199);
		case 13: SetEntData(weapon, offset, 200);
		case 14: SetEntData(weapon, offset, 201);
		case 15: SetEntData(weapon, offset, 202);
		case 16: SetEntData(weapon, offset, 203);
		case 17: SetEntData(weapon, offset, 204);
		case 18: SetEntData(weapon, offset, 205);
		case 19: SetEntData(weapon, offset, 206);
		case 20: SetEntData(weapon, offset, 207);
		case 21: SetEntData(weapon, offset, 208);
		case 22: SetEntData(weapon, offset, 209);
		case 23: SetEntData(weapon, offset, 209);
		case 24: SetEntData(weapon, offset, 210);
		case 25: SetEntData(weapon, offset, 737);
		case 29: SetEntData(weapon, offset, 211);
		case 30: SetEntData(weapon, offset, 212);
		case 735: SetEntData(weapon, offset, 736);
	}
	
	return true;
}

/**
 *	Returns wheter the warpaint definition index is valid.
 *
 *	@param	defindex	The warpaint definition index.
 *
 *	@return	If the warpaint is valid, this returns true. False otherwise.
 */
stock bool TF2_IsValidWarPaint(int defindex) { for(int i = MAX_TF2_WARPAINTS; i--;) { if(TF2_Warpaints[i] == defindex) return true; } return false; }

/**
 *	Returns the warpaint name.
 *
 *	@param	defindex	The warpaint definition index.
 *	@param	buffer		The warpaint name.
 *	@param	maxlen		The warpaint name maximum length.
 *
 *	@noreturn.
 */
stock void TF2_GetWarPaintName(int defindex, char[] buffer, int maxlen) {
	switch(defindex) {
		//First wave of warpaints, by default weapon-locked.
		//================================================//
		// Concealed Killer Collection.
		//================================================//
		case 0: strcopy(buffer, maxlen, "Redrock Roscoe");
		case 1: strcopy(buffer, maxlen, "Sand Cannon");
		case 2: strcopy(buffer, maxlen, "Wrapped Reviver");
		case 3: strcopy(buffer, maxlen, "Psychedelic Slugger");
		case 4: strcopy(buffer, maxlen, "Carpet Bomber");
		case 5: strcopy(buffer, maxlen, "Masked Mender");
		case 6: strcopy(buffer, maxlen, "Woodland Warrior");
		case 7: strcopy(buffer, maxlen, "Purple Range");
		case 8: strcopy(buffer, maxlen, "Sudden Flurry");
		case 9: strcopy(buffer, maxlen, "Forest Fire");
		case 10: strcopy(buffer, maxlen, "King Of The Jungle");
		case 11: strcopy(buffer, maxlen, "Night Terror");
		case 12: strcopy(buffer, maxlen, "Backwoods Boomstick");
		case 13: strcopy(buffer, maxlen, "Woodsy Widowmaker");
		case 14: strcopy(buffer, maxlen, "Night Owl");
		//================================================//
		// Craftsmann Collection.
		//================================================//
		case 15: strcopy(buffer, maxlen, "Tartan Torpedo");
		case 16: strcopy(buffer, maxlen, "Rustic Ruiner");
		case 17: strcopy(buffer, maxlen, "Barn Burner"); //Fun fact: "barn" means "kid" or "kids" in swedish.
		case 18: strcopy(buffer, maxlen, "Homemade Heater");
		case 19: strcopy(buffer, maxlen, "Lumber From Down Under");
		case 20: strcopy(buffer, maxlen, "Iron Wood");
		case 21: strcopy(buffer, maxlen, "Country Crusher");
		case 22: strcopy(buffer, maxlen, "Plaid Potshotter");
		case 23: strcopy(buffer, maxlen, "Shot In The Dark");
		case 24: strcopy(buffer, maxlen, "Blasted Bombardier");
		case 25: strcopy(buffer, maxlen, "Reclaimed Reanimator");
		case 26: strcopy(buffer, maxlen, "Antique Annihilator");
		case 27: strcopy(buffer, maxlen, "Old Country");
		case 28: strcopy(buffer, maxlen, "American Pastoral");
		case 29: strcopy(buffer, maxlen, "Backcountry Blaster");
		//================================================//
		// Teufort Collection.
		//================================================//
		case 30: strcopy(buffer, maxlen, "Bovine Blazemaker");
		case 31: strcopy(buffer, maxlen, "War Room");
		case 32: strcopy(buffer, maxlen, "Treadplate Tormenter");
		case 33: strcopy(buffer, maxlen, "Bogtrotter");
		case 34: strcopy(buffer, maxlen, "Earth, Sky and Fire");
		case 35: strcopy(buffer, maxlen, "Hickory Hole Puncher");
		case 36: strcopy(buffer, maxlen, "Spruced Duce");
		case 37: strcopy(buffer, maxlen, "Team Sprayer");
		case 38: strcopy(buffer, maxlen, "Rooftop Wrangler");
		case 39: strcopy(buffer, maxlen, "Civil Servant");
		case 40: strcopy(buffer, maxlen, "Citizen Pain");
		case 41: strcopy(buffer, maxlen, "Local Hero");
		case 42: strcopy(buffer, maxlen, "Mayor");
		case 43: strcopy(buffer, maxlen, "Smalltown Bringdown");
		case 44: strcopy(buffer, maxlen, "Civic Duty");
		//================================================//
		// Powerhouse Collection.
		//================================================//
		case 45: strcopy(buffer, maxlen, "Liquid Asset");
		case 46: strcopy(buffer, maxlen, "Black Dahlia");
		case 47: strcopy(buffer, maxlen, "Lightning Rod");
		case 48: strcopy(buffer, maxlen, "Pink Elephant");
		case 49: strcopy(buffer, maxlen, "Flash Dryer");
		case 50: strcopy(buffer, maxlen, "Spark Of Life");
		case 51: strcopy(buffer, maxlen, "Dead Reckoner");
		case 52: strcopy(buffer, maxlen, "Shell Shocker");
		case 53: strcopy(buffer, maxlen, "Current Event");
		case 54: strcopy(buffer, maxlen, "Turbine Torcher");
		case 55: strcopy(buffer, maxlen, "Brick House");
		case 56: strcopy(buffer, maxlen, "Sandstone Special");
		case 57: strcopy(buffer, maxlen, "Aquamarine");
		case 58: strcopy(buffer, maxlen, "Low Profile");
		case 59: strcopy(buffer, maxlen, "Thunderbolt");
		//================================================//
		// Harvest Collection.
		//================================================//
		case 60: strcopy(buffer, maxlen, "Autumn");
		case 61: strcopy(buffer, maxlen, "Nut Cracker");
		case 62: strcopy(buffer, maxlen, "Pumpkin Patch");
		case 63: strcopy(buffer, maxlen, "Macabre Web");
		case 64: strcopy(buffer, maxlen, "Boneyard");
		case 65: strcopy(buffer, maxlen, "Wildwood");
		//================================================//
		// Pyroland Collection.
		//================================================//
		case 66: strcopy(buffer, maxlen, "Balloonicorn");
		case 67: strcopy(buffer, maxlen, "Rainbow");
		case 68: strcopy(buffer, maxlen, "Sweetdreams");
		case 69: strcopy(buffer, maxlen, "Blue Mew");
		case 70: strcopy(buffer, maxlen, "Brain Candy");
		case 71: strcopy(buffer, maxlen, "Stabbed To Hell");
		case 72: strcopy(buffer, maxlen, "Flower Power");
		case 73: strcopy(buffer, maxlen, "Mister Cuddles");
		case 74: strcopy(buffer, maxlen, "Shot To Hell");
		case 75: strcopy(buffer, maxlen, "Torqued To Hell");
		//================================================//
		// Gentlemanne Collection.
		//================================================//
		case 76: strcopy(buffer, maxlen, "Coffin Nail");
		case 77: strcopy(buffer, maxlen, "Top Shelf");
		case 78: strcopy(buffer, maxlen, "Dressed To Kill");
		case 79: strcopy(buffer, maxlen, "High Rollers");
		//================================================//
		// Warbird Collection.
		//================================================//
		case 80: strcopy(buffer, maxlen, "War Hawk");
		case 81: strcopy(buffer, maxlen, "Blitzkrieg");
		case 82: strcopy(buffer, maxlen, "Air Wolf");
		case 83: strcopy(buffer, maxlen, "Corsair");
		case 84: strcopy(buffer, maxlen, "Butcher Bird");
		case 85: strcopy(buffer, maxlen, "Killer Bee");
		case 86: strcopy(buffer, maxlen, "Red Bear");
		//Second wave of warpaints, unlocked for all weapons. (That supports warpaints ofcourse :p)
		case 200: strcopy(buffer, maxlen, "Bloom Buffed");
		case 201: strcopy(buffer, maxlen, "Quack Canvassed");
		case 202: strcopy(buffer, maxlen, "Bank Rolled");
		case 203: strcopy(buffer, maxlen, "Merc Stained");
		case 204: strcopy(buffer, maxlen, "Kill Covered");
		case 205: strcopy(buffer, maxlen, "Fire Glazed");
		case 206: strcopy(buffer, maxlen, "Pizza Polished");
		case 207: strcopy(buffer, maxlen, "Bonk Varnished");
		case 208: strcopy(buffer, maxlen, "Star Crossed");
		case 209: strcopy(buffer, maxlen, "Clover Camo'd");
		case 210: strcopy(buffer, maxlen, "Freedom Wrapped");
		case 211: strcopy(buffer, maxlen, "Cardboard Boxed");
		case 212: strcopy(buffer, maxlen, "Dream Piped");
		case 213: strcopy(buffer, maxlen, "Miami Element");
		case 214: strcopy(buffer, maxlen, "Neo Tokyo");
		case 215: strcopy(buffer, maxlen, "Geometrical Teams");
		case 217: strcopy(buffer, maxlen, "Bomber Soul");
		case 218: strcopy(buffer, maxlen, "Uranium");
		case 220: strcopy(buffer, maxlen, "Cabin Fevered");
		case 221: strcopy(buffer, maxlen, "Polar Surprise");
		case 223: strcopy(buffer, maxlen, "Hana");
		case 224: strcopy(buffer, maxlen, "Dovetailed");
		case 225: strcopy(buffer, maxlen, "Cosmic Calamity");
		case 226: strcopy(buffer, maxlen, "Hazard Warning");
		case 228: strcopy(buffer, maxlen, "Mosaic");
		case 230: strcopy(buffer, maxlen, "Jazzy");
		case 232: strcopy(buffer, maxlen, "Alien Tech");
		case 234: strcopy(buffer, maxlen, "Damascus and Mahogany");
		case 235: strcopy(buffer, maxlen, "Skull Study");
		case 236: strcopy(buffer, maxlen, "Haunted Ghosts");
		case 237: strcopy(buffer, maxlen, "Spectral Shimmered");
		case 238: strcopy(buffer, maxlen, "Spirit Of Halloween");
		case 239: strcopy(buffer, maxlen, "Horror Holiday");
		case 240: strcopy(buffer, maxlen, "Totally Boned");
		case 241: strcopy(buffer, maxlen, "Electroshocked");
		case 242: strcopy(buffer, maxlen, "Ghost Town");
		case 243: strcopy(buffer, maxlen, "Tumor Toasted");
		case 244: strcopy(buffer, maxlen, "Calavera Canvas");
		case 245: strcopy(buffer, maxlen, "Snow Covered");
		case 246: strcopy(buffer, maxlen, "Frost Ornamented");
		case 247: strcopy(buffer, maxlen, "Smissmass Village");
		case 248: strcopy(buffer, maxlen, "Igloo");
		case 249: strcopy(buffer, maxlen, "Seriously Snowed");
		case 250: strcopy(buffer, maxlen, "Smissmas Camo");
		case 251: strcopy(buffer, maxlen, "Sleighin' Style");
		case 252: strcopy(buffer, maxlen, "Alpine");
		case 253: strcopy(buffer, maxlen, "Gift Wrapped");
		case 254: strcopy(buffer, maxlen, "Winterland Wrapped");
		case 255: strcopy(buffer, maxlen, "Helldriver");
		case 256: strcopy(buffer, maxlen, "Organ-ically Hellraised");
		case 257: strcopy(buffer, maxlen, "Spectrum Splattered");
		case 258: strcopy(buffer, maxlen, "Candy Coated");
		case 259: strcopy(buffer, maxlen, "Pumpkin Pied");
		case 260: strcopy(buffer, maxlen, "Sweet Toothed");
		case 261: strcopy(buffer, maxlen, "Crawlspace Critters");
		case 262: strcopy(buffer, maxlen, "Portal Plastered");
		case 263: strcopy(buffer, maxlen, "Death Deluxe");
		case 264: strcopy(buffer, maxlen, "Raving Dead");
		case 265: strcopy(buffer, maxlen, "Eyestalker");
		case 266: strcopy(buffer, maxlen, "Spider's Cluster");
		case 267: strcopy(buffer, maxlen, "Gourdy Green");
		case 268: strcopy(buffer, maxlen, "Mummified Mimic");
		case 269: strcopy(buffer, maxlen, "Spider Season");
		case 270: strcopy(buffer, maxlen, "Gingerbread Winner");
		case 271: strcopy(buffer, maxlen, "Saccharine Striped");
		case 272: strcopy(buffer, maxlen, "Elfin Enamel");
		case 273: strcopy(buffer, maxlen, "Peppermint Swirl");
		case 275: strcopy(buffer, maxlen, "Snow Globalization");
		case 276: strcopy(buffer, maxlen, "Gifting Mann's Wrapping Paper");
		case 277: strcopy(buffer, maxlen, "Snowflake Swirled");
		case 278: strcopy(buffer, maxlen, "Smissmass Spycrabs");
		case 279: strcopy(buffer, maxlen, "Frozen Aurora");
		case 280: strcopy(buffer, maxlen, "Starlight Serenity");
		case 281: strcopy(buffer, maxlen, "Frosty Delivery");
		case 282: strcopy(buffer, maxlen, "Glacial Glazed");
		case 283: strcopy(buffer, maxlen, "Cookie Fortress");
		case 284: strcopy(buffer, maxlen, "Sarsaparilla Sprayed");
		case 285: strcopy(buffer, maxlen, "Swashbuckled");
		case 286: strcopy(buffer, maxlen, "Skull Cracked");
		case 287: strcopy(buffer, maxlen, "Missfortunate");
		case 289: strcopy(buffer, maxlen, "Neon-Ween");
		case 290: strcopy(buffer, maxlen, "Simple Spirits");
		case 291: strcopy(buffer, maxlen, "Broken Bones");
		case 292: strcopy(buffer, maxlen, "Potent Poison");
		case 293: strcopy(buffer, maxlen, "Searing Souls");
		case 294: strcopy(buffer, maxlen, "Party Phantoms");
		case 295: strcopy(buffer, maxlen, "Polster-Guised");
		case 296: strcopy(buffer, maxlen, "Kiln and conquer");
		case 297: strcopy(buffer, maxlen, "Necromanced");
		case 300: strcopy(buffer, maxlen, "Yeti Coated");
		case 301: strcopy(buffer, maxlen, "Dark Pigmented");
		case 302: strcopy(buffer, maxlen, "Mannana");
		case 303: strcopy(buffer, maxlen, "Macaw Masked");
		case 304: strcopy(buffer, maxlen, "Sax Waxed");
		case 305: strcopy(buffer, maxlen, "Anodized Aloha");
		case 306: strcopy(buffer, maxlen, "Bamboo Brushed");
		case 307: strcopy(buffer, maxlen, "Tiger Buffed");
		case 308: strcopy(buffer, maxlen, "Croc Dusted");
		case 309: strcopy(buffer, maxlen, "Piña Polished");
		case 310: strcopy(buffer, maxlen, "Leopard Printed");
		case 390: strcopy(buffer, maxlen, "Dragon Slayer");
		case 391: strcopy(buffer, maxlen, "Smissmass Sweater");
		default: Format(buffer, maxlen, "Unknown warpaint (%i)", defindex);
	}
}

/**
 *	Returns the users active taunt definition index.
 *
 *	@param	client	The users index.
 *
 *	@return	Returns the taunt definition index. -1 if invalid user or 0 if no taunt.
 */
stock int TF2_GetClientActiveTauntDefinitionIndex(int client) { return GetEntPropEx(client, Prop_Send, "m_iTauntItemDefIndex"); }

/**
 *	Returns the paint colour name.
 *
 *	@param	defindex	The paint definition index.
 *	@param	buffer		The buffer to store the paint name.
 *	@param	maxlen		The maximum length of the buffer name.
 *
 *	@noreturn.
 */
stock void TF2_GetPaintName(int defindex, char[] buffer, int maxlen) {
	switch(defindex) {
		case 1315860: strcopy(buffer, maxlen, "A Distinctive Lack Of Blue");
		case 2960676: strcopy(buffer, maxlen, "After Eight");
		case 3100495: strcopy(buffer, maxlen, "A Colour Similiar To Slate");
		case 3329330: strcopy(buffer, maxlen, "A Bitter Taste Of Defeat And Lime");
		case 3874595: strcopy(buffer, maxlen, "Balaclavas Are Forever");
		case 4345659: strcopy(buffer, maxlen, "Zepheniahs Greed");
		case 4732984: strcopy(buffer, maxlen, "Operators Overalls");
		case 5322826: strcopy(buffer, maxlen, "Noble Hatters Violet");
		case 6637376: strcopy(buffer, maxlen, "An Air Of Debonair");
		case 6901050: strcopy(buffer, maxlen, "Radigan Conagher Brown");
		case 7511618: strcopy(buffer, maxlen, "Indubitably Green");
		case 8154199: strcopy(buffer, maxlen, "Ye Olde Rustic Colour");
		case 8208497: strcopy(buffer, maxlen, "A Deep Commitment To Purple");
		case 8289918: strcopy(buffer, maxlen, "Aged Moustache Grey");
		case 8400928: strcopy(buffer, maxlen, "The Value Of Teamwork");
		case 8421376: strcopy(buffer, maxlen, "Drably Olive");		
		case 10843461: strcopy(buffer, maxlen, "Muskelmannbraun");
		case 11049612: strcopy(buffer, maxlen, "Waterlogged Lab Coat");
		case 12073019: strcopy(buffer, maxlen, "Team Spirit");
		case 12807213: strcopy(buffer, maxlen, "Cream Spirit");
		case 13595446: strcopy(buffer, maxlen, "Mann Co. Orange");
		case 14204632: strcopy(buffer, maxlen, "Colour No 216-190-216");
		case 15132390: strcopy(buffer, maxlen, "An Extraordinary Abudance Of Tinge");
		case 15185211: strcopy(buffer, maxlen, "Australium Gold");
		case 15308410: strcopy(buffer, maxlen, "Dark Salmon Injustice");
		case 12377523: strcopy(buffer, maxlen, "A Mann's Mint");
		case 12955537: strcopy(buffer, maxlen, "Peculiarly Drab Tincture");
		case 15787660: strcopy(buffer, maxlen, "The Colour Of A Gentlemanns Business Pants");
		case 16738740: strcopy(buffer, maxlen, "Pink As Hell");
	}
}

/**
 *	Replaces the voicelines with the robot variant.
 *
 *	@param	client	The users index.
 *	@param	sound	The sound string of the soundhook to replace the voiceline.
 *	@param	giant	If true, giant robot versions is used.
 *
 *	@error	If the user is invalid or has invalid class, this returns false.
 */
stock bool TF2_ReplaceClientRobotVoicelines(int client, char[] sound, bool giant=false)	{
	if(!Tklib_IsValidClient(client, _, true)) return false;
	if(TF2_GetPlayerClass(client) < TFClass_Scout) return false;
	
	TFClassType class = TF2_GetPlayerClass(client);
	
	char vc[3][64];
	Format(vc[0], sizeof(vc[]), "vo/%s_", TF2_ClassTypeNameLC[class]);
	switch(giant) {
		case true: {
			Format(vc[1], sizeof(vc[]), "vo/mvm/mght/%s_", TF2_ClassTypeNameLC[class]);
			Format(vc[2], sizeof(vc[]), "%s_mvm_m", TF2_ClassTypeNameLC[class]);
		}
		case false: {
			Format(vc[1], sizeof(vc[]), "vo/mvm/norm/%s_", TF2_ClassTypeNameLC[class]);
			Format(vc[2], sizeof(vc[]), "%s_mvm", TF2_ClassTypeNameLC[class]);
		}
	}
	
	ReplaceString(sound, 128, vc[0], vc[1], false);
	ReplaceString(sound, 128, TF2_ClassTypeName[class], vc[2], false);
	PrecacheSound(sound);
	return true;
}

/**
 *	Find weapon by definition index and its owner.
 *
 *	@param	defindex	The item definition index.
 *	@param	client		The item owner user index.
 *
 *	@return	Returns the entity's owner.
 */
stock any TF2_FindWeaponByDefinitionIndex(int client, int defindex) {
	for(TFSlot slot = TFSlot_Primary; slot < TFSlot_PDA2; slot++) {
		int weapon = TF2_GetPlayerWeaponSlot(client, slot);
		if(IsValidEntityEx(weapon) && GetEntityDefinitionIndex(weapon) == defindex && GetEntityOwner(weapon) == client) return weapon;
	}
	
	return -1;
}

/**
 *	Find wearable by definition index and its owner.
 *
 *	@param	defindex	The item definition index.
 *	@param	client		The item owner user index.
 *
 *	@return	Returns the entity's owner.
 */
stock any TF2_FindCosmeticByDefinitionIndex(int client, int defindex) {
	int wearable = 0;
	while((wearable = FindEntityByClassname(wearable, "tf_wearable")) != -1) if(IsValidEntityEx(wearable) && GetEntityDefinitionIndex(wearable) == defindex && GetEntityOwner(wearable) == client) return wearable;
	while((wearable = FindEntityByClassname(wearable, "tf_wearable_levelable_item")) != -1) if(IsValidEntityEx(wearable) && GetEntityDefinitionIndex(wearable) == defindex && GetEntityOwner(wearable) == client) return wearable;
	return -1;
}

/**
 *	Returns if the weapon is an explosive type (Including Engineer's PDA because of LVL 3 Sentry Gun Rockets).
 *
 *	@param	defindex	The weapon definition index.
 *
 *	@return	If valid, returns true. Else returns false.
 */
stock bool TF2_IsValidExplosiveWeaponDefindex(int defindex) {
	switch(defindex) {
		case 18,19,20,25,205,206,207,127,130,131,228,237,265,308,
		405,406,414,441,513,608,658,661,730,737,797,800,806,
		809,886,889,895,898,904,907,913,916,962,965,971,974,
		996,1007,1085,1099,1104,1144,1150,1151,15006,15009,
		15012,15014,15024,15028,15038,15043,15045,15048,
		15052,15057,15077,15079,15081,15082,15083,15084,
		15091,15092,15104,15105,15113,15116,15117,15129,
		15130,15137,15138,15142,15150,15155,15158: return true;
	}
	
	return false;
}

/**
 *	Returns if the weapon is a flamethrower.
 *
 *	@param	defindex	The weapon definition index.
 *
 *	@return	If valid, returns true. Else returns false.
 */
stock bool TF2_IsValidFlamethrowerDefindex(int defindex) {
	switch(defindex) {
		case 21,40,208,215,594,659,741,798,807,887,
		896,905,914,963,972,11146,1178,15005,15017,
		15030,15034,15049,15054,15066,15067,15068,
		15089,15090,15115,15141,30474: return true;
	}
	
	return false;
}

/**
 *	Returns if the entity is a valid weapon.
 *
 *	@param	entity	The entity index.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool TF2_IsValidWeapon(int entity) {
	if(!IsValidEntityEx(entity)) return false;
	char clsname[128];
	GetEntityClassname(entity, clsname, sizeof(clsname));
	return StrContainsEx(clsname, "tf_weapon", false);
}

/**
 *	Returns if the entity is a valid wearable.
 *
 *	@param	entity	The entity index.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool TF2_IsValidWearable(int entity) {
	if(!IsValidEntityEx(entity)) return false;
	char clsname[128];
	GetEntityClassname(entity, clsname, sizeof(clsname));
	return StrContainsEx(clsname, "tf_wearable", false);
}

/**
 *	Set the entity's quality.
 *
 *	@param	entity		Entity index.
 *	@param	quality		The TFQuality.
 *
 *	@error	If the entity is invalid or has no quality property, this returns false.
 */
stock bool TF2_SetEntityQuality(int entity, TFQuality quality) { return SetEntDataOffset(entity, "m_iEntityQuality", quality); }

/**
 *	Returns the entity's quality.
 *
 *	@param	entity		Entity index.
 *
 *	@error	If the entity is invalid or has no quality property, this returns TFQuality_Invalid.
 */
stock TFQuality TF2_GetEntityQuality(int entity) { return view_as<TFQuality>(GetEntDataOffset(entity, "m_iEntityQuality")); }

/**
 *	Set the entity's level.
 *
 *	@param	entity		Entity index.
 *
 *	@error	If the entity is invalid or has no level property, this returns false.
 */
stock bool TF2_SetEntityLevel(int entity, int level) { return SetEntDataOffset(entity, "m_iEntityLevel", level); }

/**
 *	Returns the entity's level.
 *
 *	@param	entity		Entity index.
 *	@param	level		The level.
 *
 *	@error	If the entity is invalid or has no level property, this returns false.
 */
stock int TF2_GetEntityLevel(int entity) { return GetEntDataOffset(entity, "m_iEntityLevel"); }

/**
 *	Returns if the entity is a validated attached entity.
 *	Used for activating weapons & cosmetics (Make them visible for everyone).
 *
 *	@param	entity	The entity index.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool TF2_IsValidatedAttachedEntity(int entity) { return view_as<bool>(GetEntDataOffset(entity, "m_bValidatedAttachedEntity")); }

/**
 *	Set the entity to be a validated attached entity.
 *	Used for activating weapons & cosmetics (Make them visible for everyone).
 *
 *	@param	entity		The entity index.
 *	@param	validated	If true, the entity will be a validated attached entity. Else de-validates.
 *
 *	@error	If the entity is invalid, this returns false.
 */
stock bool TF2_SetValidatedAttachedEntity(int entity, bool validated) { return SetEntDataOffset(entity, "m_bValidatedAttachedEntity", validated); }

/**
 *	Creates a cosmetic entity.
 *
 *	@param	name				If non-null, applies the entity name.
 *	@param	ForceEdictIndex		If non-null, applies forced entity index when created.
 *
 *	@return	Returns the entity index of the cosmetic entity.
 */
stock int TF2_CreateCosmetic(const char[] name="", int ForceEdictIndex=-1) { return CreateEntityByNameEx("tf_wearable", name, ForceEdictIndex); }

/**
 *	Creates a demoshield weapon entity.
 *
 *	@param	name				If non-null, applies the entity name.
 *	@param	ForceEdictIndex		If non-null, applies forced entity index when created.
 *
 *	@return	Returns the entity index of the cosmetic demoshield entity.
 */
stock int TF2_CreateCosmeticDemoShield(const char[] name="", int ForceEdictIndex=-1) { return CreateEntityByNameEx("tf_wearable_demoshield", name, ForceEdictIndex); }

/**
 *	Creates a razorback weapon entity.
 *	Used for the 'Razorback' weapon.
 *
 *	@param	name				If non-null, applies the entity name.
 *	@param	ForceEdictIndex		If non-null, applies forced entity index when created.
 *
 *	@return	Returns the entity index of the cosmetic razorback entity.
 */
stock int TF2_CreateCosmeticRazorback(const char[] name="", int ForceEdictIndex=-1) { return CreateEntityByNameEx("tf_wearable_razorback", name, ForceEdictIndex); }

/**
 *	Creates a videomaker entity.
 *	Used for taunts.
 *
 *	@param	name				If non-null, applies the entity name.
 *	@param	ForceEdictIndex		If non-null, applies forced entity index when created.
 *
 *	@return	Returns the entity index of the cosmetic videomaker entity.
 */
stock int TF2_CreateCosmeticVideoMaker(const char[] name="", int ForceEdictIndex=-1) { return CreateEntityByNameEx("tf_wearable_vm", name, ForceEdictIndex); }

/**
 *	Creates a robot arm viewmodel.
 *	Used for the 'Gunslinger' weapon.
 *
 *	@param	name				If non-null, applies the entity name.
 *	@param	ForceEdictIndex		If non-null, applies forced entity index when created.
 *
 *	@return	Returns the entity index of the robot arm viewmodel entity.
 */
stock int TF2_CreateCosmeticRobotArm(const char[] name="", int ForceEdictIndex=-1) { return CreateEntityByNameEx("tf_wearable_robot_arm", name, ForceEdictIndex); }

/**
 *	Creates a levelable cosmetic item.
 *	Used for cosmetics updating its model based on its owner's current killstreak.
 *
 *	@param	name				If non-null, applies the entity name.
 *	@param	ForceEdictIndex		If non-null, applies forced entity index when created.
 *
 *	@return	Returns the entity index of the levelable cosmetic entity.
 */
stock int TF2_CreateCosmeticLevelable(const char[] name="", int ForceEdictIndex=-1) { return CreateEntityByNameEx("tf_wearable_levelable_item", name, ForceEdictIndex); }

/**
 *	Creates a cosmetic campaign item.
 *
 *	@param	name				If non-null, applies the entity name.
 *	@param	ForceEdictIndex		If non-null, applies forced entity index when created.
 *
 *	@return	Returns the entity index of the cosmetic campaign item entity.
 */
stock int TF2_CreateCosmeticCampaignItem(const char[] name="", int ForceEdictIndex=-1) { return CreateEntityByNameEx("tf_wearable_campaign_item", name, ForceEdictIndex); }

/**
 *	Creates a viewmodel entity.
 *	Used for showing your arms.
 *
 *	@param	name				If non-null, applies the entity name.
 *	@param	ForceEdictIndex		If non-null, applies forced entity index when created.
 *
 *	@return	Returns the entity index of the cosmetic viewmodel entity.
 */
stock int TF2_CreateViewmodel(const char[] name="", int ForceEdictIndex=-1) { return CreateEntityByNameEx("tf_viewmodel", name, ForceEdictIndex); }

/**
 *	Created a 'dropped' weapon entity.
 *	Spawned into the world when the opponent dies, replica of the weapon wielded.
 *
 *	@param	name				If non-null, applies the entity name.
 *	@param	ForceEdictIndex		If non-null, applies forced entity index when created.
 *
 *	@return	Returns the weapon entity.
 */
stock int TF2_CreateDroppedWeapon(const char[] name="", int ForceEdictIndex=-1) { return CreateEntityByNameEx("tf_dropped_weapon", name, ForceEdictIndex); }

/**
 *	Returns if the user is in the class.
 *
 *	@param	client	The users index.
 *	@param	class	The class to check.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool TF2_IsClientClass(int client, TFClassType class) { return Tklib_IsValidClient(client, _, true) ? (TF2_GetPlayerClass(client) == class) : false; }

/**
 *	Returns the users current desired class.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this returns TFClass_Unknown.
 */
stock TFClassType TF2_GetClientDesiredClass(int client) { return view_as<TFClassType>(GetEntPropEx(client, Prop_Send, "m_iDesiredPlayerClass")); }

/**
 *	Set the users current desired class.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool TF2_SetClientDesiredClass(int client, TFClassType class) { return SetEntPropEx(client, Prop_Send, "m_iDesiredPlayerClass", class); }

/**
 *	Returns if the paint kit index is valid.
 *
 *	@param	index	The paint kit index.
 */
stock bool TF2_IsValidPaintKit(int index) { for(int i = MAX_TF2_PAINTS; i--;) { if(TF2_Paints[i] == index) return true; } return false; }

/**
 *	Returns if the unusual effect index is valid.
 *
 *	@param	index	The unusual particle index.
 */
stock bool TF2_IsValidUnusual(int index) { for(int i = MAX_TF2_UNUSUALS; i--;) { if(TF2_UnusualEffects[i] == index) return true; } return false; }

/**
 *	Returns if the definition index is a valid weapon.
 *
 *	@param	defindex	The weapon definition index.
 */
stock bool TF2_IsValidWeaponDefindex(int defindex) { for(int i = MAX_TF2_WEAPONS; i--;) { if(TF2_Weapons[i] == defindex) return true; } return false; }

/**
 *	Returns if the definition index is a valid taunt.
 *
 *	@param	defindex	The taunt definition index.
 */
stock bool TF2_IsValidTaunt(int defindex) { for(int i = MAX_TF2_TAUNTS; i--;) { if(TF2_Taunts[i] == defindex) return true; } return false; }

/**
 *	Equips the user the cosmetic item.
 *
 *	@param	client		The users index.
 *	@param	cosmetic	The cosmetic entity.
 *
 *	@error	If the error or process failed, this returns -1.
 *
 *	@return	Returns the offset.
 */
stock int TF2_EquipPlayerCosmetic(int client, int cosmetic) {
	GameData data = new GameData("sm-tf2.games");
	int offset = data.GetOffset("RemoveWearable")-1;
	delete data;
	if(offset < 1) {
		SetFailState("[Tklib:TF2] TF2_EquipPlayerCosmetic(client %i, cosmetic %i)"
		... "has entered a fatal error due to invalid offset %i"
		... "(/gamedata/sm-tf2.games.txt missing or gamedata needs to be updated.)", client, cosmetic, offset);
		return -1;
	}
	StartPrepSDKCall(SDKCall_Player);
	PrepSDKCall_SetVirtual(offset);
	PrepSDKCall_AddParameter(SDKType_CBaseEntity, SDKPass_Pointer);
	Handle EquipWearable = EndPrepSDKCall();
	if(EquipWearable != null) SDKCall(EquipWearable, client, cosmetic);
	delete EquipWearable;
	return offset;
}

/**
 *	Returns if the class is valid.
 *
 *	@param	class	The TFClassType class type.
 */
stock bool TF2_IsValidClass(TFClassType class) { return (class >= TFClass_Scout && class <= TFClass_Civilian); }

/**
 *	Retrieves the users active class.
 *
 *	@param	client	The users index.
 *
 *	@error	If user is invalid, this returns TFClass_Invalid.
 */
stock TFClassType TF2_GetPlayerActiveClass(int client) {
	TFClassType class = view_as<TFClassType>(GetEntPropEx(client, Prop_Send, "m_iClass"))
	, desired = view_as<TFClassType>(GetEntPropEx(client, Prop_Send, "m_iDesiredPlayerClass"));
	
	return TF2_IsValidClass(class) ? class : TF2_IsValidClass(desired) ? desired : TFClass_Invalid;
}

/**
 *	Returns if the user has valid class.
 *
 *	@param	client	The users index.
 *
 *	@error	If the user is invalid, this returns false.
 */
stock bool TF2_PlayerHasValidClass(int client) { return TF2_IsValidClass(TF2_GetPlayerActiveClass(client)); }

#endif