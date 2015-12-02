


local SHOP = {};

SHOP.ID 				= 2;
SHOP.NPCAssociation 	= 17;
SHOP.Name				= "Ace Hardware";

SHOP.Items = {	
					'item_wrench',
					'item_paint',
					'item_metal_rod',
					'item_board',
					'item_paint_thinner',
					'item_metal_polish',
					'item_drain_cleaner',
					'item_chunk_plastic',
					'item_chunk_metal',
					'item_cardboard',
					'item_cinder_block',
					'item_propane_tank',
					'item_lodine',
					"furniture_lamp_spot",
					"item_glue",
					"item_nail",
					"furniture_saw_horse",
					"item_fuelcan",
					'item_chip',
					'item_car_lock',
				};
				
GM:RegisterShop(SHOP);