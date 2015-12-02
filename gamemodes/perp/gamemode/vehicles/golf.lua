

VEHICLE 				= {};

VEHICLE.ID 				= 'd';
VEHICLE.FID				= '5';

VEHICLE.Name 			= "Golf GTI";
VEHICLE.Make 			= "Volkswagen";
VEHICLE.Model 			= "Golf GTI";

VEHICLE.Script 			= "golf";

VEHICLE.Cost 			= 65000;
VEHICLE.PaintJobCost 	= 4500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{	model = 'models/golf/golf.mdl', skin = '0',		name = 'Silver', 	color = Color(137, 137, 137, 255)	},
						{	model = 'models/golf/golf.mdl', skin = '1', 	name = 'Blue', 		color = Color(0, 52, 113, 255)		},
						{	model = 'models/golf/golf.mdl', skin = '2', 	name = 'Green', 	color = Color(25, 112, 48, 255)		},
						{	model = 'models/golf/gol2.mdl', skin = '0', 	name = 'Red', 		color = Color(255, 0, 0, 255)		},
						{	model = 'models/golf/gol2.mdl', skin = '1', 	name = 'Yellow', 	color = Color(227, 214, 0, 255)		},
						{	model = 'models/golf/gol2.mdl', skin = '2', 	name = 'Black', 	color = Color(0, 0, 0, 255)			},
						{	model = 'models/golf/gol3.mdl', skin = '0', 	name = 'Purple', 	color = Color(67, 12, 96, 255)		},
						{	model = 'models/golf/gol3.mdl', skin = '2', 	name = 'Sky Blue', 	color = Color(0, 188, 235, 255)		},
						{	model = 'models/golf/gol3.mdl', skin = '1', 	name = 'Taxi', 		color = {	Color(203, 173, 0, 255), 
																											Color(0, 0, 0, 255)		}}, 
					};

VEHICLE.PassengerSeats 	=	{
								{Vector(19, 0, 12), Angle(0, 0, 5)},
								{Vector(19, 50, 12), Angle(0, 0, 5)},
								{Vector(-19, 50, 12), Angle(0, 0, 5)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(74.8778, 11.6949, -0.4513),
								Vector(74.8622, -51.4952, -0.2979),
								Vector(-78.6649, 9.7921, -0.2719),
								Vector(-78.8222, -59.9076, -0.1441),
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
									{Vector(29.8536, 99, 33.6380), 	Angle(20, 0, 0)};
									{Vector(-29.8536, 99, 33.6380), 	Angle(20, 0, 0)};
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