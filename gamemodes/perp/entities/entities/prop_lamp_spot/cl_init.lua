
include('shared.lua')

local matLight 		= Material( "sprites/light_ignorez" )

function ENT:Initialize ( )
	self.pv = util.GetPixelVisibleHandle();
end

function ENT:Draw()
	if (self:GetNetworkedBool("show_spot", false)) then
			local truePos = self:LocalToWorld(Vector(9, 0, 4));

			local ViewNormal = truePos - EyePos()
			local Distance = ViewNormal:Length()
			ViewNormal:Normalize()
			local LightPos = truePos + ViewNormal * -6

			render.SetMaterial( matLight )
			
			local Visibile	= util.PixelVisible(LightPos, 16, self.pv)	
			if (!Visibile) then return end
				
			local Size = math.Clamp(Distance * Visibile * 2, 64, 512)
				
			Distance = math.Clamp(Distance, 32, 800);
			local Alpha = math.Clamp((1000 - Distance) * Visibile, 0, 100);
			local r, g, b = self:GetColor();
			local Col = Color(r, g, b, Alpha);
				
			render.DrawSprite(LightPos, Size, Size, Col, Visibile)
			render.DrawSprite(LightPos, Size * 0.4, Size * 0.4, Col, Visibile);
	end
	
	self:DrawModel();
end

