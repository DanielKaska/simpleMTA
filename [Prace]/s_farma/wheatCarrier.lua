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

addEvent("triggerFarmGUI", true)
addEvent("destroyFarmGUI", true)

addEvent("endHayCarrying", true)

addEventHandler("triggerFarmGUI", root, function()
    showing = true
    jobStarter1 = DGS:dgsCreateButton(scaleX*730, scaleY*750, scaleX*140, scaleY*50, "Rozpocznij pracę", false, nil, tocolor(255,255,255,255), scaleX*0.5, scaleY*0.5, nil, nil, nil, tocolor(245, 172, 72,200), tocolor(245, 172, 72,130), tocolor(16, 16, 16,200))
    jobStarter2 = DGS:dgsCreateButton(scaleX*1040, scaleY*750, scaleX*140, scaleY*50, "Rozpocznij pracę", false, nil, tocolor(255,255,255,255), scaleX*0.5, scaleY*0.5, nil, nil, nil, tocolor(245, 172, 72,200), tocolor(245, 172, 72,130), tocolor(16, 16, 16,200))
    DGS:dgsSetFont(jobStarter1, font2)
    DGS:dgsSetFont(jobStarter2, font2)
    
    DGS:dgsSetLayer(jobStarter1, "top")
    DGS:dgsSetLayer(jobStarter2, "top")

    function drawFarmGUI()
        dxDrawText("Oferty pracy:\nEasterBoard Farm", scaleX*860, scaleY*160, scaleX*1060, scaleY*340, tocolor(255,255,255,255), scaleX*1, font2, "center", "center")
        dxDrawRectangle(scaleX*650, scaleY*290, scaleX*300, scaleY*530, tocolor(16,16,16,200), false)
        dxDrawRectangle(scaleX*970, scaleY*290, scaleX*300, scaleY*530, tocolor(16,16,16,200), false)
        dxDrawText("Oferta #1\nRoznoszenie siana", scaleX*650, scaleY*290, scaleX*950, scaleY*340, tocolor(255,255,255,255), scaleX*0.7, font2, "center", "center")
        dxDrawText("Oferta #2\nRozwożenie zamówień", scaleX*970, scaleY*290, scaleX*1270, scaleY*340, tocolor(255,255,255,255), scaleX*0.7, font2, "center", "center")

        dxDrawText("\nOpis:\n\nPoszukujemy pracowników fizycznych do przenoszenia bel siena w wyznaczone miesjca w naszych stodołach.\n\nWymagania:\n\n-Chęci do pracy", scaleX*655, scaleY*340, scaleX*950, scaleY*340, tocolor(255,255,255,255), scaleX*0.6, font3, "left", "top", false, true, true)
        dxDrawText("\nOpis:\n\nPoszukujemy kierowców z prawem jazdy kategorii B. Do obowiązków pracownika należą:\n\n-Ładowanie bel siana ze stodół na samochód\n\n-Dowożenie zamówień do klientów", scaleX*975, scaleY*340, scaleX*1270, scaleY*340, tocolor(255,255,255,255), scaleX*0.6, font3, "left", "top", false, true, true)
    end 
    addEventHandler("onClientPreRender", root, drawFarmGUI)
end)

addEventHandler("destroyFarmGUI", root, function()
    if showing == true then
        destroyElement(jobStarter1)
        destroyElement(jobStarter2)
        removeEventHandler("onClientPreRender", root, drawFarmGUI)
        showing = false
    end
end)

addEventHandler("onDgsMouseClickDown", root, function()
    if source == jobStarter1 then
        if getElementData(localPlayer, "player.working") ~= false then outputChatBox("#F4A603⚠️ #FFFFFFJuż pracujesz!", 255,255,255, true) return end
        wheatCarrier() 
        triggerEvent("sendAlert", localPlayer, "#F5AF48Rozpoczęto pracę.\n#ffffffUdaj się do stosu bel i zanieś je w wyznaczone miejsce.", 350)
        setElementData(localPlayer, "player.working", "hayCarrier")
    end
end)

addEventHandler("onDgsMouseClickDown", root, function()
    if source == jobStarter2 then
        if getElementData(localPlayer, "player.working") ~= false then outputChatBox("#F4A603⚠️ #FFFFFFJuż pracujesz!", 255,255,255, true) return end
        triggerEvent("startWheatDelivery", localPlayer)
        triggerEvent("sendAlert", localPlayer, "#F5AF48Rozpoczęto pracę.\n#ffffffZaładuj bele do auta i rozwieź je do miejsc docelowych.", 350)
        setElementData(localPlayer, "player.working", "hayDelivery")
    end
end)

hayBales = {}

