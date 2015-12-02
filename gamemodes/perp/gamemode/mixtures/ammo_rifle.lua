


local MIXTURE = {}

MIXTURE.ID = 6;

MIXTURE.Results = "ammo_rifle";
MIXTURE.Ingredients = {'item_bullet_shell', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_plastic'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 2},
						{GENE_DEXTERITY, 3},
						{GENE_PERCEPTION, 2},
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