addEvent("serverTrashCollect", true)

local cubes = {
    sphere1 = createColSphere(-200.982513, 109.914772, 2.915953, 2),
    sphere2 = createColSphere(-193.995453, 105.354340, 3.053013, 2),
    sphere3 = createColSphere(-186.771576, 100.639374, 3.117188, 2)
}

local vehicles = {}

addEventHandler("serverTrashCollect", root, function()
    local plr = source

    for key, sphere in pairs(cubes) do
        local e = getElementsWithinColShape(sphere)
        if #e == 0 then
            local x,y,z = getElementPosition(sphere)
            trashVeh = createVehicle(408, x,y,z)
            setElementData(plr, "trashVeh.owner", trashVeh)
            table.insert(vehicles, #vehicles+1, trashVeh)
            setVehiclePlateText(trashVeh, "trash"..#vehicles)
            warpPedIntoVehicle(plr, trashVeh)
            triggerClientEvent(plr, "sendAlert", plr, "Rozpoczęto #F5AF48pracę#FFFFFF\nSzukaj pojemników na odpady i je opróżnij\nPamiętaj, aby zbierać odpady #F5AF48jednakowego#FFFFFF materiału", 600)
            triggerClientEvent(plr, "clientTrashCollect", plr)
        return end
    end

end)

addEventHandler("onVehicleStartEnter", root, function(plr, seat)
    local veh = source
    if veh == trashVeh then
        if veh ~= getElementData(plr, "trashVeh.owner") then
            cancelEvent()
        end 
    end
end)