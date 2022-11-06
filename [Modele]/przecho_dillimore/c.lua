local model_id       = 12863 
local have_alpha     = false 
local is_double_sided= true 
local txd_name       = "przecho_dillimore.txd"
local col_name       = "przecho_dillimore.col"
local dff_name        = "przecho_dillimore.dff"

local col = engineLoadCOL ( col_name )
engineReplaceCOL ( col, model_id)
local txd = engineLoadTXD ( txd_name )
engineImportTXD ( txd, model_id)
local dff = engineLoadDFF ( dff_name )
engineReplaceModel ( dff, model_id, have_alpha )

if is_double_sided then
  for _, obj in pairs(getElementsByType("object")) do
    if getElementModel(obj) == model_id then
      setElementDoubleSided(obj, true)
    end
  end
end