


PROPERTY = {};

PROPERTY.ID = 34;

PROPERTY.Name = "Power Plant";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small power plant in the industrial region.";
PROPERTY.Image = "ev3x_power_plant";

PROPERTY.Cost = 750;

PROPERTY.Doors = 	{
						{Vector(3467, 4098, 117), 'models/props_c17/door01_left.mdl'},
						{Vector(3704, 4102, 126), '*48'},
						{Vector(3568, 4102, 126), '*49'},
					};
					
GAMEMODE:RegisterProperty(PROPERTY);