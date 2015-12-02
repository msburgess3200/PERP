
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local MixRange = 150;

function ENT:Initialize()
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake();
	
	self.costItem = true;
end

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	if !self:GetTable().ItemID then self:Remove(); return false; end
	if (activator != self:GetTable().Owner) then return false; end
	if self.Entity:GetTable().Tapped and self.Entity:GetTable().Tapped > CurTime() then return false; end
	
	self.Entity:GetTable().Tapped = CurTime() + 5;
	activator:GiveItem(self:GetTable().ItemID, 1, true);
	self:GetTable().Owner.theirNumItems = self:GetTable().Owner.theirNumItems - 1;
	
	self:Remove();
end

function ENT:SetContents ( ItemID, Owner )
	self:GetTable().ItemID = tonumber(ItemID);
	self:GetTable().Owner = Owner;
end

