


PROPERTY = {};

PROPERTY.ID = 55;

PROPERTY.Name = "Tides Hotel Room #5";
PROPERTY.Category = "Apartment";
PROPERTY.Description = "A nicely sized hotel room near the entrance of the city.";
PROPERTY.Image = "ev3x_tides_hotel";

PROPERTY.Cost = 500;

PROPERTY.Doors = 	{						
						{Vector(-3448, -4676, 254.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(-3476, -4729, 254.25), 'models/props_c17/door01_left.mdl'}
                    };
					
GAMEMODE:RegisterProperty(PROPERTY);