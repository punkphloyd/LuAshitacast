local profile = {};


local varhelper = gFunc.LoadFile('common/varhelper.lua');
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');
local accuracies = gFunc.LoadFile('data/acc_reqs.dat');

-- /checkparam <me> ranged accuracy minus r.acc from main, sub, range, ammo, and food when using base sets
-- base sets should be geared for minimum accuracy and maximum damage
local ra_base_accuracy = 395;           -- ranged attack base (sets.RangedBase)
local ba_base_accuracy = 387;           -- barrage base (sets.BarrageBase)
local ws_base_accuracy = 401;           -- weapon skill base (sets.WsBase), +10 if using sea gorget 


local settings = {

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
	
	CurrentLevel = 0,	
	
};

local ra_sets = {
    [0] = {},                           -- ranged attack
	[-35] = {},							-- ranged attack, with prelude
    [-50] = {},                         -- ranged attack under sharpshot
    [-85] = {},                         -- ranged attack under sharpshot and prelude
};

local ws_sets  = {
    [50] = {},                          -- 1000 tp slug
    [25] = {},                          -- 2000 tp slug
    [15] = {},                          -- 1000 tp slug under prelude
    [0] = {},                           -- 3000 tp slug, coronach, 1000 tp slug under sharpshot
    [-10] = {},                          -- 2000 tp slug under prelude
    [-25] = {},                         -- 2000 tp slug under sharpshot
    [-35] = {},                           -- 3000 tp slug, coronach, 1000 tp slug under sharpshot + prelude
    [-50] = {},                         -- 3000 tp slug and coronach under sharpshot, 
    [-60] = {},                         -- 2000 tp slug under sharpshot and prelude
    [-85] = {},                         -- 3000 tp slug and coronach under sharpshot, 
};

local ba_sets  = {
    [0] = {},                           -- barrage
    [-35] = {},                           -- barrage under prelude
    [-50] = {},                         -- barrage under sharpshot
    [-85] = {},                         -- barrage under sharpshot and prelude
};

