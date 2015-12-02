


local MIXTURE = {}

MIXTURE.ID = 50;

MIXTURE.Results = "weapon_smoke_grenade";
MIXTURE.Ingredients = {'weapon_molotov', 'item_chunk_metal'};
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