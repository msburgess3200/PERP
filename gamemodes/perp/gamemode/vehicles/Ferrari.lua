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

VEHICLE.ID 				= 'J';
VEHICLE.FID				= '58';

VEHICLE.Name 			= "Ferrari 512";
VEHICLE.Make 			= "Ferrari";
VEHICLE.Model 			= "Ferrari 512 TR";

VEHICLE.Script 			= "ferrari512tr";

VEHICLE.Cost 			= 185000;
VEHICLE.PaintJobCost 	= 7000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/ferrari512tr.mdl', skin = '9', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/ferrari512tr.mdl', skin = '1', name = 'Purple', color = Color(67, 12, 96, 255)},
									{model = 'models/tdmcars/ferrari512tr.mdl', skin = '2', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/ferrari512tr.mdl', skin = '3', name = 'Yellow', color = Color(240, 249, 0, 255)},
									{model = 'models/tdmcars/ferrari512tr.mdl', skin = '4', name = 'Blue', color = Color(0, 9, 123, 255)},
									{model = 'models/tdmcars/ferrari512tr.mdl', skin = '6', name = 'Green', color = Color(0, 121, 0, 255)},
									{model = 'models/tdmcars/ferrari512tr.mdl', skin = '7', name = 'Orange', color = Color(235, 100, 32, 255)},
									{model = 'models/tdmcars/ferrari512tr.mdl', skin = '8', name = 'Red', color = Color(255, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(15, -5, 8), Angle(0, 0, 15)}
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-89.9778, -0.0606, 0.8727),
								Vector(89.9778, -0.0606, 0.8727),
							};
							
VEHICLE.DefaultIceFriction = .5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! Nice Ferrari by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(21, 92, 18.4), 	Angle(20, 0, 0)};
									{Vector(-21, 92, 18.4), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(33.7, -97.2, 32), 	Angle(20, -180, 0)};
									{Vector(-33.7, -97.2, 32), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);