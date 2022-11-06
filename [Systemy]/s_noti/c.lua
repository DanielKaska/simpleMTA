local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX

addEvent("sendAlert", true)

local font = dxCreateFont("Nunito-Regular.ttf", 15)

DGS = exports.dgs

alerts = {}

showing = false

function alertHandler(message, duration)

    
    local sound = playSound("alert_sound.mp3")
    setSoundVolume(sound, 0.5)

    local alert = createElement("alert")
    setElementData(alert, "alert.message", message)
    setElementData(alert, "alert.duration", duration)
    setElementID(alert, #alerts+1)
    table.insert(alerts, #alerts+1, alert)
    
    for k,v in ipairs(alerts) do
        local timer = setTimer(function()
            if unpack(alerts) == nil then
                for k,v in ipairs(getElementsByType("alert")) do
                    destroyElement(v)
                end
                removeEventHandler("onClientRender", root, drawAlert)
            return end
            if isElement(v) then
                setElementData(v, "alert.message", "")
                local id = getElementID(v)
                table.remove(alerts, id)
            end
        end, duration*10, 1)

        function drawAlert()
            if isElement(v) then
                local text = getElementData(v, "alert.message")
                if text == false then return end
                dxDrawText(text, scaleX*860, scaleY*100+(k*20), scaleX*1060, scaleY*200+(k*20), tocolor(255,255,255,255), scaleX*1, scaleY*1, font, "center", "top", false, true, false, true)
            end
        end
        addEventHandler("onClientRender", root, drawAlert)
    end
end
addEventHandler("sendAlert", getRootElement(), alertHandler)