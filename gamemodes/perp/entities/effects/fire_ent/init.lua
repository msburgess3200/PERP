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


local function collideCallback ( particle )
	particle:SetDieTime(10);
end


function EFFECT:Init( data )

	local Pos = data:GetOrigin() - Vector(0, 0, 5)
	local emitter = GLOBAL_EMITTER
	
	local Trace = {};
	Trace.start = Pos;
	Trace.endpos = Pos + Vector(0, 0, 500)
	Trace.mask = MASK_VISIBLE;
	
	local TR = util.TraceLine(Trace);
	


	if (!GAMEMODE.Options_DisableFireSmoke:GetBool()) then
		// Fire Parameters
		p = GLOBAL_EMITTER:Add( "effects/perp2_flame",Pos);
		// Smoke Parameters
		s = SMOKE_EMITTER:Add("particle/tornado_smoke", Pos + Vector(0, 0, 70));
		// Fiery Smoke Parameters
		e = SMOKE_EMITTER:Add("particle/tornado_smoke", Pos + Vector(0, 0, 40));
	else
		// Fire Parameters
		p = GLOBAL_EMITTER:Add( "effects/perp2_flame",Pos);
	end;
	
	if TR.Hit then
		if (!GAMEMODE.Options_DisableFireSmoke:GetBool()) then
			p:SetVelocity(Vector(math.random(-30,30),math.random(-30,30), math.random(0, 70)))
			s:SetVelocity(Vector(math.random(-30,30),math.random(-30,30), math.random(0, 70)))
			e:SetVelocity(Vector(math.random(-30,30),math.random(-30,30), math.random(0, 70)))
		else
			p:SetVelocity(Vector(math.random(-30,30),math.random(-30,30), math.random(0, 70)))
		end;
	else
		if (!GAMEMODE.Options_DisableFireSmoke:GetBool()) then
			p:SetVelocity(Vector(math.random(-30,-20),math.random(20,30), math.random(0, 70)))
			s:SetVelocity(Vector(math.random(-30,-20),math.random(20,30), math.random(0, 70)))
			e:SetVelocity(Vector(math.random(-30,-20),math.random(20,30), math.random(0, 70)))
		else
			p:SetVelocity(Vector(math.random(-30,-20),math.random(20,30), math.random(0, 70)))
		end;
	end
	
	if (!GAMEMODE.Options_DisableFireSmoke:GetBool()) then
		// Fire Emitter
		p:SetDieTime(math.Rand(2, 3))
		p:SetStartAlpha(230)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(70, 80))
		p:SetEndSize(10)
		p:SetRoll( math.Rand( 0,10  ) )
		p:SetRollDelta(math.Rand( -0.2, 0.2 ))
		// Smoke Emitter
		s:SetDieTime(math.Rand(2, 30))
		s:SetStartAlpha(230)
		s:SetEndAlpha(0)
		s:SetStartSize(math.random(50, 80))
		s:SetEndSize(200)
		s:SetRoll( math.Rand( 0,10  ) )
		s:SetRollDelta(math.Rand( -0.2, 0.2 ))
		// Flaming Smoke Effect
		e:SetColor(math.Rand(200,240),math.Rand(80,120),0,math.Rand(100,200));
		e:SetDieTime(math.Rand(2, 10))
		e:SetStartAlpha(100)
		e:SetEndAlpha(0)
		e:SetStartSize(math.random(50, 80))
		e:SetEndSize(150)
		e:SetRoll( math.Rand( 0,10  ) )
		e:SetRollDelta(math.Rand( -0.2, 0.2 ))
	else
		// Fire Emitter
		p:SetDieTime(math.Rand(2, 3))
		p:SetStartAlpha(230)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(70, 80))
		p:SetEndSize(10)
		p:SetRoll( math.Rand( 0,10  ) )
		p:SetRollDelta(math.Rand( -0.2, 0.2 ))
	end;
	
	if TR.Hit and math.sin(CurTime() * 5) >= .5 then
		local p = SMOKE_EMITTER:Add("effects/extinguisher", Pos + Vector(math.random(-40,40),math.random(-40,40), math.random(50, 100)))
		p:SetVelocity(Vector(math.random(-20,20),math.random(-20,20), math.random(20, 40)))
		p:SetDieTime(20)
		p:SetStartAlpha(20)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(40, 50))
		p:SetEndSize(200)
		p:SetRoll( math.Rand( 0,10  ) )
		p:SetRollDelta(math.Rand( -0.2, 0.2 ));
	elseif TR.Hit and math.sin(CurTime() * 5) <= -.5 then
		local p = SMOKE_EMITTER:Add("effects/extinguisher", Pos + Vector(math.random(-40,40),math.random(-40,40), math.random(50, 100)))
		p:SetVelocity(Vector(math.random(-30,30),math.random(-30,30), math.random(0, 5)))
		p:SetDieTime(math.random(20, 30))
		p:SetStartAlpha(20)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(40, 50))
		p:SetEndSize(200)
		p:SetCollideCallback(collideCallback)
		p:SetCollide(true);
		p:SetBounce(15);
		p:SetRoll( math.Rand( 0,10  ) )
		p:SetRollDelta(math.Rand( -0.2, 0.2 ));
	end
end

function EFFECT:Think( )

	return false
	
end

function EFFECT:Render()

	
end



