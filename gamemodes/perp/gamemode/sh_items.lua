

 
ITEM_DATABASE = {};

function GM:RegisterItem ( ItemTable )
	if (ITEM_DATABASE[ItemTable.ID]) then
		Error("Conflicting ItemTable ID's: " .. ItemTable.ID .. "\n");
	end
	
	ITEM_DATABASE[ItemTable.ID] = ItemTable;
	Msg("\t-> Loaded " .. ItemTable.Name .. "\n");
end

local ThatDoesntGoThere = Sound("buttons/button10.wav");
local PerfectMatch = Sound("UI/buttonclickrelease.wav");
function PLAYER:SwapItemPosition ( first, second )	
	if (self:InVehicle()) then return; end
	if (!self:Alive()) then self:Notify("You cannot manipulate items while dead."); return; end
	if (CLIENT && GAMEMODE.UnarrestTime) then LocalPlayer():Notify("You cannot manipulate items while in jail."); return; end
	if (SERVER && self.CurrentlyJailed) then LocalPlayer():Notify("You cannot manipulate items while in jail."); return; end
	
	local playerItems
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems;
	else
		playerItems = self.PlayerItems;
	end

	local firstB = playerItems[first];
	local secondB = playerItems[second];
	
	local haveFirst = util.tobool(firstB);
	local haveSecond = util.tobool(secondB)
	
	if (!firstB) then return false; end
	
	//fix for that damn molotov glitch
	if (first <= 2) then
		if (haveSecond) then
			if CLIENT then
				surface.PlaySound(ThatDoesntGoThere);
				return false
			end
		end
	end
	
	if (second <= 2) then
		if !(firstB.Table.EquipZone && firstB.Table.EquipZone == second) then
			if CLIENT then
				surface.PlaySound(ThatDoesntGoThere);
				GAMEMODE.InventoryBlocks_Linear[first]:GrabItem();
				GAMEMODE.InventoryBlocks_Linear[second]:GrabItem();
			end
			
			return false;
		end
		
		if (haveSecond && firstB.Quantity > 1) then
			if CLIENT then
				GAMEMODE.InventoryBlocks_Linear[first]:GrabItem();
				GAMEMODE.InventoryBlocks_Linear[second]:GrabItem();
				
				if (secondB.Table != firstB.Table) then
					surface.PlaySound(ThatDoesntGoThere);
				else
					surface.PlaySound(PerfectMatch);
				end
			end
			
			return false
		end
		
		if (!haveSecond && firstB.Quantity > 1) then
			if SERVER then
				self:setItemSlot(second, firstB.ID, firstB.Quantity - 1);
			else
				setItemSlot(second, firstB.ID, firstB.Quantity - 1);
			end
			
			firstB.Quantity = 1;
		end
	elseif (haveSecond && firstB.ID == secondB.ID) then
		prospectiveNum = firstB.Quantity + secondB.Quantity;
		newStack = math.Clamp(prospectiveNum, 1, firstB.Table.MaxStack);
		oldStack = prospectiveNum - newStack;
		
		if (oldStack == 0) then
			playerItems[second] = nil;
			playerItems[first].Quantity = newStack;
		else
			playerItems[second].Quantity = oldStack;
			playerItems[first].Quantity = newStack;
		end
	elseif (haveSecond && first <= 2) then
		if (secondB.Quantity > 1) then
			if CLIENT then
				surface.PlaySound(ThatDoesntGoThere);
				GAMEMODE.InventoryBlocks_Linear[first]:GrabItem();
				GAMEMODE.InventoryBlocks_Linear[second]:GrabItem();
			end
			
			return false;
		end
	end
	
	local secondB = playerItems[second];
	local firstB = playerItems[first];
	
	if SERVER && self:Team() == TEAM_CITIZEN then
		if (second <= 2 && firstB.Table.Equip) then
			firstB.Table.Equip(self)
			
			if (haveSecond && secondB && secondB.Table.Holster) then
				secondB.Table.Holster(self)
			end
		elseif (first <= 2 && firstB.Table.Holster) then
			firstB.Table.Holster(self)
			
			if (haveSecond && secondB && secondB.Table.Equip) then
				secondB.Table.Equip(self)
			end
		end
	elseif CLIENT && self:Team() == TEAM_CITIZEN then
		if ((second <= 2 && firstB.Table.Equip) || (first <= 2 && firstB.Table.Holster)) then
			self:Notify("Government officials may not equip weapons.");
		end
	end
	
	playerItems[first] = secondB;
	playerItems[second] = firstB;
	
	if CLIENT then
		surface.PlaySound(PerfectMatch);
		
		GAMEMODE.InventoryBlocks_Linear[first]:GrabItem();
		GAMEMODE.InventoryBlocks_Linear[second]:GrabItem();
		
		RunConsoleCommand("perp_i_sp", first, second);
	end
end

