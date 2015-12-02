


VEHICLE 				= {};

VEHICLE.ID 				= 'x';

VEHICLE.Name 			= "SWAT Van";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Crown Royal";

VEHICLE.Script 			= "swatvan";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;

VEHICLE.DF				= false;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/perp2.5/swat_van.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(23.57, -35, 45), Angle(0, 0, 0)},
								{Vector(35, 85, 50), Angle(0, 90, 0)},
								{Vector(-35, 85, 50), Angle(0, -90, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(108.4158, 53.3863, 2.2271),
								Vector(-108.4158, 53.3863, 2.2271),
								Vector(-62.5363, -185.0254, 2.8965),
								Vector(62.5363, -185.0254, 2.8965),
							};
							
VEHICLE.DefaultIceFriction = 1.5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= TEAM_SWAT;

VEHICLE.PaintText = "";

VEHICLE.HornNoise 			= 	"PERP2.5/firetruck_horn.mp3";
VEHICLE.HeadlightPositions 	= 	{
									{Vector(37.0823, 134.9541, 45.3427), 	Angle(20, 0, 0)};
									{Vector(-37.0823, 134.9541, 45.3427), 	Angle(20, 0, 0)};
								};

VEHICLE.TaillightPositions 	= 	{
									{Vector(-37.7724, -128.7918, 91.6226), 	Angle(20, -180, 0)};
									{Vector(-37.3994, -134.2080, 57.0039), 	Angle(20, -180, 0)};
									{Vector(-36.9836, -135.1196, 51.0537), 	Angle(20, -180, 0)};
									{Vector(37.7724, -128.7918, 91.6226), 	Angle(20, -180, 0)};
									{Vector(37.3994, -134.2080, 57.0039), 	Angle(20, -180, 0)};
									{Vector(36.9836, -135.1196, 51.0537), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

VEHICLE.SirenNoise = Sound("PERP2.5/siren_long.mp3");
VEHICLE.SirenNoise_Alt = nil;
VEHICLE.SirenColors = 	{
							{Color(255, 0, 0, 255), Vector(15.9293, 68.5494, 106.8396)},
							{Color(255, 0, 0, 255), Vector(-15.9293, 68.5494, 106.8396)},
						};

GM:RegisterVehicle(VEHICLE);