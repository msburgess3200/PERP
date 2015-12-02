
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel("models/props_c17/pottery06a.mdl");

	self.Entity:SetMoveType( MOVETYPE_FLY )
	self.Entity:SetSolid( SOLID_NONE )
	self.Entity:SetAngles(Angle(0, 0, 0));
	
	
	self.SpawnT = CurTime();
	self.LastMoveThink = CurTime();
	
	local sizeMaker = math.random(1, 10);
	
	if (sizeMaker >= 9) then
		self.size = 3;
	elseif (sizeMaker >= 6) then
		self.size = 2;
	else 
		self.size = 1;
	end
	
	self:SetNetworkedInt("size", self.size);
end

function ENT:Think ( )
	if self.SpawnT + 30 < CurTime() then self:Remove(); return false; end
	
	self:PointGrav(self:GetPos() + Vector(0, 0, 512), 10000, 20000000)
	
	if self.LastMoveThink + 1 > CurTime() then return false; end
	
	local TraceDown = {};
	TraceDown.start = self:GetPos();
	TraceDown.endpos = self:GetPos() - Vector(0, 0, 10);
	TraceDown.filter = self;
	
	local TR = util.TraceLine(TraceDown);
	
	local z = 0;
	if !TR.Hit then z = -20 end
	
	self.LastMoveThink = CurTime();
	self.Entity:SetVelocity(Vector(math.random(-20, 20), math.random(-20, 20), z));
	self.Entity:NextThink(CurTime() + 5)
end

function ENT:Use( activator, caller )
	
end

function ENT:PointGrav ( Center, Radius, Force )
    local GravitySphere = ents.FindInSphere(Center, Radius)
	
    for k, v in pairs(GravitySphere) do
        if (v:IsValid() && !v:IsWorld() && v != self) then
	        local vPos = v:GetPos()
			local Mass = 1
			
			local PhysCheck = false
			local PhysObj = v:GetPhysicsObject()
			if(PhysObj:IsValid()) then
				PhysCheck = true
				Mass = PhysObj:GetMass()
			end
			
			local Calc1 = (Force * Mass) / (((Center - vPos):Length() - 64) ^ 2)
			local Calc2 = (Center - vPos):Normalize()
			local Calc3 = Calc1 * Calc2
			
			if v:IsPlayer() and v:Alive() then
				v:SetVelocity((Calc3 / 10) * self.size);
				
				if v:GetPos():Distance(Center) < 256 then
					v:Kill();
				end
			else
				if(PhysCheck == true) then
					if(v:GetClass() == "prop_vehicle_jeep") then
						local objects = v:GetPhysicsObjectCount()
						for i=0, objects-1 do
							local PhysObj2 = v:GetPhysicsObjectNum(i)
							PhysObj2:ApplyForceCenter(Calc3 * self.size)
						end
					else
						PhysObj:ApplyForceCenter(Calc3 * self.size)
					end
					
					if v:IsVehicle() and v:GetDriver() and v:GetDriver():IsValid() and v:GetDriver():IsPlayer() and v:GetPos():Distance(Center) < 256 then
						local Player = v:GetDriver();
						
						Player:ExitVehicle();
						Player:Kill();
					end
				else
					v:SetVelocity((Calc3 / 5000) * self.size)
				end
			end
        end
    end
end