function PLAYER:HasItem ( itemName )
	if (itemName == "item_phone" && self:Team() == TEAM_DISPATCHER) then return true; end

	local ID;
	for k, v in pairs(ITEM_DATABASE) do
		if (v.Reference == itemName) then
			ID = v.ID;
		end
	end
	
	if (!ID) then
		Msg("Couldn't find item with ID " .. itemName .. "\n");
		return false;
	end

	return (self:GetItemCount(ID) > 0);
end

function PLAYER:GetItemCount ( itemID )	
	local playerItems;
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems;
	else
		playerItems = self.PlayerItems;
	end
	
	local Quantity = 0;
	for k, v in pairs(playerItems) do
		if (v.ID == itemID) then
			Quantity = Quantity + v.Quantity;
		end
	end
	
	return Quantity;
end

function PLAYER:GetStorageCount ( itemID )	
	local storageItems;
	if CLIENT then
		storageItems = GAMEMODE.Storage;
	else
		storageItems = self.StorageItems;
	end
	
	local Quantity = 0;
	for k, v in pairs(storageItems) do
		if (v.ID == itemID) then
			Quantity = Quantity + v.Quantity;
		end
	end
	
	return Quantity;
end

function PLAYER:CanHoldItem ( itemID, Quantity )
	local itemTable = ITEM_DATABASE[itemID];
	
	local playerItems;
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems;
	else
		playerItems = self.PlayerItems;
	end
	
	local numToAdd = Quantity;
	for i = 3, INVENTORY_HEIGHT * INVENTORY_WIDTH + 2 do
		if (playerItems[i]) then
			if (playerItems[i].Table == itemTable && playerItems[i].Quantity < itemTable.MaxStack) then
				numToAdd = numToAdd - (itemTable.MaxStack - playerItems[i].Quantity);
			end
		else
			numToAdd = numToAdd - itemTable.MaxStack;
		end
		
		if (numToAdd <= 0) then break; end
	end
	
	return (numToAdd <= 0);
end

function PLAYER:CanHoldStorage ( itemID, Quantity )
	local itemTable = ITEM_DATABASE[itemID];
	
	local storageItems;
	if CLIENT then
		storageItems = GAMEMODE.StorageItems;
	else
		storageItems = self.StorageItems;
	end
	
	local numToAdd = Quantity;
	for i = 3, INVENTORY_HEIGHT * INVENTORY_WIDTH + 2 do
		if (storageItems[i]) then
			if (storageItems[i].Table == itemTable && storageItems[i].Quantity < itemTable.MaxStack) then
				numToAdd = numToAdd - (itemTable.MaxStack - storageItems[i].Quantity);
			end
		else
			numToAdd = numToAdd - itemTable.MaxStack;
		end
		
		if (numToAdd <= 0) then break; end
	end
	
	return (numToAdd <= 0);
end

function PLAYER:GiveItem ( itemID, Quantity, ClientImpulse )
	local itemTable = ITEM_DATABASE[itemID];

	local playerItems;
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems;
	else
		playerItems = self.PlayerItems;
	end
	
	local numToAdd = Quantity;
	for k, v in pairs(playerItems) do
		if (v.ID == itemID && v.Quantity < itemTable.MaxStack) then
			local ProspAdd = math.Clamp(itemTable.MaxStack - v.Quantity, 0, numToAdd);
			v.Quantity = v.Quantity + ProspAdd;
			
			numToAdd = numToAdd - ProspAdd;
			
			if CLIENT then
				GAMEMODE.InventoryBlocks_Linear[k]:GrabItem();
				
				if GAMEMODE.ShopPanel then
					GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[k]:GrabItem();
				end
			end
		end
		
		if (numToAdd <= 0) then break; end
	end
	
	if (numToAdd > 0) then
		for i = 3, INVENTORY_HEIGHT * INVENTORY_WIDTH + 2 do
			if (!playerItems[i]) then
				local ProspAdd = math.Clamp(itemTable.MaxStack, 0, numToAdd);
				
				if CLIENT then
					setItemSlot(i, itemID, ProspAdd);
					GAMEMODE.InventoryBlocks_Linear[i]:GrabItem();
					
					if GAMEMODE.ShopPanel then
						GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[i]:GrabItem();
					end
				else
					self:setItemSlot(i, itemID, ProspAdd);
				end
				
				numToAdd = numToAdd - ProspAdd;
			end
			
			if (numToAdd <= 0) then break; end
		end
	end
	
	if (SERVER && ClientImpulse) then
		umsg.Start("perp2_item_add1", self);
			umsg.Short(itemID);
			umsg.Short(Quantity);
		umsg.End();
	end
end

function PLAYER:TakeItemByID(itemID, Quantity, bNetwork)
	local playerItems
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems
	else
		playerItems = self.PlayerItems
	end
	
	for k, v in pairs(playerItems) do
		if(v.Table.ID == itemID) then
			self:TakeItem(k, Quantity)
			break
		end
	end
	
	if(bNetwork and SERVER) then
		umsg.Start("perp_takeitemnw", self)
		umsg.Long(itemID)
		umsg.Long(Quantity)
		umsg.End()
	end
end
usermessage.Hook("perp_takeitemnw", function(um)
	LocalPlayer():TakeItemByID(um:ReadLong(), um:ReadLong())
end)

