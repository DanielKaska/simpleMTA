addEvent("destroyLogin", true)
addEvent("destroyPanel", true)
addEvent("logged2", true)
addEvent("destroyRegister", true)
addEvent("callRegister", true)
sx, sy = guiGetScreenSize()


DGS = exports.dgs



------------------------------------------------------------------------------------------------------------------------------------
    showChat(false)
    showCursor(true)
    setPlayerHudComponentVisible ("all", false)
------------------------------------------------------------------------------------------------------------------------------------

local devScreenX = 1920
local devScreenY = 1080
local screenX, screenY = guiGetScreenSize()
local scaleY = screenY / devScreenY
local scaleX = screenX / devScreenX
local font = dxCreateFont("font.ttf", 14)
local user = dxCreateTexture("i/user.png")
local lock = dxCreateTexture("i/lock.png")


------------------------------------------------------------------------------------------------------------------------------------

function createLogin()
        b = exports.blur_box
        if playing ~= true then
            playing = true
            music = playSound("music.mp3", true)
        end

        if sx < 1200 then
            outputChatBox("* Ostrzeżenie: Ze względu na zbyt niską rozdzielczość Twojego ekranu, niektóre interfejsy mogą źle się wyświetlać. Zalecana minimalna rozdzielczość: 1280 x 720 px. Twoja rozdzielczość: "..sx.." x "..sy.." px.")
        end

        function renderText()
            dxDrawText("#F5AF48simple\n#FFFFFFLogowanie", scaleX*900, scaleY*200, scaleX*1020, scaleY*250, nil, scaleX*1, font, "center", "center", false, false, true, true)
        end
        addEventHandler("onClientRender", root, renderText)

        --Creating DGS
        editImage_1 = DGS:dgsCreateRoundRect({{7,false},{7,false},{7,false},{7,false}},tocolor(16,16,16,210))
        editImage_2 = DGS:dgsCreateRoundRect({{7,false},{7,false},{7,false},{7,false}},tocolor(245,175,72,200))

        bg = DGS:dgsCreateImage(scaleX*660,scaleY*182,scaleX*600,scaleY*449,"i/img.png")
        img = DGS:dgsCreateImage(scaleX*11180,scaleY*450, scaleX*40, scaleX*40, user)
        img2 = DGS:dgsCreateImage(scaleX*11184,scaleY*520, scaleX*30, scaleX*30, lock)

        openRegister = DGS:dgsCreateButton(scaleX*790,scaleY*470,scaleX*160,scaleY*30, "Rejestracja", nil, nil, tocolor(255,255,255,255), scaleX*0.9, scaleX*0.9, editImage_1,editImage_2,editImage_2, tocolor(16,16,16,255),tocolor(245, 175, 72, 255),tocolor(245, 175, 72, 255))
        loginConfirm = DGS:dgsCreateButton(scaleX*980,scaleY*470,scaleX*160,scaleY*30, "Zaloguj", nil, nil, tocolor(255,255,255,255), scaleX*0.9, scaleX*0.9, editImage_1,editImage_2,editImage_2, tocolor(16,16,16,255),tocolor(245, 175, 72, 255),tocolor(245, 175, 72, 255))
        login = DGS:dgsCreateEdit(scaleX*860,scaleY*320,scaleX*200,scaleY*35, "", false, nil, tocolor(255,255,255,255), scaleX*0.9, scaleX*0.9, nil, tocolor(16,16,16,200))
        pass = DGS:dgsCreateEdit(scaleX*860,scaleY*390,scaleX*200,scaleY*35, "", false, nil, tocolor(255,255,255,255), scaleX*1.1, scaleX*1.1, nil, tocolor(16,16,16,200))

        rememberMe = DGS:dgsCreateRadioButton(scaleX*920,scaleY*430,scaleX*100, scaleY*25, "Zapamiętaj mnie", false, nil, tocolor(255,255,255,255), scaleX*1, scaleY*1)

        DGS:dgsEditSetMaxLength(login, 15)
        DGS:dgsEditSetMaxLength(pass, 25)
        --Layers setting
        DGS:dgsSetLayer(bg, "bottom")
        DGS:dgsSetLayer(login, "top")
        DGS:dgsSetLayer(pass, "top")
        DGS:dgsSetLayer(loginConfirm, "top")
        DGS:dgsSetLayer(openRegister, "top")
        DGS:dgsSetLayer(rememberMe, "top")
        DGS:dgsSetPostGUI(openRegister, true)
        DGS:dgsSetPostGUI(loginConfirm, true)
        DGS:dgsSetPostGUI(login, true)
        DGS:dgsSetPostGUI(pass, true)
        DGS:dgsSetPostGUI(rememberMe, true)
        DGS:dgsSetPostGUI(img, true)
        DGS:dgsSetPostGUI(img2, true)
        --Fonts, properties
        DGS:dgsSetFont(login, font)
        DGS:dgsSetFont(pass, font)
        DGS:dgsSetFont(openRegister, font)
        DGS:dgsSetFont(loginConfirm, font)
        DGS:dgsSetProperty(pass,"masked",true)
        DGS:dgsSetProperty(login,"enableTabSwitch",true)
        DGS:dgsSetProperty(pass,"enableTabSwitch",true)
        DGS:dgsSetFont(rememberMe, font)
        DGS:dgsSetProperty(rememberMe,"textSize",{scaleX*0.8, scaleY*0.8})
        DGS:dgsSetProperty(login,"bgImage",editImage_1)
        DGS:dgsSetProperty(pass,"bgImage",editImage_1)
        --Utility

        blur2 = b:createBlurBox(scaleX*660,scaleY*182,scaleX*600,scaleY*449, 255,255,255,255, false)
        b:setBlurIntensity(2)
        infoTable = {}


        if fileExists("login.txt") == true then
            local file = fileOpen("login.txt")
            if file ~= false then
                local count = fileGetSize(file)
                local info = fileRead(file, count)

                for i in string.gmatch(info, "%S+") do
                    table.insert(infoTable, i)
                end
                fileClose(file)
                local insertLogin, insertPass = unpack(infoTable)
                DGS:dgsEditInsertText(login, 0, insertLogin)
                DGS:dgsEditInsertText(pass, 0, insertPass)
                DGS:dgsRadioButtonSetSelected(rememberMe, true)
            end
        end

        addEventHandler("onDgsMouseClickDown", openRegister, createRegister)
        addEventHandler("onDgsMouseClickDown", loginConfirm, loginQuery)
