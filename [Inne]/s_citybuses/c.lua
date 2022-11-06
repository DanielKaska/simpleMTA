local DGS = exports.DGS

local stops = {
    {1352.612061, 212.603363, 19.554688, 244},
    {195.648102, -79.466232, 1.578125, 270},
    {708.011902, 307.141968, 20.234375, 274},
    {999.491455, -463.301208, 50.55, 125},
    {729.9, -568.647034, 16.335938, 0},
    {1021.877014, -459.043671, 51.294083},
    {1025.983521, -464.659027, 51.444939}
}

local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX
local font = dxCreateFont("font.ttf", 15)

for i = 1, #stops do 
    local x,y,z,r = unpack(stops[i])
    local busStop = createObject(1257, x, y, z, 0,0,r)
    createBlip(x,y,z, 6, 1, 255,255,0,255)
    setObjectBreakable(busStop, false)
    busMarker = createMarker(x, y, z-0.9, "cylinder", 1, 255,255,255,0)
    setElementData(busMarker, "busMarker", i)
    setElementData(busMarker, "marker", true)
end

local images = {
    {"img/img1.jpg", "#F5AF48Montgomery#FFFFFF, znajdziesz tu: \n-Pizzerię"},
    {"img/img2.jpg", "#F5AF48Blueberry#FFFFFF, znajdziesz tu: \n-Spawn,\n-Przechowalnię,\n-Bazę TSSA,\n-Komis z tanimi autami,\n-Farmę"},
    {"img/img3.jpg", "#F5AF48Bazar"},
    {"img/img4.jpg", "#F5AF48Dillimore #FFFFFF, znajdziesz tu: \n-Posterunek policji,\n-Przechowalnię"},
    {"img/img4.jpg", "#F5AF48Johnson's Acres#FFFFFF, znajdziesz tu: \n-Farmę"},
    {"img/img4.jpg", "#F5AF48Johnson's Acres#FFFFFF, znajdziesz tu: \n-Farmę"},
    {"img/img4.jpg", "#F5AF48Johnson's Acres#FFFFFF, znajdziesz tu: \n-Farmę"}
}

function d()
    local img = unpack(images[x])
    dxDrawImage(scaleX*860,scaleY*490+x*10, scaleX*200, scaleY*100, img)
end 

function e()
    local img = unpack(images[x])
    dxDrawImage(scaleX*860,scaleY*490, scaleX*200, scaleY*100, img)
end

function chooseDestination(key, keyState)
    if key == "arrow_l" and keyState == "up" then 
        if x == 1 then return end
        x=x-1

        if i == true then
            removeEventHandler("onClientRender", root, s)
        end

        function s()
            i = true
            ss = true
            local img, txt = unpack(images[x])
            dxDrawText(txt, scaleX*560,scaleY*220, scaleX*1360,scaleY*760, tocolor(255,255,255,255), scaleX*1, font, "center", "center", nil, nil, true, true)
            dxDrawImage(scaleX*560,scaleY*220, scaleX*800, scaleY*540, img)
            if x > 1 then
                local img = unpack(images[x-1])
                dxDrawImage(scaleX*140,scaleY*360, scaleX*400, scaleY*220, img)
            end
            if x < 7 then
                local img = unpack(images[x+1])
                dxDrawImage(scaleX*1380,scaleY*360, scaleX*400, scaleY*220, img)
            end
        end 
        addEventHandler("onClientRender", root, s)


    end

    if key == "arrow_r" and keyState == "up" then 
        if x == 7 then return end
        x=x+1
        removeEventHandler("onClientRender", root, drawStops)
        if ii == true then
            removeEventHandler("onClientRender", root, e)
        end

        function e()
            ii = true
            ee = true
            local img, txt = unpack(images[x])
            dxDrawText(txt, scaleX*560,scaleY*220, scaleX*1360,scaleY*760, tocolor(255,255,255,255), scaleX*1, font, "center", "center", nil, nil, true, true)
            dxDrawImage(scaleX*560,scaleY*220, scaleX*800, scaleY*540, img)
            if x > 1 then
                local img = unpack(images[x-1])
                dxDrawImage(scaleX*140,scaleY*360, scaleX*400, scaleY*220, img)
            end
            if x < 7 then
                local img = unpack(images[x+1])
                dxDrawImage(scaleX*1380,scaleY*360, scaleX*400, scaleY*220, img)
            end
        end 
        addEventHandler("onClientRender", root, e)
    end

    function a(plr, m)
        if source == false then return end
        if localPlayer == plr then
            if getElementData(source, "busMarker") == false then return end
            if m == true then
                showing = false
                removeEventHandler("onClientRender", root, drawStops)
                toggleControl("right", true)
                toggleControl("left", true)
                toggleControl("enter_exit", true)
                unbindKey("arrow_r", "up", chooseDestination)
                unbindKey("arrow_l", "up", chooseDestination)
                unbindKey("enter", "up", travel)
                if ee == true then
                    removeEventHandler("onClientRender", root, e)
                end

                if ss == true then
                    removeEventHandler("onClientRender", root, s)
                end
            end
        end
    end
    addEventHandler("onClientMarkerLeave", root, a)