function PLAYER:GiveStorage ( itemID, Quantity, ClientImpulse )
	local itemTable = ITEM_DATABASE[itemID];
	
	local storageItems;
	if CLIENT then
		storageItems = GAMEMODE.StorageItems;
	else
		storageItems = self.StorageItems;
	end
	
	local numToAdd = Quantity;
	for k, v in pairs(storageItems) do
		if (v.ID == itemID && v.Quantity < itemTable.MaxStack) then
			local ProspAdd = math.Clamp(itemTable.MaxStack - v.Quantity, 0, numToAdd);
			v.Quantity = v.Quantity + ProspAdd;
			
			numToAdd = numToAdd - ProspAdd;
			
			if CLIENT then
				GAMEMODE.InventoryBlocks_Linear[k]:GrabItem();
				
				if GAMEMODE.ShopPanel then
					GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[k]:GrabItem();
				end
			end
		end
		
		if (numToAdd <= 0) then break; end
	end
	
	if (numToAdd > 0) then
		for i = 3, INVENTORY_HEIGHT * INVENTORY_WIDTH + 2 do
			if (!storageItems[i]) then
				local ProspAdd = math.Clamp(itemTable.MaxStack, 0, numToAdd);
				
				if CLIENT then
					setStorageSlot(i, itemID, ProspAdd);
					GAMEMODE.InventoryBlocks_Linear[i]:GrabItem();
					
					if GAMEMODE.ShopPanel then
						GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[i]:GrabItem();
					end
				else
					self:setStorageSlot(i, itemID, ProspAdd);
				end
				
				numToAdd = numToAdd - ProspAdd;
			end
			
			if (numToAdd <= 0) then break; end
		end
	end
	
	if (SERVER && ClientImpulse) then
		umsg.Start("perp2_storage_add1", self);
			umsg.Short(itemID);
			umsg.Short(Quantity);
		umsg.End();
	end
end

function PLAYER:TakeItem ( itemID, Quantity )
	local playerItems;
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems;
	else
		playerItems = self.PlayerItems;
	end
	
	local itemTable = playerItems[itemID].Table;
	
	local numToTake = Quantity;
	
	// Check the true stack first.
	local BoutToTake = math.Clamp(playerItems[itemID].Quantity, 0, numToTake);
	playerItems[itemID].Quantity = playerItems[itemID].Quantity - BoutToTake;
	
	if (playerItems[itemID].Quantity <= 0) then
		playerItems[itemID] = nil;
	end
	
	if CLIENT then
		GAMEMODE.InventoryBlocks_Linear[itemID]:GrabItem();
				
		if GAMEMODE.ShopPanel then
			GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[itemID]:GrabItem();
		end
	end
			
	numToTake = numToTake - BoutToTake;
	
	if (numToTake <= 0) then return; end
	
	for k, v in pairs(playerItems) do
		if (v.ID == itemTable.ID) then
			local BoutToTake = math.Clamp(v.Quantity, 0, numToTake);
			
			v.Quantity = v.Quantity - BoutToTake
			
			if (v.Quantity <= 0) then
				playerItems[k] = nil;
			end
			
			if CLIENT then
				GAMEMODE.InventoryBlocks_Linear[k]:GrabItem();
				
				if GAMEMODE.ShopPanel then
					GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[k]:GrabItem();
				end
			end
			
			numToTake = numToTake - BoutToTake;
		end
		
		if (numToTake <= 0) then return; end
	end
end

function PLAYER:TakeStorage ( itemID, Quantity )
	local storageItems;
	if CLIENT then
		storageItems = GAMEMODE.StorageItems;
	else
		storageItems = self.StorageItems;
	end
	
	local itemTable = storageItems[itemID].Table;
	
	local numToTake = Quantity;
	
	// Check the true stack first.
	local BoutToTake = math.Clamp(storageItems[itemID].Quantity, 0, numToTake);
	storageItems[itemID].Quantity = storageItems[itemID].Quantity - BoutToTake;
	
	if (storageItems[itemID].Quantity <= 0) then
		storageItems[itemID] = nil;
	end
	
	if CLIENT then
		GAMEMODE.InventoryBlocks_Linear[itemID]:GrabItem();
				
		if GAMEMODE.ShopPanel then
			GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[itemID]:GrabItem();
		end
	end
			
	numToTake = numToTake - BoutToTake;
	
	if (numToTake <= 0) then return; end
	
	for k, v in pairs(storageItems) do
		if (v.ID == itemTable.ID) then
			local BoutToTake = math.Clamp(v.Quantity, 0, numToTake);
			
			v.Quantity = v.Quantity - BoutToTake
			
			if (v.Quantity <= 0) then
				storageItems[k] = nil;
			end
			
			if CLIENT then
				GAMEMODE.InventoryBlocks_Linear[k]:GrabItem();
				
				if GAMEMODE.ShopPanel then
					GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[k]:GrabItem();
				end
			end
			
			numToTake = numToTake - BoutToTake;
		end
		
		if (numToTake <= 0) then return; end
	end
end


