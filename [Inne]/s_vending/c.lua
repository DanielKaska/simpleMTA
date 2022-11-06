addEventHandler("onClientResourceStart", root, function(res)
    if res == getThisResource() then
        for k,v in ipairs(getElementsByType("object")) do
            if getElementModel(v) == 1302 then
                local x,y,z = getElementPosition(v)
                local sphere = createColSphere(x,y,z+1, 2)
                setElementData(sphere, "vendingCuboid", true)
            end
        end
    end
end)

addEventHandler("onClientColShapeHit", root, function(el, md)
    if getElementData(source, "vendingCuboid") == true then
        if el == localPlayer and md == true then
            outputChatBox("Aby dokonać zakupu w #F4A603automacie #FFFFFFwciśnij #F4A603E#FFFFFF.", 255,255,255, true)
        end
        bindKey("e", "down", buy)
    end
end)

addEventHandler("onClientColShapeLeave", root, function(el, md)
    if getElementData(source, "vendingCuboid") == true then
        if el == localPlayer and md == true then
            unbindKey("e", "down", buy)
        end
    end
end)

function buy(key, pressed)
    if key == "e" and pressed == "down" then
        if transaction == true then return end
        transaction = true
        setPedAnimation(localPlayer, "vending", "vend_use", 2000, false)
        setTimer(function()
            triggerServerEvent("vendingTransaction", localPlayer)
            setPedAnimation(localPlayer, "vending", "vend_drink2_p", 1500, false)
        end, 2000, 1)

        setTimer(function()
            setPedAnimation(localPlayer)
            transaction = false
            unbindKey("e", "down", buy)
        end, 3500, 1)

    end
end