addEvent("payment", true)

local nextLevel = 100

local db = exports.s_dbconnect

function payment(ammount, exp_ammount, uid)
    local money = getElementData(source, "player.money")
    local exp = getElementData(source, "player.exp")
    local lvl = getElementData(source, "player.level")
    setElementData(source, "player.money", money+ammount)
    setElementData(source, "player.exp", exp+exp_ammount)
    if exp+exp_ammount >= (lvl*nextLevel) then
        setElementData(source, "player.level", lvl+1)
        setElementData(source, "player.exp", 0)
        triggerClientEvent(source, "sendAlert", source, "Level UP!", 200)
    end
    outputChatBox("#dcdcdcOtrzymałeś #F5AF48".."$"..ammount..", "..exp_ammount.." [XP] ", source, 255,255,255, true)
end
addEventHandler("payment", getRootElement(), payment) 

function savePlayer()
    local uid = getElementData(source, "player.uid")
    if uid == false then return end
    local money = getElementData(source, "player.money")
    local exp = getElementData(source, "player.exp")
    local lvl = getElementData(source, "player.level")
    local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
    local monthday = time.monthday
	local month = time.month
	local year = time.year
	local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
    iprint(uid.." "..money.." "..exp.." "..lvl)
    db:insert("UPDATE players SET money=? where uid=?", money, uid)
    db:insert("UPDATE players SET exp=? where uid=?", exp, uid)
    db:insert("UPDATE players SET level=? where uid=?", lvl, uid)
    db:insert("INSERT INTO payment_logs (uid,money,xp,level,data) VALUES (?,?,?,?,?)", uid, money, exp, lvl, formattedTime)
end 
addEventHandler("onPlayerQuit", root, savePlayer) 


--local test_marker = createMarker(174.054764, -13.366369, 1.584573, "cylinder", 1.5, 255, 255, 0, 170 )

--[[function dajcos()
    local uid = getElementData(source, "player.uid")
    triggerEvent("payment", source, math.random(30, 90), math.random(100, 200), uid)
end
addEventHandler("onPlayerMarkerHit",getRootElement(),dajcos)]]