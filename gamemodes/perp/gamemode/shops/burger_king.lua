


local SHOP = {};

SHOP.ID 				= 4;
SHOP.NPCAssociation 	= 20;
SHOP.Name				= "Burger King Shop";

SHOP.Items = {	
					'food_chinese_takeout',
					'food_coffee',
					'food_melon',
					'food_orangejuice',
					'food_milk',
					'food_soda',
				};
				
GM:RegisterShop(SHOP);