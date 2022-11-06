addEvent("vehTools", true)
local db = exports.s_dbconnect


addEventHandler("vehTools", root, function(el, tool)
    local id = getElementData(el, "vehicle.id")
    if tool == 1 then
        setElementFrozen(el, not isElementFrozen(el))
        if isElementFrozen(el) == true then
            outputChatBox("Zaciągnięto ręczny", source)
        else
            outputChatBox("Spuczono ręczny", source)
        end
    elseif tool == 2 then
        fixVehicle(el)
        outputChatBox("Naprawiono pojazd", source)
    elseif tool == 3 then
        local x,y,z = getElementPosition(source)
        setElementPosition(el, x,y,z)
        setElementPosition(source, x,y,z+1.5)
    elseif tool == 4 then
        local id = getElementData(el, "vehicle.vid")
        if(id)then
            local lightL = getVehicleLightState(el, 0)
            local lightR = getVehicleLightState(el, 1)
            local windshield = getVehiclePanelState (el, 4)
            local frontBump = getVehiclePanelState (el, 5)
            local rearBump = getVehiclePanelState (el, 6)
            local hood = getVehicleDoorState(el, 0)
            local trunk = getVehicleDoorState(el, 1)
            local flDoor = getVehicleDoorState(el, 2)
            local frDoor = getVehicleDoorState(el, 3)
            local rlDoor = getVehicleDoorState(el, 4)
            local rrDoor = getVehicleDoorState(el, 5)

            local damage = {
                ["lightL"] = lightL,
                ["lightR"] = lightR,
                ["windshield"] = windshield,
                ["frontBump"] = frontBump,
                ["rearBump"] = rearBump,
                ["hood"] = hood,
                ["trunk"] = trunk,
                ["flDoor"] = flDoor,
                ["frDoor"] = frDoor,
                ["rlDoor"] = rlDoor,
                ["rrDoor"] = rrDoor
            }

            db:insert("UPDATE vehicles SET damage=? WHERE vid=?", toJSON(damage), id)
            db:insert("UPDATE vehicles SET mileage=? WHERE vid=?", getElementData(el, "vehicle.mileage"), id)
            db:insert("UPDATE vehicles SET przecho=1 WHERE vid=?", id)
            destroyElement(el)
        end
    elseif tool == 5 then
        warpPedIntoVehicle(source, el, 0)
    end
end)