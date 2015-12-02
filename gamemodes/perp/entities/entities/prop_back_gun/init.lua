
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_NONE)
end

function ENT:Think ( )
	local owner = self:GetNetworkedEntity("o", nil);
	
	if (!owner || !IsValid(owner) || !owner:Alive()) then
		self:Remove();
		return
	end
	
	local foundAK = false
	for _, each in pairs(owner:GetWeapons()) do
		if (each:GetClass() == "weapon_perp_ak472" or each:GetClass() == "weapon_perp_m4a1" or each:GetClass() == "weapon_perp_mp5" or each:GetClass() == "weapon_perp_scout" or each:GetClass() == "weapon_perp_para" or each:GetClass() == "weapon_perp_shotgun") then
			foundAK = true
		end
	end
	
	if (!foundAK) then
		self:Remove()
		return
	end
end
