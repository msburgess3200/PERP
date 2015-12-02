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

VEHICLE.ID 				= 'w';

VEHICLE.Name 			= "Ambulance";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Crown Royal";

VEHICLE.Script 			= "ambulance";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;

VEHICLE.DF				= false;

VEHICLE.CustomBodyGroup = nil;

VEHICLE.PaintJobs = {
						{model = 'models/sickness/meatwagon.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	{
								{Vector(17.6582, -55.8569, 35), Angle(0, 0, 0)},
							};
	
VEHICLE.ExitPoints 		=	{
								Vector(-104.3399, 70.0193, 0.2515),
								Vector(91.520, 59.9409, 0.3834),
							};
							
VEHICLE.DefaultIceFriction = 1.5;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = nil;
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= TEAM_MEDIC;

VEHICLE.PaintText = "";

VEHICLE.HornNoise 			= 	"PERP2.5/firetruck_horn.mp3";
VEHICLE.HeadlightPositions 	= 	{
									{Vector(-30.1119, 115, 42.7482), 	Angle(20, 0, 0)};
									{Vector(30.1119, 115, 42.7482), 	Angle(20, 0, 0)};
								};

VEHICLE.TaillightPositions 	= 	{
									{Vector(-41.6259, -145.0381, 26.2781), 	Angle(20, -180, 0)};
									{Vector(41.6259, -145.0381, 26.2781), 	Angle(20, -180, 0)};
								};
VEHICLE.UnderglowPositions  =	{
								};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;

VEHICLE.SirenNoise = Sound("PERP2.5/ambulance_siren.mp3");
VEHICLE.SirenNoise_Alt = nil
VEHICLE.SirenColors = 	{
							{Color(255, 0, 0, 255), Vector(15.5842, 55.6891, 80.7181)},
							{Color(255, 0, 0, 255), Vector(-15.5842, 55.6891, 80.7181)},
						};

GM:RegisterVehicle(VEHICLE);