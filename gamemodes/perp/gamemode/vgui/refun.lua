
function ShowRenamePanel2 ( disableClose )
	local ourPanel = vgui.Create("DFrame");
	ourPanel:SetSize(260, 130);
	ourPanel:SetPos(ScrW() * .5 - 130, ScrH() * .5 - 92.5);
	ourPanel:SetAlpha(GAMEMODE.GetGUIAlpha());
	ourPanel:MakePopup();
	ourPanel:SetTitle("User Rename");
	ourPanel:SetDraggable(false);
	ourPanel:SetSkin("ugperp")
	
	ourPanel:ShowCloseButton(false);
	
	local panelList = vgui.Create("DPanelList", ourPanel);
	panelList:EnableHorizontal(false)
	panelList:EnableVerticalScrollbar(true)
	panelList:StretchToParent(5, 30, 5, 5);
	panelList:SetPadding(5);
	

		UserName = vgui.Create("perp2_rename_fun", panelList);
		panelList:AddItem(UserName);
		ourPanel:SetHeight(130);
		panelList:SetHeight(130);
	
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Forum Username:");
		panelList:AddItem(UserNamel);
	
		UserName = vgui.Create("DTextEntry", panelList);
		UserName:SetPos(80, 30);
		UserName:SetSize(100, 20);
		UserName:SetText("Username");
		panelList:AddItem(UserName);
		
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
			local username5 = UserName:GetValue();

			local anyInvalid = false;
			
			if !username5 or username5 == "" or string.len(username5) < 4 or string.len(username5) > 32 then
				UserName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			else
				UserName:SetTextColor(Color(0, 0, 0, 255));
			end
			
			if string.find(username5, ' ') then
				UserName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			else
				UserName:SetTextColor(Color(0, 0, 0, 255));
			end
			
			for i = 1, string.len(username5) do
				StringToCheck = string.lower(string.sub(username5, i, i));
		
				local IsOkay = false;
		
					for k, v in pairs(VALID_CHARACTERS) do
						if v == StringToCheck then
							IsOkay = true;
							break;
						end
					end
		
				if !IsOkay then
					UserName:SetTextColor(Color(255, 0, 0, 255));
					anyInvalid = true;
					
				else
					UserName:SetTextColor(Color(0, 0, 0, 255));
					
				end
			end
			
			if username5 == "Username" then
				UserName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
					
			else
				UserName:SetTextColor(Color(0, 0, 0, 255));
							
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
		hook.Add('Think', 'MonColors4', MonitorColors2);
		
		function SubmitButton:DoClick ( )
			if (!MonitorColors2(true)) then
				LocalPlayer():Notify("Please fix any fields that may have errors.");
				return;
			end
			
			hook.Remove("Think", 'MonColors4');
			ourPanel:Remove();
			
			RunConsoleCommand("perp_MOFUCKA_fun", UserName:GetValue(), LocalPlayer():UniqueID());
		end
end