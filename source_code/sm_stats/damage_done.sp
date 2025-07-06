stock void UpdateDamageDone(SMStats_PlayerInfo player)
{
	CallbackQuery("update `%s` set `dmg`=`dmg`+%i where `auth`='%s' and `sID`='%i'"
	, query_error_uniqueid_OnUpdateDamageDone
	, sql.playerlist
	, player.session[Stats_DamageDone]
	, player.auth
	, g_StatsID);
}