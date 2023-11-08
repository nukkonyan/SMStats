stock void UpdateDamageDone(SMStats_PlayerInfo player)
{
	CallbackQuery("update `%s` set `DamageDone`=`DamageDone`+%i where `SteamID`='%s' and `ServerID`='%i'"
	, query_error_uniqueid_OnUpdateDamageDone
	, sql_table_playerlist
	, player.session[Stats_DamageDone]
	, player.auth
	, g_StatsID);
}