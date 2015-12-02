


local PANEL = {};

function PANEL:Init ( )
	self:SetTitle("Organizations");
	self:ShowCloseButton(true);
	self:SetDraggable(false);
	self:SetAlpha(GAMEMODE.GetGUIAlpha());
	self:MakePopup()
	self:SetSkin("ugperp")
	
	local orgID = LocalPlayer():GetUMsgInt("org", 0);
	if (orgID == 0) then return; end
	
	if (!GAMEMODE.OrganizationData[orgID] || !GAMEMODE.OrganizationData[orgID][2]) then RunConsoleCommand("perp_rod", orgID); else
	self:SetTitle("Organizations - " .. GAMEMODE.OrganizationData[orgID][1]); end
	
	self.isSetup = nil;
		
	self.membersList = vgui.Create("DListView", self);
	self.membersList:SetMultiSelect(false);
	self.membersList_PlayerName = self.membersList:AddColumn('Organization Member');
	self.membersList_IsFriend = self.membersList:AddColumn('Is Currently Online');
	self.membersList_IsFriend:SetMinWidth(125);
	self.membersList_IsFriend:SetMaxWidth(125);
end

function PANEL:Setup ( )
	if (self.isSetup) then return; end
	
	local orgID = LocalPlayer():GetUMsgInt("org", 0);
	
	if (orgID == 0) then return; end
	
	if (!GAMEMODE.OrganizationData[orgID] || !GAMEMODE.OrganizationData[orgID][2] || !GAMEMODE.OrganizationMembers[orgID]) then
		self.membersList:StretchToParent(5, 60, 5, 5);
		return;
	end
	
	self.isSetup = true;
	
	self.memberInfo = {};
	for k, v in pairs(GAMEMODE.OrganizationMembers[orgID]) do
		local online = "No";
		local realName = v[1];
		for _, pl in pairs(player.GetAll()) do
			if tostring(pl:UniqueID()) == v[2] then
				online = "Yes";
				realName = pl:GetRPName();
				break;
			end
		end
			
		
		self.memberInfo[tonumber(self.membersList:AddLine(realName, online):GetID())] = v[2];
	end
	
	self.membersList:SetVisible(true);
	if (GAMEMODE.OrganizationData[orgID][4]) then
		self.membersList:StretchToParent(5, 60, (self:GetWide() * .5) + 2.5, 5);
		
		self.pMembersList = vgui.Create("DListView", self);
		self.pMembersList:SetMultiSelect(false);
		self.pMembersList_PlayerName = self.pMembersList:AddColumn('Prospective Member');
		
		local bottomSpace = 20 * 3 + 5 * 4;
		local midSpace = 30;
		
		self.pMembersList:StretchToParent(self:GetWide() * .5 + 2.5, 60, 5, 15 + bottomSpace + midSpace);
		
		self.pMemberInfo = {};
		for k, v in pairs(player.GetAll()) do
			if (v:GetUMsgInt("org", 0) == 0) then
				self.pMemberInfo[tonumber(self.pMembersList:AddLine(v:GetRPName()):GetID())] = v;
			end
		end
		
		self.pList = vgui.Create("DPanelList", self);
		self.pList:SetPadding(5);
		self.pList:SetSpacing(5);
		self.pList:StretchToParent(self:GetWide() * .5 + 2.5, self:GetTall() - 5 - bottomSpace, 5, 5);
		
		self.mList = vgui.Create("DPanelList", self);
		self.mList:SetPadding(5);
		self.mList:SetSpacing(5);
		self.mList:EnableHorizontal(true);
		self.mList:SetPos(self:GetWide() * .5 + 2.5, self:GetTall() - 10 - bottomSpace - midSpace);
		self.mList:SetSize(self:GetWide() * .5 - 7.5, midSpace);
		
		local fWide = ((self:GetWide() * .5 - 7.5) - 15) * .5;
		
		local nameChange = vgui.Create("DTextEntry", self);
		nameChange:SetText(GAMEMODE.OrganizationData[orgID][1]);
		self.pList:AddItem(nameChange);
		
		local motdChange = vgui.Create("DTextEntry", self);
		motdChange:SetText(GAMEMODE.OrganizationData[orgID][2]);
		self.pList:AddItem(motdChange);
		
		local changeButton = vgui.Create("DButton", self);
		changeButton:SetText("Save Changes");
		self.pList:AddItem(changeButton);
		
		local addButton = vgui.Create("DButton", self);
		addButton:SetText("Invite Player");
		addButton:SetWide(fWide);
		self.mList:AddItem(addButton);
		
		local remButton = vgui.Create("DButton", self);
		remButton:SetText("Remove Player");
		remButton:SetWide(fWide);
		self.mList:AddItem(remButton);
		
		function changeButton:DoClick ( )
			if (string.len(nameChange:GetValue()) < 3) then
				LocalPlayer():Notify("Your organization's name must be longer than that.");
				return;
			end
			
			RunConsoleCommand("perp_o_c", nameChange:GetValue(), motdChange:GetValue());
		end
		
		function addButton.DoClick ( )
			local selected = self.pMembersList:GetSelectedLine();
			
			if (self.pMemberInfo[selected] && IsValid(self.pMemberInfo[selected])) then
				RunConsoleCommand("perp_o_i", self.pMemberInfo[selected]:UniqueID());
			end
		end
		
		function remButton.DoClick ( )
			local selected = self.membersList:GetSelectedLine();
			
			if (self.memberInfo[selected]) then
				if (self.memberInfo[selected] == tostring(LocalPlayer():UniqueID())) then
					LocalPlayer():Notify("You cannot kick yourself out of your organization!");
					LocalPlayer():Notify("If you wish to disband your organization, you can do so at the County Clerk.");
				else
					RunConsoleCommand("perp_o_r", self.memberInfo[selected]);
				end
			end
		end
	else
		self.membersList:StretchToParent(5, 60, 5, 5);
	end
end

function PANEL:PerformLayout ( )
	self:SetSize(ScrW() * .5, ScrH() * .5);
	self:SetPos(ScrW() * .25, ScrH() * .25);
	
	self.BaseClass.PerformLayout(self);
end

local rodUs
function PANEL:Paint ( )
	self.BaseClass.Paint(self);
	
	self:Setup();
	
	if (LocalPlayer():GetUMsgInt("org", 0) == 0) then
		draw.SimpleText("You are not currently in an organization; visit the County Clerk if you are interested in creating one.", "Default", self:GetWide() * .5, self:GetTall() * .5, Color(200, 200, 200, 255), 1, 1);
		return;
	elseif (GAMEMODE.OrganizationData && GAMEMODE.OrganizationData[LocalPlayer():GetUMsgInt("org", 0)] && GAMEMODE.OrganizationData[LocalPlayer():GetUMsgInt("org", 0)][4]) then
		draw.SimpleText("MOTD: " .. GAMEMODE.OrganizationData[LocalPlayer():GetUMsgInt("org", 0)][2], "Default", self:GetWide() * .5, 27, Color(200, 200, 200, 255), 1);
		draw.SimpleText("Owner: " .. GAMEMODE.OrganizationData[LocalPlayer():GetUMsgInt("org", 0)][3], "Default", self:GetWide() * .5, 39, Color(200, 200, 200, 255), 1);
	elseif (!rodUs || rodUs != LocalPlayer():GetUMsgInt("org", 0)) then
		rodUs = LocalPlayer():GetUMsgInt("org", 0)
		RunConsoleCommand("perp_rod", tostring(LocalPlayer():GetUMsgInt("org", 0)))
	end
end

vgui.Register("perp2_organization", PANEL, "DFrame");