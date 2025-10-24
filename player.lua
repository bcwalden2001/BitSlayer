local spriteImage = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_cupcake.png")
spriteImage:setFilter("nearest", "nearest")

Player = {
    type = "Player",
    spriteImage = spriteImage,
    currentHealth = 10,
    maxHealth = 10,
    inventory = {coins = 0,
                 items = {},
                },
    sizeX = spriteImage:getWidth(),
    sizeY = spriteImage:getHeight(),
    scale = 3,
    position = {x = 0, y = 0},
    isDead = false
}

function Player.draw()
    love.graphics.draw(Player.spriteImage, Player.position.x, Player.position.y, 0, Player.scale, Player.scale)
    love.graphics.setColor(1, 1, 1, 1)
end

--Free-roaming movement for testing purposes

-- function move(speed, dt)
--     if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
--         Player.x = Player.x - speed * dt
--     end
--     if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
--         Player.x = Player.x + speed * dt
--     end
--     if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
--         Player.y = Player.y - speed * dt
--     end
--     if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
--         Player.y = Player.y + speed * dt
--     end
-- end

return Player