-- accuracy subsets for ranged attacks
-- key is the total accuracy gained over sets.RangedBase
local ra_set_options = {
    [57] = {                            -- upgrades??
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
		Body = 'Htr. Jerkin +1',
        Hands = 'Seiryu\'s Kote',
        Ring1 = 'Behemoth Ring',       	-- bellona's ring
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
	},
	[46] = {                            -- upgrades??
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Hands = 'Seiryu\'s Kote',
		Body = 'Htr. Jerkin +1',
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [38] = {
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Hands = 'Seiryu\'s Kote',
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [32] = {
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [22] = {
        Neck = 'Peacock Amulet',
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [18] = {
        Neck = 'Faith Torque',    		-- faith torque
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [12] = {
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [10] = {
        Neck = 'Peacock Amulet',
    },
    [6] = {
        Neck = 'Faith Torque',    -- faith torque
    },
    [0] = {}
};

-- accuracy subsets for barrage
-- key is the total accuracy gained over sets.BarrageBase
local ba_set_options = {
    [51] = {
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
		Body = 'Htr. Jerkin +1',
        Ring1 = 'Behemoth Ring',       	-- bellona's ring
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [43] = {
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Ring1 = 'Behemoth Ring',       	-- bellona's ring
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [32] = {
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
	},
    [22] = {
        Neck = 'Peacock Amulet',
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [18] = {
        Neck = 'Faith Torque',    		-- faith torque
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
	},
    [12] = {
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
    },
    [10] = {
        Neck = 'Peacock Amulet',
    },
    [6] = {
        Neck = 'Faith Torque',    -- faith torque
    },
    [0] = {}
};

-- accuracy subsets for weapon skills
-- key is the total accuracy gained over sets.WsBase
local ws_set_options = {
    [44] = {
        Head = 'Optical Hat',
        Ring1 = 'Behemoth Ring',       	-- bellona's ring
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
		Legs = 'Dusk Trousers +1',
    },
    [33] = {
        Head = 'Optical Hat',
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
		Legs = 'Dusk Trousers +1',
    },
    [23] = {
        Ring2 = 'Behemoth Ring +1',     -- bellona's ring
		Legs = 'Dusk Trousers +1',
    },
    [11] = {
		Legs = 'Dusk Trousers +1',
    },
    [0] = {}
};


local sets = {
    Ammo = {
        
        Ammo = 'Silver Bullet'
    },
	
	UnlimitedShot = {
		Ammo = 'Carapace Bullet'
	},
	
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
	
	Digging = {
		Body = 'Choc. Jack Coat',
		Hands = 'Chocobo Gloves',
		Legs = 'Chocobo Hose',
		Feet = 'Chocobo Boots'
	},
	
	Crafting = {
		Head = 'Shaded Specs.',
		Body = 'Blacksmith\'s Apn.',
		Hands = 'Smithy\'s Mitts'
	},
	
	HELM = {
		Body = 'Field Tunica',
		Hands = 'Field Gloves',
		Legs = 'Field Hose',
		Feet = 'Field Boots',
	},
	
	
	Idle_Priority = {
	
		Head = 'Optical Hat',
		Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
		Body = 'Kirin\'s Osode', 
		Hands = 'Blood Fng. Gnt.',
		Waist = 'Scout\'s Belt',
        Ring1 = 'Merman\'s Ring',       -- defending ring > minerva's ring
        Ring2 = 'Merman\'s Ring',       -- shadow ring
		Back = 'Amemet Mantle +1',
		Legs = 'Crimson Cuisses',
		Feet = 'Sct. Socks +1'
	},
	
	MDT = {
	
		Head = 'Optical Hat',
		Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
		Body = 'Kirin\'s Osode', 
		Hands = 'Blood Fng. Gnt.',
		Waist = 'Scout\'s Belt',
        Ring1 = 'Merman\'s Ring',       -- defending ring > minerva's ring
        Ring2 = 'Merman\'s Ring',       -- shadow ring
		Back = 'Amemet Mantle +1',
		Legs = 'Byakko\'s Haidate',
		Feet = 'Sct. Socks +1'
	},
	
	PDT = {
	
		Head = 'Optical Hat',
		Neck = 'Jeweled Collar',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
		Body = 'Kirin\'s Osode', 
		Hands = 'Blood Fng. Gnt.',
		Waist = 'Scout\'s Belt',
        Ring1 = 'Merman\'s Ring',       -- defending ring > minerva's ring
        Ring2 = 'Merman\'s Ring',       -- shadow ring
		Back = 'Amemet Mantle +1',
		Legs = 'Byakko\'s Haidate',
		Feet = 'Sct. Socks +1'
	},
	
	Melee_Priority = {
	
		Head = 'Optical Hat',
		Neck = 'Ranger\'s Necklace',
		Ear1 = 'Triumph Earring',
		Ear2 = 'Triumph Earring',
		Body = {'Kirin\'s Osode', 'Shikaree Aketon', 'Irn.Msk. Gambison'},
		Hands = {'Seiryu\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = 'Flame Ring',
		Back = 'Amemet Mantle +1',
		Legs = 'Dusk Trousers +1',
		Feet = 'Sct. Socks +1'
	},
	
	Recast_Priority = {
		
		Waist = 'Swift Belt',
		Legs = 'Byakko\'s Haidate'
	
	},
	
	Resting_Priority = {
	
	},
	
	Preshot_Priority = {
	
		Head = 'Hunter\'s Beret',
		Body = 'Scout\'s Jerkin'
	
	},
	
	RangedBase_Priority = {
	
		Head = 'Wyvern Helm',
		Neck = 'Justice Torque',
		Ear1 = 'Brutal Earring',
		Ear2 = 'Triumph Earring',
		Body = 'Kirin\'s Osode', 
		Hands = 'Blood Fng. Gnt.',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Flame Ring',
		Back = 'Amemet Mantle +1',
		Waist = 'Scout\'s Belt',
		Legs = 'Dusk Trousers +1',
		Feet = 'Sct. Socks +1'
	
	},
	
    RangedEnmityDown = {
        Head = 'Scout\'s Beret',
        Ear1 = 'Novia Earring',
    },
	
	BarrageBase = {
	
		Head = 'Wyvern Helm',
		Neck = 'Justice Torque',
		Ear1 = 'Brutal Earring',
		Ear2 = 'Triumph Earring',
        Body = 'Kirin\'s Osode',
		Hands = 'Htr. Bracers +1',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Flame Ring',
		Back = 'Amemet Mantle +1',
        Waist = 'Scout\'s Belt',
		Legs = 'Dusk Trousers +1',
		Feet = 'Sct. Socks +1'
	
	}, 
	
	WSBase = {
	
		Head = 'Wyvern Helm',
		Neck = 'Breeze Gorget',
		Ear1 = 'Brutal Earring',
		Ear2 = 'Triumph Earring',
		Body = 'Kirin\'s Osode',
        Hands = 'Seiryu\'s Kote',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Flame Ring',
		Back = 'Amemet Mantle +1',
		Waist = 'Scout\'s Belt',
		Legs = 'Byakko\'s Haidate',
		Feet = 'Sct. Socks +1'
	},
	
	
    WSEnmityDown = {
        Head = 'Scout\'s Beret',
        Ear1 = 'Novia Earring',
    },
	
	
	EagleEyeShot = {
	
		Head = 'Wyvern Helm',
		Neck = 'Justice Torque',
		Ear1 = 'Triumph Earring',
		Ear2 = 'Triumph Earring',
		Body = 'Kirin\'s Osode',
		Hands = 'Blood Fng. Gnt.',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Flame Ring',
		Back = 'Amemet Mantle +1',
		Legs = 'Dusk Trousers +1',
		Feet = 'Sct. Socks +1'
	},
	
	
	
	EnmityDown_Priority = {
	
	}
	};


profile.Sets = sets;




profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	
-- Aliases
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /rng /lac fwd');
	
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /henm /rng HENM');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /dyna /rng Dynamis');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /gods /rng Gods');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /pdt /rng PDT');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /mdt /rng MDT');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /def /rng Default');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /craft /rng Crafting');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /digging /rng Digging');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /helm /rng HELM');
	
	
	
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 5');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
	
	AshitaCore:GetChatManager():QueueCommand(1, "/lockstyleset 20");

	
	
	varhelper.Initialize();
	
	varhelper.CreateCycle('Idle', {
		[1] = 'Default', 
		[2] = 'MDT', 
		[3] = 'PDT',
		[4] = 'Digging', 
		[5] = 'Crafting', 
		[6] = 'HELM'
	});
	
	
    CalculateSets();
end

profile.OnUnload = function()

	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /rng');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /henm');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /dyna');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /gods');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /pdt');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /mdt');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /def');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /craft');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /digging');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /helm');
	
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F9');
	
	varhelper.Destroy();

end

profile.HandleCommand = function(args)
	--if not bstTables.AliasList:contains(args[1]) then return end
	
	local player = gData.GetPlayer();
	local world = gData.GetEnvironment()
    local target = gData.GetTarget()
	local toggle = nil;
	local status = nil;

	
	
	-- Update sets based on using sushi or not
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
	
	-- Update sets based on required accuracy to cap on target
	if args[1] == 'cap' then
        settings.accuracy_cap = tonumber(args[2]);
        gFunc.Echo(3, string.format("Set accuracy cap to: %d", settings.accuracy_cap));

        CalculateSets();
    end
	
	if args[1] == 'weap' then
        settings.weapon_accuracy = tonumber(args[2]);
        gFunc.Echo(3, string.format("Set weapon/ranged slot accuracy to: %d", settings.weapon_accuracy));

        CalculateSets();
    end
	
	-- update whether enmity down preferred 
	if args[1] == 'enm' then
        if settings.prefer_enmity_down then
            settings.prefer_enmity_down = false;
            gFunc.Echo(3, "Prioritizing damage over -enmity at low accuracy.");
        else
            settings.prefer_enmity_down = true;
            gFunc.Echo(3, "Prioritizing -enmity over damage at low accuracy.");
        end
    end
	
	
	
	if(args[1] == 'Digging') then
		varhelper.SetCycle('Idle', 4);
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 18');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		
	elseif(args[1] == 'Crafting') then
		varhelper.SetCycle('Idle', 5);
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		
	elseif(args[1] == 'HELM') then
		varhelper.SetCycle('Idle', 6);
		
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 19');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		
	elseif(args[1] == 'MDT') then
		varhelper.SetCycle('Idle', 2);
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		
	elseif(args[1] == 'PDT') then
		varhelper.SetCycle('Idle', 3);
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		
	elseif(args[1] == 'Default') then
		varhelper.SetCycle('Idle', 1);
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
	
	end
	
	if(args[1] == 'HENM') then
		
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 40');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		
	elseif(args[1] == 'Dynamis') then
		
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 39');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
			
	elseif(args[1] == 'Gods') then
		
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 38');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
	end
	
end

profile.HandleDefault = function()

	
	local mylevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (mylevel ~= settings.CurrentLevel) then
		gFunc.EvaluateLevels(profile.Sets, mylevel);
		settings.CurrentLevel = mylevel;
	end
	local player = gData.GetPlayer();
	
	
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet('Melee')
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
		
	else
		if(varhelper.GetCycle('Idle') == 'Digging') then
			gFunc.EquipSet(sets.Digging);

		elseif(varhelper.GetCycle('Idle') == 'Crafting') then
			gFunc.EquipSet(sets.Crafting);

		elseif(varhelper.GetCycle('Idle') == 'HELM') then
			gFunc.EquipSet(sets.HELM);

		elseif(varhelper.GetCycle('Idle') == 'MDT') then
			gFunc.EquipSet(sets.MDT);
		else	
			gFunc.EquipSet(sets.Idle);
		end
	end
	
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	
	if action.Name == 'Scavenge' then
		gFunc.Equip('Feet','Hunter\'s Socks')
	elseif action.Name == 'Shadowbind' then
		gFunc.Equip('Hands','Htr. Bracers +1')
	elseif action.Name == 'Sharpshot' then
		gFunc.Equip('Legs','Hunter\'s Braccae')
	elseif action.Name == 'Camouflage' then
		gFunc.Equip('Body','Hunter\'s Jerkin')
	elseif action.Name == 'Eagle Eye Shot' then
		gFunc.EquipSet(sets.EES)

	end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Recast);
