local types = require("types")

local skull = love.graphics.newImage("assets/packs/Pixel Art Icon Pack - RPG/Monster Part/Skull.png")
skull:setFilter("nearest", "nearest")

local slime = love.graphics.newImage("assets/packs/Pixel Art Icon Pack - RPG/Monster Part/Slime Gel.png")
slime:setFilter("nearest", "nearest")


local Object = {}
Object.__index = Object

function Object:create(name, imagesCategory, type, value)
    local image = getImageData(name, imagesCategory)
    image:setFilter("nearest", "nearest")
    
    local isCollectible = false
    local isEquipable = false
    local isConsumable = false
    local canSell = false
    local canBuy = false

    if types.collectibleTypes[type] then
        isCollectible = true
    end

    if types.equipableTypes[type] then
        isEquipable = true
    end

    if types.consumableTypes[type] then
        isConsumable = true
    end

    if types.sellableTypes[type] then
        canSell = true
    end

    if types.buyableTypes[type] then
        canBuy = true
    end

    local obj = {
        name = name,
        image = image,
        type = type,
        value = value or 1,
        position = {x = 0, y = 0},
        sizeX = image:getWidth(),
        sizeY = image:getHeight(),
        scale = 3,
        wasCollected = false,
        isCollectible = isCollectible,
        isConsumable = isConsumable,
        isEquipable = isEquipable,
        canSell = canSell,
        canBuy = canBuy,
        wasSold = false,
        wasBought = false,
        wasTrashed = false
    }

    --Generates a unique id for every object created
    obj.id = generateId(obj)

    if type == types.Types.Monster then
        obj.health = math.random(1, 3)
    end

    setmetatable(obj, Object)
    return obj
end

function Object:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y, 0, self.scale)
end

--Generates a unique id for an object
IDs = {}
function generateId(object)
    while true do
        local id = math.random(5000)
        if not IDs[id] then
            IDs[id] = object
            return id
        else
            generateId()
        end
    end
end

--Returns the image data from the images table for a particular item.
function getImageData(name, category)
    return images[category][name]
end

local function removeObjectAtTarget(targetX, targetY)
    for i = #mobsAndItems, 1, -1 do
        if mobsAndItems[i].position.x == targetX and mobsAndItems[i].position.y == targetY then
            table.remove(mobsAndItems, i)
            break
        end
    end
end

