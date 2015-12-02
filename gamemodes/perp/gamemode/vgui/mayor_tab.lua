


local PANEL = {};

function PANEL:FillWarrentList ( )
	self.OffenderList_W:Clear()
	
	self.panelListInfo_W = {};
		
	for k, v in pairs(player.GetAll()) do
		if (v != LocalPlayer() && v:Team() == TEAM_CITIZEN) then
			local warrentText = "No"
			if (v:GetNetworkedBool("warrent", false)) then
				warrentText = "Yes"
			end
			
			if (self.overrideWarrent && self.overrideWarrent == v:UniqueID()) then
				warrentText = "Yes"
			end
		
			self.panelListInfo_W[tonumber(self.OffenderList_W:AddLine(v:GetRPName(), warrentText):GetID())] = v:UniqueID();
		end
	end
end

function PANEL:FillGovOfficialsList ( )
	self.OffenderList_D:Clear()
	
	self.panelListInfo_D = {};
		
	for k, v in pairs(player.GetAll()) do
		if (v != LocalPlayer() && v:Team() != TEAM_CITIZEN) then
			if (!self.overrideOfficial || self.overrideOfficial != v:UniqueID()) then
				self.panelListInfo_D[tonumber(self.OffenderList_D:AddLine(v:GetRPName(), team.GetName(v:Team())):GetID())] = v:UniqueID();
			end
		end
	end
end

function PANEL:AddConVarBar ( parent, name, default, min, max, conVar, upGM )
	local newBar = vgui.Create("DNumSlider", parent);
	newBar:SetText(name);
	newBar:SetMin(min or 0);
	newBar:SetMax(max or 1);
	newBar:SetDecimals(0);
	newBar:SetValue(default);
	parent:AddItem(newBar);
	
	table.insert(self.conVarBars, {newBar, default, conVar, upGM})
end

