

local MIXTURE = {}

MIXTURE.ID = 35;

MIXTURE.Results = "furniture_metal_detector";
MIXTURE.Ingredients = {'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_wrench', 'item_wrench'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 3},
						{GENE_PERCEPTION, 2},
						{SKILL_CRAFTING, 5},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = true;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);