local startJob = createMarker(-197.084229, 99.947639, 1.8, "cylinder", 1.5, 255,255,255,0)

setElementData(startJob, "marker_job", true)

addEventHandler("onPlayerMarkerHit", root, function(marker, dim)
    if marker == startJob and dim == true then 
        local plr = source

        --[[
            tutaj sprawdzic, czy gracz jest w pracy (player.working)
        ]]

        if getElementData(plr, "player.office_job") == "sluzba_miejska" then
            triggerClientEvent(plr, "showTrashGUI", plr)
        else
            outputChatBox("* Musisz zatrudnić się w urzędzie, aby podjąć tu pracę.")
        end
    end
end)

addEventHandler("onMarkerLeave", root, function(plr, dim)
    if getElementType(plr) == "player" and dim == true then
        triggerClientEvent(plr, "destroyTrashGUI", plr)
    end
end)

