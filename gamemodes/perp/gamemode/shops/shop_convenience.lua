

local SHOP = {};

SHOP.ID 				= 3;
SHOP.NPCAssociation 	= 18;
SHOP.Name				= "Ching's Convenience Store";

SHOP.Items	=	{
					'drug_beer',
					'item_phone',
					'furniture_radio',
					'item_paper_towels',
					'furniture_cone',
					'item_lifealert',
					'item_repair_kit',
					'item_flashlight',
					'drug_bong',
					'item_salt',
					'item_kittylitter',
					'item_waterbottle',
					'weapon_bat',
					//'item_kevlar_vest', --She's FUCKED Jim.
					'item_lawbook',
					'weapon_binoculars',
					'drug_cig',
					'item_coke',
					'item_fuelcan',
					'item_car_lock',
					};
				
GM:RegisterShop(SHOP);