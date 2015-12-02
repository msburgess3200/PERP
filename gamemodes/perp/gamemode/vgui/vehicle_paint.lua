

 
local PANEL = {};

function PANEL:Init ( )
	self:SetTall(20);
	
	self.Button = vgui.Create('DButton', self);
	self.Button:SizeToContents();
	self.Button:SetText('Paint');
	self:SetSkin("ugperp")
end

function PANEL:PerformLayout ( )
	self.Button:SetTall(self:GetTall());
	self.Button:SetWide(self:GetWide() - self:GetTall() - 4);
	self.Button:SetPos(self:GetTall() + 4, 0);
end

function PANEL:Paint ( )
	if !self.OurColor then return false; end
	
	if !self.OurColor.r then
		local Gogo = self:GetTall() - 4
	
		surface.SetDrawColor(0, 0, 0, 255);
		surface.DrawRect(0, 1, self:GetTall() - 2, self:GetTall() - 2);
		surface.SetDrawColor(self.OurColor[1].r, self.OurColor[1].g, self.OurColor[1].b, self.OurColor[1].a);
		surface.DrawRect(1, 2, self:GetTall() - 4, math.floor(Gogo * .5));
		surface.SetDrawColor(self.OurColor[2].r, self.OurColor[2].g, self.OurColor[2].b, self.OurColor[2].a);
		surface.DrawRect(1, 2 + math.floor(Gogo * .5), self:GetTall() - 4, math.ceil(Gogo * .5));
	else
		surface.SetDrawColor(0, 0, 0, 255);
		surface.DrawRect(0, 1, self:GetTall() - 2, self:GetTall() - 2);
		surface.SetDrawColor(self.OurColor.r, self.OurColor.g, self.OurColor.b, self.OurColor.a);
		surface.DrawRect(1, 2, self:GetTall() - 4, self:GetTall() - 4);
	end
end

function PANEL:DoSetup ( Text, OurColor, Function, Ga )
	self.Button:SetText(Text);
	self.OurColor = OurColor;
	
	function self.Button.DoClick ( )
		GAMEMODE.DialogPanel:ClearDialog();
		Function(Ga);
	end
end


vgui.Register('perp2_vehicle_paint', PANEL);