local model_id       = 12939 -- id modelu który chcesz podmienić (podaj liczbe)
local have_alpha     = false -- czy twój model na przezroczyste tekstury? (podaj true lub false)
local is_double_sided= true -- czy chcesz ustawić double sided na istniejące już obiekty z tym id? (true lub false)
local col_name       = "park.col" -- nazwa pliku col
local dff_name        = "park.dff" -- nazwa pliku dff

local col = engineLoadCOL ( col_name )
engineReplaceCOL ( col, model_id)
local dff = engineLoadDFF ( dff_name )
engineReplaceModel ( dff, model_id, have_alpha )

if is_double_sided then
  for _, obj in pairs(getElementsByType("object")) do
    if getElementModel(obj) == model_id then
      setElementDoubleSided(obj, true)
    end
  end
end