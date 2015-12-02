


local MIXTURE = {}

MIXTURE.ID = 28;

MIXTURE.Results = "furniture_wood_chest_drawers_small";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_board', 'item_glue', 'item_glue', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail'};
MIXTURE.Requires = 	{
						{SKILL_WOODWORKING, 5},
						{SKILL_CRAFTING, 8},
						{GENE_DEXTERITY, 4},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);