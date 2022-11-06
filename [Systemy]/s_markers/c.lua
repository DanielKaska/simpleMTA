addEvent("customMarker", true)
local dgs = exports.dgs
    mat = dxCreateTexture("i/hiring.png")
    mat2 = dxCreateTexture("i/ring.png")
    mat3 = dxCreateTexture("i/door.png")
    line = dxCreateTexture("i/line.png")
    font = dxCreateFont("i/font.ttf", 20)
function drawCustomMarker()
    for k,v in ipairs(getElementsByType("marker")) do
        if getElementData(v, "marker_enter") == true then
            local x, y, z = getElementPosition(v)
            local size = getMarkerSize(v)
            dxDrawMaterialLine3D(x, y, z+2, x, y, z+1, mat3, size,tocolor(255, 255, 255, 255), false)
            dxDrawMaterialLine3D(x+size, y, z, x-size, y, z, mat2, 2,tocolor(255, 255, 255, 255), false, x, y, z+10)
        end
    end
end
addEventHandler("onClientPreRender", root, drawCustomMarker)

function drawTextMarker()
    for k,v in ipairs(getElementsByType("marker")) do
        if getElementData(v, "marker_text") ~= false then
            local text = getElementData(v, "marker_text")
            local x, y, z = getElementPosition(v)
            local x2, y2, z2 = getCameraMatrix()
            local distance = distance or 20
            local height = height or 1
            local size = getMarkerSize(v)
            if (isLineOfSightClear(x+0.5, y, z+2, x2-0.5, y2, z2, true, true, true)) then
                local sx, sy = getScreenFromWorldPosition(x, y, z+height)
                if(sx) and (sy) then
                    local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
                    if(distanceBetweenPoints < distance) then
                        dxDrawMaterialLine3D(x+1, y, z, x-1, y, z, mat2, 2,tocolor(255, 255, 255, 255), false, x, y, z+10)
                        dxDrawMaterialLine3D(x, y, z+0.83, x, y, z+0.84, line, 1,tocolor(255, 255, 255, 255), false)
                        dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (1.2)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false, false, true, true)
                    end
                end
            end
        end
    end
end
addEventHandler("onClientRender", root, drawTextMarker)

function drawMarker()
    for k,v in ipairs(getElementsByType("marker")) do
        if getElementData(v, "marker") == true then
            local x, y, z = getElementPosition(v)
            local size = getMarkerSize(v)
            --dxDrawMaterialLine3D(x, y, z+2, x, y, z+1, mat3, size,tocolor(255, 255, 255, 255), false)
            dxDrawMaterialLine3D(x+1, y, z, x-1, y, z, mat2, 2,tocolor(255, 255, 255, 255), false, x, y, z+10)
        end
    end
end
addEventHandler("onClientPreRender", root, drawMarker)


function drawJobMarker()
    for k,v in ipairs(getElementsByType("marker")) do
        if getElementData(v, "marker_job") == true then
            local x, y, z = getElementPosition(v)
            local size = getMarkerSize(v)
            dxDrawMaterialLine3D(x, y, z+2, x, y, z+1, mat, 1,tocolor(255, 255, 255, 255), false)
            dxDrawMaterialLine3D(x+1, y, z, x-1, y, z, mat2, 2,tocolor(255, 255, 255, 255), false, x, y, z+10)
        end
    end
end
addEventHandler("onClientPreRender", root, drawJobMarker)