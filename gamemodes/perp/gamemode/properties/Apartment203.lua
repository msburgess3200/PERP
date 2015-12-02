

PROPERTY = {};

PROPERTY.ID = 20;

PROPERTY.Name = "Apartment 203";
PROPERTY.Category = "Apartment";
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park";
PROPERTY.Image = "ev33x_apartments";

PROPERTY.Cost = 750;

PROPERTY.Doors = 	{
						{Vector( -10750.7998, -10001, 382.25), 'models/props_c17/door01_left.mdl'},
                        {Vector( -10722.9004, -9888.9102, 382.25), 'models/props_c17/door01_left.mdl'},
                        {Vector( -10722.9004, -9888.9102, 382.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-10602.78125, -10201, 382.25), 'models/props_c17/door01_left.mdl'},
					};
					
GAMEMODE:RegisterProperty(PROPERTY);