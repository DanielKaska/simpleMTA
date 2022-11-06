table={
    {"dgs"},
    {"s_dbconnect"},
    {"blur_box"},
    {"no_speed_blur"},
    {"pizza_sign"},
    {"playerblips"},
    {"s_citybuses"},
    {"s_core"},
    {"s_f3"},
    {"s_cars"},
    {"s_farma"},
    {"s_felgi"},
    {"s_hud"},
    {"s_licenses"},
    {"s_login"},
    {"s_logs"},
    {"s_markers"},
    {"s_noti"},
    {"s_payment"},
    {"s_pizza"},
    {"s_playtime"},
    {"s_radar"},
    {"s_sapd"},
    {"s_sara"},
    {"s_tickets"},
    {"s_vehs"},
    {"bone_attach"},
    {"suszarka"},
    {"s_vending"},
    {"przecho_dillimore"},
    {"park"},
    {"floor_model"},
    {"4177"},
    {"taser"},
    {"s_office"}
}

mapy={
    {"mechanik"},
    {"mechanikBB_mapa"},
    {"montgomery_extension"},
    {"przecho_dillimore"},
    {"s_park_mapa"}
}

for i,v in ipairs(mapy) do
    startResource(getResourceFromName(v[1]))
end

for i,v in ipairs(table) do
    startResource(getResourceFromName(v[1]))
end