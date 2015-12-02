
function GetManageAcocuntCommand ( )
	local W, H = 250, 185;
	local LoginName = LocalPlayer():GetPrivateString("accountname");
	local GroupID   = LocalPlayer():GetPrivateString("idgroup");
	local Email     = LocalPlayer():GetPrivateString("email");
	
		if (GroupID == "1") then
			NumToName = "Owner";
		elseif (GroupID == "2") then
			NumToName = "Super Admin";
		elseif (GroupID == "3") then
			NumToName = "Admin";
		elseif (GroupID == "4") then
			NumToName = "Guest";
		elseif (GroupID == "5") then
			NumToName = "Bronze VIP";
		elseif (GroupID == "6") then
			NumToName = "Silver VIP";
		elseif (GroupID == "7") then
			NumToName = "Gold VIP";
		elseif (GroupID == "8") then
			NumToName = "Diamond VIP";
		end
			
	
	AccountCreationScreen = vgui.Create("DFrame")
	AccountCreationScreen:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
	AccountCreationScreen:SetSize(W, H)
	AccountCreationScreen:SetTitle("Account Management")
	AccountCreationScreen:SetVisible(true)
	AccountCreationScreen:SetDraggable(false)
	AccountCreationScreen:ShowCloseButton(false)
	AccountCreationScreen:MakePopup()
	AccountCreationScreen:SetAlpha(GAMEMODE.GetGUIAlpha());
	AccountCreationScreen:SetSkin("ugperp")
	
		local PanelSize = W * .5 - 7.5;
		local UsCash = vgui.Create("DPanelList", AccountCreationScreen);
		UsCash:EnableHorizontal(false)
		UsCash:EnableVerticalScrollbar(true)
		UsCash:SetPos(5, 50);
		UsCash:SetSize(PanelSize, 20);
		UsCash:StretchToParent(5, 30, 5, 5);
		UsCash:SetPadding(5);
		
		local UserNamel = vgui.Create("DLabel", UsCash);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Username:    " .. LoginName);
		UsCash:AddItem(UserNamel);
		
		local UserNamel = vgui.Create("DLabel", UsCash);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Group:         " .. NumToName);
		UsCash:AddItem(UserNamel);
		
		local UserNamel = vgui.Create("DLabel", UsCash);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Email:          " .. Email);
		UsCash:AddItem(UserNamel);
		
		local UserNamel = vgui.Create("DLabel", UsCash);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText("Change Email:");
		UsCash:AddItem(UserNamel);
		
		UserPass = vgui.Create("DTextEntry", UsCash);
		UserPass:SetPos(80, 30);
		UserPass:SetSize(100, 20);
		UserPass:SetText("Email Address");
		UsCash:AddItem(UserPass);
		
		local SubmitButton = vgui.Create("DButton", UsCash);
		SubmitButton:SetPos(80, 30);
		SubmitButton:SetSize(100, 20);
		SubmitButton:SetText("Change Email");	

		local function MonitorColors ( )
			local Text = UserPass:GetValue();
			
			if string.find(Text, ' ') or string.find(Text, '"') or string.find(Text, 'Email Address') or string.find(Text, "'") or string.find(Text, " ") or string.len(Text) < 5 or string.len(Text) > 32 then
				UserPass:SetTextColor(Color(255, 0, 0, 255));
				return false;
			else
			
			if (!string.find(Text, '@') or !string.find(Text, '.com')) then
				UserPass:SetTextColor(Color(255, 0, 0, 255));
				return false;
			end
			
				OverallOkay = true;
				
				for i = 1, string.len(Text) do
					StringToCheck = string.lower(string.sub(Text, i, i));
					
					local IsOkay = false;
					
					for k, v in pairs(VALID_USERNAME_CHARACTERS) do
						if v == StringToCheck then
							IsOkay = true;
							break;
						end
					end
					
					if !IsOkay then
						OverallOkay = false;
					end
				end
				
				if OverallOkay then
					UserPass:SetTextColor(Color(0, 0, 0, 255));
					return true;
				else
					UserPass:SetTextColor(Color(255, 0, 0, 255));
					return false;
				end
			end
		end
		hook.Add('Think', 'MonColors4', MonitorColors);
		
		function SubmitButton:DoClick ( )
			if (!MonitorColors(true)) then
				LocalPlayer():Notify("Invalid EMail Address.");
				return;
			end
			
			RunConsoleCommand('perp_changeemail', UserPass:GetValue(), LocalPlayer():UniqueID());
			hook.Remove('Think', 'MonColors4', MonitorColors);
			UsCash:Remove();
			AccountCreationScreen:Remove();
		end
	
		UsCash:AddItem(SubmitButton);
		
		local SubmitButton2 = vgui.Create("DButton", UsCash);
		SubmitButton2:SetPos(80, 30);
		SubmitButton2:SetSize(100, 20);
		SubmitButton2:SetText("Close");
		
		function SubmitButton2:DoClick()
			hook.Remove('Think', 'MonColors4', MonitorColors);
			UsCash:Remove();
			AccountCreationScreen:Remove();
		end

		UsCash:AddItem(SubmitButton2);
end
usermessage.Hook("perp_manage_account", GetManageAcocuntCommand);

