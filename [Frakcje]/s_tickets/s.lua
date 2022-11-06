idSystem = exports.s_core
db = exports.s_dbconnect

local max_ticket_price = 5000
local max_points = 20
local max_given_points = 5

function ticket(playerSource, commandName, type, id, fine, points, reason)

    if getElementData(playerSource, "sara.duty") ~= true then if getElementData(playerSource, "sapd.duty") ~= true then return end end

    local id = tonumber(id)
    local fine = tonumber(fine)
    local points = tonumber(points)

    if id == nil then 
        outputChatBox("#ff0000❌ #ffffffPrawidłowe użycie: /mandat rodzaj_id(uid, id) id wysokosc_mandatu liczba_pkt powod", playerSource, 255,255,255, true)    
    return end
    
    if type == "id" or type == "uid" then

    if type == "id" then
        target = idSystem:findPlayer(plr, id)
        if target == false then
            outputChatBox("#ff0000❌ #ffffffNie znaleziono gracza.", playerSource, 255,255,255, true)
        return end
        uid = getElementData(target, "player.uid")
    end

    if type == "uid" then
        uid = id
    end

    if fine == nil then 
        outputChatBox("#ff0000❌ #ffffffPrawidłowe użycie: /mandat id wysokosc_mandatu liczba_pkt powod", playerSource, 255,255,255, true)    
    return end

    if points == nil then 
        outputChatBox("#ff0000❌ #ffffffPrawidłowe użycie: /mandat id wysokosc_mandatu liczba_pkt powod", playerSource, 255,255,255, true)    
    return end

    if tonumber(fine) > max_ticket_price then
        outputChatBox("#ff0000❌ #ffffffZbyt wysoka kwota mandatu.", playerSource, 255,255,255, true)
    return end
    if tonumber(points) > max_given_points then
        outputChatBox("#ff0000❌ #ffffffZbyt wysoka liczba punktów.", playerSource, 255,255,255, true)
    return end

    local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
    local monthday = time.monthday
	local month = time.month
	local year = time.year
	local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
    if reason == nil then 
        outputChatBox("#ff0000❌ #ffffffPodaj powód mandatu.", playerSource, 255,255,255, true)
    return end
    db:insert("INSERT INTO tickets (punished_uid, officer_uid, ammount, points, reason, data) VALUES (?,?,?,?,?,?)", uid, getElementData(playerSource, "player.uid"), fine, points, reason, formattedTime)
    outputChatBox("Wystawiono mandat graczowi UID: "..uid..", powód: "..reason..", kwota: "..fine..", pkt karne: "..points..".", playerSource)
    if type == "id" then
        outputChatBox("Otrzymałeś mandat od: "..getElementData(playerSource, "player.nickname")..", powód: "..reason..", kwota: "..fine..", pkt karne: "..points..".", target)
    end
    end
end
addCommandHandler("mandat", ticket)
