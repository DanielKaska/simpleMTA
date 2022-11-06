local db = exports.s_dbconnect

--check if player is banned

--[[function greetPlayer()
	local plr = source
	local serial = getPlayerSerial(plr)
	local banned = db:get("select * from banned_players where serial = ?", serial)
	if banned[1]['banned-to'] == nil then return end
	local banning = banned[1]['banned-by']
	local reason = banned[1]['reason']
	local banned_to = banned[1]['banned-to']
	if banned_to ~= nil then
		local time = getRealTime()
		local time = time.timestamp
		if time > banned_to then
			db:insert("delete from banned_players where serial = ?", serial)
		else
			kickPlayer(plr, "Jesteś zbanowany/a przez :"..banning..". Powód: "..reason)
		return end
	end
end
addEventHandler("onPlayerJoin", root, greetPlayer)]]

addEvent("logged", true)

--Camera positioning--------------------------------------------------------------------------------------

spawnPoints = {
	{369.059021, -1807.372192, 28.402386, 369.324432, -1877.547485, 20.852989},
    {1392.641479, -899.556885, 100.751335, 1428.966187, -665.824341, 119.844536},
    {2139.512451, 2000.607056, 39.573933, 2002.741333, 1720.781860, 47.436462},
    {2118.604248, 2143.421631, 18.221121, 2534.741455, 2138.646240, 18.820312}
}

function camera()
	if source == false then return end
	local spawn = math.random(1, #spawnPoints)
	local posX, posY, posZ, dirX, dirY, dirZ = unpack(spawnPoints[spawn])
	setCameraMatrix(source, posX, posY, posZ, dirX, dirY, dirZ)
	fadeCamera(source, true)
end
addEventHandler("onPlayerJoin", getRootElement(), camera)
-----------------------------------------------------------------------------------------------------------
---------------------------------------Rejestracja---------------------------------------------------------
addEvent("createAcc", true)
max_accounts = 2
function createAcc(username, password1, password2, serial)
	
	local result_ = db:get("SELECT * FROM players WHERE serial=?", serial)
	if result_ and #result_ >= max_accounts then
		outputChatBox("Osiągnąłeś maksymalną ilość kont.", source)
		triggerClientEvent(source, "sendAlert", source, "Osiągnąłeś maksymalną ilość kont.", 300)
	return end

	local result_2= db:get( "SELECT * FROM players WHERE login=?", username)
	if result_2 and #result_2 > 0 then 
		outputChatBox("Konto o podanym loginie już istnieje.", source)
		triggerClientEvent(source, "sendAlert", source, "Konto o podanym loginie już istnieje.", 300)
	return end

	if password1 == password2 then
		local time = getRealTime()
		local hours = time.hour
		local minutes = time.minute
		local seconds = time.second
		local monthday = time.monthday
		local month = time.month
		local year = time.year
		local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)

		maleSkins = {0, 1, 2, 7, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 67, 68, 70, 71, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 264, 265, 266, 267, 268, 269, 270, 271, 272, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 290, 291, 292, 293, 294, 295, 296, 297, 299, 300, 301, 302, 303, 305, 306, 307, 308, 309, 310, 311, 312}
		local r = math.random(0, #maleSkins)
		local dbEx = db:insert("INSERT INTO players (login,nick,password,serial,playtime,premium_points,money,skin,admin,exp,level,created,last_login) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)", username, username, md5(password1), serial,0,0,100,maleSkins[r],0,0,0,formattedTime,formattedTime)
	else
		triggerClientEvent(source, "sendAlert", source, "Zarejestrowano.", 200)
	end

end
addEventHandler("createAcc", getRootElement(), createAcc)







-----------------------------------------------------------------------------------------------------------
--------------------------------Logowanie------------------------------------------------------------------
addEvent("getData", true)
function matchData(username, password)
	local passwd = md5(password)
	local result = db:get("SELECT * FROM players WHERE login=?", username)
	local result_pass = db:get("SELECT * FROM players WHERE password=?", passwd)
	local uid = result[1]['uid']
	local login = result[1]['login']
	--[[local money = result[1]['money']
	local skin = result[1]['skin']
	local admin = result[1]['admin']
	local exp = result[1]['exp']
	local level = result[1]['level']
	local playtime = result[1]['playtime']
	local nick = result[1]['nick']
	local points = result[1]['premium_points'] ]]
	if #result == 1 and #result_pass == 1 then
		
		--[[for i,player in pairs(getElementsByType("player")) do
			if getElementData(player,"player.uid") == result[1]['uid'] then
				triggerClientEvent(source, "sendAlert", source, "Konto jest obecnie w użytku!", 200)
			return end
		end]]
		
		triggerClientEvent(source, "sendAlert", source, "Zalogowano pomyślnie", 200)
		setElementData(source, "player.logged", true)
		setElementData(source, "player.nickname", nick)
		setElementData(source, "player.skin", skin)
		setElementData(source, "player.uid", uid)
		setElementData(source, "player.money", money)
		setElementData(source, "player.exp", exp)
		setElementData(source, "player.level", level)
		setElementData(source, "player.playtime", playtime)
		setElementData(source, "player.points", points)

		if admin ~= 0 then
			setElementData(source, "player.admin", admin)
			setElementData(source, "admin.duty", 0)
		end

		triggerClientEvent(source, "chooseSpawn", source)
		local time = getRealTime()
		local hours = time.hour
		local minutes = time.minute
		local seconds = time.second
		local monthday = time.monthday
		local month = time.month
		local year = time.year
		local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
		db:insert("UPDATE players SET last_login=? WHERE uid=?", formattedTime, uid)
		triggerClientEvent("destroyLogin", source)
		setPlayerHudComponentVisible(source, "all", false)
		setElementModel(source, getElementData(source, "player.skin"))
		setPlayerName(source, nick)
	else
		outputChatBox("Podane dane są nieprawidłowe.", source)
		triggerClientEvent(source, "sendAlert", source, "Podane dane są nieprawidłowe.", 200)
	end


	local faction = db:get("SELECT * FROM factions WHERE uid=?", uid)

	if faction[1] ~= nil then
		setElementData(source, "player.faction", faction[1]['faction'])
	end
	
	local job = db:get("SELECT * FROM office_jobs WHERE uid=?", uid)

	if job[1] ~= nil then
		setElementData(source, "player.office_job", job[1]['job'])
	end

end	
addEventHandler("getData", getRootElement(), matchData)
-----------------------------------------------------------------------------------------------------------
--Spawnowanie uzytkownika----------------------------------------------------------------------------------
function spawnHandler(player, pos)
	local x,y,z,r = unpack(pos)
	--local skin = getElementData(source, "player.skin")
	spawnPlayer(source, x,y,z, r, skin)
	fadeCamera(source, true)
	setCameraTarget(source, source)
	triggerClientEvent("logged2", source)
	triggerClientEvent("showInterfaces", source)
	triggerClientEvent("showRadar", source)
	triggerClientEvent(source, "startPlaytime", source, source)
end
addEventHandler("logged", getRootElement(), spawnHandler)
-----------------------------------------------------------------------------------------------------------
