local globals = require("globals")
local types = require("types")
local utils = require("utils")
local levels = require("levels")

local inventory = {}
inventory.slots = {}

inventory.slots_4x4 = love.graphics.newImage("assets/images/ui/Black-4x4.png")
inventory.slots_1x4 = love.graphics.newImage("assets/images/ui/Black-1x4.png")
inventory.slots_1x4:setFilter("nearest", "nearest")
inventory.slots_4x4:setFilter("nearest", "nearest")

inventory.slotHighlight = love.graphics.newImage("assets/images/ui/Slot-Highlight.png")

inventory.numOfSlots = 4
inventory.scale = 4
inventory.slotSizeInPixels = 14 * inventory.scale

inventory.originX = 1075
inventory.originY = 300

function inventory.createInventory()
    for col = 0, inventory.numOfSlots - 1 do
        for row = 0, inventory.numOfSlots - 1 do
            local padding = 5 * inventory.scale
            local slotGap = 3 * inventory.scale
            local x = inventory.originX + (row * (inventory.slotSizeInPixels + slotGap)) + padding
            local y = inventory.originY + (col * (inventory.slotSizeInPixels + slotGap)) + padding
            table.insert(inventory.slots, {x = x, y = y})
        end
    end
end

function inventory.addItem(item)
    if types.collectibleTypes[item.type] and (item.wasCollected or item.wasBought) then
        table.insert(Player.inventory.items, item)
    end
end

function inventory.removeItem(item)
    if types.collectibleTypes[item.type] and (item.wasTrashed or item.wasSold) then
        for i = 1, #Player.inventory.items do
            if item.id == Player.inventory.items[i].id then
                table.remove(Player.inventory.items, i)
                break
            end
        end
    end
end

--Allow items in the inventory to bind to a selected key when hovered-over with the mouse
function bindItemToHotbar(item)
    --If mouse position is within an inventory slot and the inventory slot is not empty then
        --If key (1, 2, 3, or 4) is pressed then
            -- Move selected inventory item to the correct hotbar location
            -- Move current item in hotbar back into the first available inventory slot
end

return inventory, inventory.slotSizeInPixels