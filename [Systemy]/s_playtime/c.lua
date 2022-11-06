--5 min = 300 000 ms
addEvent("startPlaytime", true)

function playtime(plr)
        p = plr
        count = setTimer(function()
            local time = getElementData(plr, "player.playtime")
            setElementData(plr, "player.playtime", time+5)
        end, 300000, 0)
        setElementData(plr, "playtime.timer", count)
end
addEventHandler("startPlaytime", root, playtime)

--[[addEventHandler("onClientPlayerQuit", root, function()
    iprint(source)
    local timer = getElementData(source, "playtime.timer")
    iprint(timer)
    killTimer(timer)
    triggerServerEvent("savePlaytime", source, source)
end)]]
