
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
function ENT:Initialize()
	self.Entity:SetModel("models/props_foliage/ferns02.mdl");

	self.Entity:PhysicsInit(SOLID_NONE)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_NONE)
	self.Entity:SetAngles(Angle(0, math.random(1, 360), 0));
end
