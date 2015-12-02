



PROPERTY = {};

PROPERTY.ID = 18;

PROPERTY.Name = "Sky Scraper";
PROPERTY.Category = "Business";
PROPERTY.Description = "A large building in the inner-city.";
PROPERTY.Image = "ev3x_skyscraper";

PROPERTY.Cost = 10000;

PROPERTY.Doors = 	{
						{Vector(-5539, -9315, 135), '*35'},
						{Vector(-5539.5, -9255, 135), '*36'},
						{Vector(-5145, -9153.98046875, 1660.2800292969), 'models/highrise/doors_glass_01.mdl'},
						{Vector(-5175, -9154, 1660.2800292969), 'models/highrise/doors_glass_01.mdl'},
						{Vector(-5031.0200195313, -9634, 1532.2800292969), 'models/highrise/doors_glass_01.mdl'},
						{Vector(-5031.0200195313, -9378, 1532.2800292969), 'models/highrise/doors_glass_01.mdl'},
						{Vector(-5031.0200195313, -9154, 1532.2800292969), 'models/highrise/doors_glass_01.mdl'}
					};
					
GAMEMODE:RegisterProperty(PROPERTY);