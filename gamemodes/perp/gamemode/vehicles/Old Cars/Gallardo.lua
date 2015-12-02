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

VEHICLE.ID 				= 'F';
VEHICLE.FID				= '36';

VEHICLE.Name 			= "Gallardo";
VEHICLE.Make 			= "Lamborghini";
VEHICLE.Model 			= "Gallardo";

VEHICLE.Script 			= "gallardo";

VEHICLE.Cost 			= 850000;
VEHICLE.PaintJobCost 	= 11000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/gallardo.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/gallardo.mdl', skin = '1', name = 'Gray', color = Color(125, 128, 125, 255)},
									{model = 'models/tdmcars/gallardo.mdl', skin = '2', name = 'Orange', color = Color(235, 100, 32, 255)},
									{model = 'models/tdmcars/gallardo.mdl', skin = '3', name = 'Green', color = Color(0, 88, 36, 255)},
									{model = 'models/tdmcars/gallardo.mdl', skin = '4', name = 'Blue', color = Color(0, 9, 123, 255)},
									{model = 'models/tdmcars/gallardo.mdl', skin = '5', name = 'Black with Blue Fire', color = {Color(0, 0, 0, 255), Color(0, 52, 113, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(17.8, 4, 10), Angle(0, 0, 8)}
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-89.9778, -0.0606, 0.8727),
								Vector(89.9778, -0.0606, 0.8727)
							};
							
VEHICLE.DefaultIceFriction = .5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! Nice Gallardo by the way! Mind I have it?";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-36.1, 82.3, 29), 	Angle(20, 0, 0)};
									{Vector(36.1, 82.3, 29), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-26.6, -94.8, 38.6), 	Angle(20, -180, 0)};
									{Vector(26.6, -94.8, 38.6), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);