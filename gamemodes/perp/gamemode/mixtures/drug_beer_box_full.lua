


local MIXTURE = {}

MIXTURE.ID = 21;

MIXTURE.Results = "drug_beer_box_full";
MIXTURE.Ingredients = {'drug_beer_box_empty', 'drug_beer', 'drug_beer', 'drug_beer', 'drug_beer', 'drug_beer', 'drug_beer'};
MIXTURE.Requires = 	{

					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);