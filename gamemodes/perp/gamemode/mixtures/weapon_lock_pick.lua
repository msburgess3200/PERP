


local MIXTURE = {}

MIXTURE.ID = 15;

MIXTURE.Results = "weapon_lock_pick";
MIXTURE.Ingredients = {'item_chunk_metal', 'item_metal_rod', 'item_wrench'};
MIXTURE.Requires = 	{
						{GENE_STRENGTH, 3},
						{GENE_DEXTERITY, 1},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = true;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);