include('shared.lua')

function ENT:Draw()
	self:DrawModel();
end

function ENT:Think ( )
	self.OriginalPos = self.OriginalPos or self:GetPos();
	
	self:SetPos(self.OriginalPos + Vector(0, 0, math.sin(CurTime()) * 2.5));
	
	if (self.NextChangeAngle <= CurTime()) then
		self:SetAngles(self:GetAngles() + Angle(0, .25, 0));
		self.NextChangeAngle = self.NextChangeAngle + (1 / 60)
	end
end

function ENT:Initialize ( )	
	self.NextChangeAngle = CurTime();
end
