local profile = {};

local blmTables = T{};

blmTables.Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','San d\'Oria-Jeuno Airship','Bastok-Jeuno Airship','Windurst-Jeuno Airship','Kazham-Jeuno Airship','Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library','Western Adoulin','Eastern Adoulin'};

local varhelper = gFunc.LoadFile('common/varhelper.lua');


local Settings = {

	
	CurrentLevel = 0
	
};

local mp_thresholds = {
	['INT'] = 823,
	['Skill'] = 808,
	['Hybrid'] = 785,
	['Enmity'] = 853,
	['Idle'] = 1115,
	['Resting'] = 983,
	['Enfeebling'] = 914
};


local mp_set_options = {
	
	['INT'] = {		-- +160 MP (target)
		Head = 'Zenith Crown',
		Ring1 = 'Serket Ring',
		Ring2 = 'Snow Ring',
		Waist = 'Hierarch Belt'
	},
	['Skill'] = {		-- +175 MP (target)
		Ring1 = 'Serket Ring',
		Ring2 = 'Snow Ring',
		Waist = 'Hierarch Belt',
		Back = 'Blue Cape',
		Ear2 = 'Loquac. Earring',
	},
	['Hybrid'] = {	-- +198 MP (target)
		Head = 'Zenith Crown',
		Ring1 = 'Serket Ring',
		Ring2 = 'Snow Ring',
		Waist = 'Hierarch Belt',
		Back = 'Blue Cape',
		Hands = 'Zenith Mitts'
	},
	['Enmity'] = {	-- +130 MP (target)
		Head = 'Zenith Crown',
		Ring1 = 'Serket Ring',
		Ring2 = 'Snow Ring',
		Back = 'Blue Cape',
	
	},
	['Enfeebling'] = {	-- +70 MP (target)
		Ring1 = 'Serket Ring',
		Ear2 = 'Loquac. Earring',
	
	}
	
};


local DayElementTable = {
    ['Firesday'] = 'Fire',
    ['Earthsday'] = 'Earth',
    ['Watersday'] = 'Water',
    ['Windsday'] = 'Wind',
    ['Iceday'] = 'Ice',
    ['Lightningday'] = 'Thunder',
    ['Lightsday'] = 'Light',
    ['Darksday'] = 'Dark'
};

local ObiTable = {
    ['Fire'] = 'Sorcerer\'s Belt',
    ['Earth'] = 'Sorcerer\'s Belt',
    ['Water'] = 'Sorcerer\'s Belt',
    ['Wind'] = 'Sorcerer\'s Belt',
    ['Ice'] = 'Hyorin Obi',
    ['Thunder'] = 'Rairin Obi',
    ['Light'] = 'Sorcerer\'s Belt',
    ['Dark'] = 'Anrin Obi'
};


function ObiCheck(spell)
    local element = spell.Element
    local zone = gData.GetEnvironment()

    local badEle = {
        ['Fire'] = 'Water',
        ['Earth'] = 'Wind',
        ['Water'] = 'Thunder',
        ['Wind'] = 'Ice',
        ['Ice'] = 'Fire',
        ['Thunder'] = 'Earth',
        ['Light'] = 'Dark',
        ['Dark'] = 'Light'
    };

    local weight = 0

    --Day comparison
    if (DayElementTable[zone.Day] == spell.Element) then
        weight = weight + 1
    elseif (DayElementTable[zone.Day] == badEle[spell.Element]) then
        weight = weight - 1
    end

    --Weather comparison
    if string.find(zone.Weather, spell.Element) then
        if string.find(zone.Weather, 'x2') then
            weight = weight + 2
        else
            weight = weight + 1
        end
    elseif string.find(zone.Weather, badEle[spell.Element]) then
        if string.find(zone.Weather, 'x2') then
            weight = weight - 2
        else
            weight = weight - 1
        end
    end

    return weight
end

