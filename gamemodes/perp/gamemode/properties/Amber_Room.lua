


PROPERTY = {};

PROPERTY.ID = 100;

PROPERTY.Name = "Amber Room";
PROPERTY.Category = "Business";
PROPERTY.Description = "A large diner in the city.";
PROPERTY.Image = "ev33x_amberroom";

PROPERTY.Cost = 800;

PROPERTY.Doors = 	{
						{Vector(-10285.0996, -10609.9004, 126.281), 'models/props_c17/door02_double.mdl'},
                        {Vector(-10285.2002, -10552, 126.281), 'models/props_c17/door02_double.mdl'},
                        {Vector(-10285.0996, -10505.9004, 126.281), 'models/props_c17/door02_double.mdl'},
                        {Vector(-10285.2002, -10448, 126.281), 'models/props_c17/door02_double.mdl'},
                        
                        {Vector(-10575.0996, -10721.0996, 126.281), 'models/props_c17/door02_double.mdl'},
                        {Vector(-10633, -10721.2002, 126.281), 'models/props_c17/door02_double.mdl'},
                        {Vector(-10655.0996, -10721.0996, 126.281), 'models/props_c17/door02_double.mdl'},
                        {Vector(-10713, -10721.2002, 126.281), 'models/props_c17/door02_double.mdl'},
						{Vector(-10448, -10721, 151), '*234'},
					};
					
GAMEMODE:RegisterProperty(PROPERTY);