end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Recast);

	
end

profile.HandlePreshot = function()
	local gear = gData.GetEquipment();	
	if (gear.Ammo.Name == 'Carapace Bullet') then
	  gEquip.UnequipSlot(4)
	end
    gFunc.EquipSet(sets.Preshot);
    gFunc.SetMidDelay(1.0);
    if gData.GetBuffCount("Velocity Shot") == 0 then
        gFunc.Error("-!- USE VELOCITY SHOT -!-");
    end
	
	if gData.GetPlayer().SubJob == "SAM" and gData.GetBuffCount("Hasso") == 0 then
        gFunc.Error("-!- USE HASSO -!-");
    end
end

profile.HandleMidshot = function()
	
	gFunc.EquipSet(sets.Ammo);

    local accuracy_offset = 0;
    if gData.GetBuffCount("Sharpshot") ~= 0 then
        accuracy_offset = accuracy_offset - 50;
    end

    if gData.GetBuffCount("Barrage") == 0 then
        gFunc.EquipSet(sets.RangedBase);
		if gData.GetPlayer().SubJob == "NIN" then
			gFunc.Equip('Ear1', 'Triumph Earring');
		end
        if settings.prefer_enmity_down then
            gFunc.EquipSet(sets.RangedEnmityDown);
        end
        gFunc.EquipSet(ra_sets[accuracy_offset]);
		if settings.prefer_enmity_down then
			gFunc.Equip('Legs', 'Scout\'s Braccae');
		end
    else
        gFunc.EquipSet(sets.BarrageBase);
		if gData.GetPlayer().SubJob == "NIN" then
			gFunc.Equip('Ear1', 'Triumph Earring');
		end
        if settings.prefer_enmity_down then
            gFunc.EquipSet(sets.RangedEnmityDown);
        end
        gFunc.EquipSet(ba_sets[accuracy_offset]);
		if settings.prefer_enmity_down then
			gFunc.Equip('Legs', 'Scout\'s Braccae');
		end
    end

    local environment = gData.GetEnvironment();
    if environment.Time >= 6.0 and environment.Time < 18.00 then
		gFunc.Equip('Ear2', 'Triumph Earring');
	else
		gFunc.Equip('Ear2', 'Fenrir\'s Earring');
   
    end
	
