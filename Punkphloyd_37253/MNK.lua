-- Test branch for advanced accuracy treatment in MNK.lua
--
local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');


-- /checkparam <me> acc minus acc from main, sub, range, ammo, and food when using base sets
-- base sets should be geared for minimum accuracy and maximum damage
local tp_base_accuracy = 394;           -- ranged attack base (sets.TPBase)
local ws_base_accuracy = 407;           -- weapon skill base (sets.WsBase), +10 if using sea gorget

local settings = {

	
	CurrentLevel = 0
	
    -- /lac fwd sushi
    using_sushi = false,                -- whether using sole sushi +1 or not
    -- /lac fwd weap 20
    weapon_accuracy = 20,               -- acc from main, sub, ranged, and ammo slots
    -- /lac fwd cap 400
    accuracy_cap = 400,                 -- total accuracy requirement for target
    -- /lac fwd conq
    in_nation_controlled_area = false,  -- whether in a conquest controlled area or not
    -- /lac fwd enm
    prefer_enmity_down = false,         -- whether to prefer -enm over str/att when acc is not needed
	-- /lac fwd tank
	tanking = false						-- whether to equip tanking gear whilst engaged (Counter/PDT/Guard)
	
};

local tp_sets = {
	
	[0] = {},							-- TP set
	[-25] = {},							-- TP set under Blade Madrigal
	[-30] = {},							-- TP set under focus
	[-55] = {}							-- TP set under focus and Blade Madrigal

};

local ws_sets = {
	
	[0] = {},							-- WS set
	[-25] = {},							-- WS set under Blade Madrigal
	[-30] = {},							-- WS set under focus
	[-55] = {}							-- WS set under focus and Blade Madrigal

};


-- accuracy subsets for TP
-- key is the total accuracy gained over sets.TPBase
local tp_set_options = {
    [46] = {                            -- upgrades??
	  
    },
    [20] = {
	
    },
    [10] = {
        Neck = 'Peacock Amulet',
    },
    [5] = {
	
    },
    [0] = {}
};


-- accuracy subsets for WS
-- key is the total accuracy gained over sets.WSBase
local ws_set_options = {
    [46] = {                            -- upgrades??
	  
    },
    [20] = {
	
    },
    [10] = {
        Neck = 'Peacock Amulet',
    },
    [5] = {
	
    },
    [0] = {}
};

local Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau',
				'Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille',
				'Bastok Mines','Bastok Markets','Port Bastok','Metalworks',
				'Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower',
				'Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno',
				'Rabao','Selbina','Mhaura','Kazham','Norg'};
				
