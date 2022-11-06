local txd = engineLoadTXD("trash.txd")
local dff = engineLoadDFF("trash.dff")

engineReplaceModel(dff, 408)
engineImportTXD(txd, 408)