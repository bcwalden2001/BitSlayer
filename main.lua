--I made this game because I was inspired by a mini arcade game in Sludge Life called Crypt Creeper.

local globals = require("globals")
local fonts = require("fonts")
local levels = require("levels")
local inventory = require("inventory")
local animations = require("animations")
local sounds = require("audio")
local spawn = require("spawn")
local objects = require("objects")
local Player = require("Player")
local types = require("types")
local attack = require("attack")

function love.load()
    --Random seed so math.random() is actually random every time its called
    math.randomseed(os.time())

    --Window settings
    love.window.setMode(globals.DESKTOP_WIDTH, globals.DESKTOP_HEIGHT, {fullscreen = false, borderless = true})

    -- Custom app icon
    local appIcon = love.image.newImageData('assets/images/icons/demon.PNG') --DO NOT USE AI SLOP
    love.window.setIcon(appIcon)

    --Load fonts here
    FONT_ArcadiaSmall = fonts.FONT_ArcadiaSmall
    FONT_ArcadiaMedium = fonts.FONT_ArcadiaMedium
    FONT_ArcadiaLarge = fonts.FONT_ArcadiaLarge

    --Load level here
    blankScreenPlayed = false
    currentLevel = 1
    levelBackground = levels.getLevelBackground(currentLevel)
    levelSprite = levels.getLevelSprite(currentLevel)

    --Spawns objects into the level here
    spawn.spawn(levels.levels[1].numOfTiles, levels.levels[1].mapScale)
    portal = objects.Object:create("Portal", "doorways", 1)

    --Initializes the player's inventory
    inventory.createInventory()

    --Load Text objects here
    deathScreenText = love.graphics.newText(FONT_ArcadiaLarge, "YOU DIED")

end

function love.update(dt)
    if Player.currentHealth <= 0 then
        Player.isDead = true
    end

    animations.moveItemsInInventory()
end

function love.draw()
    if not blankScreenPlayed then

        --Draws the background image
        love.graphics.draw(levelBackground, 0, 0, 0, 1, 1)

        --Mouse coordinates for testing purposes
        local mouseX, mouseY = love.mouse.getPosition()
        love.graphics.print("mouseX "..mouseX.." ", 0, 500)
        love.graphics.print("mouseY "..mouseY.." ", 0, 530)

        --Frame counter
        love.graphics.setFont(FONT_ArcadiaMedium)
        love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 25)
        love.graphics.setFont(FONT_ArcadiaSmall)

        --Draws the map
        love.graphics.draw(levelSprite, globals.DESKTOP_WIDTH / 2, globals.DESKTOP_HEIGHT / 2, 0, levels.levels[1].mapScale, levels.levels[1].mapScale, levels.levels[1].levelWidth / 2, levels.levels[1].levelHeight / 2)
        
        animations.drawInventorySlots()
        animations.drawInventoryItems()

        --Drawing objects on the map
        for _, i in ipairs(mobsAndItems) do
            --Draws monsters and their health bars
            if i.type == types.Types.Monster and not i.isDead then
                local monster = i
                monsterPresent = true
                monster:draw()
                love.graphics.print(monster:getHealth(), monster.position.x, monster.position.y, 0, 1, 1)
            end
            --Draws items and their values
            if i.type ~= types.Types.Monster and i.type ~= types.Types.Doorway and not i.wasCollected then --Doorway will eventually need to be drawn
                local item = i
                item:draw()
                love.graphics.print(item.value, item.position.x, item.position.y, 0, 1, 1)
            end
            if not monsterPresent then
                portal:draw() --FIXME -> This needs to spawned and drawn in a random tile
            end
        end

        --Draws the Player, their health bar and other game stats
        if not Player.isDead then
            Player.draw()
            love.graphics.setFont(FONT_ArcadiaSmall)
            love.graphics.print(Player.currentHealth, Player.position.x, Player.position.y, 0, 1, 1)
            love.graphics.setFont(FONT_ArcadiaMedium)
            love.graphics.print("COINS COLLECTED: "..Player.inventory.coins.." ", 30, 300, 0, 1, 1)
        else
            blankScreenPlayed = true
        end
    else
        love.graphics.setFont(FONT_ArcadiaLarge)
        love.graphics.draw(deathScreenText, globals.DESKTOP_WIDTH / 2 - deathScreenText:getWidth() / 2, 
                                            globals.DESKTOP_HEIGHT / 2 - deathScreenText:getHeight() / 2)
    end
