


PROPERTY = {};

PROPERTY.ID = 4;

PROPERTY.Name = "Small Shop";
PROPERTY.Category = "Business";
PROPERTY.Description = "A moderately sized shop in the inner-city.";
PROPERTY.Image = "ev33x_small_shop";

PROPERTY.Cost = 500;

PROPERTY.Doors = 	{
						{Vector(-5255, -6945, 135), '*182'},
                        {Vector(-5377, -6945, 135), '*183'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);