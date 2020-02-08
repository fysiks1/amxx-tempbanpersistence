// Writes a ban to the temp ban file so that it can be loaded by load_temp_bans.amxx

new g_szBanFilepath[] = "banned_temp.txt"

public add_temp_ban(szSteamID[], iTime)
{
	new iExpire = get_systime() + iTime * 60
	new szString[128], szDate[32]
	format_time(szDate, charsmax(szDate), "%m/%d/%Y - %H:%M:%S", iExpire)
	formatex(szString, charsmax(szString), "^"%s^" ^"%d^" ^"%s^"", szSteamID, iExpire, szDate)
	write_file(g_szBanFilepath, szString)
}
