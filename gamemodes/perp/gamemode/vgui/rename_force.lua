


local PANEL = {};


surface.CreateFont("ForcedFont", {
	font="Tahoma",
	size=13,
	weight=1000,
	antialias=true
})

local WarningTexture = surface.GetTextureID("PERP2/warning");
function PANEL:Init ( )
	self.MonitorSkill = 'ERROR'
end

function PANEL:PerformLayout ( )
	surface.SetFont("ForcedFont");
	local x, y = surface.GetTextSize("whatever.");
	self:SetHeight(y * 1.5);
end

function PANEL:Paint ( )
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(SKIN.control_color.r, SKIN.control_color.g, SKIN.control_color.b, SKIN.control_color.a));
	
	surface.SetDrawColor(255, 255, 255, 255);
	surface.SetTexture(WarningTexture);
	surface.DrawTexturedRect(4, 4, self:GetTall() - 8, self:GetTall() - 8)
	
	draw.SimpleText("You must change your RP name.", "ForcedFont", self:GetTall() + 8, self:GetTall() * .5, Color(255, 0, 0, 255), 0, 1);
end

vgui.Register('perp2_rename_force', PANEL);