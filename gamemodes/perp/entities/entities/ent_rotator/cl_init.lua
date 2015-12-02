include('shared.lua')

/*---------------------------------------------------------
   Name: DrawTranslucent
   Desc: Draw translucent
---------------------------------------------------------*/
function ENT:Draw()

end

function ENT:Think ( )	

end

function ENT:Initialize ( )
	self:SetNotSolid(true)
	self:SetNoDraw(true)
	self:DrawShadow(false)

end

function ENT:OnRemove ( )

end
