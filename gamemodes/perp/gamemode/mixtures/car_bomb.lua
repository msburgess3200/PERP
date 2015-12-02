


local MIXTURE = {}

MIXTURE.ID = 14;

MIXTURE.Results = "item_car_bomb";
MIXTURE.Ingredients = {'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_metal_rod', 'item_metal_rod', 'item_metal_rod', 'item_chunk_plastic', 'item_chunk_plastic', 'item_chunk_plastic', 'item_chunk_plastic', 'item_chunk_plastic', 'item_chunk_plastic', 'item_chunk_plastic', 'item_propane_tank', 'item_propane_tank', 'item_propane_tank', 'item_propane_tank'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 3},
						{GENE_DEXTERITY, 2},
						{GENE_PERCEPTION, 4},
						{SKILL_CRAFTINESS, 8},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);