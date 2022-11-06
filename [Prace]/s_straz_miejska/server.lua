local marker = createMarker(654.257019, -553.924133, 15.4, "cylinder", 1.7, 255,255,255,0)
local db = exports.s_dbconnect
setElementData(marker, "marker_text", "Straż miejska")



addEventHandler("onPlayerMarkerHit", root, function(m, md)
    if m == marker and md then 
        local uid = getElementData(source, "player.uid")

        if getElementData(source, "player.working") == "straz_miejska" then
            outputChatBox("* Kończysz pracę.", source)
            setElementModel(source, getElementData(source, "player.skin"))
            setElementData(source, "player.working", false)
            triggerClientEvent(source, "stopStrazMiejska", source)
        return end

        if getElementData(source, "player.working") ~= false then return end

        local isHired = db:get("select job from office_jobs where uid = ?", uid)
        if #isHired > 0 then
            setElementModel(source, 71)
            setElementData(source, "player.working", "straz_miejska")
            local time = getRealTime()
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second
            local monthday = time.monthday
            local month = time.month
            local year = time.year
            local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
            triggerClientEvent(source, "startStrazMiejska", source)
            db:insert("update office_jobs set last_seen = ? where uid = ?", formattedTime, uid)
        end
    end
end)