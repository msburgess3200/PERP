/////////////////////////////////////////
// © 2011-2012 CGC-GAMING              //
//    All rights reserved    		   //
/////////////////////////////////////////
// This material may not be  		   //
//   reproduced, displayed,  		   //
//  modified or distributed  		   //
// without the express prior 		   //
// written permission of the 		   //
//   the copyright holder.  		   //
//		                  			   //
/////////////////////////////////////////


VEHICLE 				= {};

VEHICLE.ID 				= '3001';

VEHICLE.Name 			= "UnderCover Charger";
VEHICLE.Make 			= "Dodge";
VEHICLE.Model 			= "Dodge Charger";

VEHICLE.Script 			= "buffalo2";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
									{model = 'models/sickness/buffalodr.mdl', skin = '0', name = 'Black', color = Color(0, 0, 0, 255)},
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

VEHICLE.RequiredClass 	= TEAM_AGENT;

VEHICLE.HornNoise 			= 	Sound("PERP2.5/siren_short.mp3");
VEHICLE.HeadlightPositions 	= 	{
									{Vector(32.7764, 105.9195, 40.4165), 	Angle(20, 0, 0)};
									{Vector(-32.7764, 105.9195, 40.4165), 	Angle(20, 0, 0)};
								};
VEHICLE.TaillightPositions 	= 	{
									{Vector(-33.1593, -111.6055, 41.7291), 	Angle(20, -180, 0)};
									{Vector(33.1593, -111.6055, 41.7291), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
								};
								
VEHICLE.RevvingSound		= "vehicles/caterham/rev_short_loop.wav";
VEHICLE.SpinoutSound		= "vehicles/golf/skid_highfriction.wav";

VEHICLE.SirenNoise = Sound("PERP2.5/siren_long.mp3");
VEHICLE.SirenNoise_Alt = Sound("PERP2.5/siren_wail.mp3");

VEHICLE.SirenColors = 	{
							{Color(0, 0, 255, 255), Vector(19.91, 113.58, 33.2)},
							{Color(0, 0, 255, 255), Vector(-25.11, -75.12, 56.5)},
							{Color(255, 0, 0, 255), Vector(-19.91, 113.58, 33.2)},
							{Color(255, 0, 0, 255), Vector(25.11, -75.12, 56.5)},
						};

						
GM:RegisterVehicle(VEHICLE);