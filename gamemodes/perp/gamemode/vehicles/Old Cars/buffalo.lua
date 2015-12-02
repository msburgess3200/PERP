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

VEHICLE.ID 				= 'D';
VEHICLE.FID				= '34';

VEHICLE.Name 			= "Charger";
VEHICLE.Make 			= "Dodge";
VEHICLE.Model 			= "Dodge Charger";

VEHICLE.Script 			= "buffalo";

VEHICLE.Cost 			= 175000;
VEHICLE.PaintJobCost 	= 8250;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/sickness/buffalodr.mdl', skin = '0', name = 'Black', color = Color(0, 0, 0, 255)},
									{model = 'models/sickness/buffalodr.mdl', skin = '1', name = 'Blue', color = Color(0, 52, 113, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(23, -7.5, 15), Angle(0, 0, 13)},
								{Vector(23, 40, 15), Angle(0, 0, 13)},
								{Vector(-23, 40, 15), Angle(0, 0, 13)},
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

VEHICLE.PaintText = "Of course! Haven't seen many chargers around.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(32.7764, 105.9195, 40.4165), 	Angle(20, 0, 0)};
									{Vector(-32.7764, 105.9195, 40.4165), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-33.1593, -111.6055, 41.7291), 	Angle(20, -180, 0)};
									{Vector(33.1593, -111.6055, 41.7291), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);