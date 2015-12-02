


PROPERTY = {};

PROPERTY.ID = 26;

PROPERTY.Name = "Apartment 101";
PROPERTY.Category = "Apartment";
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park";
PROPERTY.Image = "ev33x_apartments";

PROPERTY.Cost = 750;

PROPERTY.Doors = 	{
						{Vector(-10750.7998, -10000.7998, 254.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(-10722.7002, -9889, 254.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(-10604, -9889, 254.25), 'models/props_c17/door01_left.mdl'},
					};
					
GAMEMODE:RegisterProperty(PROPERTY);