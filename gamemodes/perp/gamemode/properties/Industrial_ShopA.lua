

PROPERTY = {};

PROPERTY.ID = 10;

PROPERTY.Name = "Industrial Shop A";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the back of Industrial";
PROPERTY.Image = "ev33x_industrial_shop";

PROPERTY.Cost = 450;

PROPERTY.Doors = {
                        {Vector(4238, 7077, 118.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(3774, 6941, 118.25), 'models/props_c17/door01_left.mdl'},
                };

GAMEMODE:RegisterProperty(PROPERTY);
