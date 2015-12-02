///////////////////////////////
// © 2009-2010 Pulsar Effect //
//    All rights reserved    //
///////////////////////////////
// This material may not be  //
//   reproduced, displayed,  //
//  modified or distributed  //
// without the express prior //
// written permission of the //
//   the copyright holder.   //
///////////////////////////////


VEHICLE 				= {};

VEHICLE.ID 				= 'c';
VEHICLE.FID				= '3';

VEHICLE.Name 			= "Mini Cooper";
VEHICLE.Make 			= "BMW";
VEHICLE.Model 			= "Mini Cooper";

VEHICLE.Script 			= "mini";

VEHICLE.Cost 			= 50000;
VEHICLE.PaintJobCost 	= 3500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = 1023;

VEHICLE.PaintJobs = {
						{	model = 'models/mini/mini.mdl', skin = '0', 	name = 'White', 	color = Color(248, 251, 232, 255)	},
						{	model = 'models/mini/mini.mdl', skin = '1', 	name = 'Red', 		color = Color(205, 0, 0, 255)		},
						{	model = 'models/mini/mini.mdl', skin = '2', 	name = 'Blue', 		color = Color(0, 9, 123, 255)		},
						{	model = 'models/mini/mini.mdl', skin = '3', 	name = 'Silver', 	color = Color(125, 128, 125, 255)	},
						{	model = 'models/mini/mini.mdl', skin = '4', 	name = 'Orange', 	color = Color(235, 100, 32, 255)	},
						{	model = 'models/mini/mini.mdl', skin = '5',	 	name = 'Sky Blue', 	color = Color(0, 188, 235, 255)		},
						{	model = 'models/mini/mini.mdl', skin = '6',	 	name = 'Green', 	color = Color(0, 88, 36, 255)		},
						{	model = 'models/mini/mini.mdl', skin = '7', 	name = 'Black', 	color = Color(0, 0, 0, 255)			},
						{	model = 'models/mini/mini.mdl', skin = '8', 	name = 'Brown', 	color = Color(136, 97, 53, 255)		},
						{	model = 'models/mini/mini.mdl', skin = '9', 	name = 'Purple', 	color = Color(67, 12, 96, 255)		},
						{	model = 'models/mini/mini.mdl', skin = '10', 	name = 'Pink', 		color = Color(255, 0, 234, 255)		},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(-14, -6, 10), Angle(0, 0 ,0)},
								{Vector(14, 36, 10), Angle(0, 0 ,0)},
								{Vector(-14, 36, 10), Angle(0, 0 ,0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(70.1791, 15.6533, -2),
								Vector(70.1791, -33.3029, -2),
								Vector(-70.1791, 15.6533, -2),
								Vector(-70.1791, -33.302, -2),
							};
							
VEHICLE.DefaultIceFriction = .1;
							
VEHICLE.PlayerReposition_Pos = Vector(14, -6, 18);
VEHICLE.PlayerReposition_Ang = Angle(0, 90, 0);

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 5);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "< Mutters > Stupid british cars.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-24, 70, 32), Angle(20, 0, 0)};
									{Vector(24, 70, 32), Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-25.5362, -70.6969, 25.6062), Angle(20, -180, 0)};
									{Vector(25.5362, -70.6969, 25.6062), Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/golf/v8_start_loop1.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);