
GM.PlayerItems = {};
GM.StorageItems = {};

function setItemSlot ( itemSlot, itemID, itemQuantity )
	GAMEMODE.PlayerItems[itemSlot] 				= {}
	GAMEMODE.PlayerItems[itemSlot].ID 			= itemID;
	GAMEMODE.PlayerItems[itemSlot].Table 		= ITEM_DATABASE[itemID];
	GAMEMODE.PlayerItems[itemSlot].Quantity 	= itemQuantity;
	
	GAMEMODE.InventoryBlocks_Linear[itemSlot]:GrabItem();
end

function setStorageSlot ( itemSlot, itemID, itemQuantity )
	GAMEMODE.StorageItems[itemSlot] 				= {}
	GAMEMODE.StorageItems[itemSlot].ID 			= itemID;
	GAMEMODE.StorageItems[itemSlot].Table 		= ITEM_DATABASE[itemID];
	GAMEMODE.StorageItems[itemSlot].Quantity 	= itemQuantity;
	
	GAMEMODE.InventoryBlocks_Linear[itemSlot]:GrabItem();
end

local function removeItem ( itemID, ammount )
	GAMEMODE.PlayerItems[itemID].Quantity = GAMEMODE.PlayerItems[itemID].Quantity - ammount;
			
	if (GAMEMODE.PlayerItems[itemID].Quantity <= 0) then
		if (server && itemID <= 2 && GAMEMODE.PlayerItems[itemID].Table.Holster) then
			GAMEMODE.PlayerItems[itemID].Table.Holster(LocalPlayer());
		end
	
		GAMEMODE.PlayerItems[itemID] = nil;
		GAMEMODE.InventoryBlocks_Linear[itemID]:GrabItem();
	end
end

local function removeStorage ( itemID, ammount )
	GAMEMODE.StorageItems[itemID].Quantity = GAMEMODE.StorageItems[itemID].Quantity - ammount;
			
	if (GAMEMODE.StorageItems[itemID].Quantity <= 0) then
		GAMEMODE.StorageItems[itemID] = nil;
		GAMEMODE.InventoryBlocks_Linear[itemID]:GrabItem();
	end
end

function GM.BankTake ( itemID, ammount)	
	local playerItems = GAMEMODE.PlayerItems
	local myItemTotal = tonumber(table.Count(playerItems));
	local primary = playerItems[2];
	local secondary = playerItems[1];
	local PFilled = util.tobool(primary);
	local SFilled = util.tobool(secondary);
	
	if (PFilled && SFilled) then
		myItemTotal = myItemTotal - 2
	elseif (PFilled || SFilled) then
		myItemTotal = myItemTotal - 1
	end
	
	if (myItemTotal >= (INVENTORY_HEIGHT * INVENTORY_WIDTH)) then
		surface.PlaySound('buttons/button10.wav')
		return;
	end
	
	local realID = GAMEMODE.StorageItems[itemID].Table.ID

	//client
	removeStorage(itemID, ammount);
	LocalPlayer():GiveItem(realID, ammount);

	//server
	RunConsoleCommand("perp_bs_t", itemID, ammount);
	surface.PlaySound('items/ammocrate_open.wav');
	
end

function GM.BankGive ( itemID, ammount)	
	local storageItems = GAMEMODE.StorageItems
	local myStorageTotal = tonumber(table.Count(storageItems));

	if (myStorageTotal >= (INVENTORY_HEIGHT * INVENTORY_WIDTH)) then
		surface.PlaySound('buttons/button10.wav')
		return;
	end
	
	local realID = GAMEMODE.PlayerItems[itemID].Table.ID
	//client
	removeItem(itemID, ammount);
	LocalPlayer():GiveStorage(realID, ammount)
		
	//server
	RunConsoleCommand("perp_bs_g", itemID, ammount);
	surface.PlaySound('items/ammocrate_close.wav');
	
end

// Client -> Server Networking
function GM.UseItem ( itemID )	
	if (LocalPlayer():InVehicle()) then return; end
	if (!LocalPlayer():Alive()) then LocalPlayer():Notify("You cannot manipulate items while dead."); return; end
	if (GAMEMODE.UnarrestTime) then LocalPlayer():Notify("You cannot manipulate items while in jail."); return; end
	
	if (GAMEMODE.PlayerItems[itemID]) then
		local useCommand = GAMEMODE.PlayerItems[itemID].Table.OnUse(itemID);
		
		if (useCommand && GAMEMODE.PlayerItems[itemID].Table.PredictUseDrop) then
			removeItem(itemID, 1);
		end
		
		RunConsoleCommand("perp_i_u", itemID);
	end
