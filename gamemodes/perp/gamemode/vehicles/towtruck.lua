


VEHICLE 				= {};

VEHICLE.ID 				= '%';
/*
VEHICLE.Name 			= "Tow Truck";
VEHICLE.Make 			= "International";
VEHICLE.Model 			= "2674";

VEHICLE.Script 			= "international_2674";
*/

VEHICLE.Name 			= "Tow Truck";
VEHICLE.Make 			= "";
VEHICLE.Model 			= "";

VEHICLE.Script 			= "towtruck";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;

VEHICLE.DF				= false;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						--{model = 'models/sickness/zil.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
						{model = 'models/sickness/towtruckdr.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(17, -25, 50), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-75.2014, 37.7570, 3.5399),
								Vector(75.2014, 37.7570, 3.5399),
							};
							
VEHICLE.DefaultIceFriction = .5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= TEAM_ROADCREW;

VEHICLE.PaintText = "";

VEHICLE.HornNoise 			= 	"PERP2.5/firetruck_horn.mp3";
VEHICLE.HeadlightPositions =	{
									{Vector(-36, 107, 45.748199462891), Angle(5, 0, 0)},
									{Vector(36, 107, 45), Angle(5, 0, 0)},
								};



VEHICLE.TaillightPositions =	{
									{Vector(-38, -112, 42), Angle(5, -180, 0)},
									{Vector(38, -112, 42), Angle(5, -180, 0)},
								};
VEHICLE.UnderglowPositions  =	{
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

VEHICLE.SirenNoise = Sound("PERP2.5/siren_long.mp3");
VEHICLE.SirenNoise_Alt = nil;
VEHICLE.SirenColors = 	{
							{Color(180, 150, 0, 255), Vector(15.5842, 59.6891, 104.7181)},
							{Color(220, 250, 0, 255), Vector(-15.5842, 59.6891, 104.7181)},
						};

GM:RegisterVehicle(VEHICLE);