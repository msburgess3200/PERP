

local MIXTURE = {}

MIXTURE.ID = 12;

MIXTURE.Results = "weapon_deagle";
MIXTURE.Ingredients = {'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_plastic', 'item_chunk_plastic'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 2},
						{GENE_DEXTERITY, 5},
						{GENE_PERCEPTION, 1},
						{SKILL_CRAFTINESS, 6},
					};
					
MIXTURE.Free = false;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	player:UnlockMixture(5);

	return true;
end

GM:RegisterMixture(MIXTURE);