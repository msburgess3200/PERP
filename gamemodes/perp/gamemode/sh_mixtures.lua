


MIXTURE_DATABASE = {};

function GM:RegisterMixture ( MixtureTable )
	if (MIXTURE_DATABASE[MixtureTable.ID]) then
		Error("Conflicting mixture ID's #" .. MixtureTable.ID);
	end
	
	MixtureTable.IngredientRefs = MixtureTable.Ingredients;
	MixtureTable.Ingredients = {};
	
	for _, ref in pairs(MixtureTable.IngredientRefs) do
		for id, item in pairs(ITEM_DATABASE) do
			if item.Reference == ref then
				table.insert(MixtureTable.Ingredients, id);
			end
		end
	end
	
	MixtureTable.ResultsRef = MixtureTable.Results;
	MixtureTable.Results = nil;
		
	for id, item in pairs(ITEM_DATABASE) do
		if item.Reference == MixtureTable.ResultsRef then
			MixtureTable.Results = id;
			MixtureTable.Name = item.Name;
			break;
		end
	end
		
	if (!MixtureTable.Results) then
		Error("Missing result real ID from mixture " .. MixtureTable.ID);
	end
	
	Msg("\t-> Loaded " .. MixtureTable.Name .. "\n");

	MIXTURE_DATABASE[MixtureTable.ID] = MixtureTable;
end

function PLAYER:HasMixture ( MixtureID )
	if (MIXTURE_DATABASE[MixtureID].Free) then return true; end
	
	return util.tobool(string.find(self:GetPrivateString("mixtures", ""), tostring(MixtureID) .. ";"));
end

if CLIENT then return; end

function PLAYER:UnlockMixture ( MixtureID )
	if (self:HasMixture(MixtureID)) then return false; end
	if (MIXTURE_DATABASE[MixtureID].Free) then return false; end
	
	self:SetPrivateString("mixtures", self:GetPrivateString("mixtures", "") .. tostring(MixtureID) .. ";");
	self:Notify("You have unlocked the " .. MIXTURE_DATABASE[MixtureID].Name .. " mixture!");
	
	return true;
end
