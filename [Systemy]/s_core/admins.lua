--[[
1 - Supporter
2 - Moderator
3 - Administrator
4 - Administrator RCON
5 - Właściciel
]]

local db = exports.s_dbconnect


function adm_duty(playerSource)
    local admin = getElementData(playerSource, "player.admin")
    if admin == false then return end
        if admin == 1 or 2 or 3 or 4 or 5 then
            setElementData(playerSource, "admin.duty", admin)
            outputChatBox("Jesteś teraz na służbie.", playerSource)
        end
end
addCommandHandler("duty", adm_duty)

function adm_dutyoff(playerSource)
    if getElementData(playerSource, "player.admin") == false then return end
    if getElementData(playerSource, "admin.duty") == 0 then return end
        setElementData(playerSource, "admin.duty", false)
        outputChatBox("Nie jesteś już na służbie.", playerSource)
end
addCommandHandler("dutyoff", adm_dutyoff)

function vtp(playerSource, commandName, veh)
	if getElementData(playerSource, "admin.duty") == false then return end
	if getElementData(playerSource, "admin.duty") > 1 then
	if veh == nil then return end
	local wus = getElementByID("vehicle"..veh)

	local zrodlo = getElementData(playerSource, "player.nickname")
	if wus == false then
		outputChatBox("#FF2D00[/vtt]#ECF0F1 Pojazd znajduje się w przechowalni, lub nie istnieje.", playerSource, 255, 255, 255, true)
		outputChatBox("#FF2D00[/vtt]#ECF0F1 Upewnij się, że ID pojazdu zostało podane poprawnie. (Podane ID: "..veh..")", playerSource, 255, 255, 255, true)
	else
	warpPedIntoVehicle(playerSource, wus)
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
    local monthday = time.monthday
	local month = time.month
	local year = time.year
	local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
	triggerEvent("insert_tp_logs", root, zrodlo, "Pojazd ID: "..veh, formattedTime)
	end
end
end
addCommandHandler("vtt", vtp)

function restartRes(playerSource, commandName, res)
	if getElementData(playerSource, "admin.duty") == false then return end
		if getElementData(playerSource, "admin.duty") > 3 then
			local resource = getResourceFromName(res)
			restartResource(resource)
			outputChatBox("Uruchomiono ponownie zasób "..res..".", playerSource)
		end
end
addCommandHandler("r", restartRes)

function jp(playerSource)
	if getElementData(playerSource, "admin.duty") == false then return end 
	if getElementData(playerSource, "admin.duty") < 1 then return end

	setPedWearingJetpack(playerSource, not isPedWearingJetpack(playerSource))
end
addCommandHandler("jp", jp)

function teleportto(playerSource, commandName, id)
	if getElementData(playerSource, "admin.duty") ~= false then
	if getElementData(playerSource, "admin.duty") < 1 then return end
	if id == nil then return end
	local target = findPlayer(plr, id)
	if target == false then
		outputChatBox("#FF2D00[/tt]#ECF0F1 Nie znaleziono gracza. (Podane id: ".. id..").", playerSource, 255, 255, 255, true)
	return end
	local zrodlo = getElementData(playerSource, "player.nickname")
	local cel = getElementData(target, "player.nickname")

	local x,y,z = getElementPosition(target)
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
    local monthday = time.monthday
	local month = time.month
	local year = time.year
	local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
	setElementPosition(playerSource, x,y+1,z)
	outputChatBox("#1D8348[/tt]#ECF0F1 Teleportowano do gracza "..getElementData(target, "player.nickname")..".", playerSource, 255, 255, 255, true)
	triggerEvent("insert_tp_logs", root, zrodlo, cel, formattedTime)
	end
end
addCommandHandler("tt", teleportto)


function teleporthere(playerSource, commandName, id)
	if getElementData(playerSource, "admin.duty") ~= false then
	if getElementData(playerSource, "admin.duty") < 1 then return end
	if id == nil then return end
	local target = findPlayer(plr, id)
	if target == false then return end
	local zrodlo = getElementData(playerSource, "player.nickname")
	local cel = getElementData(target, "player.nickname")
	if target == false then
		outputChatBox("#FF2D00[/th]#ECF0F1 Nie znaleziono gracza. (Podane id: ".. id..").", playerSource, 255, 255, 255, true)
	return end
	local x,y,z = getElementPosition(playerSource)
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
    local monthday = time.monthday
	local month = time.month
	local year = time.year
	local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
	setElementPosition(target, x,y+1,z)
	outputChatBox("#1D8348[/tt]#ECF0F1 Teleportowano gracza "..getElementData(target, "player.nickname")..".", playerSource, 255, 255, 255, true)
	triggerEvent("insert_tp_logs", root, cel, zrodlo, formattedTime)
	end
