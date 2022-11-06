addEvent("clientTrashCollect", true)

loadstring(exports.dgs:dgsImportFunction())()

local b = exports.bone_attach

addEventHandler("clientTrashCollect", root, function()
    local plr = source 
    local truck = getElementData(plr, "trashVeh.owner")

    local marker = createMarker(0,0,0,"cylinder", 1.5, 255,255,255,0)
    setElementData(plr, "trashMarker", marker)
    setElementData(truck, "truck_filling", 0)
    setElementData(plr, "trashMarker", marker)
    attachElements(marker, truck, 0, -5, -1.5)

    randomRoute(plr)
end)

local gui = {}

function renderTruckFilling(plr, dim)
    local marker = getElementData(plr, "trashMarker")
    if source == marker then
        if plr == localPlayer and dim == true then  

            local truck = getElementData(plr, "trashVeh.owner")

            if getElementData(plr, "trashCarrying") ~= false then
                local bin = getElementData(plr, "trashCarrying")
                destroyElement(bin)
                setElementData(plr, "trashCarrying", false)
                setElementData(truck, "truck_filling", math.floor(math.random(100, 150)))
            end


            
            setElementFrozen(truck, true)
            local tx,ty,tz = getElementPosition(truck)
            local x,y,z = getElementPosition(marker)

            local interface = dgsCreate3DInterface(x,y,z+1,2,0.1,200,20,tocolor(255,255,255,255))
            local filling = dgsCreateProgressBar(0,0, 200, 20, false, interface)
            dgsSetProperty(filling,"bgColor",tocolor(20,20,20, 210))
            dgsSetProperty(filling,"indicatorColor",tocolor(245,175,72, 210))
            dgsProgressBarSetProgress(filling,getElementData(truck, "truck_filling")/50)
            table.insert(gui, #gui+1, interface)
       end
    end
end
addEventHandler("onClientMarkerHit", root, renderTruckFilling)

addEventHandler("onClientMarkerLeave", root, function(plr, dim)
    local marker = getElementData(plr, "trashMarker")
    if source == marker then
        if plr == localPlayer and dim == true then  
            local truck = getElementData(plr, "trashVeh.owner")
            setElementFrozen(truck, false)
            for k,v in pairs(gui) do
                destroyElement(v)
                table.remove(gui, k)
            end
       end
    end 
end)

local containers = {
    {-222.085297, 116.806343, 2.373984},
    {-217.948807, 115.609421, 2.596363},
    {-211.074615, 113.350273, 2.763117}
}

local object_ids = {
    1331,
    1334,
    1339
}

local bins_table = {}

function randomRoute(plr)
    for k,v in ipairs(containers) do
        local x,y,z = unpack(v)
        local r = math.random(1, #object_ids)
        local trashCan = createObject(object_ids[r], x,y,z, 0, 0, math.random(0, 360))
        if object_ids[r] == 1331 or 1334 then setObjectScale(trashCan, 0.8) setElementPosition(trashCan, x,y,z-0.2) end
        local marker = createMarker(x,y,z-1, "cylinder", 1.5, 255,255,255,0)
        setElementParent(trashCan, marker)
        table.insert(bins_table, #bins_table+1, trashCan)
        setElementData(marker, "trashBinOwner", plr)
        
        setElementCollisionsEnabled(trashCan, false)
    end
end

addEventHandler("onClientMarkerHit", root, function(player, dim)
    local plr = getElementData(source, "trashBinOwner")
    if plr == player and dim == true then
        if getElementData(plr, "trashCarrying") == false then
            setElementData(plr, "trashCarrying", source)
            attachElements(source, plr, 0, 1, 0, 0, 0, 180) 
        end
    end    
end)