local Types = {
    Amulet = "amulet",
    Armor = "armor",
    Bar = "bar",
    Coin = "coin",
    Container = "container",
    Doorway = "doorway",
    Fabric = "fabric",
    Food = "food",
    Gem = "gem",
    Key = "key",
    Light = "light",
    Misc = "misc",
    Monster = "monster",
    Ore = "ore",
    Potion = "potion",
    Resource = "resource",
    Ring = "ring",
    Shield = "shield",
    Tool = "tool",
    Weapon = "weapon",
}

local collectibleTypes = {
    [Types.Amulet] = true,
    [Types.Armor] = true,
    [Types.Bar] = true,
    [Types.Coin] = true,
    [Types.Container] = true,
    [Types.Fabric] = true,
    [Types.Food] = true,
    [Types.Gem] = true,
    [Types.Key] = true,
    [Types.Light] = true,
    [Types.Misc] = true,
    [Types.Ore] = true,
    [Types.Potion] = true,
    [Types.Resource] = true,
    [Types.Ring] = true,
    [Types.Shield] = true,
    [Types.Tool] = true,
    [Types.Weapon] = true,
}

local consumableTypes = {
    [Types.Food] = true,
    [Types.Potion] = true
}

local equipableTypes = {
    [Types.Amulet] = true,
    [Types.Armor] = true,
    [Types.Container] = true,
    [Types.Ring] = true,
    [Types.Shield] = true,
    [Types.Tool] = true,
    [Types.Weapon ] = true
}

local sellableTypes = {
    [Types.Amulet] = true,
    [Types.Armor] = true,
    [Types.Bar] = true,
    [Types.Container] = true,
    [Types.Fabric] = true,
    [Types.Food] = true,
    [Types.Gem] = true,
    [Types.Key] = true,
    [Types.Light] = true,
    [Types.Misc] = true,
    [Types.Ore] = true,
    [Types.Potion] = true,
    [Types.Resource] = true,
    [Types.Ring] = true,
    [Types.Shield] = true,
    [Types.Tool] = true,
    [Types.Weapon] = true
}

local buyableTypes = {
    [Types.Amulet] = true,
    [Types.Armor] = true,
    [Types.Bar] = true,
    [Types.Container] = true,
    [Types.Fabric] = true,
    [Types.Food] = true,
    [Types.Gem] = true,
    [Types.Key] = true,
    [Types.Light] = true,
    [Types.Misc] = true,
    [Types.Ore] = true,
    [Types.Potion] = true,
    [Types.Resource] = true,
    [Types.Ring] = true,
    [Types.Shield] = true,
    [Types.Tool] = true,
    [Types.Weapon] = true
}

return {
    Types = Types,
    collectibleTypes = collectibleTypes,
    consumableTypes = consumableTypes,
    equipableTypes = equipableTypes,
    sellableTypes = sellableTypes,
    buyableTypes = buyableTypes
}