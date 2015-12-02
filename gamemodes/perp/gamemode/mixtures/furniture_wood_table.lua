

local MIXTURE = {}

MIXTURE.ID = 22;

MIXTURE.Results = "furniture_wood_table";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_board', 'item_glue', 'item_glue'};
MIXTURE.Requires = 	{
						{SKILL_WOODWORKING, 1},
						{SKILL_CRAFTING, 3},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);