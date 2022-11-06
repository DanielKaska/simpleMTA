local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX

function isPedAiming (thePedToCheck)
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" or isPedDoingGangDriveby(thePedToCheck) then
				return true
			end
		end
	end
	return false
end

function blockShoot()
	if getPedWeapon(localPlayer) == 22 then
            toggleControl("fire", false)
            toggleControl("aim_weapon", true)
            toggleControl("action", false)
        else
            if getElementData(localPlayer, "sapd.duty") == true then
                toggleControl("fire", true)
                toggleControl("aim_weapon", true)
                toggleControl("action", true)
        else
            toggleControl("fire", false)
        end
    end 
end
addEventHandler("onClientRender", root, blockShoot)

vehTools = {
    "Ręczny",
    "Fix",
    "Przenieś do siebie",
    "Do przechowalni",
    "Wejdź do pojazdu"
}
toolsScroll = 1

function scrollUp()
    if toolsScroll == #vehTools then return end
    toolsScroll = toolsScroll+1
end

function scrollDown()
    if toolsScroll == 1 then return end
    toolsScroll = toolsScroll-1
end

elementy = {}
playerElements = {}

function tools(key, state)
    triggerServerEvent("vehTools", localPlayer, element, toolsScroll)
end

addEventHandler("onClientPlayerTarget", root, function(el)
    if isPedAiming(source) == true and el and getElementType(el) == "vehicle" and getPedWeapon(source) == 22 then
        bindKey("mouse1", "down", tools)
        bindKey("mouse_wheel_up", "down", scrollUp)
        bindKey("mouse_wheel_down", "down", scrollDown)
        element = el
        local gui = createElement("suszarka_gui")
        table.insert(elementy, #elementy+1, gui)
        

        if showing ~= true then
            addEventHandler("onClientRender", root, drawVehicle)
            showing = true
        end
    else
        unbindKey("mouse1", "down", tools)
        unbindKey("mouse_wheel_up", "down", scrollUp)
        unbindKey("mouse_wheel_down", "down", scrollDown)
        for i=1,#elementy do
            removeEventHandler("onClientRender", root, drawVehicle)
            table.remove(elementy, i)
            showing = false
        end
    end

    if isPedAiming(source) == true and el and getElementType(el) == "player" and getPedWeapon(source) == 22 then
        playerElement = el
        local playerGui = createElement("suszarka_gui_player")
        table.insert(playerElements, #playerElements+1, playerGui)
        
        if showing ~= true then
            addEventHandler("onClientRender", root, drawPlayer)
            showing = true
        end
    else
        for i=1,#playerElements do
            removeEventHandler("onClientRender", root, drawPlayer)
            table.remove(playerElements, i)
            showing = false
        end

    end

end)

function drawPlayer()
    local praca = getElementData(playerElement, "player.working")
    local login
    if praca == false then praca = "brak" end
    dxDrawRectangle(scaleX*1690, scaleY*290, scaleX*240, scaleY*100, tocolor(16,16,16,100))
    dxDrawText("ID gracza: "..getElementData(playerElement, "id"), scaleX*1700, scaleY*300, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
    dxDrawText("Nick gracza: "..getElementData(playerElement, "player.nickname"), scaleX*1700, scaleY*320, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
    dxDrawText("Praca: "..praca, scaleX*1700, scaleY*340, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
    dxDrawText("Czas gry: "..string.format("%d", getElementData(playerElement, "player.playtime")/60).." h", scaleX*1700, scaleY*360, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
end

function drawVehicle()
    if isElement(element) == true then
        local speedX, speedY, speedZ = getElementVelocity(element)
        local speed = (speedX^2 + speedY^2 + speedZ^2)^(0.5)
        local owner = getElementData(element, "vehicle.vid")
        local last_driver = getElementData(element, "last.driver")
        local driver = getVehicleOccupant(element)
        local mileage = getElementData(element, "vehicle.mileage")
        if driver ~= false then
            driver_name = getPlayerName(driver)
        end
        if owner == false then owner = "Brak id" end
        if last_driver == false then last_driver = "Brak" end
        if driver == false then driver_name = "Brak" end
        if mileage == false then mileage = "Brak" end
        if type(mileage) ~= "string" then mileage = string.format("%d", mileage) end
        dxDrawRectangle(scaleX*1690, scaleY*290, scaleX*240, scaleY*200, tocolor(16,16,16,100))
        dxDrawText(getVehiclePlateText(element), scaleX*1700, scaleY*300, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
        dxDrawText("VID: "..owner, scaleX*1700, scaleY*320, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
        dxDrawText("Prędkość: "..string.format("%d", speed*180).." km/h", scaleX*1700, scaleY*340, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
        dxDrawText("Obecny kierowca: "..driver_name, scaleX*1700, scaleY*360, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
        dxDrawText("Ostatni kierowca: "..last_driver, scaleX*1700, scaleY*380, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
        dxDrawText("Przebieg: "..mileage.." km", scaleX*1700, scaleY*400, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
        dxDrawText(toolsScroll..": "..vehTools[toolsScroll], scaleX*1700, scaleY*460, scaleX*1920, scaleY*490, tocolor(255,255,255,255), scaleX*1, "arial", "left")
    end
end