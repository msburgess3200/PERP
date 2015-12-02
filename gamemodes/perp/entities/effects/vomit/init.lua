/////////////////////////////////////////
// © 2010-2020 D3luX - D3luX-Gaming    //
//    All rights reserved    		   //
/////////////////////////////////////////
// This material may not be  		   //
//   reproduced, displayed,  		   //
//  modified or distributed  		   //
// without the express prior 		   //
// written permission of the 		   //
//   the copyright holder.  		   //
//		D3luX-Gaming.com   			   //
/////////////////////////////////////////

EFFECT.Mat = Material("effects/blood_core")

local function DecalMaker ( Particle, Pos, Norm )
	util.Decal("BeerSplash", Pos + Norm, Pos - Norm);

	Particle:SetEndSize(math.random(14, 20));
	Particle:SetEndAlpha(0);
	Particle:SetDieTime(3);
end

function EFFECT:Init ( Data )
	self.Barfer = Data:GetEntity()
	self.DieTime = CurTime() + math.Rand(.25, 1.5)
	
	if !self.Barfer or !self.Barfer:IsValid() or !self.Barfer:IsPlayer() then return false; end
	
	self.Emitter = ParticleEmitter(self.Barfer:EyePos());

	sound.Play(Sound("npc/zombie/zombie_pain3.wav"), self.Barfer:EyePos(), 75, 100);
end

function EFFECT:Think()
	if !self.Barfer or !self.Barfer:IsValid() or !self.Barfer:IsPlayer() or CurTime() > self.DieTime then self.Emitter:Finish(); return false; end
	
	local SpawnPos = self.Barfer:EyePos() + self.Barfer:EyeAngles():Forward() * 10;
	local Dir = self.Barfer:GetAimVector();

	local Particle = self.Emitter:Add("effects/blood_core", SpawnPos);

	Particle:SetVelocity((Dir + VectorRand() * 0.1) * math.Rand(200, 300));
	Particle:SetDieTime(20);
	
	Particle:SetStartAlpha(255);
	Particle:SetEndAlpha(100);
	
	Particle:SetStartSize(math.random(15, 20));
	Particle:SetEndSize(math.random(10, 15));
	
	Particle:SetColor(128, 80, 0);
	Particle:SetCollide(true);
	Particle:SetGravity(Vector(0, 0, -450));
	Particle:SetRollDelta(math.random(-10, 10));
	Particle:SetCollideCallback(DecalMaker);
	
	return true;
end

function EFFECT:Render() end

