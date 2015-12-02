
include('shared.lua')

function ENT:Draw()
	self:DrawEntityOutline( 1.1 )

	self:DrawModel()
end

function ENT:DrawEntityOutline( big )
	
	big = big or 1.0
	render.SuppressEngineLighting( true )
	render.SetAmbientLight( 1, 1, 1 )
	render.SetColorModulation( 1, 1, 1 )
	
		// First Outline	
		self:SetModelScale( 1 * 1.1 * big ,0)
		render.MaterialOverride( Material( "black_outline" ) )
		self:DrawModel()
		
		
		// Second Outline
		self:SetModelScale( 1 * 1 * big,0 )
		render.MaterialOverride( Material( "white_outline" ) )
		self:DrawModel()
		
		// Revert everything back to how it should be
		render.MaterialOverride( nil )
		self:SetModelScale( 1,0 )
		
	render.SuppressEngineLighting( false )
	
	local col = self:GetColor()
	render.SetColorModulation( col.r/255, col.g/255, col.b/255 )

end
