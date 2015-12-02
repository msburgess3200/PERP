
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

MixRange = 150;

function ENT:Initialize()
	self:SetModel("models/props_wasteland/interior_fence002e.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake();
end

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	if self.Entity:GetTable().Tapped and self.Entity:GetTable().Tapped > CurTime() then return false; end

	if (self:GetTable().Owner == activator) then
		activator:GiveItem(81, 1, true);
		self.Tapped = CurTime() + 5
		self:Remove()
	end
end

function ENT:SetItemOwner ( Owner )
	self:GetTable().Owner = Owner;
end

local weapons = {"weapon_perp_ak472", "weapon_perp_copgun", "weapon_perp_copgun_ss", "weapon_perp_copgun_usp", "weapon_perp_deagle2", "weapon_perp_fiveseven", "weapon_perp_glock", "weapon_perp_shotgun", "weapon_perp_uzi", "weapon_perp_mp5", "weapon_perp_m4a1", "weapon_perp_para", "weapon_perp_scout", "weapon_perp_lockpick", "weapon_perp_molotov"}

function ENT:Think ( )
	if (self.goingOff && (self.goingOff + 5) > CurTime()) then return end

	local min = self:OBBMins()
	local cen = self:OBBCenter()
	local real = self:LocalToWorld(Vector(cen.x, cen.y, min.z))

	for _, each in pairs(player.GetAll()) do
		if (each:GetPos():Distance(real) < 50) then 
			local foundGun = false
			for _, each in pairs(each:GetWeapons()) do
				local cl = string.lower(each:GetClass())
				
				for _, class in pairs(weapons) do
					if (cl == class) then
						foundGun = true
						break
					end
				end
				
				if (foundGun) then break end
			end
			
			if (foundGun) then
				self.goingOff = CurTime()
				umsg.Start("perp_metal_det")
					umsg.Entity(self)
				umsg.End()
				return
			end
		end
	end
end
