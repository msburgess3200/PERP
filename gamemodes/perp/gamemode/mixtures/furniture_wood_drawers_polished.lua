


local MIXTURE = {}

MIXTURE.ID = 31;

MIXTURE.Results = "furniture_wood_drawers_polished";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_metal_polish', 'item_metal_polish', 'item_paint'};
MIXTURE.Requires = 	{
						{SKILL_WOODWORKING, 8},
						{SKILL_CRAFTING, 7},
						{GENE_DEXTERITY, 4},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = true;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);