local sets = {
	Empty = {
		Main = '',
		Sub = '',
		Range = '',
		Ammo = '',
		Head = '',
		Neck = '',
		Ear1 = '',
		Ear2 = '',
		Body = '',
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	},
	
	Crafting = {
		Head = 'Shaded Specs.',
		Body = 'Blacksmith\'s Apn.',
		Hands = 'Smithy\'s Mitts'
	},
	
	TP_Priority = {
		Head = {'Temple Crown', 'Emperor Hairpin'},
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = {'Spike Earring', 'Tor. Earring +1', 'Beetle Earring +1'},
		Ear2 = {'Spike Earring', 'Tor. Earring +1', 'Beetle Earring +1'},
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = {'Amemet Mantle +1', 'Jaguar Mantle', 'Nomad\'s Mantle'},
		Waist = {'Brown Belt', 'Purple Belt'},
		Legs = 'Republic Subligar',
		Feet = {'Fuma Kyahan', 'Fed. Kyahan'}
	},
	
	TPBase_Priority = {
		
	
	},
	
	WSBase_Priority = {
		
	
	},
	
	TPEnmityDown_Priority = { 
	
	},
	
	WSEnmityDown_Priority = {
	
	
	},
	
	Town_Priority = {
	
		Head = 'Emperor Hairpin',
		Neck = 'Peacock Amulet',
		Ear1 = 'Wyvern Earring',
		Ear2 = {'Spike Earring', 'Tor. Earring +1', 'Beetle Earring +1'},
		Body = 'Scp. Harness +1',
		Hands = 'Ochiudo\'s Kote',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Sniper\'s Ring +1',
		Back = 'Nomad\'s Mantle',
		Waist = 'Brown Belt',
		Legs = 'Republic Subligar',
		Feet = 'Fuma Kyahan'
	
	},
	
	Idle_Priority = {
		Head = 'Emperor Hairpin',
		Neck = 'Peacock Amulet',
		Ear1 = 'Dodge Earring',
		Ear2 = 'Dodge Earring',
		Body = 'Scp. Harness +1',
		Hands = 'Custom M Gloves',
		Ring1 = 'Vigor Ring',
		Ring2 = 'Vigor Ring',
		Back = 'Nomad\'s Mantle',
		Waist = 'Warrior\'s Belt +1',
		Legs = 'Crow Hose',
		Feet = 'Air Solea'
	},
	
	Resting_Priority = {
		Head = '',
		Neck = '',
		Ear1 = '',
		Ear2 = '',
		Body = '',
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	},
	
	Combo_Priority = {
		Head = {'Temple Crown', 'Emperor Hairpin'},
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = {'Spike Earring', 'Tor. Earring +1', 'Beetle Earring +1'},
		Ear2 = {'Spike Earring', 'Tor. Earring +1', 'Beetle Earring +1'},
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = {'Amemet Mantle +1', 'Jaguar Mantle', 'Nomad\'s Mantle'},
		Waist = {'Brown Belt', 'Purple Belt'},
		Legs = 'Republic Subligar',
		Feet = {'Fed. Kyahan'}
	
	},
	
	Raging_Priority = {
		Head = {'Temple Crown', 'Emperor Hairpin'},
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = {'Spike Earring', 'Tor. Earring +1', 'Beetle Earring +1'},
		Ear2 = {'Spike Earring', 'Tor. Earring +1', 'Beetle Earring +1'},
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = {'Amemet Mantle +1', 'Jaguar Mantle', 'Nomad\'s Mantle'},
		Waist = {'Life Belt', 'Brown Belt', 'Purple Belt'},
		Legs = 'Republic Subligar',
		Feet = {'Fed. Kyahan'}
	
	},
	
	Howling_Priority = {
		Head = {'Temple Crown', 'Emperor Hairpin'},
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = {'Spike Earring', 'Tor. Earring +1'},
		Ear2 = {'Spike Earring', 'Tor. Earring +1'},
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Pallas\'s Bracelets','Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = {'Amemet Mantle +1', 'Jaguar Mantle', 'Nomad\'s Mantle'},
		Waist = {'Life Belt', 'Brown Belt', 'Purple Belt'},
		Legs = 'Republic Subligar',
		Feet = {'Fed. Kyahan'}
	
	},
	
	DragonKick_Priority = {
		Head = {'Temple Crown', 'Emperor Hairpin'},
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = {'Spike Earring', 'Tor. Earring +1'},
		Ear2 = {'Spike Earring', 'Tor. Earring +1'},
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Pallas\'s Bracelets','Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = {'Amemet Mantle +1', 'Jaguar Mantle', 'Nomad\'s Mantle'},
		Waist = {'Life Belt', 'Brown Belt', 'Purple Belt'},
		Legs = 'Republic Subligar',
		Feet = {'Fed. Kyahan'}
	
	},
	
	Asuran_Priority = {
		Head = {'Temple Crown', 'Emperor Hairpin'},
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = {'Spike Earring', 'Tor. Earring +1'},
		Ear2 = {'Spike Earring', 'Tor. Earring +1'},
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Pallas\'s Bracelets','Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = {'Amemet Mantle +1', 'Jaguar Mantle', 'Nomad\'s Mantle'},
		Waist = {'Life Belt', 'Brown Belt', 'Purple Belt'},
		Legs = 'Republic Subligar',
		Feet = {'Fed. Kyahan'}
	
	},
	
	Chakra_Priority = {
		Body = {'Temple Cyclas', 'Custom Tunic'},
		Ring1 = 'Vigor Ring',
		Ring2 = 'Vigor Ring',
		Waist = 'Warrior\'s Belt +1',
		Legs = 'Republic Subligar',
	},
	
	ChiBlast = {
		Head = 'Temple Crown',
		Neck = 'Justice Badge',
		Hands = 'Devotee\'s Mitts',
		Ring1 = 'Kshama Ring No.9',
		Legs = 'Custom Slacks'
	},
	
	Tanking_Priority = {
	
		Head = {''},
		Neck = {'Peacock Amulet'},
		Ear1 = {''},
		Ear2 = {''},
		Body = {''},
		Hands = {''},
		Ring1 = {''},
		Ring2 = {''},
		Back = {''},
		Waist = {''},
		Legs = {'Temple Hose'},
		Feet = {''}
	},
	
	PDT_Priority = {
	
		Head = {''},
		Neck = {'Peacock Amulet'},
		Ear1 = {''},
		Ear2 = {''},
		Body = {''},
		Hands = {''},
		Ring1 = {''},
		Ring2 = {''},
		Back = {''},
		Waist = {''},
		Legs = {'Temple Hose'},
		Feet = {''}
	},
	
	MDT_Priority = {
	
		Head = {''},
		Neck = {'Peacock Amulet'},
		Ear1 = {''},
		Ear2 = {''},
		Body = {''},
		Hands = {''},
		Ring1 = {''},
		Ring2 = {''},
		Back = {''},
		Waist = {''},
		Legs = {'Temple Hose'},
		Feet = {''}
	},
	
	Haste_Priority = {
	
		Head = {''},
		Neck = {'Peacock Amulet'},
		Ear1 = {''},
		Ear2 = {''},
		Body = {''},
		Hands = {''},
		Ring1 = {''},
		Ring2 = {''},
		Back = {''},
		Waist = {''},
		Legs = {'Temple Hose'},
		Feet = {''}
	}
	
};


