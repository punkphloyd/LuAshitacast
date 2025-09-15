local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');

local Settings = {

	
	CurrentLevel = 0
	
};

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
    ['Fire'] = 'Penitent\'s Rope',
    ['Earth'] = 'Penitent\'s Rope',
    ['Water'] = 'Penitent\'s Rope',
    ['Wind'] = 'Penitent\'s Rope',
    ['Ice'] = 'Hyorin Obi',
    ['Thunder'] = 'Rairin Obi',
    ['Light'] = 'Penitent\'s Rope',
    ['Dark'] = 'Penitent\'s Rope'
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
	
	
	FastCast = {
		Head = 'Warlock\'s Chapeau',
		Ear1 = 'Loquac. Earring',
		Body = 'Duelist\'s Tabard',
		Ring1 = 'Ether Ring',
		Ring2 = 'Serket Ring'
	},
	
	
	TP = {
		Main = 'Fencing Degen',
		Sub = '',
		Range = '',
		Ammo = '',
		Head = 'Emperor Hairpin',
		Neck = 'Peacock Amulet',
		Ear1 = 'Drone Earring',
		Ear2 = 'Drone Earring',
		Body = 'Scp. Harness +1',
		Hands = 'Custom M Gloves',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Kshama Ring No.2',
		Back = 'Nomad\'s Mantle',
		Waist = 'Life Belt',
		Legs = 'Crow Hose',
		Feet = 'Leaping Boots'
	},
	
	Idle_Priority = {
		Main = { 'Terra\'s Staff', 'Fencing Degen' },
		Sub = '',
		Range = '',
		Ammo = '',
		--Head = 'Gold Hairpin +1',
		Neck = {'Star Necklace', 'Justice Badge'},
		Ear1 = 'Loquac. Earring',
		Ear2 = 'Mana Earring',
		Body = { 'Vermillion Cloak', 'Ryl.Sqr. Robe +1', 'Republic Aketon' },
		Hands = 'Errant Cuffs',
		Ring1 = 'Ether Ring',
		Ring2 = 'Serket Ring',
		Back = 'Hexerei Cape',
		Waist = 'Hierarch Belt',
		Legs = 'Crimson Cuisses',
		Feet = 'Errant Pigaches'
	},
	
	Resting_Priority = {
		Main = { 'Pluto\'s Staff', 'Fencing Degen'},
		Sub = '',
		Range = '',
		Ammo = '',
		Head = 'Gold Hairpin +1',
		Neck = 'Checkered Scarf',
		Ear1 = 'Morion Earring',
		Ear2 = 'Mana Earring',
		Body = 'Mahatma Hpl.',
		Hands = '',
		Ring1 = 'Ether Ring',
		Ring2 = 'Serket Ring',
		Back = 'Aurora Mantle',
		Waist = 'Duelist\'s Belt',
		Legs = 'Baron\'s Slops',
		Feet = 'Hydra Gaiters'
	},
	
	Nuke_Priority = {
		Head = 'Warlock\'s Chapeau',
		Neck = 'Prudence Torque',
		Ear1 = 'Novio Earring',
		Ear2 = 'Moldavite Earring',
		Body = 'Mahatma Hpl.',
		Hands = 'Zenith Mitts',
		Ring1 = 'Snow Ring',
		Ring2 = 'Snow Ring',
		Back = 'Prism Cape',
		Waist = 'Penitent\'s Rope',
		Legs = 'Mahatma Slops',
		Feet = 'Custom M Boots'
	},
	
	Enfeebling = {
		Main = 'Fencing Degen',
		Neck = 'Enfeebling Torque',
		Body = 'Warlock\'s Tabard',
		Back = 'Altruistic Cape'
	},
	
	INT_Priority = {
		Head = 'Warlock\'s Chapeau',
		Neck = 'Checkered Scarf',
		Ear1 = 'Morion Earring',
		Ear2 = 'Moldavite Earring',
		Body = 'Justaucorps +1',
		Hands = 'Mage\'s Mitts',
		Ring1 = 'Genius Ring',
		Ring2 = 'Genius Ring',
		Back = 'Red Cape +1',
		Waist = 'Penitent\'s Rope',
		Legs = 'Magic Cuisses',
		Feet = 'Custom M Boots'
	},
	
	MND_Priority = {
		Head = 'Zenith Crown',
		Neck = 'Faith Torque',
		Body = 'Mahatma Hpl.',
		Hands = 'Devotee\'s Mitts',
		Ring1 = 'Kshama Ring No.9',
		Back = 'Prism Cape',
		Waist = 'Penitent\'s Rope',
		Legs = 'Mahatma Slops',
		Feet = 'Errant Pigaches'
	},
	
	Cure_Priority = {
	
		
	},
	
	Stoneskin = {
	
		Main = 'Neptune\'s Staff',
		Head = 'Zenith Crown',
		Neck = 'Faith Torque',
		Body = 'Mahatma Hpl.',
		Hands = 'Devotee\'s Mitts',
		Ring1 = 'Kshama Ring No.9',
		Back = 'Prism Cape',
		Waist = 'Penitent\'s Rope',
		Legs = 'Mahatma Slops',
		Feet = 'Errant Pigaches'
	
	},
	
	Precast = {
	
		Head = 'Warlock\'s Chapeau',
		Ear1 = 'Loquac. Earring',
		Body = 'Duelist\'s Tabard',
		Ring1 = 'Ether Ring',
		Ring2 = 'Serket Ring',
	}
};


profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	
	
	varhelper.Initialize();
	
	varhelper.CreateToggle('CraftingMode',false);
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /rdm /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F12 /rdm Crafting');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
	AshitaCore:GetChatManager():QueueCommand(1, "/lockstyleset 18");
end

profile.OnUnload = function()

	varhelper.Destroy();
end

profile.HandleCommand = function(args)
	if(args[1] == 'Crafting') then
		varhelper.AdvanceToggle('CraftingMode');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		gFunc.Message('Crafting Mode: ' .. tostring(varhelper.GetToggle('CraftingMode')));
	end
end

profile.HandleDefault = function()
	local mylevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (mylevel ~= Settings.CurrentLevel) then
		gFunc.EvaluateLevels(profile.Sets, mylevel);
		Settings.CurrentLevel = mylevel;
	end
	local player = gData.GetPlayer();
	
	if(varhelper.GetToggle('CraftingMode') == true) then
		gFunc.EquipSet(sets.Crafting);
		return
	end
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.TP);
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	else
		gFunc.EquipSet(sets.Idle);
		if (player.MainJobLevel  < 59) then
			gFunc.Equip('Head', 'Gold Hairpin +1');
		end
	end
	
	

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
	
	local mndDebuffs = T{'Slow', 'Paralyze'};
	local intDebuffs = T{'Blind', 'Poison'};
	local eleDebuffs = T{'Burn', 'Choke', 'Shock', 'Rasp', 'Drown', 'Frost'};
    local player = gData.GetPlayer();
    local weather = gData.GetEnvironment();
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
		gFunc.Equip('Main', StaffTable[spell.Element]);
	
	elseif (spell.Skill == 'Elemental Magic') then
		gFunc.EquipSet(sets.Nuke);
		gFunc.Equip('main', StaffTable[spell.Element]);
		if spell.MppAftercast <= 50 then
                gFunc.Equip('neck', 'Uggalepih Pendant');
					
        end
		if ObiCheck(spell) >= 1 then
                gFunc.Equip('waist', ObiTable[spell.Element])
        end
	elseif (spell.Skill == 'Enfeebling Magic') then
		gFunc.EquipSet(sets.Enfeebling);
		gFunc.Equip('main', StaffTable[spell.Element]);
		if(mndDebuffs:contains(spell.Name)) then
			gFunc.EquipSet(sets.MND);
		
		elseif intDebuffs:contains(spell.Name) then
			gFunc.EquipSet(sets.INT);
		end
	elseif(spell.Type == 'Bard Song') then
		if (spell.Name:contains('Paeon')) then
			gFunc.Equip('Back','Singer\'s Mantle');
		end
	else
		gFunc.EquipSet(sets.FastCast);
		
	end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()

end

return profile;