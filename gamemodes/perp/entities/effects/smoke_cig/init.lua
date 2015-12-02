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

local SmokeSize = 1;

function EFFECT:Init(data)
	local Position = data:GetOrigin();
	local Emitter = ParticleEmitter(Position);

	for i = 1, 5 do
		local Particle = Emitter:Add("particle/particle_smokegrenade", Position);
		local ShadesOfGray = math.random(220, 240);
		
		if Particle then
			Particle:SetVelocity((Vector(0, 0, 3) * math.random(5, 10)) + (VectorRand() * 2));
			
			Particle:SetLifeTime(0);
			Particle:SetDieTime(math.Rand(5, 7));
			
			Particle:SetColor(ShadesOfGray, ShadesOfGray, ShadesOfGray);
			Particle:SetStartAlpha(math.random(200, 255));
			Particle:SetEndAlpha(0);
			
			Particle:SetStartSize(math.Rand(20, 25));
			Particle:SetEndSize(math.Rand(10, 15));
			
			Particle:SetRoll(math.Rand(-180, 180));
			Particle:SetRollDelta(math.Rand(-.2, .2));
			
			//Particle:SetAirResistance(math.Rand(520, 620));
			Particle:SetGravity(Vector(0, 0, 0));
			
			//Particle:SetCollide(true);
			//Particle:SetBounce(.42);
			
			Particle:SetLighting(1);
		end
	end
		
	Emitter:Finish()
end

function EFFECT:Think( )
	return false;
end

function EFFECT:Render()

end

