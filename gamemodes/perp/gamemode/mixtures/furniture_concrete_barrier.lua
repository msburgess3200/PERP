

local MIXTURE = {}

MIXTURE.ID = 36;
                   
MIXTURE.Results = "furniture_Concrete_Barrier";
MIXTURE.Ingredients = {'item_cinder_block','item_cinder_block','item_cinder_block','item_cinder_block','item_metal_rod','item_metal_rod'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 2},
						{GENE_STRENGTH, 2},
						{SKILL_CRAFTINESS, 4},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);