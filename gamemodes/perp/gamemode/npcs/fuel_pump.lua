


local NPC = {};

NPC.Name = "Fuel Pump";
NPC.ID = 25;

FuelMax = 10000;

NPC.Model = Model("models/props_wasteland/gaspump001a.mdl");
NPC.Invisible = true; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = {Vector(-6533, -6583, 70), Vector(-6460, -6583, 70), Vector(-6460, -6286, 70), Vector(-6533, -6286, 64), Vector(-6530, -5996, 64), Vector(-6463, -5996, 64), Vector(10741, 13291, 64), Vector(10973, 13290, 64), Vector(10975, 13574, 64), Vector(10738, 13567, 64), Vector(10042, 13569, 64), Vector(9811, 13564, 64), Vector(9806, 13297, 64), Vector(10042, 13289, 64)};
NPC.Angles = {Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0)};
NPC.ShowChatBubble = false;

NPC.Sequence = -1;

// This is always local player.
function NPC.OnTalk ( )
	local CID = ClientCar;
		if CID == nil or CID == 0 or CID == 30 then
			GAMEMODE.DialogPanel:SetDialog("I don't have a car to refuel. (Retrive your car or respawn if it's a govt vehicle.)");
		
			GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG);
	
			GAMEMODE.DialogPanel:Show();
else
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedInt("carid") == tonumber(CID)) then
			ourVehicle = v;
					VOwner = ourVehicle:GetNetworkedEntity("owner");
					if VOwner == nil then return end;
					CurFuel = ourVehicle:GetNetworkedInt("fuel");
					GAMEMODE.DialogPanel:SetDialog("Welcome to the Sierra City Fuel Station.");
	
					NPC.MakeDialogButtons();
			
					GAMEMODE.DialogPanel:Show();
			end
		end
	end
end

function NPC.MakeDialogButtons ( )
	GAMEMODE.DialogPanel:AddDialog("Buy fuel", NPC.Deposit)
	GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG)
end


// Deposit Functions
function NPC.Deposit ( )
	GAMEMODE.DialogPanel:SetDialog("How much gas would you like to buy?");
	
	GAMEMODE.DialogPanel:AddDialog("Check your gas", NPC.CheckGas);
	GAMEMODE.DialogPanel:AddDialog("1/4 tank", NPC.Quarter);
	GAMEMODE.DialogPanel:AddDialog("1/2 tank", NPC.Half);
	GAMEMODE.DialogPanel:AddDialog("Fill it", NPC.FillIt);
end

function NPC.Gas ( ammount )
if (LocalPlayer():Team() != TEAM_CITIZEN) then
	GAMEMODE.DialogPanel:SetDialog("I should ask my boss about this.\n\n(Government vehicles do not require gas.)");
	GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG)
	return;
end
if (!ourVehicle || !IsValid(ourVehicle) || ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
	GAMEMODE.DialogPanel:SetDialog("I probably should bring my car closer to the pump. (the car is too far away)");
	
	GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG)
	else
	local CashToTake = math.Clamp(math.Round(ammount * .03),0,10000)
	if (LocalPlayer():GetCash() >= CashToTake) then
	RunConsoleCommand("perp_t_f", ammount, CashToTake);
		
		LocalPlayer():AddFuel(ammount);
		LocalPlayer():TakeCash(CashToTake);
		
		GAMEMODE.DialogPanel:SetDialog("Thank you for your purchase.");

		GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG);
		else
		GAMEMODE.DialogPanel:SetDialog("I don't have that much money.");
				GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG);

		end
	end
end

function NPC.Quarter ( )
if FuelMax - CurFuel < 2500 then 
	local Total = FuelMax - CurFuel;
	NPC.Gas(Total);
	else
	NPC.Gas(2500);
	end
 end
 
function NPC.Half ( ) 
if FuelMax <= CurFuel then NPC.Gas(0); end
if FuelMax - CurFuel < 5000 then
	NPC.Gas(math.Clamp(FuelMax - CurFuel, 0, 10000));
	else
	NPC.Gas(5000);
	end
 end
 
function NPC.FillIt ( ) NPC.Gas(math.Clamp(10000 - CurFuel, 0, 10000)); end


function NPC.CheckGas ( )
	if (LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I should ask my boss about this.\n\n(Government vehicles do not require gas.)");
		GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG)
		return;
	end
	PerFuel = math.Round(CurFuel / 100)
	GAMEMODE.DialogPanel:SetDialog("Current Fuel: " .. PerFuel .. "%\n\nWhat would you like to do?");
	
	NPC.MakeDialogButtons();
end

GAMEMODE:LoadNPC(NPC);