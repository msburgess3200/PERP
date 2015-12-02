

local PANEL = {};

function PANEL:Init ( )

end

function PANEL:PerformLayout ( )	

end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
	
	surface.SetDrawColor(0, 0, 0, 255);
	surface.DrawOutlinedRect(4, 4, self:GetWide() - 8, self:GetTall() - 8);
	
	surface.SetDrawColor(54, 54, 54, 255);
	surface.DrawRect(5, 5, self:GetWide() - 10, self:GetTall() - 10);
	
	draw.SimpleText(self.Title or "Unnamed Shop", "Default", self:GetWide() * .5, self:GetTall() * .5, Color(255, 255, 255, 255), 1, 1);
end

vgui.Register("perp2_shop_title", PANEL);