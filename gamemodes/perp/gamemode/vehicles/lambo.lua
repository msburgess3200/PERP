


VEHICLE 				= {};

VEHICLE.ID 				= 'q';
VEHICLE.FID				= '17';

VEHICLE.Name 			= "Lamborghini";
VEHICLE.Make 			= "Automobili Lamborghini";
VEHICLE.Model 			= "Miura SV";

VEHICLE.Script 			= "lambo";

VEHICLE.Cost 			= 145000;
VEHICLE.PaintJobCost 	= 8000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = 511;

VEHICLE.PaintJobs = {
									{model = 'models/lambo/lambo.mdl', skin = '0', name = 'White', color = Color(248, 251, 232, 255)},
									{model = 'models/lambo/lambo.mdl', skin = '1', name = 'Red', color = Color(205, 0, 0, 255)}, 
									{model = 'models/lambo/lambo.mdl', skin = '2', name = 'Blue', color = Color(0, 9, 123, 255)}, 
									{model = 'models/lambo/lambo.mdl', skin = '3', name = 'Silver', color = Color(125, 128, 125, 255)}, 
									{model = 'models/lambo/lambo.mdl', skin = '4', name = 'Orange', color = Color(235, 100, 32, 255)}, 
									{model = 'models/lambo/lambo.mdl', skin = '5', name = 'Sky Blue', color = Color(0, 188, 235, 255)},
									{model = 'models/lambo/lambo.mdl', skin = '6', name = 'Green', color = Color(0, 88, 36, 255)}, 
									{model = 'models/lambo/lambo.mdl', skin = '7', name = 'Black', color = Color(0, 0, 0, 255)}, 
									{model = 'models/lambo/lambo.mdl', skin = '8', name = 'Brown', color = Color(136, 97, 53, 255)},
									{model = 'models/lambo/lambo.mdl', skin = '9', name = 'Purple', color = Color(67, 12, 96, 255)},
									{model = 'models/lambo/lambo.mdl', skin = '10', name = 'Pink', color = Color(255, 0, 234, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(25, 10, 15), Angle(0, 0, 20)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-79.2231, -13.6429, 4.9321),
								Vector(79.2231, -13.6429, 4.9321),
							};
							
VEHICLE.DefaultIceFriction = .5;
							
VEHICLE.PlayerReposition_Pos = Vector(-23, -30, 18);
VEHICLE.PlayerReposition_Ang = Angle(0, 90, 0);

VEHICLE.ViewAdjustments_FirstPerson = Vector(-7, 0, -2);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "<Whistles> Nice Lamborghini. Yah, we can paint her. It may cost a bit extra, though.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(35.9498, 105.3018, 39.5148), 	Angle(20, 0, 0)};
									{Vector(-35.9498, 105.3018, 39.5148), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-37.5575, -114.6718, 40.7938), 	Angle(20, -180, 0)};
									{Vector(37.5575, -114.6718, 40.7938), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 10)};
									{Vector(0, -35, 10)};
								};
								
VEHICLE.RevvingSound		= "vehicles/lambo/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);