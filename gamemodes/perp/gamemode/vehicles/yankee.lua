

VEHICLE 				= {};

VEHICLE.ID 				= 'l';
VEHICLE.FID 			= '12';

VEHICLE.Name 			= "Yankee";
VEHICLE.Make 			= "General Motors";
VEHICLE.Model 			= "Yankee";

VEHICLE.Script 			= "yankee";

VEHICLE.Cost 			= 100000;
VEHICLE.PaintJobCost 	= 5000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/yankeedr.mdl', skin = '0', name = 'Red', color = Color(180, 0, 0, 255)},
						{model = 'models/sickness/yankeedr.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
						{model = 'models/sickness/yankeedr.mdl', skin = '2', name = 'Brown', color = Color(139, 69, 19, 255)},
						{model = 'models/sickness/yankeedr.mdl', skin = '3', name = 'Blue', color = Color(100, 149, 237, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(20.6327, -43.2826, 52.5586), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-93.6075, 48.9518, 4.2876),
								Vector(93.6075, 48.9518, 4.2876),
							};
							
VEHICLE.DefaultIceFriction = .3;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "I can try, but I won't promise much.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(38.7723, 130.7135, 49.6355), 	Angle(20, 0, 0)};
									{Vector(-38.7723, 130.7135, 49.6355), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-23.5693, -175.8279, 32.9439), 	Angle(20, -180, 0)};
									{Vector(23.5693, -175.8279, 32.9439), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/premier/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);