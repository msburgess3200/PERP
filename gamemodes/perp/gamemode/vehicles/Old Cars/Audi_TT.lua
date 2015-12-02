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

VEHICLE.ID 				= 'L';
VEHICLE.FID				= '66';

VEHICLE.Name 			= "Audi TT 07";
VEHICLE.Make 			= "Audi";
VEHICLE.Model 			= "TT 07";

VEHICLE.Script 			= "auditt";

VEHICLE.Cost 			= 175000;
VEHICLE.PaintJobCost 	= 5000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/auditt.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/auditt.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/auditt.mdl', skin = '2', name = 'Bloodly Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/auditt.mdl', skin = '4', name = 'Black with Green stipes', color = {Color(0, 0, 0, 255), Color(42, 255, 0, 255)}},
									{model = 'models/tdmcars/auditt.mdl', skin = '5', name = 'Black with Blue Fire', color = {Color(0, 0, 0, 255), Color(0, 52, 113, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(19.5, 5, 13), Angle(0, 0, 8)}
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

VEHICLE.PaintText = "Of course! Nice Audi by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-31.3, 79.7, 30.4), 	Angle(20, 0, 0)};
									{Vector(31.3, 79.7, 30.4), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-31.4, -77.8, 36.3), 	Angle(20, -180, 0)};
									{Vector(31.4, -77.8, 36.3), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);