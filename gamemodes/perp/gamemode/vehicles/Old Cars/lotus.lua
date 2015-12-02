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

VEHICLE.ID 				= 'r';
VEHICLE.FID				= '18';

VEHICLE.Name 			= "Lotus";
VEHICLE.Make 			= "Lotus";
VEHICLE.Model 			= "Elise";

VEHICLE.Script 			= "elise";

VEHICLE.Cost 			= 200000;
VEHICLE.PaintJobCost 	= 8500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/sickness/lotus_elise.mdl', skin = '0', name = 'Blue', color = Color(32, 60, 133, 255)},
									{model = 'models/sickness/lotus_elise.mdl', skin = '1', name = 'Green', color = Color(43, 79, 40, 255)},
									{model = 'models/sickness/lotus_elise.mdl', skin = '2', name = 'Midnight Blue', color = Color(5, 3, 35, 255)},
									{model = 'models/sickness/lotus_elise.mdl', skin = '3', name = 'Silver', color = Color(141, 148, 165, 255)},
									{model = 'models/sickness/lotus_elise.mdl', skin = '4', name = 'Orange', color = Color(163, 83, 8, 255)},
									{model = 'models/sickness/lotus_elise.mdl', skin = '5', name = 'Yellow', color = Color(227, 183, 27, 255)},
									{model = 'models/sickness/lotus_elise.mdl', skin = '6', name = 'Dark Red', color = Color(117, 0, 0, 255)},
									{model = 'models/sickness/lotus_elise.mdl', skin = '7', name = 'Black', color = Color(8, 5, 5, 255)},
									{model = 'models/sickness/lotus_elise.mdl', skin = '8', name = 'Navy', color = Color(16, 21, 35, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(13, 15, 5), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-70.2944, -15.4549, 3.5120),
								Vector(69.4895, -7.4818, 3.3041),
							};
							
VEHICLE.DefaultIceFriction = .2;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Nice lotus... First one I've seen in a long time...";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-28.3782, 71.6368, 32.2197), 	Angle(20, 0, 0)};
									{Vector(28.3782, 71.6368, 32.2197), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-20.6187, -92.4385, 36.1864), 	Angle(20, -180, 0)};
									{Vector(20.6187, -92.4385, 36.1864), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/enzo/turbo.mp3";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);