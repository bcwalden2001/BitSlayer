-- This will eventually be implemented into animations to show player and monster deaths
alpha = 1
isDecreasing = true

if isDecreasing == true then
    alpha = alpha - .03
elseif isDecreasing == false then
    alpha = alpha + .03
end

if alpha >= 1 then
    isDecreasing = true
    alpha = alpha - .03
end
if alpha <= 0 then
    isDecreasing = false
    alpha = alpha + .03
end