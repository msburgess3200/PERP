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

VEHICLE.ID 				= 'N';
VEHICLE.FID				= '53';

VEHICLE.Name 			= "Mazda RX-8";
VEHICLE.Make 			= "RX8";
VEHICLE.Model 			= "Mazda RX-8";

VEHICLE.Script 			= "rx8";

VEHICLE.Cost 			= 80000;
VEHICLE.PaintJobCost 	= 2000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/rx8.mdl', skin = '4', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/rx8.mdl', skin = '2', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/rx8.mdl', skin = '3', name = 'Blue', color = Color(0, 9, 123, 255)},
									{model = 'models/tdmcars/rx8.mdl', skin = '5', name = 'Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/rx8.mdl', skin = '6', name = 'Green', color = Color(0, 88, 36, 255)},
									{model = 'models/tdmcars/rx8.mdl', skin = '1', name = 'Light Blue with Black', color = {Color(0, 0, 0, 255), Color(0, 9, 123, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(-17.8, -2.2, 21), Angle(0, 0, 8)},
								{Vector(-17.8, 38.4, 21), Angle(0, 0, 8)},
								{Vector(17.8, 38.4, 21), Angle(0, 0, 8)},
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

VEHICLE.PaintText = "Of course! Nice Mustang by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(31, 90.2, 39.3), 	Angle(20, 0, 0)};
									{Vector(-31, 90.2, 39.3), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(25, -98.4, 48.2), 	Angle(20, -180, 0)};
									{Vector(-25, -98.4, 48.2), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);