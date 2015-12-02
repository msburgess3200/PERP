local PLUGIN = {}

PLUGIN.Name = "Demote"
PLUGIN.Author = "RedMist"
PLUGIN.Date = "15th March 2011"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if (CLIENT) then

	function PLUGIN.DoDemote(PLAYER)
		local function EndFunction ( Info )
			if PLAYER and PLAYER:IsValid() and PLAYER:IsPlayer() then
				RunConsoleCommand('perp2_demote', PLAYER:UniqueID(), Info);
			end
		end

		Derma_StringRequest("Demote Reason", "Why are you demoting this person?", "", EndFunction);
	end   
	
	
	function PLUGIN.AddMenu(DMENU)			
	
		DMENU:AddSubMenu( "Demote",   nil, function(NEWMENU) ASS_PlayerMenu( NEWMENU, {"IncludeAll", "IncludeLocalPlayer"}, PLUGIN.DoDemote ) end ):SetImage( "gui/silkicons/status_offline" )

	end

end

ASS_RegisterPlugin(PLUGIN)
