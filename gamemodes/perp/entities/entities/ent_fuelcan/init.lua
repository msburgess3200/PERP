
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/metalgascan.mdl")
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake();
	
	self.CurFuel = 5000
	self.OurHealth = 100
	self.Sound = "perp3.0/waterpour.wav"
	self.Exploding = false
end

function ENT:Think()
/*
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
					if (v:GetClass() == "prop_vehicle_jeep") then
						v:GetNetworkedEntity("owner"):AddFuel(self.CurFuel, false)
						self:EmitSound(self.Sound, 10000, 100)
						self:Remove()
						break;
					end
			end
*/
end

function ENT:Use(activator, caller)
		if (!activator:IsPlayer()) then return; end
		
		if (activator:KeyDown( IN_WALK ) ) then 
		activator:GiveItem(89, 1, true);
		self:Remove();
		return;
		end
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 50)) do
					if (v:GetClass() == "prop_vehicle_jeep") then
						v:GetNetworkedEntity("owner"):AddFuel(self.CurFuel, false)
						self:EmitSound(self.Sound, 500, 100)
						self:Remove()
						break;
					end
			end
end

function ENT:OnTakeDamage(dmg)
	self:TakePhysicsDamage(dmg);
	if (self.OurHealth <= 0) then 
	self:Explode()
	return
	end
	self.OurHealth = (self.OurHealth - dmg:GetDamage())
	if (self.OurHealth <= 0) then
	self:Explode()
	return
	end
end

function ENT:Explode()
	if self.Exploding then return end
	self.Exploding = true
	local explode = ents.Create( "env_explosion" )
	explode:SetPos( self:GetPos() )
	explode:SetOwner( self.Owner )
	explode:Spawn()
	explode:SetKeyValue( "iMagnitude", "50" )
	explode:Fire( "Explode", 0, 0 )
	self:Remove()
	
end