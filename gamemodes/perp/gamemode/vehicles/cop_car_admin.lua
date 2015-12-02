
 

VEHICLE 				= {};

VEHICLE.ID 				= 'D';

VEHICLE.Name 			= "Police Charger";
VEHICLE.Make 			= "Dodge";
VEHICLE.Model 			= "Charger";

VEHICLE.Script 			= "911";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;

VEHICLE.DF				= false;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/buffalodr.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(23, -7.5, 15), Angle(0, 0, 13)},
								{Vector(23, 40, 15), Angle(0, 0, 13)},
								{Vector(-23, 40, 15), Angle(0, 0, 13)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-89.9778, -0.0606, 0.8727),
								Vector(89.9778, -0.0606, 0.8727),
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
									{Vector(32.7764, 105.9195, 40.4165), 	Angle(20, 0, 0)};
									{Vector(-32.7764, 105.9195, 40.4165), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-33.1593, -111.6055, 41.7291), 	Angle(20, -180, 0)};
									{Vector(33.1593, -111.6055, 41.7291), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

VEHICLE.SirenNoise = Sound("PERP2.5/siren_long.mp3");
VEHICLE.SirenNoise_Alt = Sound("PERP2.5/siren_wail.mp3");

VEHICLE.SirenColors = 	{
							{Color(0, 0, 255, 255), Vector(-14, 120, 40)},
							{Color(0, 0, 255, 255), Vector(14, 120, 40)},
							{Color(255, 0, 0, 255), Vector(-8, 120, 40)},
							{Color(255, 0, 0, 255), Vector(8, 120, 40)},							
							{Color(0, 0, 255, 255), Vector(-26, -79, 58)},
							{Color(0, 0, 255, 255), Vector(26, -79, 58)},
							{Color(255, 0, 0, 255), Vector(-22, -79, 58)},
							{Color(255, 0, 0, 255), Vector(22, -79, 58)},
						};


GM:RegisterVehicle(VEHICLE);