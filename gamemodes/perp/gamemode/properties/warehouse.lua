


PROPERTY = {};

PROPERTY.ID = 1;

PROPERTY.Name = "Warehouse";
PROPERTY.Category = "Business";
PROPERTY.Description = "A large warehouse in central EvoCity Country.";
PROPERTY.Image = "ev3x_warehouse";

PROPERTY.Cost = 1000;

PROPERTY.Doors = 	{
						{Vector(-3244, 318, 135), '*1'},
						{Vector(-3526.8000488281, 122.00199890137, 126.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-2228, 139.00199890137, 126.25), 'models/props_c17/door01_left.mdl'},
					};
					
GAMEMODE:RegisterProperty(PROPERTY);