profile.Sets = sets;

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	CalculateSets();
	
	varhelper.Initialize();
	
	varhelper.CreateToggle('CraftingMode',false);
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /mnk /lac fwd');
	
	AshitaCore:GetChatManager():QueueCommand(1, '/macro book 27');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
	AshitaCore:GetChatManager():QueueCommand(1, "/lockstyleset 5");
end


profile.OnUnload = function()

	varhelper.Destroy();
end

profile.HandleCommand = function(args)
    if args[1] == 'sushi' then
        if settings.using_sushi then
            settings.using_sushi = false;
            gFunc.Echo(3, "Using sole sushi +1 disabled.");
        else
            settings.using_sushi = true;
            gFunc.Echo(3, "Using sole sushi +1 enabled.");
        end

        CalculateSets();
    end

    if args[1] == 'weap' then
        settings.weapon_accuracy = tonumber(args[2]);
        gFunc.Echo(3, string.format("Set weapon/ranged slot accuracy to: %d", settings.weapon_accuracy));

        CalculateSets();
    end

    if args[1] == 'cap' then
        settings.accuracy_cap = tonumber(args[2]);
        gFunc.Echo(3, string.format("Set accuracy cap to: %d", settings.accuracy_cap));

        CalculateSets();
    end

    if args[1] == 'conq' then
        if settings.in_nation_controlled_area then
            settings.in_nation_controlled_area = false;
            gFunc.Echo(3, "Use nation-controlled area gear disabled.");
        else
            settings.in_nation_controlled_area = true;
            gFunc.Echo(3, "Use nation-controlled area gear enabled.");
        end
    end

    if args[1] == 'enm' then
        if settings.prefer_enmity_down then
            settings.prefer_enmity_down = false;
            gFunc.Echo(3, "Prioritizing damage over -enmity at low accuracy.");
        else
            settings.prefer_enmity_down = true;
            gFunc.Echo(3, "Prioritizing -enmity over damage at low accuracy.");
        end
    end
	
	if args[1] == 'tank' then
		if settings.tanking then
			settings.tanking = false;
            gFunc.Echo(3, "Tanking set to false");
		else
			settings.tanking = true;
            gFunc.Echo(3, "Tanking set to true");
		end
	end
end

profile.HandleDefault = function()
	local player = gData.GetPlayer();
	local zone = gData.GetEnvironment();
	local cstance = gData.GetBuffCount('Counterstance');
	local mylevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (mylevel ~= settings.CurrentLevel) then
		gFunc.EvaluateLevels(profile.Sets, mylevel);
		settings.CurrentLevel = mylevel;
	end
	
	local accuracy_offset = 0;
	if gData.GetBuffCount("Focus") ~= 0 then
		accuracy_offset = accuracy_offset - 30;
	end
	
	if gData.GetBuffCount("Madrigal") ~= 0 then
		accuracy_offset = accuracy_offset - 25;
	end
	
	if (zone.Area ~= nil and Towns:contains(zone.Area)) then
		gFunc.EquipSet(sets.Town)
		return
	end
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.TPBase);
		if settings.prefer_enmity_down then
			gFunc.EquipSet(sets.TPEnmityDown);
		end
		gFunc.EquipSet(tp_sets[accuracy_offset]);
		
		if (player.SubJob == 'DRG') then
			gFunc.Equip('Ear1', 'Wyvern Earring');
		end
		if settings.tanking then
			gFunc.EquipSet(sets.Tanking);
		end 
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	else
		gFunc.EquipSet(sets.Idle);
	end
	
