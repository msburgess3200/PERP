


PROPERTY = {};

PROPERTY.ID = 21;

PROPERTY.Name = "Apartment 102";
PROPERTY.Category = "Apartment";
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park";
PROPERTY.Image = "ev33x_apartments";

PROPERTY.Cost = 750;

PROPERTY.Doors = 	{
						{Vector( -10830.7002, -9697, 254.25), 'models/props_c17/door01_left.mdl'},
                        {Vector( -10471, -9512.9404, 254.25), 'models/props_c17/door01_left.mdl'},
                        {Vector( -10416, -9503.7803, 254.25), 'models/props_c17/door01_left.mdl'},
					};
					
GAMEMODE:RegisterProperty(PROPERTY);