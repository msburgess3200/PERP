


local MIXTURE = {}

MIXTURE.ID = 61;

MIXTURE.Results = "weapon_ak47";
MIXTURE.Ingredients = {'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_metal_polish', 'item_board', 'item_board'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 4},
						{GENE_PERCEPTION, 2},
						{GENE_DEXTERITY, 2},
						{SKILL_CRAFTINESS, 6},
					};
					
MIXTURE.Free = false;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	player:UnlockMixture(6);

	return true;
end

GM:RegisterMixture(MIXTURE);