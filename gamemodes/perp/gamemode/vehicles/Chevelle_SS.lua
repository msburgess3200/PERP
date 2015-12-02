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

VEHICLE.ID 				= 'U';
VEHICLE.FID				= '62';

VEHICLE.Name 			= "Chevelle SS";
VEHICLE.Make 			= "Chevrolet";
VEHICLE.Model 			= "Chevelle";

VEHICLE.Script 			= "chevelless";

VEHICLE.Cost 			= 200000;
VEHICLE.PaintJobCost 	= 10000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/chevelless.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/chevelless.mdl', skin = '3', name = 'Purple', color = Color(67, 12, 96, 255)},
									{model = 'models/tdmcars/chevelless.mdl', skin = '5', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/chevelless.mdl', skin = '7', name = 'Yellow', color = Color(240, 249, 0, 255)},
									{model = 'models/tdmcars/chevelless.mdl', skin = '9', name = 'Blue', color = Color(0, 0, 240, 255)},
									{model = 'models/tdmcars/chevelless.mdl', skin = '11', name = 'Light Blue', color = Color(0, 0, 240, 255)},
									{model = 'models/tdmcars/chevelless.mdl', skin = '15', name = 'Orange', color = Color(235, 100, 32, 255)},
									{model = 'models/tdmcars/chevelless.mdl', skin = '17', name = 'Red', color = Color(240, 0, 0, 255)},
									{model = 'models/tdmcars/chevelless.mdl', skin = '25', name = 'Black with winning squares(white)', color = {Color(0, 0, 0, 255), Color(255, 255, 255, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(15, -4, 16), Angle(0, 0, 8)},
								{Vector(-15, 40, 16), Angle(0, 0, 8)},
								{Vector(15, 40, 16), Angle(0, 0, 8)},
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

VEHICLE.PaintText = "Of course! Nice Chevelle SS by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-25, 105, 35), 	Angle(20, 0, 0)};
									{Vector(27, 105, 35), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-34, -120, 29.5), 	Angle(20, -180, 0)};
									{Vector(34, -120, 29.5), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);