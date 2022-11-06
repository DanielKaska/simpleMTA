local marker = createMarker(1366.261963, 248.843002, 18.6, "cylinder", 1.2, 255,255,255,0)
local marker2 = createMarker(203.520706, -203.282013, 0.65, "cylinder", 1.2, 255,255,255,0)

setElementData(marker, "marker_job", true)
setElementData(marker2, "marker_job", true)
addEvent("endj", true)
addEvent("endj2", true)
addEvent("startJ", true)
addEvent("startJobBlista", true)


createBlip(207.777496, -198.362488, 7.578125, 29, 1)

spawn = createColSphere(1391.687134, 264.946899, 19.566933, 2)
spawn2 = createColSphere(1386.947876, 266.867096, 19.566933, 2)
spawn3 = createColSphere(1382.813110, 268.723724, 19.566933, 2)
spawn4 = createColSphere(1378.329590, 270.732544, 19.566933, 2)

function startJob(markerHit, dim)
    if markerHit == marker or marker2 and dim == true then
    local plr = source
    if isPedInVehicle(plr) == true then return end
        if getElementData(plr, "player.working") == "scooter" then
            triggerClientEvent(plr, "sendAlert", plr, "Kończysz pracę.", 150)
            triggerClientEvent(plr, "endJob", plr, plr)
            removeElementData(plr, "marker")
            removeElementData(plr, "blip")
            removeElementData(plr, "refillMarker")
            local v = getElementData(plr, "owner")
            removeElementData(plr, "owner")
            removeElementData(plr, "player.working")
            destroyElement(v)
            
        elseif getElementData(plr, "player.working") == "blista" then
            if getElementData(plr, "carrying") == true then return end
            triggerClientEvent(plr, "sendAlert", plr, "Kończysz pracę.", 150)
            triggerClientEvent(plr, "endJob2", plr, plr)
            removeElementData(plr, "marker")
            removeElementData(plr, "blip")
            removeElementData(plr, "refillMarker")
            removeElementData(plr, "carrying")
            local v = getElementData(plr, "owner")
            local obj = getElementData(v, "object")
            local obj2 = getElementData(v, "object2")
            local takeMarker = getElementData(v, "takeMarker")
            removeElementData(plr, "player.working")
            removeElementData(v, "object")
            removeElementData(v, "object2")
            removeElementData(plr, "owner")
            destroyElement(v)
            destroyElement(obj)
            destroyElement(obj2)
        else
            if getElementData(plr, "player.working") == true then return end
            if isPedInVehicle(plr) == true then
                triggerClientEvent(plr, "sendAlert", plr, "Wyjdź z pojazdu, aby rozpocząć pracę.", 150)
            else
                if markerHit == marker then
                    triggerClientEvent(plr, "startJob", plr, plr)
                else 
                if markerHit == marker2 then
                    triggerClientEvent(plr, "startJobScooter", plr, plr)
                end
                end
            end

        end
    end
end
addEventHandler("onPlayerMarkerHit", root, startJob)

function markerLeave(leaveElement, matchingDimension)
	local elementType = getElementType(leaveElement)
    if matchingDimension then
        if elementType == "player" then
            triggerClientEvent(leaveElement, "destroyDrawing", leaveElement)
        end
    end
end
addEventHandler("onMarkerLeave", marker, markerLeave)

function markerLeaveScooter(leaveElement, matchingDimension)
	local elementType = getElementType(leaveElement)
    if matchingDimension then
        if elementType == "player" then
            triggerClientEvent(leaveElement, "destroyDrawingScooter", leaveElement)
        end
    end
end
addEventHandler("onMarkerLeave", marker2, markerLeaveScooter)

function startJob_scooter_serverside(plr)
    triggerClientEvent(plr, "sendAlert", plr, "Zaczynasz pracę.", 150)
    setElementData(plr, "player.working", "scooter")
    outputChatBox("#89CFF0ℹ️ #FFFFFFUdaj się do punktów na mapie, aby dostarczyć zamówienia.", plr, 255,255,255, true)
    outputChatBox("#F4A603⚠️ #FFFFFFPamiętaj, że zarówno stan zamówienia jak i czas dostarczenia wpływa na wypłatę.", plr, 255,255,255, true)
    local veh = createVehicle(448, 204.096680, -206.271042, 1.578125, 0, 0, 356)
    setVehiclePlateText(veh, "K1 PIZZA")
    setElementData(plr, "owner", veh)
    warpPedIntoVehicle(plr, veh)
    triggerClientEvent(plr, "startScooterJob", plr,  getElementData(plr, "owner"))
