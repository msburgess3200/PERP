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

VEHICLE.ID 				= 'h';
VEHICLE.FID				= '8';

VEHICLE.Name 			= "Hakumai";
VEHICLE.Make 			= "Toyota";
VEHICLE.Model 			= "Hakumai";

VEHICLE.Script 			= "hakumai";

VEHICLE.Cost 			= 70000;
VEHICLE.PaintJobCost 	= 4500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{	model = 'models/sickness/hakumaidr.mdl', skin = '0', name = 'Black', 		color = Color(11, 9, 13, 255)	},
						{	model = 'models/sickness/hakumaidr.mdl', skin = '1', name = 'White', 		color = Color(205, 203, 195, 255)		},
						{	model = 'models/sickness/hakumaidr.mdl', skin = '2', name = 'Red', 		color = Color(255, 0, 0, 255)		},
						{	model = 'models/sickness/hakumaidr.mdl', skin = '3', name = 'Spring Green', 		color = Color(0, 255, 127, 255)		},
						{	model = 'models/sickness/hakumaidr.mdl', skin = '4', name = 'Royal Blue', 		color = Color(39, 64, 139, 255)		},
						{	model = 'models/sickness/hakumaidr.mdl', skin = '5', name = 'Cacky', 	color = Color(240, 248, 255, 255)		},						
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(20, -5, 8), Angle(0, 0, 0)},
								{Vector(20, 30, 5), Angle(0, 0, 0)},
								{Vector(-17, 30, 5), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-72.6838, 31.2153, 2.6657),
								Vector(-72.6838, -37.3369, 2.8875),
								Vector(72.6838, -45.6067, 2.1214),
								Vector(72.6838, 13.3602, 1.9054),
							};
							
VEHICLE.DefaultIceFriction = .5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course I will!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(25.6303, 96.1097, 26.5435), 	Angle(20, 0, 0)};
									{Vector(-25.6303, 96.1097, 26.5435), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-24.7187, -95.7260, 33.2167), 	Angle(20, -180, 0)};
									{Vector(24.7187, -95.7260, 33.2167), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/golf/v8_start_loop1.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);