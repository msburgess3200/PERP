

function GM.GetTaxRate_Sales ( ) return GetGlobalInt("tax_sales", 0) * 0.01 end
function GM.GetTaxRate_Income ( ) return GetGlobalInt("tax_income", 0) * 0.01 end
function GM.GetTaxRate_Income_Text ( ) return GetGlobalInt("tax_income", 0) .. "%" end
function GM.GetTaxRate_Sales_Text ( ) return GetGlobalInt("tax_sales", 0) .. "%" end

if SERVER then

	function GM.GiveCityMoney ( amount )
		GAMEMODE.CityBudget = GAMEMODE.CityBudget + amount
		GAMEMODE.CityBudget_LastIncome = GAMEMODE.CityBudget_LastIncome + amount
	end	
	
	function GiveFederalFunding()
		local numemployees = 0
		for k,v in pairs(player.GetAll()) do
			if v:Team() != TEAM_CITIZEN then
				numemployees = numemployees + 1
			end
		end
		
		local AmountToGive = 100 + (10 * numemployees)
		GAMEMODE.GiveCityMoney(AmountToGive)
	end
	timer.Create("FederalFunding", 360, 0, GiveFederalFunding)

	
else

	local function receiveMayorUpdate ( uMsg )
		GAMEMODE.CityBudget = uMsg:ReadLong()
		GAMEMODE.CityBudget_LastIncome = uMsg:ReadShort()
		GAMEMODE.CityBudget_LastExpenses = uMsg:ReadShort()
	end
	usermessage.Hook("perp2_mayor_info", receiveMayorUpdate)

end