end


function travel(key, state)
    if key == "enter" and state == "up" then
        posx,posy,posz = unpack(stops[x])
        local pox, poy, poz = getElementPosition(localPlayer)
        time = (getDistanceBetweenPoints3D(pox, poy, poz, posx, posy, posz))/65

        if time < 5 then 
            outputChatBox("Tyle to chyba możesz przejść z buta..")
        return end

        triggerEvent("sendAlert", localPlayer, "Podróż będzie trwała #F5AF48"..string.format("%d", time).."#FFFFFF s.", 250)
        unbindKey("arrow_r", "up", chooseDestination)
        unbindKey("arrow_l", "up", chooseDestination)
        unbindKey("enter", "up", travel)
        
        if ss == true then
            removeEventHandler("onClientRender", root, s)
        end
        if ee == true then
            removeEventHandler("onClientRender", root, e)
        end
        ss = false
        ee = false
        ii = false
        aa = false
        fadeCamera(false, 2)
        setTimer(freeze, 2100, 1)
        setTimer(travel2, time*1000, 1)
    end
end

function freeze()
    setElementPosition(localPlayer, 0,0,-10)
    setElementFrozen(localPlayer, true)
end

function travel2()
    fadeCamera(true, 2)
    showing = false
    setElementPosition(localPlayer, posx,posy+1.5,posz)
    setElementFrozen(localPlayer, false)
end


function triggerGui(plr, m)
    if localPlayer == plr then
        if source == false then return end
        if getElementData(source, "busMarker") == false then return end
        if m == true then
            x = 1
            i = false
            ii = false
            if showing == true then return end
            showing = true
            bindKey("arrow_r", "up", chooseDestination)
            bindKey("arrow_l", "up", chooseDestination)
            toggleControl("enter_exit", false)
            bindKey("enter", "up", travel)
            toggleControl("right", false)
            toggleControl("left", false)
            --showChat(false)

            function drawStops()
                dxDrawImage(scaleX*560,scaleY*220, scaleX*800, scaleY*540, "img/img1.jpg", 0, 0, 0, nil, true)
                dxDrawImage(scaleX*1380,scaleY*360, scaleX*400, scaleY*220, "img/img2.jpg", 0, 0, 0, nil, true)
                dxDrawText("Wybierz strzałkami #F5AF48< > #FFFFFFmiejsce docelowe.", scaleX*860,scaleY*50, scaleX*1060, scaleX*70, tocolor(255,255,255,200), scaleX*1, font, "center", "center", false, true, true, true)
                dxDrawText("Wybór zatwierdź klikając #F5AF48ENTER.", scaleX*860,scaleY*70, scaleX*1060, scaleX*90, tocolor(255,255,255,200), scaleX*1, font, "center", "center", false, true, true, true)
                dxDrawText("#F5AF48Montgomery#FFFFFF, znajdziesz tu: \n-Pizzerię", scaleX*560,scaleY*220, scaleX*1360,scaleY*760, tocolor(255,255,255,255), scaleX*1, font, "center", "center", nil, nil, true, true)
                
            end 
            addEventHandler("onClientRender", root, drawStops)

            function drawRect()
                dxDrawRectangle(scaleX*0.01, scaleY*0.01, scaleX*1920, scaleY*1080, tocolor(16,16,16,190))
            end
            addEventHandler("onClientRender", root, drawRect)

        end
    end
end
addEventHandler("onClientMarkerHit", root, triggerGui)

function destroyGui(plr, m)
    if source == false then return end
    if localPlayer == plr then
        if getElementData(source, "busMarker") == false then return end
        if m == true then
            if showing == true then
                x = 0
                removeEventHandler("onClientRender", root, drawStops)
                removeEventHandler("onClientRender", root, drawRect)
                toggleControl("right", true)
                toggleControl("left", true)
                toggleControl("enter_exit", true)
                if aa ~= false then
                    unbindKey("arrow_r", "up", chooseDestination)
                    unbindKey("arrow_l", "up", chooseDestination)
                    unbindKey("enter", "up", travel)
                    showChat(true)
                    showing = false
                end 
            end
        end
    end
end
addEventHandler("onClientMarkerLeave", root, destroyGui)