function PANEL:Think ( )
	for _, each in pairs(self.conVarBars) do
		local curVal = each[1]:GetValue()
		
		if (curVal != each[2]) then
			RunConsoleCommand(each[3], curVal)
			if (each[4]) then GAMEMODE[each[4]] = curVal end
			self.checkText = 0
			each[2] = curVal
		end
	end
	
	if (self.checkText && self.checkText > CurTime()) then return end
	self.checkText = CurTime() + 0.5
	
	local projectedPrice_LawEnforcement = (GAMEMODE.MaximumCops * GAMEMODE.PayDay_Police) + (GAMEMODE.PayDay_SWAT * GAMEMODE.MaximumSWAT) + GAMEMODE.PayDay_Dispatcher + (GAMEMODE.UpkeepCost_PoliceCar * GAMEMODE.MaxCopCars) + (GAMEMODE.UpkeepCost_SWATVan * GAMEMODE.MaxSWATVans)
	local projectedPrice_CivilServices = (GAMEMODE.MaximumFireMen * GAMEMODE.PayDay_Fireman) + (GAMEMODE.PayDay_Medic * GAMEMODE.MaximumParamedic) + (GAMEMODE.UpkeepCost_Ambulance * GAMEMODE.MaxAmbulances) + (GAMEMODE.UpkeepCost_Firetruck * GAMEMODE.MaxFireTrucks)
	local projectedPrice_SecretService = (GAMEMODE.MaximumSecretService * GAMEMODE.PayDay_SecretService) + (GAMEMODE.UpkeepCost_Stretch * GAMEMODE.MaxStretch)
	
	local projectedPrice = projectedPrice_LawEnforcement + projectedPrice_CivilServices + GAMEMODE.MayorPay + projectedPrice_SecretService
	if (!self.displayedProjectedPrice || self.displayedProjectedPrice != projectedPrice) then
		self.displayedProjectedPrice = projectedPrice
		self.projectedExpenses:SetText("Projected Expenses: $" .. projectedPrice .. " ( $" .. (GAMEMODE.CityBudget_LastExpenses or 0) .. " Last Quarter )");
		self.projLawEnforcement:SetText("Projected Law Enforcement Expenses: $" .. projectedPrice_LawEnforcement .. " ( " .. math.Round((projectedPrice_LawEnforcement / projectedPrice) * 100) .. "% of total expenses )")
		self.projCivilServices:SetText("Projected Civil Services Expenses: $" .. projectedPrice_CivilServices .. " ( " .. math.Round((projectedPrice_CivilServices / projectedPrice) * 100) .. "% of total expenses )")
		self.projSecretService:SetText("Projected Secret Service Expenses: $" .. projectedPrice_SecretService .. " ( " .. math.Round((projectedPrice_SecretService / projectedPrice) * 100) .. "% of total expenses )")
	end
	
	if (!self.displayedCityBudget || GAMEMODE.CityBudget != self.displayedCityBudget) then
		self.displayedCityBudget = GAMEMODE.CityBudget
		self.cityFunds:SetText("City Funds: $" .. (GAMEMODE.CityBudget or 0));
	end
	
	local projectedIncome = table.Count(player.GetAll()) * FREE_CASH_PER_PLAYER
	for _, each in pairs(player.GetAll()) do
		TO_EARN = 50
		
		if (each:Team() == TEAM_MAYOR) then
			TO_EARN = GAMEMODE.MayorPay
		elseif (each:Team() == TEAM_POLICE) then
			TO_EARN = GAMEMODE.PayDay_Police
		elseif (each:Team() == TEAM_SWAT) then
			TO_EARN = GAMEMODE.PayDay_SWAT
		elseif (each:Team() == TEAM_SECRET_SERVICE) then
			TO_EARN = GAMEMODE.PayDay_SecretService
		elseif (each:Team() == TEAM_MEDIC) then
			TO_EARN = GAMEMODE.PayDay_Medic
		elseif (each:Team() == TEAM_FIRE) then
			TO_EARN = GAMEMODE.PayDay_Fireman
		elseif (each:Team() == TEAM_DISPATCHER) then
			TO_EARN = GAMEMODE.PayDay_Dispatcher
		end
		
		if (each:IsBronze()) then
			TO_EARN = TO_EARN * 1.25
		end
		
		projectedIncome = projectedIncome + math.Round(TO_EARN * GAMEMODE.GetTaxRate_Income())
	end
	
	if (!self.displayedProjIncome || self.displayedProjIncome != projectedIncome) then
		self.displayedProjIncome = projectedIncome
		self.projectedIncome:SetText("Projected Income: $" .. projectedIncome .. " ( $" .. (GAMEMODE.CityBudget_LastIncome or 0) .. " Last Quarter )");
	end
end