end

--Handles Player movement, attack mechanics and item hotbar binding
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    local targetX, targetY  = Player.position.x, Player.position.y

    if key == "a" or key == "left" then
        targetX = Player.position.x - levels.levels[1].tileSize
        -- print("targetX after pressing left: ", targetX)
    elseif key == "d" or key == "right" then
        targetX = Player.position.x + levels.levels[1].tileSize
        -- print("targetX after pressing right: ", targetX)
    elseif key == "s" or key == "down" then
        targetY = Player.position.y + levels.levels[1].tileSize
        -- print("targetY after pressing down: ", targetY)
    elseif key == "w" or key == "up" then
        targetY = Player.position.y - levels.levels[1].tileSize
        -- print("targetY after pressing up: ", targetY)
    end

    --Check object before initiating an action or event
    monsterInTile = false
    for _, i in ipairs(mobsAndItems) do
        if i.type == types.Types.Monster then
            local monster = i
            if (monster.position.x == targetX and monster.position.y == targetY) and not monster.isDead then
                monsterInTile = true
                attack(monster, 1)
                Player.currentHealth = Player.currentHealth - 1
                if monster.health <= 0 then
                    monster.isDead = true
                    Player.position.x = monster.position.x
                    Player.position.y = monster.position.y
                    objects.removeObjectAtTarget(targetX, targetY)

                    local monsterKillSound = sounds.monsterKillSound:clone()
                    monsterKillSound:setVolume(.5)
                    monsterKillSound:play()
                    
                    break
                end
            end

        elseif i.type == types.Types.Potion then
            local healthPotion = i
            if (healthPotion.position.x == targetX and healthPotion.position.y == targetY) then
                if Player.currentHealth < Player.maxHealth then
                    Player.currentHealth  = Player.currentHealth + 1
                    local potionConsumeSound = sounds.potionConsumeSound:clone()
                    potionConsumeSound:setVolume(.5)
                    potionConsumeSound:play()
                else
                    healthPotion.wasCollected = true
                    inventory.addItem(healthPotion)
                end
                objects.removeObjectAtTarget(targetX, targetY)
                break
            end

        elseif i.type == types.Types.Coin then
            local coin = i
            if (coin.position.x == targetX and coin.position.y == targetY) then
                Player.inventory.coins = Player.inventory.coins + 1
                coin.wasCollected = true
                local coinCollectSound = sounds.coinCollectSound:clone()
                coinCollectSound:setVolume(.5)
                coinCollectSound:play()
                inventory.addItem(coin)
                objects.removeObjectAtTarget(targetX, targetY)
                break
            end

        elseif i.type == types.Types.Weapon then
            local weapon = i
            if (weapon.position.x == targetX and weapon.position.y == targetY) then
                weapon.wasCollected = true
                local weaponCollectSound = sounds.weaponCollectSound:clone()
                weaponCollectSound:setVolume(.5)
                weaponCollectSound:play()
                inventory.addItem(weapon)
                objects.removeObjectAtTarget(targetX, targetY)
                break
            end

        elseif i.type == types.Types.Shield then
            local shield = i
            if (shield.position.x == targetX and shield.position.y == targetY) then
                shield.wasCollected = true
                local shieldCollectSound = sounds.shieldCollectSound:clone()
                shieldCollectSound:setVolume(.5)
                shieldCollectSound:play()
                inventory.addItem(shield)
                objects.removeObjectAtTarget(targetX, targetY)
                break
            end
        --check for more types later (chests, doorways, )
        end
    end

    -- Print statements for testing purposes
    -- print("\n", monsterExists)
    -- print(targetX, targetY)
    -- print(levelOriginX, levelOriginY)
    -- print(levelBoundX, levelBoundY)
    -- print(levelWidthScaled, levelHeightScaled, "\n")

    --Enables the Player to move into empty tiles
    local tileCols = math.floor((targetX - levels.levels[1].levelOriginX) / levels.levels[1].tileSize)
    local tileRows = math.floor((targetY - levels.levels[1].levelOriginY) / levels.levels[1].tileSize)
    if monsterInTile == false and ((tileCols >= 0 and tileCols < levels.levels[1].numOfTiles) and (tileRows >= 0 and tileRows < levels.levels[1].numOfTiles)) then
        Player.position.x = targetX
        Player.position.y = targetY
    end
end
