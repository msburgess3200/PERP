


PROPERTY = {};

PROPERTY.ID = 54;

PROPERTY.Name = "Tides Hotel Room #4";
PROPERTY.Category = "Apartment";
PROPERTY.Description = "A nicely sized hotel room near the entrance of the city.";
PROPERTY.Image = "ev3x_tides_hotel";

PROPERTY.Cost = 500;

PROPERTY.Doors = 	{						
						{Vector(-3785, -4676, 254.28100585938), 'models/props_c17/door01_left.mdl'},
                        {Vector(-3820, -4729, 254.25), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);