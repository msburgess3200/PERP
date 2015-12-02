


local MIXTURE = {}

MIXTURE.ID = 26;

MIXTURE.Results = "furniture_wood_empty_bookcase";
MIXTURE.Ingredients = {'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_board', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail', 'item_nail'};
MIXTURE.Requires = 	{
						{SKILL_WOODWORKING, 6},
						{SKILL_CRAFTING, 8},
						{GENE_DEXTERITY, 3},
					};
					
MIXTURE.Free = true;

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = true;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GM:RegisterMixture(MIXTURE);