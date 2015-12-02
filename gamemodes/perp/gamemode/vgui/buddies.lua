


local PANEL = {};

function PANEL:Init ( )
	self:SetTitle("Buddies");
	self:ShowCloseButton(true);
	self:SetDraggable(false);
	self:SetAlpha(GAMEMODE.GetGUIAlpha());
	self:MakePopup()
	self:SetSkin("ugperp")

	self.NonBuddies = vgui.Create("DListView", self);
	self.NonBuddies:SetMultiSelect(false);
	self.NonBuddies_PlayerName = self.NonBuddies:AddColumn('Player Name ( Complete Server List )');
	self.NonBuddies_IsFriend = self.NonBuddies:AddColumn('Is Steam Friend');
	self.NonBuddies_IsFriend:SetMinWidth(100);
	self.NonBuddies_IsFriend:SetMaxWidth(100);
	
	self.Buddies = vgui.Create("DListView", self);
	self.Buddies:SetMultiSelect(false);
	self.Buddies_PlayerName = self.Buddies:AddColumn('Player Name ( Current Buddies )');
	self.Buddies_IsFriend = self.Buddies:AddColumn('Is Steam Friend');
	self.Buddies_InServer = self.Buddies:AddColumn('Is In Server');
	self.Buddies_IsFriend:SetMinWidth(75);
	self.Buddies_IsFriend:SetMaxWidth(75);
	self.Buddies_InServer:SetMinWidth(75);
	self.Buddies_InServer:SetMaxWidth(75);
	
	self.panelList = vgui.Create("DPanelList", self);
	self.panelList:SetPadding(5);
	self.panelList:SetSpacing(5);
	self.panelList:EnableHorizontal(true);
	
	self.saveBuddies = vgui.Create("DCheckBoxLabel", panelList);
	self.saveBuddies:SetText("Save Buddies?");
	self.saveBuddies:SetValue(GAMEMODE.Options_SaveBuddies:GetInt());
	self.saveBuddies:SetConVar("perp2_save_buddies");
	self.panelList:AddItem(self.saveBuddies);
	
	self.removeBuddies = vgui.Create("DButton", panelList);
	self.removeBuddies:SetText("Remove Buddy");
	self.panelList:AddItem(self.removeBuddies);
	
	self.addBuddies = vgui.Create("DButton", panelList);
	self.addBuddies:SetText("Add Buddy");
	self.panelList:AddItem(self.addBuddies);
	
	self.wasSaving = GAMEMODE.Options_SaveBuddies:GetBool();
	
	self.BuddyListInfo = {};
	self.NonBuddyListInfo = {};
	for k, v in pairs(player.GetAll()) do
		if v != LocalPlayer() then
			local IsFriend = v:GetFriendStatus() == 'friend';
			local FriendText = 'No';
			if IsFriend then FriendText = 'Yes'; end
		
			if LocalPlayer():HasBuddy(v) then
				self.BuddyListInfo[tonumber(self.Buddies:AddLine(v:GetRPName(), FriendText, "Yes"):GetID())] = {v:GetRPName(), v:UniqueID(), FriendText, true};
			else
				self.NonBuddyListInfo[tonumber(self.NonBuddies:AddLine(v:GetRPName(), FriendText):GetID())] = {v:GetRPName(), v:UniqueID(), FriendText, true};
			end
		end
	end
	
	for k, v in pairs(GAMEMODE.Buddies) do
		local in_server = false;
		for _, pl in pairs(player.GetAll()) do
			if (tostring(pl:UniqueID()) == v[2]) then
				in_server = pl;
				break;
			end
		end
		
		if (!in_server) then
			self.BuddyListInfo[tonumber(self.Buddies:AddLine(v[1], v[3], "No"):GetID())] = {v[1], v[2], v[3], false};
		elseif (v[1] != in_server:GetRPName()) then
			v[1] = in_server:GetRPName();
			self:SaveFile();
		end
	end
	
	function self.addBuddies:DoClick ( )
		local selected = GAMEMODE.BuddyPanel.NonBuddies:GetSelectedLine();
		
		if (!selected) then return; end
		if (!GAMEMODE.BuddyPanel.NonBuddyListInfo[selected]) then return; end
		
		local pInfo = GAMEMODE.BuddyPanel.NonBuddyListInfo[selected];
		
		GAMEMODE.BuddyPanel.NonBuddies:RemoveLine(selected);
		GAMEMODE.BuddyPanel.BuddyListInfo[tonumber(GAMEMODE.BuddyPanel.Buddies:AddLine(pInfo[1], pInfo[3], "Yes"):GetID())] = pInfo;
		GAMEMODE.BuddyPanel.NonBuddyListInfo[selected] = nil;
		table.insert(GAMEMODE.Buddies, {pInfo[1], pInfo[2], pInfo[3]});
		
		GAMEMODE.BuddyPanel:SaveFile();
		RunConsoleCommand("perp_ab", pInfo[2]);
	end
	
	function self.removeBuddies:DoClick ( )
		local selected = GAMEMODE.BuddyPanel.Buddies:GetSelectedLine();
		
		if (!selected) then return; end
		if (!GAMEMODE.BuddyPanel.BuddyListInfo[selected]) then return; end
		
		local pInfo = GAMEMODE.BuddyPanel.BuddyListInfo[selected];
		
		GAMEMODE.BuddyPanel.Buddies:RemoveLine(selected);
		GAMEMODE.BuddyPanel.BuddyListInfo[selected] = nil;
		
		for k, v in pairs(GAMEMODE.Buddies) do
			if (pInfo[2] == v[2]) then
				GAMEMODE.Buddies[k] = nil;
			end
		end
		
		GAMEMODE.BuddyPanel:SaveFile();
		RunConsoleCommand("perp_rb", pInfo[2]);
		
		if (!pInfo[4]) then return; end
		
		GAMEMODE.BuddyPanel.NonBuddyListInfo[tonumber(GAMEMODE.BuddyPanel.NonBuddies:AddLine(pInfo[1], pInfo[3]):GetID())] = pInfo;
	end
