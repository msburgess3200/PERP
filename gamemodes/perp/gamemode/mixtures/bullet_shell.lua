


local MIXTURE = {}

MIXTURE.ID = 3;

MIXTURE.Results = "item_bullet_shell";
MIXTURE.Ingredients = {'item_chunk_metal', 'item_metal_polish'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 1},
						{GENE_PERCEPTION, 2},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = true;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);