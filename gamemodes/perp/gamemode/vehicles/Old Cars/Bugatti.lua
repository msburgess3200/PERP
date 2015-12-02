/////////////////////////////////////////
 // © 2009-2010 D3luX - Dynamic Effect //
//    All rights reserved    		   //
/////////////////////////////////////////
// This material may not be  		   //
//   reproduced, displayed,  		   //
//  modified or distributed  		   //
// without the express prior 		   //
// written permission of the 		   //
//   the copyright holder.   		   //
/////////////////////////////////////////


VEHICLE 				= {};

VEHICLE.ID 				= '8';

VEHICLE.Name 			= "Veyron";
VEHICLE.Make 			= "Bugatti";
VEHICLE.Model 			= "Bugatti Veyron";

VEHICLE.Script 			= "veyron";

VEHICLE.Cost 			= 2200000;
VEHICLE.PaintJobCost 	= 20000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/veyron.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/veyron.mdl', skin = '1', name = 'Black/Red', color = Color(0, 0, 0, 255)},
									{model = 'models/veyron.mdl', skin = '2', name = 'Black/Blue', color = Color(0, 52, 113, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(17, -14, 0), Angle(0, 0, 13)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-89.9778, -0.0606, 0.8727),
								Vector(89.9778, -0.0606, 0.8727),
							};
							
VEHICLE.DefaultIceFriction = .5;
							
VEHICLE.PlayerReposition_Pos = Vector(-15, 0, 8);
VEHICLE.PlayerReposition_Ang = Angle(10, 90, 00);

VEHICLE.ViewAdjustments_FirstPerson = Vector(-18, -223, -42);
VEHICLE.ViewAdjustments_ThirdPerson = Vector(0, 0, 30);

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! A Bugatti Veyron? Damn.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(32.7764, 90.9195, 20.4165), 	Angle(20, 0, 0)};
									{Vector(-32.7764, 90.9195, 20.4165), 	Angle(20, 0, 0)};
									{Vector(-24.7764, 90.9195, 20.4165), 	Angle(15, 0, 0)};
									{Vector(24.7764, 90.9195, 20.4165), 	Angle(15, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-25.1593, -92.6055, 30.7291), 	Angle(20, -180, 0)};
									{Vector(25.1593, -92.6055, 30.7291), 	Angle(20, -180, 0)};
									{Vector(18.1593, -92.6055, 30.7291), 	Angle(15, -180, 0)};
									{Vector(-18.1593, -92.6055, 30.7291), 	Angle(15, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/enzo/turbo.mp3";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);