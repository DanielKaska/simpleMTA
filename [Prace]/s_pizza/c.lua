addEvent("startJob", true)
addEvent("startJobScooter", true)
addEvent("endJob", true)
addEvent("endJob2", true)
addEvent("randomDeliver", true)
addEvent("startScooterJob", true)
addEvent("destroyDrawing", true)
addEvent("destroyDrawingScooter", true)
addEvent("startBlistaJob", true)


showing = false

--2337.752930, 75.152321, 26.517496 pc pizza
--attachElements(el, myVeh, 0, -0.5, 0.795)
local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX
local font = dxCreateFont("font.ttf", 15)
local font2 = dxCreateFont("font-thick.ttf", 20)
local font3 = dxCreateFont("font-medium.ttf", 20)
local DGS = exports.DGS



--scooter ponts

local deliveryPoints = {
    {1945.605835, 163.500824, 37.248997},
    {1566.105103, 23.297003, 24.164062},
    {1360.316650, 206.535004, 19.554688},
    {1284.143188, 158.586044, 20.793369},
    {1293.828979, 157.301743, 20.460938},
    {1227.770386, 181.950577, 20.367842},
    {1248.934814, 366.140472, 19.554688},
    {1374.098511, 475.587769, 20.051077},
    {1277.569336, 370.461060, 19.554688},
    {1435.600586, 334.571228, 18.841671},
    {1151.729980, 304.246857, 21.066238},
    {1097.283569, 263.454285, 27.684378},
    {1091.064331, 240.681458, 30.195759},
    {1076.312988, 157.094315, 31.756798},
    {1044.898926, 199.130249, 34.658085},
    {710.693604, 225.767899, 27.139999},
    {730.790405, 222.683517, 27.668314},
    {723.713135, 268.932861, 22.453125},
    {747.680908, 258.842743, 27.085938},
    {647.188354, 291.967407, 20.415625},
    {752.406128, 376.710052, 23.214382},
    {757.047729, 374.741486, 23.195122},
    {748.275574, 305.342133, 20.234375}
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function chooseLevelScooter()

    showing = true
    scooterButton = DGS:dgsCreateButton(scaleX*890, scaleY*750, scaleX*140, scaleY*50, "Rozpocznij pracę", false, nil, tocolor(255,255,255,255), scaleX*0.5, scaleY*0.5, nil, nil, nil, tocolor(245, 172, 72,200), tocolor(245, 172, 72,130), tocolor(16, 16, 16,200))
    DGS:dgsSetFont(scooterButton, font2)
    DGS:dgsSetLayer(scooterButton, "bottom")

    function s(b, s)
        if b == "left" and s == "up" then
            if getElementData(localPlayer, "player.working") ~= false then outputChatBox("#F4A603⚠️ #FFFFFFJuż pracujesz!", 255,255,255, true) return end
            triggerServerEvent("startJ", localPlayer, localPlayer)
            removeEventHandler("onClientRender", root, drawScooter)
        end
    end
    addEventHandler("onDgsMouseClick", scooterButton, s)

    function drawScooter()
            dxDrawText("Oferty pracy:\nThe Well Stacked Pizza", scaleX*860, scaleY*160, scaleX*1060, scaleY*340, tocolor(255,255,255,255), scaleX*1, font2, "center", "center", false, true, true, true)
            dxDrawText("#F5AF48Lokalny dostawca", scaleX*810, scaleY*300, scaleX*1110, scaleY*640, tocolor(255,255,255,255), scaleX*0.75, font2, "center", "top", false, true, true, true)
            dxDrawRectangle(scaleX*810, scaleY*290, scaleX*300, scaleY*530, tocolor(16,16,16,200), false)
            dxDrawText("\n\nOpis:\n\nSzukasz pracy na początek? Idealnie się składa, w firmie The Well Stacked Pizza nie wymagamy żadnego doświadczenia. Co więcej, znajdziesz u nas też możliwość awansu.\n\nPrzyjmujemy od zaraz.\n\nWymagania:\n-Prawo jazdy kategorii A/B\n\nTwoje obowiązki:\n-Sprawne dostarczanie zamówień głównie na terenie Montgomery.\n\n", scaleX*815, scaleY*300, scaleX*1110, scaleY*640, tocolor(255,255,255,255), scaleX*0.6, font3, "left", "top", false, true, true)
    end
    addEventHandler("onClientPreRender", root, drawScooter)
end
addEventHandler("startJobScooter", localPlayer, chooseLevelScooter)

function chooseLevel()
    showing = true
    blistaButton = DGS:dgsCreateButton(scaleX*890, scaleY*750, scaleX*140, scaleY*50, "Rozpocznij pracę", false, nil, tocolor(255,255,255,255), scaleX*0.5, scaleY*0.5, nil, nil, nil, tocolor(245, 172, 72,200), tocolor(245, 172, 72,130), tocolor(16, 16, 16,200))
    DGS:dgsSetFont(blistaButton, font2)
    DGS:dgsSetLayer(blistaButton, "top")

    function d(b, s)
        if b == "left" and s == "up" then
            if getElementData(localPlayer, "player.working") ~= false then outputChatBox("#F4A603⚠️ #FFFFFFJuż pracujesz!", 255,255,255, true) return end
            if getElementData(localPlayer, "player.level") < 5 then outputChatBox("#F4A603⚠️ #FFFFFFMasz zbyt niski poziom, aby podjąć tu pracę.", 255,255,255, true) return end
            triggerServerEvent("startJobBlista", localPlayer, localPlayer)
            removeEventHandler("onClientRender", root, draw)
        end
    end
    addEventHandler("onDgsMouseClick", blistaButton, d)

    function draw()
        dxDrawText("Oferty pracy:\nThe Well Stacked Pizza", scaleX*860, scaleY*160, scaleX*1060, scaleY*340, tocolor(255,255,255,255), scaleX*1, font2, "center", "center")
        dxDrawText("#F5AF48Dostawca międzymiastowy", scaleX*810, scaleY*300, scaleX*1110, scaleY*640, tocolor(255,255,255,255), scaleX*0.75, font2, "center", "top", false, true, true, true)
        dxDrawRectangle(scaleX*810, scaleY*290, scaleX*300, scaleY*530, tocolor(16,16,16,200), false)
        dxDrawText("\n\nOpis:\n\nPrzepracowałeś w życiu już pare godzin i chcesz zacząć normalnie zarabiać? Jeśli tak, to zapraszamy do pracy.\n\nPrzyjmujemy od zaraz.\n\nWymagania:\n-Prawo jazdy kategorii B\n-Doświadczenie w pracy\n\nTwoje obowiązki:\n-Dostarczanie zamówień na terenie Montgomery, Dillimore, Blueberry, oraz Palomino Creek.\n-Dbanie o stan pojazdu.", scaleX*815, scaleY*300, scaleX*1110, scaleY*640, tocolor(255,255,255,255), scaleX*0.6, font3, "left", "top", false, true, true)
    end
    addEventHandler("onClientPreRender", root, draw)
end
addEventHandler("startJob", localPlayer, chooseLevel)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function a(plr)
    if showing == false then return end
    removeEventHandler("onClientPreRender", root, draw)
    destroyElement(blistaButton)
    showing = false
end
addEventHandler("destroyDrawing", localPlayer, a)

function b(plr)
    if showing == false then return end
    removeEventHandler("onClientPreRender", root, drawScooter)
    destroyElement(scooterButton)
    showing = false
end
addEventHandler("destroyDrawingScooter", localPlayer, b)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function startJob() --------- Scooter job
        removeEventHandler("onClientPreRender", root, drawScooter) 
        refillMarker = createMarker(210.237518, -167.343124, 0.4, "cylinder", 2, 255,0,0,120)
        setElementData(localPlayer, "player.working", "scooter")
        xx = math.random(15, 20)
        setElementData(localPlayer, "refillMarker", refillMarker)
        triggerEvent("randomDeliver", localPlayer, localPlayer)
        addEventHandler("onClientMarkerHit", refillMarker, restockPizza)



        function draw()
            dxDrawText("#F5AF48"..xx.." #FFFFFFzamówień do dostarczenia.", scaleX*1640,scaleY*454, scaleX*1920, scaleX*504, tocolor(255,255,255,200), scaleX*1, font, "left", "top", false, true, true, true)
            dxDrawRectangle(scaleX*1640,scaleY*457, scaleX*260, scaleY*23, tocolor(16,16,16,170), false)
            local v = getElementData(localPlayer, "owner")
            local v, p, o = getElementPosition(v)
            local x, y, z = getElementPosition(localPlayer)
            local distance = getDistanceBetweenPoints3D(v, p, o, x ,y ,z)


            if distance > 29 then
                dxDrawText("Oddalasz się zbyt daleko od pojazdu!", scaleX*960,scaleY*654, scaleX*960, scaleX*704, tocolor(255,0,0,200), scaleX*0.8, font, "center", "center")
            end

            if distance > 49 then
                endJob(localPlayer)
                outputChatBox("#F4A603⚠️ #FFFFFFPraca została przerwana.", 255,255,255, true)
                triggerServerEvent("endj", localPlayer, localPlayer)
            end
        end
        addEventHandler("onClientRender", root, draw)
end
addEventHandler("startScooterJob", root, startJob)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



local pc = {
    {2269.467041, 108.143768, 27.672457},
    {2201.623779, -60.807178, 27.438086},
    {2256.894531, -43.265285, 26.480915},
    {2270.321533, -11.575669, 27.437016},
    {2207.418945, 62.032215, 27.692652},
    {2207.075928, 106.049934, 27.754179},
    {2236.404297, 163.662308, 27.412907},
    {2258.252686, 163.637085, 27.410942},
    {2269.407959, 108.497955, 27.752192},
    {2327.030762, 116.195221, 27.763880},
    {2327.227783, 136.308929, 27.737255},
    {2327.380127, 191.079269, 27.688841},
    {2360.752197, 141.915787, 27.763018},
    {2377.339844, 42.168209, 27.708366},
    {2377.360596, -8.642037, 27.712137},
    {2410.399902, -3.305125, 26.904142},
    {2414.764893, 17.924290, 26.952585},
    {2409.403564, 26.098391, 27.683460},
    {2413.769775, 58.447216, 27.749666},
    {2443.313965, 58.354313, 27.715704},
    {2447.333252, 16.431534, 26.828384},
    {2447.783936, -13.148374, 27.683458},
    {2365.294678, -47.691563, 28.153547},
    {2390.280273, -53.816959, 28.153551},
    {2418.233643, -51.485676, 28.153547},
    {2437.101562, -53.560581, 28.153549},
    {2447.063965, 92.286880, 27.763172},
    {2462.671387, 132.707260, 26.961285},
    {2483.737549, 126.343063, 27.675648},
    {2517.821777, 127.104805, 27.675646},
    {2533.338135, 128.370499, 26.726116}
}

local montgomery = {
    {1299.267212, 140.975739, 20.405972},
    {1293.643433, 157.427551, 20.460938},
    {1299.198975, 141.084961, 20.407179},
    {1306.373169, 148.258530, 20.341469},
    {1308.136230, 152.847305, 20.379051},
    {1296.692017, 190.463181, 20.460938},
    {1284.743896, 385.605255, 19.554688},
    {1302.855225, 361.925232, 19.688162}
}

local dillimore = {
    {770.406433, -504.100037, 18.012926},
    {820.320435, -510.267273, 18.012922},
    {745.029724, -510.584869, 18.012922},
    {743.477112, -555.254700, 18.012926},
    {764.855042, -555.910278, 18.012924},
    {743.996033, -588.259827, 18.012922},
    {792.665649, -507.282593, 18.012922}
}

local blueberry = {
    {248.075897, -33.165726, 1.578125},
    {253.215012, -22.638794, 1.612182},
    {249.569489, -92.582771, 2.836869},
    {249.558487, -121.330841, 2.826456},
    {253.846222, -163.446213, 5.078612},
    {264.984528, -57.035595, 2.777210},
    {292.754791, -55.138096, 1.984925},
    {315.978394, -92.542778, 2.842030},
    {315.921478, -121.360764, 2.860395},
    {261.566284, -270.364929, 1.578125},
    {256.510956, -278.080322, 1.578125},
    {263.554840, -283.652985, 1.578125},
    {260.016205, -302.752045, 1.918370},
    {242.120056, -297.920349, 1.578125},
    {235.119308, -308.514343, 1.583575},
    {226.772751, -305.925873, 1.598392},
    {285.543701, 43.193703, 2.533252},
    {309.835876, 43.060959, 2.809536},
    {316.173615, 53.876678, 3.375000},
    {340.362823, 61.446838, 3.782002},
    {340.577301, 30.146786, 6.358040}
}



function blistaJob()

    markers = {}

    removeEventHandler("onClientPreRender", root, draw) 
    setElementData(localPlayer, "player.working", "blista")
    randomPc = math.random(3,6)
    randomMontgomery = math.random(1,3)
    randomDillimore = math.random(1,3)
    randomBb = math.random(4,7)
    blista = getPedOccupiedVehicle(localPlayer)

    

    for a=1, randomPc do
        local points = math.random(1, #pc)
        local x,y,z = unpack(pc[points])
        pcMarker = createMarker(x,y,z-1, "cylinder", 1, 245, 175, 72)
        setElementData(pcMarker, "blistaMarker", true)
        setElementData(pcMarker, "index", a)
        setElementData(pcMarker, "table", "pc")
        local b = createBlip(x,y,z, 1, 1, 255,255,255)
        table.insert(markers, pcMarker)
        setElementParent(b, pcMarker)
    end

    for b=1, randomMontgomery do
        local points = math.random(1, #montgomery)
        local x,y,z = unpack(montgomery[points])
        montgomeryMarker = createMarker(x,y,z-1, "cylinder", 1, 245, 175, 72)
        setElementData(montgomeryMarker, "blistaMarker", true)
        setElementData(montgomeryMarker, "index", b+randomPc)
        setElementData(pcMarker, "table", "mont")
        local b = createBlip(x,y,z, 1, 1, 255,255,255)
        table.insert(markers, montgomeryMarker)
        setElementParent(b, montgomeryMarker)
    end
    
    for c=1, randomDillimore do
        local points = math.random(1, #dillimore)
        local x,y,z = unpack(dillimore[points])
        dillimoreMarker = createMarker(x,y,z-1, "cylinder", 1, 245, 175, 72)
        setElementData(dillimoreMarker, "blistaMarker", true)
        setElementData(dillimoreMarker, "index", c+randomPc+randomMontgomery)
        setElementData(pcMarker, "table", "dilli")
        local b = createBlip(x,y,z, 1, 1, 255,255,255)
        table.insert(markers, dillimoreMarker)
        setElementParent(b, dillimoreMarker)
    end

    for d=1, randomBb do
        local points = math.random(1, #blueberry)
        local x,y,z = unpack(blueberry[points])
        bbMarker = createMarker(x,y,z-1, "cylinder", 1, 245, 175, 72)
        setElementData(bbMarker, "blistaMarker", true)
        setElementData(bbMarker, "index", d+randomPc+randomMontgomery+randomDillimore)
        setElementData(pcMarker, "table", "bb")
        local b = createBlip(x,y,z, 1, 1, 255,255,255)
        table.insert(markers, bbMarker)
        setElementParent(b, bbMarker)
    end

    function drawBlista()
        --dxDrawText("#F5AF48"..x.." #FFFFFFzamówień do dostarczenia.", scaleX*1640,scaleY*454, scaleX*1920, scaleX*504, tocolor(255,255,255,200), scaleX*1, font, "left", "top", false, true, true, true)
        --dxDrawRectangle(scaleX*1640,scaleY*457, scaleX*260, scaleY*23, tocolor(16,16,16,170), false)
        local v = getElementData(localPlayer, "owner")
        local v, p, o = getElementPosition(v)
        local x, y, z = getElementPosition(localPlayer)
        local distance = getDistanceBetweenPoints3D(v, p, o, x ,y ,z)
        if distance > 29 then
            dxDrawText("Oddalasz się zbyt daleko od pojazdu!", scaleX*960,scaleY*654, scaleX*960, scaleX*704, tocolor(255,0,0,200), scaleX*0.8, font, "center", "center")
        end

        if distance > 49 then
            endJob2(localPlayer)
            outputChatBox("#F4A603⚠️ #FFFFFFPraca została przerwana.", 255,255,255, true)
            triggerServerEvent("endj2", localPlayer, localPlayer)
        end
    end
    addEventHandler("onClientRender", root, drawBlista)

    addEventHandler("onClientMarkerHit", root, takePizza)
    addEventHandler("onClientVehicleEnter", root, closeTrunk)
    addEventHandler("onClientMarkerHit", root, blistaDeliver)
    addEventHandler("onClientVehicleExit", root, takeDelivery)
end
addEventHandler("startBlistaJob", localPlayer, blistaJob)

function takePizza(plr, m)
    if m then
        if plr == getLocalPlayer() then
            local v = getElementData(plr, "owner")
            if source == getElementData(v, "takeMarker") then
                if getElementData(plr, "carrying") == true then
                    destroyElement(pizza)
                    toggleControl("crouch", true)
                    toggleControl("sprint", true)
                    toggleControl("jump", true)
                    setElementData(plr, "carrying", false)
                    setPedAnimation(plr,"ped","walk_player",0,true,true,false,false) 
                else
                    toggleControl("crouch", false)
                    toggleControl("sprint", false)
                    toggleControl("jump", false)
                    pizza = createObject(2814, 0,0,0)
                    attachElements(pizza, plr, 0, 0.35,0.35)
                    setPedAnimation(plr,"CARRY","crry_prtial",0,true,true,false,true) 
                    setElementData(plr, "carrying", true)
                end
            end
        end
        end
    end

function takeDelivery(plr)
    if source == getElementData(plr, "owner") then
        local veh = source
        if plr == getLocalPlayer() then
            takeMarker = createMarker(0,0,0, "cylinder", 1, 245, 175, 72)
            marker = true
            setVehicleDoorOpenRatio(veh, 1, 1, 1500)
            attachElements(takeMarker, veh, 0, -2.7, -1)
            setElementData(veh, "takeMarker", takeMarker)
        end
    end
end

function closeTrunk(plr)
    if source == getElementData(plr, "owner") then
        if plr == getLocalPlayer() then
            local veh = source
            setVehicleDoorOpenRatio(veh, 1, 0, 1500)
            if marker == true then
                destroyElement(getElementData(veh, "takeMarker"))
            end
        end
    end
end

function blistaDeliver(plr, md)
    if getElementData(source, "blistaMarker") == true then
        if plr == getLocalPlayer() then
        if getElementData(plr, "carrying") ~= true then
            outputChatBox("#F4A603⚠️ #FFFFFFWeź zamówienie z bagażnika!", 255,255,255, true)
        return end
        destroyElement(pizza)
        toggleControl("crouch", true)
        toggleControl("sprint", true)
        toggleControl("jump", true)
        setElementData(plr, "carrying", false)
        setPedAnimation(plr,"ped","walk_player",0,true,true,false,true) 
        local id = getElementData(source, "index")
        destroyElement(source)
        triggerServerEvent("payment", plr, math.random(35, 55), math.random(1,5))
        end
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function endJob(plr)                                            --ending the scooter job
    if getElementData(plr, "player.working") == "scooter" then
        local md = getElementData(plr, "marker")
        local bl = getElementData(plr, "blip")
        local rm = getElementData(plr, "refillMarker")
        local v =  getElementData(plr, "owner")
        if rm then                                                              
            destroyElement(rm)
        end
        removeEventHandler("onClientRender", root, draw)
        if xx < 1 then return end
        destroyElement(md)
        destroyElement(bl)
    end
end
addEventHandler("endJob", localPlayer, endJob)

function endJob2(plr)                                            --ending the blista job
    if getElementData(plr, "player.working") == "blista" then
        local veh = getElementData(plr, "owner")
        local mdd = getElementData(veh, "takeMarker")

        for k,v in pairs(markers) do
            if isElement(markers[k]) then
                destroyElement(markers[k])
            end 
        end

        markers = nil

        removeEventHandler("onClientRender", root, drawBlista)
        removeEventHandler("onClientMarkerHit", root, takePizza)
        removeEventHandler("onClientVehicleEnter", root, closeTrunk)
        removeEventHandler("onClientMarkerHit", root, blistaDeliver)
        removeEventHandler("onClientVehicleExit", root, takeDelivery)
        destroyElement(mdd)
    end
end
addEventHandler("endJob2", localPlayer, endJob2)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



function deliver(plr, md)
    if source == getElementData(plr, "marker") and md == true then
        local md = getElementData(plr, "marker")
        local bl = getElementData(plr, "blip")
        destroyElement(md)
        destroyElement(bl)
        randomDelivery(plr)
        xx=xx-1
        local d = math.floor(dist/50)
        triggerServerEvent("payment", plr, math.random(15, 23)+d, math.random(1,5))
    end
end

function randomDelivery(plr)
    if xx == 1 then
        triggerEvent("sendAlert", plr, "Skończyły się dostawy, wróć do #F5AF48restauracji #FFFFFFpo więcej.", 300)
    else
        local r = math.random(1, #deliveryPoints)
        local x, y, z = unpack(deliveryPoints[r])
        m = createMarker(x,y,z-1.2, "cylinder", 1, 245,175,72,100)
        local p1, p2, p3 = getElementPosition(plr)
        dist = getDistanceBetweenPoints3D(p1, p2, p3, x, y, z)
        b = createBlipAttachedTo(m, 0, 1, 245,175,72,255)
        setElementData(plr, "marker", m)
        setElementData(plr, "blip", b)
        addEventHandler("onClientMarkerHit", m, deliver)
    end
end
addEventHandler("randomDeliver", localPlayer, randomDelivery)

function restockPizza(plr, md)
    if source == getElementData(plr, "refillMarker") and md == true then
        if xx == 0 then 
            xx = math.random(15, 20)
            randomDelivery(plr)
            triggerEvent("sendAlert", plr, "#F5AF48"..x.." #FFFFFFnowych dostaw.", 200)
        else
            triggerEvent("sendAlert", plr, "Dokończ dostawy.", 200)
        end
    end
end
