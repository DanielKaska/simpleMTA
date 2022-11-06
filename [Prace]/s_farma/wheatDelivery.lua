local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX
local font = dxCreateFont("font.ttf", 15)
local font2 = dxCreateFont("font-thick.ttf", 20)
local font3 = dxCreateFont("font-medium.ttf", 20)
local DGS = exports.DGS

local image = dxCreateTexture("i/truck.png")

addEvent("startWheatDelivery", true)
addEvent("endHayLoading", true)


addEventHandler("startWheatDelivery", root, function()
    triggerServerEvent("spawnWheatCar", source)
    addEventHandler("onClientVehicleEnter", root, closeTrunk)
    addEventHandler("onClientVehicleExit", root, takeDelivery)
    addEventHandler("onClientRender", root, drawDelivery)
    wheatRender = true
    deliveryRender = false
    createObjectsToLoad()
    marker = false
    addEventHandler("onClientRender", root, checkDistance)
end)

shed_points = {
    {-97.046387, -94.865700, 3.118082},
    {-99.037079, -95.855293, 3.118082},
    {-94.926796, -97.528305, 3.118082},
    {-93.359787, -94.279167, 3.118082},
    {-87.959625, -95.285515, 3.118082},
    {-86.357941, -97.480797, 3.118082},
    {-84.751518, -96.940201, 3.118082},
    {-81.332718, -100.117210, 3.118082},
    {-78.309006, -97.885902, 3.118082},
    {-72.763771, -108.344597, 3.118082},
    {-74.755257, -109.425575, 3.118082},
    {-77.376625, -106.583153, 3.118082},
    {-87.911819, -108.258621, 3.301640},
    {-97.676849, -98.316452, 6.503325},
    {-93.404106, -102.827972, 6.484375},
    {-74.591789, -105.887283, 6.552680},
    {-73.864319, -102.170753, 6.556211},
    {-124.207863, -93.456871, 6.484375},
    {-145.218887, -91.094124, 6.515307},
    {-123.265282, -93.393333, 6.489588},
    {-125.030281, -93.137039, 6.484375},
    {-146.622040, -92.978104, 6.577787},
    {-144.979340, -89.849724, 6.513188},
    {-145.321609, -91.908279, 6.513616},
    {-52.635567, 56.718647, 3.110270},
    {-60.303680, 60.795784, 3.110270},
    {-62.591129, 60.513489, 3.110270},
    {-69.707367, 44.066101, 3.110270},
    {-70.313622, 37.405685, 3.110270},
    {-53.814999, 50.227882, 3.110270},
    {-54.377480, 57.099747, 3.110270},
    {-55.795738, 58.545887, 6.533018},
    {-61.990208, 52.211933, 6.476562},
    {-63.791348, 47.073200, 6.476562},
    {-67.231079, 37.272865, 6.521674},
    {-43.810104, 27.248718, 3.117188},
    {-52.927586, 31.484619, 3.117188},
    {-51.489262, 38.163933, 3.109375},
    {-43.865879, 54.886429, 3.117188},
    {-46.006424, 54.620651, 3.117188},
    {-46.679592, 28.574780, 6.484375},
    {-49.312393, 31.688404, 6.484375}
}

deliveryPoints = {
    {1303.086670, 362.256714, 19.688162},
    {1382.725830, 259.606842, 19.566933},
    {1244.317505, 204.575562, 19.645432},
    {1945.747314, 163.358032, 37.238342},
    {2332.723145, 75.004570, 26.620975},
    {2329.258057, 6.139077, 26.521933},
    {1073.297485, -344.859619, 73.992188},
    {1105.654419, -299.714661, 74.539062},
    {681.466248, -476.084900, 16.335938},
    {691.361511, -640.420898, 16.322060},
    {695.053162, -499.864410, 16.335938},
    {1198.400269, -920.968689, 43.036903},
    {-380.760284, -1426.614746, 25.762119},
    {-577.795776, -1482.026855, 10.828817},
    {-388.872253, -1144.048950, 69.267357},
    {-383.603119, -1040.293091, 58.898811},
    {-430.076660, -400.119598, 16.203125},
    {-1044.863647, 1552.957764, 33.323364},
    {-856.611511, 1537.071045, 22.587044},
    {-144.192673, 1222.451782, 19.899220},
    {-19.068850, 1178.847046, 19.563381},
    {321.489349, 1147.475342, 8.576572}
}


