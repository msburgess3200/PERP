

local MIXTURE = {}

MIXTURE.ID = 37;

MIXTURE.Results = "furniture_Cop_Barrier";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_metal_rod', 'item_paint'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 2},
						{GENE_STRENGTH, 2},
						{SKILL_CRAFTINESS, 3},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);