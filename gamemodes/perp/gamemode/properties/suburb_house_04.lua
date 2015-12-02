


PROPERTY = {};

PROPERTY.ID = 42;

PROPERTY.Name = "Suburbs House #4";
PROPERTY.Category = "House";
PROPERTY.Description = "A moderately sized house in the suburbs.";
PROPERTY.Image = "ev3x_subs4";

PROPERTY.Cost = 3500;

PROPERTY.Doors = 	{
						{Vector(2237.1875, 13281, 111.09375), '*17'},
						{Vector(2984, 13796, 112.25), 'models/props_c17/door01_left.mdl'},
						{Vector(2858, 13796, 112.25), 'models/props_c17/door01_left.mdl'},
						{Vector(2820, 14050, 48.25), 'models/props_c17/door01_left.mdl'},
						{Vector(2820, 14248, 48.25), 'models/props_c17/door01_left.mdl'},
						{Vector(2690, 14108, 176.25), 'models/props_c17/door01_left.mdl'},
						{Vector(2736, 14172, 176.25), 'models/props_c17/door01_left.mdl'},
						{Vector(2752, 13347, 120), '*10'},
					};
					
GAMEMODE:RegisterProperty(PROPERTY);