

VEHICLE 				= {};

VEHICLE.ID 				= 't';
VEHICLE.FID				= '20';

VEHICLE.Name 			= "Stallion";
VEHICLE.Make 			= "Oldsmobile";
VEHICLE.Model 			= "Cutlass";

VEHICLE.Script 			= "stallion";

VEHICLE.Cost 			= 300000;
VEHICLE.PaintJobCost 	= 9500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/stalliondr.mdl', skin = '0', name = 'Black', color = Color(0, 0, 0, 255)},
						{model = 'models/sickness/stalliondr.mdl', skin = '1', name = 'White', color = Color(255, 250, 250, 255)},
						{model = 'models/sickness/stalliondr.mdl', skin = '2', name = 'Red', color = Color(205, 51, 51, 255)},
						{model = 'models/sickness/stalliondr.mdl', skin = '3', name = 'Pale Green', color = Color(152, 251, 152, 255)},
						{model = 'models/sickness/stalliondr.mdl', skin = '4', name = 'Dodger Blue', color = Color(24, 116, 205, 255)},
						{model = 'models/sickness/stalliondr.mdl', skin = '5', name = 'Cacky', color = Color(240, 248, 255, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(14, 8, 8), Angle(0, 0, 10)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-72.3996, -6.1857, 1.8621),
								Vector(72.3996, -0.1439, 0.3239),
							};
							
VEHICLE.DefaultIceFriction = .5;
							
VEHICLE.PlayerReposition_Pos = Vector(-16, -15, 18);
VEHICLE.PlayerReposition_Ang = Angle(0, 90, 0);

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 5);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! The great American classic.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-31.4999, 98.5857, 31.4159), 	Angle(20, 0, 0)};
									{Vector(31.4999, 98.5857, 31.4159), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(18.6511, -92.8365, 31.6970), 	Angle(20, -180, 0)};
									{Vector(-18.6511, -92.8365, 31.6970), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/shelby/shelby_rev_short_loop1.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);