end
addEventHandler("onClientResourceStart", resourceRoot, createLogin)
-------------------------------------------------------------------------

function createRegister()
    destroyLogin()
    
    --Rendering

    function dxRender()
        dxDrawText("#F5AF48simple\n#FFFFFFRejestracja", scaleX*900, scaleY*200, scaleX*1020, scaleY*250, nil, scaleX*1, font, "center", "center", false, false, true, true)
    end
    addEventHandler("onClientRender", root, dxRender)


    


    --creating DGS elements
    bg2 = DGS:dgsCreateImage(scaleX*660,scaleY*182,scaleX*600,scaleY*449,"i/img.png")
    registerRadioB = DGS:dgsCreateRadioButton(scaleX*900,scaleY*500,scaleX*100, scaleY*25, "Akceptuję regulamin", false, nil, tocolor(255,255,255,255), scaleX*0.3, scaleY*0.3)
    closeRegisterWindow = DGS:dgsCreateButton(scaleX*790,scaleY*540,scaleX*160,scaleY*30, "Logowanie", nil, nil, tocolor(255,255,255,255), scaleX*0.9, scaleX*0.9, editImage_1,editImage_2,editImage_2, tocolor(16,16,16,255),tocolor(245, 175, 72, 255),tocolor(245, 175, 72, 255))
    registerConfirm = DGS:dgsCreateButton(scaleX*980,scaleY*540,scaleX*160,scaleY*30, "Zarejestruj", nil, nil, tocolor(255,255,255,255), scaleX*0.9, scaleX*0.9, editImage_1,editImage_2,editImage_2, tocolor(16,16,16,255),tocolor(245, 175, 72, 255),tocolor(245, 175, 72, 255))
    login1 = DGS:dgsCreateEdit(scaleX*860,scaleY*320,scaleX*200,scaleY*35, "", false, nil, tocolor(255,255,255,255), scaleX*0.9, scaleX*0.9, nil, tocolor(16,16,16,200))
    pass1 = DGS:dgsCreateEdit(scaleX*860,scaleY*390,scaleX*200,scaleY*35, "", false, nil, tocolor(255,255,255,255), scaleX*1.1, scaleX*1.1, nil, tocolor(16,16,16,200))
    pass2 = DGS:dgsCreateEdit(scaleX*860,scaleY*460,scaleX*200,scaleY*35, "", false, nil, tocolor(255,255,255,255), scaleX*1.1, scaleX*1.1, nil, tocolor(16,16,16,200))


    DGS:dgsEditSetMaxLength(login1, 15)
    DGS:dgsEditSetMaxLength(pass1, 25)
    DGS:dgsEditSetMaxLength(pass2, 25)
    --DGS settings

    DGS:dgsSetLayer(registerRadioB, "top")
    DGS:dgsSetLayer(closeRegisterWindow, "top")
    DGS:dgsSetLayer(registerConfirm, "top")
    DGS:dgsSetLayer(login1, "top")
    DGS:dgsSetLayer(pass1, "top")
    DGS:dgsSetLayer(pass2, "top")

    DGS:dgsSetPostGUI(login1, true)
    DGS:dgsSetPostGUI(pass1, true)
    DGS:dgsSetPostGUI(pass2, true)
    DGS:dgsSetPostGUI(registerConfirm, true)
    DGS:dgsSetPostGUI(closeRegisterWindow, true)
    DGS:dgsSetPostGUI(registerRadioB, true)
    
    --fonts, properties

    DGS:dgsSetProperty(login1,"bgImage",editImage_1)
    DGS:dgsSetProperty(pass1,"bgImage",editImage_1)
    DGS:dgsSetProperty(pass2,"bgImage",editImage_1)

    DGS:dgsSetProperty(login1,"enableTabSwitch",true)
    DGS:dgsSetProperty(pass1,"enableTabSwitch",true)
    DGS:dgsSetProperty(pass2,"enableTabSwitch",true)
    DGS:dgsSetProperty(pass1,"masked",true)
    DGS:dgsSetProperty(pass2,"masked",true)
    DGS:dgsSetFont(login1, font)
    DGS:dgsSetFont(pass1, font)
    DGS:dgsSetFont(pass2, font)
    DGS:dgsSetFont(registerRadioB, font)
    DGS:dgsSetFont(closeRegisterWindow, font)
    DGS:dgsSetFont(registerConfirm, font)
    DGS:dgsSetProperty(registerRadioB,"textSize",{scaleX*0.8, scaleY*0.8})
    --Handlers

    blur3 = b:createBlurBox(scaleX*660,scaleY*182,scaleX*600,scaleY*449, 255,255,255,255, false)
    b:setBlurIntensity(2)

    addEventHandler("onDgsMouseClickDown", closeRegisterWindow, destroyRegister)
    addEventHandler("onDgsMouseClickDown", registerConfirm, registerAcc)
