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

VEHICLE.ID 				= 'm';
VEHICLE.FID				= '13';

VEHICLE.Name 			= "Shelby";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Shelby Mustang";

VEHICLE.Script 			= "shelby";

VEHICLE.Cost 			= 105000;
VEHICLE.PaintJobCost 	= 6500;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = 511;

VEHICLE.PaintJobs = {
						{model = 'models/shelby/shelby.mdl', skin = '0', name = 'White', color = Color(248, 251, 232, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '1', name = 'Red', color = Color(205, 0, 0, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '2', name = 'Blue', color = Color(0, 9, 123, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '3', name = 'Silver', color = Color(125, 128, 125, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '4', name = 'Orange', color = Color(235, 100, 32, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '5', name = 'Sky Blue', color = Color(0, 188, 235, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '6', name = 'Green', color = Color(0, 88, 36, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '7', name = 'Black', color = Color(0, 0, 0, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '8', name = 'Brown', color = Color(136, 97, 53, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '9', name = 'Purple', color = Color(67, 12, 96, 255)},
						{model = 'models/shelby/shelby.mdl', skin = '10', name = 'Pink', color = Color(255, 0, 234, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(16, 4, 13), Angle(0, 0, 10)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-72.3996, -6.1857, 1.8621),
								Vector(72.3996, -0.1439, 0.3239),
							};
							
VEHICLE.DefaultIceFriction = .5;
							
VEHICLE.PlayerReposition_Pos = Vector(-16, -15, 18);
VEHICLE.PlayerReposition_Ang = Angle(0, 90, 0);

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 5);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Of course! The great American classic.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-31.4999, 98.5857, 31.4159), 	Angle(20, 0, 0)};
									{Vector(31.4999, 98.5857, 31.4159), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(18.6511, -92.8365, 31.6970), 	Angle(20, -180, 0)};
									{Vector(-18.6511, -92.8365, 31.6970), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 5)};
									{Vector(0, -35, 5)};
								};
								
VEHICLE.RevvingSound		= "vehicles/shelby/shelby_rev_short_loop1.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);