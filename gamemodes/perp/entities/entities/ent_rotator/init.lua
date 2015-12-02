AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local Distance = 75
local MaxFires = 25;
local NumberOfFires = 0;

function ENT:Initialize()
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_NONE)
end

function ENT:Think ( )
	
end
