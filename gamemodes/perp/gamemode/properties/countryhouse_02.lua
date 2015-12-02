

PROPERTY = {};

PROPERTY.ID = 62;

PROPERTY.Name = "Country House #2";
PROPERTY.Category = "House";
PROPERTY.Description = "A small house in the Country Area.";
PROPERTY.Image = "ev3x_countryhouse234";

PROPERTY.Cost = 1000;

PROPERTY.Doors = 	{
						{Vector(8329.1875, 3278, 58.25), 'models/props_c17/door01_left.mdl'},
						{Vector(8421.1875, 3122, 58.25), 'models/props_c17/door01_left.mdl'},
						{Vector(8237.1875, 3122, 58.25), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);