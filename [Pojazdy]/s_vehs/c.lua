local lu=getTickCount()

local function naliczPrzebieg(veh)
    local przebieg=getElementData(veh,"vehicle.mileage") or 0
    if (getTickCount()-lu>250) then
    lu=getTickCount()
    local vx,vy,vz=getElementVelocity(veh)
    local spd=((vx^2 + vy^2 + vz^2)^(0.5)/10)
    if (spd>0) then
        przebieg=przebieg+(spd)/3
        setElementData(veh, "vehicle.mileage", przebieg)
    end
    end
end

function updatePrzebieg()
    local v=getPedOccupiedVehicle(localPlayer)
    if (not v) then return end
    if (not getVehicleEngineState(v)) then return end
    if (getVehicleController(v)~=localPlayer) then return end
    naliczPrzebieg(v)
end
addEventHandler("onClientRender", root, updatePrzebieg)


addEventHandler("onClientRender", root, function()
	local v=getPedOccupiedVehicle(localPlayer)
	if v then
		local przebieg = getElementData(v, "vehicle.mileage")
		if przebieg == false then return end
		dxDrawText("Przebieg: "..math.floor(przebieg).." km", 960, 400)
	end
end)

-------------------------------damage after collision-------------------------------------------------

local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX
addEventHandler("onClientVehicleDamage", root, function(_,_,damage)
	local veh = source
	local plr = getVehicleOccupant(veh, 0)
	if plr == false then return end
	local hp = getElementHealth(plr)
	local newHp = hp-damage/20

	if newHp > 5 then
		setElementHealth(plr, newHp)
	else
		setElementHealth(plr, 5)
	end
	
	if hp-newHp > 15 or hp < 6 then
		local ad = getElementData(plr, "admin.duty")
		local sapd = getElementData(plr, "sapd.duty")
		
		if sapd == false and ad == false then

		if showing == true then return end
		triggerEvent("showHud", plr)
		triggerEvent("showRadar2", plr)
		addEventHandler("onClientRender", root, unconscious)
		showing = true
		showChat(false)
		timeToWake = math.random(20,25)
		toggleAllControls(false)
		setTimer(function()
			showing = false
			showChat(true)
			triggerEvent("showHud", plr)
			triggerEvent("showRadar2", plr)
			removeEventHandler("onClientRender", root, unconscious)
			timeToWake = 0
			toggleAllControls(true)
		end, timeToWake*1000, 1)
	end
end
end)

function unconscious()
	local time = getTickCount()/1000
	local sin = math.sin(time)*35+35
	dxDrawRectangle(scaleX*0.01, scaleY*0.01, scaleX*1920, scaleX*1080, tocolor(255,0,0,sin))
	dxDrawText("Powoli odzyskujesz przytomność\nKup coś do jedzenia, albo skontaktuj się z pogotowiem, by się uleczyć", scaleX*910, scaleY*400, scaleX*1010, scaleY*450, tocolor(255,255,255,255), scaleX*1, "arial", "center", "center")
end
------------------------------------------------------------------------------------------------------