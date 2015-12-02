


SHOP_DATABASE = {};

function GM:RegisterShop ( ShopTable )
	ShopTable.ItemRefs = ShopTable.Items;
	ShopTable.Items = {};
	
	for _, ref in pairs(ShopTable.ItemRefs) do
		if (type(ref) == "table") then
			table.insert(ShopTable.Items, ref);
		else
			for id, item in pairs(ITEM_DATABASE) do
				if item.Reference == ref then
					table.insert(ShopTable.Items, id);
				end
			end
		end
	end
	
	if (SHOP_DATABASE[ShopTable.ID]) then
		Error("Conflicting ShopTable ID's: " .. ShopTable.ID .. "\n");
	end
	
	SHOP_DATABASE[ShopTable.ID] = ShopTable;
	Msg("\t-> Loaded " .. ShopTable.Name .. " [NPC Lock: " .. ShopTable.NPCAssociation .. "]\n");
end

if SERVER then return end

function GM.OpenShop ( ShopID )
	if (GAMEMODE.ShopPanel) then GAMEMODE.ShopPanel:Remove(); GAMEMODE.ShopPanel = nil; end
	
	gui.EnableScreenClicker(true);
	GAMEMODE.ShopPanel = vgui.Create("perp2_shop");
	//GAMEMODE.ShopPanel.ShopTitle.Title = SHOP_DATABASE[ShopID].Name;
	
	for k, v in pairs(SHOP_DATABASE[ShopID].Items) do
		if (type(v) != "table") then
			GAMEMODE.ShopPanel:AddItemForSale(ITEM_DATABASE[v]);
		else
			for _, date in pairs(v[2]) do
				if (date == GetGlobalString("os.date", "")) then
					local fetchID
					for d, i in pairs(ITEM_DATABASE) do
						if (i.Reference == v[1]) then
							fetchID = d
						end
					end
				
					GAMEMODE.ShopPanel:AddItemForSale(ITEM_DATABASE[fetchID]);
					break
				end
			end
		end
	end
end
