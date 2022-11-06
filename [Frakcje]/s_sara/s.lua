
local marker = createMarker(-10.869576, -289.401184, 5.429688, "cylinder", 1)

local towingVehicles = {
    {-2, -301.2, 5.5}, 
    {-2, -308.2, 5.5},
    {-2, -315.1, 5.5},
    {-2, -322.2, 5.5},
    {-2, -329.3, 5.5},
    {-2, -336.4, 5.5}
}


function createVehicles(resource)
    if resource == getThisResource() then
        for i = 1, #towingVehicles do
            local x,y,z = unpack(towingVehicles[i])
            towCar = createVehicle(525, x,y,z-0.2, 0, 0, -270)
            setVehicleColor(towCar, 255,255,0)
            --setElementFrozen(towCar, true)
            setVehiclePlateText(towCar, "SARA "..i)
            setElementData(towCar, "sara.vehicle", true)
        end
    end
end
addEventHandler("onResourceStart", root, createVehicles)

function allowEnter(enteringPed, seat)
    if getElementData(source, "sara.vehicle") == true then
        if getElementData(enteringPed, "sara.duty") == false and seat == 0 then
            cancelEvent()
        end
    end
end
addEventHandler("onVehicleStartEnter", root, allowEnter)


function startJob(markerHit,matchingDimension)
    if markerHit == marker then
        if getElementData(source, "player.faction") ~= "sara" then return end
        if getElementData(source, "sara.duty") == false then
            triggerClientEvent(source, "sendAlert", source, "Wszedłeś/aś na służbę.", 400)
            setElementData(source, "sara.duty", true)
            setElementModel(source, 260)
        else
            removeElementData(source, "sara.duty")
            setElementModel(source, getElementData(source, "player.skin"))
        end
    end
end
addEventHandler("onPlayerMarkerHit", root, startJob)

