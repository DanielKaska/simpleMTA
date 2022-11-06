addCommandHandler("pala", function(plr)
    if getElementData(plr, "sapd.duty") == true then
        giveWeapon(plr, 3)
    end
end)

addCommandHandler("taser", function(plr)
    if getElementData(plr, "sapd.duty") == true then
        giveWeapon(plr, 23)
    end
end)

---------------------------------------------------------------------------------------------------------
addEventHandler("onPlayerDamage", root, function(officer, cause, _, dmg) -- stunowanie po uderzeniu palka
    local plr = source
    if cause ~= 3 then return end
    setElementHealth(plr, getElementHealth(plr)+dmg)
    if getElementData(plr, "frozen") == true then return end
    
    if getPedWeapon(officer) == 3 then
        setPedAnimation(plr,"ped", "KO_shot_face", 10000, false)
        setElementData(plr, "frozen", true)
        toggleAllControls(plr, false)
        outputChatBox("* Tracisz przytomność", plr)
        triggerClientEvent(plr, "showRadar2", plr)
        triggerClientEvent(plr, "showHud", plr)
        fadeCamera(plr, false, 2.5)

        local timer = setTimer(function()
            setPedAnimation(plr,"ped", "getup", 1, false)
            removeElementData(plr, "frozen")
            toggleAllControls(plr, true)
            triggerClientEvent(plr, "showRadar2", plr)
            triggerClientEvent(plr, "showHud", plr)
            fadeCamera(plr, true, 2.5)
            killTimer(getElementData(plr, "pala_timer"))
        end, 15000, 1)

        setElementData(plr, "pala_timer", timer)
    end
end)
---------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------
addEventHandler("onPlayerDamage", root, function(officer, cause, _, dmg) -- stunowanie po strzeleniu taserem
    local plr = source
    if cause ~= 23 then return end
    setElementHealth(plr, getElementHealth(plr)+dmg)
    if getElementData(plr, "frozen") == true then return end

    if getPedWeapon(officer) == 23 then
        setPedAnimation(plr, "ped", "bike_fall_off", 1, false)
        setElementData(plr, "frozen", true)
        toggleAllControls(plr, false)
        outputChatBox("* Zostajesz postrzelony paralizatorem", plr)

        local timer2 = setTimer(function()
            setPedAnimation(plr,"ped", "getup", 1, false)
            removeElementData(plr, "frozen")
            toggleAllControls(plr, true)
            killTimer(getElementData(plr, "taser_timer"))
        end, 30000, 1)

        setElementData(plr, "taser_timer", timer2)
    end
end)
---------------------------------------------------------------------------------------------------------