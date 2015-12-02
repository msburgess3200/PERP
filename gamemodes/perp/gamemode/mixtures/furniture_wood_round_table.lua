

local MIXTURE = {}

MIXTURE.ID = 23;

MIXTURE.Results = "furniture_wood_round_table";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_glue', 'item_glue', 'item_glue', 'item_glue'};
MIXTURE.Requires = 	{
						{SKILL_WOODWORKING, 2},
						{SKILL_CRAFTING, 5},
						{GENE_DEXTERITY, 2},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);