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

VEHICLE.ID 				= 'o';
VEHICLE.FID				= '15';

VEHICLE.Name 			= "Corvette";
VEHICLE.Make 			= "Chevrolet (GM)";
VEHICLE.Model 			= "Corvette";

VEHICLE.Script 			= "corvette";

VEHICLE.Cost 			= 125000;
VEHICLE.PaintJobCost 	= 7500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/corvette/corvette.mdl', skin = '0', name = 'Blue', color = Color(0, 52, 113, 255)},
									{model = 'models/corvette/corvette.mdl', skin = '1', name = 'Silver', color = Color(137, 137, 137, 255)},
									{model = 'models/corvette/corvette.mdl', skin = '2', name = 'Yellow', color = Color(255, 255, 0, 255)},
									{model = 'models/corvette/corvett2.mdl', skin = '0', name = 'Red', color = Color(255, 0, 0, 255)},
									{model = 'models/corvette/corvett2.mdl', skin = '1', name = 'Green', color = Color(42, 255, 0, 255)},
									{model = 'models/corvette/corvett2.mdl', skin = '2', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/corvette/corvett3.mdl', skin = '0', name = 'Purple', color = Color(67, 12, 96, 255)},
									{model = 'models/corvette/corvett3.mdl', skin = '2', name = 'Sky Blue', color = Color(0, 188, 235, 255)},
									{model = 'models/corvette/corvett4.mdl', skin = '0', name = 'Taxi', color = {Color(203, 173, 0, 255), Color(0, 0, 0, 255)}},
									{model = 'models/corvette/corvett4.mdl', skin = '1', name = 'Blue With Stripes', color = {Color(0, 139, 187, 255), Color(0, 36, 48, 255)}},
									{model = 'models/corvette/corvett4.mdl', skin = '2', name = 'Yellow With Stripes', color = {Color(203, 156, 0, 255), Color(45, 35, 0, 255)}},
									//{model = 'models/corvette/corvett3.mdl', skin = '1', name = '#OVERRIDE#', color = {Color(255, 0, 0, 255), Color(0, 0, 0, 255)}},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(23, 15, 13), Angle(0, 0, 10)},
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

VEHICLE.PaintText = "Of course! Not quite as good looking as the shelby, but it's still pretty damn fine.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(32.7764, 97.9195, 32.4165), 	Angle(20, 0, 0)};
									{Vector(-32.7764, 97.9195, 32.4165), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-33.1593, -111.6055, 41.7291), 	Angle(20, -180, 0)};
									{Vector(-22.1437, -112.1921, 42.0366), 	Angle(20, -180, 0)};
									{Vector(22.1437, -112.1921, 42.0366), 	Angle(20, -180, 0)};
									{Vector(33.1593, -111.6055, 41.7291), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);