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

VEHICLE.ID 				= 'I';
VEHICLE.FID				= '57';

VEHICLE.Name 			= "Audi R8";
VEHICLE.Make 			= "Audi";
VEHICLE.Model 			= "Audi R8 V10";
VEHICLE.Mat				= 'materials/VGUI/audir8v10tdm';

VEHICLE.Script 			= "audir8v10";

VEHICLE.Cost 			= 190000;
VEHICLE.PaintJobCost 	= 8000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/audir8v10.mdl', skin = '13', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/audir8v10.mdl', skin = '1', name = 'Purple', color = Color(67, 12, 96, 255)},
									{model = 'models/tdmcars/audir8v10.mdl', skin = '2', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/audir8v10.mdl', skin = '3', name = 'Yellow', color = Color(240, 249, 0, 255)},
									{model = 'models/tdmcars/audir8v10.mdl', skin = '4', name = 'Blue', color = Color(0, 9, 123, 255)},
									{model = 'models/tdmcars/audir8v10.mdl', skin = '5', name = 'Modern Green', color = Color(0, 121, 0, 255)},
									{model = 'models/tdmcars/audir8v10.mdl', skin = '8', name = 'Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/audir8v10.mdl', skin = '11', name = 'Pink', color = Color(255, 0, 234, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(17.5, 4, 7), Angle(0, 0, 15)},
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

VEHICLE.PaintText = "Of course! Nice Audi by the way man!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-34.1, 80.3, 27.3), 	Angle(20, 0, 0)};
									{Vector(34.1, 80.3, 27.3), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-25.4, -93.4, 36.2), 	Angle(20, -180, 0)};
									{Vector(25.4, -93.4, 36.2), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);