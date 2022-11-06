addEvent("getDataSAPD", true)
local db = exports.s_dbconnect
local idSys = exports.s_core
local marker = createMarker(638.468811, -585.710388, 16.187500, "cylinder", 1)
local blip = createBlip(619.429565, -585.729858, 17.233013, 30)

local policeCars = {
    {613.977356, -610, 17.226562}, 
    {613.541992, -605.9, 17.233013}
}

function createVehicles(resource)
    if resource == getThisResource() then
        for i = 1, #policeCars do
            local x,y,z = unpack(policeCars[i])
            policeCar = createVehicle(426, x,y,z-0.2, 0, 0, 270)
            setVehicleColor(policeCar, 16,16,16, 255,255,255)
            addVehicleUpgrade(policeCar, 1025)
            --setElementFrozen(policeCar, true)
            setVehiclePlateText(policeCar, "SAPD "..i)
            setElementData(policeCar, "sapd.vehicle", true)
            addVehicleSirens(policeCar, 2, 2)
            setVehicleSirens(policeCar, 1, -0.3, 0, 0.85, 0, 0, 255, 255, 255)
            setVehicleSirens(policeCar, 2, 0.3, 0, 0.85, 255, 0, 0, 255, 255)
            setVehicleHandling(policeCar, "numberOfGears", 3)
            setVehicleHandling(policeCar, "mass", 1400)
            setVehicleHandling(policeCar, "tractionMultiplier", 0.8)
            setVehicleHandling(policeCar, "engineAcceleration", 18)
            setVehicleHandling(policeCar, "steeringLock", 50)
            setVehicleHandling(policeCar, "driveType", "awd")
            setVehicleHandling(policeCar, "maxVelocity", 240)
            setVehicleHandling(policeCar, "engineInertia", 40)
            setVehicleHandling(policeCar, "suspensionDamping", 0)
            setVehicleHandling(policeCar, "suspensionHighSpeedDamping", 0)
        end
    end
end
addEventHandler("onResourceStart", root, createVehicles)

function allowEnter(enteringPed, seat)
    if getElementData(source, "sapd.vehicle") == true then
        if getElementData(enteringPed, "sapd.duty") == false and seat == 0 then
            cancelEvent()
        end
    end
end
addEventHandler("onVehicleStartEnter", root, allowEnter)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function startJob(markerHit,matchingDimension)
    if markerHit == marker then
        if getElementData(source, "player.faction") ~= "sapd" then return end
        if getElementData(source, "sapd.duty") == false then
            triggerClientEvent(source, "sendAlert", source, "Wszedłeś/aś na służbę.", 200)
            setElementData(source, "sapd.duty", true)
            --setElementModel(source, 260)
        else
            takeWeapon(source, 3)
            removeElementData(source, "sapd.duty")
            setElementModel(source, getElementData(source, "player.skin"))
            triggerClientEvent(source, "sendAlert", source, "Zszedłeś/aś ze służby.", 200)
        end
    end
