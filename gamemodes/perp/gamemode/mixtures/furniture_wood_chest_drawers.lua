


local MIXTURE = {}

MIXTURE.ID = 25;

MIXTURE.Results = "furniture_wood_chest_drawers";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_glue', 'item_glue', 'item_glue', 'item_glue', 'item_glue', 'item_glue', 'item_glue', 'item_glue', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal'};
MIXTURE.Requires = 	{
						{SKILL_WOODWORKING, 4},
						{SKILL_CRAFTING, 6},
						{GENE_DEXTERITY, 3},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);