


function GM.MakeRealtorScreen ( )	
	local W, H = 500, 250;
	
	local DermaPanel = vgui.Create("DFrame")
	DermaPanel:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
	DermaPanel:SetSize(W, H)
	DermaPanel:SetTitle("Realtor's Office - Current Sales Tax: " .. GAMEMODE.GetTaxRate_Sales_Text())
	DermaPanel:SetVisible(true)
	DermaPanel:SetDraggable(false)
	DermaPanel:ShowCloseButton(true)
	DermaPanel:SetAlpha(GAMEMODE.GetGUIAlpha());
	DermaPanel:SetSkin("ugperp")
	
	local PropertySheet = vgui.Create("DPropertySheet", DermaPanel);
	PropertySheet:StretchToParent(5, 30, 5, 5);
	
	local PropertySheetPanels = {};
	
	for k, v in pairs(PROPERTY_DATABASE) do
		if !PropertySheetPanels[v.Category] then
			PropertySheetPanels[v.Category] = vgui.Create("DPanelList");
			PropertySheetPanels[v.Category]:EnableHorizontal(false)
			PropertySheetPanels[v.Category]:EnableVerticalScrollbar(true)
			PropertySheetPanels[v.Category]:StretchToParent(5, 30, 5, 5);
			PropertySheetPanels[v.Category]:SetPadding(5);
			PropertySheetPanels[v.Category]:SetSpacing(5);
		end
	
		local NewMenu = vgui.Create('perp2_realtor_property', PropertySheetPanels[v.Category]);
		NewMenu:SetProperty(k);
		PropertySheetPanels[v.Category]:AddItem(NewMenu);
	end
	
	for k, v in pairs(PropertySheetPanels) do
		PropertySheet:AddSheet(k, v)
	end

	DermaPanel:MakePopup();
end
