

local PANEL = {};

function PANEL:Init ( )
	self.theirCashOffers = vgui.Create("DTextEntry", self);
		self.theirCashOffers:SetNumeric(true);
		self.theirCashOffers:SetEditable(false);
		self.theirCashOffers:SetText("0");  

	self.ourCashOfferss = vgui.Create("DTextEntry", self:GetParent());
		self.ourCashOfferss:SetNumeric(true);
		self.ourCashOfferss:SetText("0");	
	
	//self:SetSkin("ugperp")
end

function PANEL:PerformLayout ( )	
	local bufferSize = 5;
	
	local spaceAllotedPer = (self:GetWide() - (bufferSize * 4)) / 3;
	
	local x, y = self:GetPos()
	self.ourCashOfferss:SetPos(x + bufferSize * 2 + spaceAllotedPer * 1.5, y + bufferSize * 1.5);
	self.ourCashOfferss:SetSize(spaceAllotedPer * .5 - bufferSize, self:GetTall() - bufferSize * 3);
	
	self.theirCashOffers:SetPos(bufferSize * 3 + spaceAllotedPer * 2.5, bufferSize * 1.5);
	self.theirCashOffers:SetSize(spaceAllotedPer * .5 - bufferSize, self:GetTall() - bufferSize * 3);
	
	self:MakePopup()
	self.ourCashOfferss:MakePopup()
end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
	
	surface.SetDrawColor(0, 0, 0, 255);
	surface.DrawOutlinedRect(4, 4, self:GetWide() - 8, self:GetTall() - 8);
	
	surface.SetDrawColor(54, 54, 54, 255);
	surface.DrawRect(5, 5, self:GetWide() - 10, self:GetTall() - 10);
	
	draw.SimpleText("Trading With: " .. GAMEMODE.TradingWith:GetRPName(), "Default", 10, self:GetTall() * .5, Color(255, 255, 255, 255), 0, 1);
	
	local spaceAllotedPer = (self:GetWide() - 20) / 3;
	
	local ourVal = tonumber(self.ourCashOfferss:GetValue() or 0) or 0;
	
	draw.SimpleText("Your Cash Offer: ", "Default", 5 + spaceAllotedPer * 1.5, self:GetTall() * .5, Color(255, 255, 255, 255), 2, 1);
	draw.SimpleText("Their Cash Offer: ", "Default", 10 + spaceAllotedPer * 2.5, self:GetTall() * .5, Color(255, 255, 255, 255), 2, 1);
	
	if (ourVal > LocalPlayer():GetCash()) then
		self.ourCashOfferss:SetTextColor(Color(255, 0, 0, 255));
	elseif (ourVal < 0) then
		self.ourCashOfferss:SetTextColor(Color(255, 0, 0, 255));
	elseif (math.ceil(ourVal) != math.floor(ourVal)) then
		self.ourCashOfferss:SetTextColor(Color(255, 0, 0, 255));
	elseif (!self.lastSendCash || self.lastSendCash != ourVal) then
		self.lastSendCash = ourVal;
		GAMEMODE.OurOffer_Cash = ourVal;
		RunConsoleCommand("perp_t_d", ourVal);
		
		GAMEMODE.Trade_WeAccepted 		= nil;
		GAMEMODE.Trade_TheyAccepted 	= nil;
	
		self.ourCashOfferss:SetTextColor(Color(0, 0, 0, 255));
	else
		self.ourCashOfferss:SetTextColor(Color(0, 0, 0, 255));
	end
end

vgui.Register("perp2_trade_cash", PANEL);