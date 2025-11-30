local globals = require("globals")
local objects = require("objects")
local monster = require("monster")
local Player = require("Player")
local levels = require("levels")
local types = require("types")

mobsAndItems = {}

function getTileCenter(originX, originY, tileSize, tileRowNum, tileColNum)
    local tileCenterX = originX + (tileRowNum * tileSize) + tileSize / 2
    local tileCenterY = originY + (tileColNum * tileSize) + tileSize / 2
    return tileCenterX, tileCenterY
end

function centerObjectInTile(object, tileCenterX, tileCenterY)
    local offsetX = object.sizeX * object.scale / 2
    local offsetY = object.sizeY * object.scale / 2
    object.position.x = tileCenterX - offsetX
    object.position.y = tileCenterY - offsetY
end

--Creates monsters, items, and a doorway and spawns them into the map
local function spawn(numOfTiles, mapScale)
    local levelWidth, levelHeight = levels.levels[1].levelWidth, levels.levels[1].levelHeight
    local levelWidthScaled, levelHeightScaled = levelWidth * mapScale, levelHeight * mapScale
    local levelOriginX, levelOriginY = (globals.DESKTOP_WIDTH / 2) - (levelWidthScaled / 2), (globals.DESKTOP_HEIGHT / 2) - (levelHeightScaled / 2)
    local tileSize = math.floor((levelWidth * mapScale) / numOfTiles)
    local tileCounter = 1

    for y = 0, numOfTiles - 1 do
        for x = 0, numOfTiles - 1 do
            local tileCenterX = (levelOriginX + (x * tileSize) + tileSize / 2)
            local tileCenterY = (levelOriginY + (y * tileSize) + tileSize / 2)
            if not (y == numOfTiles - 1 and x == math.floor(numOfTiles / 2)) then
                if currentLevel == 1 then
                    if math.random() < .80 then
                        local newMonster = monster:create()
                        centerObjectInTile(newMonster, tileCenterX, tileCenterY)
                        table.insert(mobsAndItems, newMonster)
                    elseif math.random() < .10 then
                        -- Find the correct chest image to use
                        --
                        -- local chest = Object:create("Chest")
                        -- centerObjectInTile(chest, tileCenterX, tileCenterY)
                        -- table.insert(mobsAndItems, chest)
                    else
                        local coin1 = objects.Object:create("Coin1", "coins", types.Types.Coin, 1)
                        local healthPotion = objects.Object:create("HealingPotion", "potions", types.Types.Potion, 1)
                        local adventurerSword = objects.Object:create("AdventurerSword", "weapons", types.Types.Weapon, 1)
                        local shield = objects.Object:create("HeaterShield", "shields", types.Types.Shield, 1)
                        local items = {coin1, healthPotion, adventurerSword, shield}
                        local randomItem = items[math.random(1, #items)]
                        centerObjectInTile(randomItem, tileCenterX, tileCenterY)
                        table.insert(mobsAndItems, randomItem)
                    end
                else
                    print("There are no other levels besides level 1")
                end
            else
                centerObjectInTile(Player, tileCenterX, tileCenterY)
                Player.x = tileCenterX
                Player.y = tileCenterY
            end
            tileCounter = tileCounter + 1
        end
    end
end

local function getAllMobsAndItems()
    return mobsAndItems
end

return {
    spawn = spawn,
    getAllMobsAndItems = getAllMobsAndItems
}


