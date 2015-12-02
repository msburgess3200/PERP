


PROPERTY = {};

PROPERTY.ID = 30;

PROPERTY.Name = "Tides Hotel Room #3";
PROPERTY.Category = "Apartment";
PROPERTY.Description = "A nicely sized hotel room near the entrance of the city.";
PROPERTY.Image = "ev3x_tides_hotel";

PROPERTY.Cost = 500;

PROPERTY.Doors = 	{
						{Vector(-3785, -4540, 254.28100585938), 'models/props_c17/door01_left.mdl'},
                        {Vector(-3820, -4533, 254.25), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);