local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX
local font = dxCreateFont("utility/font.ttf", 15)
local font2 = dxCreateFont("utility/font-thick.ttf", 20)
local font3 = dxCreateFont("utility/font-medium.ttf", 10)

local button = dxCreateTexture("utility/button.png")
local button_click = dxCreateTexture("utility/button_click.png")

local DGS = exports.dgs

addEvent("receiveHistory", true)
addEvent("receiveInfo", true)

local cooldown = false
local showing = false
local drawing = false

function isMouseIn( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end



function drawDashboard(key)
    if getElementData(localPlayer, "player.logged") == true then 
        if showing == false then
            if cooldown == true then
                outputChatBox("#F4A603⚠️ #FFFFFFMożesz użyć panelu gracza raz na 10 sekund.", 255,255,255, true)
            return end
            
            hist = {}
            --cars = {}
            account = {}

            triggerEvent("showRadar2", localPlayer)
            triggerEvent("showHud", localPlayer)
            showChat(false)
            showCursor(true)
            showing = true

            local bg = DGS:dgsCreateImage(scaleX*0.01,scaleY*0.01,scaleX*1920,scaleY*1080,"utility/dash.png", false, nil, tocolor(255,255,255,70))
            local tab = DGS:dgsCreateImage(scaleX*0.01,scaleY*0.01,scaleX*1920,scaleY*1080,"utility/tab.png")
           
            local closeDash = DGS:dgsCreateButton(scaleX*1610,scaleY*1000,scaleX*200,scaleY*30, "Zamknij panel", nil, nil, tocolor(255,255,255,255), scaleX*1.3, scaleX*1.3, nil, nil, nil, tocolor(16,16,16,255),tocolor(245, 175, 72, 255),tocolor(245, 175, 72, 255))
             
            local changePass = DGS:dgsCreateButton(scaleX*522,scaleY*920,scaleX*150,scaleY*30, "Zmień hasło", nil, nil, tocolor(0,0,0,255), scaleX*0.7, scaleY*0.7, button, button_click, button_click, tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(255,255,255,255))
             
            local changeTime = DGS:dgsCreateButton(scaleX*1690,scaleY*340,scaleX*150,scaleY*30, "+2h", nil, nil, tocolor(0,0,0,255), scaleX*0.7, scaleY*0.7, button, button_click, button_click, tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(255,255,255,255))
            local changeTime2 = DGS:dgsCreateButton(scaleX*1690,scaleY*380,scaleX*150,scaleY*30, "-2h", nil, nil, tocolor(0,0,0,255), scaleX*0.7, scaleY*0.7, button, button_click, button_click, tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(255,255,255,255))
            local currentPass = DGS:dgsCreateEdit(scaleX*497, scaleY*720, scaleX*200, scaleX*25, "", false, nil, tocolor(0,0,0,255), scaleX*0.9, scaleX*0.9, nil, tocolor(255,255,255,255))
            local newPass = DGS:dgsCreateEdit(scaleX*497, scaleY*785, scaleX*200, scaleX*25, "", false, nil, tocolor(0,0,0,255), scaleX*0.9, scaleX*0.9, nil, tocolor(255,255,255,255))
            local confirmPass = DGS:dgsCreateEdit(scaleX*497, scaleY*850, scaleX*200, scaleX*25, "", false, nil, tocolor(0,0,0,255), scaleX*0.9, scaleX*0.9, nil, tocolor(255,255,255,255))
            
            local extraSunny = DGS:dgsCreateButton(scaleX*1690,scaleY*95,scaleX*150,scaleY*30, "Słonecznie", nil, nil, tocolor(0,0,0,255), scaleX*0.7, scaleY*0.7, button, button_click, button_click, tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(255,255,255,255))
            local cloudy = DGS:dgsCreateButton(scaleX*1690,scaleY*135,scaleX*150,scaleY*30, "Pochmurnie", nil, nil, tocolor(0,0,0,255), scaleX*0.7, scaleY*0.7, button, button_click, button_click, tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(255,255,255,255))
            local rainy = DGS:dgsCreateButton(scaleX*1690,scaleY*175,scaleX*150,scaleY*30, "Pada deszcz", nil, nil, tocolor(0,0,0,255), scaleX*0.7, scaleY*0.7, button, button_click, button_click, tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(255,255,255,255))


            DGS:dgsSetFont(changePass, font)
            DGS:dgsSetFont(changeTime, font)
            DGS:dgsSetFont(changeTime2, font)

            DGS:dgsSetFont(extraSunny, font)
            DGS:dgsSetFont(cloudy, font)
            DGS:dgsSetFont(rainy, font)

            DGS:dgsEditSetMaxLength(currentPass, 30)
            DGS:dgsEditSetMaxLength(newPass, 25)
            DGS:dgsEditSetMaxLength(confirmPass, 25)

            DGS:dgsSetProperty(currentPass, "caretColor", tocolor(0,0,0,255))
            DGS:dgsSetProperty(newPass, "caretColor", tocolor(0,0,0,255))
            DGS:dgsSetProperty(confirmPass, "caretColor", tocolor(0,0,0,255))

            DGS:dgsSetLayer(changePass, "top")
            DGS:dgsSetLayer(currentPass, "top") 
            DGS:dgsSetLayer(newPass, "top")
            DGS:dgsSetLayer(confirmPass, "top")

            DGS:dgsSetLayer(closeDash, "top")

            DGS:dgsSetLayer(extraSunny, "top")
            DGS:dgsSetLayer(cloudy, "top")
            DGS:dgsSetLayer(rainy, "top")

            DGS:dgsSetLayer(changeTime, "top")
            DGS:dgsSetLayer(changeTime2, "top")
            --------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------
        
            local uid = getElementData(localPlayer, "player.uid")

            triggerServerEvent("getHistory", localPlayer, localPlayer, uid)
            triggerServerEvent("getInfo", localPlayer, localPlayer, uid)

            addEventHandler("receiveHistory", localPlayer, getHistory)
            addEventHandler("receiveInfo", localPlayer, getInfo)
            
            --setTimer(function()
                addEventHandler("onClientRender", root, drawHistory)
                drawing = true
            --end, 1000, 1)
            --------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------
            function time()  
                local h, m = getTime()
                dxDrawText(string.format("%d", h)..":"..string.format("%d", m), scaleX*1745, scaleY*300, scaleX*1845, scaleY*300, tocolor(0,0,0,255), scaleX*1, font, nil, nil, false, false, true)
            end
            addEventHandler("onClientRender", root, time)

            addEventHandler("onDgsMouseClickDown", changeTime, function()
                local h, m = getTime()
                setTime(h+2,m)
            end)

            addEventHandler("onDgsMouseClickDown", changeTime2, function()
                local h, m = getTime()
                setTime(h-2,m)
            end)
            --------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------

            addEventHandler("onDgsMouseClickDown", extraSunny, function()
                setWeather(1)
            end)

            addEventHandler("onDgsMouseClickDown", cloudy, function()
                setWeather(4)
            end)

            addEventHandler("onDgsMouseClickDown", rainy, function()
                setWeather(8)
            end)
            --------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------

            addEventHandler("onDgsMouseClickDown", changePass, function(b)
                if b == "left" then
                    local oldPass = DGS:dgsGetText(currentPass)
                    local newPass = DGS:dgsGetText(newPass)
                    local confirmPass = DGS:dgsGetText(confirmPass)

                    if #newPass < 6 then
                        triggerEvent("sendAlert", localPlayer, "Minimalna długość hasła to 6 znaków.", 200)
                    return end

                    DGS:dgsSetEnabled(changePass, false)

                    local uid = getElementData(localPlayer, "player.uid")

                    triggerServerEvent("passChange", localPlayer, localPlayer, uid, oldPass, newPass, confirmPass)
                end
            end)


            addEventHandler("onDgsMouseClick", closeDash, function()
                if drawing == true then
                    drawing = false
                    showChat(true)
                    showCursor(false)
                    triggerEvent("showRadar2", localPlayer)
                    triggerEvent("showHud", localPlayer)
                    removeEventHandler("receiveHistory", localPlayer, getHistory)
                    removeEventHandler("receiveInfo", localPlayer, getInfo)
                    removeEventHandler("onClientRender", root, drawHistory)
                    destroyElement(changePass)
                    removeEventHandler("onClientRender", root, time)
                    destroyElement(closeDash)
                    destroyElement(bg)
                    destroyElement(tab)
                    destroyElement(currentPass)
                    destroyElement(confirmPass)
                    destroyElement(changeTime)
                    destroyElement(changeTime2)
                    destroyElement(newPass)
                    destroyElement(cloudy)
                    destroyElement(rainy)
                    destroyElement(extraSunny)
                    showing = false
                    cooldown = true
                    hist = nil
                    account = nil
                    setTimer(function()
                        cooldown = false
                    end, 1000, 1)
                end
            end)
        end
    end
end
bindKey("F3", "down", drawDashboard)



function getHistory(tID, m, xp, lvl, data, i)
    table.insert(hist, i, {tID, m, xp, lvl, data})
end

function getInfo(accAge, last, login)
    table.insert(account, 1, {accAge, last, login})
end

function cursorInfo()
    if isCursorShowing() then -- if the cursor is showing
       local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
 
       outputChatBox( string.format(": X=%.4f Y=%.4f", screenx*1920, screeny*1080) )
    else
       outputChatBox( "Your cursor is not showing." )
    end
 end
 addCommandHandler( "cursorpos", cursorInfo )

function drawHistory()
    x=(scaleY*0)
    

    if isMouseIn(scaleX*497, scaleY*720, scaleX*200, scaleX*25) then
        dxDrawText("Obecne hasło", cx*(scaleX*1920), cy*(scaleY*1080)+10, cx+scaleX*100, cy+scaleY*50, tocolor(255,255,255,255), scaleX*1, "arial", nil, nil, false, false, true)
        dxDrawRectangle(cx*(scaleX*1920), cy*(scaleY*1080)+10, scaleX*80, scaleY*15, tocolor(16,16,16,120), false)
    end

    if isMouseIn(scaleX*497, scaleY*785, scaleX*200, scaleX*25) then
        dxDrawText("Nowe hasło", cx*(scaleX*1920), cy*(scaleY*1080)+10, cx+scaleX*100, cy+scaleY*50, tocolor(255,255,255,255), scaleX*1, "arial", nil, nil, false, false, true)
        dxDrawRectangle(cx*(scaleX*1920), cy*(scaleY*1080)+10, scaleX*70, scaleY*15, tocolor(16,16,16,120), false)
    end

    if isMouseIn(scaleX*497, scaleY*850, scaleX*200, scaleX*25) then
        dxDrawText("Potwierdź hasło", cx*(scaleX*1920), cy*(scaleY*1080)+10, cx+scaleX*100, cy+scaleY*50, tocolor(255,255,255,255), scaleX*1, "arial", nil, nil, false, false, true)
        dxDrawRectangle(cx*(scaleX*1920), cy*(scaleY*1080)+10, scaleX*90, scaleY*15, tocolor(16,16,16,120), false)
    end


    if isMouseIn(scaleX*88,scaleY*42,scaleX*64,scaleY*64) then
        dxDrawText("Data zapisania danych", cx*(scaleX*1920), cy*(scaleY*1080)+10, cx+scaleX*100, cy+scaleY*50, tocolor(255,255,255,255), scaleX*1, "arial", nil, nil, false, false, true)
        dxDrawRectangle(cx*(scaleX*1920), cy*(scaleY*1080)+10, scaleX*125, scaleY*15, tocolor(16,16,16,120), false)
    end

    if isMouseIn(scaleX*487,scaleY*51,scaleX*64,scaleY*32) then
        dxDrawText("Ilość punktów EXP", cx*(scaleX*1920), cy*(scaleY*1080)+10, cx+scaleX*100, cy+scaleY*50, tocolor(255,255,255,255), scaleX*1, "arial", nil, nil, false, false, true)
        dxDrawRectangle(cx*(scaleX*1920), cy*(scaleY*1080)+10, scaleX*105, scaleY*15, tocolor(16,16,16,120), false)
    end

    if isMouseIn(scaleX*100,scaleY*706,scaleX*64,scaleY*64) then
        dxDrawText("Data założenia konta", cx*(scaleX*1920), cy*(scaleY*1080)+10, cx+scaleX*100, cy+scaleY*50, tocolor(255,255,255,255), scaleX*1, "arial", nil, nil, false, false, true)
        dxDrawRectangle(cx*(scaleX*1920), cy*(scaleY*1080)+10, scaleX*115, scaleY*15, tocolor(16,16,16,120), false)
    end

    if isMouseIn(scaleX*100,scaleY*836,scaleX*64,scaleY*64) then
        dxDrawText("Data ostatniego logowania", cx*(scaleX*1920), cy*(scaleY*1080)+10, cx+scaleX*100, cy+scaleY*50, tocolor(255,255,255,255), scaleX*1, "arial", nil, nil, false, false, true)
        dxDrawRectangle(cx*(scaleX*1920), cy*(scaleY*1080)+10, scaleX*147, scaleY*15, tocolor(16,16,16,120), false)
    end

    if isMouseIn(scaleX*107,scaleY*583,scaleX*64,scaleY*64) then
        dxDrawText("Login (Nie mylić z nickiem)", cx*(scaleX*1920), cy*(scaleY*1080)+10, cx+scaleX*100, cy+scaleY*50, tocolor(255,255,255,255), scaleX*1, "arial", nil, nil, false, false, true)
        dxDrawRectangle(cx*(scaleX*1920), cy*(scaleY*1080)+10, scaleX*147, scaleY*15, tocolor(16,16,16,120), false)
    end

    while account[1] == nil do return end

    dxDrawText(unpack(account[1], 1), scaleX*45, scaleY*790, scaleX*216, scaleY*70, tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center") -- acc age
    dxDrawText(unpack(account[1], 2), scaleX*45, scaleY*913, scaleX*216, scaleY*70, tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center") -- last login
    dxDrawText(unpack(account[1], 3), scaleX*45, scaleY*655, scaleX*216, scaleY*70, tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center") -- login
    dxDrawText(getElementData(localPlayer, "player.points"), scaleX*322, scaleY*790, scaleX*364, scaleY*70, tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center") -- premium points

    if getElementData(localPlayer, "player.playtime") < 60 then
        dxDrawText(getElementData(localPlayer, "player.playtime").." m", scaleX*265, scaleY*655, scaleX*426, scaleY*70, tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center") -- playtime
    else
        dxDrawText(string.format("%.2f", (getElementData(localPlayer, "player.playtime")/60)).." h", scaleX*265, scaleY*655, scaleX*426, scaleY*70, tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center") -- playtime
    end

    while hist[7] == nil do
        dxDrawText("Aby uzyskać dostęp do statystyk, musisz zostawić po sobie 7 dni aktywności na serwerze.", scaleX*50, scaleY*105, scaleX*700, scaleY*(120), tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center")
    return end

    for i=1,7 do
        x=x+(scaleY*40) 
        local r,g,b = 0,0,0
        dxDrawText(unpack(hist[i], 5), scaleX*35, scaleY*95+x, scaleX*206, scaleY*(70+x), tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center")
        dxDrawText("$"..unpack(hist[i], 2), scaleX*255, scaleY*95+x, scaleX*425, scaleY*(70+x), tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center")
        dxDrawText(unpack(hist[i], 3), scaleX*478, scaleY*95+x, scaleX*555, scaleY*(70+x), tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center")
        dxDrawText("LVL: "..unpack(hist[i], 4), scaleX*606, scaleY*95+x, scaleX*688, scaleY*(70+x), tocolor(r,g,b,255), scaleX*0.8, scaleY*0.8, font, "center")    
    end
end