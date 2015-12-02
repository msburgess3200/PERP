


PROPERTY = {};

PROPERTY.ID = 40;

PROPERTY.Name = "Suburbs House #2";
PROPERTY.Category = "House";
PROPERTY.Description = "A moderately sized house in the suburbs.";
PROPERTY.Image = "ev3x_subs2";

PROPERTY.Cost = 2000;

PROPERTY.Doors = 	{
						{Vector(4276.1875, 11000.1875, 116), '*5'},
						{Vector(5008.1875, 11335.6875, 177), '*15'},
						{Vector(5120.1875, 11335.6875, 140), '*16'},
						{Vector(4444.1875, 11107.1875, 116), 'models/props_c17/door01_left.mdl'},
						{Vector(4511.1875, 11220.1875, 116), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);