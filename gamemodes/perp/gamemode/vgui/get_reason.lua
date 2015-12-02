


function ShowGetBanTime ( toBan, banTitle, banText2, onClick )
	local ourPanel = vgui.Create("DFrame");
	ourPanel:SetSize(300, 170);
	ourPanel:SetPos(ScrW() * .5 - 150, ScrH() * .5 - (170 * .5));
	ourPanel:SetAlpha(GAMEMODE.GetGUIAlpha());
	ourPanel:MakePopup();
	ourPanel:SetTitle(banTitle);
	ourPanel:SetDraggable(false);
	ourPanel:SetSkin("ugperp")
	
	local panelList = vgui.Create("DPanelList", ourPanel);
	panelList:EnableHorizontal(false)
	panelList:EnableVerticalScrollbar(true)
	panelList:StretchToParent(5, 30, 5, 5);
	panelList:SetPadding(5);
	
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText(toBan .. ".");
		panelList:AddItem(UserNamel);
		
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("");
		panelList:AddItem(UserNamel);
		
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Reason:");
		panelList:AddItem(UserNamel);
		
		UserPass = vgui.Create("DTextEntry", panelList);
		UserPass:SetPos(80, 30);
		UserPass:SetSize(100, 20);
		UserPass:SetText("Reason");
		panelList:AddItem(UserPass);
		
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("");
		panelList:AddItem(UserNamel);
		
		local SubmitButton = vgui.Create("DButton", panelList);
		SubmitButton:SetPos(80, 30);
		SubmitButton:SetSize(100, 20);
		SubmitButton:SetText(banText2);
		
		panelList:AddItem(SubmitButton);
		
		function SubmitButton:DoClick ( )
			ourPanel:Remove();
			
			onClick(UserPass:GetValue());
		end
end
