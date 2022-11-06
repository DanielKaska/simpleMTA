
radar = dxCreateTexture("i/radar.png")
addEvent("rysuj", false)
loadstring(exports.dgs:dgsImportFunction())()
addEvent("showInterfaces", true)
addEvent("showHud", true)
setPlayerHudComponentVisible("radar", false)

local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleValue = screenY / devScreenY
local scaleValueX = screenX / devScreenX
local font = dxCreateFont("font.ttf", 15)

function formatNumber(number, sep)
	assert(type(tonumber(number))=="number", "Bad argument @'formatNumber' [Expected number at argument 1 got "..type(number).."]")
	assert(not sep or type(sep)=="string", "Bad argument @'formatNumber' [Expected string at argument 2 got "..type(sep).."]")
	local money = number
	for i = 1, tostring(money):len()/3 do
		money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1"..sep.."%2")
	end
	return money
end

local texture = dxCreateTexture("i/radar.png")

showing = false

function triggerHud()
    if showing == false then
        showing = true
        local nextLevel = 100
        local posx,posy = guiGetScreenSize()
        local color = tocolor(255,255,0)
        local scale = scaleValueX*200
        local fontScale = scaleValueX*1
        levelBar = dgsCreateProgressBar(scaleValueX*1720, scaleValueX*10,scale,scale, false, nil, nil, nil, nil, tocolor(245, 175, 72))

        dgsProgressBarSetStyle(levelBar,"ring-round",{
            isClockwise = false,
            rotation = 90,
            antiAliased = 0.005,
            radius = 0.2,
            thickness = 0.01})

        

        function drawHud()
            if not getElementData(localPlayer, "player.logged") == true then return end
            local lvl = getElementData(localPlayer, "player.level")
            local exp = getElementData(localPlayer, "player.exp")
            local money2 = getElementData(localPlayer, "player.money")
            local pb = dgsProgressBarSetProgress(levelBar,exp/lvl)
            dxDrawText(lvl, scaleValueX*1720, scaleValueX*95, scaleValueX*1920, scaleValue*105, nil, fontScale, font, "center")
            dxDrawText("$"..formatNumber(money2, "."), scaleValueX*1720, scaleValueX*95, scaleValueX*1720, scaleValue*105, nil, fontScale, font, "center")
        end
        addEventHandler("onClientRender", root, drawHud)
        

        --showzones
        -----------------------------------------------------------------------------------------------
        -----------------------------------------------------------------------------------------------
        function showzones()
            local x,y,z = getElementPosition(localPlayer)
            strefa = getZoneName(x,y,z)
            dxDrawText(strefa, scaleValue*2, scaleValue*1045, nil, nil, nil, 1, font)
        end
        addEventHandler("onClientRender", root, showzones)
        -----------------------------------------------------------------------------------------------
        -----------------------------------------------------------------------------------------------
    end
end
addEventHandler("showInterfaces", localPlayer, triggerHud)

goalShowing = false

function goal(plr, goal, name)
    if goalShowing == false then
        
        if goal == nil or name == nil then
            outputChatBox("#F4A603⚠️ #FFFFFFPodaj wysokość celu i jego nazwę.", 255,255,255, true)
        return end

        if tonumber(goal) <= getElementData(localPlayer, "player.money") then 
            outputChatBox("#F4A603⚠️ #FFFFFFCel nie może być niższy niż ilość gotówki!", 255,255,255, true)
        return end
        goalShowing = true
        local startGoal = getElementData(localPlayer, "player.money")
        local endGoal = tonumber(goal)
        local hasToEarn = endGoal-startGoal
        goalProgress = dgsCreateProgressBar(scaleValueX*810, scaleValue*1045,scaleValueX*300,scaleValue*25, false, nil, nil, nil, nil, tocolor(245, 175, 72))
            function renderHandler()
                local currentMoney = getElementData(localPlayer, "player.money")
                local earned = currentMoney-startGoal
                dgsProgressBarSetProgress(goalProgress,(earned/hasToEarn)*100)
                if currentMoney > endGoal then 
                    triggerEvent("sendAlert", root, "Cel #F5AF48"..name.." #FFFFFFzostał zrealizowany.", 200)
                    destroyElement(goalProgress)
                    goalShowing = false
                    removeEventHandler("onClientRender", root, renderHandler)
                end
                dxDrawText(name, scaleValueX*810, scaleValue*1045,scaleValueX*1110,scaleValue*1070, nil, scaleValueX*1, font, "center", "center", false, false, true)
            end
            addEventHandler("onClientRender", root, renderHandler)
    else
        destroyElement(goalProgress)
        goalShowing = false
        removeEventHandler("onClientRender", root, renderHandler)
    end
end
addCommandHandler("cel", goal)

function ukryjRadar()
    if showing == true then
        destroyElement(levelBar)
        removeEventHandler("showInterfaces", localPlayer, triggerHud)
        removeEventHandler("onClientRender", root, showzones)
        removeEventHandler("onClientRender", root, drawHud)
        showing = false
    else
        triggerEvent("showInterfaces", localPlayer)
        triggerHud()
    end
end
addEventHandler("showHud", localPlayer, ukryjRadar)
addCommandHandler("hud", ukryjRadar)