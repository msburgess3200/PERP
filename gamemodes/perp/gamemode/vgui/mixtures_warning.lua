local PANEL = {};

surface.CreateFont("MixturesWarningFont", {
	font="Tahoma",
	size=ScreenScale(10),
	weight=1000,
	antialias=true
})

local WarningTexture = surface.GetTextureID("PERP2/warning");

function PANEL:Init ( )

end

function PANEL:PerformLayout ( )
	surface.SetFont("MixturesWarningFont");
	local x, y = surface.GetTextSize("whatever.");
	self:SetHeight(y * 3);
end

function PANEL:Paint ( )
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(SKIN.control_color.r, SKIN.control_color.g, SKIN.control_color.b, SKIN.control_color.a));
	
	surface.SetDrawColor(255, 255, 255, 255);
	surface.SetTexture(WarningTexture);
	surface.DrawTexturedRect(4, 4, self:GetTall() - 8, self:GetTall() - 8)
	
	draw.SimpleText("You have not unlocked all mixtures yet!", "MixturesWarningFont", self:GetTall() + 8, self:GetTall() * .5, Color(255, 255, 255, 255), 0, 1);
end

vgui.Register('perp2_mixtures_warn', PANEL);