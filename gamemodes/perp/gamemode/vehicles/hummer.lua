

VEHICLE 				= {};

VEHICLE.ID 				= 'k';
VEHICLE.FID				= '11';

VEHICLE.Name 			= "Hummer H2";
VEHICLE.Make 			= "General Motors";
VEHICLE.Model 			= "Hummer H2";

VEHICLE.Script 			= "hummer";

VEHICLE.Cost 			= 95000;
VEHICLE.PaintJobCost 	= 6000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/hummer-h2.mdl', skin = '0', name = 'Red', color = Color(240, 0, 0, 255)},
						{model = 'models/sickness/hummer-h2.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
						{model = 'models/sickness/hummer-h2.mdl', skin = '2', name = 'Silver', color = Color(155, 161, 155, 255)},
						{model = 'models/sickness/hummer-h2.mdl', skin = '3', name = 'White', color = Color(240, 249, 240, 255)},
						{model = 'models/sickness/hummer-h2.mdl', skin = '4', name = 'Green', color = Color(0, 121, 0, 255)},
						{model = 'models/sickness/hummer-h2.mdl', skin = '5', name = 'Blue', color = Color(0, 0, 240, 255)},
						{model = 'models/sickness/hummer-h2.mdl', skin = '6', name = 'Gray', color = Color(125, 127, 125, 255)},
						{model = 'models/sickness/hummer-h2.mdl', skin = '8', name = 'Yellow', color = Color(240, 249, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(20, -14, 25), Angle(0, 0, 0)},
								{Vector(20, 20, 23), Angle(0, 0, 0)},
								{Vector(-20, 20, 23), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-78.4888, 31.0606, 1.5582),
								Vector(-78.7425, -20.2776, 1.6878),
								Vector(79.3276, -24.8024, 1.5374),
								Vector(80.5768, 34.7472, 1.3860),
							};
							
VEHICLE.DefaultIceFriction = 1.5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Nice gas guzzler you have there.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(23.3503, 104.2362, 39.7837), 	Angle(20, 0, 0)};
									{Vector(-23.3503, 104.2362, 39.7837), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-32.5509, -84.3881, 46.0062), 	Angle(20, -180, 0)};
									{Vector(32.5509, -84.3881, 46.0062), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);