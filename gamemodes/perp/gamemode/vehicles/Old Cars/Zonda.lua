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

VEHICLE.ID 				= 'G'; 
VEHICLE.FID				= '37';

VEHICLE.Name 			= "Zonda C12";
VEHICLE.Make 			= "Pagani";
VEHICLE.Model 			= "Zonda C12";

VEHICLE.Script 			= "c12";

VEHICLE.Cost 			= 1200000; 
VEHICLE.PaintJobCost 	= 15000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/zondac12.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/zondac12.mdl', skin = '2', name = 'Bloodly Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/zondac12.mdl', skin = '3', name = 'Silver', color = Color(125, 128, 125, 255)},
									{model = 'models/tdmcars/zondac12.mdl', skin = '4', name = 'Black with Green stipes', color = {Color(0, 0, 0, 255), Color(42, 255, 0, 255)}},
									{model = 'models/tdmcars/zondac12.mdl', skin = '5', name = 'Black with Blue Fire', color = {Color(0, 0, 0, 255), Color(0, 52, 113, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(16.5, 5, 10), Angle(0, 0, 8)}
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

VEHICLE.PaintText = "Of course! Nice Zonda by the way! I promise to be careful! ";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-36.4, 81.1, 26.7), 	Angle(20, 0, 0)};
									{Vector(36.4, 81.1, 26.7), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-30.7, -100.6, 30.6), 	Angle(20, -180, 0)};
									{Vector(30.7, -100.6, 30.6), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);