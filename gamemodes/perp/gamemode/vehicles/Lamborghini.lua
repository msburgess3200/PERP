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

VEHICLE.ID 				= 'O';
VEHICLE.FID				= '61';

VEHICLE.Name 			= "Lamborghini Murcielago";
VEHICLE.Make 			= "Lamborghini";
VEHICLE.Model 			= "Murcielago";

VEHICLE.Script 			= "murcielagoTDM";

VEHICLE.Cost 			= 500000;
VEHICLE.PaintJobCost 	= 10000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/murcielago.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/murcielago.mdl', skin = '3', name = 'Purple', color = Color(67, 12, 96, 255)},
									{model = 'models/tdmcars/murcielago.mdl', skin = '5', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/murcielago.mdl', skin = '7', name = 'Yellow', color = Color(240, 249, 0, 255)},
									{model = 'models/tdmcars/murcielago.mdl', skin = '9', name = 'Blue', color = Color(0, 0, 240, 255)},
									{model = 'models/tdmcars/murcielago.mdl', skin = '11', name = 'Light Blue', color = Color(0, 0, 240, 255)},
									{model = 'models/tdmcars/murcielago.mdl', skin = '15', name = 'Orange', color = Color(235, 100, 32, 255)},
									{model = 'models/tdmcars/murcielago.mdl', skin = '17', name = 'Red', color = Color(240, 0, 0, 255)},
									{model = 'models/tdmcars/murcielago.mdl', skin = '23', name = 'White with Black Stripes', color = {Color(0, 0, 0, 255), Color(255, 255, 255, 255)}},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(17.5, 4, 5), Angle(0, 0, 8)}
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

VEHICLE.PaintText = "Of course! Nice Lamborghini by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-29.2, 85.5, 28), 	Angle(20, 0, 0)};
									{Vector(29.2, 85.5, 28), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-30, -101, 39), 	Angle(20, -180, 0)};
									{Vector(30, -101, 39), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);