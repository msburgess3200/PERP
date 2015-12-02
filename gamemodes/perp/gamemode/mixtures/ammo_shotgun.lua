


local MIXTURE = {}

MIXTURE.ID = 7;

MIXTURE.Results = "ammo_shotgun";
MIXTURE.Ingredients = {'item_bullet_shell', 'item_chunk_plastic', 'item_chunk_plastic', 'item_cardboard'};
MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 3},
						{GENE_DEXTERITY, 1},
						{GENE_PERCEPTION, 1},
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