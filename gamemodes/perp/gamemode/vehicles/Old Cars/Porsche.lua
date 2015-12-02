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

VEHICLE.ID 				= 'P';
VEHICLE.FID				= '63';

VEHICLE.Name 			= "Porsche 997 GT3";
VEHICLE.Make 			= "Porsche";
VEHICLE.Model 			= "997";

VEHICLE.Script 			= "997gt3";

VEHICLE.Cost 			= 180000;
VEHICLE.PaintJobCost 	= 5000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/997gt3.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/997gt3.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/997gt3.mdl', skin = '2', name = 'Red', color = Color(240, 0, 0, 255)},
									{model = 'models/tdmcars/997gt3.mdl', skin = '3', name = 'Green', color = Color(0, 88, 36, 255)},
									{model = 'models/tdmcars/997gt3.mdl', skin = '4', name = 'Blue', color = Color(0, 0, 240, 255)},
									{model = 'models/tdmcars/997gt3.mdl', skin = '5', name = 'Yellow', color = Color(240, 249, 0, 255)},
									--{model = 'models/tdmcars/997gt3.mdl', skin = '25', name = 'Black with Orange rims', color = {Color(0, 0, 0, 255), Color(235, 100, 32, 255)}},
									--{model = 'models/tdmcars/997gt3.mdl', skin = '25', name = 'Black with Purple stipes', color = {Color(0, 0, 0, 255), Color(67, 12, 96, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(18, -1, 17), Angle(0, 0, 8)}
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

VEHICLE.PaintText = "Of course! Nice Porsche by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-31.2, 76, 34.2), 	Angle(20, 0, 0)};
									{Vector(31.2, 76, 34.2), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-24.9, -100.8, 36.4), 	Angle(20, -180, 0)};
									{Vector(24.9, -100.8, 36.4), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);