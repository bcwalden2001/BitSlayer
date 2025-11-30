local globals = require("globals")

--local test = love.graphics.newImage("assets/images/maps/level1.png")
local level1Sprite = love.graphics.newImage("assets/images/maps/dungeon_tiles_map.png")
level1Sprite:setFilter("nearest", "nearest")

local levels = {
    [1] = {
        levelSprite = level1Sprite,
        levelWidth = level1Sprite:getWidth(),
        levelHeight = level1Sprite:getHeight(),
        numOfTiles = 5,
        mapScale = 7,
        backgroundImage = love.graphics.newImage("assets/images/backgrounds/brick-wall.png")
    }
}

--Aliasing level1 to levels[1]
levels.level1 = levels[1]

-- Variables that change per each level
levels[1].levelWidthScaled, levels[1].levelHeightScaled = levels[1].levelWidth * levels[1].mapScale, levels[1].levelHeight * levels[1].mapScale
levels[1].levelOriginX, levels[1].levelOriginY = (globals.DESKTOP_WIDTH / 2) - (levels[1].levelWidthScaled / 2), (globals.DESKTOP_HEIGHT / 2) - (levels[1].levelHeightScaled / 2)
levels[1].levelBoundX, levels[1].levelBoundY = levels[1].levelOriginX + levels[1].levelWidthScaled, levels[1].levelOriginY + levels[1].levelHeightScaled
levels[1].tileSize = math.floor((levels[1].levelWidth * levels[1].mapScale) / levels[1].numOfTiles)

--Gets the level. Right now there's one level so the parameter should be 1.
function getLevelSprite(level)
    return levels[level].levelSprite
end

--Gets the width and height of the map in pixels
function getLevelSize(level)
    return levels[level].levelWidth, levels[level].levelHeight
end

--Gets the background image for the level
function getLevelBackground(level)
    return levels[level].backgroundImage
end

return {
    levels = levels,
    getLevelSprite = getLevelSprite,
    getLevelSize = getLevelSize,
    getLevelBackground = getLevelBackground
}
