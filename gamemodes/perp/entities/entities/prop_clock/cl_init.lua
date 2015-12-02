
include('shared.lua')

local x = -100;
local y = -100;
local w = 200;
local h = 200;

local secondHand = surface.GetTextureID("perp2/clock/hand_skinny");
local minuteHand = surface.GetTextureID("perp2/clock/hand_long");
local hourHand = surface.GetTextureID("perp2/clock/hand_short");

local tickSound = Sound("perp2.5/clock2.mp3");

function ENT:Initialize ( )
	self.curSeconds = 0;
	self.nextAddSeconds = CurTime();
end

function ENT:Think ( )
	if (self.nextAddSeconds <= CurTime()) then
		self.curSeconds = self.curSeconds + 1;
		if (self.curSeconds == 61) then self.curSeconds = 1; end
		self.nextAddSeconds = CurTime() + 1;
		
		sound.Play(tickSound, self:GetPos(), 60);
	end
end

function ENT:Draw()
	self:DrawModel()
	
	local ang = self.Entity:GetAngles()
	
	local pos = self.Entity:GetPos() + (self.Entity:GetUp() * 3.5)
	
	// Calculate real tiems and stuff
	local perHour = DAY_LENGTH / 24;
	local perMinute = DAY_LENGTH / 1440;
	
	local hours = GAMEMODE.CurrentTime / perHour;
	local mins = (GAMEMODE.CurrentTime / perMinute) - math.floor(hours) * 60;
	
	if (hours > 12) then
		hours = hours - 12;
	end
	
	local hourRotation = (hours / 12) * -360
	local minRotation = (mins / 60) * -360
	local secRotation = (self.curSeconds / 60) * -360
	
	cam.Start3D2D(pos, ang, .05)
		surface.SetDrawColor(0, 0, 0, 255);
		
		surface.SetTexture(hourHand);
		surface.DrawTexturedRectRotated(x + w * .5, y + h * .5, w, h, 90 + hourRotation);
		
		surface.SetTexture(minuteHand);
		surface.DrawTexturedRectRotated(x + w * .5, y + h * .5, w, h, 90 + minRotation);
		
		surface.SetTexture(secondHand);
		surface.DrawTexturedRectRotated(x + w * .5, y + h * .5, w, h, 90 + secRotation);
	cam.End3D2D();
end