function PANEL:Init ( )
	self.conVarBars = {}
	
	self:SetTitle("Mayor Commands");
	self:ShowCloseButton(true);
	self:SetDraggable(false);
	self:SetAlpha(GAMEMODE.GetGUIAlpha());
	self:MakePopup()
	self:SetSkin("ugperp")
	
	self.PropertySheet = vgui.Create("DPropertySheet", self);
	
	// Warrent Page
	self.warrentList = vgui.Create("DPanelList", self)
	self.warrentList:SetPadding(5);
	self.warrentList:SetSpacing(5);
	
	self.WarrentButton = vgui.Create("DButton", self.warrentList);
	self.WarrentButton:SetText("Warrent Citizen");
	function self.WarrentButton.DoClick ( )
		GAMEMODE.LastWarrentPlayer = GAMEMODE.LastWarrentPlayer or 0;
		
		if (GAMEMODE.LastWarrentPlayer > CurTime()) then
			LocalPlayer():Notify("You must wait another " .. math.ceil(GAMEMODE.LastWarrentPlayer - CurTime()) .. " seconds before warrenting another player.");
			return;
		end
					
		GAMEMODE.LastWarrentPlayer = CurTime() + 10;
		
		self.overrideWarrent = self.panelListInfo_W[self.OffenderList_W:GetSelectedLine()]
			
		RunConsoleCommand("perp_g_w", self.panelListInfo_W[self.OffenderList_W:GetSelectedLine()], self.AdditionalComments_W:GetValue());
		
		self:FillWarrentList()
	end
	self.warrentList:AddItem(self.WarrentButton);
	
	self.AdditionalComments_W = vgui.Create("DTextEntry", self.warrentList);
	self.AdditionalComments_W:SetText("Warrent Reason ( Keep This Short )");
	self.warrentList:AddItem(self.AdditionalComments_W);
	
	self.OffenderList_W = vgui.Create("DListView", self.warrentList)
	self.OffenderList_W:SetMultiSelect(false);
	self.OffenderList_W:AddColumn("Citizen");
	self.OffenderList_W:AddColumn("Currently Warrented");
	self.warrentList:AddItem(self.OffenderList_W)

	self:FillWarrentList()
	
	self.warrentList:PerformLayout();
	
	// Government Officials Demoting
	
	self.officialsList = vgui.Create("DPanelList", self)
	self.officialsList:SetPadding(5);
	self.officialsList:SetSpacing(5);
	
	self.DemoteButton = vgui.Create("DButton", self.officialsList);
	self.DemoteButton:SetText("Fire Government Employee");
	function self.DemoteButton.DoClick ( )
		GAMEMODE.LastDemotePlayer = GAMEMODE.LastDemotePlayer or 0;
		
		if (GAMEMODE.LastDemotePlayer > CurTime()) then
			LocalPlayer():Notify("You must wait another " .. math.ceil(GAMEMODE.LastDemotePlayer - CurTime()) .. " seconds before demoting another player.");
			return;
		end
		
		GAMEMODE.LastDemotePlayer = CurTime() + 60;
			
		RunConsoleCommand("perp_g_d", self.panelListInfo_D[self.OffenderList_D:GetSelectedLine()], self.AdditionalComments_D:GetValue());
		
		self.overrideOfficial = self.panelListInfo_D[self.OffenderList_D:GetSelectedLine()]
		self:FillGovOfficialsList()
	end
	self.officialsList:AddItem(self.DemoteButton);
	
	self.AdditionalComments_D = vgui.Create("DTextEntry", self.officialsList);
	self.AdditionalComments_D:SetText("Demote Reason ( Keep This Short )");
	self.officialsList:AddItem(self.AdditionalComments_D);
	
	self.OffenderList_D = vgui.Create("DListView", self.officialsList)
	self.OffenderList_D:SetMultiSelect(false);
	self.OffenderList_D:AddColumn("Government Employee");
	self.OffenderList_D:AddColumn("Position");
	self.officialsList:AddItem(self.OffenderList_D)

	self:FillGovOfficialsList()
	
	self.officialsList:PerformLayout();
	
	// Taxes & Employment
	self.taxesList = vgui.Create("DPanelList", self)
	self.taxesList:SetPadding(5);
	self.taxesList:SetSpacing(5);
	
	self.cityFunds = vgui.Create("DLabel", self.taxesList);
	self.cityFunds:SetText("City Funds: $0");
	self.taxesList:AddItem(self.cityFunds);
	
	self.projectedIncome = vgui.Create("DLabel", self.taxesList);
	self.projectedIncome:SetText("Projected Income: $0 ($0 Last Quarter)");
	self.taxesList:AddItem(self.projectedIncome);
	
	self.projectedExpenses = vgui.Create("DLabel", self.taxesList);
	self.projectedExpenses:SetText("Projected Expenses: $0 ($0 Last Quarter)");
	self.taxesList:AddItem(self.projectedExpenses);

	self:AddConVarBar(self.taxesList, "Sales Tax Rate ( Be careful - this could aggrivate citizens! )", GetGlobalInt("tax_sales", 0), 0, GAMEMODE.MaxTax_Sales, "perp_m_t_s")
	self:AddConVarBar(self.taxesList, "Income Tax Rate ( Be careful - this could aggrivate citizens! )", GetGlobalInt("tax_income", 0), 0, GAMEMODE.MaxTax_Income, "perp_m_t_i")
	
	// Law Enforcement
	self.lawEnforcementList = vgui.Create("DPanelList", self)
	self.lawEnforcementList:SetPadding(5);
	self.lawEnforcementList:SetSpacing(5);

	self.projLawEnforcement = vgui.Create("DLabel", self.lawEnforcementList);
	self.projLawEnforcement:SetText("Projected Law Enforcement Expenses: $0 ( 0% of total expenses )");
	self.lawEnforcementList:AddItem(self.projLawEnforcement);
	
	self:AddConVarBar(self.lawEnforcementList, "Police Officer Employment ( How many police officers can be hired. )", GAMEMODE.MaximumCops, 0, GAMEMODE.MaxEmployment_Police, "perp_m_e_c", "MaximumCops")
	self:AddConVarBar(self.lawEnforcementList, "Police Officer Salary ( The ammount officers are paid every pay day. )", GAMEMODE.PayDay_Police, GAMEMODE.MinimumPayGov, GAMEMODE.MaxPayDay_Police, "perp_m_p_c", "PayDay_Police")
	self:AddConVarBar(self.lawEnforcementList, "Squad Car Upkeep ( How many police cruisers are available. $" .. GAMEMODE.UpkeepCost_PoliceCar .. " upkeep each. )", GAMEMODE.MaxCopCars, 0, GAMEMODE.MaxVehicles_Police, "perp_m_v_c", "MaxCopCars")
	
	self:AddConVarBar(self.lawEnforcementList, "SWAT Team Employment ( How many SWAT members can be hired. )", GAMEMODE.MaximumSWAT, 0, GAMEMODE.MaxEmployment_SWAT, "perp_m_e_s", "MaximumSWAT")
	self:AddConVarBar(self.lawEnforcementList, "SWAT Member Salary ( The ammount officers are paid every pay day. )", GAMEMODE.PayDay_SWAT, GAMEMODE.MinimumPayGov, GAMEMODE.MaxPayDay_SWAT, "perp_m_p_s", "PayDay_SWAT")
	self:AddConVarBar(self.lawEnforcementList, "SWAT Van Upkeep ( How many SWAT vans are available. $" .. GAMEMODE.UpkeepCost_SWATVan .. " upkeep each. )", GAMEMODE.MaxSWATVans, 0, GAMEMODE.MaxVehicles_SWAT_, "perp_m_v_s", "MaxSWATVans")
	
	self:AddConVarBar(self.lawEnforcementList, "Dispatcher Salary ( The ammount the dispatcher is paid every pay day. )", GAMEMODE.PayDay_Dispatcher, GAMEMODE.MinimumPayGov, GAMEMODE.MaxPayDay_Dispatcher, "perp_m_p_d", "PayDay_Dispatcher")
	
	// Civil Services
	self.civilServicesList = vgui.Create("DPanelList", self)
	self.civilServicesList:SetPadding(5);
	self.civilServicesList:SetSpacing(5);
	
	self.projCivilServices = vgui.Create("DLabel", self.civilServicesList);
	self.projCivilServices:SetText("Projected Civil Services Expenses: $0 ( 0% of total expenses )");
	self.civilServicesList:AddItem(self.projCivilServices);
	
	self:AddConVarBar(self.civilServicesList, "Fireman Employment ( How many firemen can be hired. )", GAMEMODE.MaximumFireMen, 0, GAMEMODE.MaxEmployment_Fire, "perp_m_e_f", "MaximumFireMen")
	self:AddConVarBar(self.civilServicesList, "Fireman Salary ( The ammount firemen are paid every pay day )", GAMEMODE.PayDay_Fireman, GAMEMODE.MinimumPayGov, GAMEMODE.MaxPayDay_Fireman, "perp_m_p_f", "PayDay_Fireman")
	self:AddConVarBar(self.civilServicesList, "Fire Engine Upkeep ( How many fire engine are available. $" .. GAMEMODE.UpkeepCost_Firetruck .. " upkeep each. )", GAMEMODE.MaxFireTrucks, 0, GAMEMODE.MaxVehicles_Fire, "perp_m_v_f", "MaxFireTrucks")
	
	self:AddConVarBar(self.civilServicesList, "Paramedic Employment ( How many paramedics can be hired. )", GAMEMODE.MaximumParamedic, 0, GAMEMODE.MaxEmployment_Medic, "perp_m_e_m", "MaximumParamedic")
	self:AddConVarBar(self.civilServicesList, "Paramedic Salary ( The ammount paramedics are paid every pay day )", GAMEMODE.PayDay_Medic, GAMEMODE.MinimumPayGov, GAMEMODE.MaxPayDay_Paramedic, "perp_m_p_m", "PayDay_Medic")
	self:AddConVarBar(self.civilServicesList, "Ambulance Upkeep ( How many ambulances are available. $" .. GAMEMODE.UpkeepCost_Ambulance .. " upkeep each. )", GAMEMODE.MaxAmbulances, 0, GAMEMODE.MaxVehicles_Medic, "perp_m_v_m", "MaxAmbulances")
	
	// Secret Service
	self.secretServiceList = vgui.Create("DPanelList", self)
	self.secretServiceList:SetPadding(5);
	self.secretServiceList:SetSpacing(5);
	
	self.projSecretService = vgui.Create("DLabel", self.secretServiceList);
	self.projSecretService:SetText("Projected Secret Service Expenses: $0 ( 0% of total expenses )");
	self.secretServiceList:AddItem(self.projSecretService);
	
	self:AddConVarBar(self.secretServiceList, "Secret Service Employment ( How many Secret Service agents can be hired. )", GAMEMODE.MaximumSecretService, 0, GAMEMODE.MaxEmployment_SecretService, "perp_m_e_ss", "MaximumSecretService")
	self:AddConVarBar(self.secretServiceList, "Secret Service Agent Salary ( The ammount Secret Service agents are paid every pay day )", GAMEMODE.PayDay_SecretService, GAMEMODE.MinimumPayGov, GAMEMODE.MaxPayDay_SecretService, "perp_m_p_ss", "PayDay_SecretService")
	self:AddConVarBar(self.secretServiceList, "Limousine Upkeep ( How many limousine are available. $" .. GAMEMODE.UpkeepCost_Stretch .. " upkeep each. )", GAMEMODE.MaxStretch, 0, GAMEMODE.MaxVehicles_SecretService, "perp_m_v_ss", "MaxStretch")
		
	// Pop them all in
	self.PropertySheet:AddSheet("Warrants", self.warrentList);
	self.PropertySheet:AddSheet("Government Employees", self.officialsList);
	self.PropertySheet:AddSheet("City Funds", self.taxesList);
	self.PropertySheet:AddSheet("Law Enforcement", self.lawEnforcementList);
	self.PropertySheet:AddSheet("Civil Services", self.civilServicesList);
	self.PropertySheet:AddSheet("Secret Service", self.secretServiceList);
end

function PANEL:PerformLayout ( )
	self:SetSize(ScrW() * .5, ScrH() * .5);
	self:SetPos(ScrW() * .25, ScrH() * .25);
	
	self.PropertySheet:StretchToParent(5, 30, 5, 5)
	
	self.OffenderList_W:SetHeight(self:GetTall() - 75);
	self.OffenderList_D:SetHeight(self:GetTall() - 75);
	
	self.BaseClass.PerformLayout(self);
end

function PANEL:Paint ( )
	self.BaseClass.Paint(self);
end

vgui.Register("perp2_mayor_tab", PANEL, "DFrame");