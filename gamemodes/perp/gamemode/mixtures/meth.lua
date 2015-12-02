


METH_COOK_TIME = 60 * 10;
METH_BURN_TIME = 60 * 12;

local MIXTURE = {}

MIXTURE.ID = 1;

MIXTURE.Results = "drug_meth_wet";
MIXTURE.Ingredients = {"item_waterbottle", "item_waterbottle", "item_waterbottle", "item_kittylitter", "item_salt", "item_lodine"};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 2},
						{SKILL_CRAFTINESS, 3},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	if (!GAMEMODE.FindWaterSource(pos, MixRange)) then
		player:Notify("There needs to be a bathtub nearby to mix the ingredients in.");
		return false
	end
	
	if (player:Team() != TEAM_CITIZEN) then
		player:Notify("You cannot do this as a government official.");
		return false;
	end

	return true;
end

GM:RegisterMixture(MIXTURE);