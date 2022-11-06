addEvent("vehData", true)
addEvent("createVeh", true)
addEvent("getVeh", true)

local markerBB = createMarker(162.245728, -25.638664, 1, "cylinder", 1.5, 255, 255, 0, 0)
local markerDillimore = createMarker(710.637878, -572.52990, 15.4, "cylinder", 1.5, 245, 175, 72, 30)



setElementData(markerBB, "parking.marker", true)
setElementData(markerDillimore, "parking.marker", true)
setElementData(markerDillimore, "marker", true)

local colBB = createColSphere(157.970535, -22.416811, 1.578125, 3)
local colDillimore = createColSphere(707.389038, -569.383423, 16.335938, 3)

createBlip(166.824890, -18.903473, 1.578125, 3, 1)
createBlip(706.716187, -569.382690, 16.335938, 3)
local db = exports.s_dbconnect

  
function loadVeh(marker,uid)
    if getElementData(marker, "parking.marker") == true then
    iprint(marker)
    location = marker
    local uid = getElementData(source, "player.uid")
    local result = db:get("SELECT * FROM vehicles WHERE owner_uid=? and przecho=1",uid)

    local nrWynikow = #result
    if nrWynikow == 0 then return end
    
    for i=1, nrWynikow do
        local vid = result[i]['vid']
        local veh_id = result[i]['veh_id']
        local owner_uid = result[i]['owner_uid']
        local mileage = result[i]['mileage']
        local ld = result[i]['last_driver']
        triggerClientEvent(source, "getData", source, vid, veh_id, owner_uid, mileage, ld, i)     
    end

    if result and #result > 0 then
        triggerClientEvent(source, "drawGUI", source)
    end
end
end
addEventHandler("onPlayerMarkerHit", getRootElement(), loadVeh)

function createVeh(chosen, plr)
    local q = db:get("select * from vehicles where vid=?", chosen)
    if q[1] == nil then return end
    if q[1]['owner_uid'] == getElementData(plr, "player.uid") then
        triggerClientEvent(plr, "destroyParking", plr)
        local res2 = db:get("SELECT * from vehicles WHERE vid=?", chosen)
        local r = res2[1]['r']
        local g = res2[1]['g']
        local b = res2[1]['b']
        local klucze = res2[1]['klucze']
        local mileage = res2[1]['mileage']
        local veh_id = res2[1]['veh_id']
        if location == markerBB then
            local check = getElementsWithinColShape(colBB, "vehicle")
            if next(check) == nil then
                car = createVehicle(veh_id, 157.970535, -22.416811, 1.578125, 0, 0, 270)
            else
                outputChatBox("#F4A603⚠️ #FFFFFFNa wyświetlaczu pojawia się napis: Brak wolnego miejsca na wydanie pojazdu.", plr, 255,255,255, true)
            return end
        elseif location == markerDillimore then
            local check = getElementsWithinColShape(colDillimore, "vehicle")
            if next(check) == nil then
                car = createVehicle(veh_id, 707.389038, -569.383423, 16.335938, 0, 0, 270)
            else
                outputChatBox("#F4A603⚠️ #FFFFFFNa wyświetlaczu pojawia się napis: Brak wolnego miejsca na wydanie pojazdu.", plr, 255,255,255, true)
            return end
        end
        db:insert("UPDATE vehicles SET przecho=0 where vid=?", chosen)
        setVehiclePlateText(car, "SA "..chosen)
        setElementID(car, "vehicle"..chosen)
        setElementData(car, "vehicle.vid", chosen)
        setElementData(car, "vehicle.owner", getElementData(plr, "player.uid"))
        setElementData(car, "vehicle.owner_nick", getElementData(plr, "player.nickname"))
        setElementData(car, "vehicle.klucze", klucze)
        setElementData(car, "vehicle.mileage", mileage)
        setVehicleColor(car, r,g,b)

        if res2[1]['maska'] ~= 0 then addVehicleUpgrade(car, res2[1]['maska']) end
        if res2[1]['felgi'] ~= 0 then addVehicleUpgrade(car, res2[1]['felgi']) end
        if res2[1]['nitro'] ~= 0 then addVehicleUpgrade(car, res2[1]['nitro']) end
        if res2[1]['zderzak_p'] ~= 0 then addVehicleUpgrade(car, res2[1]['zderzak_p']) end
        if res2[1]['zderzak_t'] ~= 0 then addVehicleUpgrade(car, res2[1]['zderzak_t']) end
        if res2[1]['wlot'] ~= 0 then addVehicleUpgrade(car, res2[1]['wlot']) end
        if res2[1]['spoiler'] ~= 0 then addVehicleUpgrade(car, res2[1]['spoiler']) end
        if res2[1]['lights'] ~= 0 then addVehicleUpgrade(car, res2[1]['lights']) end
        if res2[1]['wlot_dach'] ~= 0 then addVehicleUpgrade(car, res2[1]['wlot_dach']) end
        if res2[1]['hydraulika'] ~= 0 then addVehicleUpgrade(car, res2[1]['hydraulika']) end
        if res2[1]['stereo'] ~= 0 then addVehicleUpgrade(car, res2[1]['stereo']) end
        if res2[1]['wydech'] ~= 0 then addVehicleUpgrade(car, res2[1]['wydech']) end
        if res2[1]['turbo'] ~= 0 then setVehicleHandling(car, "engineAcceleration", 20) end

        
        local JSONTable = fromJSON(res2[1].damage)

        local lightL = JSONTable.lightL
        local lightR = JSONTable.lightR
        local windshield = JSONTable.windshield
        local frontBump = JSONTable.frontBump
        local rearBump = JSONTable.rearBump
        local hood = JSONTable.hood
        local trunk = JSONTable.trunk
        local flDoor = JSONTable.flDoor
        local frDoor = JSONTable.frDoor
        local rlDoor = JSONTable.rlDoor
        local rrDoor = JSONTable.rrDoor

        setVehicleLightState(car, 0, lightL)
        setVehicleLightState(car, 1, lightR)
        setVehiclePanelState(car, 4, windshield)
        setVehiclePanelState(car, 5, frontBump)
        setVehiclePanelState(car, 6, rearBump)
        setVehicleDoorState(car, 0, hood)
        setVehicleDoorState(car, 1, trunk)
        setVehicleDoorState(car, 2, flDoor)
        setVehicleDoorState(car, 3, frDoor)
        setVehicleDoorState(car, 4, rlDoor)
        setVehicleDoorState(car, 5, rrDoor)
    end
