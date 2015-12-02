

local MIXTURE = {}

MIXTURE.ID = 33;

MIXTURE.Results = "furniture_wood_simple_table";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_glue'};
MIXTURE.Requires = 	{
						{SKILL_WOODWORKING, 3},
						{SKILL_CRAFTING, 2},
						{GENE_DEXTERITY, 3},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = true;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);