end

profile.HandleWeaponskill = function()
	
    gFunc.EquipSet(sets.Ammo);

    local accuracy_offset = 0;

    if gData.GetBuffCount("Sharpshot") ~= 0 then
        accuracy_offset = accuracy_offset - 50;
    end
	
	if gData.GetBuffCount("Prelude") ~= 0 then
        accuracy_offset = accuracy_offset - 35;
    end

    local action = gData.GetAction();
    if action.Name == 'Slug Shot' or action.Name == 'Sidewinder' then
        local player = gData.GetPlayer();
        if player.TP < 3000 then
            accuracy_offset = accuracy_offset + 25;
            if player.TP < 2000 then
                accuracy_offset = accuracy_offset + 25;
            end
        end
    end

    gFunc.EquipSet(sets.WSBase);
	if action.Name == 'Coronach' then
		gFunc.Equip('Feet', 'Htr. Socks +1');
	end
	if gData.GetPlayer().SubJob == "NIN" or gData.GetPlayer().SubJob == "WAR" then
		gFunc.Equip('Ear1', 'Triumph Earring');
	end
    if settings.prefer_enmity_down then
        gFunc.EquipSet(sets.WsEnmityDown);
    end
    if gData.GetBuffCount("Unlimited Shot") ~= 0 then
        gFunc.EquipSet(sets.UnlimitedShot);
    end
    gFunc.EquipSet(ws_sets[accuracy_offset]);
	
    if settings.prefer_enmity_down then
        gFunc.Equip('Legs', 'Scout\'s Braccae');
    end

    local environment = gData.GetEnvironment();
    if environment.Time >= 6.0 and environment.Time < 18.00 then
		gFunc.Equip('Ear2', 'Triumph Earring');
	else
		gFunc.Equip('Ear2', 'Fenrir\'s Earring');
   
    end