function takeDelivery(plr) -- 
    if source == getElementData(plr, "wheatDeliverVehicle") then
        local veh = source
        if plr == getLocalPlayer() then
            takeMarker = createMarker(0,0,0, "cylinder", 1, 245, 175, 72)
            marker = true
            setVehicleDoorOpenRatio(veh, 4, 1, 1500)
            setVehicleDoorOpenRatio(veh, 5, 1, 1500)
            attachElements(takeMarker, veh, 0, -3.5, -1)
            setElementData(veh, "takeMarker", takeMarker)
            setElementData(takeMarker, "wheatLoadMarker", true)
        end
    end
end

function closeTrunk(plr)
    if source == getElementData(plr, "wheatDeliverVehicle") then
        if plr == getLocalPlayer() then
            local veh = source
            setVehicleDoorOpenRatio(veh, 4, 0, 1500)
            setVehicleDoorOpenRatio(veh, 5, 0, 1500)
            if marker == true then
                destroyElement(getElementData(veh, "takeMarker"))
            end
        end
    end
end

function createObjectsToLoad() -- creating hay bales
    bales = 0
    hayBales = {}
    local r = math.random(1, 1)
    for i=1,r do
        local rr = math.random(1, #shed_points)
        local x,y,z = unpack(shed_points[rr])
        local rand = math.random(0, 360)
        local loadPoints = createMarker(x,y,z-1, "cylinder", 1, 255,255,255,0)
        local hay = createObject(1454, x,y,z-1, 0, rand, rand)
        bales = r
        setObjectScale(hay, 0.4, 0.7)
        setElementCollisionsEnabled(hay, false)
        table.insert(hayBales, i, hay)
        table.insert(hayBales, i, loadPoints)
        setElementData(loadPoints, "loadPoint", true)
        setElementParent(hay, loadPoints)
        local blip = createBlip(x,y,z, 1)
        setElementParent(blip, loadPoints)
    end
end
 
addEventHandler("onClientMarkerHit", root, function(plr, dim) -- attaching hay bales to the player 
    if plr == localPlayer and dim == true then
        if getElementData(source, "loadPoint") == true then
            if getElementData(plr, "hayLoading") ~= true then
                setElementData(plr, "hayLoading", true)
                setPedAnimation(plr, "carry", "liftup", -1, false)
                toggleControl("crouch", false)
                toggleControl("sprint", false)
                toggleControl("jump", false)
                local hay = source
                setTimer(function()
                    setPedAnimation(plr,"CARRY","crry_prtial",0,true,true,false,true)
                        exports.bone_attach:attachElementToBone(hay, plr, 12, 0, 0, 0, 0, 25) 
                    setElementData(plr, "hay", hay)
                end, 600, 1)
            end
        end
    end
end)

addEventHandler("onClientMarkerHit", root, function(plr, dim) -- loading hay bales onto the truck
    if plr == localPlayer and dim == true then
        if getElementData(source, "wheatLoadMarker") == true then
            local hayBale = getElementData(plr, "hay")
            if isElement(hayBale) then
                if hayBale ~= false then
                    destroyElement(hayBale)
                    setPedAnimation(plr, "carry", "putdwn", -1, false)

                    setTimer(function()
                        setPedAnimation(plr,"ped","walk_player",0,true,true,false,true)
                    end, 600, 1)

                    bales = bales-1
                    setElementData(plr, "hayLoading", false)
                    toggleControl("crouch", true)
                    toggleControl("sprint", true)
                    toggleControl("jump", true)
                    triggerServerEvent("payment", plr, math.random(20,40), math.random(0,1))

                    if bales == 0 then -- randomising delivery points
                        triggerEvent("sendAlert", plr, "Udaj się do #F5AF48punktu #FFFFFFwskazanego na mapie, by dostarczyć zamówienie.", 250)
                        local r = math.random(1,#deliveryPoints)
                        local x,y,z = unpack(deliveryPoints[r])
                        deliveryMarker = createMarker(x,y,z-1, "cylinder", 1, 255,255,255,255)
                        local blip = createBlip(x,y,z, 1, 1, 255,255,255,255,1,500)
                        setElementParent(blip, deliveryMarker)
                        setElementData(deliveryMarker, "wheatDeliveryMarker", true)
                        wheatRender = false
                        removeEventHandler("onClientRender", root, drawDelivery)
                        deliveryRender = true
                        addEventHandler("onClientRender", root, drawDestination)
                    end
                end
            end
        end
    end
end)

function checkDistance()
    local x,y,z = getElementPosition(localPlayer)
    local v = getElementData(localPlayer, "wheatDeliverVehicle")
    if isElement(v) then
        local vx,vy,vz = getElementPosition(v)
        local dist = getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)
        if dist > 50 then 
            triggerServerEvent("endHayDelivery", localPlayer)
            removeEventHandler("onClientRender", root, checkDistance)
        return end
    end 
end


function drawDelivery() -- drawing things
    dxDrawText("Bele do załadowania: "..bales, 500,500)
end

function drawDestination()
    local mx,my,mz = getElementPosition(deliveryMarker)
    local x,y,z = getElementPosition(localPlayer)
    local dist = getDistanceBetweenPoints3D(mx,my,mz,x,y,z)
    dxDrawText("Odległość od punktu: "..string.format("%d",dist).."m", scaleX*860, scaleY*50, scaleX*1060, scaleY*50, tocolor(255,255,255,255), scaleX*1, font2, "center", "center")
    dxDrawImage(scaleX*700, scaleY*15, scaleX*63, scaleY*64,image)
end

addEventHandler("onClientMarkerHit", root, function(plr, dim) -- ending the delivery
    if plr == localPlayer and dim == true then
        if getElementData(source, "wheatDeliveryMarker") == true then
            destroyElement(source)
            triggerServerEvent("payment", plr, math.random(110,135), math.random(7,15))
            triggerEvent("sendAlert", plr, " Zakończyłeś #F5AF48zlecenie#FFFFFF, wróć na farmę by podjąć się kolejnego.", 250)
            removeEventHandler("onClientRender", root, drawDestination)
        end
    end
end)

addEventHandler("endHayLoading", root, function() -- ending the job

    for k,v in pairs(hayBales) do
        if isElement(hayBales[k]) then
            destroyElement(hayBales[k])
        end 
    end

    local marker = getElementData(source, "loadPoint")

    if marker ~= false then
        if isElement(marker) == true then
            destroyElement(marker)
        end 
    end
    local veh = getElementData(source, "wheatDeliverVehicle")
    

    local loadMarker = getElementData(veh, "takeMarker")

    if isElement(loadMarker) then
        destroyElement(loadMarker)
    end
    toggleControl("crouch", true)
    toggleControl("sprint", true)
    toggleControl("jump", true)
    removeEventHandler("onClientVehicleEnter", root, closeTrunk)
    removeEventHandler("onClientVehicleExit", root, takeDelivery)
    removeEventHandler("onClientRender", root, checkDistance)
    if wheatRender == true then
        removeEventHandler("onClientRender", root, drawDelivery)
        wheatRender = nil
    end

    if deliveryRender == true then
        removeEventHandler("onClientRender", root, drawDestination)
        deliveryRender = nil
    end

    triggerEvent("sendAlert", localPlayer, "Kończysz #F5AF48pracę#FFFFFF.", 250)
end)