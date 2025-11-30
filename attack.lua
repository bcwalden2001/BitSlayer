--Called when attacking monsters, reducing their health and/or the player's
function attack(target, damage)
    if target.health >= 1 then
        target.health = target.health - damage
    end
end

return attack
