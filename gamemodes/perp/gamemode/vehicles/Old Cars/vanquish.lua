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

VEHICLE.ID 				= 'E';
VEHICLE.FID				= '35';

VEHICLE.Name 			= "Vanquish";
VEHICLE.Make 			= "Vanquish";
VEHICLE.Model 			= "Vanquish";

VEHICLE.Script 			= "vanquish";

VEHICLE.Cost 			= 300000;
VEHICLE.PaintJobCost 	= 12000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/sickness/vanquish.mdl', skin = '0', name = 'Teal Green', color = Color(32, 170, 170, 255)},
									{model = 'models/sickness/vanquish.mdl', skin = '1', name = 'Purple', color = Color(72, 61, 139, 255)},
									{model = 'models/sickness/vanquish.mdl', skin = '2', name = 'Navy Blue', color = Color(0, 0, 128, 255)},
									{model = 'models/sickness/vanquish.mdl', skin = '3', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/sickness/vanquish.mdl', skin = '4', name = 'Orange Red', color = Color(255, 70, 0, 255)},
									{model = 'models/sickness/vanquish.mdl', skin = '5', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/sickness/vanquish.mdl', skin = '7', name = 'Dark Green', color = Color(0, 100, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(19, 5, 15), Angle(0, 0, 13)},
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

VEHICLE.PaintText = "Of course! Nice Vanquish by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(29.7764, 98.9195, 36.4165), 	Angle(20, 0, 0)};
									{Vector(-29.7764, 98.9195, 36.4165), 	Angle(20, 0, 0)};
									{Vector(34.7764, 100.9195, 19.4165), 	Angle(20, 0, 0)};
									{Vector(-34.7764, 100.9195, 19.4165), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-29.1593, -105.6055, 38.7291), 	Angle(20, -180, 0)};
									{Vector(29.1593, -105.6055, 38.7291), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);