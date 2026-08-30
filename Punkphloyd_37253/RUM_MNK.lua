local profile = {};

local tp_sets = {
    [379] = {
        Head = 'Optical Hat',
        Ring2 = 'Toreador\'s Ring',
        Feet = 'Fuma Sune-ate',
    },
    [369] = {
        Head = 'Panther Mask +1',
        Ring2 = 'Toreador\'s Ring',
        Feet = 'Dune Boots',
    },
    [362] = {
        Head = 'Panther Mask +1',
        Ring2 = 'Flame Ring',
        Feet = 'Dune Boots',
    },
};

local ws_sets = {
    [394] = {
        Head = 'Optical Hat',
        Ear2 = 'Merman\'s Earring',
        Body = 'Shura Togi',
        Ring2 = 'Toreador\'s Ring',
        Waist = 'Life Belt',
    },
    [384] = {
        Head = 'Optical Hat',
        Ear2 = 'Merman\'s Earring',
        Body = 'Shura Togi',
        Ring2 = 'Toreador\'s Ring',
        Waist = 'Black Belt',
    },
    [377] = {
        Head = 'Optical Hat',
        Ear2 = 'Merman\'s Earring',
        Body = 'Shura Togi',
        Ring2 = 'Flame Ring',
        Waist = 'Black Belt',
    },
    [367] = {
        Head = 'Mel. Crown +1',
        Ear2 = 'Merman\'s Earring',
        Body = 'Shura Togi',
        Ring2 = 'Flame Ring',
        Waist = 'Black Belt',
    },
    [363] = {
        Head = 'Mel. Crown +1',
        Ear2 = 'Merman\'s Earring',
        Body = 'Kirin\'s Osode',
        Ring2 = 'Flame Ring',
        Waist = 'Black Belt',
    },
};

local hf_sets = {
    [405] = {
        Head = 'Optical Hat',
        Ear1 = 'Minuet Earring',
        Ring2 = 'Toreador\'s Ring',
        Waist = 'Life Belt',
        Legs = 'Byakko\'s Haidate',
    },
    [401] = {
        Head = 'Optical Hat',
        Ear1 = 'Minuet Earring',
        Ring2 = 'Toreador\'s Ring',
        Waist = 'Life Belt',
        Legs = 'Shura Haidate',
    },
    [394] = {
        Head = 'Optical Hat',
        Ear1 = 'Minuet Earring',
        Ring2 = 'Flame Ring',
        Waist = 'Life Belt',
        Legs = 'Melee Hose',
    },
    [384] = {
        Head = 'Mel. Crown +1',
        Ear1 = 'Minuet Earring',
        Ring2 = 'Flame Ring',
        Waist = 'Life Belt',
        Legs = 'Melee Hose',
    },
    [379] = {
        Head = 'Mel. Crown +1',
        Ear1 = 'Merman\'s Earring',
        Ring2 = 'Flame Ring',
        Waist = 'Life Belt',
        Legs = 'Melee Hose',
    },
    [371] = {
        Head = 'Mel. Crown +1',
        Ear1 = 'Merman\'s Earring',
        Ring2 = 'Flame Ring',
        Waist = 'Brown Belt',
        Legs = 'Melee Hose',
    },
    [363] = {
        Head = 'Mel. Crown +1',
        Ear1 = 'Merman\'s Earring',
        Ring2 = 'Flame Ring',
        Waist = 'Brown Belt',
        Legs = 'Melee Hose',
    },
};

