

PROPERTY = {};

PROPERTY.ID = 6;

PROPERTY.Name = "The Depot";
PROPERTY.Category = "Business";
PROPERTY.Description = "A moderately sized werehouse in the industrial area.";
PROPERTY.Image = "ev33x_depot";

PROPERTY.Cost = 1000;

PROPERTY.Doors = 	{
					{Vector(2805, 5507, 122.25), 'models/props_c17/door01_left.mdl'},
                    {Vector(3181, 6395, 122.25), 'models/props_c17/door01_left.mdl'},
                    {Vector(3312, 5883, 130), '*225'},
                    {Vector(3440, 5883, 130), '*224'}
                    };
					
GAMEMODE:RegisterProperty(PROPERTY);