end

function GM.DropItem ( itemID )	

	if (LocalPlayer():InVehicle()) then return; end
	if (!LocalPlayer():Alive()) then LocalPlayer():Notify("You cannot manipulate items while dead."); return; end
	if (GAMEMODE.UnarrestTime) then LocalPlayer():Notify("You cannot manipulate items while in jail."); return; end

	if (GAMEMODE.PlayerItems[itemID]) then

		if itemID == 83 then
		Trace = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
		
		if Trace.HitWorld and Trace.MatType == MAT_DIRT then		
		else
			return false;
		end
		
		end	
		
		local dropCommand = GAMEMODE.PlayerItems[itemID].Table.OnDrop();
		
		if (GAMEMODE.PlayerItems[itemID].Table.PredictUseDrop && dropCommand) then
			removeItem(itemID, 1); 
			surface.PlaySound(DropItemSound);
		end
		
		RunConsoleCommand("perp_i_d", itemID);
	end
end

// Server -> Client Networking
local function parseSaveString ( input )
	local itemInfo = string.Explode(";", string.Trim(input));
	
	for k, v in pairs(itemInfo) do
		local splitAgain = string.Explode(",", v);
		
		if (#splitAgain == 3) then
			local itemSlot = tonumber(splitAgain[1]);
			
			setItemSlot(tonumber(splitAgain[1]), tonumber(splitAgain[2]), tonumber(splitAgain[3]));
			
			if (itemSlot <= 2 && ITEM_DATABASE[itemSlot].Equip) then
				ITEM_DATABASE[itemSlot].Equip(LocalPlayer());
			end
		end
	end
end

local function parseSSaveString ( input )
	local itemInfo = string.Explode(";", string.Trim(input));
	
	for k, v in pairs(itemInfo) do
		local splitAgain = string.Explode(",", v);
		
		if (#splitAgain == 3) then
			local itemSlot = tonumber(splitAgain[1]);
			setStorageSlot(tonumber(splitAgain[1]), tonumber(splitAgain[2]), tonumber(splitAgain[3]));
		end
	end
end


function ItemHook()
	
	parseSaveString(net.ReadString());

end
net.Receive("ItemHook",ItemHook)
--datastream.Hook("ItemHook", ItemHook);

function StorageHook( )
	
	parseSSaveString(net.ReadString());

end
net.Receive("StorageHook",StorageHook)
--datastream.Hook("StorageHook", StorageHook);

local function loadChangeItem ( UMsg )
	local itemSlot = UMsg:ReadShort();
	local itemID = UMsg:ReadShort();
	local itemQuantity = UMsg:ReadShort();
	
	setItemSlot(itemSlot, itemID, itemQuantity);
end
usermessage.Hook("perp_item_change", loadChangeItem);


local function loadChangeStorage ( UMsg )
	local itemSlot = UMsg:ReadShort();
	local itemID = UMsg:ReadShort();
	local itemQuantity = UMsg:ReadShort();
	
	setStorageSlot(itemSlot, itemID, itemQuantity);
end
usermessage.Hook("perp_storage_change", loadChangeStorage);


local function getRemovePredict ( UMsg )
	local itemID = UMsg:ReadShort();
	local sQuantity = UMsg:ReadShort();
	local sID = UMsg:ReadShort();
	
	if (GAMEMODE.PlayerItems[itemID] && GAMEMODE.PlayerItems[itemID].ID == sID && GAMEMODE.PlayerItems[itemID].Quantity == sQuantity) then
		removeItem(itemID, 1);
	else
		for k, v in pairs(GAMEMODE.PlayerItems) do
			if (v.ID == sID && v.Quantity == sQuantity) then
				removeItem(k, 1);
			end
		end
	end
end
usermessage.Hook("perp_item_rem1", getRemovePredict)


local function getRemovePredictS ( UMsg )
	local itemID = UMsg:ReadShort();
	local sQuantity = UMsg:ReadShort();
	local sID = UMsg:ReadShort();
	
	if (GAMEMODE.StorageItems[itemID] && GAMEMODE.StorageItems[itemID].ID == sID && GAMEMODE.StorageItems[itemID].Quantity == sQuantity) then
		removeItem(itemID, 1);
	else
		for k, v in pairs(GAMEMODE.StorageItems) do
			if (v.ID == sID && v.Quantity == sQuantity) then
				removeItem(k, 1);
			end
		end
	end
end
usermessage.Hook("perp_storage_rem1", getRemovePredictS)


DropItemSound = Sound('items/ammocrate_close.wav');
local function getRemovePredictDrop ( UMsg )
	local itemID = UMsg:ReadShort();
	local sQuantity = UMsg:ReadShort();
	local sID = UMsg:ReadShort();
	
	if (GAMEMODE.PlayerItems[itemID] && GAMEMODE.PlayerItems[itemID].ID == sID && GAMEMODE.PlayerItems[itemID].Quantity == sQuantity) then
		removeItem(itemID, 1);
	else
		for k, v in pairs(GAMEMODE.PlayerItems) do
			if (v.ID == sID && v.Quantity == sQuantity) then
				removeItem(k, 1);
			end
		end
	end
	
	surface.PlaySound(DropItemSound);
end
usermessage.Hook("perp_item_rem1_d", getRemovePredictDrop)

local newItem = Sound('items/ammocrate_open.wav');
local function getAddItem ( UMsg )
	local itemID = UMsg:ReadShort();
	local itemQuantity = UMsg:ReadShort();
	
	LocalPlayer():GiveItem(itemID, itemQuantity);
	surface.PlaySound(newItem);
end
usermessage.Hook("perp2_item_add1", getAddItem);

/*
local function getAddStorage ( UMsg )
	local itemID = UMsg:ReadShort();
	local itemQuantity = UMsg:ReadShort();
	
	LocalPlayer():GiveStorage(itemID, itemQuantity);
	surface.PlaySound(newItem);
end
usermessage.Hook("perp2_storage_add1", getAddStorage);
*/

// Buy / Sell
local ThatDoesntGoThere = Sound("buttons/button10.wav");
local CashRegister = Sound("PERP2.5/register.mp3");
function GM.SellItem ( itemID, Ammount )
	if (!LocalPlayer():Alive()) then LocalPlayer():Notify("You cannot manipulate items while dead."); return; end
	local itemTable = GAMEMODE.PlayerItems[itemID].Table;
	
	if (!itemTable) then return; end
	if (itemTable.RestrictedSelling) then return; end
	
	if (LocalPlayer():GetItemCount(itemTable.ID) < Ammount) then
		surface.PlaySound(ThatDoesntGoThere);
		LocalPlayer():Notify("You don't have enough items to sell that many.", true);
		return;
	end
	
	// Go ahead with it.
	local Total = math.floor(Ammount * itemTable.Cost * .5);
	LocalPlayer():GiveCash(Total);
	
	LocalPlayer():TakeItem(itemID, Ammount);
	surface.PlaySound(CashRegister);
	
	RunConsoleCommand("perp_i_s", itemID, Ammount);
end

function GM.BuyItem ( itemTable, Ammount )
	if (!LocalPlayer():Alive()) then LocalPlayer():Notify("You cannot manipulate items while dead."); return; end
	local Total = Ammount * (itemTable.Cost + math.Round(itemTable.Cost * GAMEMODE.GetTaxRate_Sales()));

	if (LocalPlayer():GetCash() < Total) then
		surface.PlaySound(ThatDoesntGoThere);
		LocalPlayer():Notify("You don't have enough money.", true);
		return;
	end
	
	if (!LocalPlayer():CanHoldItem(itemTable.ID, Ammount)) then
		surface.PlaySound(ThatDoesntGoThere);
		LocalPlayer():Notify("You don't have enough inventory room.", true);
		return;
	end
	
	// Go ahead with it.
	LocalPlayer():TakeCash(Total);
	
	LocalPlayer():GiveItem(itemTable.ID, Ammount);
	surface.PlaySound(newItem);
	
	RunConsoleCommand("perp_i_b", itemTable.ID, Ammount);
end

function GM.AttemptToEquip ( slotID )
	if (!GAMEMODE.PlayerItems[slotID]) then return; end
	if (!GAMEMODE.PlayerItems[slotID].Table.EquipZone) then return; end
	if (slotID <= 2) then return; end
	
	LocalPlayer():SwapItemPosition(slotID, GAMEMODE.PlayerItems[slotID].Table.EquipZone);
end

function GM.RemoveEquipped ( UMsg )
	local id = UMsg:ReadShort();

	GAMEMODE.PlayerItems[id] = nil;
	GAMEMODE.InventoryBlocks_Linear[id]:GrabItem();
end
usermessage.Hook("perp_rem_eqp", GM.RemoveEquipped);