local StaffTable = {
	['Fire'] = 'Vulcan\'s Staff',
	['Earth'] = 'Terra\'s Staff',
	['Water'] = 'Neptune\'s Staff',
	['Wind'] = 'Auster\'s Staff',
	['Ice'] = 'Aquilo\'s Staff',
	['Thunder'] = 'Jupiter\'s Staff',
	['Light'] = 'Apollo\'s Staff',
	['Dark'] = 'Pluto\'s Staff'
};

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
	
	HELM = {
		Body = 'Field Tunica',
		Hands = 'Field Gloves',
		Legs = 'Field Hose',
		Feet = 'Field Boots'
	},
	
	Town = {
		Head = 'Shaded Specs.',
		Body = 'Blacksmith\'s Apn.',
		Hands = 'Smithy\'s Mitts',
	},
	
	HPLow = {
		Head = 'Zenith Crown',			-- 50 HP
		Neck = 'Star Necklace',			-- 15 HP
		Hands = 'Zenith Mitts',			-- 50 HP
		Legs = 'Zenith Slacks',			-- 50 HP
		Ring1 = 'Serket Ring',			-- 50 HP
		Ring2 = 'Ether Ring',			-- 30 HP
		Back = 'Blue Cape',				-- 15 HP
		Feet = 'Rostrum Pumps'			-- 30 HP
	},
	
	Idle_Priority = {
		Main = StaffTable['Earth'],
		Ammo = 'Phtm. Tathlum', 
		Head = 'Zenith Crown',			-- 50 HP, 3 INT
		Neck = 'Uggalepih Pendant',		-- 20 MP
		Ear1 = 'Astral Earring',		-- 25 MP
		Ear2 = 'Loquac. Earring',		-- 30 MP
		Body = 'Sorcerer\'s Coat',		-- 12 MP
		Hands = 'Zenith Mitts',			-- 50 MP, 5 MAB
		Ring1 = 'Serket Ring',			-- 30 MP
		Ring2 = 'Ether Ring',			-- 50 MP
		Back = 'Blue Cape',				-- 30 MP
		Waist = 'Hierarch Belt',		-- 48 MP
		Legs = 'Zenith Slacks',			-- 50 MP
		Feet = 'Rostrum Pumps'			-- 30 MP, 3 INT
	},
	
	Digging = {
		Body = 'Choc. Jack Coat',
		Hands = 'Chocobo Gloves',
		Legs = 'Chocobo Hose',
		Feet = 'Chocobo Boots'
	},
	
	Resting_Priority = {
		Main = StaffTable['Dark'],
		Ammo = 'Phtm. Tathlum', 
		Head = 'Wzd. Petasos +1',
		Neck = 'Checkered Scarf',
		Ear1 = 'Warlock\'s Earring',
		Ear2 = 'Loquac. Earring',
		Body = 'Errant Hpl.',
		Hands = 'Zenith Mitts',
		Ring1 = 'Serket Ring',
		Ring2 = 'Ether Ring',
		Back = 'Blue Cape',
		Waist = 'Hierarch Belt',
		Legs = 'Baron\'s Slops',
		Feet = 'Hydra Gaiters'
	},
	
	Nuke_INT_Priority = {
		Range = '',
		Ammo = 'Phtm. Tathlum',
		Head = 'Demon Helm +1',
		Neck = 'Prudence Torque',
		Ear1 = 'Novio Earring',
		Ear2 = 'Moldavite Earring',
		Body = 'Igqira Weskit',
		Hands = 'Zenith Mitts', 
		Ring1 = 'Snow Ring',
		Ring2 = 'Snow Ring',
		Back = 'Prism Cape', 
		Waist = 'Sorcerer\'s Belt',
		Legs = 'Mahatma Slops', 
		Feet = 'Src. Sabots +1'
	},
	
	Nuke_Skill_Priority = {
		Range = '',
		Ammo = 'Phtm. Tathlum',
		Head = 'Sorcerer\'s Petas.',
		Neck = 'Elemental Torque',
		Ear1 = 'Novio Earring',
		Ear2 = 'Moldavite Earring',
		Body = 'Igqira Weskit',
		Hands = 'Wizard\'s Gloves',
		Ring1 = 'Snow Ring',
		Ring2 = 'Snow Ring',
		Back = 'Prism Cape', 
		Waist = 'Sorcerer\'s Belt',
		Legs = 'Druid\'s Slops', 
		Feet = 'Src. Sabots +1'

	},
	
	Nuke_Hybrid_Priority = {
		Range = '',
		Ammo = 'Phtm. Tathlum',
		Head = 'Demon Helm +1',
		Neck = 'Prudence Torque',
		Ear1 = 'Novio Earring',
		Ear2 = 'Moldavite Earring',
		Body = 'Igqira Weskit',
		Hands = 'Wizard\'s Gloves', 
		Ring1 = 'Snow Ring',
		Ring2 = 'Snow Ring',
		Back = 'Prism Cape', 
		Waist = 'Sorcerer\'s Belt',
		Legs = 'Mahatma Slops', 
		Feet = 'Src. Sabots +1'

	},
	
	Nuke_Enmity = {
		Range = '',
		Ammo = 'Phtm. Tathlum',
		Head = 'Wzd. Petasos +1',
		Neck = 'Prudence Torque',
		Ear1 = 'Novio Earring',
		Ear2 = 'Novia Earring',
		Body = 'Errant Hpl.',
		Hands = 'Zenith Mitts', 
		Ring1 = 'Snow Ring',
		Ring2 = 'Snow Ring',
		Back = 'Prism Cape',
		Waist = 'Penitent\'s Rope',
		Legs = 'Mahatma Slops', 
		Feet = 'Src. Sabots +1'

	},
	
	
	
	Enfeebling_Priority = {
		Head = 'Nashira Turban', 
		Body = 'Wizard\'s Coat',
		Neck = 'Enfeebling Torque',
		Ring1 = 'Snow Ring',
		Ring2 = 'Snow Ring',
		Back = 'Altruistic Cape',
		Legs = 'Nashira Seraweels'
	},
	
	Enf_Eff_Priority = {
		Head = 'Nashira Turban',
		Neck = 'Enfeebling Torque',
		Ear2 = 'Loquac. Earring',
		Body = 'Wizard\'s Coat',
		Ring1 = 'Serket Ring',
		Ring2 = 'Ether Ring',
		Back = 'Altruistic Cape',
		Legs = 'Nashira Seraweels'
	},
	
	
	INT_Enf = {
		Ammo = 'Phtm. Tathlum',
		Hands = 'Errant Cuffs',
		Waist = 'Sorcerer\'s Belt',
		Feet = 'Rostrum Pumps'

	},
	
	MND_Enf = {
		Hands = 'Devotee\'s Mitts',
		Feet = 'Errant Pigaches'
	},
	
	Divine = {
		Range = '',
		Ammo = 'Phtm. Tathlum',
		Head = 'Demon Helm +1',
		Neck = 'Prudence Torque',
		Ear1 = 'Novio Earring',
		Ear2 = 'Moldavite Earring',
		Body = 'Igqira Weskit',
		Hands = 'Zenith Mitts', 
		Ring1 = 'Snow Ring',
		Ring2 = 'Snow Ring',
		Back = 'Prism Cape', 
		Waist = 'Sorcerer\'s Belt',
		Legs = 'Mahatma Slops', 
		Feet = 'Rostrum Pumps'
	
	},
	
	Stoneskin_Priority = {
	
		Main = 'Kirin\'s Pole',
		Head = 'Zenith Crown',
		Neck = 'Faith Torque',
		Body = 'Errant Hpl.',
		Hands = 'Devotee\'s Mitts',
		Back = 'Prism Cape',
		Waist = 'Penitent\'s Rope',
		Legs = 'Mahatma Slops',
		Feet = 'Errant Pigaches'
	
	},
	
	Cure = {
	
	},
	
	Precast_Priority = {
	
		Head = {'Nashira Turban'},
		Ear2 = 'Loquac. Earring',
		Ring1 = 'Serket Ring',
		Ring2 = 'Ether Ring',
		Back = 'Warlock\'s Mantle',
		Legs = 'Nashira Seraweels',
		Feet = 'Rostrum Pumps'
	},
	
	Dark_Priority = {
		Ammo = 'Phtm. Tathlum',
		Head = 'Zenith Crown',
		Neck = 'Dark Torque',
		Ear1 = 'Astral Earring',
		Ear2 = 'Loquac. Earring',
		Body = 'Nashira Manteel',
		Hands = 'Src. Gloves +1',
		Ring1 = 'Serket Ring',
		Ring2 = 'Overlord\'s Ring',
		Back = 'Warlock\'s Mantle',
		Waist = 'Hierarch Belt',
		Legs = 'Wizard\'s Tonban',
		Feet = 'Igqira Huaraches'
		
	},
	
	Stun = {
	
		Head = 'Nashira Turban',
		Neck = 'Dark Torque',
		Ear1 = 'Loquac. Earring',
		Ear2 = 'Novia Earring',
		Body = 'Nashira Manteel',
		Hands = 'Src. Gloves +1',
		Ring1 = 'Serket Ring',
		Ring2 = 'Ether Ring',
		Back = 'Warlock\'s Mantle',
		Waist = '',
		Legs = 'Nashira Seraweels',
		Feet = 'Rostrum Pumps'
	
	};
	
	Drain = {
	
		Head = 'Nashira Turban',
		Neck = 'Dark Torque',
		Ear1 = 'Loquac. Earring',
		Ear2 = 'Novia Earring',
		Body = 'Nashira Manteel',
		Hands = 'Src. Gloves +1',
		Ring1 = 'Serket Ring',
		Ring2 = 'Overlord\'s Ring',
		Back = 'Warlock\'s Mantle',
		Waist = '',
		Legs = 'Nashira Seraweels',
		Feet = 'Igqira Huaraches'
	
	},
	
	
	Aspir = {
	
		Head = 'Nashira Turban',
		Neck = 'Dark Torque',
		Ear1 = 'Loquac. Earring',
		Ear2 = 'Novia Earring',
		Body = 'Nashira Manteel',
		Hands = 'Src. Gloves +1',
		Ring1 = 'Serket Ring',
		Ring2 = 'Overlord\'s Ring',
		Back = 'Warlock\'s Mantle',
		Waist = '',
		Legs = 'Nashira Seraweels',
		Feet = 'Igqira Huaraches'
	
	},
	
	Burst = {
		Hands = 'Src. Gloves +1',
	},
	
	SorcPants = {
		Legs = 'Sorcerer\'s Tonban',
	}
};


profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()

	AshitaCore:GetChatManager():QueueCommand(1, '/macro book 3');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');

    gSettings.AllowAddSet = true;
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /blm /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /mb /lac fwd mb');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /eff /lac fwd eff');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F12 /blm Digging');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F12 /blm Crafting');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F11 /blm NukeMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind @F12 /blm HELM');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F9 /blm HPLow');
	
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /blm Report');
	
	AshitaCore:GetChatManager():QueueCommand(1, "/lockstyleset 3");
	
	varhelper.Initialize();
	
	varhelper.CreateToggle('DiggingMode',false);
	varhelper.CreateToggle('CraftingMode',false);
	varhelper.CreateToggle('HELMMode',false);
	varhelper.CreateToggle('ConquestMode',true);
	varhelper.CreateToggle('Burst',false);
	varhelper.CreateToggle('Efficiency',false);
	varhelper.CreateCycle('NukeMode',{[1] = 'INT', [2] = 'Skill', [3] = 'Hybrid', [4] = 'Enmity'})
end

profile.OnUnload = function()

	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /blm');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /mb');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /eff');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F11');
	varhelper.Destroy();
end

profile.HandleCommand = function(args)

	if (args[1] == 'mb') then
		varhelper.AdvanceToggle('Burst');
		gFunc.Message('Burst Mode: ' .. tostring(varhelper.GetToggle('Burst')));
	end
	if (args[1] == 'eff') then
		varhelper.AdvanceToggle('Efficiency');
		gFunc.Message('Effiency Mode: ' .. tostring(varhelper.GetToggle('Efficiency')));
	end
	if(args[1] == 'HPLow') then
		
	AshitaCore:GetChatManager():QueueCommand(-1, '/lac set HPLow');
	end

	if(args[1] == 'Digging') then
		varhelper.AdvanceToggle('DiggingMode');
		if(varhelper.GetToggle('DiggingMode') == true ) then 
			if(varhelper.GetToggle('CraftingMode') == true) then
				varhelper.AdvanceToggle('CraftingMode');
			end
			AshitaCore:GetChatManager():QueueCommand(1, '/macro book 18');
			AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		end
		gFunc.Message('Digging Mode: ' .. tostring(varhelper.GetToggle('DiggingMode')));
		gFunc.Message('Crafting Mode: ' .. tostring(varhelper.GetToggle('CraftingMode')));
	
	elseif(args[1] == 'Crafting') then
		varhelper.AdvanceToggle('CraftingMode');
		if(varhelper.GetToggle('CraftingMode') == true ) then 
			if(varhelper.GetToggle('DiggingMode') == true) then
				varhelper.AdvanceToggle('DiggingMode');
			end
			AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
			AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		end
		gFunc.Message('Crafting Mode: ' .. tostring(varhelper.GetToggle('CraftingMode')));
		gFunc.Message('Digging Mode: ' .. tostring(varhelper.GetToggle('DiggingMode')));
	
	
	elseif(args[1] == 'NukeMode') then
		varhelper.AdvanceCycle('NukeMode');
		gFunc.Message('Nuke Mode: ' .. tostring(varhelper.GetCycle('NukeMode')));
	
	elseif(args[1] == 'HELM') then
		varhelper.AdvanceToggle('HELMMode');
		if(varhelper.GetToggle('HELMMode') == true ) then 
			if(varhelper.GetToggle('DiggingMode') == true) then
				varhelper.AdvanceToggle('DiggingMode');
			end
			if(varhelper.GetToggle('CraftingMode') == true) then
				varhelper.AdvanceToggle('CraftingMode');
			end
			AshitaCore:GetChatManager():QueueCommand(1, '/macro book 19');
			AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		end
		gFunc.Message('HELM Mode: ' .. tostring(varhelper.GetToggle('HELMMode')));
		
		gFunc.Message('Crafting Mode: ' .. tostring(varhelper.GetToggle('CraftingMode')));
		gFunc.Message('Digging Mode: ' .. tostring(varhelper.GetToggle('DiggingMode')));
	
	
	
	elseif(args[1] == 'Report') then
		gFunc.Message('Digging Mode (toggle w/ CTRL+F12): ' .. tostring(varhelper.GetToggle('DiggingMode')));
		gFunc.Message('Crafting Mode (toggle w/ ALT+F12): ' .. tostring(varhelper.GetToggle('CraftingMode')));
		gFunc.Message('HELM Mode (toggle w/ WIN+F12): ' .. tostring(varhelper.GetToggle('HELMMode')));
		gFunc.Message('Nuke Mode (toggle w/ ALT+F11): ' .. tostring(varhelper.GetCycle('NukeMode')));
	end