end
addEventHandler("createVeh", getRootElement(), createVeh)

function getVehiclePos(veh)
    local carID = getElementByID(veh)
    local x,y,z = getElementPosition(carID)
    print(x.." "..y.." "..z)
end
addEventHandler("getVeh", getRootElement(), getVehiclePos)





local oddaj = createMarker(163.693741, -14.960943, 1.578125-1, "cylinder", 5, 255, 0, 0, 0)
addEventHandler("onMarkerHit", oddaj, function(hit)
    if(hit and isElement(hit) and getElementType(hit) == "player")then
        local veh = getPedOccupiedVehicle(hit)
        if(veh)then
            local id = getElementData(veh, "vehicle.vid")
            if(id)then
                iprint(hit)
                local lightL = getVehicleLightState(veh, 0)
                local lightR = getVehicleLightState(veh, 1)
                local windshield = getVehiclePanelState (veh, 4)
                local frontBump = getVehiclePanelState (veh, 5)
                local rearBump = getVehiclePanelState (veh, 6)
                local hood = getVehicleDoorState(veh, 0)
                local trunk = getVehicleDoorState(veh, 1)
                local flDoor = getVehicleDoorState(veh, 2)
                local frDoor = getVehicleDoorState(veh, 3)
                local rlDoor = getVehicleDoorState(veh, 4)
                local rrDoor = getVehicleDoorState(veh, 5)

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
                db:insert("UPDATE vehicles SET mileage=? WHERE vid=?", getElementData(veh, "vehicle.mileage"), id)
                db:insert("UPDATE vehicles SET przecho=1 WHERE vid=?", id)
                db:insert("UPDATE vehicles SET last_driver=? WHERE vid=?", getElementData(hit, "player.nickname"), id)
                destroyElement(veh)
            end
        end
    end
end)

function restart_veh()
	db:insert("UPDATE vehicles SET przecho=1")
end
addEventHandler ("onResourceStart", getResourceRootElement (getThisResource()), restart_veh)