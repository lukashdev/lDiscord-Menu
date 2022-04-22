#include <sourcemod>
#include <multicolors>

#pragma newdecls required
#pragma semicolon 1
#pragma tabsize 0

#define PLUGIN_AUTHOR "lukash"
#define PLUGIN_VERSION "1.0.0"
#define PLUGIN_NAME "lDiscord"
#define PLUGIN_DESCRIPTION "Discord"
#define PLUGIN_URL "https://steamcommunity.com/id/lukasz11772/"
#define PATH_FILE "cfg/sourcemod/lPlugins/Discord.txt"
#define TAG "{darkred}[ {orange}Discord {darkred}]{yellow}"
#define ConsoleTAG "[ Discord ]"
#define DEBUG

public Plugin myinfo = 
{
	name = PLUGIN_NAME,
	author = PLUGIN_AUTHOR,
	description = PLUGIN_DESCRIPTION,
	version = PLUGIN_VERSION,
	url = PLUGIN_URL
};

ConVar cv_DiscordURL;

public void OnPluginStart()
{
    RegConsoleCmd("sm_dc", CMD_Discord);
    RegConsoleCmd("sm_dsc", CMD_Discord);
    RegConsoleCmd("sm_discord", CMD_Discord);
    cv_DiscordURL = CreateConVar("sm_Discord_URL", "https://discord.gg/G3ydAHut6Y");
	AutoExecConfig(true, "lDiscord");
}

public Action CMD_Discord(int client, int args)
{
    GeneralMenu(client);
}

public int Menu_Handler(Menu menu, MenuAction action, int client, int Position)
{
	if(action == MenuAction_Select)
	{
		char Item[32];
		GetMenuItem(menu, Position, Item, sizeof(Item));
		if(StrEqual(Item, "linkchat"))
			SendLink(client, 1);
		if(StrEqual(Item, "linkconsole"))
			SendLink(client, 2);
	}
	else if(action == MenuAction_End)
		delete menu;
}

void GeneralMenu(int client)
{
    Menu menu = new Menu(Menu_Handler);
    menu.SetTitle("» Wybierz działanie");
    menu.AddItem("linkchat", "» Wyślij linka na CHAT");
    menu.AddItem("linkconsole", "» Wyślij linka na konsolę");
    menu.Display(client, 60);
}

void SendLink(int client, int position)
{
	char sDiscordURL[512];
	GetConVarString(cv_DiscordURL, sDiscordURL, sizeof(sDiscordURL));
	if(position == 1)
		CPrintToChat(client, "%s %s", TAG, sDiscordURL);
	else
		CPrintToChat(client, "%s %s", ConsoleTAG, sDiscordURL);
}