
include('shared.lua')

function ENT:Initialize ()
	self.aps = 5
	self.lastRot = CurTime()
	self.curRot = 0
end

function ENT:Draw()
	if (self:GetNetworkedBool("smoking", false)) then
		local effect = EffectData();
			effect:SetOrigin(self:GetPos());
		util.Effect("meth_smoke", effect);
	end
	
	if (self:GetNetworkedString("title", "") != "") then
		self:DrawModel()
		
		self.curRot = self.curRot + (self.aps * (CurTime() - self.lastRot))
		if (self.curRot > 360) then self.curRot = self.curRot - 360 end
		self.lastRot = CurTime()
		
		local priceText = "$" .. self:GetNetworkedInt("price", -1)
		local priceColor = Color(255, 255, 255, 255)
		if (self:GetNetworkedInt("price", -1) == -1) then
			priceText = "Not For Sale"
			priceColor = Color(255, 150, 150, 255)
		elseif (LocalPlayer():GetCash() < self:GetNetworkedInt("price", -1)) then
			priceColor = Color(255, 150, 150, 255)
		end
		
		cam.Start3D2D(self:LocalToWorld(self:GetNetworkedVector("maxs", Vector(0, 0, 0))) + Vector(0, 0, 5), Angle(180, self.curRot, -90), .5)
                draw.DrawText(self:GetNetworkedString("title", ""), "ScoreboardText", 0, -25, Color(255, 255, 255, 255), 1, 1)
                draw.DrawText(priceText, "ScoreboardText", 0, -15, priceColor, 1, 1)
        cam.End3D2D()
		
		cam.Start3D2D(self:LocalToWorld(self:GetNetworkedVector("maxs", Vector(0, 0, 0))) + Vector(0, 0, 10), Angle(180, self.curRot + 180, -90), .5)
                draw.DrawText(self:GetNetworkedString("title", ""), "ScoreboardText", 0, -25, Color(255, 255, 255, 255), 1, 1)
                draw.DrawText(priceText, "ScoreboardText", 0, -15, priceColor, 1, 1)
        cam.End3D2D()
	else
		if ( LocalPlayer():GetEyeTrace().Entity == self.Entity && EyePos():Distance( self.Entity:GetPos() ) < 512 ) then
			self:DrawEntityOutline( 1.1 )
		end
		
		self:DrawModel()
	end
end

local matOutlineWhite 	= Material( "white_outline" )
local ScaleNormal		= 1.1
local ScaleOutline1		= 1
local ScaleOutline2		= 1.1
local matOutlineBlack 	= Material( "black_outline" )

function ENT:DrawEntityOutline( size )
	
	size = size or 1.0
	render.SuppressEngineLighting( true )
	render.SetAmbientLight( 1, 1, 1 )
	render.SetColorModulation( 1, 1, 1 )
	
		// First Outline	
		self:SetModelScale( ScaleOutline2 * size,0)
		render.MaterialOverride( matOutlineBlack )
		self:DrawModel()
		
		
		// Second Outline
		self:SetModelScale( ScaleOutline1 * size,0)
		render.MaterialOverride( matOutlineWhite )
		self:DrawModel()
		
		// Revert everything back to how it should be
		render.MaterialOverride( nil )
		self:SetModelScale( ScaleNormal,0)
		
	render.SuppressEngineLighting( false )
	
	local col = self:GetColor()
	render.SetColorModulation( col.r/255, col.g/255, col.b/255 )

end
