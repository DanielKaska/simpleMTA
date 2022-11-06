addEvent("showRadar", true) --showing radar after join
addEvent("showRadar2", true) --showing/hiding radar

local sx, sy = guiGetScreenSize()
local zoom = 1
if sx < 2048 then
    zoom = math.min(10, 2048/sx)
end
local font = dxCreateFont("data/font.ttf", 16/zoom)
local hudMaskShader = dxCreateShader("data/hud_mask.fx")
local radarTexture = dxCreateTexture("data/world.png")
local maskTexture1 = dxCreateTexture("data/circle_mask.png")
dxSetShaderValue(hudMaskShader, "sPicTexture", radarTexture)
dxSetShaderValue(hudMaskShader, "sMaskTexture", maskTexture1)
setPlayerHudComponentVisible("radar", false)

local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleValue = screenY / devScreenY
local scaleValueX = screenX / devScreenX
local DGS = exports.dgs

function renderCrosshair()
	local weap = getPedWeapon(localPlayer)
	if true then
		local hX, hY, hZ = getPedTargetEnd(localPlayer)
		local screen1, screen2 = getScreenFromWorldPosition(hX,hY,hZ)
		if (screen1 and screen2) then
			dxDrawImage(screen1-15/zoom/2, screen2-15/zoom/2, 15/zoom, 15/zoom, "data/crosshair.png")
		end
	end
end

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

showing = false


function triggerHud()
    if showing == false then
        showing = true

		healthBar = DGS:dgsCreateProgressBar(-160/zoom, sy - 560/zoom, 720/zoom, 720/zoom, false, nil, nil, nil, nil, tocolor(245, 175, 72))

		DGS:dgsProgressBarSetStyle(healthBar,"ring-round",{
            isClockwise = false,
            rotation = 90,
            antiAliased = 0.005,
            radius = 0.2,
            thickness = 0.005})

	function test()
		if not getElementData(localPlayer, "player.logged") then return end
		setPlayerHudComponentVisible("crosshair", false)
		setPlayerHudComponentVisible("radar", false)
		if isPedAiming(localPlayer) and getKeyState("mouse2") then
			renderCrosshair()
		end

		local health = getElementHealth(localPlayer)
		DGS:dgsProgressBarSetProgress(healthBar,health)

		local px,py,pz = getElementPosition(localPlayer)
		local street = getZoneName(px, py, pz)
		local city = getZoneName(px, py, pz, true)
		local x = (px) / 6000
		local y = (py) / -6000
		dxSetShaderValue(hudMaskShader, "gUVPosition", x, y)
		dxSetShaderValue(hudMaskShader, "gUVScale", 0.11, 0.11)

		local _,_,camrot = getElementRotation(getCamera())
		dxSetShaderValue(hudMaskShader, "gUVRotAngle", math.rad(-camrot))

		dxDrawImage(50/zoom, sy - 350/zoom, 300/zoom, 300/zoom, hudMaskShader, 0,0,0, tocolor(255,255,255,230))

		DGS:dgsProgressBarSetStyle(healthBar, "ring-round",{
			isClockwise = false,
            rotation = camrot,
            antiAliased = 0.005,
            radius = 0.2,
            thickness = 0.005})

		for k,v in pairs(getElementsByType("blip")) do
			local bx, by, bz = getElementPosition(v)
			local dist = getDistanceBetweenPoints2D(px, py, bx, by)/zoom/2
			local rot = math.atan2(bx - px, by - py) + math.rad(camrot)
			if dist <= 140/zoom then
				local x, y = 200/zoom + math.sin(rot) * dist, sy - 200/zoom - math.cos(rot) * dist
				dxDrawImage(x - 15/zoom, y - 15/zoom, 25/zoom, 25/zoom, "data/blips/" .. getBlipIcon(v) .. ".png")
			end
		end

		local x, y = 200/zoom, sy - 200/zoom
		local _,_,rz = getElementRotation(localPlayer)
		dxDrawImage(x - 15/zoom, y - 15/zoom, 30/zoom, 30/zoom, "data/player.png", camrot - rz)
	end
	addEventHandler("onClientRender", root, test)
	function findRotation(x1, y1, x2, y2) 
		local t = -math.deg(math.atan2(x2 - x1, y2 - y1))
		return t < 0 and t + 360 or t
	end

	function getPointFromDistanceRotation(x, y, dist, angle)
		local a = math.rad(90 - angle)
		local dx = math.cos(a) * dist
		local dy = math.sin(a) * dist
		return x+dx, y+dy
	end
end
end
addEventHandler("showRadar", localPlayer, triggerHud)

function ukryjRadar()
    if showing == true then
        destroyElement(healthBar)
        removeEventHandler("showRadar", localPlayer, triggerHud)
        removeEventHandler("onClientRender", root, test)
        showing = false
    else
        triggerEvent("showRadar", localPlayer)
        triggerHud()
    end
end
addEventHandler("showRadar2", localPlayer, ukryjRadar)
addCommandHandler("showradar", ukryjRadar)