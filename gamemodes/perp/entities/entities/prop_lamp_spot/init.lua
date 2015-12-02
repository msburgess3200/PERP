
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/props_wasteland/light_spotlight01_lamp.mdl");
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake();
end

function ENT:OnTakeDamage ( )
	if (self.broken) then return; end
	
	self.broken = true
	self.flashlight:Fire("TurnOff", "", 0);
	self:SetNetworkedBool("show_spot", false);
	
	self:SetSkin(1)
end
