
include('shared.lua')

function ENT:Initialize ()

end

function ENT:Draw()
	self:DrawModel()
end

local sound = Sound("perp2.5/metal_detector.mp3")
local function metalDetectorUMsg ( uMsg )
	local ent = uMsg:ReadEntity()
	
	sound.Play(sound, ent:GetPos(), 100, 100)
end
usermessage.Hook("perp_metal_det", metalDetectorUMsg)