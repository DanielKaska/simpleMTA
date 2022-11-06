local db = exports.s_dbconnect

addEvent("savePlaytime", true)

addEventHandler("onPlayerQuit", root, function()
    local t = getElementData(source, "player.playtime")
    local uid = getElementData(source, "player.uid")
    db:insert("UPDATE players SET playtime = ? WHERE uid = ?", t, uid)
end)