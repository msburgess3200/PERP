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

VEHICLE.ID 				= '3';
VEHICLE.FID				= '56';

VEHICLE.Name 			= "R8";
VEHICLE.Make 			= "Audi";
VEHICLE.Model 			= "R8";

VEHICLE.Script 			= "r8";

VEHICLE.Cost 			= 480000;
VEHICLE.PaintJobCost 	= 8000;

VEHICLE.DF				= true;

VEHICLE.CustomBodyGroup = 511;

VEHICLE.PaintJobs = {
						{model = 'models/tdmcars/audir8v10.mdl', skin = '0', name = 'White', color = Color(248, 251, 232, 255)},
						{model = 'models/tdmcars/audir8v10.mdl', skin = '1', name = 'Pink', color = Color(255, 0, 246, 255)},
						{model = 'models/tdmcars/audir8v10.mdl', skin = '2', name = 'Black', color = Color(0, 0, 0, 255)},
						{model = 'models/tdmcars/audir8v10.mdl', skin = '3', name = 'Yellow', color = Color(255, 212, 0, 255)},
						{model = 'models/tdmcars/audir8v10.mdl', skin = '4', name = 'Blue', color = Color(0, 59, 255, 255)},
						{model = 'models/tdmcars/audir8v10.mdl', skin = '5', name = 'Sky blue', color = Color(0, 212, 255, 255)},
						{model = 'models/tdmcars/audir8v10.mdl', skin = '8', name = 'Red', color = Color(255, 29, 0, 255)},
						{model = 'models/tdmcars/audir8v10.mdl', skin = '10', name = 'Purple', color = Color(170, 0, 255, 255)},
						//{model = 'models/tdmcars/audir8v10.mdl', skin = '0', name = 'White', color = Color(248, 251, 232, 255)},
					};
/*				
VEHICLE.PassengerSeats 	=	{
								{Vector(25, 10, 15), Angle(0, 0, 20)},
							};
	*/
	
	VEHICLE.PassengerSeats 	=	{
								{Vector(18.92, -6.22, 13.99), Angle(0, 0, 20)},
							};
							
VEHICLE.ExitPoints 		=	{
								Vector(-79.2231, -13.6429, 4.9321),
								Vector(79.2231, -13.6429, 4.9321),
							};
							
VEHICLE.DefaultIceFriction = 1.5;
				
/*		
VEHICLE.PlayerReposition_Pos = Vector(-23, -30, 18);
VEHICLE.PlayerReposition_Ang = Angle(0, 90, 0);
*/

VEHICLE.PlayerReposition_Pos = Vector(-13.29, -6.22, 13.99);
VEHICLE.PlayerReposition_Ang = Angle(0, 90, 0);
/*
VEHICLE.ViewAdjustments_FirstPerson = Vector(-7, 0, -2); */
VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= nil;

VEHICLE.PaintText = "Woah, nice! Ill take my time painting this for you.";

VEHICLE.HornNoise 			= 	NORMAL_HORNS;
/*
VEHICLE.HeadlightPositions 	= 	{
									{Vector(35.9498, 105.3018, 39.5148), 	Angle(20, 0, 0)};
									{Vector(-35.9498, 105.3018, 39.5148), 	Angle(20, 0, 0)};
								};
								*/
								
								VEHICLE.HeadlightPositions 	= 	{
									{Vector(27.23, 89.01, 27.48), 	Angle(20, 0, 0)};
									{Vector(-27.23, 89.01, 27.48), 	Angle(20, 0, 0)};
								};
								/*
								VEHICLE.TaillightPositions 	= 	{
									{Vector(-37.5575, -114.6718, 40.7938), 	Angle(20, -180, 0)};
									{Vector(37.5575, -114.6718, 40.7938), 	Angle(20, -180, 0)};
								};
								*/
VEHICLE.TaillightPositions 	= 	{
									{Vector(-27.75, -90.62, 36.62), 	Angle(20, -180, 0)};
									{Vector(27.75, -90.62, 36.62), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
									{Vector(0, 35, 10)};
									{Vector(0, -35, 10)};
								};
								
VEHICLE.RevvingSound		= "vehicles/lambo/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

GM:RegisterVehicle(VEHICLE);