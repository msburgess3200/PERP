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

VEHICLE.ID 				= 'n';
VEHICLE.FID				= '14';

VEHICLE.Name 			= "Spyder";
VEHICLE.Make 			= "Ferrari";
VEHICLE.Model 			= "Spyder";

VEHICLE.Script 			= "spyder";

VEHICLE.Cost 			= 115000;
VEHICLE.PaintJobCost 	= 7000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/360spyder.mdl', skin = '0', name = 'Red', color = Color(149, 17, 19, 255)},
						{model = 'models/sickness/360spyder.mdl', skin = '1', name = 'Yellow', color = Color(227, 180, 0, 255)},
						{model = 'models/sickness/360spyder.mdl', skin = '2', name = 'Black', color = Color(16, 17, 19, 255)},
						{model = 'models/sickness/360spyder.mdl', skin = '3', name = 'Purple', color = Color(19, 16, 35, 255)},
						{model = 'models/sickness/360spyder.mdl', skin = '4', name = 'Sky Blue', color = Color(43, 28, 22, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(20, -5, 5), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(74.9855, 14.4281, 2.9982),
								Vector(-73.2818, 15.7390, 2.9978),
							};
							
VEHICLE.DefaultIceFriction = .2;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(24.0162, 104.6773, 29.7472), 	Angle(20, 0, 0)};
									{Vector(-24.0162, 104.6773, 29.7472), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(28.3587, -82.8735, 33.7746), 	Angle(20, -180, 0)};
									{Vector(-28.3587, -82.8735, 33.7746), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/enzo/turbo.mp3";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);