#include <amxmodx>
#include <fvault>
//#include <zombie_plague/zp_packs_system>

native zp_get_user_packs(index);
native zp_set_user_packs(index, amount);

#define PLUGIN "[ZP] Daily Reward Packs"
#define VERSION "1.0"
#define AUTHOR "DadoDz"

new g_playername[33][32];
new g_lastclaim[33];
new bool:g_loaded[33];

#define PACKS_REWARD 200
#define COOLDOWN_TIME 43200 // 12 hours in seconds
#define VAULT_NAME "zp_daily_reward_packs"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);

	register_clcmd("say /get", "clcmd_claim")
	register_clcmd("say get", "clcmd_claim")
}

public client_putinserver(id)
{
	get_user_name(id, g_playername[id], charsmax(g_playername[]));

	if (!is_user_bot(id) && !is_user_hltv(id))
		LoadPlayerData(id);
}

public client_disconnected(id)
{
	SavePlayerData(id);
	g_loaded[id] = false;
}

public clcmd_claim(id)
{
	new iCurrentTime = get_systime();
	new iTimePassed = iCurrentTime - g_lastclaim[id];
	new iCooldown = COOLDOWN_TIME;
	
	if(iTimePassed >= iCooldown || g_lastclaim[id] == 0)
	{
		zp_set_user_packs(id, zp_get_user_packs(id) + PACKS_REWARD);
		g_lastclaim[id] = iCurrentTime;
		client_print_color(id, print_team_default, "^x04[^x01ZP^x04]^x01 You received^x04 %d packs^x01!", PACKS_REWARD);
		SavePlayerData(id);
	}
	else
	{
		new iRemaining = iCooldown - iTimePassed;
		new iHours = iRemaining / 3600;
		new iMinutes = (iRemaining % 3600) / 60;
		client_print_color(id, print_team_default, "^x04[^x01ZP^x04]^x01 You can use /get again in^x03 %dh %dm^x01!", iHours, iMinutes);
	}
}

SavePlayerData(id)
{
	if(is_user_bot(id) || is_user_hltv(id) || !g_loaded[id])
		return;
        
	new szDataHolder[160];
	formatex(szDataHolder, charsmax(szDataHolder), "%i", g_lastclaim[id]);
	fvault_set_data(VAULT_NAME, g_playername[id], szDataHolder);   
}

LoadPlayerData(id)
{
	if(!g_playername[id][0])
		return;
        
	new szDataHolder[160], szClaimTime[15];

	if(fvault_get_data(VAULT_NAME, g_playername[id], szDataHolder, charsmax(szDataHolder)))
	{
		parse(szDataHolder, szClaimTime, charsmax(szClaimTime));
		g_lastclaim[id] = szClaimTime[0] ? str_to_num(szClaimTime) : 0;
	}
	else
	{
		g_lastclaim[id] = 0;
		SavePlayerData(id);
	}
    
	g_loaded[id] = true;
}
