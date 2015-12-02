
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/props_lab/powerbox02b.mdl")
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():SetMass(2000)
	
	self:SetUseType(SIMPLE_USE)
	
	self.UpSound = CreateSound(self, "plats/crane/vertical_start.wav")
	self.DownSound = CreateSound(self, "plats/crane/vertical_start.wav")
	
	self.Pulley = ents.Create("prop_physics_multiplayer")
	self.Pulley:SetModel("models/props_c17/pulleywheels_small01.mdl")
	self.Pulley:SetPos(self.Vehicle:GetPos() + self.Vehicle:GetForward() * -137 + self.Vehicle:GetUp() * 100)
	self.Pulley:SetAngles(self.Vehicle:GetAngles())
	self.Pulley:Spawn()
	self.Pulley:GetPhysicsObject():SetMass(2000)
	self.Pulley.UnBurnable = true
	
	constraint.Weld(self.Vehicle, self, 0, 0, 0, true)
	for i=1, 10 do
		constraint.Weld(self.Pulley, self.Vehicle, 0, 0, 0, true)
	end
	self:DeleteOnRemove(self.Pulley)
	
	self.LastDriver = NULL
	self.Mode = "down"
	self.LastMode = "up"
	self.On = false
	self.UnBurnable = true
	
	self.RopeLength = 0
	self.CurrentRopeLength = 0
	self.NextRopeRefresh = CurTime()
	self.NextRopeRefresh2 = CurTime()
end

function ENT:SetVehicle(objEnt)
	self.Vehicle = objEnt
	
	objEnt:DeleteOnRemove(self)
end

function ENT:RemakeRope(length)
	if(not ValidEntity(self.Hook) or not ValidEntity(self.Pulley)) then return end
	
	constraint.RemoveConstraints(self.Hook, "Rope")
	constraint.RemoveConstraints(self.Pulley, "Rope")
	
	constraint.Rope(self.Pulley, self.Hook, 0, 0, Vector(0, 0, 0), Vector(0, 0, 22), 0, math.Clamp(length, 20, 400), 0, 2, "cable/cable2", false)
end

function ENT:Think()	
	if(self.On) then
		if(self.LastMode == "down") then
			self.RopeLength = math.Clamp(self.RopeLength + 10, 0, 400)
		elseif(self.LastMode == "up") then
			self.RopeLength = math.Clamp(self.RopeLength - 10, 0, 400)
		end
		
		if(self.RopeLength == 0) then
			if(ValidEntity(self.Hook)) then
				if(not self.Hook.Weld) then
					self.Hook:Remove()
					self.Hook = nil
					
					self:Use(self.LastDriver)
				end
			end
		end
		if(self.RopeLength == 400) then
			self:Use(self.LastDriver)
		end
	end
	
	if(self.NextRopeRefresh < CurTime()) then
		if(self.RopeLength != self.CurrentRopeLength) then
			self:RemakeRope(self.RopeLength)
			
			self.CurrentRopeLength = self.RopeLength
			
			self.NextRopeRefresh = CurTime() + 0.1
		end
	end
	
	if(self.NextRopeRefresh2 < CurTime()) then
		self:RemakeRope(self.RopeLength)

		self.NextRopeRefresh2 = CurTime() + 3
	end
	
	if(self.RopeLength > 10) then
		if(not ValidEntity(self.Hook)) then
			self.Hook = ents.Create("ent_towtruck_hook")
			self.Hook:SetPos(self.Pulley:GetPos() + self.Pulley:GetRight() * -15 + self.Pulley:GetUp() * 25)
			self.Hook.Pulley = self.Pulley
			self.Hook.Vehicle = self.Vehicle
			self.Hook.Controller = self
			self.Hook:Spawn()
			self.Hook:Activate()
			self:DeleteOnRemove(self.Hook)
			
			self:RemakeRope(self.RopeLength)
		end
	end
end

function ENT:Use(driver)
	if(not driver:IsPlayer()) then return end
	if(driver:GetPos():Distance(self:GetPos()) > 100) then return end
	if(driver:Team() != TEAM_ROADCREW) then return end
	
	self.LastDriver = driver
	
	if(self.Mode == "down") then
		self.DownSound:Play()
		self.DownSound:ChangePitch(120,0)

		self.Mode = "stop"
		self.LastMode = "down"
		self.On = true
	elseif(self.Mode == "stop") then
		self.DownSound:Stop()
		self.UpSound:Stop()
		
		if(self.LastMode == "up") then
			self.Mode = "down"
		else
			self.Mode = "up"
		end
		
		self.LastDriver = NULL
		self.On = false
		self:EmitSound("plats/crane/vertical_stop.wav")
	elseif(self.Mode == "up") then
		self.UpSound:Play()
		self.UpSound:ChangePitch(80,0)
		
		self.Mode = "stop"
		self.LastMode = "up"
		self.On = true
	end
end

function ENT:OnRemove()
	self.DownSound:Stop()
	self.UpSound:Stop()
end