local sets = {
    Idle = {
        Ammo = 'Happy Egg',
        Head = 'Dream Ribbon',
        Neck = 'Evasion Torque',
        Ear1 = 'Novia Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Melee Cyclas',
        Hands = 'Seiryu\'s Kote',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Shadow Ring',
        Waist = 'Black Belt',
        Back = 'Resentment Cape',
        Legs = 'Melee Hose',
        Feet = 'Melee Gaiters',
    },
    PDT = {
        Ammo = 'Happy Egg',
        Head = 'Arh. Jinpachi +1',
        Neck = 'Evasion Torque',
        Ear1 = 'Ethereal Earring',
        Ear2 = 'Novia Earring',       -- hp or mp
        Body = 'Arhat\'s Gi +1',
        Hands = 'Seiryu\'s Kote',
        Ring1 = 'Jelly Ring',
        Ring2 = 'Shadow Ring',
        Back = 'Boxer\'s Mantle',     -- shadow mantle
        Waist = 'Black Belt',
        Legs = 'Melee Hose',
        Feet = 'Melee Gaiters',
    },
    Resting = {
        Ammo = 'Happy Egg',
        Head = 'Tpl. Crown +1',
        Neck = 'Evasion Torque',
        Ear1 = 'Novia Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Melee Cyclas',
        Hands = 'Seiryu\'s Kote',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Shadow Ring',
        Back = 'Melee Cape',
        Waist = 'Black Belt',
        Legs = 'Melee Hose',
        Feet = 'Melee Gaiters',
    },
    TpBase = {
        --Ammo = 'Tiphia Sting',
        Ammo = 'Virtue Stone',
        Neck = 'Faith Torque',
        Ear1 = 'Wyvern Earring',
        --Ear1 = 'Ethereal Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Shura Togi',
        --Hands = 'Ochiudo\'s Kote',
        Hands = 'Mel. Gloves +1',
        Ring1 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Black Belt',
        Legs = 'Byakko\'s Haidate',
    },
    JumpBase = {
        Ammo = 'Tiphia Sting',
        --Ear1 = 'Wyvern Earring',
        Ear1 = 'Merman\'s Earring',
        Neck = 'Faith Torque',
        --Ear1 = 'Merman\'s Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Shura Togi',
        --Hands = 'Ochiudo\'s Kote',
        Hands = 'Mel. Gloves +1',
        Ring1 = 'Rajas Ring',
        Back = 'Wyvern Mantle',
        Waist = 'Black Belt',
        Legs = 'Shura Haidate',
        Feet = 'Shura Sune-ate',
    },
    WsBase = {
        Ammo = 'Tiphia Sting',
        Neck = 'Faith Torque',
        Ear1 = 'Novia Earring',
        --Hands = 'Ochiudo\'s Kote',
        Hands = 'Mel. Gloves +1',
        Ring1 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Legs = 'Shura Haidate',
        Feet = 'Shura Sune-ate',
    },
    WsEarth = {
        Neck = 'Soil Gorget',
    },
    WsThunder = {
        Neck = 'Thunder Gorget',
    },
    HfBase = {
        --Ammo = 'Tiphia Sting',
        Ammo = 'Virtue Stone',
        Ear2 = 'Brutal Earring',
        Body = 'Kirin\'s Osode',
        Hands = 'Mel. Gloves +1',
        Ring1 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Legs = 'Bahamut\'s Hose',
        Feet = 'Dune Boots',
    },
    Evasion = {
        Ammo = 'Orphic Egg',
        Head = 'Optical Hat',
        Neck = 'Evasion Torque',
        Ear1 = 'Novia Earring',
        Ear2 = 'Brutal Earring',
        --Ear1 = 'Merman\'s Earring',
        --Ear1 = 'Wyvern Earring',
        Body = 'Scp. Harness +1',
        Hands = 'Rasetsu Tekko',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Scouter\'s Rope',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Rasetsu Sune-ate',
    },
    Recast = {
        Ammo = 'Tiphia Sting',
        Head = 'Panther Mask +1',
        Neck = 'Evasion Torque',
        Ear1 = 'Novia Earring',
        Ear2 = 'Loquac. Earring',       -- eris earring +1 > eris earring
        Body = 'Kirin\'s Osode',
        Hands = 'Mel. Gloves +1',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Shadow Ring',
        Waist = 'Black Belt',
        Back = 'Boxer\'s Mantle',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Fuma Sune-ate',
    },
    Jump = {
        Back = 'Wyvern Mantle',
    },
    Focus = {
        Head = 'Tpl. Crown +1',
    },
    Boost = {
        Hands = 'Temple Gloves',
    },
    Dodge = {
        Feet = 'Temple Gaiters',
    },
    Counterstance = {
        Feet = 'Melee Gaiters',
    },
    Chakra = {
        Ammo = 'Happy Egg',
        Head = 'Genbu\'s Kabuto',
        Neck = 'Fortitude Torque',
        Body = 'Temple Cyclas',
        Hands = 'Mel. Gloves +1',
        Back = 'Melee Cape',
        Waist = 'Warwolf Belt',
        Legs = 'Republic Subligar',
        Feet = 'Power Sandals',
    },
    ChiBlast = {
        --Main = 'Kirin\'s Pole',
        Head = 'Tpl. Crown +1',
        Neck = 'Faith Torque',
        Ear1 = 'Novia Earring',
        Ear2 = 'Ryakho\'s Earring',
        Body = 'Kirin\'s Osode',
        Hands = 'Devotee\'s Mitts',
        Ring1 = 'Aqua Ring',
        Ring2 = 'Aqua Ring',
        Back = 'Melee Cape',
        Waist = 'Twinthread Obi',
        Legs = 'Tpl. Hose +1',
        Feet = 'Suzaku\'s Sune-ate',
    },
    DayCombat = {
        Ear1 = 'Fenrir\'s Earring',
    },
    NightCombat = {
        Ear1 = 'Merman\'s Earring',
    },
};

