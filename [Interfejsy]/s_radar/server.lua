local weapons = {
	"grenade",
	"teargas",
	"molotov",
	"colt 45",
	"silenced",
	"deagle",
	"shotgun",
	"sawed-off",
	"combat shotgun",
	"uzi",
	"mp5",
	"ak-47",
	"m4",
	"tec-9",
	"rifle",
	"sniper",
	"rocket launcher",
	"rocket launcher hs",
	"flamethrower",
	"minigun",
	"satchel",
	"bomb",
	"spraycan",
	"fire extinguisher",
	"camera"
}

for k,v in pairs(weapons) do
	setWeaponProperty(v, "poor", "accuracy", 300)
	setWeaponProperty(v, "std", "accuracy", 300)
	setWeaponProperty(v, "pro", "accuracy", 300)
end