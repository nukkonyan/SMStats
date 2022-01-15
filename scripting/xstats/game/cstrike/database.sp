/**
 *	Prepare database.
 */
void PrepareDB_CSS()	{
	char query[8192];
	int len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `playerlist_css`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ServerID`							int(16) not null default '1' comment 'Servers unique ID',");
	len += Format(query[len], sizeof(query)-len, "`Points`								int(32) not null default '1000',");
	len += Format(query[len], sizeof(query)-len, "`LastConnected`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`LastConnectedServerID`				int(32) not null default '1' comment 'Last server id player were on.',");
	len += Format(query[len], sizeof(query)-len, "`PlayTime`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Playername`						varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`SteamID`							varchar(64) not null default '',");
	len	+= Format(query[len], sizeof(query)-len, "`IPAddress`						varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`Kills`								int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Deaths`								int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Assists`								int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Suicides`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`DamageDone`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`KnifeKills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Headshots`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscopes`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Dominations`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Revenges`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`MoneySpent`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_hegrenade`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_flashbang`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_smokegrenade`			int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_deagle`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_glock`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ak47`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_aug`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_awp`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_famas`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_g3sg1`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_galilar`				int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_m249`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_m4a1`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_mac10`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_p90`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_mp5`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_ump45`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_xm1014`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_m9`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_usp`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_nova`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_p228`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scar20`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_sg552`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_scout`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills_weapon_knife`					int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`SteamID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 1);
	
	//Reset for new query.
	query = NULL_STRING;
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
	
	query = NULL_STRING;
	len = 0;
	
	len += Format(query[len], sizeof(query)-len, "create table if not exists `maps_log_css`");
	len += Format(query[len], sizeof(query)-len, "(");
	len += Format(query[len], sizeof(query)-len, "`ServerID`						int(32) not null default '1',");
	len += Format(query[len], sizeof(query)-len, "`MapName`						varchar(64) not null default '',");
	len += Format(query[len], sizeof(query)-len, "`PlayTime`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Kills`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Deaths`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Assists`							int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Suicides`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Headshots`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Noscopes`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Dominations`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "`Revenges`						int(32) not null default '0',");
	len += Format(query[len], sizeof(query)-len, "primary key (`ServerID`)");
	len += Format(query[len], sizeof(query)-len, ")");
	db.Query(DBQuery_DB, query, 4);
}