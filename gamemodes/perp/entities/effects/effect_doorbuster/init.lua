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

function EFFECT:Init(data)
	local pos = data:GetOrigin() + Vector(0, 0, 15)

	local emitter = ParticleEmitter(pos)
		for i=1, 250 do
			local particle = emitter:Add("effects/fire_cloud1", pos)
			particle:SetVelocity(Vector(math.random(-75,75),math.random(-75,75),math.random(-75,75)):Normalize() * 500)
			particle:SetAirResistance(15)
			particle:SetCollide(true)
			particle:SetBounce(0.2)
			particle:SetDieTime(1.2)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(25)
			particle:SetEndSize(50)
			particle:SetRoll(math.Rand(0, 360))
		end
		for i=1, 250 do
			local particle = emitter:Add("sprites/heatwave", pos)
			particle:SetVelocity(Vector(math.random(-75,75),math.random(-75,75),math.random(-75,10)):Normalize() * 1000)
			particle:SetAirResistance(math.random(100, 200))
			particle:SetCollide(true)
			particle:SetBounce(0.2)
			particle:SetGravity(Vector(0, 0, 25))
			particle:SetDieTime(6)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255)
			particle:SetStartSize(75)
			particle:SetEndSize(0)
			particle:SetRoll(math.Rand(0, 360))
		end
		for i=1, 75 do
			local particle = emitter:Add("effects/fire_cloud1", pos)
			particle:SetVelocity(Vector(math.random(-5,5),math.random(-5,5),math.random(100,200)))
			particle:SetAirResistance(25)
			particle:SetCollide(true)
			particle:SetBounce(0.2)
			particle:SetDieTime(1.2)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(25)
			particle:SetEndSize(75)
			particle:SetRoll(math.Rand(0, 360))
		end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
