setFPSLimit(74)
setGameType("Coming soon")

if getOcclusionsEnabled() then
    setOcclusionsEnabled(false)
end

local parkBb = createWater (177.610580, -111.965897, 1.539062, 190.365143, -111.930153, 1.539062, 177.259247, -103.334351, 1.539062, 190.270309, -103.317024, 1.539062) 
setWaterLevel (parkBb,0.5) 

function findPlayer(plr,cel)
	local target=nil
	if (tonumber(cel) ~= nil) then
		target=getElementByID("p"..cel)
	else -- podano fragment nicku
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 1, true) then
				if (target) then
					outputChatBox("Znaleziono wiecej niz jednego gracza o pasujacym nicku, podaj wiecej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	return target
end

function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

local function findFreeValue(tablica_id)
	table.sort(tablica_id)
	local wolne_id=0
	for i,v in ipairs(tablica_id) do
		if (v==wolne_id) then wolne_id=wolne_id+1 end
		if (v>wolne_id) then return wolne_id end
	end
	return wolne_id
end

function assignPlayerID(plr)
	local gracze=getElementsByType("player")
	local tablica_id = {}
	for i,v in ipairs(gracze) do
		local lid=getElementData(v, "id")
		if (lid) then
			table.insert(tablica_id, tonumber(lid))
		end
	end
	local free_id=findFreeValue(tablica_id)
	
	setElementData(plr,"id", free_id)
	setElementID(plr, "p" .. free_id)
	return free_id
end

function getPlayerID(plr)
	if not plr then return "" end
	local id=getElementData(plr,"id")
	if (id) then
		return id
	else
		return assignPlayerID(plr)
	end
	
end

addEventHandler ("onPlayerJoin", getRootElement(), function()
	assignPlayerID(source)
	local id=getElementData(source,"id")
end)


function onResourceStart ( )
    local players = getElementsByType ( "player" ) -- Store all the players in the server into a table
    for key, player in ipairs ( players ) do       -- for all the players in the table
        setPlayerNametagShowing ( player, false )  -- turn off their nametag
    end
end
addEventHandler ( "onResourceStart", resourceRoot, onResourceStart )

function onPlayerJoin ( )
	setPlayerNametagShowing ( source, false )
end
addEventHandler ( "onPlayerJoin", root, onPlayerJoin )

function jp(playerSource)
	local gracz_id = getElementData(playerSource, "id")
	outputChatBox("Twoje ID: "..gracz_id, playerSource)
end
addCommandHandler("id", jp)

--[[function checkOwner(enteringPed, seat)    
    local owner = getElementData(source, "vehicle.owner")
	local vid = getElementData(source, "vehicle.vid")
    local entering = getElementData(enteringPed, "player.uid")
    local klucze = getElementData(source, "vehicle.klucze")
    if entering == klucze then return end
	if vid == false then return end
    if seat == 0 then
        if entering < owner or entering > owner then
            cancelEvent() 
            outputChatBox("Nie masz kluczy do tego pojazdu!",enteringPed)
        end
    end
end
addEventHandler("onVehicleStartEnter", getRootElement(), checkOwner)]]
------------------------------------------------------------------------------------------------------- undestructible vehicles


function pojazdPusty(veh)
    local occupants = getVehicleOccupants(veh)
    local seats = getVehicleMaxPassengers(veh)
	if (not seats) then return true end
    for i=0,seats do
	local occupant = occupants[seat]
	if occupant and (getElementType(occupant)=="player" or getElementType(occupant)=="ped") then
	    return false
	end
    end
    return true
end


for i,v in ipairs(getElementsByType("vehicle")) do
    if (pojazdPusty(v)) then
        setVehicleDamageProof(v,true)
    else
	if getElementData(v,"damageproof") then setVehicleDamageProof(v, true) return end
	setVehicleDamageProof(v,false)
    end
end

addEventHandler ( "onVehicleEnter", root, function()
	if getElementData(source,"damageproof") then setVehicleDamageProof(source, true) return end
    setVehicleDamageProof(source, false)
end)

addEventHandler ( "onVehicleExit", root, function()
    if (pojazdPusty(source)) then
        setVehicleDamageProof(source, true)
    else
		if getElementData(source,"damageproof") then setVehicleDamageProof(source, true) return end
        setVehicleDamageProof(source, false)
    end
end)

------------------------------------------------------------------------------------------------------- undestructible vehicles


------------------------------------------------------------------------------------------------------- chat
local radius = 20

	local function playerChat(message, messageType)
		if string.find(message, "#F") or string.find(message, "#f") then cancelEvent() return end
		if getElementData(source, "player.logged") ~= true then cancelEvent() return end
		if messageType == 0 then --Global (main) chat
				cancelEvent()
			outputChatBox("#FFFFFF"..getElementData(source, "player.nickname").."#F5AF48 | #FFFFFF"..getElementData(source, "id")..": "..message, root, red, green, blue, true)
		end
	end
	addEventHandler("onPlayerChat", root, playerChat)


	function pmMessages(playerSource, commandName, id, ...)
		local plr = findPlayer(plr, id)

		outputChatBox("#FFFFFF< "..getElementData(plr, "player.nickname")..": "..table.concat({...}, " "), playerSource, 255,255,255, true)
		outputChatBox("#FFFFFF> "..getElementData(playerSource, "player.nickname")..": "..table.concat({...}, " "), plr, 255,255,255, true)

	end
	addCommandHandler("pm", pmMessages)
-------------------------------------------------------------------------------------------------------