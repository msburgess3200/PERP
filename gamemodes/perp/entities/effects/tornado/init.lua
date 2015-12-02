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

function EFFECT:Init( data )

	self.scale	= data:GetScale() or 1
	self.ent 	= data:GetEntity() 

	self.particles = {}
	
	self.nextEmit = CurTime()
	self.nextPhys = CurTime() - 1
end

function EFFECT:Think()
	if (!self.ent || !IsValid(self.ent)) then
		return false;
	end

	local curPos = self.ent:GetPos();
	
	if (self.nextEmit < CurTime()) then
		self.nextEmit = CurTime() + 0.75
		
		for i = 0, 29 do
			local rad = math.rad(math.Rand(0, 360))
   			local height = math.random(math.Clamp(1 - self.scale, 0, 1) * 2048, 2048)			
			local radius = ((height / 500) ^ 3) * (6 * math.Clamp(self.scale, 0.1, 5)) + (36 * (2 ^ math.Clamp(self.scale, 0.1, 5)))
			local origin = (radius * Vector(math.sin(rad), math.cos(rad), 0)) + Vector(0, 0, height)						
			local particle = SMOKE_EMITTER:Add("particle/tornado_smoke", (curPos - Vector(0,0,50)) + origin)
			
			if (particle) then
				particle:SetDieTime(math.Rand(4.00, 5.25))
				particle:SetStartAlpha(150 * math.Clamp( (self.scale/0.25),0,1))
				particle:SetEndAlpha(150 * math.Clamp( (self.scale/0.25),0,1))
				particle:SetStartSize(16 * math.Clamp(self.scale,0.1,5) * (height^0.375))
				particle:SetEndSize(16 * math.Clamp(self.scale,0.1,5) * (height^0.375))
				particle:SetGravity(Vector(0,0,0))
				particle:SetVelocity(Vector(0,0,0))
				particle:SetRoll( math.Rand(-0.5,0.5) )
				particle:SetRollDelta( math.Rand(0,1.0) )
				particle:SetColor(50, 50, 50, 255);
								
				table.insert(self.particles, particle)
			end
		end
	end
	
	if (self.nextPhys < CurTime()) then
		self.nextPhys = CurTime() + 0.25
		
		for index, each in pairs(self.particles) do
			if (each:GetLifeTime() > 0.01 && ((each:GetLifeTime() + 0.1) < each:GetDieTime())) then
				local vec = curPos - each:GetPos();
				local vec2 = Vector(vec.x, vec.y, 0) * (((1 - ((vec.z * -1) / 2048)) + 0.075) * 2.15)
				each:SetGravity(vec2 * ((1 - (vec.z * -1) / 2048) * 2))
				vec2:Rotate(Angle(0, -90, 0))
				each:SetVelocity(vec2)
			else
				self.particles[index] = nil;
			end
		end
	end
			
	return true 
end

function EFFECT:Render() 				 
end

