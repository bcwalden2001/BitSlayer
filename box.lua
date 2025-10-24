-- This is the first bit of code I wrote before I made the game 
-- so I could learn the basics of Lua and Love2D

local box = {}

local posXLeft = 350
local posXRight = 450
local posYBottom = 450
local posYTop = 350
local movingRight = true
local stop = false

function box.load()
    love.window.setMode(800, 800, {resizable=true})
    gamePausedFontHeader = love.graphics.newFont("/assets/gamepaused.otf", 40)
    gamePausedFontDefault = love.graphics.newFont("/assets/gamepaused.otf", 25)
end

function box.update(dt)
    moveBox(300, dt)
end

function box.draw()
    spacebarPressed()
    drawBox(posXLeft, posXRight)
end

function box.keypressed(key)
    if key == 'space' then
        stop = not stop
        showMessage = true
    end
end

function spacebarPressed()
    if showMessage then
        if stop then
            love.graphics.print("You pressed the spacebar and  \n the box stopped again!", gamePausedFontDefault, 100, 100)
        else
            love.graphics.print("You pressed the spacebar and  \n the started moving again!", gamePausedFontDefault, 100, 100)
        end
    else
        love.graphics.print("Press the spacebar to stop the box", gamePausedFontHeader, 100, 100)
    end
end

function moveBox(speed, dt)

    if stop == false then 

        -- Moving left and right
        if movingRight == true then
            posXRight = posXRight + speed * dt
            posXLeft = posXLeft + speed * dt
        elseif movingRight == false then
            posXRight = posXRight - speed * dt
            posXLeft = posXLeft - speed * dt

        end

        -- Bouncing off walls
        if posXRight >= 800 then 
            movingRight = false
        elseif posXLeft <= 0 then
            movingRight = true

        end
    end
end

function drawBox(posXLeft, posXRight)
    local boxVertices = {posXLeft,posYTop, posXRight,posYTop, posXRight,posYBottom, posXLeft,posYBottom}
    love.graphics.polygon("fill", boxVertices)
end

return box