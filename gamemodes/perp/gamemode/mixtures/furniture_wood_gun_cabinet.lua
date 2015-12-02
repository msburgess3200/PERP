


local MIXTURE = {}

MIXTURE.ID = 34;

MIXTURE.Results = "furniture_wood_gun_cabinet";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'weapon_ak47', 'weapon_ak47'};
MIXTURE.Requires = 	{
						{SKILL_WOODWORKING, 8},
						{SKILL_CRAFTING, 8},
						{GENE_DEXTERITY, 5},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = true;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);