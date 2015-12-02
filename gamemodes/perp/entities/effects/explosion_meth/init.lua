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


local scale = .2;
	
function EFFECT:Init( data )
	
	local vOffset = data:GetOrigin()
			
	if LocalPlayer():GetPos():Distance(vOffset) < 2000 then
		sound.Play(Sound('ambient/explosions/explode_1.wav'), self:GetPos(), 160);
	end
	
	local NumParticles = 32
	
	
		for i=0, NumParticles do
		
			particle = SMOKE_EMITTER:Add( "particle/particle_smokegrenade", vOffset )
			if (particle) then
				
				local Vec = VectorRand()
				particle:SetVelocity( Vector(Vec.x, Vec.y, math.Rand(0.5,2)) * 1500 * scale)
				
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.75 * scale )
				
				particle:SetStartAlpha( 0 )
				particle:SetEndAlpha( 0 )
				
				particle:SetStartSize( 5 * scale )
				particle:SetEndSize( 5 * scale )
				
				particle:SetColor(0,0,0)
				
				//particle:SetRoll( math.Rand(0, 360) )
				//particle:SetRollDelta( math.Rand(-200, 200) )
				
				particle:SetAirResistance( 120 * scale )
				
				particle:SetGravity( Vector( 0, 0, -1000 ) * math.pow(scale, 2) )
				
				particle:SetCollide( true )
				particle:SetBounce( 0.5 )
				particle:SetThinkFunction(ParticleThink)
				particle:SetNextThink(CurTime() + 0.1)
			
			end
			
			particle2 = SMOKE_EMITTER:Add( "particles/smokey", vOffset )
			if (particle2) then
				
				local Vec2 = VectorRand()
				particle2:SetVelocity( Vector(Vec2.x, Vec2.y, math.Rand(0.1,1.5)) * 1200 * scale)
				
				particle2:SetLifeTime( 0 )
				particle2:SetDieTime( 6 )
				
				particle2:SetStartAlpha( 250 )
				particle2:SetEndAlpha( 0 )
				
				particle2:SetStartSize( 150 * scale )
				particle2:SetEndSize( 200 * scale )
				
				particle2:SetColor(150,150,140)
				
				//particle2:SetRoll( math.Rand(0, 360) )
				//particle2:SetRollDelta( math.Rand(-200, 200) )
				
				particle2:SetAirResistance( 250 * scale )
				
				particle2:SetGravity( Vector( 0, 0, -50 ) * math.pow(scale, 2) )
				
				particle2:SetLighting( true )
				particle2:SetCollide( true )
				particle2:SetBounce( 0.5 )
			
			end
			
			particle3 = SMOKE_EMITTER:Add( "particle/particle_smokegrenade", vOffset )
			if (particle3) then
				
				local Vec3 = VectorRand()
				particle3:SetVelocity( Vector(Vec3.x, Vec3.y, math.Rand(0.05,1.5)) * 500 * scale)
					
				particle3:SetLifeTime( 0 )
				particle3:SetDieTime( 1 )
				
				particle3:SetStartAlpha( 255 )
				particle3:SetEndAlpha( 0 )
					
				particle3:SetStartSize( 100 * (scale * 2) )
				particle3:SetEndSize( 120 * scale )
				
				particle3:SetColor(255,80,20)					
				particle3:SetRoll( math.Rand(0, 360) )
				particle3:SetRollDelta( math.Rand(-2, 2) )
					
				particle3:SetAirResistance( 150 )
				
				particle3:SetGravity( Vector( 0, 0, 400 ) * math.pow(scale, 2) )					
				particle3:SetCollide( true )
				particle3:SetBounce( 1 )
			
			end
			
		end
		
end


/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
	return false
end

function ParticleThink( part )

	if part:GetLifeTime() > 0.18 then 
		local vOffset = part:GetPos()	
	
		local particle = SMOKE_EMITTER:Add( "particles/smokey", vOffset )
		
		if (particle) then
		
			particle:SetLifeTime( 0 )
			particle:SetDieTime( 8 - part:GetLifeTime() * 2 )
				
			particle:SetStartAlpha( 150 )
			particle:SetEndAlpha( 0 )
				
			particle:SetStartSize( (90 - (part:GetLifeTime() * 100)) / 2 * scale )
			particle:SetEndSize( 100 - (part:GetLifeTime() * 100) * scale )
				
			particle:SetColor(150,150,140)
				
			particle:SetRoll( math.Rand(-0.5, 0.5) )
			particle:SetRollDelta( math.Rand(-0.5, 0.5) )
				
			particle:SetAirResistance( 250 * scale )
				
			particle:SetGravity( Vector( 0, 0, -100 ) * math.pow(scale, 2) )
				
			particle:SetLighting( true )
			particle:SetCollide( true )
			particle:SetBounce( 0.5 )

		end		
	end
	
	part:SetNextThink( CurTime() + 0.1 )
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()
end
