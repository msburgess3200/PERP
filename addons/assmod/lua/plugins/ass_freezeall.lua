
local PLUGIN = {}

PLUGIN.Name = "Freeze All"
PLUGIN.Author = "RedMist"
PLUGIN.Date = "15th March 2011"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}


if (CLIENT) then

	function PLUGIN.FreezeAll()
		RunConsoleCommand('perp_a_fa');
	end   
	
	function PLUGIN.UnFreezeAll()
		RunConsoleCommand('perp_a_ufa');
	end   
	
	
	function PLUGIN.AddMenu(DMENU)			
		DMENU:AddSubMenu("Freeze All", nil, function (NEWM)
		NEWM:AddOption("Freeze All", function() PLUGIN.FreezeAll() end)
		NEWM:AddOption("UnFreeze All", function() PLUGIN.UnFreezeAll() end)
		end)

	end

end

ASS_RegisterPlugin(PLUGIN)