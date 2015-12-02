
include('shared.lua')

local x = -50;
local y = -50;
local w = 100;
local h = 100;

local hand = surface.GetTextureID("perp2/clock/hand_long");

function ENT:Initialize ( )

end

function ENT:Draw()
	self:DrawModel()
	
	local handRotation = (GetGlobalInt("temp", 35) / 100) * -270
	
	for i = 0, 1 do
		local ang = self.Entity:GetAngles();
		
		ang:RotateAroundAxis(ang:Forward(), 90);
		ang:RotateAroundAxis(ang:Right(), -90 + (i * 180));
		
		local pos = self.Entity:GetPos() + (self.Entity:GetUp() * 1) + (self.Entity:GetForward() * (1 - (i * 2)))
		
		cam.Start3D2D(pos, ang, .05)
			surface.SetDrawColor(0, 0, 0, 175);
			
			surface.SetTexture(hand);
			
			surface.DrawTexturedRectRotated(x + w * .5, y + h * .5, w, h, 135 + handRotation);
		cam.End3D2D();
	end
end
