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

VEHICLE.ID 				= 'j';
VEHICLE.FID				= '10';

VEHICLE.Name 			= "Barchetta";
VEHICLE.Make 			= "Ferrari";
VEHICLE.Model 			= "Barchetta";

VEHICLE.Script 			= "ferrari";

VEHICLE.Cost 			= 85000;
VEHICLE.PaintJobCost 	= 5500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/ferrari.mdl', skin = '0', name = 'Red', color = Color(200, 42, 40, 255)},
						{model = 'models/ferrari2.mdl', skin = '0', name = 'Silver', color = Color(120, 122, 120, 255)},
						{model = 'models/ferrari3.mdl', skin = '0', name = 'Yellow', color = Color(197, 201, 43, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(16, 2, 9), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-66.0086, -10.4226, 1.5535),
								Vector(62.9183, 9.9905, 1.4159),
							};
							
VEHICLE.DefaultIceFriction = .2;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 15);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! Unfortunately, due to the openess of your car, we only have a few paints that won't spread everywhere while we're applying it.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(20.7194, 90.3255, 26.6879), 	Angle(20, 0, 0)};
									{Vector(-20.7194, 90.3255, 26.6879), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-21.2796, -76.8145, 30.8403), 	Angle(20, -180, 0)};
									{Vector(21.2796, -76.8145, 30.8403), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/enzo/turbo.mp3";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);