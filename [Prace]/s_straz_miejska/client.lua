addEvent("startStrazMiejska", true)
addEvent("stopStrazMiejska", true)

function math.round(num, decimals)
    decimals = math.pow(10, decimals or 0)
    num = num * decimals
    if num >= 0 then num = math.floor(num + 0.5) else num = math.ceil(num - 0.5) end
    return num / decimals
end

addEventHandler("startStrazMiejska", root, function()
    addEventHandler("onClientRender", root, monitorEarnings)
    timerStart = getTickCount()
end)

addEventHandler("stopStrazMiejska", root, function()
    removeEventHandler("onClientRender", root, monitorEarnings)
    local timer = monitorEarnings()
    local workedFor = ((timer-timerStart)/1000)/60

    if workedFor < 1 then workedFor = 0 end
    triggerServerEvent("payment", source, math.round(workedFor)*25, 0)
    outputChatBox("* Przepracowałeś/aś "..string.format("%d", workedFor).." min.")
end)

function monitorEarnings()
    timer = getTickCount()
    return timer
end