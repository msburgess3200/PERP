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

VEHICLE.ID 				= 'V';
VEHICLE.FID				= '55';

VEHICLE.Name 			= "Skyline R34";
VEHICLE.Make 			= "Nissan";
VEHICLE.Model 			= "Skyline";

VEHICLE.Script 			= "skyline_r34";

VEHICLE.Cost 			= 120000;
VEHICLE.PaintJobCost 	= 4000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/skyline_r34.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/skyline_r34.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/skyline_r34.mdl', skin = '2', name = 'Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/skyline_r34.mdl', skin = '3', name = 'Green', color = Color(0, 88, 36, 255)},
									{model = 'models/tdmcars/skyline_r34.mdl', skin = '4', name = 'Blue', color = Color(0, 9, 123, 255)},
									{model = 'models/tdmcars/skyline_r34.mdl', skin = '6', name = 'Black with Blue fire effect', color = {Color(0, 0, 0, 255), Color(0, 9, 123, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(-17.8, -2.2, 14), Angle(0, 0, 8)},
								{Vector(-17.8, 35.4, 14), Angle(0, 0, 8)},
								{Vector(17.8, 35.4, 14), Angle(0, 0, 8)},
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

VEHICLE.PaintText = "Of course! Nice Skyline R34 by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-23.2, 96, 30), 	Angle(20, 0, 0)};
									{Vector(23.2, 96, 30), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-32.2, -105.2, 40.4), 	Angle(20, -180, 0)};
									{Vector(32.2, -105.2, 40.4), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);