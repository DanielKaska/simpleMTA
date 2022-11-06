addEvent("chooseSpawn", true)

local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX
local font = dxCreateFont("font.ttf", 15)





local s_bb = dxCreateTexture("i/spawn_blueberry.png")
local s_dillimore = dxCreateTexture("i/spawn_dillimore.png")
local s_montgomery = dxCreateTexture("i/spawn_montgomery.png")

local img = dxCreateTexture("i/img.png")

setTimer(function()
    b = exports.blur_box
end, 500, 1)

local dgs = exports.dgs

local spawns = {
    {"Blueberry", 170.163681, -123.940300, 1.549520, 0, s_bb},
    {"Dillimore", 729.609863, -573.678650, 16.335938, 90, s_dillimore},
    {"Montgomery", 2269.917725, -75.457100, 26.772381, 180, s_montgomery}
}

local buttons = {}

addEventHandler("chooseSpawn", root, function()
    for k,v in pairs(spawns) do
        local text, x, y, z, r, image = unpack(spawns[k])
        local button = dgs:dgsCreateButton(scaleX*400+k*scaleX*230, scaleY*300, scaleX*200, scaleY*340, text, nil, nil, tocolor(255,255,255,255), scaleX*0.9, scaleX*0.9, image,image,image, tocolor(255, 255, 255, 200),tocolor(255, 255, 255, 255),tocolor(255, 255, 255, 255))
        table.insert(buttons, k, button)
        setElementData(button, "spawnButton", true)
        setElementData(button, "spawnData", {x,y,z,r})
        dgs:dgsSetPostGUI(button, true)
        dgs:dgsSetLayer(button, "top")
        dgs:dgsSetFont(button, font)
    end
    img = dgs:dgsCreateImage(scaleX*480, scaleY*200,scaleX*960,scaleY*540, img)
    blur = b:createBlurBox(scaleX*481, scaleY*201, scaleX*958, scaleY*538, 255,255,255,255, false)
    b:setBlurIntensity(2)
end)

addEventHandler("onDgsMouseClickDown", root, function(b)
    if b == "left" and getElementData(source, "spawnButton") == true then
        local x,y,z,r = getElementData(source, "spawnData")
        triggerServerEvent("logged", localPlayer, localPlayer, x,y,z,r)
        for k,v in pairs(buttons) do
            destroyElement(v)
        end
        destroyElement(img)
        exports.blur_box:destroyBlurBox(blur)
        buttons = nil
    end
end)