


local MIXTURE = {}

MIXTURE.ID = 20;

MIXTURE.Results = "drug_beer_box_empty";
MIXTURE.Ingredients = {'item_cardboard', 'item_cardboard'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 1},
						{GENE_DEXTERITY, 1},
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