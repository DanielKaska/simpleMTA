addEvent("examSuccessB", true)
addEvent("examSuccessC", true)
local db = exports.s_dbconnect

local aMarker = createMarker(70.701958, 127.711166, 1.5, "cylinder", 1, 245, 175, 72)
local bMarker = createMarker(78.328140, 122.936142, 1.5, "cylinder", 1, 245, 175, 72)
local cMarker = createMarker(75.908722, 124.625031, 1.5, "cylinder", 1, 245, 175, 72)

local examVehicles = {}

