


PROPERTY = {};

PROPERTY.ID = 11;

PROPERTY.Name = "Industrial Shop B";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the back of Industrial";
PROPERTY.Image = "ev33x_industrial_shop";

PROPERTY.Cost = 300;

PROPERTY.Doors = {
                        {Vector(4238, 7461, 118.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(3766, 7325, 118.25), 'models/props_c17/door01_left.mdl'},
                };

GAMEMODE:RegisterProperty(PROPERTY);
