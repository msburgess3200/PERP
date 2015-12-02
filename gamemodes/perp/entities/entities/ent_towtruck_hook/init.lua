
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/props_junk/meathook001a.mdl")
	
	self:PhysicsInit( SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():SetMass(20)
	
	self:SetUseType(ONOFF_USE)
	
	self.Weld = nil
	self.NextAttach = CurTime()
end

function ENT:Attach(obj)
	if(self.Weld) then return end
	if(self.NextAttach > CurTime()) then return end
	
	self.AttachedEntity = obj
	
	self:EmitSound("physics/metal/sawblade_stick1.wav")
	
	local eff = EffectData()
	eff:SetOrigin(self:GetPos())
	util.Effect("ManhackSparks", eff)
	
	self.Weld = constraint.Weld(self, obj, 0, 0, 0, true)
	
	self:GetPhysicsObject():SetMass(500)
	
	if(obj:IsVehicle()) then
		obj:Fire("HandBrakeOff", "", 0)
	end
end

function ENT:Detach()
	constraint.RemoveConstraints(self, "Weld")
	
	self:GetPhysicsObject():SetMass(20)
	
	self.Weld = nil
	self.NextAttach = CurTime() + 2
end

function ENT:Think()
	self:Extinguish()
	
	if(self.AttachedEntity and not ValidEntity(self.AttachedEntity)) then
		self:Detach()
		
		self.AttachedEntity = nil
	end
end

function ENT:Use(activator, caller)
	if(not activator:IsPlayer()) then return end
	if(activator:GetPos():Distance(self:GetPos()) > 100) then return end
	
	self:Detach()
end

function ENT:StartTouch(obj)
	if(obj == self.Vehicle) then return end
	if(obj == self.Pulley) then return end
	if(obj == self.Controller) then return end
	if(obj == self.Controller) then return end
	if(obj == self.Beam) then return end
	
	if(self:GetVelocity():Length() > 50) then return end
	if(obj:GetPhysicsObject() and not obj:IsPlayer() and obj != self.Vehicle and obj != game.GetWorld()) then
		self:Attach(obj)
		if(self:IsPlayerHolding()) then
			self:GetPhysicsObject():EnableMotion(false)
			timer.Simple(0.5, function()
				self:GetPhysicsObject():EnableMotion(true)
			end)
		end
	end
end
/*
hook.Add("GravGunOnPickedUp", "TowtruckHookGravGunOnPickedUp", function(objPl, obj)
	if(obj:GetClass() == "ent_towtruck_hook") then
		if(obj.Weld != nil) then
			obj:Detach()
		end
	end
end)
*/
