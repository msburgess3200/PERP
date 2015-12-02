

VEHICLE 				= {};

VEHICLE.ID 				= 'c';
VEHICLE.FID				= '4';

VEHICLE.Name 			= "BMW";
VEHICLE.Make 			= "BMW";
VEHICLE.Model 			= "M5";

VEHICLE.Script 			= "bmw";

VEHICLE.Cost 			= 60000;
VEHICLE.PaintJobCost 	= 4000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{	model = 'models/sickness/bmw-m5.mdl', skin = '0', name = 'White', 		color = Color(205, 203, 195, 255)	},
						{	model = 'models/sickness/bmw-m5.mdl', skin = '1', name = 'Red', 		color = Color(128, 29, 24, 255)		},
						{	model = 'models/sickness/bmw-m5.mdl', skin = '2', name = 'Black', 		color = Color(11, 9, 13, 255)		},
						{	model = 'models/sickness/bmw-m5.mdl', skin = '3', name = 'Navy', 		color = Color(16, 21, 48, 255)		},
						{	model = 'models/sickness/bmw-m5.mdl', skin = '4', name = 'Green', 		color = Color(21, 37, 32, 255)		},
						{	model = 'models/sickness/bmw-m5.mdl', skin = '5', name = 'Crimson', 	color = Color(51, 15, 16, 255)		},
						{	model = 'models/sickness/bmw-m5.mdl', skin = '7', name = 'Sky Blue',	color = Color(173, 199, 219, 255)	},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(20, -5, 8), Angle(0, 0, 0)},
								{Vector(20, 30, 5), Angle(0, 0, 0)},
								{Vector(-17, 30, 5), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-72.6838, 31.2153, 2.6657),
								Vector(-72.6838, -37.3369, 2.8875),
								Vector(72.6838, -45.6067, 2.1214),
								Vector(72.6838, 13.3602, 1.9054),
							};
							
VEHICLE.DefaultIceFriction = .5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Classic beamer.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(25.6303, 96.1097, 26.5435), 	Angle(20, 0, 0)};
									{Vector(-25.6303, 96.1097, 26.5435), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-24.7187, -95.7260, 33.2167), 	Angle(20, -180, 0)};
									{Vector(24.7187, -95.7260, 33.2167), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/golf/v8_start_loop1.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);