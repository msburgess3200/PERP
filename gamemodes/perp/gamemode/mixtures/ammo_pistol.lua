

local MIXTURE = {}

MIXTURE.ID = 5;

MIXTURE.Results = "ammo_pistol";
MIXTURE.Ingredients = {'item_bullet_shell', 'item_chunk_metal', 'item_cardboard'};
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