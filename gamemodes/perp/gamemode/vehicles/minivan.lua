


VEHICLE 				= {};

VEHICLE.ID 				= '5';
VEHICLE.FID				= '44';

VEHICLE.Name 			= "MiniVan";
VEHICLE.Make 			= "Toyota";
VEHICLE.Model 			= "Minivan Q1";

VEHICLE.Script 			= "minivan";

VEHICLE.Cost 			= 60000;
VEHICLE.PaintJobCost 	= 3000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
							{model = 'models/sickness/minivandr.mdl', skin = '0', name = 'Black', color = Color(0, 0, 0, 255)},
							{model = 'models/sickness/minivandr.mdl', skin = '1', name = 'White', color = Color(255, 255, 255, 255)},
							{model = 'models/sickness/minivandr.mdl', skin = '2', name = 'Gray', color = Color(0, 0, 0, 255)},
							{model = 'models/sickness/minivandr.mdl', skin = '3', name = 'Red', color = Color(200, 8, 21, 255)},
							{model = 'models/sickness/minivandr.mdl', skin = '4', name = 'Green', color = Color(0, 171, 56, 245)},
							{model = 'models/sickness/minivandr.mdl', skin = '5', name = 'Blue', color = Color(11, 56, 69, 255)},
							{model = 'models/sickness/minivandr.mdl', skin = '6', name = 'Yellow', color = Color(255, 255, 0, 255)},
					};

VEHICLE.PassengerSeats 	=	{
								{Vector(22,24,18), Angle(0, 0 ,0)},
								{Vector(0,24,18), Angle(0, 0 ,0)},
								{Vector(-22,24,18), Angle(0, 0 ,0)},
								{Vector(22,-20,18), Angle(0, 0 ,0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-78.4888, 31.0606, 1.5582),
								Vector(-78.7425, -20.2776, 1.6878),
								Vector(79.3276, -24.8024, 1.5374),
								Vector(80.5768, 34.7472, 1.3860),
							};
							
VEHICLE.DefaultIceFriction = .6;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 5);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! Unfortunately I don't have many paint colors available for that car.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(29.8536, 92, 31.6380), 	Angle(20, 0, 0)};
									{Vector(-29.8536, 92, 31.6380), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(30.3712, -101.0814, 43.8752), 	Angle(20, -180, 0)};
									{Vector(-30.3712, -101.0814, 43.8752), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/golf/v8_start_loop1.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);