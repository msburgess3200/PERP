
POT_GROW_TIME = 60 * 15;
MAX_POT = 5;

local MIXTURE = {}

MIXTURE.ID = 51;

MIXTURE.Results = "drug_cocaine";
MIXTURE.Ingredients = {"drug_coca_seeds", "item_pot"};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 1},
						{GENE_DEXTERITY, 1},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	if (player:Team() != TEAM_CITIZEN) then
		player:Notify("You cannot do this as a government official.");
		return false;
	end
	
	local NumDrugs = 0;
	for k, v in pairs(ents.FindByClass('ent_coca')) do
		if v:GetTable().ItemSpawner == player then
			NumDrugs = NumDrugs + 1;
		end
	end
	
	local VipCoke = MAX_POT;
	if(player:GetLevel() == 99) then
		VipCoke = 6;
	elseif(player:GetLevel() == 98) then
		VipCoke = 8
	elseif(player:GetLevel() <= 97) then
		VipCoke = 10
	end
	
	if (NumDrugs >= VipCoke) then
		if (player:GetLevel() == 100) then
			player:Notify("Bronze VIP coke limit reached");
		elseif(player:GetLevel() == 99) then
			player:Notify("Silver VIP coke limit reached");
		elseif(player:GetLevel() == 98) then
			player:Notify("Gold VIP coke limit reached");
		elseif(player:GetLevel() == 97) then
			player:Notify("Diamond VIP coke limit reached");
		elseif(player:GetLevel() <= 96) then
			player:Notify("Admin coke limit reached");
		else
			player:Notify("Guest coke limit reached");
		end
		return false;
	end

	return true;
end

GM:RegisterMixture(MIXTURE);