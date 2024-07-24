stock void UpdateDamageDone(SMStats_PlayerInfo player)
{
	CallbackQuery("update `%s` set `DamageDone`=`DamageDone`+%i where `SteamID`='%s' and `StatsID`='%i'"
	, query_error_uniqueid_OnUpdateDamageDone
	, sql.playerlist
	, player.session[Stats_DamageDone]
	, player.auth
	, g_StatsID);
}