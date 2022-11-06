addEvent("getHistory", true)
addEvent("getInfo", true)
addEvent("passChange", true)
local db = exports.s_dbconnect

function data(plr, uid)
    local q = db:get("SELECT * FROM (SELECT * FROM payment_logs where uid = ? ORDER BY nrTransakcji DESC LIMIT 7) sub ORDER BY nrTransakcji ASC", uid)
    if #q <7 then return end

    for i=1, #q do
        local tID = q[i]['nrTransakcji']
        local m = q[i]['money']
        local xp = q[i]['xp']
        local lvl = q[i]['level']
        local data = q[i]['data']
        triggerClientEvent(plr, "receiveHistory", plr, tID, m, xp, lvl, data, i)
    end
end
addEventHandler("getHistory", root, data)

function info(plr, uid)
    local i = db:get("SELECT * FROM players where uid = ?", uid)
    current = i[1]['password']
    local accountAge = i[1]["created"]
    local lastLogin = i[1]["last_login"]
    local login = i[1]["login"]
    triggerClientEvent(plr, "receiveInfo", plr, accountAge, lastLogin, login)
end
addEventHandler("getInfo", root, info)

function changePass(plr, uid, oldPass, newPass, confirmPass)
    if md5(oldPass) == current then

        if newPass == confirmPass then
            db:insert("UPDATE players SET password=? WHERE uid=?", md5(newPass), uid)
            triggerClientEvent(plr, "sendAlert", plr, "Zmienieno hasło, pamiętaj, aby nigdy nie podawać go byle komu.", 300)
        end
    else
        triggerClientEvent(plr, "sendAlert", plr, "Podano nieprawidłowe dane.", 300)
    end 
end
addEventHandler("passChange", root, changePass)