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
	local Pos = data:GetOrigin() + Vector(0, 0, 15);

	local p = SMOKE_EMITTER:Add("effects/extinguisher", Pos)
	p:SetVelocity(Vector(math.random(-.1,.1),math.random(-.1,.1), math.random(1, 2)))
	p:SetDieTime(5)
	p:SetStartAlpha(50)
	p:SetEndAlpha(0)
	p:SetStartSize(1)
	p:SetEndSize(5)
	p:SetRoll( math.Rand( 0,10  ) )
	p:SetRollDelta(math.Rand( -0.2, 0.2 ));
end

function EFFECT:Think( )

	return false
	
end

function EFFECT:Render()

	
end