end
addEventHandler("onPlayerMarkerHit", root, startJob)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------system komputera i poszykiwanych-------------------------------------------------------------------------------------
function data(dataType, id)
    if dataType == "gracz" then
        local plr = idSys:findPlayer(plr, id)
        if plr == false then
            outputChatBox("* Nie znaleziono podanego gracza.", source)    
        return end
        local nick = getElementData(plr, "player.nickname")
        local uid = getElementData(plr, "player.uid")
        local mandaty = db:get("select * from tickets where punished_uid=?", uid)
        local suma_pkt = db:get("select SUM(points) from tickets where punished_uid=?", uid)
        local sum_mandat = db:get("select SUM(ammount) from tickets where punished_uid=?", uid)
        local poszukiwany = db:get("select poszukiwany from players where uid=?", uid)
        local suma_mandatow = sum_mandat[1]['SUM(ammount)']
        local jest_poszukiwany = poszukiwany[1]['poszukiwany']
        local suma_punktow_karnych = suma_pkt[1]['SUM(points)']
        outputChatBox("------------------------------------------------", source)
        outputChatBox("| Nick obywatela: "..nick, source)
        outputChatBox("| UID obywatela: "..uid, source)
        outputChatBox("| Nieopłacone mandaty: "..#mandaty..", $"..suma_mandatow, source)
        outputChatBox("| Punkty karne: "..suma_punktow_karnych, source)
        outputChatBox("| Czy jest poszukiwany : "..jest_poszukiwany, source)
        outputChatBox("------------------------------------------------", source)
    elseif dataType == "pojazd" then
        local veh = getElementByID("vehicle"..id)
        if veh == false then
            outputChatBox("* Podano nieparidłowe ID pojazdu, lub znajduje się on w przechowalni.", source)    
        return end
        local owner = getElementData(veh, "vehicle.owner")
        local nick = getElementData(veh, "vehicle.owner_nick")
        local mileage = getElementData(veh, "vehicle.mileage")
        outputChatBox("------------------------------------------------", source)
        outputChatBox("| Nick właściciela: "..nick, source)
        outputChatBox("| UID właściciela: "..owner, source)
        outputChatBox("| Przebieg: "..mileage.." km", source)
        outputChatBox("------------------------------------------------", source)
    end
end
addEventHandler("getDataSAPD", root, data)

addCommandHandler("poszukiwany", function(plr, command, uid, is)
    if getElementData(plr, "sapd.duty") ~= true then return end
    if uid == nil then
        outputChatBox("* Podaj UID.", plr)
    return end
    local id = tonumber(uid)
    if id == nil then
        outputChatBox("* UID musi być liczbą.", plr)
    return end
    if is == nil then
        outputChatBox("Prawidłowe użycie: /poszukiwany uid tak/nie", plr)
    return end
    if #is > 4 then
        outputChatBox("* Nie za dużo tych znaków?", plr)
    return end
    if id < 1 then return end
    db:insert("update players set poszukiwany=? where uid =?", is, id)
    if is == "tak" then
        outputChatBox("* Gracz uid "..id.." jest teraz poszukiwany.", plr)
    elseif is == "nie" then
        outputChatBox("* Gracz uid "..id.." nie jest już poszukiwany.", plr)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------system kajdanek-------------------------------------------------------------------------------------------------------------

addCommandHandler("zakuj", function(plr, command, id)
    if getElementData(plr, "sapd.duty") ~= true then return end
    if getElementData(plr, "zakuty") ~= false then return end
    if id == nil then
        outputChatBox("Podaj id lub nick", plr)    
    return end
    local target = idSys:findPlayer(plr, id)
    if target == plr then outputChatBox("Chcesz zakuć samego siebie?", plr) return end

    local x,y,z = getElementPosition(plr)
    local range = getElementsWithinRange(x,y,z, 3, "player")
    for k,v in pairs(range) do
        if v == target then

            if isPedInVehicle(target) then
                removePedFromVehicle(target)
            end

            toggleAllControls(target, false)
            toggleControl(target, "chatbox", true)
            attachElements(target, plr, 0, 0.5)
            outputChatBox("* Jesteś zakuty/a", target)
            setElementData(plr, "zakuty", target)
            triggerClientEvent(target, "onPlayerHandcuffed", target)

            bindKey(plr, "x", "down", function()
                local x,y,z = getElementPosition(plr)
                local car = getElementsWithinRange(x,y,z, 2, "vehicle")
                local veh = car[1]
                if veh == nil then return end
                detachElements(target, plr)
                local seats = getVehicleOccupants(veh)
                if seats[2] == nil then
                    warpPedIntoVehicle(target, veh, 2)
                elseif seats[3] == nil then
                    warpPedIntoVehicle(target, veh, 3)
                end
                toggleControl(target, "chatbox", true)
                setPedAnimation(plr)
                removeElementData(plr, "zakuty")
                unbindKey(plr, "x")
            end)
        end
    end
end)

addCommandHandler("odkuj", function(plr)
    if getElementData(plr, "sapd.duty") ~= true then return end
    local target = getElementData(plr, "zakuty")
    if isElement(target) then
        toggleControl(target, "chatbox", true)
        setPedAnimation(plr)
        toggleAllControls(target, true)
        detachElements(target, plr)
        removeElementData(plr, "zakuty")
        outputChatBox("* Jesteś odkuty/a", target)
        triggerClientEvent(target, "onPlayerUnHandcuffed", target)
        unbindKey(plr, "x")
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------