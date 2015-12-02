


local MIXTURE = {}

MIXTURE.ID = 11;

MIXTURE.Results = "weapon_fiveseven";
MIXTURE.Ingredients = {'item_chunk_metal', 'item_chunk_metal', 'item_paint', 'item_paint', 'item_chunk_plastic'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 3},
						{GENE_DEXTERITY, 3},
						{SKILL_CRAFTINESS, 3},
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