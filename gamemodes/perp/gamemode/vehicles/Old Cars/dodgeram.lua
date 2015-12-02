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

VEHICLE.ID 				= 'K';
VEHICLE.FID				= '56';

VEHICLE.Name 			= "Dodge RAM SRT10";
VEHICLE.Make 			= "Dodge";
VEHICLE.Model 			= "RAM";

VEHICLE.Script 			= "dodgeram";

VEHICLE.Cost 			= 170000;
VEHICLE.PaintJobCost 	= 7000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/dodgeram.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/dodgeram.mdl', skin = '6', name = 'Green', color = Color(0, 88, 36, 255)},
									{model = 'models/tdmcars/dodgeram.mdl', skin = '8', name = 'Orange', color = Color(235, 100, 32, 255)},
									{model = 'models/tdmcars/dodgeram.mdl', skin = '9', name = 'Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/dodgeram.mdl', skin = '10', name = 'Blue', color = Color(0, 9, 123, 255)},
									{model = 'models/tdmcars/dodgeram.mdl', skin = '3', name = 'White & Black', color = {Color(0, 0, 0, 255), Color(255, 255, 255, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(20, 6, 21), Angle(0, 0, 8)}
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

VEHICLE.PaintText = "Of course! Nice Dodge Ram by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(32.4, 92, 38.2), 	Angle(20, 0, 0)};
									{Vector(-32.4, 92, 38.2), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(38.2, -109, 45.7), 	Angle(20, -180, 0)};
									{Vector(-38.2, -109, 45.7), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);