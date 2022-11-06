function trigger()
    function speedo()

        if isPedInVehicle(localPlayer) == false then return end

        local veh = getPedOccupiedVehicle(localPlayer)
        local speedx, speedy, speedz = getElementVelocity(veh)
        local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
        local kmh = actualspeed * 180

        dxDrawText(string.format("%d", kmh), 1700, 900, 1750, 950, tocolor(255,255,255,255), 2)
    end
    addEventHandler("onClientRender", root, speedo)



end
addEventHandler("onClientVehicleEnter", root, trigger)

