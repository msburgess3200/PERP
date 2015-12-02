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

VEHICLE.ID 				= 'i';
VEHICLE.FID				= '9';

VEHICLE.Name 			= "Escalade";
VEHICLE.Make 			= "Cadillac";
VEHICLE.Model 			= "Escalade";

VEHICLE.Script 			= "cavalcade";

VEHICLE.Cost 			= 80000;
VEHICLE.PaintJobCost 	= 5250;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/cavalcadedr.mdl', skin = '0', name = 'Black', color = Color(32, 32, 32, 255)},
						{model = 'models/sickness/cavalcadedr.mdl', skin = '1', name = 'White', color = Color(224, 228, 224, 255)},
						{model = 'models/sickness/cavalcadedr.mdl', skin = '2', name = 'Grey', color = Color(77, 79, 77, 255)},
						{model = 'models/sickness/cavalcadedr.mdl', skin = '3', name = 'Red', color = Color(69, 33, 43, 255)},
						{model = 'models/sickness/cavalcadedr.mdl', skin = '4', name = 'Green', color = Color(24, 53, 43, 255)},
						{model = 'models/sickness/cavalcadedr.mdl', skin = '5', name = 'Blue', color = Color(11, 56, 69, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(20.7402, 5.1125, 31.7450), Angle(0, 0, 5)},
								{Vector(15.1965, 46.2199, 31.2720), Angle(0, 0, 10)},
								{Vector(-15.1965, 46.2199, 31.2720), Angle(0, 0, 10)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-93.0215, 17.4183, 2.1078),
								Vector(93.0215, 17.4183, 2.1078),
								Vector(-95.7439, -53.4246, 1.8225),
								Vector(95.7439, -53.4246, 1.8225),
							};
							
VEHICLE.DefaultIceFriction = .3;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Nice caddy. Yeah, I can paint that for you.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-33.1503, 104.8578, 50.8099), 	Angle(20, 0, 0)};
									{Vector(33.1503, 104.8578, 50.8099), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(36.2034, -123.4885, 50.9218), 	Angle(20, -180, 0)};
									{Vector(-36.2034, -123.4885, 50.9218), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/landstalker/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);