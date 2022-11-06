addEvent("office_job_gui", true)
addEvent("office_job_gui_destroy", true)
loadstring(exports.dgs:dgsImportFunction())()

setTimer(function()
    b = exports.blur_box
end, 5000, 1)


local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX

local font = dxCreateFont("font.ttf", scaleX*12)
local img = dxCreateTexture("i/img.png")


--[[
    sm_now = number of workers
    trash_now = number of workers
]]

rendering = false

addEventHandler("office_job_gui", root, function(sm_now, trash_now)
    if rendering == true then return end
    rendering = true
    blur = b:createBlurBox(scaleX*810, scaleY*400, scaleX*290, scaleY*170, 255,255,255,255, false)
    b:setBlurIntensity(2)
    button = dgsCreateButton(scaleX*895, scaleY*515, scaleX*120, scaleX*30, "Zatrudnij się", false, nil, nil, scaleX*0.95, scaleX*0.95, nil, nil, nil, tocolor(16,16,16,140), tocolor(245, 175, 72,140), tocolor(245, 175, 72,200))
    list = dgsCreateGridList(scaleX*810, scaleY*400, scaleX*290, scaleY*150)

    local column = dgsGridListAddColumn(list, "", 1)
    sm = dgsGridListAddRow(list, 1, "Straż Miejska "..sm_now.."/20 zatrudnionych")
    sp = dgsGridListAddRow(list, 2, "Służba porządkowa "..trash_now.."/80 zatrudnionych")
    img2 = dgsCreateImage(scaleX*810, scaleY*400, scaleX*290, scaleY*170, img)
    dgsSetProperty(list,"sortEnabled",false)
    dgsSetProperty(list,"bgColor",tocolor(16,16,16,0))
    dgsSetProperty(list,"columnColor",tocolor(16,16,16,0))
    dgsGridListSetRowBackGroundColor(list, 1, tocolor(16,16,16,0), tocolor(245, 175, 72,140), tocolor(245, 175, 72,200))
    dgsGridListSetRowBackGroundColor(list, 2, tocolor(16,16,16,0), tocolor(245, 175, 72,140), tocolor(245, 175, 72,200))
    dgsGridListSetItemData(list, 1, column, "sm")
    dgsGridListSetItemData(list, 2, column, "sp")
    dgsSetFont(list, font)
    dgsSetPostGUI(list, true)
    dgsSetPostGUI(button, true)
    dgsSetLayer(button, "top")
    dgsSetLayer(list, "center")
    dgsSetLayer(img2, "bottom")
    dgsSetFont(button, font)

    addEventHandler("onDgsMouseClickDown", button, function(b)
        if cooldown == true then outputChatBox("* Odczekaj chwilę przed kolejnym kliknięciem") return end
        local selected = dgsGridListGetSelectedItem(list)
        if selected < 0 then return end

        cooldown = true
        setTimer(function()
            cooldown = false
        end, 10000, 1)

        if selected == 1 then

            if sm_now == 32 then
                outputChatBox("* Brak miejsc!")
            return end

            triggerServerEvent("jobHired", localPlayer, "straz")
            
            elseif selected == 2 then

            if trash_now == 80 then
                outputChatBox("* Brak miejsc!")
            return end

            triggerServerEvent("jobHired", localPlayer, "sluzba_miejska")
        end
    end)

end)



addEventHandler("office_job_gui_destroy", root, function()
    b:destroyBlurBox(blur)
    destroyElement(list)
    destroyElement(button)
    destroyElement(img2)
    rendering = false
end)