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
				local p = GLOBAL_EMITTER:Add("effects/extinguisher", Entity:GetShootPos() + Entity:GetAimVector() * 20)
				p:SetVelocity(Entity:GetAimVector() * 500)
				p:SetDieTime(1)
				p:SetStartAlpha(0)
				p:SetEndAlpha(100)
				p:SetStartSize(5)
				p:SetEndSize(40)
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



