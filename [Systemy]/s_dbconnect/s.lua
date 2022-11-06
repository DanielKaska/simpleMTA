--[[
    Autor: Daniel Kaska
    Wszystkie prawa należą do: Daniel Kaska
    Data: 16.06.2022
    Korzystanie z tego kodu bez wcześniejszej zgody autora jest łamaniem prawa.
]]

-- Łączenie z bazą danych
function startDB(startedResource)
    if startedResource == getThisResource() then
        connection = dbConnect("mysql", "dbname=db_83860;host=127.0.0.1;charset=utf8", "root", "TajneHasloBazaDanych")
        if connection then
            outputDebugString("Połączono z bazą danych MySQL. ".."[".. getResourceName(getThisResource()).."]", 3, 255,255,255)
        else
            outputDebugString("Błąd w połączeniu z db. ".."[".. getResourceName(getThisResource()).."]", 3, 255,255,255)
        end
    end
end
addEventHandler("onResourceStart", root, startDB)


--Wysyłanie danych do bazy

function insert(...)
    if not connection then return end
        local q = dbExec(connection, ...)
        if q == false then 
            outputDebugString("Błąd podczas wysyłania danych. ".."[".. getResourceName(getThisResource()).."]", 4, 255,0,0)
        end
end

function get(...)
    if not connection then return end
        local g = dbQuery(connection, ...)
        local res = dbPoll(g, -1)
        if res == false then
            outputDebugString("Błąd podczas pobierania danych. ".."[".. getResourceName(getThisResource()).."]", 4, 255,0,0)
        end
        return res
end