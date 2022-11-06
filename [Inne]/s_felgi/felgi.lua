function felgi()

txd = engineLoadTXD("wheel_or1.txd")
engineImportTXD(txd, 1025)
dff = engineLoadDFF("wheel_or1.dff", 1025)
engineReplaceModel(dff, 1025)

txd = engineLoadTXD("wheel_sr6.txd")
engineImportTXD(txd, 1073)
dff = engineLoadDFF("wheel_sr6.dff", 1073)
engineReplaceModel(dff, 1073)

txd = engineLoadTXD("wheel_sr3.txd")
engineImportTXD(txd, 1074)
dff = engineLoadDFF("wheel_sr3.dff", 1074)
engineReplaceModel(dff, 1074)

txd = engineLoadTXD("wheel_sr2.txd")
engineImportTXD(txd, 1075)
dff = engineLoadDFF("wheel_sr2.dff", 1075)
engineReplaceModel(dff, 1075)

txd = engineLoadTXD("wheel_lr4.txd")
engineImportTXD(txd, 1076)
dff = engineLoadDFF("wheel_lr4.dff", 1076)
engineReplaceModel(dff, 1076)

txd = engineLoadTXD("wheel_lr3.txd")
engineImportTXD(txd, 1078)
dff = engineLoadDFF("wheel_lr3.dff", 1078)
engineReplaceModel(dff, 1078)

txd = engineLoadTXD("wheel_lr1.txd")
engineImportTXD(txd, 1077)
dff = engineLoadDFF("wheel_lr1.dff", 1077)
engineReplaceModel(dff, 1077)

txd = engineLoadTXD("wheel_sr1.txd")
engineImportTXD(txd, 1079)
dff = engineLoadDFF("wheel_sr1.dff", 1079)
engineReplaceModel(dff, 1079)

txd = engineLoadTXD("wheel_sr5.txd")
engineImportTXD(txd, 1080)
dff = engineLoadDFF("wheel_sr5.dff", 1080)
engineReplaceModel(dff, 1080)

txd = engineLoadTXD("wheel_sr4.txd")
engineImportTXD(txd, 1081)
dff = engineLoadDFF("wheel_sr4.dff", 1081)
engineReplaceModel(dff, 1081)

txd = engineLoadTXD("wheel_gn1.txd")
engineImportTXD(txd, 1082)
dff = engineLoadDFF("wheel_gn1.dff", 1082)
engineReplaceModel(dff, 1082)

txd = engineLoadTXD("wheel_lr2.txd")
engineImportTXD(txd, 1083)
dff = engineLoadDFF("wheel_lr2.dff", 1083)
engineReplaceModel(dff, 1083)

txd = engineLoadTXD("wheel_lr5.txd")
engineImportTXD(txd, 1084)
dff = engineLoadDFF("wheel_lr5.dff", 1084)
engineReplaceModel(dff, 1084)

txd = engineLoadTXD("wheel_gn2.txd")
engineImportTXD(txd, 1085)
dff = engineLoadDFF("wheel_gn2.dff", 1085)
engineReplaceModel(dff, 1085)

txd = engineLoadTXD("wheel_gn3.txd")
engineImportTXD(txd, 1096)
dff = engineLoadDFF("wheel_gn3.dff", 1096)
engineReplaceModel(dff, 1096)

txd = engineLoadTXD("wheel_gn4.txd")
engineImportTXD(txd, 1097)
dff = engineLoadDFF("wheel_gn4.dff", 1097)
engineReplaceModel(dff, 1097)

txd = engineLoadTXD("wheel_gn5.txd")
engineImportTXD(txd, 1098)
dff = engineLoadDFF("wheel_gn5.dff", 1098)
engineReplaceModel(dff, 1098)













end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), felgi)