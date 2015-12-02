


PROPERTY = {};

PROPERTY.ID = 61;

PROPERTY.Name = "Country House #1";
PROPERTY.Category = "House";
PROPERTY.Description = "A small house in the Country Area.";
PROPERTY.Image = "ev3x_countryhouse1";

PROPERTY.Cost = 1200;

PROPERTY.Doors = 	{
						{Vector(9930, 3365, 61), '*158'},
						{Vector(10077.1875, 3176, 58.25), 'models/props_c17/door01_left.mdl'},
						{Vector(9853.1875, 3124, 58.25), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);