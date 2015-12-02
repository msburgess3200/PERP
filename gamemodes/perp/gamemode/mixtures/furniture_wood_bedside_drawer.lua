


local MIXTURE = {}

MIXTURE.ID = 27;

MIXTURE.Results = "furniture_wood_bedside_drawer";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_glue', 'item_glue'};
MIXTURE.Requires = 	{
						{SKILL_WOODWORKING, 1},
						{SKILL_CRAFTING, 2},
						{GENE_DEXTERITY, 1},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);