



local PANEL = {};

function PANEL:Init ( )
	self.AcceptButton = vgui.Create("DButton", self);
	self.AcceptButton:SetText("Accept Offer");
	
	self.CloseButton = vgui.Create("DButton", self);
	self.CloseButton:SetText("Close Trade");
	
	//self:SetSkin("ugperp")
	
	function self.CloseButton.DoClick ( )
		RunConsoleCommand("perp_t_c");
		GAMEMODE.CancelTrade();
	end
	
	function self.AcceptButton.DoClick ( )
		if (!GAMEMODE.Trade_WeAccepted) then
			RunConsoleCommand("perp_t_ag");
			GAMEMODE.Trade_WeAccepted = true;
		end
		
		if (GAMEMODE.Trade_TheyAccepted) then
			GAMEMODE.FinishTrade();
		end
	end
end

function PANEL:PerformLayout ( )	
	local bufferSize = 5;
	
	local buttonSize = (self:GetWide() - (bufferSize * 3)) * .5
	self.AcceptButton:SetPos(bufferSize, bufferSize);
	self.AcceptButton:SetSize(buttonSize, self:GetTall() - bufferSize * 2);
	self.CloseButton:SetPos(bufferSize * 2 + buttonSize, bufferSize);
	self.CloseButton:SetSize(buttonSize, self:GetTall() - bufferSize * 2);
end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
	
	self.AcceptButtonText = self.AcceptButtonText or "Accept Offer";
	if (GAMEMODE.Trade_WeAccepted) then
		if (self.AcceptButtonText != "Waiting On Other Player") then
			self.AcceptButtonText = "Waiting On Other Player";
			self.AcceptButton:SetText("Waiting On Other Player");
		end
	elseif (GAMEMODE.Trade_TheyAccepted) then
		if (self.AcceptButtonText != "Accept Offer - They've Accepted") then
			self.AcceptButtonText = "Accept Offer - They've Accepted";
			self.AcceptButton:SetText("Accept Offer - They've Accepted");
		end
	elseif (self.AcceptButtonText != "Accept Offer") then
		self.AcceptButtonText = "Accept Offer";
		self.AcceptButton:SetText("Accept Offer");
	end
end


vgui.Register("perp2_trade_buttons", PANEL);