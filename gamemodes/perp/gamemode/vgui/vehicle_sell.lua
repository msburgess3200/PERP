
function GM.ShowSellView ( )		
	local W, H = 500, 250;
	
	local DermaPanel = vgui.Create("DFrame")
	DermaPanel:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
	DermaPanel:SetSize(W, H)
	DermaPanel:SetTitle("Vehicle Garage")
	DermaPanel:SetVisible(true)
	DermaPanel:SetDraggable(false)
	DermaPanel:ShowCloseButton(true)
	DermaPanel:SetAlpha(GAMEMODE.GetGUIAlpha());

	local PanelList1 = vgui.Create("DPanelList", DermaPanel);
	PanelList1:EnableHorizontal(false)
	PanelList1:EnableVerticalScrollbar(true)
	PanelList1:StretchToParent(5, 30, 5, 5);
	PanelList1:SetPadding(5);
	PanelList1:SetSpacing(5);
	
	local tbl = {}
	for k, v in pairs(VEHICLE_DATABASE) do
		table.insert(tbl, v.Name)
	end
	table.sort(tbl)
	
	for k, v in ipairs(tbl) do
		for t, c in pairs(VEHICLE_DATABASE) do
			if(c.Name == v) then
				local table = c
				if (table && !table.RequiredClass && LocalPlayer():HasVehicle(t)) then
					local NewMenu = vgui.Create('perp2_vehicle_sell_details', PanelList1)
					NewMenu:SetVehicle(table)
					PanelList1:AddItem(NewMenu)
				end
				tbl[k] = nil
			end
		end
	end

	DermaPanel:MakePopup();
end
