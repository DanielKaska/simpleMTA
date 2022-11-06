addEvent("vendingTransaction", true)


addEventHandler("vendingTransaction", root, function()
    local money = getElementData(source, "player.money")
    local health = getElementHealth(source)
    if money < 10 then
        outputChatBox("#F4A603⚠️ #FFFFFFNie stać Cię na ten produkt!", source, 255,255,255, true)
    else
        setElementData(source, "player.money", money-10)
        if health > 75 then
            setElementHealth(source, 100)
        else
            setElementHealth(source, health+25)
        end
    end
end)