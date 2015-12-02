
function ShowRenamePanel ( disableClose )
	local ourPanel = vgui.Create("DFrame");
	ourPanel:SetSize(260, 185);
	ourPanel:SetPos(ScrW() * .5 - 130, ScrH() * .5 - 92.5);
	ourPanel:SetAlpha(GAMEMODE.GetGUIAlpha());
	ourPanel:MakePopup();
	ourPanel:SetTitle("Character Rename");
	ourPanel:SetDraggable(false);
	ourPanel:SetSkin("ugperp")
	
	ourPanel:ShowCloseButton(false);
	
	local panelList = vgui.Create("DPanelList", ourPanel);
	panelList:EnableHorizontal(false)
	panelList:EnableVerticalScrollbar(true)
	panelList:StretchToParent(5, 30, 5, 5);
	panelList:SetPadding(5);
	
	if disableClose then
		UserName = vgui.Create("perp2_rename_force", panelList);
		panelList:AddItem(UserName);
		ourPanel:SetHeight(ourPanel:GetTall() + UserName:GetTall());
		panelList:SetHeight(panelList:GetTall() + UserName:GetTall());
	end
	
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Character's First Name:");
		panelList:AddItem(UserNamel);
	
		UserName = vgui.Create("DTextEntry", panelList);
		UserName:SetPos(80, 30);
		UserName:SetSize(100, 20);
		UserName:SetText("John");
		panelList:AddItem(UserName);
		
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("");
		panelList:AddItem(UserNamel);
		
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Character's Last Name:");
		panelList:AddItem(UserNamel);
		
		UserPass = vgui.Create("DTextEntry", panelList);
		UserPass:SetPos(80, 30);
		UserPass:SetSize(100, 20);
		UserPass:SetText("Doe");
		panelList:AddItem(UserPass);
		
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("");
		panelList:AddItem(UserNamel);
		
		local SubmitButton = vgui.Create("DButton", panelList);
		SubmitButton:SetPos(80, 30);
		SubmitButton:SetSize(100, 20);
		SubmitButton:SetText("Change Name");
		
		panelList:AddItem(SubmitButton);
		
		local function MonitorColors2 ( wantReturn )
			local firstName = UserName:GetValue();
			local lastName = UserPass:GetValue();

			local anyInvalid = false;
			
			if !GAMEMODE.IsValidPartialName(firstName) then
				UserName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			else
				UserName:SetTextColor(Color(0, 0, 0, 255));
			end
	
			if !GAMEMODE.IsValidPartialName(lastName) then
				UserPass:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			else
				UserPass:SetTextColor(Color(0, 0, 0, 255));
			end
			
			if (!GAMEMODE.IsValidName(firstName, lastName, true)) then
				UserPass:SetTextColor(Color(255, 0, 0, 255));
				UserName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			end
			
			if (firstName .. " " .. lastName == LocalPlayer():GetRPName()) then
				UserPass:SetTextColor(Color(255, 0, 0, 255));
				UserName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			end
			
			if (anyInvalid) then
				SubmitButton:SetEnabled(false);
			else
				SubmitButton:SetEnabled(true);
			end
			
			if (wantReturn) then
				return !anyInvalid;
			end
		end
		hook.Add('Think', 'MonColors2', MonitorColors2);
		
		function SubmitButton:DoClick ( )
			if (!MonitorColors2(true)) then
				LocalPlayer():Notify("Please fix any fields that may have errors.");
				return;
			end
			
			hook.Remove("Think", 'MonColors2');
			ourPanel:Remove();
			
			RunConsoleCommand("perp_MOFUCKA_cn", UserName:GetValue(), UserPass:GetValue(), LocalPlayer():UniqueID());
		end
end
