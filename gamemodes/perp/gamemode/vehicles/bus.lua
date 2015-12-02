


VEHICLE 				= {};

VEHICLE.ID 				= '-';

VEHICLE.Name 			= "Bus";
VEHICLE.Make 			= "Bus";
VEHICLE.Model 			= "Bus";

VEHICLE.Script 			= "gtabus";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;
VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/gtabus.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(-35, -108, 52), Angle(0, 0, 0)},
								{Vector(-35, -68, 52), Angle(0, 0, 0)},
								{Vector(-35, -28, 52), Angle(0, 0, 0)},
								{Vector(-35, 10, 52), Angle(0, 0, 0)},
								{Vector(35, -108, 52), Angle(0, 0, 0)},
								{Vector(35, -68, 52), Angle(0, 0, 0)},
								{Vector(35, -28, 52), Angle(0, 0, 0)},
								{Vector(35, 10, 52), Angle(0, 0, 0)},
								{Vector(-35, 147, 52), Angle(0, 0, 0)},
								{Vector(-35, 197, 52), Angle(0, 0, 0)},
								{Vector(35, 147, 52), Angle(0, 0, 0)},
								{Vector(35, 197, 52), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(85, 210, 0.2515),
							};
							
VEHICLE.DefaultIceFriction = 1.5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 0);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= TEAM_BUSDRIVER;

VEHICLE.PaintText = "";

VEHICLE.HornNoise 			= 	"PERP2.5/firetruck_horn.mp3";
VEHICLE.HeadlightPositions =	{
									{Vector(-31, 266, 38), Angle(5, 0, 0)},
									{Vector(31, 266, 38), Angle(5, 0, 0)},
								};

VEHICLE.TaillightPositions =	{
									{Vector(-50, -245, 50), Angle(5, -180, 0)},
									{Vector(50, -245, 50), Angle(5, -180, 0)},
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;


GM:RegisterVehicle(VEHICLE);