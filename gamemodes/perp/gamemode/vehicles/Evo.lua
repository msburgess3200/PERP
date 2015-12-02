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

VEHICLE.ID 				= 'T';
VEHICLE.FID				= '60';

VEHICLE.Name 			= "Evo Lancer X";
VEHICLE.Make 			= "Mitsubishi";
VEHICLE.Model 			= "Evo Lancer";

VEHICLE.Script 			= "mitsu_evox";

VEHICLE.Cost 			= 80000;
VEHICLE.PaintJobCost 	= 1500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/tdmcars/mitsu_evox.mdl', skin = '0', name = 'White', color = Color(255, 255, 255, 255)},
									{model = 'models/tdmcars/mitsu_evox.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/tdmcars/mitsu_evox.mdl', skin = '2', name = 'Bloodly Red', color = Color(255, 0, 0, 255)},
									{model = 'models/tdmcars/mitsu_evox.mdl', skin = '4', name = 'Black with Green stipes', color = {Color(0, 0, 0, 255), Color(42, 255, 0, 255)}},
									{model = 'models/tdmcars/mitsu_evox.mdl', skin = '5', name = 'Black with Blue Fire', color = {Color(0, 0, 0, 255), Color(0, 52, 113, 255)}}
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(-19.3, -12, 18.3), Angle(0, 0, 8)},
								{Vector(-17.8, 43.4, 19.3), Angle(0, 0, 8)},
								{Vector(14.2, 43.4, 19.3), Angle(0, 0, 8)},
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

VEHICLE.PaintText = "Of course! Nice Evo Lancer by the way!";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-35.4, 76.9, 33.5), 	Angle(20, 0, 0)};
									{Vector(33.4, 76.9, 33.5), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-31.2, -110.3, 46.1), 	Angle(20, -180, 0)};
									{Vector(31.2, -110.3, 46.1), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);