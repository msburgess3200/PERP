
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

MixRange = 150;

function ENT:Initialize()
	self:SetModel("models/props/cs_militia/caseofbeer01.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake();
	
	self.willBurn = (math.random(1, 10) == 1);
end

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	if self.Entity:GetTable().Tapped and self.Entity:GetTable().Tapped > CurTime() then return false; end
	
	if (self:GetTable().numBeers > 0) then
		self:GetTable().numBeers = self:GetTable().numBeers - 1
		activator:GiveItem(26, 1, true);
	elseif (self:GetTable().Owner == activator) then
		activator:GiveItem(64, 1, true);
		self.Tapped = CurTime() + 5
		self:Remove()
	else
		activator:Notify("The box of beer is empty.")
	end
end

function ENT:SetNumBeers ( numBeers, Owner )
	self:GetTable().numBeers = numBeers;
	self:GetTable().Owner = Owner;
end


function ENT:Think ( )

end