end



function splitString(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)

    for match in string.gmatch(str, pattern) do
        table.insert(result, match)
    end

    return result
end

function CalculateSets()
    gFunc.Echo(2, "Selecting gear sets for each accuracy step...");
	
	gFunc.Echo(7, "Ranged Attack under Sharpshot and Prelude...");
    ra_sets[-85] = SelectSet(ra_set_options, ra_base_accuracy, settings.accuracy_cap - 85);

    gFunc.Echo(7, "Ranged Attack under Sharpshot...");
    ra_sets[-50] = SelectSet(ra_set_options, ra_base_accuracy, settings.accuracy_cap - 50);

    gFunc.Echo(7, "Ranged Attack under Prelude...");
    ra_sets[-35] = SelectSet(ra_set_options, ra_base_accuracy, settings.accuracy_cap - 35);

    gFunc.Echo(7, "Ranged Attack...");
    ra_sets[0] = SelectSet(ra_set_options, ra_base_accuracy, settings.accuracy_cap);

    gFunc.Echo(7, "Barrage under Sharpshot and Prelude...");
    ba_sets[-85] = SelectSet(ba_set_options, ba_base_accuracy, settings.accuracy_cap - 85);

    gFunc.Echo(7, "Barrage under Sharpshot...");
    ba_sets[-50] = SelectSet(ba_set_options, ba_base_accuracy, settings.accuracy_cap - 50);

    gFunc.Echo(7, "Barrage under Prelude...");
    ba_sets[-35] = SelectSet(ba_set_options, ba_base_accuracy, settings.accuracy_cap - 35);

    gFunc.Echo(7, "Barrage...");
    ba_sets[0] = SelectSet(ba_set_options, ba_base_accuracy, settings.accuracy_cap);

    gFunc.Echo(7, "3000TP Slug + Coronach under Sharpshot and Prelude...");
    ws_sets[-85] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap - 85);

    gFunc.Echo(7, "2000TP Slug under Sharpshot and Prelude...");
    ws_sets[-60] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap - 60);

    gFunc.Echo(7, "3000TP Slug + Coronach under Sharpshot...");
    ws_sets[-50] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap - 50);

    gFunc.Echo(7, "3000TP Slug under Prelude / Coronach under Prelude / 1000TP Slug under Sharpshot and Prelude...");
    ws_sets[-35] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap - 35);

    gFunc.Echo(7, "2000TP Slug under Sharpshot...");
    ws_sets[-25] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap - 25);

    gFunc.Echo(7, "2000TP Slug under Prelude...");
    ws_sets[-10] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap -10);

    gFunc.Echo(7, "3000TP Slug / Coronach / 1000TP Slug under Sharpshot...");
    ws_sets[0] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap);

    gFunc.Echo(7, "1000TP Slug under Prelude...");
    ws_sets[15] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap + 15);

    gFunc.Echo(7, "2000TP Slug...");
    ws_sets[25] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap + 25);

    gFunc.Echo(7, "1000TP Slug...");
    ws_sets[50] = SelectSet(ws_set_options, ws_base_accuracy, settings.accuracy_cap + 50);

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