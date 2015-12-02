


local PANEL = {};

function PANEL:Init ( )
	self:SetTitle("Mayorial Vote");
	self:ShowCloseButton(false);
	self:SetDraggable(false);
	self:SetAlpha(GAMEMODE.GetGUIAlpha());
	self:MakePopup()
	self:SetSkin("ugperp")
	
	self.panelList = vgui.Create("DPanelList", self);
end

function PANEL:AddPlayer ( ply )
	local accept_deny = vgui.Create("DButton", self.panelList);
	accept_deny:SetText(ply:GetRPName());
	self.panelList:AddItem(accept_deny);
		
	function accept_deny.DoClick ( )
		self:Remove();
		GAMEMODE.VotePanel = nil;
		RunConsoleCommand("perp_g_v", ply:UniqueID());
	end
end

function PANEL:PerformLayout ( )
	local w, h = 215, 150;
	self:SetSize(w, h);
	self:SetPos(ScrW() * .5 - (w * .5), ScrH() * .5 - (h * .5));
	self.panelList:StretchToParent(5, 30, 5, 5);
	
	self.BaseClass.PerformLayout(self);
end

vgui.Register("perp2_mayor_election", PANEL, "DFrame");