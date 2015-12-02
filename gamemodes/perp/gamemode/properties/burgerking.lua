


PROPERTY = {};

PROPERTY.ID = 27;

PROPERTY.Name = "Burger King";
PROPERTY.Category = "Business";
PROPERTY.Description = "Moderately Sized business at the enterance of the city.";
PROPERTY.Image = "ev3x_burgerking";

PROPERTY.Cost = 3000;

PROPERTY.Doors = 	{
                        {Vector(-7276, -4657, 135), '*168'},
                        {Vector(-7276, -4535, 135), '*167'},
                        {Vector(-7535, -3967, 126.25), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);