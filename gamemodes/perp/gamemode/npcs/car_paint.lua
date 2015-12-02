

local NPC = {};

NPC.Name = "Paint Shop";
NPC.ID = 6;

NPC.Model = Model("models/players/perp2/m_1_02.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(4219.197266, -4733.370605, 128.031250 - 63); 
NPC.Angles = Angle(0, 90, 0);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.DialogPanel:SetDialog("'Ay G, what's happenin?");
	
	GAMEMODE.DialogPanel:AddDialog('Erm... Hello, "G". Can I get a paint job?', NPC.Paint)
	GAMEMODE.DialogPanel:AddDialog('Do you do anything other than paint cars?', NPC.LightHop)
	GAMEMODE.DialogPanel:AddDialog("Nevermind...", LEAVE_DIALOG)
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.PerformPaint ( ID )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	local VehicleTable = lookForVT(ourVehicle);
	
	if VehicleTable.ID == 'z' then
		VehicleTable.ID = 'P';
		VehicleTable.RequiredClass = nil;
	end
	
	if (VehicleTable.RequiredClass || LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end

	if (LocalPlayer():GetCash() < VehicleTable.PaintJobCost) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you can pay for all of this?");
		GAMEMODE.DialogPanel:AddDialog("Not exactly...", LEAVE_DIALOG)
		
		return;
	end
	
	GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> There we go, it should be dried by now. That'll be " .. DollarSign() .. VehicleTable.PaintJobCost .. ".");
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
	
	LocalPlayer():TakeCash(VehicleTable.PaintJobCost, true);
	RunConsoleCommand("perp_v_s", ID);
	
	GAMEMODE.Vehicles[VehicleTable.ID][1] = tonumber(ID);
end

function NPC.PerformLights ( ID )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	local VehicleTable = lookForVT(ourVehicle);
	
	if VehicleTable.ID == 'z' then
		VehicleTable.ID = 'P';
		VehicleTable.RequiredClass = nil;
	end
	
	if (VehicleTable.RequiredClass || LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	else
		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> I hope you enjoy your new headlights. That'll be " .. DollarSign() .. (VehicleTable.PaintJobCost * 2) .. ".");
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
		LocalPlayer():TakeCash(VehicleTable.PaintJobCost * 2, true);
			if (GAMEMODE.Vehicles[VehicleTable.ID] && tonumber(GAMEMODE.Vehicles[VehicleTable.ID][4]) == 0) then
				// Headlights
				RunConsoleCommand("perp_v_l", ID);
				GAMEMODE.Vehicles[VehicleTable.ID][2] = tonumber(ID);
			else
				// Headlights
				RunConsoleCommand("perp_v_l", ID);
				GAMEMODE.Vehicles[VehicleTable.ID][2] = tonumber(ID);
				// Underglow
				RunConsoleCommand("perp_v_ugc", ID);
				GAMEMODE.Vehicles[lookForVT(ourVehicle).ID][4] = tonumber(ID);
			end;
	end;

	if (LocalPlayer():GetCash() < (VehicleTable.PaintJobCost * 2)) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you can pay for all of this?");
		GAMEMODE.DialogPanel:AddDialog("Not exactly...", LEAVE_DIALOG)
		
		return;
	end	
end

function NPC.Paint ( )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	if (!ourVehicle || !IsValid(ourVehicle) || ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?");
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG);
		
		return;
	end

	local VehicleTable = lookForVT(ourVehicle);
	
	if VehicleTable.ID == 'z' then
		VehicleTable.ID = 'P';
		VehicleTable.RequiredClass = nil;
	end
	
	if (VehicleTable.RequiredClass || LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end
	
	GAMEMODE.DialogPanel:SetDialog(VehicleTable.PaintText .. " What color did you want on it? Either way, it'll be " .. DollarSign() .. VehicleTable.PaintJobCost .. ". I only accept cash.");
	
	for k, v in pairs(VehicleTable.PaintJobs) do
		GAMEMODE.DialogPanel:AddPaintOption(v.name, v.color, NPC.PerformPaint, k);
	end
	
	GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
end

function NPC.Lights ( )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	if (!ourVehicle || !IsValid(ourVehicle) || ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?");
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG);
		
		return;
	end

	local VehicleTable = lookForVT(ourVehicle);
	
	if VehicleTable.ID == 'z' then
		VehicleTable.ID = 'P';
		VehicleTable.RequiredClass = nil;
	end
	
	if (VehicleTable.RequiredClass || LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end
	
	GAMEMODE.DialogPanel:SetDialog("We have quote a few colors, which would you like? No matter what you choose, it'll be " .. DollarSign() .. (VehicleTable.PaintJobCost * 2) .. " to install.");
	
	for k, v in pairs(HEADLIGHT_COLORS) do
		if (v[3] != "Gold" || LocalPlayer():IsGold()) then
			GAMEMODE.DialogPanel:AddPaintOption(v[3], v[2], NPC.PerformLights, k);
		end
	end
	
	GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
end

function NPC.Underglow ( )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	if (!ourVehicle || !IsValid(ourVehicle) || ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?");
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG);
		
		return;
	end

	local VehicleTable = lookForVT(ourVehicle);
	
	if VehicleTable.ID == 'z' then
		VehicleTable.ID = 'P';
		VehicleTable.RequiredClass = nil;
	end
	
	if (VehicleTable.RequiredClass || LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end
	
	if (GAMEMODE.Vehicles[VehicleTable.ID] && tonumber(GAMEMODE.Vehicles[VehicleTable.ID][4]) >= 1) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you want me to remove your underglow? It'll cost full price to put them back on if you ever want to.");
		
		GAMEMODE.DialogPanel:AddDialog("Yes, I'm sure.", NPC.DoUnderglow);
		GAMEMODE.DialogPanel:AddDialog("Let me think about it more.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Underglow cost " .. DollarSign() .. COST_FOR_UNDERGLOW .. " to install.");

		if (LocalPlayer():GetCash() >= COST_FOR_UNDERGLOW) then
			GAMEMODE.DialogPanel:AddDialog("Lets do it!", NPC.DoUnderglow);
		end
		
		GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
	end
end

--[[ 
function NPC.UnderglowColors ( )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	if (!ourVehicle || !IsValid(ourVehicle) || ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?");
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG);
		
		return;
	end

	local VehicleTable = lookForVT(ourVehicle);
	
	if (VehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end
	
	GAMEMODE.DialogPanel:SetDialog("We have quote a few colors, which would you like? No matter what you choose, it'll be " .. DollarSign() .. (VehicleTable.PaintJobCost * 2) .. " to install.");
	
	for k, v in pairs(UNDERGLOW_COLORS) do
		if (v[3] != "Gold" || LocalPlayer():IsGold() || LocalPlayer():SteamID() == "STEAM_0:0:25589967") then
			GAMEMODE.DialogPanel:AddPaintOption(v[3], v[2], NPC.PerformUnderglow, k);
		end
	end
	
	GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
end
 ]]
 
function NPC.DoUnderglow ( )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	if (!ourVehicle || !IsValid(ourVehicle) || ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?");
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG);
		
		return;
	end

	local VehicleTable = lookForVT(ourVehicle);
	
	if VehicleTable.ID == 'z' then
		VehicleTable.ID = 'P';
		VehicleTable.RequiredClass = nil;
	end
	
	if (VehicleTable.RequiredClass || LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end
		
	if (GAMEMODE.Vehicles[VehicleTable.ID] && tonumber(GAMEMODE.Vehicles[VehicleTable.ID][4]) >= 1) then
		RunConsoleCommand("perp_v_uga");
		GAMEMODE.Vehicles[VehicleTable.ID][4] = 0;
		
		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> Alright, I've removed them for you. Have a good day.");
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> You'll have fun with this, I promise. That'll be " .. DollarSign() .. COST_FOR_UNDERGLOW .. ".\n\n(You can activate your underglow with the g key.)");
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
	
		if (LocalPlayer():GetCash() < COST_FOR_UNDERGLOW) then return; end
		
		LocalPlayer():TakeCash(COST_FOR_UNDERGLOW, true);
		GAMEMODE.Vehicles[VehicleTable.ID][4] = 1;
		RunConsoleCommand("perp_v_uga");
	end
end

--[[
function NPC.PerformUnderglow ( ID )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	local VehicleTable = lookForVT(ourVehicle);
	
	if (VehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end

	if (LocalPlayer():GetCash() < (VehicleTable.PaintJobCost * 2)) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you can pay for all of this?");
		GAMEMODE.DialogPanel:AddDialog("Not exactly...", LEAVE_DIALOG)
		
		return;
	end
	
	GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> I hope you enjoy your new underglow. That'll be " .. DollarSign() .. (VehicleTable.PaintJobCost * 2) .. ".");
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
	
	LocalPlayer():TakeCash(VehicleTable.PaintJobCost * 2, true);
	RunConsoleCommand("perp_v_ugc", ID);
	
	GAMEMODE.Vehicles[VehicleTable.ID][4] = tonumber(ID);
end
]]

function NPC.DoHydraulics ( )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	if (!ourVehicle || !IsValid(ourVehicle) || ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?");
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG);
		
		return;
	end

	local VehicleTable = lookForVT(ourVehicle);
	
	if VehicleTable.ID == 'z' then
		VehicleTable.ID = 'P';
		VehicleTable.RequiredClass = nil;
	end
	
	if (VehicleTable.RequiredClass || LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end
		
	if (GAMEMODE.Vehicles[VehicleTable.ID] && tonumber(GAMEMODE.Vehicles[VehicleTable.ID][3]) == 1) then
		RunConsoleCommand("perp_v_j");
		GAMEMODE.Vehicles[VehicleTable.ID][3] = 0;
		
		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> Alright, I've removed them for you. Have a good day.");
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> You'll have fun with this, I promise. That'll be " .. DollarSign() .. COST_FOR_HYDRAULICS .. ".\n\n(You can activate your hydraulics with the shift key.)");
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
	
		if (LocalPlayer():GetCash() < COST_FOR_HYDRAULICS) then return; end
		
		LocalPlayer():TakeCash(COST_FOR_HYDRAULICS, true);
		GAMEMODE.Vehicles[VehicleTable.ID][3] = 1;
		RunConsoleCommand("perp_v_j");
	end
end

function NPC.Hydraulics ( )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	if (!ourVehicle || !IsValid(ourVehicle) || ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?");
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG);
		
		return;
	end

	local VehicleTable = lookForVT(ourVehicle);
	
	if VehicleTable.ID == 'z' then
		VehicleTable.ID = 'P';
		VehicleTable.RequiredClass = nil;
	end
	
	if (VehicleTable.RequiredClass || LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end
	
	if (GAMEMODE.Vehicles[VehicleTable.ID] && tonumber(GAMEMODE.Vehicles[VehicleTable.ID][3]) == 1) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you want me to remove your hydraulics? It'll cost full price to put them back on if you ever want to.");
		
		GAMEMODE.DialogPanel:AddDialog("Yes, I'm sure.", NPC.DoHydraulics);
		GAMEMODE.DialogPanel:AddDialog("Let me think about it more.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Hydraulics cost " .. DollarSign() .. COST_FOR_HYDRAULICS .. " to install.");

		if (LocalPlayer():GetCash() >= COST_FOR_HYDRAULICS) then
			GAMEMODE.DialogPanel:AddDialog("Lets do it!", NPC.DoHydraulics);
		end
		
		GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
	end
end

function NPC.LightHop ( )
	local ourVehicle;
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedEntity("owner") == LocalPlayer()) then
			ourVehicle = v;
		end
	end
	
	local VehicleTable;
	if (ourVehicle && IsValid(ourVehicle)) then
		VehicleTable = lookForVT(ourVehicle);
	end
	
	print(VehicleTable.ID);
	
	if VehicleTable.ID == 'z' then
		VehicleTable.ID = 'P';
		VehicleTable.RequiredClass = nil;
	end

	if (LocalPlayer():IsBronze()) then
		if (!VehicleTable) then
			GAMEMODE.DialogPanel:SetDialog("Of course. We also install custom headlights, hydraulics and now even underglow! But I'll need to see your car first before I can give you any prices.");
			GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG);
		elseif (VehicleTable.RequiredClass || LocalPlayer():Team() != TEAM_CITIZEN) then
			GAMEMODE.DialogPanel:SetDialog("Of course. We also install custom headlights, hydraulics and now even underglow! But I can't install it on that car.\n\n(You cannot modify government vehicles.)");
			GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG);
		else
			GAMEMODE.DialogPanel:SetDialog("Of course. We also install custom headlights, hydraulics and now even underglow!");
			
			GAMEMODE.DialogPanel:AddDialog('Awesome! What colors of headlights do you offer?', NPC.Lights)
			
			if (GAMEMODE.Vehicles[VehicleTable.ID] && tonumber(GAMEMODE.Vehicles[VehicleTable.ID][3]) == 1) then
				GAMEMODE.DialogPanel:AddDialog('Can you remove these hydraulics for me?', NPC.Hydraulics);
			else
				GAMEMODE.DialogPanel:AddDialog('How much do hydraulics cost?', NPC.Hydraulics);
			end
			
			if (GAMEMODE.Vehicles[VehicleTable.ID] && tonumber(GAMEMODE.Vehicles[VehicleTable.ID][4]) >= 1) then
				GAMEMODE.DialogPanel:AddDialog('Can you remove this underglow for me?', NPC.Underglow);
			else
				GAMEMODE.DialogPanel:AddDialog('How much does underglow cost?', NPC.Underglow);
			end
			
			GAMEMODE.DialogPanel:AddDialog("Nevermind.", LEAVE_DIALOG)
		end
	else
		GAMEMODE.DialogPanel:SetDialog("Of course. We also install custom headlights, hydraulics and now even underglow! But we don't do that for everybody that walks in here; only for the people who give off an aura of awesomeness, which you aren't doing right now.\n\n(You must be a VIP member to further customize your vehicle.)");
		
		GAMEMODE.DialogPanel:AddDialog("Oh... Nevermind, then...", LEAVE_DIALOG)
	end

	GAMEMODE.DialogPanel:Show();
end

GAMEMODE:LoadNPC(NPC);