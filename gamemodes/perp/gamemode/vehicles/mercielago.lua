


VEHICLE 				= {};

VEHICLE.ID 				= 's';
VEHICLE.FID				= '19';

VEHICLE.Name 			= 'Murcielago';
VEHICLE.Make 			= "Lamborghini";
VEHICLE.Model 			= "Murcielago";

VEHICLE.Script 			= "murcielago";

VEHICLE.Cost 			= 350000;
VEHICLE.PaintJobCost 	= 9000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/murcielago.mdl', skin = '0', name = 'Yellow', color = Color(227, 180, 0, 255)},
						{model = 'models/sickness/murcielago.mdl', skin = '1', name = 'Black', color = Color(16, 17, 19, 255)},
						{model = 'models/sickness/murcielago.mdl', skin = '2', name = 'Orange', color = Color(240, 112, 13, 255)},
						{model = 'models/sickness/murcielago.mdl', skin = '3', name = 'Silver', color = Color(131, 131, 125, 255)},
						{model = 'models/sickness/murcielago.mdl', skin = '4', name = 'Purple', color = Color(19, 16, 35, 255)},
						{model = 'models/sickness/murcielago.mdl', skin = '5', name = 'Lime', color = Color(155, 203, 83, 255)},
						{model = 'models/sickness/murcielago.mdl', skin = '6', name = 'Light Blue', color = Color(163, 176, 195, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(50, 0, 5), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-65.0953, 4.6053, 2.5827);
								Vector(116.3831, 11.0841, 4.8897);
							};
							
VEHICLE.DefaultIceFriction = .4;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 5);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Nice lambo, man.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{}
VEHICLE.TaillightPositions 	= 	{
									{Vector(57.6773, -111.7434, 39.3989), 	Angle(20, -180, 0)};
									{Vector(-6.2260, -111.6745, 39.2979), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(25, 35, 5)};
									{Vector(25, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/enzo/turbo.mp3";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);