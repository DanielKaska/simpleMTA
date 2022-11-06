local marker = createMarker(-59.552864, 83.248711, 2.2, "cylinder", 1.5, 255,255,255,0)
createBlip(-59.552864, 83.248711, 3.117188, 7)
setElementData(marker, "marker_job", true)

local cuboid = createColSphere(-72.200722, 2.183414, 3.117188, 150)
addEvent("endHayDelivery", true)


spawn = createColSphere(-87.683365, 111.682961, 3.117188, 2)
spawn2 = createColSphere(-90.799355, 104.226250, 3.117188, 2)
spawn3 = createColSphere(-94.147484, 93.961166, 3.117188, 2)
spawn4 = createColSphere(-98.251228, 81.565384, 3.117188, 2)


addEventHandler("endHayDelivery", root, function(bool)
    removeElementData(source, "player.working")
    removeElementData(source, "hayLoading")
    removeElementData(source, "hay")
    triggerClientEvent(source, "endHayLoading", source)
    destroyElement(getElementData(source, "wheatDeliverVehicle"))
end)

addEventHandler("onColShapeLeave", root, function(el, md)
    if source == cuboid then
        if getElementType(el) == "player" then 
            if getElementData(el, "player.working") == "hayCarrier" then
                removeElementData(el, "player.working")
                triggerClientEvent(el, "endHayCarrying", source)
                removeElementData(el, "shed_marker")
                removeElementData(el, "hayCarry")
                removeElementData(el, "hay")
                removeElementData(el, "shed_marker") 
            end
        end
    end
end)

addEvent("spawnWheatCar", true)

addEventHandler("onPlayerMarkerHit", root, function(m, dim)
    if m == marker and dim == true then
        if isPedInVehicle(source) == true then return end
        if getElementData(source, "player.working") == "hayCarrier" then 
            removeElementData(source, "player.working")
            triggerClientEvent(source, "endHayCarrying", source)
            removeElementData(source, "shed_marker")
            removeElementData(source, "hayCarry")
            removeElementData(source, "hay")
            removeElementData(source, "shed_marker")
        elseif getElementData(source, "player.working") == "hayDelivery" then 
            removeElementData(source, "player.working")
            removeElementData(source, "hayLoading")
            removeElementData(source, "hay")
            triggerClientEvent(source, "endHayLoading", source)
            destroyElement(getElementData(source, "wheatDeliverVehicle"))
        return end
        triggerClientEvent(source, "triggerFarmGUI", source)
    end
end)

addEventHandler("onPlayerMarkerLeave", root, function(m, dim)
    if m == marker and dim == true then
        triggerClientEvent(source, "destroyFarmGUI", source)
    end
end)

addEventHandler("spawnWheatCar", root, function()
        local check = getElementsWithinColShape(spawn, "vehicle")

        if next(check) == nil then
            car = createVehicle(440, -87.683365, 111.682961, 3.117188, 0, 0, 336)
        else
            local check2 = getElementsWithinColShape(spawn2, "vehicle")
            if next(check2) == nil then
                car = createVehicle(440, -90.799355, 104.226250, 3.117188, 0, 0, 336)
        else
            local check3 = getElementsWithinColShape(spawn3, "vehicle")
            if next(check3) == nil then
                
        else 
            outputChatBox("#F4A603⚠️ #FFFFFFPoczekaj na wolne miejsce wydawania pojazdów!", source, 255,255,255, true)
            car = createVehicle(440, -104.147484, 93.961166, 3.117188, 0, 0, 336)
        end 
        end
    end
    setElementData(source, "wheatDeliverVehicle", car)
    warpPedIntoVehicle(source, car, 0)
end)

function checkOwner(plr)
    if source == car then
        if source ~= getElementData(plr, "wheatDeliverVehicle") then
            cancelEvent()
        end

        if getElementData(plr, "hayLoading") == true then
            cancelEvent()
        end
    end
end
addEventHandler("onVehicleStartEnter", root, checkOwner)

addEventHandler("onPlayerQuit", root, function()
    local veh = getElementData(source, "wheatDeliverVehicle")
    if isElement(veh) then 
        destroyElement(veh)
    end
end)