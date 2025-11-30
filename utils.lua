local globals = require("globals")

local utils = {}

--Determines the center of an object
function utils.centerSpriteX(spriteImage, spriteScale)
    local newOriginX = (globals.DESKTOP_WIDTH / 2) - (spriteImage:getWidth() * spriteScale / 2)
    return newOriginX
end

function utils.centerSpriteY(spriteImage, spriteScale)
    local newOriginY = (globals.DESKTOP_HEIGHT / 2) - (spriteImage:getHeight() * spriteScale / 2)
    return newOriginY
end

return utils