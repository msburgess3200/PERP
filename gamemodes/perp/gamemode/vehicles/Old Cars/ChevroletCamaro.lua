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

VEHICLE.ID 				= 'm';
VEHICLE.FID				= '13';

VEHICLE.Name 			= "Camaro SS";
VEHICLE.Make 			= "Chevrolet";
VEHICLE.Model 			= "Camaro SS 69";

VEHICLE.Script 			= "69camaro";

VEHICLE.Cost 			= 105000;
VEHICLE.PaintJobCost 	= 6500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/69camaro.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/69camaro.mdl', skin = '1', name = 'Blue', color = Color(0, 9, 123, 255)},
									{model = 'models/tdmcars/69camaro.mdl', skin = '2', name = 'Bloodly Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/69camaro.mdl', skin = '3', name = 'Silver', color = Color(125, 128, 125, 255)},
									{model = 'models/tdmcars/69camaro.mdl', skin = '4', name = 'Black with Green stipes', color = {Color(0, 0, 0, 255), Color(42, 255, 0, 255)}},
									{model = 'models/tdmcars/69camaro.mdl', skin = '6', name = 'Black with Blue Fire', color = {Color(0, 0, 0, 255), Color(0, 52, 113, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(16.5, 6, 23), Angle(0, 0, 8)},
								{Vector(15, 24, 23), Angle(0, 0, 8)},
								{Vector(-15, 24, 23), Angle(0, 0, 8)}
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

VEHICLE.PaintText = "Of course! Nice lame Volvo by the way! :P";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-31.7, 103.2, 32), 	Angle(20, 0, 0)};
									{Vector(31.7, 103.2, 32), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-32.9, -106.2, 36), 	Angle(20, -180, 0)};
									{Vector(32.9, -106.2, 36), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);