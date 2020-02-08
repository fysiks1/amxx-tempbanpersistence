#include <amxmodx>
#include <tempbans>

// new Array:g_aBans

public plugin_init()
{
	register_plugin("Load Temp Bans", "0.1", "Fysiks")
	set_task(2.0, "delayed") // Just so they end up at the end of the list and not the begining
}

public delayed()
{
	// Read file, calculate remaining ban time, use 'banid' to re-ban them only for the remaining time, remove old entries, 
	new f = fopen(g_szBanFilepath, "rt")
	if( f )
	{
		new data[128], szSteamID[32], szTime[32], iExpire, iCount
		new iNow = get_systime()
		while(!feof(f))
		{
			fgets(f, data, charsmax(data))
			trim(data)
			parse(data, szSteamID, charsmax(szSteamID), szTime, charsmax(szTime))
			iExpire = str_to_num(szTime)
			if( iExpire > iNow )
			{
				// Add to ban list
				server_cmd("banid %0.1f %s", float((iExpire - iNow) / 60), szSteamID)
				data[0] = iExpire
				copy(data[0], charsmax(data) - 1, szSteamID)
				iCount++
			}
		}
		fclose(f)
		server_print(">>Temporary Bans Loaded (%d)", iCount)
	}
	else
	{
		set_fail_state("Failed to load temporary bans!")
	}
}