local font = dxCreateFont("font.ttf", 15)
local img = dxCreateTexture("img.png")

function getPos()
    local x, y, z = getElementPosition(localPlayer)
    local _,_,r = getElementRotation(localPlayer)
    outputChatBox(string.format("%f", x)..", ".. string.format("%f", y) ..", " .. string.format("%f", z))
    outputChatBox(string.format("%d", r))
end
addCommandHandler ( "gp",getPos) 

function bindCursor ()
    showCursor(not isCursorShowing());
end
bindKey("m","down",bindCursor);



--[[addCommandHandler("devmode",
    function()
        setDevelopmentMode(true)
    end
)
]]
--zrobic komende /krzeslo (animacja, model)

setWorldSpecialPropertyEnabled("randomfoliage", false)

function showLocalHealth()
    veh = getPedOccupiedVehicle(localPlayer)
    if veh then
        local hp = getElementHealth(veh)
        if hp < 271 then 
            setElementHealth(veh, 275)
        end
    end
end
addEventHandler("onClientRender", root, showLocalHealth)


addEventHandler( "onClientRender",root,
   function( )
      local px, py, pz, tx, ty, tz, dist
      px, py, pz = getCameraMatrix( )
       for _, v in ipairs( getElementsByType ( 'player' ) ) do
         if (v~=getLocalPlayer()) then
         tx, ty, tz = getElementPosition( v )
         local n = getElementData(v, "player.nickname")
         local id = getElementData(v, "id")
         dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
         if dist < 30.0 then
            if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false, localPlayer) then
               local sx, sy, sz = getPedBonePosition( v, 5 )
               local x,y = getScreenFromWorldPosition( sx, sy, sz + 0.3 )
               if x then -- getScreenFromWorldPosition returns false if the point isn't on screen
                local e = getElementData(v, "admin.duty")
                local p = getElementData(v, "player.premium")

                if e == false then
                    dxDrawText("#A9A9A9"..n.."#FFFFFF | "..id, x, y-30, x, y, tocolor(255, 255, 255), 0.85 + ( 15 - dist ) * 0.02, font, "center", nil, false, false, false, true)
                end

                if e == 0 then
                    dxDrawText("#A9A9A9"..n.."#FFFFFF | "..id, x, y-30, x, y, tocolor(255, 255, 255), 0.85 + ( 15 - dist ) * 0.02, font, "center", nil, false, false, false, true)
                end

                if e ~= false then
                    if e == 1 then
                        dxDrawText("#87CEFA"..n.."#FFFFFF | "..id, x, y-30, x, y, tocolor(255, 255, 0), 0.85 + ( 15 - dist ) * 0.02, font, "center", nil, false, false, false, true)
                    elseif e ==2 then
                        dxDrawText("#98FB98"..n.."#FFFFFF | "..id, x, y-30, x, y, tocolor(255, 255, 0), 0.85 + ( 15 - dist ) * 0.02, font, "center", nil, false, false, false, true)
                    elseif e ==3 then
                        dxDrawText("#DC143C"..n.."#FFFFFF | "..id, x, y-30, x, y, tocolor(255, 255, 0), 0.85 + ( 15 - dist ) * 0.02, font, "center", nil, false, false, false, true)
                    elseif e ==4 then
                        dxDrawText("#DC143C"..n.."#FFFFFF | "..id, x, y-30, x, y, tocolor(255, 255, 0), 0.85 + ( 15 - dist ) * 0.02, font, "center", nil, false, false, false, true)
                    elseif e ==5 then
                        dxDrawText("#DC143C"..n.."#FFFFFF | "..id, x, y-30, x, y, nil, 0.85 + ( 15 - dist ) * 0.02, font, "center", nil, false, false, false, true)
                    end
                
                else
                    
                if p == true then
                    dxDrawText("#F5AF48"..n.."#FFFFFF | "..id, x, y-30, x, y, nil, 0.85 + ( 15 - dist ) * 0.02, font, "center", nil, false, false, false, true)
                end

                end
               end
            end
         end
      end
   end
end
)