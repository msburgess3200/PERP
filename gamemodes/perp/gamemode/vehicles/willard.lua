


VEHICLE 				= {};

VEHICLE.ID 				= 'n';
VEHICLE.FID 			= '2';

VEHICLE.Name 			= "Willard";
VEHICLE.Make 			= "General Motors";
VEHICLE.Model 			= "Willard";

VEHICLE.Script 			= "willard";

VEHICLE.Cost 			= 35000;
VEHICLE.PaintJobCost 	= 3000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/willarddr.mdl', skin = '0', name = 'Black', color = Color(32, 32, 32, 255)},
						{model = 'models/sickness/willarddr.mdl', skin = '1', name = 'White', color = Color(229, 232, 229, 255)},
						{model = 'models/sickness/willarddr.mdl', skin = '2', name = 'Red', color = Color(133, 41, 40, 255)},
						{model = 'models/sickness/willarddr.mdl', skin = '3', name = 'Green', color = Color(53, 129, 59, 255)},
						{model = 'models/sickness/willarddr.mdl', skin = '4', name = 'Blue', color = Color(11, 75, 197, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(16.4618, 1.4206, 15.2389), Angle(0, 0, 10)},
								{Vector(16.6661, 34.4757, 10.0073), Angle(0, 0, 15)},
								{Vector(-16.6661, 34.4757, 10.0073), Angle(0, 0, 15)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(68.2786, 22.3959, 1.7422),
								Vector(-68.2786, 22.3959, 1.7422),
								Vector(71.2187, -50.1828, 1.7471),
								Vector(-71.2187, -50.1828, 1.7471),
							};
							
VEHICLE.DefaultIceFriction = .2;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 5);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Sure.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-24.6580, 109.1685, 33.1460), 	Angle(20, 0, 0)};
									{Vector(24.6580, 109.1685, 33.1460), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(20.2314, -110.5173, 35.0710), 	Angle(20, -180, 0)};
									{Vector(-20.2314, -110.5173, 35.0710), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/golf/v8_start_loop1.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);