
# Starting tasks completed:

Create a box ✓
Draw a box in the very center of the window ✓
Make a box move ✓
Make a box change directions while still moving ✓
Make a box stop moving when the spacebar is pressed ✓
Make the box move again after pressing the spacebar once ✓
Print text to the screen ✓
Trigger a keypressed callback function ✓
Make a move box and draw box function ✓


# Game-relevant tasks completed

Give the player and monster health bars above their heads ✓
Allow combat to work with player movement ✓
Allow the player to move within the grid ✓
Make the map bigger for future levels (3x3 -> 5x5) ✓
Create basic objects templates in the spawn method ✓
Add an inventory table to the player table ✓
Write the logic for the booleans in object:create() ✓
Change the default player skin to a test image from the new asset pack ✓
Create objects with object:create() ✓
Write the generateId() function ✓
Write the logic in love.keypressed for the 4 basic items that can spawn ✓
Add a coin counter ✓
Add an FPS counter in-game ✓
Highlight inventory slots when the mouse is hovered of them ✓
Fix removeObject function in objects.lua deleting multiple objects at once ✓
Add coin and potion sound effects ✓
Write player inventory functions for adding/removing from their inventory ✓
Add swords to the player's inventory ✓
Add shields to the player's inventory ✓
Add coins to the player's inventory ✓
Add potions to the player's inventory ✓

# Tasks to-do

Allow items to be movable in the inventory via the mouse (work-in-progress)

Add doorways/portals so player can beat the level
Add a hotbar for items with quick keys (1,2,3,...)
Allow items in the inventory to be binded to the player's hotbar
Add a player equipment slots (for armor, weapons, trinkets, etc.)
Allow items to be equipped or consumed from the player's inventory or hotbar
Add a score counter
Add an experience bar and levels for the player based on the number of monsters they have killed
Change the death screen to phase in, play music, and allow the player to restart or quit out entirely

Progression:

Add chests to hold items
Add keys that can drop when killing monsters
Add bosses
Add boss drops
Add a timer in-game

Animate tile player movement
Animate monster death
Animate portal sprite

# Design Notes:

Mob and Item Spawn Rate:

    ex) 70 - 85 % of tiles spawn monsters
    ex) 1 to 3 tiles are coins
    ex) Every level has at least one chest
    ex) Every 10 levels a boss spawns
    ex) Every 5 levels there's a shopkeeper that spawns

            - Shopkeeper features:

                - Ability to buy/sell loot with/for coins
                - More storage -> belt, sack, bag
                - Food for health
                - Special potions (random -> "Brew of the day")
                - Weapons, shields, armor and spells
                - Rings and amulets for buffs 
                - Tools and lights for sidequests and QOL
                - Keys (for chests)
                - Maps (for finding secrets)


Item Drop Chances:

74% chance for common item
20% chance for uncommon item
5% chance for rare items
1% chance for legendary item

# Core Gameplay Ideas

Focus on problem-solving?
- Limited moves
- More risk going for items
- Puzzle-oriented

Focus on freedom and progression?
- Unlimited movement and exploration encouraged
- Replayability of levels
- Looting, killing, and leveling is prioritized

World-building?
- Every 10 levels is a new world
- Every new world is larger or harder to complete
- Harder -> Higher health enemies -> Harder-hitting enemies -> Traps
    
    Easier
    3x3
    5x5
    7x7
    9x9
    Harder

Classes have special abilities...

- Rogue -> more movement -> lockpicks -> sneak ability for bypassing monsters
- Warrior -> less movement -> higher defense -> sweeping attack ability for conic damage
- Barbarian -> higher damage -> rage ability with high crit chance -> multi-hit ability
- Mage -> splash damage and piercing damage with spells -> specialization
