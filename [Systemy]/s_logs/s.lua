addEvent("insert_adm_logs", true)
addEvent("insert_tp_logs", true)
db = exports.s_dbconnect

function insert_adm_logs(karajacy, karany, rodzaj_kary, dlugosc_kary, powod, data)
    db:insert("INSERT into adm_logs values (?,?,?,?,?,?)", karajacy, karany, rodzaj_kary, dlugosc_kary, powod, data)
end
addEventHandler("insert_adm_logs", getRootElement(), insert_adm_logs) 

function insert_tp_logs(zrodlo, cel, data)
    db:insert("INSERT into adm_tp_logs values (?,?,?)", zrodlo, cel, data)
end
addEventHandler("insert_tp_logs", getRootElement(), insert_tp_logs)