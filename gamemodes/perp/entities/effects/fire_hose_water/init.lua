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

	local Entity = data:GetEntity();
		
	for i = 1, 10 do
		timer.Simple((i - 1) * .02, function ( )
			if Entity and Entity:IsValid() and Entity:IsPlayer() and Entity:Alive() then
				local p = GLOBAL_EMITTER:Add("effects/splash1", Entity:GetShootPos() + Entity:GetAimVector() * 5)
				p:SetVelocity(Entity:GetAimVector() * 1000)
				p:SetDieTime(.5)
				p:SetStartAlpha(0)
				p:SetEndAlpha(100)
				p:SetStartSize(math.random(3, 8))
				p:SetEndSize(math.random(40, 50))
				p:SetRoll( math.Rand( 0,10  ) )
				p:SetRollDelta(math.Rand( -0.2, 0.2 ))
			end
		end);
	end

end

function EFFECT:Think( )

	return false
	
end

function EFFECT:Render()

	
end



