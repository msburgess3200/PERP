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

VEHICLE.ID 				= 'A';
VEHICLE.FID				= '31';

VEHICLE.Name 			= "Huntley";
VEHICLE.Make 			= "Landrover";
VEHICLE.Model 			= "Rangerover";

VEHICLE.Script 			= "huntley";

VEHICLE.Cost 			= 95000;
VEHICLE.PaintJobCost 	= 6250;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/huntleydr.mdl', skin = '0', name = 'Black', color = Color(0, 0, 0, 255)},
						{model = 'models/sickness/huntleydr.mdl', skin = '1', name = 'Blue', color = Color(0, 52, 113, 255)},
						{model = 'models/sickness/huntleydr.mdl', skin = '2', name = 'Red', color = Color(255, 0, 0, 255)},
						{model = 'models/sickness/huntleydr.mdl', skin = '3', name = 'Dark Red', color = Color(117, 0, 0, 255)},
						{model = 'models/sickness/huntleydr.mdl', skin = '4', name = 'Green', color = Color(42, 255, 0, 255)},
						{model = 'models/sickness/huntleydr.mdl', skin = '6', name = 'White', color = Color(248, 251, 232, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(16, 2, 30), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-93.6075, 48.9518, 4.2876),
								Vector(93.6075, 48.9518, 4.2876),
							};
							
VEHICLE.DefaultIceFriction = .2;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! Oh what was that again? A landrover paintjob? wow.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(38.7723, 102.7135, 49.6355), 	Angle(20, 0, 0)};
									{Vector(-38.7723, 102.7135, 49.6355), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-35.2796, -120.8145, 55.8403), 	Angle(20, -180, 0)};
									{Vector(35.2796, -120.8145, 55.8403), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/enzo/turbo.mp3";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);