addEvent("drawGUI", true)
addEvent("getData", true)
addEvent("destroyParking", true)

DGS = exports.dgs


local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX

local font = dxCreateFont("font.ttf", 15)
local background = dxCreateTexture("i/background.png")
local take_tab = dxCreateTexture("i/take_tab.png")
local bars = dxCreateTexture("i/bars.png")

local button = dxCreateTexture("i/button.png")
local button_click = dxCreateTexture("i/button_click.png")

local car_marker = dxCreateTexture("i/car.png")
local garage = dxCreateTexture("i/garage.png")
local size = 1
local x,y,z = 162.314285, -25.748814, 1.578125

addEventHandler("onClientRender", root, function()
    dxDrawMaterialLine3D(x, y, z+0.6, x, y, z-0.6, car_marker, size,tocolor(255,255,255, 255), false)
    dxDrawMaterialLine3D(163.874191, -14.651442, 2.6, 163.874191, -14.651442, 1, garage, 2,tocolor(255,255,255, 255), false)
end)

scroll=0

function scrollUp()
    scroll=scroll+2
end

function scrollDown()
    scroll=scroll-2
end

function createBoxText(text, topX, topY, botX, botY, color, scalex, scaley, font)
    if topY < scaleY*1050 then
        if topY > scaleY*680 then
            dxDrawText(text, topX, topY, botX, botY, color, scalex, scaley, font, "center", false, false, false, false)
        end
    end
end

data = {}
textElements = {}

function loadVehicles(vid, veh_id, uid, mileage, ld, i)
    table.insert(data, i, {vid, veh_id, uid, mileage, ld})
    inc = i
end
addEventHandler("getData", root, loadVehicles)

function trigger()
    bindKey("mouse_wheel_up", "down", scrollUp)
    bindKey("mouse_wheel_down", "down", scrollDown)
    local closeParking = DGS:dgsCreateButton(scaleX*885,scaleY*1000,scaleX*150,scaleY*30, "Zamknij", nil, nil, tocolor(255,255,255,255), scaleX*1, scaleX*1, nil, nil, nil, tocolor(16,16,16,255),tocolor(245, 175, 72, 255),tocolor(245, 175, 72, 255))
    local bgrd = DGS:dgsCreateImage(scaleX*0.01, scaleY*0.01, scaleX*1920, scaleY*1080, background)
    local tab = DGS:dgsCreateImage(scaleX*785, scaleY*300, scaleX*350, scaleY*500, take_tab)
    local bars = DGS:dgsCreateImage(scaleX*785, scaleY*280, scaleX*350, scaleY*500, bars)
    local takeButton = DGS:dgsCreateButton(scaleX*885,scaleY*700,scaleX*150,scaleY*30, "Wyciągnij pojazd", nil, nil, tocolor(0,0,0,255), scaleX*0.7, scaleY*0.7, button, button_click, button_click, tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(255,255,255,255))
    local targetCar = DGS:dgsCreateEdit(scaleX*870, scaleY*630, scaleX*180, scaleY*30, "", false, false, tocolor(0,0,0,255), scaleX*0.7, scaleX*0.7, nil, tocolor(0,0,0,0))
    DGS:dgsSetLayer(closeParking, "top")
    DGS:dgsSetLayer(bgrd, "bottom")
    DGS:dgsSetLayer(tab, "center")
    DGS:dgsSetLayer(takeButton, "top")
    DGS:dgsSetLayer(targetCar, "top")

    DGS:dgsSetProperty(targetCar, "caretColor", tocolor(0,0,0,255))

    DGS:dgsSetProperty(tab,"postGUI",false)
    DGS:dgsSetProperty(bars,"postGUI",true)

    DGS:dgsEditSetPlaceHolder(targetCar, "Podaj ID pojazdu" )
    DGS:dgsSetProperty(targetCar,"placeHolderFont",font)
    DGS:dgsSetFont(takeButton, font)
    DGS:dgsSetFont(targetCar, font)
    DGS:dgsSetFont(closeParking, font)
    
    triggerEvent("showRadar2", localPlayer)
    triggerEvent("showHud", localPlayer)
    addEventHandler("onClientRender", root, drawParking)
    showCursor(true)
    showChat(false)

    function destroyParking()
        if isElement(bgrd) == false then return end
            triggerEvent("showRadar2", localPlayer)
            triggerEvent("showHud", localPlayer)
            destroyElement(bgrd)
            destroyElement(closeParking)
            destroyElement(tab)
            destroyElement(takeButton)
            destroyElement(targetCar)
            destroyElement(bars)
            removeEventHandler("onClientRender", root, drawParking)
            showCursor(false)
            showChat(true)
            data = nil
            textElements = nil
            data = {}
            textElements = {}
            scroll=0
            unbindKey("mouse_wheel_up", "down", scrollUp)
            unbindKey("mouse_wheel_down", "down", scrollDown)
    end
    addEventHandler("onDgsMouseClickDown", closeParking, destroyParking)
    addEventHandler("destroyParking", root, destroyParking)

    addEventHandler("onDgsMouseClickDown", takeButton, function()
        local chosen = DGS:dgsGetText(targetCar)
        triggerServerEvent("createVeh", localPlayer, chosen, localPlayer)
    end)
end
addEventHandler("drawGUI", root, trigger)


function drawParking()
    for k,v in ipairs(data) do
        local vid, veh, uid, mileage, ld = unpack(data[k])
        createBoxText(vid, scaleX*850, scaleY*750+((k*(scaleY*40))+(scroll*15)), scaleX*870, scaleY*100, tocolor(0,0,0,255), scaleX*0.9, font)
        createBoxText(getVehicleNameFromModel(veh), scaleX*930, scaleY*750+((k*(scaleY*40))+(scroll*15)), scaleX*990, scaleY*100, tocolor(0,0,0,255), scaleX*0.9, font)
        createBoxText(mileage, scaleX*1030, scaleY*750+((k*(scaleY*40))+(scroll*15)), scaleX*1100, scaleY*100, tocolor(0,0,0,255), scaleX*0.9, font)
    end
end