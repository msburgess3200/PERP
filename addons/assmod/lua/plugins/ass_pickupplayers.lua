local PLUGIN = {}

PLUGIN.Name = "Admin Pickup Players"
PLUGIN.Author = "RedMist"
PLUGIN.Date = "15th March 2011"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if (SERVER) then
	
	function PLUGIN.PhysgunPickup( PLAYER, ENTITY )
		if PLAYER:IsAdmin() then
			if ENTITY:IsPlayer() then
				if ENTITY != PLAYER then
					if ENTITY:IsBetterOrSame(PLAYER) then
						return false
					end
				end
				ENTITY:Freeze(true)
				ENTITY:SetMoveType(MOVETYPE_NOCLIP)
				return true
			end
		end
	end
	hook.Add( "PhysgunPickup", "PhysgunPickup", PLUGIN.PhysgunPickup )
	
	function PLUGIN.PhysgunDrop(PLAYER, ENTITY)
		if ENTITY:IsPlayer() then
			ENTITY:SetMoveType(MOVETYPE_WALK)
			ENTITY:Freeze(false)
		end
	end
	hook.Add( "PhysgunDrop", "PhysgunDrop", PLUGIN.PhysgunDrop)

end

if (CLIENT) then
end

ASS_RegisterPlugin(PLUGIN)