end
addEventHandler("startJ", root, startJob_scooter_serverside)




function startJob_blista_serverside(plr)
    setElementData(plr, "player.working", "blista")
    --outputChatBox("#89CFF0ℹ️ #FFFFFFUdaj się do punktów na mapie, aby dostarczyć zamówienia.", plr, 255,255,255, true)
    --outputChatBox("#F4A603⚠️ #FFFFFFPamiętaj, że zarówno stan zamówienia jak i czas dostarczenia wpływa na wypłatę.", plr, 255,255,255, true)
    
        local check = getElementsWithinColShape(spawn, "vehicle")

        if next(check) == nil then
            blista = createVehicle(496, 1392.151489, 263.950623, 19.165884, 0, 0, 336)
        else
            local check2 = getElementsWithinColShape(spawn2, "vehicle")
            if next(check2) == nil then
                blista = createVehicle(496, 1386.947876, 266.867096, 19.566933, 0, 0, 336)
        else
            local check3 = getElementsWithinColShape(spawn3, "vehicle")
            if next(check3) == nil then
                blista = createVehicle(496, 1382.813110, 268.723724, 19.566933, 0, 0, 336)
        else 
            outputChatBox("#F4A603⚠️ #FFFFFFPoczekaj na wolne miejsce wydawania pojazdów!", plr, 255,255,255, true)
            return end
        end
    end
    setVehicleHandling(blista, "maxVelocity", 140)
    setVehicleColor(blista, 255,255,255, 255,0,0)
    setVehiclePlateText(blista, "K1 PIZZA")
    setElementData(plr, "owner", blista)
    warpPedIntoVehicle(plr, blista)
    local el = createObject(1910, 0,0,0)
    local el2 = createObject(1910, 0,0,0)
    setObjectScale(el, 0.1, 0.8, 1.1)
    setObjectScale(el2, 0.1, 0.8, 1.1)
    setElementData(blista, "object", el)
    setElementData(blista, "object2", el2)
    attachElements(el, blista, -0.1, -0.4, 0.8, 0, 10)
    attachElements(el2, blista, 0.1, -0.4, 0.8, 0, -10)
    triggerClientEvent(plr, "startBlistaJob", plr,  getElementData(plr, "owner"))

    function checkOwner(plr)
        if source == blista then
            if source ~= getElementData(plr, "owner") then
                cancelEvent()
            end
        end
    end
    addEventHandler("onVehicleStartEnter", root, checkOwner)

end
addEventHandler("startJobBlista", root, startJob_blista_serverside)

function endj(plr)
    local v = getElementData(plr, "owner")
    if v then
        destroyElement(v)
    end
    removeElementData(plr, "marker")
    removeElementData(plr, "blip")
    removeElementData(plr, "refillMarker")
    removeElementData(plr, "player.working")
end
addEventHandler("endj", root, endj)

function q()
    if getElementData(source, "player.working") == "blista" then
        endj2(source)
    elseif getElementData(source, "player.working") == "scooter" then 
        endj(source)
    end
end
addEventHandler("onPlayerQuit", root, q)

function endj2(plr)
    triggerClientEvent(plr, "sendAlert", plr, "Kończysz pracę.", 150)
    removeElementData(plr, "marker")
    removeElementData(plr, "blip")
    removeElementData(plr, "refillMarker")
    removeElementData(plr, "carrying")
    local v = getElementData(plr, "owner")
    local obj = getElementData(v, "object")
    local obj2 = getElementData(v, "object2")
    local takeMarker = getElementData(v, "takeMarker")
    removeElementData(plr, "player.working")
    removeElementData(v, "object")
    removeElementData(v, "object2")
    removeElementData(plr, "owner")
    destroyElement(v)
    destroyElement(obj)
    destroyElement(obj2)
end
addEventHandler("endj2", root, endj2)