local settings = {
    sushi = false,                  -- are you eating sushi+1?
    acc_cap = 362,                  -- accuracy requirement for target, set with /lac fwd cap x
    tp_minus_30 = tp_sets[369],     -- set for tp under Focus
    tp_base = tp_sets[369],         -- set for tp
    ws_minus_30 = ws_sets[363],     -- set for ws under Focus
    ws_base = ws_sets[363],         -- set for ws
    hf_minus_30 = hf_sets[363],     -- set for hf under Focus
    hf_base = hf_sets[363],         -- set for hf 
};


profile.Sets = sets;
profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = false;
    calculateSets();
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();

    if (player.Status == 'Engaged') then
        local needed_acc_offset = 0;

        if (gData.GetBuffCount("Focus") ~= 0) then
            needed_acc_offset = needed_acc_offset - 30;
        end

        if (gData.GetBuffCount("Hundred Fists") == 0) then
            gFunc.EquipSet(sets.TpBase);
            if (needed_acc_offset <= -30) then
                gFunc.EquipSet(settings.tp_minus_30);
            else 
                gFunc.EquipSet(settings.tp_base);
            end
        else
            gFunc.EquipSet(sets.HfBase);
            if (needed_acc_offset <= -30) then
                gFunc.EquipSet(settings.hf_minus_30);
            else 
                gFunc.EquipSet(settings.hf_base);
            end
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else
        gFunc.EquipSet(sets.Idle);
        --gFunc.EquipSet(sets.PDT);
    end
end

profile.HandleAbility = function()
    local ability = gData.GetAction();
    local environment = gData.GetEnvironment();

    if (ability.Name == 'Boost') then
        gFunc.EquipSet(sets.Boost);
    elseif (ability.Name == 'Dodge') then
        gFunc.EquipSet(sets.Dodge);
    elseif (ability.Name == 'Chakra') then
        gFunc.EquipSet(sets.Chakra);
    elseif (ability.Name == 'Focus') then
        gFunc.EquipSet(sets.Focus);
    elseif (ability.Name == 'Chi Blast') then
        gFunc.EquipSet(sets.ChiBlast);
    elseif (ability.Name == 'Counterstance') then
        gFunc.EquipSet(sets.Counterstance);
    elseif (ability.Name == 'Jump' or ability.Name == 'High Jump') then
        gFunc.EquipSet(sets.JumpBase);
        if (gData.GetBuffCount("Focus") ~= 0) then
            gFunc.EquipSet(settings.tp_minus_30);
        else
            gFunc.EquipSet(settings.tp_base);
        end
        if (environment.Time > 6.0 and environment.Time < 18.00) then
            gFunc.EquipSet(sets.DayCombat);
        else
            gFunc.EquipSet(sets.NightCombat);
        end
    end

