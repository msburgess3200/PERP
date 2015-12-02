


INVALID_RP_NAMES = {};

function GM.GatherInvalidNames ( )
	/*
	http.Get(URL_INVALID_RP_NAMES, "", function ( results )
		for k, v in pairs(string.Explode("\n", string.lower(results))) do
			table.insert(INVALID_RP_NAMES, string.Explode(" ", string.Trim(v)));
		end
	end);
	*/
end

function GM.IsValidPartialName ( name )
	if (string.len(name) < 3) then return false; end
	if (string.len(name) >= 16) then return false; end
	
	local name = string.lower(name);
	
	local numDashes = 0;
	for i = 1, string.len(name) do
		local validLetter = false;
		local curChar = string.sub(name, i, i);
		
		if (curChar == "-") then
			numDashes = numDashes + 1;
			
			if (numDashes > 1) then
				return false;
			end
		end
		
		for k, v in pairs(VALID_NAME_CHARACTERS) do
			if (curChar == v) then
				validLetter = true;
				break;
			end
		end
		
		if (!validLetter) then
			Msg("bad char")
			return false;
		end
	end

	/*
	for k, v in pairs(INVALID_RP_NAMES) do
		if (#v == 1) then
			if (string.sub(v[1], 0, 1) == "^") then
				if (string.sub(name, 0, string.len(v[1]) - 1) == string.sub(v[1], 2)) then
					return false;
				end
			elseif (string.find(name, v[1])) then
				return false;
			end
		end
	end
	*/
	
	return true;
end

function GM.IsValidName ( first, last, skipFirstLast )
	local first = string.lower(first);
	local last = string.lower(last);

	if (!skipFirstLast) then
		if (!GAMEMODE.IsValidPartialName(first)) then return false; end
		if (!GAMEMODE.IsValidPartialName(last)) then return false; end
	end
	
	if (first == "john" && last == "doe") then return false end
	
	/*
	for k, v in pairs(INVALID_RP_NAMES) do
		if (#v > 1) then
			if (first == v[1] && last == v[2]) then
				return false;
			end
		end
	end
	*/
	
	return true;
end

