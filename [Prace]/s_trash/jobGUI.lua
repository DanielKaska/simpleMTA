loadstring(exports.dgs:dgsImportFunction())()

local job_desc = "Praca w S.A Sanitation Service \n\n\n Jeździj #F5AF48śmieciarką#FFFFFF, wypatruj #F5AF48śmietników #FFFFFFi wyładuj ich zawartość do wozu.\n Pamiętaj, aby zbierać tylko jeden rodzaj odpadów - w końcu recykling po coś jest.\n\nPo całkowitym zapełnieniu #F5AF48śmieciarki#FFFFFF, wróć na bazę, by zrzucić śmieci i odebrać #F5AF48wypłatę#FFFFFF."

local blur = exports.blur_box
local bg = dxCreateTexture("utilities/trash-bg.png")
local mask = dxCreateTexture("utilities/img.png")
local font = dxCreateFont("utilities/font.ttf", 15)
local font_thick = dxCreateFont("utilities/font-thick.ttf", 16)
local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX

addEvent("showTrashGUI", true)
addEvent("destroyTrashGUI", true)

local gui = {}

addEventHandler("showTrashGUI", root, function()
    local img = dgsCreateImage(scaleX*640, scaleY*350, scaleX*640, scaleY*360, bg, false, nil, tocolor(255,255,255,210))
    local img_mask = dgsCreateImage(scaleX*640, scaleY*350, scaleX*640, scaleY*360, mask, false, nil, tocolor(255,255,255,255))

    local rect_normal = dgsCreateRoundRect({{7,false},{7,false},{7,false},{7,false}},tocolor(16,16,16,210))
    local rect_hover = dgsCreateRoundRect({{7,false},{7,false},{7,false},{7,false}},tocolor(245,175,72,200))
    local button_start = dgsCreateButton(scaleX*880,scaleY*630,scaleX*160,scaleY*30, "Rozpocznij pracę", nil, nil, tocolor(255,255,255,255), scaleX*0.7, scaleX*0.7, rect_normal,rect_hover,rect_hover, tocolor(16,16,16,255),tocolor(245, 175, 72, 255),tocolor(245, 175, 72, 255))
    local label = dgsCreateLabel(scaleX*880,scaleY*430,scaleX*160,scaleY*30,job_desc, false, nil, tocolor(255,255,255,255), scaleX*0.75, scaleX*0.75)

    local properties = {}
    properties.font = font_thick
    properties.colorCoded = true
    properties.subPixelPositioning = true
    properties.alignment = {"center", "center"}
    dgsSetProperties(label, properties)

    dgsSetPostGUI(button_start, true)
    dgsSetPostGUI(label, true)
    dgsSetFont(button_start, font)

    blurBox = blur:createBlurBox(scaleX*640, scaleY*350, scaleX*640, scaleY*360, 255,255,255,255, false)
    blur:setBlurIntensity(1.5)

    table.insert(gui, #gui+1, {img, img_mask, button_start, label, text_mask})

    addEventHandler("onDgsMouseClickDown", root, function()
        if source == button_start then
            triggerEvent("destroyTrashGUI", localPlayer)
            triggerServerEvent("serverTrashCollect", localPlayer)
        end
    end)

end)

function destroyGUI()
    for k,v in ipairs(gui) do
        for key, val in ipairs(v) do
            destroyElement(v[key])
        end
        blur:destroyBlurBox(blurBox)
        table.remove(gui, k)
    end
end
addEventHandler("destroyTrashGUI", root, destroyGUI)