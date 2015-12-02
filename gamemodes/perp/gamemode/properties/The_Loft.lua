


PROPERTY = {};

PROPERTY.ID = 13;

PROPERTY.Name = "The Loft";
PROPERTY.Category = "Apartment";
PROPERTY.Description = "Large studio apartment, over looking the park.";
PROPERTY.Image = "ev33x_loft";

PROPERTY.Cost = 1250;

PROPERTY.Doors = 	{
						{Vector( -10840, -9082, 301.25), 'models/props_c17/door01_left.mdl'},
						{Vector( -10729, -9212, 301.25), 'models/props_c17/door01_left.mdl'},
					};
					
GAMEMODE:RegisterProperty(PROPERTY);