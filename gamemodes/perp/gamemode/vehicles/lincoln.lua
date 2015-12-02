


VEHICLE 				= {};

VEHICLE.ID 				= 'g';
VEHICLE.FID				= '7';

VEHICLE.Name 			= "Lincoln MK4";
VEHICLE.Make 			= "Ford Lincoln";
VEHICLE.Model 			= "Lincoln MK4";

VEHICLE.Script 			= "lincoln";

VEHICLE.Cost 			= 65000;
VEHICLE.PaintJobCost 	= 5000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/1972markiv.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
						{model = 'models/sickness/1972markiv.mdl', skin = '1', name = 'Red', color = Color(176, 4, 48, 255)},
						{model = 'models/sickness/1972markiv.mdl', skin = '2', name = 'Yellow', color = Color(205, 143, 5, 255)},
						{model = 'models/sickness/1972markiv.mdl', skin = '3', name = 'Pink', color = Color(248, 0, 227, 255)},
						{model = 'models/sickness/1972markiv.mdl', skin = '4', name = 'Light Blue', color = Color(19, 117, 173, 255)},
						{model = 'models/sickness/1972markiv.mdl', skin = '5', name = 'Olive Green', color = Color(144, 157, 91, 255)},
						{model = 'models/sickness/1972markiv.mdl', skin = '6', name = 'Brown', color = Color(155, 131, 200)},
						{model = 'models/sickness/1972markiv.mdl', skin = '8', name = 'Black', color = Color(0, 0, 0, 255)},
					};
	
VEHICLE.PassengerSeats 	=	{
								{Vector(18, 0, 15), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(81.2183, 7.3703, 2.9262),
								Vector(-83.6722, 4.4156, 2.6407),
							};
							
VEHICLE.DefaultIceFriction = .7;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "1972 lincoln. A classic.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(24.6412, 122.8028, 31.5536), 	Angle(20, 0, 0)};
									{Vector(-24.6412, 122.8028, 31.5536), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(31.0510, -118.8743, 29.5939), 	Angle(20, -180, 0)};
									{Vector(-31.0510, -118.8743, 29.5939), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/enzo/turbo.mp3";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_lowfriction.wav";

GM:RegisterVehicle(VEHICLE);