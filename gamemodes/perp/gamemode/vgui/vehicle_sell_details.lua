

local PANEL = {};

function PANEL:Init ( )
	self:SetTall(76);
	
	self.Button = vgui.Create('DButton', self);
	self.Button:SizeToContents();
	self.Button:SetTall(20);
	self.Button:SetWide(60);
	self.Button:SetText('Sell');
	self:SetSkin("ugperp")
end

function PANEL:PerformLayout ( )
	self.Button:SetPos(self:GetWide() - 4 - self.Button:GetWide(), self:GetTall() - 4 - self.Button:GetTall());
end

function PANEL:Paint ( )
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(150, 150, 150, 255))
	
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(5, 5, 66, 66)
	surface.SetTexture(self.ourMat)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(6, 6, 64, 64)
	
	draw.SimpleText(self.ourName or 'ERROR', "RealtorFont", 75, 0, Color(255, 255, 255, 255))
	
	draw.SimpleText(DollarSign() .. self.ourCost, "RealtorFont", self:GetWide() - 4, 0, Color(0, 200, 0, 255), 2)
	
	draw.SimpleText("Make: " .. self.ourTable.Make or 'ERROR', "Default", 75, self:GetTall() * .5, Color(255, 255, 255, 255))
	draw.SimpleText("Model: " .. self.ourTable.Model, "Default", 75, self:GetTall() * .7, Color(255, 255, 255, 255))
end

function PANEL:SetVehicle ( Table )
	self.ourTable = Table;
	self.ourName = Table.Name;
	self.ourCost = Table.Cost * 0.5
	self.ourID = Table.ID;
	self.ourMat = Table.Texture;
	
	local ID = self.ourID
	function self.Button.DoClick ( )	
		Derma_Query("Are you sure that you want to sell your car?\nThis action can't be undone.", "Wait a second..",
		"NOO!", function() end,
		"Yeah, sell it.", function()
			RunConsoleCommand("perp_v_sellit", ID)
			GAMEMODE.Vehicles[ID] = nil
		end)	
			
		self:GetParent():GetParent():GetParent():Remove();
	end
end

vgui.Register('perp2_vehicle_sell_details', PANEL);