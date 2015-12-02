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

VEHICLE.ID 				= 'F';
VEHICLE.FID				= '36';

VEHICLE.Name 			= "DiabloVT";
VEHICLE.Make 			= "Lamborghini";
VEHICLE.Model 			= "DiabloVT";

VEHICLE.Script 			= "diablovt60";

VEHICLE.Cost 			= 450000;
VEHICLE.PaintJobCost 	= 11000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/diablovt.mdl', skin = '0', name = 'Orange', color = Color(255, 140, 0)},
						{model = 'models/sickness/diablovt.mdl', skin = '1', name = 'Midnight Purple', color = Color(79, 47, 79)},
						{model = 'models/sickness/diablovt.mdl', skin = '2', name = 'Black', color = Color(0, 0, 0)},
						{model = 'models/sickness/diablovt.mdl', skin = '3', name = 'Dark Green', color = Color(0, 100, 0)},
						{model = 'models/sickness/diablovt.mdl', skin = '5', name = 'White', color = Color(255, 250, 250)},
						{model = 'models/sickness/diablovt.mdl', skin = '6', name = 'Red', color = Color(255, 0, 0)},
						{model = 'models/sickness/diablovt.mdl', skin = '7', name = 'Yellow', color = Color(255, 255, 0)},
						{model = 'models/sickness/diablovt.mdl', skin = '8', name = 'Light Blue', color = Color(30, 144, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(20, 0, 5), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-116.0953, 4.6053, 2.5827);
								Vector(116.3831, 11.0841, 4.8897);
							};
							
VEHICLE.DefaultIceFriction = .2;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! A classic I'd love to paint.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-7.5092, 85, 33), 	Angle(20, 0, 0)};
									{Vector(58.8012, 85, 33), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(57.6773, -111.7434, 39.3989), 	Angle(20, -180, 0)};
									{Vector(-6.2260, -111.6745, 39.2979), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(25, 35, 5)};
									{Vector(25, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/lambo2/v8_turbo_on_loop1.wav";
VEHICLE.SpinoutSound		= "vehicles/lambo2/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);