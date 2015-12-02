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

VEHICLE.ID 				= 'Z';
VEHICLE.FID				= '59';

VEHICLE.Name 			= "Ford Focus RS";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Focus";

VEHICLE.Script 			= "focusrs";

VEHICLE.Cost 			= 70000;
VEHICLE.PaintJobCost 	= 1000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/focusrs.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/focusrs.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/focusrs.mdl', skin = '2', name = 'Bloodly Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/focusrs.mdl', skin = '4', name = 'Black with Green stipes', color = {Color(0, 0, 0, 255), Color(42, 255, 0, 255)}},
									{model = 'models/tdmcars/focusrs.mdl', skin = '5', name = 'Black with Blue Fire', color = {Color(0, 0, 0, 255), Color(0, 52, 113, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(-17.5, -2, 21), Angle(0, 0, 8)},
								{Vector(17.5, 40, 21), Angle(0, 0, 8)},
								{Vector(-17.5, 40, 21), Angle(0, 0, 8)},
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

VEHICLE.PaintText = "Of course! Nice Focus by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-28.8, 82.4, 33.6), 	Angle(20, 0, 0)};
									{Vector(28.8, 82.4, 33.6), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-31.2, -85, 55.8), 	Angle(20, -180, 0)};
									{Vector(31.2, -85, 55.8), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);