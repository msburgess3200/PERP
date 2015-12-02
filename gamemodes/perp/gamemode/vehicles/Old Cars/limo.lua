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

VEHICLE.ID 				= 'J';
VEHICLE.FID				= '40';

VEHICLE.Name 			= "Stretch Limo";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Crown Royal";

VEHICLE.Script 			= "limo";

VEHICLE.Cost 			= 200000;
VEHICLE.PaintJobCost 	= 10000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/stretchdr.mdl', skin = '0', name = '', color = Color(240, 249, 240, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '1', name = 'Black', color = Color(0, 0, 0, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '2', name = 'Silver', color = Color(155, 161, 155, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '3', name = 'White', color = Color(240, 249, 240, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '4', name = 'Green', color = Color(0, 121, 0, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '5', name = 'Blue', color = Color(0, 0, 240, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '6', name = 'Gray', color = Color(125, 127, 125, 255)},
						{model = 'models/sickness/stretchdr.mdl', skin = '8', name = 'Yellow', color = Color(240, 249, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(22.9451, -47.7737, 10.6397), Angle(0, 0, 5)},
								{Vector(23.8519, 114.6827, 14.9151), Angle(0, 0, 5)},
								{Vector(-23.8519, 114.6827, 14.9151), Angle(0, 0, 5)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-90.6435, 65.5650, 2.1304),
								Vector(90.6435, 65.5650, 2.1304),
								Vector(-92.2684, -109.0656, 1.6255),
								Vector(92.2684, -109.0656, 1.6255),
							};
							
VEHICLE.DefaultIceFriction = 1.5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass = nil;

VEHICLE.PaintText = "Nice streach, whos it for?";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(29.9323, 167.0016, 35.9562), 	Angle(20, 0, 0)};
									{Vector(-29.9323, 167.0016, 35.9562), 	Angle(20, 0, 0)};
								};

VEHICLE.TaillightPositions 	= 	{
									{Vector(-25.4767, -198.0278, 39.2658), 	Angle(20, -180, 0)};
									{Vector(25.4767, -198.0278, 39.2658), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 50, 5)};
									{Vector(0, -50, 5)};
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

GM:RegisterVehicle(VEHICLE);