end

// GAMEMODE.Buddies

function PANEL:PerformLayout ( )
	self:SetSize(ScrW() * .5, ScrH() * .5);
	self:SetPos(ScrW() * .25, ScrH() * .25);
	
	self.BaseClass.PerformLayout(self);
	
	local Border = 5;
	
	local spaceForBotRight = 30;
	
	local wideness = self:GetWide() * .5 - Border * 6.5
	
	self.NonBuddies:StretchToParent(Border, 30, self:GetWide() * .5 + Border * .5, Border);
	self.Buddies:StretchToParent(self:GetWide() * .5 + Border * .5, 30, Border, Border * 2 + spaceForBotRight);
	self.panelList:StretchToParent(self:GetWide() * .5 + Border * .5, self:GetTall() - (Border + spaceForBotRight), Border, Border);
	
	self.saveBuddies:SetWide(wideness * .334);
	self.addBuddies:SetWide(wideness * .334);
	self.removeBuddies:SetWide(wideness * .334);
	self.saveBuddies:SetTall(self.addBuddies:GetTall());
end

function PANEL:SaveFile ( )
	if !GAMEMODE.Options_SaveBuddies:GetBool() then return; end
	
	self.wasSaving = true;
			
	local writeBuffer = "";
			
	for k, v in pairs(self.BuddyListInfo) do	
		writeBuffer = writeBuffer .. v[1] .. "\t" .. v[2] .. "\t" .. v[3] .. "\n";
	end
			
	file.Write("perp2_buddies.txt", writeBuffer);
end

function PANEL:Think ( )
	if GAMEMODE.Options_SaveBuddies:GetBool() then
		if (!self.wasSaving) then
			self:SaveFile();
		end
	elseif self.wasSaving then
		self.wasSaving = nil;
		file.Delete("perp2_buddies.txt");
	end
end

vgui.Register("perp2_buddies", PANEL, "DFrame");