
local PLUGIN = {}

PLUGIN.Name = "Toggle OOC"
PLUGIN.Author = "Misha"
PLUGIN.Date = "13 January 2012"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}


if (CLIENT) then

	function PLUGIN.ToggleOOC()
		RunConsoleCommand('perp_a_ooct');
	end   
	
	function PLUGIN.AddMenu(DMENU)			

	end --Redone in ASS_Client, look there.

ASS_RegisterPlugin(PLUGIN)