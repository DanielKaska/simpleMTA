addEvent("onPlayerHandcuffed", true)
addEvent("onPlayerUnHandcuffed", true)

cooldown = false
vehCooldown = false
addCommandHandler("komputer", function(commandName, dataType, id)
    if getElementData(localPlayer, "sapd.duty") == true then
        if dataType == "gracz" then
            if cooldown == false then
                cooldown = true
                if id == nil then triggerClientEvent(source, "sendAlert", source, "Podano nieprawidłowe dane.", 200) return end
                triggerServerEvent("getDataSAPD", localPlayer, dataType, id)
                setTimer(function() cooldown = false end, 10000, 1)
            else
                outputChatBox("* Zaczekaj 10 sekund przed następnym użyciem komputera.")
            end
        elseif dataType == "pojazd" then
            if vehCooldown == false then
                vehCooldown = true
                triggerServerEvent("getDataSAPD", localPlayer, dataType, id)
                setTimer(function() vehCooldown = false end, 10000, 1)
            else
                outputChatBox("* Zaczekaj 10 sekund przed następnym użyciem komputera.")
            end
        end
    end
end)

------------------------------------------------------------------------------------------------------------ wylaczanie i wlaczanie kolizji w kajdankach
function noColision()
    for i,v in pairs(getElementsByType("vehicle")) do
        setElementCollidableWith(v, source, false)
    end
end
addEventHandler("onPlayerHandcuffed", root, noColision)

function Colision()
    for i,v in pairs(getElementsByType("vehicle")) do
        setElementCollidableWith(v, source, true)
    end
end
addEventHandler("onPlayerUnHandcuffed", root, Colision)
------------------------------------------------------------------------------------------------------------

