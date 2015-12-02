
 

VEHICLE 				= {};

VEHICLE.ID 				= 'ddddd';

VEHICLE.Name 			= "Police Car";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Crown Royal";

VEHICLE.Script 			= "cop";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;

VEHICLE.DF				= false;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/perp2.5/police_cruiser.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(19.8167, 0, 10), Angle(0, 0, 0)},
								{Vector(19.8167, 40, 14), Angle(0, 0, 0)},
								{Vector(-19.8167, 40, 14), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-83.1944, 6.2218, 3.3109),
								Vector(83.1944, 6.2218, 3.3109),
								Vector(83.1944, -31, 3.3109),
								Vector(-83.1944, -31, 3.3109),
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
									{Vector(-25.4003, 102.3026, 32.7976), 	Angle(15, 0, 0)};
									{Vector(25.4003, 102.3026, 32.7976), 	Angle(15, 0, 0)};
								};

VEHICLE.TaillightPositions 	= 	{
									{Vector(-28.1642, -122.3515, 35.9066), 	Angle(20, -180, 0)};
									{Vector(28.1642, -122.3515, 35.9066), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

VEHICLE.SirenNoise = Sound("PERP2.5/siren_long.mp3");
VEHICLE.SirenNoise_Alt = Sound("PERP2.5/siren_wail.mp3");

VEHICLE.SirenColors = 	{
							{Color(0, 0, 255, 255), Vector(19.9011, -11.7145, 64.5684)},
							{Color(0, 0, 255, 255), Vector(-19.9011, -11.7145, 64.5684)},
							{Color(255, 0, 0, 255), Vector(-12.2631, -7.0797, 65.0943)},
							{Color(255, 0, 0, 255), Vector(12.2631, -7.0797, 65.0943)},
							{Color(0, 0, 255, 255), Vector(-5.4694, -3.4697, 65.1131)},
							{Color(0, 0, 255, 255), Vector(5.4694, -3.4697, 65.1131)},
							{Color(255, 0, 0, 255), Vector(0, 1.5218, 64.8619)},
						};


GM:RegisterVehicle(VEHICLE);