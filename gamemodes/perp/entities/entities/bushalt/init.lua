
AddCSLuaFile("cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType(SIMPLE_USE)
	
	if(self.Entity:GetPhysicsObject():IsValid()) then
		self.Entity:GetPhysicsObject():EnableMotion(false)
	end
end