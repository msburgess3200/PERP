


local PANEL = {};

function PANEL:Init ( )
	self:SetTitle("Organization Invitation");
	self:ShowCloseButton(true);
	self:SetDraggable(false);
	self:SetAlpha(GAMEMODE.GetGUIAlpha());
	self:MakePopup()
	self:SetSkin("ugperp")
	
	local panelList = vgui.Create("DPanelList", self);
	panelList:StretchToParent(5, 30, 5, 5);
	
	local button_deny = vgui.Create("DButton", self);
	button_deny:SetSize(100, 20);
	button_deny:SetPos(5, 60);
	button_deny:SetText("Deny");
	
	function button_deny.DoClick ( )
		self:Remove();
		GAMEMODE.InvitePanel = nil;
	end
	
	local accept_deny = vgui.Create("DButton", self);
	accept_deny:SetSize(100, 20);
	accept_deny:SetPos(110, 60);
	accept_deny:SetText("Accept");
	
	function accept_deny.DoClick ( )
		self:Remove();
		GAMEMODE.InvitePanel = nil;
		RunConsoleCommand("perp_o_a");
	end
end

function PANEL:SetOrg ( n )
	self.Org = n;
end

function PANEL:PerformLayout ( )
	local w, h = 215, 85;
	self:SetSize(w, h);
	self:SetPos(ScrW() * .5 - (w * .5), ScrH() * .5 - (h * .5));
	
	self.BaseClass.PerformLayout(self);
end

function PANEL:Paint ( )
	self.BaseClass.Paint(self);
	
	if (self.Org) then
		draw.SimpleText("You Have Been Invited To", "Default", self:GetWide() * .5, 30, Color(255, 255, 255, 200), 1, 1);
		draw.SimpleText(self.Org, "Default", self:GetWide() * .5, 45, Color(255, 255, 255, 200), 1, 1);
	end
end

vgui.Register("perp2_invite", PANEL, "DFrame");