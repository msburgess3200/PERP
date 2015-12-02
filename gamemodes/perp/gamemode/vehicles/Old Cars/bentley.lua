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

VEHICLE.ID 				= 'p';
VEHICLE.FID				= '16';

VEHICLE.Name 			= "Bentley";
VEHICLE.Make 			= "Bentley";
VEHICLE.Model 			= "Mulsanne";

VEHICLE.Script 			= "bentley";

VEHICLE.Cost 			= 135000;
VEHICLE.PaintJobCost 	= 7750;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/pmp600dr.mdl', skin = '0', name = 'Black', color = Color(32, 32, 32, 255)},
						{model = 'models/sickness/pmp600dr.mdl', skin = '1', name = 'White', color = Color(224, 228, 224, 255)},
						{model = 'models/sickness/pmp600dr.mdl', skin = '2', name = 'Red', color = Color(69, 33, 43, 255)},
						{model = 'models/sickness/pmp600dr.mdl', skin = '3', name = 'Green', color = Color(24, 53, 43, 255)},
						{model = 'models/sickness/pmp600dr.mdl', skin = '4', name = 'Blue', color = Color(11, 56, 69, 255)},
						{model = 'models/sickness/pmp600dr.mdl', skin = '5', name = 'Purple', color = Color(80, 45, 93, 255)},
						{model = 'models/sickness/pmp600dr.mdl', skin = '6', name = 'Orange', color = Color(173, 87, 13, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(22.1026, 0.8364, 11.2528), Angle(0, 0, 5)},
								{Vector(17.1929, 49.2309, 12.0695), Angle(0, 0, 0)},
								{Vector(-17.1929, 49.2309, 12.0695), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(89.3729, 11.1262, 2.8183),
								Vector(-89.3729, 11.1262, 2.8183),
								Vector(89.9560, -47.4454, 2.7637),
								Vector(-89.9560, -47.4454, 2.7637),
							};
							
VEHICLE.DefaultIceFriction = .3;
							
VEHICLE.PlayerReposition_Pos = Vector(-23, -4, 21);
VEHICLE.PlayerReposition_Ang = Angle(0, 90, 0);

VEHICLE.ViewAdjustments_FirstPerson = Vector(5, 2.5, 5);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "I love me a bentley. Yeah, I'll paint it.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(22.1597, 98.3805, 32.6427), 	Angle(20, 0, 0)};
									{Vector(-22.1597, 98.3805, 32.6427), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(32.7627, -108.6362, 42.2312), 	Angle(20, -180, 0)};
									{Vector(-32.7627, -108.6362, 42.2312), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/premier/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);