


VEHICLE 				= {};

VEHICLE.ID 				= 'y';

VEHICLE.Name 			= "Fire Truck";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Crown Royal";

VEHICLE.Script 			= "workingfire";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;

VEHICLE.DF				= false;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/truckfire.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(27, -145, 60), Angle(0, 0, 0)},
								{Vector(27, -108, 60), Angle(0, -180, 0)},
								{Vector(-27, -108, 60), Angle(0, -180, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(104, 133, -2),
								Vector(104, 68, -2),
								Vector(-104, 133, -2),
								Vector(-104, 68, -2),
							};
							
VEHICLE.DefaultIceFriction = 1.5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 5);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= TEAM_FIREMAN;

VEHICLE.PaintText = "";

VEHICLE.HornNoise 			= 	Sound("PERP2.5/firetruck_horn4.mp3");
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-37.3524, 200.2199, 52.8729), 	Angle(20, 0, 0)};
									{Vector(37.8264, 200.2791, 52.7459), 	Angle(20, 0, 0)};
								};

VEHICLE.TaillightPositions 	= 	{
									{Vector(-40.1956, -151.2481, 60.6091), 	Angle(20, -180, 0)};
									{Vector(40.9551, -151.2332, 60.6596), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

VEHICLE.SirenNoise = Sound("PERP2.5/firetruck_siren.mp3");
VEHICLE.SirenNoise_Alt = nil;
VEHICLE.SirenColors = 	{
							{Color(255, 0, 0, 255), Vector(24.8623, 133.0943, 112.8922)},
							{Color(255, 0, 0, 255), Vector(-24.8623, 133.0943, 112.8922)},
						};

GM:RegisterVehicle(VEHICLE);