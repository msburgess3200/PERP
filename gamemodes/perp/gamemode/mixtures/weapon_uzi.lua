


local MIXTURE = {}

MIXTURE.ID = 8;

MIXTURE.Results = "weapon_uzi";
MIXTURE.Ingredients = {'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_plastic', 'item_metal_rod', 'item_paint'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 4},
						{GENE_PERCEPTION, 0},
						{GENE_DEXTERITY, 4},
						{SKILL_CRAFTINESS, 3},
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