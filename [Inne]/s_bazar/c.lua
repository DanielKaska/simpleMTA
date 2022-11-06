local marker = createMarker(773.7, 346.5, 18.5, "cylinder", 0.5, 255,255,255,0)


font = dxCreateFont('i/font.ttf', 20, false, 'proof')
local redcircle = dxCreateTexture("i/koszulka.png")

x,y,z = 773.7, 346.5, 22




xs, ys = guiGetScreenSize()

function isMouseInPosition (x, y, width, height)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end




size = 1
addEventHandler("onClientRender", root, function()
    dxDrawMaterialLine3D(x, y, z-1.5, x, y, z-2.5, redcircle, size,tocolor(255, 255, 255, 255), false)
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--dxDrawImage(xs, ys, xs, ys, id, 0, 0, 0, tocolor(255,255,255,255), true)
--dxDrawRectangle(xs, ys, xs, ys,tocolor(16,16,16,200), false, false)

function ifHit(hitElement)
    function draw()
        if not isElementWithinMarker(localPlayer, marker) then return end
            if not isPedInVehicle(localPlayer) then
                showChat(false)
                showCursor(true)
                setPlayerHudComponentVisible ("all", false)
                dxDrawRectangle(xs*0.0001, ys*0.0001, xs*0.9999, ys*0.9999,tocolor(16,16,16,200), false, false)
                local lineColor = tocolor(255, 255, 255, 255)
                dxDrawText("Stragan z ubraniami",xs*0.01, ys*0.01, xs*0.5, ys*0.62, lineColor, 1, font)

                    if isMouseInPosition(xs*0.005, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.005, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 0) end
                        
                    end

                    if isMouseInPosition(xs*0.1, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.1, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 2) end
                        
                    end

                    if isMouseInPosition(xs*0.2, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.2, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 7) end
                        
                    end

                    if isMouseInPosition(xs*0.3, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.3, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 13) end
                        
                    end

                    if isMouseInPosition(xs*0.4, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.4, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 15) end
                        
                    end

                    if isMouseInPosition(xs*0.5, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.5, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 16) end
                        
                    end

                    if isMouseInPosition(xs*0.6, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.6, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 21) end
                        
                    end

                    if isMouseInPosition(xs*0.7, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.7, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 25) end
                        
                    end

                    if isMouseInPosition(xs*0.8, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.8, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 29) end
                        
                    end

                    if isMouseInPosition(xs*0.9, ys*0.05, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.9, ys*0.05, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 32) end
                        
                    end

                    ----------------------------------------------------------------------------------------------------
                    if isMouseInPosition(xs*0.005, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.005, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 41) end
                        
                    end

                    if isMouseInPosition(xs*0.1, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.1, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 44) end
                        
                    end

                    if isMouseInPosition(xs*0.2, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.2, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 56) end
                        
                    end

                    if isMouseInPosition(xs*0.3, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.3, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 58) end
                        
                    end

                    if isMouseInPosition(xs*0.4, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.4, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 68) end
                        
                    end

                    if isMouseInPosition(xs*0.5, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.5, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 78) end
                        
                    end

                    if isMouseInPosition(xs*0.6, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.6, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 79) end
                        
                    end

                    if isMouseInPosition(xs*0.7, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.7, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 86) end
                        
                    end

                    if isMouseInPosition(xs*0.8, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.8, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 101) end
                        
                    end

                    if isMouseInPosition(xs*0.9, ys*0.35, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.9, ys*0.35, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 105) end
                        
                    end
                    -----------------------------------------------------------------------------------------------------
                    if isMouseInPosition(xs*0.005, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.005, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 106) end
                        
                    end

                    if isMouseInPosition(xs*0.1, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.1, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 113) end
                        
                    end

                    if isMouseInPosition(xs*0.2, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.2, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 115) end
                        
                    end

                    if isMouseInPosition(xs*0.3, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.3, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 136) end
                        
                    end

                    if isMouseInPosition(xs*0.4, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.4, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 142) end
                        
                    end

                    if isMouseInPosition(xs*0.5, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.5, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 158) end
                        
                    end

                    if isMouseInPosition(xs*0.6, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.6, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 160) end
                        
                    end

                    if isMouseInPosition(xs*0.7, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.7, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 212) end
                        
                    end

                    if isMouseInPosition(xs*0.8, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.8, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                        if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 220) end
                        
                    end

                    if isMouseInPosition(xs*0.9, ys*0.65, xs*0.07, ys*0.25)
                    then
                        dxDrawRectangle(xs*0.9, ys*0.65, xs*0.07, ys*0.25,tocolor(220,220,220,200), false, false)
                        
                            if getKeyState("mouse1") == true then onMarkerLeave(hitElement) setElementModel(localPlayer, 239) end
                            
                    end

                dxDrawImage(xs*0.005, ys*0.05, xs*0.07, ys*0.25, "i/1.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.005, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                dxDrawImage(xs*0.1, ys*0.05, xs*0.07, ys*0.25, "i/2.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.1, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                dxDrawImage(xs*0.2, ys*0.05, xs*0.07, ys*0.25, "i/7.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.2, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                dxDrawImage(xs*0.3, ys*0.05, xs*0.07, ys*0.25, "i/13.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.3, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                dxDrawImage(xs*0.4, ys*0.05, xs*0.07, ys*0.25, "i/15.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.4, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                dxDrawImage(xs*0.5, ys*0.05, xs*0.07, ys*0.25, "i/16.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.5, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                dxDrawImage(xs*0.6, ys*0.05, xs*0.07, ys*0.25, "i/21.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.6, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                dxDrawImage(xs*0.7, ys*0.05, xs*0.07, ys*0.25, "i/25.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.7, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                dxDrawImage(xs*0.8, ys*0.05, xs*0.07, ys*0.25, "i/29.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.8, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                dxDrawImage(xs*0.9, ys*0.05, xs*0.07, ys*0.25, "i/32.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.9, ys*0.05, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)

                -------------------------------------------------------------------------------------------------
                dxDrawImage(xs*0.005, ys*0.35, xs*0.07, ys*0.25, "i/41.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.005, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.1, ys*0.35, xs*0.07, ys*0.25, "i/44.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.1, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.2, ys*0.35, xs*0.07, ys*0.25, "i/56.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.2, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.3, ys*0.35, xs*0.07, ys*0.25, "i/58.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.3, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.4, ys*0.35, xs*0.07, ys*0.25, "i/68.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.4, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.5, ys*0.35, xs*0.07, ys*0.25, "i/78.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.5, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.6, ys*0.35, xs*0.07, ys*0.25, "i/79.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.6, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.7, ys*0.35, xs*0.07, ys*0.25, "i/86.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.7, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.8, ys*0.35, xs*0.07, ys*0.25, "i/101.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.8, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.9, ys*0.35, xs*0.07, ys*0.25, "i/105.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.9, ys*0.35, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                -------------------------------------------------------------------------------------------------
                dxDrawImage(xs*0.005, ys*0.65, xs*0.07, ys*0.25, "i/106.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.005, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.1, ys*0.65, xs*0.07, ys*0.25, "i/113.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.1, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.2, ys*0.65, xs*0.07, ys*0.25, "i/115.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.2, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.3, ys*0.65, xs*0.07, ys*0.25, "i/136.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.3, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.4, ys*0.65, xs*0.07, ys*0.25, "i/142.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.4, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.5, ys*0.65, xs*0.07, ys*0.25, "i/158.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.5, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.6, ys*0.65, xs*0.07, ys*0.25, "i/160.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.6, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.7, ys*0.65, xs*0.07, ys*0.25, "i/212.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.7, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.8, ys*0.65, xs*0.07, ys*0.25, "i/220.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.8, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                dxDrawImage(xs*0.9, ys*0.65, xs*0.07, ys*0.25, "i/239.png", 0, 0, 0, tocolor(255,255,255,255), true)
                dxDrawRectangle(xs*0.9, ys*0.65, xs*0.07, ys*0.25,tocolor(16,16,16,200), false, false)
                else return end


end
        if hitElement and getElementType(hitElement) == "player" and hitElement == localPlayer then
            addEventHandler("onClientRender", getRootElement(), draw)
        end
    end
addEventHandler("onClientMarkerHit", marker, ifHit)


function onMarkerLeave(hitElement)
    if hitElement == localPlayer then
    showChat(true)
    showCursor(false)
    setPlayerHudComponentVisible ("radar", true)
    removeEventHandler("onClientRender", getRootElement(), draw)
    end
end 
addEventHandler ("onClientMarkerLeave", marker, onMarkerLeave)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pytajnik = createPickup(764, 348, 20, 3, 1239, 4000, 0)
marker2 = createMarker(764, 348, 20, "cylinder", 0.5, 255,255,255,0)

local function clientPickupHit(thePlayer)
    function draw2()
        --if not isPedInVehicle(localPlayer) then return end
        if not isElementWithinMarker(localPlayer, marker2) then return end
        local lineColor = tocolor(255, 255, 255, 255)
        dxDrawRectangle(xs*0.35, ys*0.65, xs*0.3, ys*0.15, tocolor(16,16,16,255))
        dxDrawText("Witaj na bazarze!",xs*0.457, ys*0.62, xs*0.457, ys*0.62, lineColor, 1, font)
        dxDrawText("Na bazarze kupisz niemal wszystko! Od ubrań, przez jedzenie,\naż po części samochodowe!",xs*0.36, ys*0.7, xs*0.36, ys*0.7, lineColor, 0.8, font)
        
    end
    addEventHandler("onClientRender", getRootElement(), draw2)
end
addEventHandler("onClientMarkerHit", marker2, clientPickupHit)

function destroyPickup()
    removeEventHandler("onClientRender", getRootElement(), draw2)
end 
addEventHandler("onClientMarkerLeave", marker2, destroyPickup)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
