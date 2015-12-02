


local MIXTURE = {}

MIXTURE.ID = 38;

MIXTURE.Results = "furniture_fence_chain";
MIXTURE.Ingredients = {'item_metal_rod', 'item_metal_rod', 'item_metal_rod', 'item_metal_rod'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 1},
						{GENE_STRENGTH, 2},
						{SKILL_CRAFTINESS, 2},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);