end

profile.HandleDefault = function()
	local mylevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (mylevel ~= Settings.CurrentLevel) then
		gFunc.EvaluateLevels(profile.Sets, mylevel);
		Settings.CurrentLevel = mylevel;
	end
	local player = gData.GetPlayer();
	if(varhelper.GetToggle('DiggingMode') == true) then
		gFunc.EquipSet(sets.Digging);
		return
	end
	if(varhelper.GetToggle('CraftingMode') == true) then
		gFunc.EquipSet(sets.Crafting);
		return
	end
	if(varhelper.GetToggle('HELMMode') == true) then
		gFunc.EquipSet(sets.HELM);
		return
	end
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.TP);
	elseif (player.Status == 'Resting') then

		gFunc.EquipSet(sets.Resting);

	else
		gFunc.EquipSet(sets.Idle);
	end
	
	-- local zone = gData.GetEnvironment();
	-- if (zone.Area ~= nil and blmTables.Towns:contains(zone.Area)) then
	--	gFunc.EquipSet(sets.Town)
	-- end

end

profile.HandleAbility = function()
	local action = gData.GetAction();
	

end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	local spell = gData.GetAction();

	gFunc.EquipSet(sets.Precast);
end

profile.HandleMidcast = function() 
	
	local mndDebuffs = T{'Slow', 'Paralyze', 'Silence'};
	local intDebuffs = T{'Blind', 'Poison', 'Gravity', 'Sleep'};
	local accDebuffs = T{'Silence', 'Bind', 'Gravity'}
	local eleDebuffs = T{'Burn', 'Choke', 'Shock', 'Rasp', 'Drown', 'Frost'};
	
    local player = gData.GetPlayer();
    local environ = gData.GetEnvironment();
    local spell = gData.GetAction();
    local target = gData.GetActionTarget();
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0);
	
	if(spell.Skill == 'Enhancing Magic') then
		gFunc.EquipSet(sets.Enhancing);
		if(spell.Name == 'Stoneskin') then
			gFunc.EquipSet(sets.Stoneskin);
		end
	elseif (spell.Skill == 'Healing Magic') then
		gFunc.EquipSet(sets.Cure);
	
	elseif (spell.Skill == 'Elemental Magic') then
		gFunc.EquipSet('Nuke_' .. varhelper.GetCycle('NukeMode'));
		gFunc.Equip('main', StaffTable[spell.Element]);
		if(player.HPP <= 79) then
                gFunc.Equip('Ring2', 'Sorcerer\'s Ring');
        end 
		if(player.HP < 705) then
			gFunc.Equip('Ring2', 'Sorcerer\'s Ring');
		end
		if spell.MppAftercast <= 50 then
                gFunc.Equip('neck', 'Uggalepih Pendant');
					
        end
		if ObiCheck(spell) >= 1 then
                gFunc.Equip('waist', ObiTable[spell.Element])
        end
		if varhelper.GetToggle('Burst') == true then
			gFunc.EquipSet(sets.Burst);
		end
		
		if (environ.DayElement == spell.Element) then
			gFunc.EquipSet(sets.SorcPants);
		end
		
	elseif (spell.Skill == 'Enfeebling Magic') then
		gFunc.EquipSet(sets.Enfeebling);
		
	
		if(intDebuffs:contains(spell.Name)) then
			gFunc.EquipSet(sets.INT_Enf);
		
		elseif(mndDebuffs:contains(spell.Name)) then
			gFunc.EquipSet(sets.MND_Enf);
		
		elseif(spell.Name == 'Bind') then
			gFunc.EquipSet(sets.Enfeebling);
		end
		gFunc.Equip('main', StaffTable[spell.Element]);
	elseif (spell.Skill == 'Dark Magic') then
		gFunc.EquipSet(sets.Dark)
		
		gFunc.Equip('main', StaffTable[spell.Element])
		if environ.WeatherElement == 'Dark' then
			gFunc.Equip('Main', 'Diabolos\'s Pole')
		end
		
		if ObiCheck(spell) >= 1 then
                gFunc.Equip('waist', ObiTable[spell.Element])
        end
	end
	
	if varhelper.GetToggle('Efficiency') == true then
		if (spell.Skill == 'Elemental Magic') then
			nuke_mode = varhelper.GetCycle('NukeMode');
			if player.MP > mp_thresholds[nuke_mode] then 
				gFunc.EquipSet(mp_set_options[nuke_mode]);
			end
		elseif (spell.Skill == 'Enfeebling Magic') then
			if player.MP > mp_thresholds['Enfeebling'] then 
				gFunc.EquipSet(mp_set_options['Enfeebling']);
			end
		
		end
	end
	
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()

end

return profile;