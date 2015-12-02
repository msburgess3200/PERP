

include('shared.lua')

local sirenPos = {Vector(-6527.918945, -8544.065430, 1261.234253), Vector(922.109436, 4752.591797, 913.729919), Vector(3499.881104, -6526.524414, 464.601379)};

function ENT:Draw()

end

function ENT:Think ( )
	if self.NextWindGust < CurTime() then
		self.NextWindGust = CurTime() + 2
		sound.Play('ambient/wind/windgust.wav', self:GetPos() + Vector(0, 0, 20), math.random(75, 100), 100);
	end
	
	if (self:GetNetworkedInt("size", 0) != 0 && !self.madeEffect) then
		local Effect = EffectData();
			Effect:SetEntity(self);
			Effect:SetScale(self:GetNetworkedInt("size", 0));
		util.Effect('tornado', Effect);
		
		self.madeEffect = true;
	end
	
	if (self.nextThrowSirenSound < CurTime()) then
		for _, pos in pairs(sirenPos) do
			sound.Play('perp2.5/tsiren.mp3', pos, 150, 100);
			self.nextThrowSirenSound = CurTime() + SoundDuration('perp2.5/tsiren.mp3');
		end
	end
end

function ENT:Initialize ( )	
	self:DrawShadow(false);
	
	self.NextWindGust = 0;
	
	self.nextThrowSirenSound = CurTime() + 5
end
