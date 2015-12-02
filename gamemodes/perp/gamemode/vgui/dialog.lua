


local PANEL = {};

function PANEL:Init ( )
	self.DialogButtons = {};
	self.DialogLabels = {};
	self:SetSkin("ugperp")
	
	self.TextHolder = vgui.Create("DPanelList", self);
	self.TextHolder:EnableHorizontal(false)
	self.TextHolder:EnableVerticalScrollbar(true)
	self.TextHolder:SetPadding(0);
	self.TextHolder:SetSpacing(-5);
	
	self.DialogHolder = vgui.Create("DPanelList", self);
	self.DialogHolder:EnableHorizontal(false)
	self.DialogHolder:EnableVerticalScrollbar(true)
	self.DialogHolder:SetPadding(5);
	self.DialogHolder:SetSpacing(5);
	
	self.FaceBackground = vgui.Create("DPanelList", self);
	
	self.ModelPanel = vgui.Create('DModelPanel', self);
	self.ModelPanel:SetFOV(70);
	self.ModelPanel:SetCamPos(Vector(14, 0, 60));
	function self.ModelPanel:LayoutEntity( Entity ) end
	
	self:SetAlpha(GAMEMODE.GetGUIAlpha());
end

function PANEL:PerformLayout ( )	
	surface.SetFont("default");
	_, self.TextHeight = surface.GetTextSize("blabla");

	local MaxW, MaxH = ScrW() * .4, ScrH() * .2;
	self:SetPos(ScrW() * .5 - MaxW * .5, ScrH() - MaxH * 1.5);
	self:SetSize(MaxW, MaxH);
	
	self.FaceBackground:SetPos(3, 3);
	self.FaceBackground:SetSize(MaxH - 6, MaxH - 6);
	self.ModelPanel:SetPos(3, 3);
	self.ModelPanel:SetSize(MaxH - 6, MaxH - 6);
	
	self.DialogHolder:StretchToParent(MaxH, 6 + self.TextHeight * 4, 3, 3);
	self.TextHolder:SetPos(MaxH, 3);
	self.TextHolder:SetSize(self:GetWide() - 3 - MaxH, self.TextHeight * 4);
	
	for k, v in pairs(self.DialogLabels) do
		self.TextHolder:RemoveItem(v);
		v:Remove();
	end
	self.DialogLabels = {};
	
	if (self.Dialog) then
		local explodedResults = string.Explode("\n", self.Dialog);
			
		for k, v in pairs(explodedResults) do
			local splitResults = cutLength(v, self.TextHolder:GetWide() + 15, "Default");
				
			for _, txt in pairs(splitResults) do
				local newLabel = vgui.Create("DLabel", self.TextHolder);
				newLabel:SetText("  " .. txt);
				self.TextHolder:AddItem(newLabel);
				
				table.insert(self.DialogLabels, newLabel);
			end
		end
	end
end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
end

function PANEL:ClearDialog ( )
	for k, v in pairs(self.DialogButtons) do
		self.DialogHolder:RemoveItem(v);
		v:Remove();
	end
	
	self.DialogButtons = {};
end

function PANEL:AddDialog ( Text, DoAction )
	local newButton = vgui.Create("DButton", self);
	
	if DoAction == LEAVE_DIALOG then
		newButton:SetText(Text .. " <Leave>");
	else
		newButton:SetText(Text);
	end
	
	function newButton.DoClick ( )
		self:ClearDialog();
		DoAction();
	end
	
	self.DialogHolder:AddItem(newButton);
	table.insert(self.DialogButtons, newButton);
end

function PANEL:AddPaintOption ( Text, Col, DoAction, Arg )
	local newButton = vgui.Create("perp2_vehicle_paint", self);
	
	newButton:DoSetup(Text, Col, DoAction, Arg)
	
	self.DialogHolder:AddItem(newButton);
	table.insert(self.DialogButtons, newButton);
end

function PANEL:SetDialog ( Text )
	self.Dialog = Text;
	self:InvalidateLayout();
end

function PANEL:Show ( )
	self.ModelPanel:SetLookAt(CAM_LOOK_AT[LocalPlayer():GetSex()]);
	self.ModelPanel:SetModel(LocalPlayer():GetModel());
	
	self:SetVisible(true);
	self:MakePopup();
end

function PANEL:Hide ( )
	self:SetVisible(false);
	LocalPlayer():ClearForcedEyeAngles();
	self:ClearDialog();
end

vgui.Register("perp2_dialog", PANEL);