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

VEHICLE.ID 				= 'Q';
VEHICLE.FID				= '50';

VEHICLE.Name 			= "Mercedes Sl65 AMG";
VEHICLE.Make 			= "Mercedes";
VEHICLE.Model 			= "Sl65 AMG";

VEHICLE.Script 			= "sl65amg";

VEHICLE.Cost 			= 155000;
VEHICLE.PaintJobCost 	= 7000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/sl65amg.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/sl65amg.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/sl65amg.mdl', skin = '2', name = 'Bloodly Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/sl65amg.mdl', skin = '4', name = 'Black with Green stipes', color = {Color(0, 0, 0, 255), Color(42, 255, 0, 255)}},
									{model = 'models/tdmcars/sl65amg.mdl', skin = '5', name = 'Black with Blue Fire', color = {Color(0, 0, 0, 255), Color(0, 52, 113, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(17.5, -14, 14), Angle(0, 0, 8)},
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

VEHICLE.PaintText = "Of course! Nice Mercedes by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-33.1, 82.3, 27.5), 	Angle(20, 0, 0)};
									{Vector(33.1, 82.3, 27.5), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-23, -96.2, 28.8), 	Angle(20, -180, 0)};
									{Vector(23, -96.2, 28.8), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);