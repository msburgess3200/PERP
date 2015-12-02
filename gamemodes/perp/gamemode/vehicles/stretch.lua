


VEHICLE 				= {};

VEHICLE.ID 				= 'v';

VEHICLE.Name 			= "Stretch Limo";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Crown Royal";

VEHICLE.Script 			= "stretch";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;

VEHICLE.DF				= false;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/stretchdr.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(22.9451, -47.7737, 10.6397), Angle(0, 0, 5)},
							}
								
	VEHICLE.ExitPoints 		=	{
								Vector(-90.6435, 65.5650, 2.1304),
								Vector(90.6435, 65.5650, 2.1304),
								Vector(-92.2684, -109.0656, 1.6255),
								Vector(92.2684, -109.0656, 1.6255),
							};
							
VEHICLE.DefaultIceFriction = 1.5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass = TEAM_SECRET_SERVICE;

VEHICLE.PaintText = "";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(29.9323, 167.0016, 35.9562), 	Angle(20, 0, 0)};
									{Vector(-29.9323, 167.0016, 35.9562), 	Angle(20, 0, 0)};
								};

VEHICLE.TaillightPositions 	= 	{
									{Vector(-25.4767, -198.0278, 39.2658), 	Angle(20, -180, 0)};
									{Vector(25.4767, -198.0278, 39.2658), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

GM:RegisterVehicle(VEHICLE);