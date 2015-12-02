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

VEHICLE.ID 				= 'B';
VEHICLE.FID				= '32';

VEHICLE.Name 			= "Mule";
VEHICLE.Make 			= "General Motors";
VEHICLE.Model 			= "Mule";

VEHICLE.Script 			= "mule";

VEHICLE.Cost 			= 110000;
VEHICLE.PaintJobCost 	= 7000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/muledr.mdl', skin = '0', name = 'White', color = Color(248, 251, 232, 255)},
						{model = 'models/sickness/muledr.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
						{model = 'models/sickness/muledr.mdl', skin = '2', name = 'Brown', color = Color(136, 97, 53, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(20.6327, -110.2826, 60.5586), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-93.6075, 48.9518, 4.2876),
								Vector(93.6075, 48.9518, 4.2876),
							};
							
VEHICLE.DefaultIceFriction = .3;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "A mule huh? Interesting.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(35.7723, 161.7135, 47.6355), 	Angle(20, 0, 0)};
									{Vector(-35.7723, 161.7135, 47.6355), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-27.5693, -170.8279, 38.9439), 	Angle(20, -180, 0)};
									{Vector(27.5693, -170.8279, 38.9439), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/premier/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);