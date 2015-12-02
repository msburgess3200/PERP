


PROPERTY = {};

PROPERTY.ID = 5;

PROPERTY.Name = "Large Shop";
PROPERTY.Category = "Business";
PROPERTY.Description = "A large sized shop in the inner-city.";
PROPERTY.Image = "ev33x_large_shop";

PROPERTY.Cost = 1000;

PROPERTY.Doors = 	{
						{Vector(-5432, -7768, 135), '*185'},
                        {Vector(-5432, -7890, 135), '*184'},
					};
					
GAMEMODE:RegisterProperty(PROPERTY);