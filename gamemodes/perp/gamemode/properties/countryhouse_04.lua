


PROPERTY = {};

PROPERTY.ID = 64;

PROPERTY.Name = "Country House #4";
PROPERTY.Category = "House";
PROPERTY.Description = "A small house in the Country Area.";
PROPERTY.Image = "ev3x_countryhouse234";

PROPERTY.Cost = 1000;

PROPERTY.Doors = 	{
						{Vector(7472, 4246.78125, 58.25), 'models/props_c17/door01_left.mdl'},
						{Vector(7316, 4338.78125, 58.25), 'models/props_c17/door01_left.mdl'},
						{Vector(7316, 4154.78125, 58.25), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);