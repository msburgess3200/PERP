


POT_GROW_TIME = 60 * 15;
MAX_POT = 5;

local MIXTURE = {}

MIXTURE.ID = 2;

MIXTURE.Results = "drug_pot";
MIXTURE.Ingredients = {"drug_pot_seeds", "item_pot"};
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
	
		//needs fix
		for k, v in pairs(ents.FindByClass('ent_pot')) do
			if v:GetTable().ItemSpawner == player then
				NumDrugs = NumDrugs + 1;
			end
		end
	
	local VipWeed = MAX_POT;
	if(player:GetLevel() == 99) then
		VipWeed = 6;
	elseif(player:GetLevel() == 98) then
		VipWeed = 8
	elseif(player:GetLevel() <= 97) then
		VipWeed = 10
	end
	
	if (NumDrugs >= VipWeed) then
		if (player:GetLevel() == 100) then
			player:Notify("Bronze VIP pot limit reached");
		elseif(player:GetLevel() == 99) then
			player:Notify("Silver VIP pot limit reached");
		elseif(player:GetLevel() == 98) then
			player:Notify("Gold VIP pot limit reached");
		elseif(player:GetLevel() == 97) then
			player:Notify("Diamond VIP pot limit reached");
		elseif(player:GetLevel() < 97) then
			player:Notify("Admin pot limit reached");
		else
			player:Notify("Guest pot limit reached");
		end
		return false;
	end
	
	return true;
end

GM:RegisterMixture(MIXTURE);