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

VEHICLE.ID 				= 'a';
VEHICLE.FID				= '1';

VEHICLE.Name 			= "ATV";
VEHICLE.Make 			= "Honda";
VEHICLE.Model 			= "Rubicon";

VEHICLE.Script 			= "rubicon";

VEHICLE.Cost 			= 5000;
VEHICLE.PaintJobCost 	= 2500;  

VEHICLE.DF				= true;                                      

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{	model = 'models/perp2.5/atv_1.mdl', 	skin = '0', 	name = 'Red', 		color = Color(255, 0, 0, 255)		},
						{	model = 'models/perp2.5/atv_1.mdl', 	skin = '1', 	name = 'Blue', 		color = Color(8, 28, 124, 255)		},
						{	model = 'models/perp2.5/atv_1.mdl', 	skin = '2', 	name = 'Black', 	color = Color(32, 32, 32, 255)		},
						{	model = 'models/perp2.5/atv_2.mdl', 	skin = '0', 	name = 'Orange', 	color = Color(254, 173, 23, 255)	},
						{	model = 'models/perp2.5/atv_2.mdl', 	skin = '1', 	name = 'Green', 	color = Color(25, 112, 48, 255)		},
						{	model = 'models/perp2.5/atv_2.mdl', 	skin = '2', 	name = 'Pink', 		color = Color(255, 0, 234, 255)		},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(0, 30, 24), Angle(0, 0, 0)},
							};
							
VEHICLE.ExitPoints 		=	{
								Vector(-54.0352, -13.6456, 4.5162),
								Vector(54.0352, -13.6456, 4.6937),
							};
							
VEHICLE.DefaultIceFriction = 1.5;
							
VEHICLE.PlayerReposition_Pos = Vector(0, -23, 40);
VEHICLE.PlayerReposition_Ang = Angle(25, 90, 00);

VEHICLE.ViewAdjustments_FirstPerson = VIEW_LOCK;
VEHICLE.ViewAdjustments_ThirdPerson = Vector(0, 0, 30);

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! ATV paint jobs are a little tricky, but I think I can manage.";

VEHICLE.HornNoise 			= 	nil;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-11.0832, 45.0560, 32.8541), Angle(30, 0, 0)};
									{Vector(11.0832, 45.0560, 32.8541), Angle(30, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-18.0701, -50.9401, 37.1385), Angle(20, -180, 0)};
									{Vector(18.0701, -50.9401, 37.1385), Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound 		= nil;
VEHICLE.SpinoutSound		= nil;

GM:RegisterVehicle(VEHICLE);