


local PANEL = {};

local WarningTexture = surface.GetTextureID("PERP2/warning");

function PANEL:Init ( )
	self:SetSkin("ugperp")
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
	
	draw.SimpleText("You have been blacklisted from using this feature.", "MixturesWarningFont", self:GetTall() + 8, self:GetTall() * .3, Color(255, 255, 255, 255), 0, 1);
	
	local expired = LocalPlayer():HasBlacklist('a');
	
	if (expired == 0) then
		draw.SimpleText("Date Lifted: Never", "Default", self:GetTall() + 8, self:GetTall() * .6, Color(255, 255, 255, 255), 0, 1);
	else
		if (GAMEMODE.Options_EuroStuff:GetBool()) then
			draw.SimpleText("Date Lifted: " .. os.date("%B %d, 20%y at %H:%M", expired), "Default", self:GetTall() + 8, self:GetTall() * .6, Color(255, 255, 255, 255), 0, 1);
		else
			draw.SimpleText("Date Lifted: " .. os.date("%B %d, 20%y at %I:%M %p", expired), "Default", self:GetTall() + 8, self:GetTall() * .6, Color(255, 255, 255, 255), 0, 1);
		end
	end
end

vgui.Register('perp2_reportbl_warn', PANEL);