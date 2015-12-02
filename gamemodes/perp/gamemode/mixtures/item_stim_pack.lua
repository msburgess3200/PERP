


local MIXTURE = {}

MIXTURE.ID = 41;

MIXTURE.Results = "item_stim_pack";
MIXTURE.Ingredients = {'item_paper_towels', 'item_chunk_plastic'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 1},
						{GENE_STRENGTH, 2},
						{SKILL_CRAFTINESS, 4},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = true;
MIXTURE.RequiresWaterSource = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);