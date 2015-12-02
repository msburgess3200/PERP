


local SHOP = {};

SHOP.ID 				= 101;
SHOP.NPCAssociation 	= 92;
SHOP.Name				= "Izzys'bar drinks";

SHOP.Items	=	{
					'drug_beer_box_full',
					'drug_beer',
					'drug_cig',
					'food_coffee',
				};
				
GM:RegisterShop(SHOP);