function wheatCarrier()

    random_start = math.random(1,2)

    hayBalesLocation = {
        {-22.072760, 101.360771, 3.117188},
        {-18.367466, 102.415558, 3.117188},
        {-17.592308, 100.531685, 3.117188},
        {-19.678917, 98.979988, 3.117188},
        {-20.080069, 97.045296, 3.117188},
        {-17.590382, 97.395813, 3.117188}
    }

    shed_points = {
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

    second_hayBalesLocation = {
        {-69.702980, -51.089947, 3.117188},
        {-67.958801, -51.842613, 3.117188},
        {-66.495323, -56.284142, 3.117188},
        {-65.426796, -57.123920, 3.117188},
        {-65.577751, -53.307186, 3.109396},
        {-66.798080, -51.640419, 3.109396},
        {-64.767525, -51.734444, 3.117188}
    }

    second_shed_points = {
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
        {-145.321609, -91.908279, 6.513616}
    }

    if random_start == 1 then
        for i=1,#hayBalesLocation do 
            hayAmmount = i
            local r = math.random(0, 360)
            local x,y,z = unpack(hayBalesLocation[i])
            local hay = createObject(1454, x,y,z-1, 0, r, r)
            local marker = createMarker(x,y,z-1, "cylinder", 1, 255,255,255,0)
            local blip = createBlip(x,y,z, 1)
            setObjectScale(hay, 0.4, 0.7)
            setElementCollisionsEnabled(hay, false)
            table.insert(hayBales, i, hay)
            table.insert(hayBales, i, marker)
            setElementData(marker, "hayMarker", true)
            setElementParent(hay, marker)
            setElementParent(blip, marker)
        end
    else
        for i=1,#second_hayBalesLocation do 
            hayAmmount = i
            local r = math.random(0, 360)
            local x,y,z = unpack(second_hayBalesLocation[i])
            local hay = createObject(1454, x,y,z-1, 0, r, r)
            local marker = createMarker(x,y,z-1, "cylinder", 1, 255,255,255,0)
            local blip = createBlip(x,y,z, 1)
            setObjectScale(hay, 0.4, 0.7)
            setElementCollisionsEnabled(hay, false)
            table.insert(hayBales, i, hay)
            table.insert(hayBales, i, marker)
            setElementData(marker, "hayMarker", true)
            setElementParent(hay, marker)
            setElementParent(blip, marker)
        end
    end
end

addEventHandler("onClientMarkerHit", root, function(plr, dim)
    if plr == localPlayer then 
        if getElementData(source, "hayMarker") == true then
            if getElementData(plr, "hayCarry") ~= true then
                setElementData(plr, "hayCarry", true)
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
                if random_start == 1 then
                    local shed_point = math.random(1, #shed_points)
                    local x,y,z = unpack(shed_points[shed_point])
                    local shed_marker = createMarker(x,y,z-1.2, "cylinder", 1, 255,255,255)
                    local blip = createBlip(x,y,z, 1)
                    setElementData(shed_marker, "shed_marker", true)
                    setElementData(plr, "shed_marker", shed_marker)
                    setElementParent(blip, shed_marker)
                else
                    local shed_point = math.random(1, #second_shed_points)
                    local x,y,z = unpack(second_shed_points[shed_point])
                                    local shed_marker = createMarker(x,y,z-1.2, "cylinder", 1, 255,255,255)
                    local blip = createBlip(x,y,z, 1)
                    setElementData(shed_marker, "shed_marker", true)
                    setElementData(plr, "shed_marker", shed_marker)
                    setElementParent(blip, shed_marker)
                end
            end
        end
    end
end)

addEventHandler("onClientMarkerHit", root, function(plr, dim)
    if plr == localPlayer then
        if getElementData(source, "shed_marker") == true then
            setPedAnimation(plr, "CARRY", "putdwn", -1, false)
            local hay = source
            setTimer(function()
                setPedAnimation(plr,"ped","walk_player",0,true,true,false,true)
                if isElement(hay) then
                    destroyElement(hay)
                    destroyElement(getElementData(plr, "hay"))
                end
                toggleControl("crouch", true)
                toggleControl("sprint", true)
                toggleControl("jump", true)
                setElementData(localPlayer, "hayCarry", false)
                hayAmmount = hayAmmount-1
                triggerServerEvent("payment", localPlayer, math.random(20, 35), math.random(1,5))
                if hayAmmount == 0 then 
                    wheatCarrier()
                end
            end, 800, 1)
        end
    end
end)

addEventHandler("endHayCarrying", root, function()
    for k,v in pairs(hayBales) do
        if isElement(hayBales[k]) then
            destroyElement(hayBales[k])
        end 
    end
    local marker = getElementData(source, "shed_marker", shed_marker)
    if marker ~= false then
        if isElement(marker) == true then
            destroyElement(marker)
        end 
    end
    toggleControl("crouch", true)
    toggleControl("sprint", true)
    toggleControl("jump", true)
    outputChatBox("#F4A603⚠️ #FFFFFFKończysz pracę.", 255,255,255, true)
end)