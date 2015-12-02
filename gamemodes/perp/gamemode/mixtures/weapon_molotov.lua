


local MIXTURE = {}

MIXTURE.ID = 13;

MIXTURE.Results = "weapon_molotov";
MIXTURE.Ingredients = {'weapon_bottle', 'item_propane_tank', 'item_paper_towels', 'item_paper_towels'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 1},
						{GENE_DEXTERITY, 2},
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