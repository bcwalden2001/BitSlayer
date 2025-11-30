local objects = require("objects")
local types = require("types")

--Monster is the superclass of all mobs
local monster = {}
monster.__index = monster

function monster:create()
    local mobTypes = {"Skull", "Slime"}
    local randomMob = mobTypes[math.random(1, #mobTypes)]
    local spriteImage = objects.images.mobs[randomMob]

    local instance = {
        type = types.Types.Monster,
        spriteImage = spriteImage,
        health = math.random(1, 3),
        sizeX = spriteImage:getWidth(),
        sizeY = spriteImage:getHeight(),
        scale = 3,
        position = { x = 0, y = 0},
        isDead = false
    }
    setmetatable(instance, monster)
    return instance
end

function monster:kill()
    self.isDead = true
end

function monster:getHealth()
    return self.health
end

function monster:draw()
    love.graphics.draw(self.spriteImage, self.position.x, self.position.y, 0, self.scale)
end

return monster