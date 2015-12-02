

PROPERTY = {};

PROPERTY.ID = 17;

PROPERTY.Name = "Large Industrial Werehouse";
PROPERTY.Category = "Business";
PROPERTY.Description = "Very large werehouse located in the industrial area, with its own front gate!";
PROPERTY.Image = "ev33x_large_industrial_warehouse";

PROPERTY.Cost = 2000;

PROPERTY.Doors = 	{
						{Vector(1336.5, 5403, 132), '*23'},
                        {Vector(1332, 5890, 178), '*24'},
                        {Vector(1332, 6396, 178), '*26'},
                        {Vector(1844, 5890, 122.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(1937.25, 5889.875, 122.25), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);