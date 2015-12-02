local PANEL = {}


surface.CreateFont("MixturesWarningFont2", {
	font="Tahoma",
	size=ScreenScale(8),
	weight=1000,
	antialias=true
})
 
local WarningTexture = surface.GetTextureID("perp2/warning")

function PANEL:Init ( )

end

function PANEL:PerformLayout ( )
	surface.SetFont("MixturesWarningFont2")
	local x, y = surface.GetTextSize("whatever.")
	self:SetHeight(y * 1 + 2)
end

function PANEL:Paint ( )
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(SKIN.control_color.r, SKIN.control_color.g, SKIN.control_color.b, SKIN.control_color.a))
	
	draw.SimpleText("Click the icons to spawn a mixture.", "MixturesWarningFont2", self:GetTall() + 8, self:GetTall() * .5, Color(255, 255, 255, 255), 0, 1)
end

vgui.Register('perp2_mixtures_tip', PANEL)