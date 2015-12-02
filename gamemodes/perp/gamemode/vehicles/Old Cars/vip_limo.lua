
VEHICLE 				= {};

VEHICLE.ID 				= '9';

VEHICLE.Name 			= "VIP's Limo";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Crown Royal";

VEHICLE.Script 			= "stretch";

VEHICLE.Cost 			= 400000;
VEHICLE.PaintJobCost 	= 18000;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/stretchdr.mdl', skin = '0', name = 'Black', color = Color(0, 0, 0, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '1', name = 'White', color = Color(200, 200, 200, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '2', name = 'Grey', color = Color(100, 100, 100, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '3', name = 'Red', color = Color(200, 0, 0, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '4', name = 'Dark Green', color = Color(0, 150, 0, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '5', name = 'Dark Cyan', color = Color(0, 0, 0, 255)},
						
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(-23.8519, 114.6827, 14.9151), Angle(0, 0, 5)},
								{Vector(-10.899806976318, 59.471515655518, 14.9151) , Angle(0, -90, 5)},
								{Vector(-16.279039382935, 31.403144836426, 14.9151) , Angle(0, -90, 5)},
								{Vector(-16.506628036499, 4.3994045257568, 14.9151) , Angle(0, -90, 5)},
								{Vector(-16.470249176025, -17.35131072998, 14.9151) , Angle(0, -90, 5)},
								{Vector(23.8519, 114.6827, 14.9151), Angle(0, 0, 5)},
								{Vector(22.9451, -47.7737, 10.6397), Angle(0, 0, 5)},
								
								
							};
	
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

VEHICLE.PaintText = "I love me a limo. Yeah, I'll paint it.";

VEHICLE.VipOnly = true

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
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

GM:RegisterVehicle(VEHICLE);