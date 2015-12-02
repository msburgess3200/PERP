
 

VEHICLE 				= {};

VEHICLE.ID 				= 'z';

VEHICLE.Name 			= "Police Mustang";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "GT500 Mustang";

VEHICLE.Script 			= "gt500";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;

VEHICLE.DF				= false;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/tdmcars/gt500.mdl', color = Color(255, 255, 255, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(17.8, 0, 27.3), Angle(0, 0, 8)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-83.1944, 6.2218, 3.3109),
								Vector(83.1944, 6.2218, 3.3109),
							};
							
VEHICLE.DefaultIceFriction = 1;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= TEAM_POLICE;

VEHICLE.PaintText = "";

VEHICLE.HornNoise 			= 	Sound("PERP2.5/siren_short.mp3");
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-33, 91.5, 33), 	Angle(20, 0, 0)};
									{Vector(33, 91.5, 33), 	Angle(20, 0, 0)};
								};

VEHICLE.TaillightPositions 	= 	{
									{Vector(-26, -107, 42), 	Angle(20, -180, 0)};
									{Vector(26, -107, 42), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

VEHICLE.SirenNoise = Sound("PERP2.5/siren_long.mp3");
VEHICLE.SirenNoise_Alt = Sound("PERP2.5/siren_wail.mp3");

VEHICLE.SirenColors = 	{
							{Color(0, 0, 255, 255), Vector(-16, 110, 33)},
							{Color(0, 0, 255, 255), Vector(23, 110, 33)},
							{Color(255, 0, 0, 255), Vector(-8, 110, 33)},
							{Color(255, 0, 0, 255), Vector(16, 110, 33)},
						};

GM:RegisterVehicle(VEHICLE);