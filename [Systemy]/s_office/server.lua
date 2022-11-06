local marker = createMarker(656.653503, -549.966431, 15.4, "cylinder", 1.7, 255,255,255,0)
local db = exports.s_dbconnect
setElementData(marker, "marker_text", "Oferty pracy")

addEvent("jobHired", true)

addEventHandler("onPlayerMarkerHit", root, function(m, md)
    if m == marker and md == true then
        local plr = source
        local sm_count = db:get("select * from office_jobs where job = 'straz'")
        local trash_count = db:get("select job from office_jobs where job = 'sluzba_miejska'")
        triggerClientEvent(plr, "office_job_gui", plr, #sm_count, #trash_count)
    end
end)

addEventHandler("onPlayerMarkerLeave", root, function(m, md)
    if m == marker and md == true then
        triggerClientEvent(source, "office_job_gui_destroy", source)
    end
end)

addEventHandler("jobHired", root, function(job)
    local uid = getElementData(source, "player.uid")
    local count = db:get("select * from office_jobs where uid = ?", uid)
    if #count > 0 then outputChatBox("* Jesteś już zatrudniony", source) return end

    local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
    local monthday = time.monthday
	local month = time.month
	local year = time.year
    local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)

    db:insert("insert into office_jobs values (?,?,?,?)", job, uid, formattedTime, formattedTime)
    triggerClientEvent(source, "sendAlert", source, "Zostałeś zatrudniony przez urząd", 300)
    setElementData(source, "player.office_job", job)
end)


setTimer(function()
    local current_time = getRealTime()
    local players = db:get("select uid, UNIX_TIMESTAMP(last_seen) from office_jobs")
    for k,v in pairs(players) do
        local time = players[k]["UNIX_TIMESTAMP(last_seen)"]
        local time_elapsed = (current_time.timestamp+7200-time)/3600
        if time_elapsed >= 24 then
            db:insert("DELETE FROM `office_jobs` WHERE `uid` = ?", players[k]["uid"])
            for key, plr in ipairs(getElementsByType("player")) do
                if getElementData(plr, "player.uid") == players[k]["uid"] then
                    setElementData(plr, "player.office_job", false)
                    outputChatBox("* Zostałeś zwolniony przez urząd ze względu na zbyt małą aktywność w pracy.", plr)
                end
            end
        end
    end
end, 3600000, 0)