end
addCommandHandler("th", teleporthere)


function kick(playerSource, commandName, id, ...)
	if getElementData(playerSource, "admin.duty") ~= false then
		if getElementData(playerSource, "admin.duty") < 1 then return end
		if id == false then return end
		local target = findPlayer(plr, id)
		local reason = table.concat({...}, " ")
		local kickedBy = getElementData(playerSource, "player.nickname")
		local kicked = getElementData(target, "player.nickname")
		local time = getRealTime()
		local hours = time.hour
		local minutes = time.minute
		local seconds = time.second
		local monthday = time.monthday
		local month = time.month
		local year = time.year
		local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
		print(kickedBy.." wyrzucił gracza "..kicked.. ", powód: "..reason.." "..formattedTime)
		kickPlayer(target,kickedBy, reason)
		triggerEvent("insert_adm_logs", root, kickedBy, kicked, "Kick", "N/A", reason, formattedTime)
	end
end
addCommandHandler("k", kick)

function debug(playerSource)
	if getElementData(playerSource, "admin.duty") > 3 then
		setPlayerScriptDebugLevel(playerSource, 3)
	end
end
addCommandHandler("debug", debug)

function teleport(playerSource, _, destination)
	local cords = {
		przecho = {166.307587, -10.655604, 1.097312},
		sara = {-14.743559, -285.292908, 4.947990},
		farma = {-43.258770, -11.065239, 2.633152},
		farma2 = {1069.546021, -324.961548, 73.511086},
		pizza = {1342.067383, 260.063660, 19.036423},
		bazar = {763.393127, 344.271698, 19.617743},
		dillimore = {705.158997, -611.274048, 16.335938}
	}

	if getElementData(playerSource, "admin.duty") ~= false then
		if getElementData(playerSource, "admin.duty") < 1 then return end
		local dest = cords[destination]
		local veh = getPedOccupiedVehicle(playerSource)

		if veh ~= false then
			if dest == nil then
				outputChatBox("#FF2D00[/th]#ECF0F1 Podano złą lokację.", playerSource, 255, 255, 255, true)
			return end
			setElementPosition(veh, unpack(dest))
		end

		if dest == nil then
			outputChatBox("#FF2D00[/th]#ECF0F1 Podano złą lokację.", playerSource, 255, 255, 255, true)
		return end
		setElementPosition(playerSource, unpack(dest))
	end
end
addCommandHandler("tp", teleport)

--(current_time.timestamp+7200-time)/3600

addCommandHandler("addban", function(player, commandName, type,id, days, reason)
	if getElementData(player, "admin.duty") > 2 then
		if days == nil then outputChatBox("#FF2D00[/addban]#ECF0F1 Użycie: /addban [rodzaj_id] [id/nick] [dlugosc_w_dniach].", player, 255, 255, 255, true) return end
		if type == "id" then
			local current_time = getRealTime()
			local target = findPlayer(plr, id)
			if target == false then outputChatBox("#FF2D00[/addban]#ECF0F1 Użycie: /addban [rodzaj_id] [id/nick] [dlugosc_w_dniach].", player, 255, 255, 255, true) return end
			local days = tonumber(days)
			local bantime = current_time.timestamp+days*24*3600
			local banned_uid = getElementData(target, "player.uid")
			local banned_nick = getElementData(target, "player.nickname")
			local banning_uid = getElementData(player, "player.uid")
			local banning_nick = getElementData(player, "player.nickname")
			db:insert("insert into banned_players values (?,?,?,?,?,?)", banned_nick, banned_uid, getPlayerSerial(target), bantime, banning_nick..", "..banning_uid, reason)
			kickPlayer(target, player, "Oh no, you're banned! :(( | Powód: "..reason)
		elseif type == "uid" then
			local current_time = getRealTime()
			local target = findPlayer(plr, id)
			local days = tonumber(days)
			local bantime = current_time.timestamp+days*24*3600
			local banned_nickname = db:get("select nick from players where uid=?", id)
			local banned_nick = banned_nickname[1]['nick']
			local banning_uid = getElementData(player, "player.uid")
			local banning_nick = getElementData(player, "player.nickname")
			local serial1 = db:get("select serial from players where uid=?", id)
			local serial = serial1[1]['serial']
			db:insert("insert into banned_players values (?,?,?,?,?,?)", banned_nick, id, serial, bantime, banning_nick..", UID: "..banning_uid, reason)
		end
	end
end)

addCommandHandler("suszarka", function(plr)
	if getElementData(plr, "admin.duty") ~= false then
		if getElementData(plr, "admin.duty") < 1 then return end
		local suszarka = giveWeapon(plr, 22, 1, true)
	end
end)