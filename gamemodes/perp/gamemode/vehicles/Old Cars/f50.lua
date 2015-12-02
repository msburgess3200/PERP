///////////////////////////////
// This material may not be  //
//   reproduced, displayed,  //
//  modified or distributed  //
// without the express prior //
// written permission of the //
//   the copyright holder.   //
///////////////////////////////


VEHICLE 				= {}; 

VEHICLE.ID 				= 'G'; 
VEHICLE.FID				= '37';

VEHICLE.Name 			= "F50"; 
VEHICLE.Make 			= "Ferrari";
VEHICLE.Model 			= "Ferrari F50"; 

VEHICLE.Script 			= "f50"; 

VEHICLE.Cost 			= 1200000; 
VEHICLE.PaintJobCost 	= 15000;

VEHICLE.DF				= true; 

VEHICLE.CustomBodyGroup = nil; 

VEHICLE.PaintJobs = {
									{model = 'models/sickness/f50.mdl', skin = '0', name = 'Red', color = Color(255, 0, 0, 0)},
									{model = 'models/sickness/f50.mdl', skin = '1', name = 'Metallic Grey', color = Color(196, 196, 196)},
									{model = 'models/sickness/f50.mdl', skin = '2', name = 'Black', color = Color(0, 0, 0)},
									{model = 'models/sickness/f50.mdl', skin = '4', name = 'Yellow', color = Color(255, 255, 0)},									
					};
					
VEHICLE.PassengerSeats 	=	{
								
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

VEHICLE.PaintText = "Wow! I haven't painted one of these in years. What a beauty."; 

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