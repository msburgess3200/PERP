


local MIXTURE = {}

MIXTURE.ID = 60;

MIXTURE.Results = "weapon_hk45";
MIXTURE.Ingredients = {'item_chunk_metal', 'item_chunk_metal', 'item_metal_polish', 'item_metal_polish'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 2},
						{GENE_PERCEPTION, 1},
						{GENE_DEXTERITY, 2},
						{SKILL_CRAFTINESS, 1},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	player:UnlockMixture(5);

	return true;
end

GM:RegisterMixture(MIXTURE);