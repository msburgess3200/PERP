
AddCSLuaFile("cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/asteriskgaming/perpx/road_spikes.mdl")
	
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self:DrawShadow(false)
	
	self:SetNWBool("deployed", true)
	
	self.ActiveTime = CurTime()
end

function ENT:RemoveSpikes()
	self:SetNWBool("deployed", false)
	timer.Simple(1, function()
		self:Remove()
		self = nil
	end)
end

function ENT:Think(ent)
	if(not self.OwnerID) then self:Remove() return end
	local bRemove = true
	for k, v in pairs(player.GetAll()) do
		if(v:SteamID() == self.OwnerID) then
			bRemove = false
		end
	end
	if(bRemove) then self:Remove() return end
	
	local tr = {}
	tr.start = self:GetPos() + self:OBBMins() + Vector(0, 0, 20)
	tr.endpos = self:GetPos() + self:OBBMaxs() + Vector(0, 0, 20)
	tr.filter = {self}
	local tr = util.TraceLine(tr)
	local ent = tr.Entity
	
	local tr2 = {}
	tr2.start = self:GetPos() + self:OBBMins() + Vector(0, 0, 50)
	tr2.endpos = self:GetPos() + self:OBBMaxs() + Vector(0, 0, 50)
	tr2.filter = {self}
	local tr2 = util.TraceLine(tr2)
	local ent2 = tr2.Entity
	
	local objEnt = NULL
	
	if(ValidEntity(ent2) and ent2:IsVehicle()) then
		objEnt = ent
	elseif(ValidEntity(ent) and ent:IsVehicle()) then
		objEnt = ent
	end
	
	if(not ValidEntity(objEnt) ) then return end
	
	if(self.ActiveTime + 0.66 > CurTime()) then return end
	
	if(objEnt:IsVehicle() and objEnt:GetVelocity():Length() > 5 and objEnt:GetDriver():IsValid() and not objEnt.TiresBroken) then
		objEnt:EmitSound("weapons/flaregun/fire.wav")
		objEnt:BreakTires()
	end
end