end

profile.HandleItem = function()
    local item = gData.GetAction();
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Recast);
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Recast);
end

profile.HandlePreshot = function()
    gFunc.EquipSet(sets.Preshot);
end

profile.HandleMidshot = function()
    gFunc.EquipSet(sets.Ranged);
end

profile.HandleWeaponskill = function()
    if (canWS == false) then gFunc.CancelAction() return;
    end

    local action = gData.GetAction();
    local player = gData.GetPlayer();

    local needed_acc_offset = 0;

    if (gData.GetBuffCount("Focus") ~= 0) then
        needed_acc_offset = needed_acc_offset - 30;
    end

    gFunc.EquipSet(sets.WsBase);
    if (action.Name == 'Asuran Fists') then
        if (player.TP >= 2000 and player.TP < 3000) then
            needed_acc_offset = needed_acc_offset - 25;
        end if (player.TP == 2000) then
            needed_acc_offset = needed_acc_offset - 50;
        end
        --gFunc.EquipSet(sets.WsEarth);
    else
        gFunc.EquipSet(sets.WsThunder);
    end

    if (needed_acc_offset <= -30) then
        gFunc.EquipSet(settings.ws_minus_30);
    else 
        gFunc.EquipSet(settings.ws_base);
    end
end

profile.HandleCommand = function(args)
    if (args[1] == 'sushi') then
        if (settings.sushi == true) then
            settings.sushi = false;
            gFunc.Echo(255, "Sushi disabled.");
        else
            settings.sushi = true;
            gFunc.Echo(255, "Sushi enabled.");
        end

        calculateSets();
    end

    if (args[1] == 'food') then
        settings.food_bonus = args[2];
        gFunc.Echo(255, string.format("Set food bonus mutiplier to: %f", settings.food_bonus));

        calculateSets();
    end

    if (args[1] == 'cap') then
        settings.acc_cap = args[2];
        gFunc.Echo(255, string.format("Set accuracy cap to: %d", settings.acc_cap));

        calculateSets();
    end
end

function calculateSets()
    gFunc.Echo(2, "Selecting gear sets for each accuracy step...");

    local needed_acc = tonumber(settings.acc_cap);

    if (settings.sushi == true) then
        needed_acc = needed_acc - math.floor(math.min(needed_acc - needed_acc / 1.16, 76));
    end

    gFunc.Echo(7, "TP - 30...");
    settings.tp_minus_30 = select_set(tp_sets, needed_acc - 30);

    gFunc.Echo(7, "TP...");
    settings.tp_base = select_set(tp_sets, needed_acc);

    gFunc.Echo(7, "WS - 30...");
    settings.ws_minus_30 = select_set(ws_sets, needed_acc - 30);

    gFunc.Echo(7, "WS...");
    settings.ws_base = select_set(ws_sets, needed_acc);

    gFunc.Echo(7, "HF - 30...");
    settings.hf_minus_30 = select_set(hf_sets, needed_acc - 30);

    gFunc.Echo(7, "HF...");
    settings.hf_base = select_set(hf_sets, needed_acc);

end

function select_set(sets, needed_accuracy)
    local set = nil;
    local set_key = 9999;
    local highest_set = 0;

    for k, v in pairs(sets) do
        highest_set = math.max(highest_set, k);

        if (k >= needed_accuracy and k <= set_key) then
            set = v;
            set_key = k;
        end
    end

    if (set ~= nil) then
        gFunc.Echo(1, string.format("- Using set: %d", set_key));
    else
        local expected_hitrate = math.min(math.max((190 - (needed_accuracy - highest_set)) / 2.0, 20.0), 95.0);
        gFunc.Echo(8, string.format("- Cap missed by: %d, expected hit rate %.1f%%", needed_accuracy - highest_set, expected_hitrate));

        set = sets[highest_set];
    end

    return set;
end

return profile;