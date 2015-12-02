



local PANEL = {};

	local parseRules = function ( Results, whereTo, Size )
		if (!whereTo) then return; end
		
		local explodedResults = string.Explode("\n", Results);
		
		for k, v in pairs(explodedResults) do
			local isHeader = string.sub(v, 1, 1) == ":";
			
			local font = PERP2_SKIN.fontLabel;
			if (isHeader) then
				font = PERP2_SKIN.fontLargeLabel;
				v = string.sub(v, 2);
			end
			
			local splitResults = cutLength(v, Size, font);
			
			for _, txt in pairs(splitResults) do
				local UserNamel = vgui.Create("DLabel", whereTo);
				UserNamel:SetPos(80, 30);
				UserNamel:SetSize(100, 20);
				
				if (isHeader) then
					UserNamel:SetText(":" .. txt);
					UserNamel:SetColor(Color(255, 255, 255, 255));
				else
					UserNamel:SetText(txt);
				end
				
				whereTo:AddItem(UserNamel);
			end
		end
	end

function PANEL:Init ( )
	self:SetTitle("Menu");
	self:ShowCloseButton(true);
	self:SetDraggable(false);
	self:SetSkin("ugperp")
	
	self:SetAlpha(GAMEMODE.GetGUIAlpha());
	
	self:MakePopup()
		
	self.PropertySheet = vgui.Create("DPropertySheet", self);
	
	self.RulesList = vgui.Create("DPanelList", self);
	self.RulesList:EnableHorizontal(false)
	self.RulesList:EnableVerticalScrollbar(true)
	self.RulesList:SetPadding(5);
	self.RulesList:SetPadding(5);
	self.RulesList:SetSpacing(-5);
	
	self.ChatList = vgui.Create("DPanelList", self);
	self.ChatList:EnableHorizontal(false)
	self.ChatList:EnableVerticalScrollbar(true)
	self.ChatList:SetPadding(5);
	self.ChatList:SetPadding(5);
	self.ChatList:SetSpacing(-5);
	
	self.FAQList = vgui.Create("DPanelList", self);
	self.FAQList:EnableHorizontal(false)
	self.FAQList:EnableVerticalScrollbar(true)
	self.FAQList:SetPadding(5);
	self.FAQList:SetPadding(5);
	self.FAQList:SetSpacing(-5);
	
	self.SkillsList = vgui.Create("DPanelList", self);
	self.SkillsList:EnableHorizontal(false)
	self.SkillsList:EnableVerticalScrollbar(true)
	self.SkillsList:SetPadding(5);
	self.SkillsList:SetPadding(5);
	self.SkillsList:SetSpacing(5);
	
	self.GeneList = vgui.Create("DPanelList", self);
	self.GeneList:EnableHorizontal(false)
	self.GeneList:EnableVerticalScrollbar(true)
	self.GeneList:SetPadding(5);
	self.GeneList:SetPadding(5);
	self.GeneList:SetSpacing(5);
	
	self.OptionsList = vgui.Create("DPanelList", self);
	self.OptionsList:EnableHorizontal(false)
	self.OptionsList:EnableVerticalScrollbar(true)
	self.OptionsList:SetPadding(5);
	self.OptionsList:SetPadding(5);
	self.OptionsList:SetSpacing(5);
	
	self.MixturesList = vgui.Create("DPanelList", self);
	self.MixturesList:EnableHorizontal(false)
	self.MixturesList:EnableVerticalScrollbar(true)
	self.MixturesList:SetPadding(5);
	self.MixturesList:SetPadding(5);
	self.MixturesList:SetSpacing(5);
	
	self.ReportList = vgui.Create("DPanelList", self);
	self.ReportList:EnableHorizontal(true)
	self.ReportList:EnableVerticalScrollbar(true)
	self.ReportList:SetPadding(5);
	self.ReportList:SetPadding(5);
	self.ReportList:SetSpacing(5);
	
	self.PropertySheet:AddSheet("Rules List", self.RulesList);
	self.PropertySheet:AddSheet("Donate", self.ChatList);
	self.PropertySheet:AddSheet("F.A.Q.", self.FAQList);
	//self.PropertySheet:AddSheet("Report Player", self.ReportList);
	self.PropertySheet:AddSheet("Options", self.OptionsList);
	self.PropertySheet:AddSheet("Skills", self.SkillsList);
	self.PropertySheet:AddSheet("Genetics", self.GeneList);
	self.PropertySheet:AddSheet("Mixtures", self.MixturesList);
	
	self:SetSize(ScrW() * .5, ScrH() * .5);
	self:SetPos(ScrW() * .25, ScrH() * .25);
	
	if GAMEMODE.ChatList then
		parseRules(GAMEMODE.ChatList, self.ChatList, self:GetWide() - 50);
	else
		http.Fetch(URL_CHAT, function ( r ) if self && self.Remove then GAMEMODE.ChatList = r; parseRules(r, self.ChatList, self:GetWide() - 50); end end)
	end
	
	if GAMEMODE.Rules then
		parseRules(GAMEMODE.Rules, self.RulesList, self:GetWide() - 50);
	else
		http.Fetch(URL_RULES, function ( r ) if self && self.Remove then GAMEMODE.Rules = r; parseRules(r, self.RulesList, self:GetWide() - 50); end end)
	end
	
	if GAMEMODE.FAQ then
		parseRules(GAMEMODE.FAQ, self.FAQList, self:GetWide() - 50);
	else
		http.Fetch(URL_FAQ, function ( r ) if self && self.Remove then GAMEMODE.FAQ = r; parseRules(r, self.FAQList, self:GetWide() - 50); end end)
	end
	
	for k, v in pairs(SKILLS_DATABASE) do
		local What = vgui.Create("perp2_skill_bar", self.SkillsList):SetSkill(v[1]);
		self.SkillsList:AddItem(What);
		What:PerformLayout();
	end
	
	for k, v in pairs(GENES_DATABASE) do
		local What = vgui.Create("perp2_gene_bar", self.SkillsList):SetSkill(v[1]);
		self.GeneList:AddItem(What);
		What:PerformLayout();
	end
	
	for k, v in pairs(MIXTURE_DATABASE) do
		if (!LocalPlayer():HasMixture(k)) then
			self.MixturesList:AddItem(vgui.Create('perp2_mixtures_tip', self.MixturesList));
			self.MixturesList:AddItem(vgui.Create('perp2_mixtures_warn', self.MixturesList));
			break;
		end
	end
	
	local sortedMixturesTable = {};
	for k, v in pairs(MIXTURE_DATABASE) do
		if (LocalPlayer():HasMixture(k)) then
			table.insert(sortedMixturesTable, v);
		end
	end
	
	table.sort(sortedMixturesTable, function ( a, b ) 
		if (!a) then return false; end
		if (!b) then return true; end
		
		local curPos = 1;
		
		local lA = string.lower(a.Name);
		local lB = string.lower(b.Name);
		
		while true do
			local sA = string.sub(lA, curPos, curPos);
			local sB = string.sub(lB, curPos, curPos);
			
			if (sB == "") then
				return true;
			elseif (sA == "") then
				return false;
			end
		
			local boA = string.byte(sA)
			local boB = string.byte(sB)
			
			if (boA < boB) then
				return true;
			elseif (boA > boB) then
				return false;
			end
			
			curPos = curPos + 1;
		end
	end);
	
	for k, v in pairs(sortedMixturesTable) do
		local NewMixInfo = vgui.Create('perp2_mixtures_info', self.MixturesList);
		self.MixturesList:AddItem(NewMixInfo);
		NewMixInfo:SetMixture(v);
	end
	
	// Report tab
	if (LocalPlayer():HasBlacklist('a')) then
		self.ReportList:EnableHorizontal(false);
		self.LabelOfReport = vgui.Create('perp2_reportbl_warn', self.ReportList);
		self.ReportList:AddItem(self.LabelOfReport);
	else
		self.LabelOfReport = vgui.Create("DLabel", self.ReportList);
		self.LabelOfReport:SetText("This report will send a text log of the last 100 messages.");
		self.ReportList:AddItem(self.LabelOfReport);
		self.LabelOfReport:SetSize(self:GetWide() * .5, 20);
		
		self.ReportButton = vgui.Create("DButton", self.ReportList);
		self.ReportButton:SetText("Report Player");
		function self.ReportButton.DoClick ( )
			GAMEMODE.LastReportPlayer = GAMEMODE.LastReportPlayer or 0;
			
			if (GAMEMODE.LastReportPlayer > CurTime()) then
				LocalPlayer():Notify("You must wait another " .. math.ceil(GAMEMODE.LastReportPlayer - CurTime()) .. " seconds before reporting another player.");
				return;
			end
			
			if (self.reportListInfo[self.OffenderList:GetSelectedLine()] && self.ruleBrokenInfo[self.RuleList:GetSelectedLine()]) then
				if (LocalPlayer():IsAdmin()) then
					GAMEMODE.LastReportPlayer = CurTime() + 5;
				elseif (LocalPlayer():IsBronze()) then
					GAMEMODE.LastReportPlayer = CurTime() + 30;
				else
					GAMEMODE.LastReportPlayer = CurTime() + 60;
				end
				
				RunConsoleCommand("perp_r_p", self.reportListInfo[self.OffenderList:GetSelectedLine()], self.ruleBrokenInfo[self.RuleList:GetSelectedLine()], self.AdditionalComments:GetValue());
			end
		end
		self.ReportList:AddItem(self.ReportButton);
		self.ReportButton:SetSize(self:GetWide() * .45, 20);
		
		self.AdditionalComments = vgui.Create("DTextEntry", self.ReportList);
		self.AdditionalComments:SetText("Additional Comments (Keep This Short)");
		self.ReportList:AddItem(self.AdditionalComments);
		self.AdditionalComments:SetSize(self:GetWide() * .98, 20);

		self.OffenderList = vgui.Create("DListView", self.ReportList)
		self.OffenderList:SetMultiSelect(false);
		self.OffenderList:AddColumn("Select Offender");
		
		self.reportListInfo = {};
		
		for k, v in pairs(GAMEMODE.PlayerNamesForReport) do
			if (v[1] && IsValid(v[1])) then
				self.reportListInfo[tonumber(self.OffenderList:AddLine(v[2]):GetID())] = v[3];
			elseif (v[4]) then
				if (CurTime() - v[4] > 60) then
					local mins = math.floor(math.ceil(CurTime() - v[4]) / 60);
					
					if (mins == 1) then
						self.reportListInfo[tonumber(self.OffenderList:AddLine(v[2] .. " [Left " .. math.floor(math.ceil(CurTime() - v[4]) / 60) .. " Minute Ago]"):GetID())] = v[3];
					else
						self.reportListInfo[tonumber(self.OffenderList:AddLine(v[2] .. " [Left " .. math.floor(math.ceil(CurTime() - v[4]) / 60) .. " Minutes Ago]"):GetID())] = v[3];
					end
				else
					self.reportListInfo[tonumber(self.OffenderList:AddLine(v[2] .. " [Left " .. math.ceil(CurTime() - v[4]) .. " Seconds Ago]"):GetID())] = v[3];
				end
			end
		end
		
		self.RuleList = vgui.Create("DListView", self.ReportList)
		self.RuleList:SetMultiSelect(false);
		self.RuleList:AddColumn("Select Rule Broken");
		
		self.ruleBrokenInfo = {};
		
		for i = 1, 41 do
			self.ruleBrokenInfo[tonumber(self.RuleList:AddLine("Rule #" .. tostring(i)):GetID())] = i;
		end
		
		self.ReportList:PerformLayout();
		
		self.OffenderList:SetPos(5, 55);
		self.RuleList:SetPos(10 + self:GetWide() * .67, 55);
		
		self.OffenderList:SetHeight(self:GetTall() * .8 - 55);
		self.OffenderList:SetWide(self:GetWide() * .67);
		
		self.RuleList:SetHeight(self:GetTall() * .8 - 55);
		self.RuleList:SetWide(self:GetWide() * .28);
		
		self.ReportList:Remove()
	end
	
	GAMEMODE.LoadOptionsList(self.OptionsList);
end

function PANEL:PerformLayout ( )
	self:SetSize(ScrW() * .5, ScrH() * .5);
	self:SetPos(ScrW() * .25, ScrH() * .25);
	
	self.BaseClass.PerformLayout(self);
	
	self.PropertySheet:StretchToParent(5, 30, 5, 5)
end

vgui.Register("perp2_help", PANEL, "DFrame");