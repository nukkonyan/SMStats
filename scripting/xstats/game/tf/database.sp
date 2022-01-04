/**
 *	Prepare database.
 */
void PrepareDB_TF2()
{
	char query[8192];
	int len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `playerlist_tf2`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`Points`						int(32)			not null default '1000',");
	len += Format(query[len], sizeof(query)-len, "`PlayTime`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Playername`					varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`SteamID`						varchar(64)		not null default '',");
	len	+= Format(query[len], sizeof(query)-len, "`IPAddress`					varchar(64)		not null default '127.0.0.1',");
	len += Format(query[len], sizeof(query)-len, "`Headshots`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Backstabs`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills`						int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Deaths`						int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Suicides`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Assists`						int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscopes`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Dominations`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Revenges`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MiniSentryKills`				int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryKills`					int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryLVL1Kills`				int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryLVL2Kills`				int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentryLVL3Kills`				int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MiniSentriesBuilt`			int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`SentriesBuilt`				int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`DispensersBuilt`				int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TeleporterExitsBuilt`		int(32)			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`TeleporterEntrancesBuilt`	int(32)			not null default '0',");
	
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bat`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bottle`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_fireaxe`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_kukri`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_knife`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_fists`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_shovel`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_wrench`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_bonesaw`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_shotgun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scattergun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sniperrifle`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_minigun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_smg`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_syringegun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_rocketlauncher`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_grenadelauncher`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_stickybomblauncher`		int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_flamethrower`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_pistol`					int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_revolver`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_blutsauger`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ubersaw`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_axtinguisher`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_flaregun`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_backburner`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_natascha`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_killerglovesofboxing`	int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sandman`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_forceanature`			int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_huntsman`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ambassador`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_directhit`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_equalizer`				int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scottish_resistance`	int(32)	not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_demoshield`				int(32)	not null default '0',");
	
	len += Format(query[len], sizeof(query)-len, "primary key (`SteamID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 1);
	
	//Reset for new query.
	query = "";
	len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `kill_log_css`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ID`							int(32)			not null auto_increment,");
	len += Format(query[len], sizeof(query)-len, "`Playername`					varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`SteamID`						varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Victim_Playername`			varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Victim_SteamID`				varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Assister_Playername`			varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Assister_SteamID`			varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Timestamp`					timestamp		not null default current_timestamp,");
	len += Format(query[len], sizeof(query)-len, "`Weapon`						varchar(64)		not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Headshot`					bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscope`						bool			not null default '0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`ID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 2);
}