end

-------------------------------------------------------------------------
function destroyRegister()
    removeEventHandler("onClientRender", root, dxRender)
    destroyElement(registerConfirm)
    destroyElement(closeRegisterWindow)
    destroyElement(registerRadioB)
    destroyElement(login1)
    destroyElement(pass1)
    destroyElement(pass2)
    destroyElement(bg2)
    exports.blur_box:destroyBlurBox(blur3)
    createLogin()
end
addEventHandler("destroyRegister", localPlayer, destroyRegister)
-------------------------------------------------------------------------
function destroyLogin()
    removeEventHandler("onClientRender", root, renderText)
    destroyElement(openRegister)
    destroyElement(loginConfirm)
    destroyElement(login)
    destroyElement(pass)
    destroyElement(bg)
    destroyElement(rememberMe)
    destroyElement(img)
    destroyElement(img2)
    exports.blur_box:destroyBlurBox(blur2)
end
addEventHandler("destroyLogin", localPlayer, destroyLogin)
-------------------------------------------------------------------------

--createRegister()

function destroy()
        showCursor(false)
        showChat(true)
        removeEventHandler("onClientRender", getRootElement(), renderText)
        stopSound(music)
        playing = false
end
addEventHandler("logged2", localPlayer, destroy)




function registerAcc()
    if DGS:dgsRadioButtonGetSelected(registerRadioB) == true then
        local x1 = DGS:dgsGetText(login1)
        local x2 = DGS:dgsGetText(pass1)
        x3 = 3
        x3 = 5
        if #x1 == nil then return end
        if #x2 == nil then return end
        if #x1 <= x3 then return end
        if #x2 <= x3 then return end
        if string.find(x1, " ") then triggerEvent("sendAlert", localPlayer, "Nie używaj spacji.") return end
        if string.find(x2, " ") then triggerEvent("sendAlert", localPlayer, "Nie używaj spacji.") return end
        serial = getPlayerSerial(getRootElement())
        username = DGS:dgsGetText(login1)
        password1 = DGS:dgsGetText(pass1)
        password2 = DGS:dgsGetText(pass2)
        triggerServerEvent("createAcc", localPlayer, username, password1, password2, serial)
        destroyRegister()
    end
end 



function loginQuery()
    x1 = DGS:dgsGetText(login)
    x2 = DGS:dgsGetText(pass)
    if x1 == nil then return end
    if x2 == nil then return end
    if #x1 <= 1 or #x2 <= 1 then return end
    password = DGS:dgsGetText(pass)
    username = DGS:dgsGetText(login)

    if DGS:dgsRadioButtonGetSelected(rememberMe) == true then
        local file = fileOpen("login.txt")
        if file == false then
            local file = fileCreate("login.txt")
            fileWrite(file, username, " ",password)
            fileClose(file)
        else
            fileWrite(file, username, " ",password)
            fileClose(file)
        end
    end

    triggerServerEvent("getData", localPlayer, username, password)
end