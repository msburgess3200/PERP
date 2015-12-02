


PROPERTY = {};

PROPERTY.ID = 7;

PROPERTY.Name = "The Chop Shop";
PROPERTY.Category = "Business";
PROPERTY.Description = "Nice werehouse/garage for putting the chop in chop shop.";
PROPERTY.Image = "ev33x_chop_shop";

PROPERTY.Cost = 900;

PROPERTY.Doors = 	{
                        {Vector(3768, 5954.96875, 130), '*223'},
                        {Vector(3831, 5381, 122.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(4055, 5759, 122.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(4272, 6787, 122.25), 'models/props_c17/door01_left.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);