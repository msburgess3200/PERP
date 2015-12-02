
function PLAYER:setItemSlot ( itemSlot, itemID, itemQuantity )
	self.PlayerItems[itemSlot] 				= {}
	self.PlayerItems[itemSlot].ID 			= itemID;
	self.PlayerItems[itemSlot].Table 		= ITEM_DATABASE[itemID];
	self.PlayerItems[itemSlot].Quantity 	= itemQuantity;
end

function PLAYER:setStorageSlot ( itemSlot, itemID, itemQuantity )
	self.StorageItems[itemSlot] 				= {}
	self.StorageItems[itemSlot].ID 			= itemID;
	self.StorageItems[itemSlot].Table 		= ITEM_DATABASE[itemID];
	self.StorageItems[itemSlot].Quantity 	= itemQuantity;
end

// Loading
function PLAYER:parseSaveString ( input )
	local itemInfo = string.Explode(";", string.Trim(input));
	
	for k, v in pairs(itemInfo) do
		local splitAgain = string.Explode(",", v);
		
		if (#splitAgain == 3) then
			local itemSlot = tonumber(splitAgain[1]);
			self:setItemSlot(itemSlot, tonumber(splitAgain[2]), tonumber(splitAgain[3]));
			
			if (itemSlot <= 2 && ITEM_DATABASE[itemSlot].Equip) then
				ITEM_DATABASE[itemSlot].Equip(self);
			end
		end
	end
end

function PLAYER:parseSSaveString ( input )
	local itemInfo = string.Explode(";", string.Trim(input));
	
	for k, v in pairs(itemInfo) do
		local splitAgain = string.Explode(",", v);
		
		if (#splitAgain == 3) then
			local itemSlot = tonumber(splitAgain[1]);
			self:setStorageSlot(itemSlot, tonumber(splitAgain[2]), tonumber(splitAgain[3]));
		end
	end
end
// Save
function PLAYER:CompileItems ( )
	local saveString = "";
	
	for k, v in pairs(self.PlayerItems) do
		saveString = saveString .. k .. "," .. v.ID .. "," .. v.Quantity .. ";";
	end
	
	return saveString;
end

function PLAYER:CompileStorage ( )
	local saveString = "";
	
	for k, v in pairs(self.StorageItems) do
		saveString = saveString .. k .. "," .. v.ID .. "," .. v.Quantity .. ";";
	end
	
	return saveString;
end

// Client -> Server Networking
local function receiveSwapCommand ( Player, Cmd, Args )
	if (!Args[1] || !Args[2]) then return false; end
	if (!Player:Alive()) then return; end
	if (Player:InVehicle()) then return; end
	if (Player.CurrentlyJailed) then return; end
	
	local firstItem = tonumber(Args[1] or 0);
	local secondItem = tonumber(Args[2] or 0);
	
	Player:SwapItemPosition(firstItem, secondItem);
end
concommand.Add("perp_i_sp", receiveSwapCommand);

local function receiveUseCommand ( Player, Cmd, Args )
	if (!Args[1]) then return false; end
	if (Player:InVehicle()) then return; end
	if (!Player:Alive()) then return; end
	if (Player.CurrentlyJailed) then return; end
	
	local item = tonumber(Args[1] or 0);
	
	if (Player.PlayerItems[item]) then
		local useCommand = Player.PlayerItems[item].Table.OnUse(Player);
		
		if (useCommand) then
			Player.PlayerItems[item].Quantity = Player.PlayerItems[item].Quantity - 1;
			
			if (!Player.PlayerItems[item].Table.PredictUseDrop) then
				umsg.Start("perp_item_rem1", Player);
					umsg.Short(item);
					umsg.Short(Player.PlayerItems[item].Quantity + 1);
					umsg.Short(Player.PlayerItems[item].ID);
				umsg.End();
			end
			
			if (Player.PlayerItems[item].Quantity == 0) then
				if (item <= 2 && Player.PlayerItems[item].Table.Holster) then
					Player.PlayerItems[item].Table.Holster(LPlayer)
				end
			
				Player.PlayerItems[item] = nil;
			end
		end
	end
end
concommand.Add("perp_i_u", receiveUseCommand);

local function receiveDropCommand ( Player, Cmd, Args )
	if (!Args[1]) then return false; end
	if (Player:InVehicle()) then return; end
	if (!Player:Alive()) then return; end
	if (Player.CurrentlyJailed) then return; end
	
	local item = tonumber(Args[1] or 0);
	
	if (Player.PlayerItems[item]) then
		local itemTable = Player.PlayerItems[item].Table;
		
		local useCommand = Player.PlayerItems[item].Table.OnDrop(Player);
		
		if (useCommand) then
			Player.PlayerItems[item].Quantity = Player.PlayerItems[item].Quantity - 1;
			
			if (!Player.PlayerItems[item].Table.PredictUseDrop) then
				umsg.Start("perp_item_rem1_d", Player);
					umsg.Short(item);
					umsg.Short(Player.PlayerItems[item].Quantity + 1);
					umsg.Short(Player.PlayerItems[item].ID);
				umsg.End();
			end
			
			if (Player.PlayerItems[item].Quantity == 0) then
				if (item <= 2 && Player.PlayerItems[item].Table.Holster) then
					Player.PlayerItems[item].Table.Holster(Player)
				end
			
				Player.PlayerItems[item] = nil;
			end
		//Let's check to make sure your not dropping a shroom with this system :)
		
		if itemTable.ID == 83 then
		else
			local trace = {};
				trace.start = Player:GetShootPos();
				trace.endpos = Player:GetShootPos() + Player:GetAimVector() * 50;
				trace.filter = Player;
			local tRes = util.TraceLine(trace);
			
			local itemDrop = ents.Create("ent_item");
				itemDrop:SetModel(itemTable.WorldModel);
				itemDrop:SetContents(itemTable.ID, Player);
				itemDrop:SetPos(tRes.HitPos);
			itemDrop:Spawn();
			
			if (GAMEMODE.FindCashRegister(tRes.HitPos, 256, Player)) then
				itemDrop:SetNetworkedString("title", itemTable.Name)
				
				Player.LastDroppedItem = itemDrop
				
				umsg.Start("perp2_name_item", Player)
					umsg.Short(itemTable.ID)
					umsg.Entity(itemDrop)
				umsg.End()
			end
		end
		end
	end
end
concommand.Add("perp_i_d", receiveDropCommand);

function receiveBuyCommand ( Player, Cmd, Args )
	if (!Args[1] || !Args[2]) then return false; end
	if (!Player:Alive()) then return; end
	
	local itemID = tonumber(Args[1] or 0);
	local Ammount = tonumber(Args[2] or 0);
	local itemTable = ITEM_DATABASE[itemID];
	
	if (Ammount <= 0) then return; end
	
	local StoresThatHave = {};
	for k, v in pairs(SHOP_DATABASE) do
		for _, i in pairs(v.Items) do
			if i == itemID then
				table.insert(StoresThatHave, v.NPCAssociation);
			elseif (type(i) == "table" && i[1] == itemTable.Reference) then
				for _, date in pairs(i[2]) do
					if (date == GetGlobalString("os.date", "")) then
						table.insert(StoresThatHave, v.NPCAssociation);
						break
					end
				end
			end
		end
	end
		
	local canBuy = false;
	for k, v in pairs(ents.FindByClass("npc_vendor")) do
		if (!canBuy) then
			local Dist = v:GetPos():Distance(Player:GetPos());
			
			if (Dist <= 200) then				
				for _, i in pairs(StoresThatHave) do
					if (v.NPCID == i) then						
						canBuy = true;
						break;
					end
				end
			end
		end
	end
	
	if (!canBuy) then return; end
	
	local Total = Ammount * (itemTable.Cost + math.Round(itemTable.Cost * GAMEMODE.GetTaxRate_Sales()));

	if (Player:GetCash() < Total) then return; end
	if (!Player:CanHoldItem(itemTable.ID, Ammount)) then return; end
	
	// Go ahead with it.
	Player:TakeCash(Total, true);
	Player:GiveItem(itemTable.ID, Ammount);
end
concommand.Add("perp_i_b", receiveBuyCommand);

local function receiveSellCommand ( Player, Cmd, Args )
	if (!Args[1] || !Args[2]) then return false; end
	if (!Player:Alive()) then return; end
	
	local itemID = tonumber(Args[1] or 0);
	local Ammount = tonumber(Args[2] or 0);
	local itemTable = Player.PlayerItems[itemID].Table;
	
	if (Ammount <= 0) then return; end
	if (!itemTable) then return; end
	if (itemTable.RestrictedSelling) then return; end
	
	if (Player:GetItemCount(itemTable.ID) < Ammount) then return; end
	
	// Go ahead with it.
	local Total = math.floor(Ammount * itemTable.Cost * .5);
	Player:GiveCash(Total);
	
	Player:TakeItem(itemID, Ammount);
end
concommand.Add("perp_i_s", receiveSellCommand);

local function TakeBank (Player, Cmd, Args)

	local itemID = tonumber(Args[1])
	local ammount = tonumber(Args[2])
	local itemTable = Player.StorageItems[itemID].Table;
	
	local realID = tonumber(itemTable.ID)
	
	Player:TakeStorage(itemID, ammount);
	Player:GiveItem(realID, ammount);
	
end
concommand.Add("perp_bs_t", TakeBank)

local function GiveBank (Player, Cmd, Args)
	
	local itemID = tonumber(Args[1])
	local ammount = tonumber(Args[2])
	local itemTable = Player.PlayerItems[itemID].Table;
		
	local realID = tonumber(itemTable.ID)
		
	Player:TakeItem(itemID, ammount);
	Player:GiveStorage(realID, ammount);
	
end
concommand.Add("perp_bs_g", GiveBank)
	
function GM.FindHeatSource ( Position, Size, skipFire )
	for k, v in pairs(ents.FindInSphere(Position, Size)) do
		if (v:GetTable().HeatSource) then
			if !skipFire && math.random(1, 100) == 1 then
				local Fire = ents.Create('ent_fire');
				Fire:SetPos(v:GetPos());
				Fire:Spawn();
				
				v:Remove();
			end
		
			return true;
		end
	end
end

function GM.FindWaterSource ( Position, Size )
	for k, v in pairs(ents.FindInSphere(Position, Size)) do
		if (v:GetTable().WaterSource) then
			return true;
		end
	end
end

function GM.FindSawHorse ( Position, Size )
	for k, v in pairs(ents.FindInSphere(Position, Size)) do
		if (v:GetTable().SawHorse) then
			return true;
		end
	end
end

function GM.FindCashRegister ( Position, Size, Player )
	for k, v in pairs(ents.FindInSphere(Position, Size)) do
		if (v:GetModel() == "models/props_c17/cashregister01a.mdl" && v:GetClass() == "ent_prop_item" && v:GetTable().Owner == Player) then
			return true;
		end
	end
end

function GM.SItem ( user, cmd, args )
	if (!args[1] || !args[2]) then return end
	if (!user.LastDroppedItem || !IsValid(user.LastDroppedItem)) then return end
	
	local itemName = args[1]
	local itemPrice = math.Clamp(tonumber(args[2]), 0, 50000)
	
	user.LastDroppedItem:SetNetworkedInt("price", itemPrice)
	user.LastDroppedItem:SetNetworkedString("title", itemName)
end
concommand.Add("perp_sitem", GM.SItem)