end

profile.HandlePrecast = function()
    gFunc.EquipSet(sets.Recast);
end

profile.HandleMidcast = function()
    gFunc.EquipSet(sets.Recast);
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	
	
	if action.Name == 'Chakra' then
		gFunc.EquipSet(sets.Chakra);
	elseif action.Name == 'Chi Blast' then
		gFunc.EquipSet(sets.ChiBlast);
	elseif action.Name == 'Dodge' then
		gFunc.Equip('Feet','Temple Gaiters');
	elseif action.Name == 'Focus' then
		gFunc.Equip('Head','Temple Crown');
	elseif action.Name == 'Boost' then
		gFunc.Equip('Hands','Temple Gloves');
	end

end

profile.HandleWeaponskill = function()
	local action = gData.GetAction();
	
	local accuracy_offset = 0;
	if gData.GetBuffCount("Focus") ~= 0 then
		accuracy_offset = accuracy_offset - 30;
	end
	
	if gData.GetBuffCount("Madrigal") ~= 0 then
		accuracy_offset = accuracy_offset - 25;
	end
	
	gFunc.EquipSet(sets.WSBase);
	gFunc.Echo(3,'Weaponskill function entered');
	if action.Name == 'Combo' then
		gFunc.EquipSet(sets.Combo);
	elseif action.Name == 'Raging Fists' then
		gFunc.Echo(3,'Raging Fists condition entered');
		gFunc.EquipSet(sets.Raging);
	elseif action.Name == 'Howling Fist' then
		gFunc.Echo(3,'Howling Fist condition entered');
		gFunc.EquipSet(sets.Howling);
	end
	gFunc.EquipSets(ws_sets[accuracy_offset]);
end

function CalculateSets()
    gFunc.Echo(2, "Selecting gear sets for each accuracy step...");

    gFunc.Echo(7, "TP under focus and madrigal...");
    ra_sets[-55] = SelectSet(ra_set_options, ra_base_accuracy, settings.accuracy_cap - 55);

    gFunc.Echo(7, "TP under focus...");
    ra_sets[-30] = SelectSet(ra_set_options, ra_base_accuracy, settings.accuracy_cap - 30);

    gFunc.Echo(7, "TP under focus...");
    ra_sets[-25] = SelectSet(ra_set_options, ra_base_accuracy, settings.accuracy_cap - 25);
	
    gFunc.Echo(7, "TPing...");
    ra_sets[0] = SelectSet(ra_set_options, ra_base_accuracy, settings.accuracy_cap);

    gFunc.Echo(7, "WS under focus and madrigal...");
    ws_sets[-55] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap - 55);

    gFunc.Echo(7, "WS under focus...");
    ws_sets[-30] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap - 30);

    gFunc.Echo(7, "WS under focus...");
    ws_sets[-25] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap - 25);
	
    gFunc.Echo(7, "WSing...");
    ws_sets[0] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap);

end

function SelectSet(set_options, base_accuracy, needed_accuracy)
    local set = nil;
    local set_key = 9999;
    local highest_set = 0;
    local highest_accuracy = 0;

    for k, v in pairs(set_options) do
        local total_accuracy = k + base_accuracy + settings.weapon_accuracy;
        if settings.using_sushi then
            total_accuracy = total_accuracy + math.floor(math.min(total_accuracy * 0.16, 76));
        end

        highest_accuracy = math.max(highest_accuracy, total_accuracy);
        highest_set = math.max(highest_set, k);

        if total_accuracy >= needed_accuracy and k <= set_key then
            set = v;
            set_key = k;
        end
    end

    if set ~= nil then
        if set_key == 0 then
            gFunc.Echo(1, "...Using base set.");
        else
            gFunc.Echo(1, string.format("...Using set: +%d", set_key));
        end
    else
        local missing_accuracy = needed_accuracy - highest_accuracy;
        local expected_hitrate = math.min(math.max(95.0 - missing_accuracy / 2.0, 20.0), 95.0);
        gFunc.Echo(8, string.format("...%d under cap, %.1f%% hitrate. Using set: +%d", missing_accuracy, expected_hitrate, highest_set));

        set = set_options[highest_set];
    end

    return set;
end



return profile;