images = {

    Blank = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_blank.png"),

    mobs = {
        Skull = skull,
        Slime = slime
    },

    coins = {
        Coin1 = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_coin1.png"),
        Coin3 = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_coin3.png"),
        Coin10 = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_coin10.png")
    },

    potions = {
        FirePotion = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_potion_fire.png"),
        GhostPotion = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_potion_ghost.png"),
        HealingPotion = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_potion_healing.png"),
        LovePotion = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_potion_love.png"),
        MagicPotion = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_potion_magic.png"),
        ManaPotion = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_potion_mana.png"),
        SpectralPotion = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_potion_spectral.png"),
        PoisonousPotion = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_potion_poisonous.png")
    },

    containers = {
        Sack = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_sack.png"),
        Bag = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bag.png")
    },

    weapons = {
        Alebard = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_alebard.png"),

        BroadheadArrow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_arrow_broadhead.png"),
        FireArrow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_arrow_fire.png"),
        FlintheadArrow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_arrow_flinthead.png"),
        MagicArrow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_arrow_magic.png"),
        PoisontipArrow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_arrow_poisontip.png"),
        Arrow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_arrow.png"),

        EnchantedAxe = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_axe_enchanted.png"),
        GildedAxe = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_axe_gilded.png"),
        LightningAxe = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_axe_lightning.png"),
        MoltenAxe = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_axe_molten.png"),
        SturdyAxe = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_axe_sturdy.png"),

        CursedBattleAxe = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_battleaxe_cursed.png"),
        BattleAxe = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_battleaxe.png"),

        Bomb = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_bomb.png"),

        CryptBow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_bow_crypt.png"),
        FineBow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_bow_fine.png"),
        GildedBow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_bow_gilded.png"),
        Bow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_bow.png"),

        Club = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_club.png"),

        CompositeBow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_composite_bow.png"),
        Crossbow = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_crossbow.png"),

        CursedDagger = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_dagger_cursed.png"),
        CurvedDagger = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_dagger_curved.png"),
        FineDagger = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_dagger_fine.png"),
        GildedDagger = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_dagger_gilded.png"),
        HolyDagger = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_dagger_holy.png"),
        PoisontipDagger = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_dagger_poisontip.png"),

        Dagger = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_dagger.png"),

        Flail = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_flail.png"),

        Greatsword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_greatsword.png"),

        BlacksmithHammer = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_hammer_blacksmith.png"),
        DwarvenHammer = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_hammer_dwarven.png"),
        EnchantedHammer = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_hammer_enchanted.png"),
        LightningHammer = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_hammer_lightning.png"),
        MoltenHammer = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_hammer_molten.png"),
        Hammer= love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_hammer.png"),

        IronClub = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_iron_club.png"),

        Mace =  love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_mace.png"),

        Shiv = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_shiv.png"),

        Shortsword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_shortsword.png"),

        GildedSpear = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_spear_gilded.png"),
        Spear = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_spear.png"),

        AdventurerSword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword_adventurers.png"),
        ChampionsSword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword_champions.png"),
        CrystalSword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword_crystal.png"),
        CursedSword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword_cursed.png"),
        CurvedSword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword_curved.png"),
        EnchantedSword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword_enchanted.png"),
        BlazingSword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword_blazing.png"),
        LightningSword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword_lightning.png"),
        MoltenSword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword_molten.png"),
        Sword = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_sword.png"),

        RubyWand = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_wand_ruby.png"),
        SkullWand = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_wand_skull.png"),
        SorcerersWand = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_wand_sorcerers.png"),
        TopazWand = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_wand_topaz.png"),
        TwigWand = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_wand_twig.png"),
        Wand = love.graphics.newImage("assets/packs/Pack Of Holding/weapon/items_wand.png")
    },

    shields = {
        Buckler = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_shield_buckler.png"),
        ChampionShield = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_shield_champion.png"),
        HeaterShield = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_shield_heater.png"),
        KiteShield = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_shield_kite.png"),
        MetalShield = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_shield_metal.png"),
        RoundShield = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_shield_round.png"),
        TowerShield = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_shield_tower.png"),
    },

    armor = {
        ChainArmor = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_armor_chain.png"),
        Cuirass = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_armor_cuirass.png"),
        DemoniteArmor = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_armor_demonite.png"),
        LeatherArmor = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_armor_leather.png"),
        PaddedArmor = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_armor_padded.png"),
        PlateArmor = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_armor_plate.png"),
        Tunic = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_armor_tunic.png"),
        
        AdventurerBelt = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_belt_adventurer.png"),
        GildedBelt = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_belt_gilded.png"),
        LeatherBelt = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_belt_leather.png"),
        SnakeBelt = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_belt_snake.png"),
        SturdyBelt = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_belt_sturdy.png"),
        
        DemoniteBoots = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_boots_demonite.png"),
        Greaves = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_boots_greaves.png"),
        HeavyBoots = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_boots_heavy.png"),
        LeatherBoots = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_boots_leather.png"),
        PlateBoots = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_boots_plate.png"),
        StuddedBoots = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_boots_studded.png"), 
        
        ChainGauntlet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_gauntlet_chain.png"),
        DemoniteGauntlet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_gauntlet_demonite.png"),
        GildedGauntlet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_gauntlet_gilded.png"),
        HeavyGauntlet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_gauntlet_heavy.png"),
        PlateGauntlet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_gauntlet_plated.png"),
        LeatherGlove = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_glove_leather.png"),
        
        GreatHelm = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_helm_great.png"),
        ClosedHelmet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_helmet_closed.png"),
        DemoniteHelmet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_helmet_demonite.png"),
        LeatherCap = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_helmet_leather.png"),
        NasalHelmet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_helmet_nasal.png"),
        SalletHelmet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_helmet_sallet.png"),
        ScorpionKingHelmet = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_helmet_scorpion_king.png"),
        MailCoif = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_mail_coif.png"),
        WizardHat = love.graphics.newImage("assets/packs/Pack Of Holding/armor/items_wizard_hat.png")
    },

    rings = {
        AmethystRing = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_ring_amethyst.png"),
        DiamondRing = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_ring_diamond_side.png"),
        EngravedRing = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_ring_engraved.png"),
        GoldRing = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_ring_gold.png"),
        HolyRing = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_ring_holy.png"),
        MetalRing = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_ring_metal.png"),
        RubyRing = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_ring_ruby.png"),
        SpectralRing = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_ring_spectral.png"),
        WoodenRing = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_ring_wooden.png")
    },

    amulets = {
        EmeraldAmulet = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_amulet_emerald.png"),
        HolyAmulet = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_amulet_holy.png"),
        MagicAmulet = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_amulet_magic.png")
    },

    tools = {
        Lockpick = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_tools_lockpick.PNG"),
        FishingRod = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_tools_fishingrod.png"),
        Pickaxe = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_tools_pickaxe.png"),
        Saw = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_tools_saw.png"),
        Shovel = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_tools_shovel.png"),
        Sickle = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_tools_sickle.png"),
        WoodcuttersAxe = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_tools_woodcutters_axe.png")
    },

    food = {
        Apple = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_apple.png"),
        Berry = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_berry.png"),
        Beer = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_tankard2.png"),
        Coke = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bottle_coke.png"),
        Cupcake = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_cupcake.png"),
        BowlOfFood = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bowl_full.png"),
        Carrot = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_carrot.png"),
        Cheese = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_cheese.png"),
        Fish = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_fish.png"),
        LoafBread = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bread_loaf.png"),
        RoundBread = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bread_round.png"),
        Steak = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_steak.png"),
        Wine = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bottle_wine.png")
    },

    resources = {
        Logs = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_logs.png"),
        Planks = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_planks.png")
    },

    ores = {
        Rocks = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_rocks.png"),
        Coal = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_coal.png")
    },

    bars = {
        CopperBar = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bar_copper.png"),
        GoldBar = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bar_gold.png"),
        IronBar = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bar_iron.png"),
        MythrilBar = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_bar_mythril.png")
    },

    gems = {
        Amber = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_gem_amber.png"),
        Diamond = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_gem_diamond.png"),
        Peridot = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_gem_peridot.png"),
        Ruby = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_gem_ruby.png"),
        Runestone = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_gem_runestone.png")
    },

    keys = {
        BronzeKey = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_key_bronze.png"),
        GoldKey = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_key_gold.png"),
        IronKey = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_key_iron.png"),
        SilverKey = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_key_silver.png"),
        SkullKey = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_key_skull.png"),
        WardenKey = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_key_warden.png"),
    },

    lights = {
        Candle = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_light_candle.png"),
        GhostLantern = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_light_lantern_ghost.png"),
        Lantern = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_light_lantern.png"),
        Torch = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_light_torch.png")
    },

    doorways = {
        Portal = love.graphics.newImage("assets/images/random/portal_door.png")
    },

    fabric = {
        Leather = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_fabric_leather.png"),
        Yarn = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_fabric_yarn.png")
    },

    misc = {
        Hourglass = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_hourglass.png"),
        Web = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_web.png"),
        Leaf = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_leaf.png"),
        Book = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_book.png"),
        Map = love.graphics.newImage("assets/packs/Pixel Art Icon Pack - RPG/Misc/Map.png"),
        Compass = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_compass.png"),
        Feather = love.graphics.newImage("assets/packs/Pack Of Holding/misc/items_feather.png")
    }
}

return {
    Object = Object,
    images = images,
    removeObjectAtTarget = removeObjectAtTarget
}