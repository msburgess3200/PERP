


local PANEL = {};



surface.CreateFont("RealtorFont", {
	font="Tahoma",
	size=30,
	weight=1000,
	antialias=true
})

function PANEL:Init ( )
	self:SetTall(76);
	self:SetSkin("ugperp")
	
	self.Button = vgui.Create('DButton', self);
	self.Button:SizeToContents();
	self.Button:SetTall(20);
	self.Button:SetWide(60);
	self.Button:SetText('Purchase');
end

local SoldMaterial = surface.GetTextureID('PERP2/sold');

function PANEL:PerformLayout ( )
	self.Button:SetPos(self:GetWide() - 4 - self.Button:GetWide(), self:GetTall() - 4 - self.Button:GetTall());
end

function PANEL:Paint ( )
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(150, 150, 150, 255));
	
	surface.SetTexture(self.OurMat);
	surface.SetDrawColor(0, 0, 0, 255);
	surface.DrawRect(5, 5, 66, 66);
	surface.SetDrawColor(255, 255, 255, 255);
	surface.DrawTexturedRect(6, 6, 64, 64);
	
	if self.IsOwned then
		surface.SetTexture(SoldMaterial);
		surface.SetDrawColor(255, 255, 255, 150);
		surface.DrawTexturedRect(6, 6, 64, 64);
	end
	
	draw.SimpleText(self.OurName, "RealtorFont", 75, 0, Color(255, 255, 255, 255));
	
	if self.OurCost > LocalPlayer():GetCash() then
		draw.SimpleText(DollarSign() .. self.OurCost, "RealtorFont", self:GetWide() - 4, 0, Color(200, 0, 0, 255), 2);
	else
		draw.SimpleText(DollarSign() .. self.OurCost, "RealtorFont", self:GetWide() - 4, 0, Color(255, 255, 255, 255), 2);
	end
	
	draw.SimpleText(self.OurDescription or 'ERROR', "Default", 75, self:GetTall() * .5, Color(255, 255, 255, 255));
end

function PANEL:SetProperty ( ID )
	local OurTable = PROPERTY_DATABASE[ID];
	
	self.OurCost = OurTable.Cost + math.Round(OurTable.Cost * GAMEMODE.GetTaxRate_Sales());
	self.OurMat = OurTable.Texture;
	self.OurName = OurTable.Name;
	self.OurDescription = OurTable.Description;
	self.OurID = ID;
	
	self.IsOwned = false;
	local ProspectiveOwner = GetGlobalEntity('p_' .. ID);
	
	if ProspectiveOwner and ProspectiveOwner:IsValid() and ProspectiveOwner:IsPlayer() then
		self.IsOwned = true;
		self.WeOwn = LocalPlayer() == ProspectiveOwner;
	end

	if self.IsOwned then
		if !self.WeOwn then
			self.Button:SetEnabled(false);
			self.Button:SetText('Sold');
		else
			self.Button:SetText('Sell');
		end
	else
		if LocalPlayer():GetCash() < self.OurCost then
			self.Button:SetEnabled(false);
		end
	end
	
	function self.Button.DoClick ( )
		if (LocalPlayer():GetCash() > OurTable.Cost || self.WeOwn) then
			RunConsoleCommand('perp_p_b', self.OurID);
			
			if (self.WeOwn) then
				LocalPlayer():GiveCash(math.Round(OurTable.Cost * .5), true);
			else
				LocalPlayer():TakeCash(OurTable.Cost + math.Round(OurTable.Cost * GAMEMODE.GetTaxRate_Sales()), true);
			end
			
			self:GetParent():GetParent():GetParent():GetParent():Remove();
		end
	end
	
	timer.Simple(.1, LEAVE_DIALOG);
end

vgui.Register('perp2_realtor_property', PANEL);