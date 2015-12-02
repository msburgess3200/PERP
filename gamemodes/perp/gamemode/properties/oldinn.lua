


PROPERTY = {};

PROPERTY.ID = 36;

PROPERTY.Name = "Old Inn";
PROPERTY.Category = "House";
PROPERTY.Description = "A slightly old home that needs some work.";
PROPERTY.Image = "ev3x_oldinn";

PROPERTY.Cost = 750;

PROPERTY.Doors = 	{
						{Vector(-499, -8015, 115), 'models/props_c17/door01_left.mdl'},
						{Vector(-1019, -8015.15625, 115), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);