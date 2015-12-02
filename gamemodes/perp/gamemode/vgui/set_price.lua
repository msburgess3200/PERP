


function ShowItemSetup ( uMsg )
	local itemID = uMsg:ReadShort()
	local itemMod = uMsg:ReadEntity()
	
	local ourPanel = vgui.Create("DFrame");
	ourPanel:SetSize(260, 185);
	ourPanel:SetPos(ScrW() * .5 - 130, ScrH() * .5 - 92.5);
	ourPanel:SetAlpha(GAMEMODE.GetGUIAlpha());
	ourPanel:MakePopup();
	ourPanel:SetTitle("Setup Item Sale");
	ourPanel:SetDraggable(false);
	ourPanel:SetSkin("ugperp")
	ourPanel:ShowCloseButton(false);
	
	local panelList = vgui.Create("DPanelList", ourPanel);
	panelList:EnableHorizontal(false)
	panelList:EnableVerticalScrollbar(true)
	panelList:StretchToParent(5, 30, 5, 5);
	panelList:SetPadding(5);
	
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Item Name:");
		panelList:AddItem(UserNamel);
	
		local UserName = vgui.Create("DTextEntry", panelList);
		UserName:SetPos(80, 30);
		UserName:SetSize(100, 20);
		UserName:SetText(ITEM_DATABASE[itemID].Name);
		panelList:AddItem(UserName);
		
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("");
		panelList:AddItem(UserNamel);
		
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Item Price:");
		panelList:AddItem(UserNamel);
		
		local UserPass = vgui.Create("DTextEntry", panelList);
		UserPass:SetPos(80, 30);
		UserPass:SetSize(100, 20);
		UserPass:SetText(ITEM_DATABASE[itemID].Cost);
		UserPass:SetNumeric(true)
		panelList:AddItem(UserPass);
		
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText(ITEM_DATABASE[itemID].Name);
		panelList:AddItem(UserNamel);
		
		local SubmitButton = vgui.Create("DButton", panelList);
		SubmitButton:SetPos(80, 30);
		SubmitButton:SetSize(100, 20);
		SubmitButton:SetText("OK");
		
		panelList:AddItem(SubmitButton);
		
		function SubmitButton:DoClick ( )
			ourPanel:Remove();
			
			if (itemMod && IsValid(itemMod)) then
				itemMod:SetNetworkedString("title", UserName:GetValue())
				itemMod:SetNetworkedInt("price", tonumber(UserPass:GetValue()))
			end
			
			RunConsoleCommand("perp_sitem", UserName:GetValue(), UserPass:GetValue());
		end
end
usermessage.Hook("perp2_name_item", ShowItemSetup)