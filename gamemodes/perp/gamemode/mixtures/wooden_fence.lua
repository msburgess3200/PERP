


local MIXTURE = {}

MIXTURE.ID = 16;

MIXTURE.Results = "furniture_fence";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_glue', 'item_glue', 'item_glue', 'item_paint'};
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