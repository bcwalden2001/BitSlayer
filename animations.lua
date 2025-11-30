local inventory = require("inventory")

local animations = {}
local draggingItem = nil
local dragIndex = 1
local itemScale = 1.8

--Draws the inventory to the screen
function animations.drawInventorySlots()
    love.graphics.draw(inventory.slots_4x4, inventory.originX, inventory.originY, 0, inventory.scale, inventory.scale)
end

--Draws a slightly darker grey box in an empty inventory when the mouse is hovered over the slot
function animations.enableSlotHighlighting()
    for _, slot in ipairs(inventory.slots) do
        local x, y = slot.x, slot.y
        if love.mouse.getX() >= x and love.mouse.getX() <= x + inventory.slotSizeInPixels
        and love.mouse.getY() >= y and love.mouse.getY() <= y + inventory.slotSizeInPixels then
            love.graphics.draw(inventory.slotHighlight, x, y, 0, inventory.scale, inventory.scale)
        end
    end
end

--Draws the items in the inventory to the screen
function animations.drawInventoryItems()
    if next(Player.inventory.items) ~= nil then
        for i = 1, #Player.inventory.items do
            local slot = inventory.slots[i]
            love.graphics.draw(Player.inventory.items[i].image, slot.x, slot.y, 0, itemScale,itemScale)
        end
    end

    if draggingItem then
        --Attaches the center of the item to the mouse
        love.graphics.draw(draggingItem.image, love.mouse.getX() - ((draggingItem.sizeX / 2) * itemScale), love.mouse.getY() - ((draggingItem.sizeY / 2) * itemScale), 0, itemScale, itemScale)
    end
end

--Adds drag-and-drop functionality of inventory items
function animations.moveItemsInInventory()
    --Get the mouse coordinates
    local mouseX, mouseY = love.mouse.getX(), love.mouse.getY()
    --If mouse is pressed down then
    if love.mouse.isDown(1) then
        if not draggingItem then
            for i, slot in ipairs(inventory.slots) do
                --If mouse position is within an inventory slot 
                if ((mouseX >= slot.x and mouseX <= slot.x + inventory.slotSizeInPixels) and
                    (mouseY >= slot.y and mouseY <= slot.y + inventory.slotSizeInPixels)) then
                    if Player.inventory.items[i] then
                        draggingItem = Player.inventory.items[i]
                        dragIndex = i
                        Player.inventory.items[i] = nil
                    end
                end
            end
        end
    else
        if draggingItem then
        --Try dropping the item into an empty slot
            for i, slot in ipairs(inventory.slots) do
                if mouseX >= slot.x and mouseX <= slot.x + inventory.slotSizeInPixels and
                mouseY >= slot.y and mouseY <= slot.y + inventory.slotSizeInPixels then
                    Player.inventory.items[i] = draggingItem
                    draggingItem = nil
                    return
                end
            end
            --If the item is not dropped into a slot, return it to the original slot
            Player.inventory.items[dragIndex] = draggingItem
            draggingItem = nil
        end
    end
end

return animations