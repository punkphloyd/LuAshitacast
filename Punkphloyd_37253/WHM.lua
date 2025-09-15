local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');

local Settings = {

	
	CurrentLevel = 0
	
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
	
	Enhancing = {
		Feet = 'Cleric\'s Duckbills'
	},
	
	EnmityDown = {
		head = "Cleric\'s Cap",
		body = "Blessed Bliaut",
		hands = "Healer\'s Mitts",
		legs = "Blessed Trousers",
		ring1 = "Tamas Ring"
	
	},
	
	Charm = {
		Main = '',
		Sub = '',
		Range = '',
		Ammo = '',
		Head = 'Noble\'s Ribbon',
		Neck = 'Bird Whistle',
		Ear1 = '',
		Ear2 = '',
		Body = '',
		Hands = '',
		Ring1 = 'Moon Ring',
		Ring2 = 'Moon Ring',
		Back = '',
		Waist = 'Corsette',
		Legs = 'Custom Slacks',
		Feet = ''
	},
	
	TP = {
		Head = '',
		Neck = 'Peacock Amulet',
		Ear1 = 'Beetle Earring +1',
		Ear2 = 'Beetle Earring +1',
		Body = '',
		Hands = 'Battle Gloves',
		Ring1 = 'Tamas Ring',
		Ring2 = 'Sniper\'s Ring',
		Back = '',
		Waist = '',
		Legs = 'Cmb.Cst. Slacks',
		Feet = 'Cmb.Cst. Shoes'
	},
	
	FastCast = {
		Ear1 = 'Loquac. Earring',
		Hands = 'Blessed Mitts',
		Legs = 'Blessed Trousers',
		Feet = 'Blessed Pumps'
	},
	
	Idle_Priority = {
		Main = { 'Terra\'s Staff', 'Solid Wand' },
		Sub = '',
		Range = '',
		Ammo = '',
		Head = 'Zenith Crown',
		Neck = 'Uggalepih Pendant',
		Ear1 = 'Loquac. Earring',
		Ear2 = 'Novio Earring',
		Body = 'Cleric\'s Bliaut',
		Hands = {'Zenith Mitts', 'Healer\'s Mitts', 'Devotee\'s Mitts' },
		Ring1 = 'Tamas Ring',
		Ring2 = 'Serket Ring',
		Back = 'Altruistic Cape',
		Waist = 'Hierarch Belt',
		Legs = 'Zenith Slacks',
		Feet = 'Healer\'s Duckbills'
	},
	
	Idle_Refresh_Priority = {
		Main = { 'Terra\'s Staff', 'Solid Wand' },
		Sub = '',
		Range = '',
		Ammo = '',
		Head = 'Zenith Crown',
		Neck = 'Uggalepih Pendant',
		Ear1 = 'Loquac. Earring',
		Ear2 = 'Phtm. Earring +1',
		Body = 'Cleric\'s Bliaut',
		Hands = {'Zenith Mitts', 'Healer\'s Mitts', 'Devotee\'s Mitts' },
		Ring1 = 'Tamas Ring',
		Ring2 = 'Serket Ring',
		Back = 'Altruistic Cape',
		Waist = 'Hierarch Belt',
		Legs = 'Zenith Slacks',
		Feet = 'Healer\'s Duckbills'
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
		Feet = 'Field Boots'
	},
	
	Resting_Priority = {
		Main = { 'Pluto\'s Staff', 'Blessed Hammer' },
		Sub = '',
		Range = '',
		Ammo = '',
		Head = 'Hlr. Cap +1',
		Neck = 'Checkered Scarf',
		Ear1 = 'Relaxing Earring',
		Ear2 = '',
		Body = 'Mahatma Hpl.',
		Hands = '',
		Ring1 = 'Tamas Ring',
		Ring2 = 'Serket Ring',
		Back = '',
		Waist = 'Cleric\'s Belt',
		Legs = 'Baron\'s Slops',
		Feet = 'Hydra Gaiters'
	},
	
	Nuke_Priority = {
		Main = { 'Solid Wand', 'Yew Wand +1' },
		Sub = '',
		Range = '',
		Ammo = 'Morion Tathlum',
		Head = 'Seer\'s Crown +1',
		Neck = 'Black Silk Neckerchief',
		Ear1 = 'Novio Earring',
		Ear2 = 'Moldavite Earring',
		Body = 'Baron\'s Saio',
		Hands = 'Seer\'s Mitts +1',
		Ring1 = 'Tamas Ring',
		Ring2 = { 'Wisdom Ring', 'Knowledge Ring' },
		Back = 'Red Cape +1',
		Waist = 'Shaman\'s Belt',
		Legs = 'Seer\'s Slacks +1',
		Feet = 'Custom M Boots'
	},
	
	Enfeebling = {
	},
	
	
	
	INT_Potency_Priority = {
		Main = { 'Solid Wand', 'Yew Wand +1' },
		Sub = '',
		Range = '',
		Ammo = 'Phantom Tathlum',
		Head = 'Seer\'s Crown +1',
		Neck = 'Enfeebling Torque',
		Ear1 = 'Morion Earring',
		Ear2 = 'Enfeebling Earring',
		Body = { 'Healer\'s Bliaut', 'Baron\'s Saio' },
		Hands = {'Cleric\'s Mitts', 'Seer\'s Mitts +1'},
		Ring1 = 'Tamas Ring',
		Ring2 = { 'Wisdom Ring', 'Knowledge Ring' },
		Back = 'Red Cape +1',
		Waist = 'Shaman\'s Belt',
		Legs = 'Seer\'s Slacks +1',
		Feet = 'Custom M Boots'
	},
	
	
	MND_Potency_Priority = {
		Main = { 'Solid Wand', 'Yew Wand +1' },
		Sub = '',
		Range = '',
		Ammo = 'Morion Tathlum',
		Head =  { 'Healer\'s Cap', 'Circe\'s Hat' },
		Neck = 'Enfeebling Torque',
		Ear1 = 'Geist Earring',
		Ear2 = 'Enfeebling Earring',
		Body = { 'Healer\'s Bliaut', 'Bishop\'s Robe', 'Baron\'s Saio' },
		Hands = {'Cleric\'s Mitts', 'Devotee\'s Mitts'},
		Ring1 = 'Tamas Ring',
		Ring2 = 'Saintly Ring +1',
		Back = 'White Cape +1',
		Waist = 'Cleric\'s Belt',
		Legs = 'Custom Slacks',
		Feet = 'Seer\'s Pumps +1'
	},
	
	Divine_Priority = {
	
		Main = { 'Apollo\'s Staff', 'Solid Wand' },
		Sub = '',
		Range = '',
		Ammo = 'Morion Tathlum',
		Head =  { 'Healer\'s Cap', 'Circe\'s Hat' },
		Neck = 'Justice Badge',
		Ear1 = 'Novio Earring',
		Ear2 = 'Moldavite Earring',
		Body = { 'Bishop\'s Robe', 'Baron\'s Saio' },
		Hands = {'Cleric\'s Mitts', 'Devotee\'s Mitts'},
		Ring1 = 'Tamas Ring',
		Ring2 = 'Kshama Ring No.9',
		Back = 'Prism Cape',
		Waist = 'Friar\'s Rope',
		Legs = {'Healer\'s Pantaln.', 'Custom Slacks' },
		Feet = 'Seer\'s Pumps +1'
	},
	
	Banish_Priority = {
	
		Main = { 'Apollo\'s Staff', 'Solid Wand' },
		Sub = '',
		Range = '',
		Ammo = 'Morion Tathlum',
		Head =  { 'Healer\'s Cap', 'Circe\'s Hat' },
		Neck = 'Justice Badge',
		Ear1 = 'Novio Earring',
		Ear2 = 'Moldavite Earring',
		Body = { 'Bishop\'s Robe', 'Baron\'s Saio' },
		Hands = {'Cleric\'s Mitts', 'Devotee\'s Mitts'},
		Ring1 = 'Tamas Ring',
		Ring2 = 'Kshama Ring No.9',
		Back = 'White Cape +1',
		Waist = 'Friar\'s Rope',
		Legs = {'Healer\'s Pantaln.', 'Custom Slacks' },
		Feet = 'Seer\'s Pumps +1'
	},
	
	Cure_Priority = {
	
		Main = { 'Apollo\'s Staff', 'Solid Wand' },
		Sub = '',
		Range = '',
		Ammo = 'Morion Tathlum',
		Head =  { 'Healer\'s Cap', 'Circe\'s Hat' },
		Neck = 'Ajari Bead Necklace',
		Ear1 = 'Geist Earring',
		Ear2 = 'Morion Earring',
		Body = { 'Noble\'s Tunic', 'Bishop\'s Robe', 'Baron\'s Saio' },
		Hands = 'Blessed Mitts',
		Ring1 = 'Tamas Ring',
		Ring2 = 'Saintly Ring +1',
		Back = 'White Cape +1',
		Waist = 'Penitent\'s Rope',
		Legs = 'Blessed Trousers',
		Feet = 'Errant Pigaches'
	},
	
	Precast = {
	
		Ring1 = 'Ether Ring',
		Ring2 = 'Astral Ring',
	}
,
    Melee_Priority = {
        Main = 'Darksteel Maul',
        Sub = 'Darksteel Maul',
        Ammo = 'Phtm. Tathlum',
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Moldavite Earring',
        Body = 'Reverend Mail',
        Hands = 'Blessed Mitts',
        Ring1 = 'Kshama Ring No.2',
        Ring2 = 'Victory Ring',
        Back = 'Altruistic Cape',
        Waist = 'Swift Belt',
        Legs = 'Blessed Trousers',
        Feet = 'Blessed Pumps',
    }};


profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /whm /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F12 /whm Digging');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F12 /whm Crafting');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind @F12 /whm HELM');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F11 /whm IdleMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F11 /whm MeleeMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /whm Report');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F9 /whm LowEnmityMode');
	
	varhelper.Initialize();
	
	varhelper.CreateToggle('DiggingMode',false);
	varhelper.CreateToggle('CraftingMode',false);
	varhelper.CreateToggle('HELMMode',false);
	varhelper.CreateToggle('UseRefreshIdle',true);
	varhelper.CreateToggle('MeleeMode',false);
	varhelper.CreateToggle('LowEnmityMode',false);
	
end

profile.OnUnload = function()

	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /whm');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F11');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F11');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F9');
	varhelper.Destroy();
end

profile.HandleCommand = function(args)
	if(args[1] == 'Digging') then
		varhelper.AdvanceToggle('DiggingMode');
		if(varhelper.GetToggle('DiggingMode') == true ) then 
			if(varhelper.GetToggle('CraftingMode') == true) then
				varhelper.AdvanceToggle('CraftingMode');
			end
			if(varhelper.GetToggle('HELMMode') == true) then
				varhelper.AdvanceToggle('HELMMode');
			end
			AshitaCore:GetChatManager():QueueCommand(1, '/macro book 18');
			AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		end
		gFunc.Message('Digging Mode: ' .. tostring(varhelper.GetToggle('DiggingMode')));
		gFunc.Message('Crafting Mode: ' .. tostring(varhelper.GetToggle('CraftingMode')));
		gFunc.Message('HELM Mode: ' .. tostring(varhelper.GetToggle('HELMMode')));
		
	elseif(args[1] == 'Crafting') then
		varhelper.AdvanceToggle('CraftingMode');
		if(varhelper.GetToggle('CraftingMode') == true ) then 
			if(varhelper.GetToggle('DiggingMode') == true) then
				varhelper.AdvanceToggle('DiggingMode');
			end
			if(varhelper.GetToggle('HELMMode') == true) then
				varhelper.AdvanceToggle('HELMMode');
			end
			AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
			AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		end
		gFunc.Message('Crafting Mode: ' .. tostring(varhelper.GetToggle('CraftingMode')));
		gFunc.Message('Digging Mode: ' .. tostring(varhelper.GetToggle('DiggingMode')));
		gFunc.Message('HELM Mode: ' .. tostring(varhelper.GetToggle('HELMMode')));
		
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
	
	
	elseif(args[1] == 'IdleMode') then
		varhelper.AdvanceToggle('UseRefreshIdle');
		gFunc.Message('Refresh Idle Mode: ' .. tostring(varhelper.GetToggle('UseRefreshIdle')));
	
	elseif(args[1] == 'MeleeMode') then
		
		if(varhelper.GetToggle('MeleeMode') == false) then
			gFunc.Message('Weapon switching disabled');
			AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Main');
			AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Sub');
		else
			gFunc.Message('Weapon switching enabled');
			AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Main');
			AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Sub');
		end
		varhelper.AdvanceToggle('MeleeMode');
		gFunc.Message('Melee Mode: ' .. tostring(varhelper.GetToggle('MeleeMode')));
	
	elseif(args[1] == 'LowEnmityMode') then
		varhelper.AdvanceToggle('LowEnmityMode');
		gFunc.Message('Low Enmity Mode: ' .. tostring(varhelper.GetToggle('LowEnmityMode')));
		
	elseif(args[1] == 'Report') then
		gFunc.Message('Crafting Mode (toggle w/ CTRL+F12): ' .. tostring(varhelper.GetToggle('CraftingMode')));
		gFunc.Message('Digging Mode (toggle w/ ALT+F12): ' .. tostring(varhelper.GetToggle('DiggingMode')));
		gFunc.Message('HELM Mode (toggle w/ WIN+F12): ' .. tostring(varhelper.GetToggle('HELMMode')));
		gFunc.Message('Refresh Idle Mode (toggle w/ CTRL+F11): ' .. tostring(varhelper.GetToggle('UseRefreshIdle')));
		gFunc.Message('Melee Mode (toggle w/ ALT+F11): ' .. tostring(varhelper.GetToggle('MeleeMode')));
		gFunc.Message('Low Enmity Mode (toggle w/ CTRL+F9): ' .. tostring(varhelper.GetToggle('LowEnmityMode')));
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
		if(varhelper.GetToggle('UseRefreshIdle') == true) then
			gFunc.EquipSet(sets.Idle_Refresh);
		else
			gFunc.EquipSet(sets.Idle);
		end
	end
	

end

profile.HandleAbility = function()
	local action = gData.GetAction();
	
	if(varhelper.GetToggle('LowEnmityMode') == true) then
		gFunc.EquipSet(sets.EnmityDown);
	end

end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	local spell = gData.GetAction();
	gFunc.EquipSet(sets.FastCast);
	
	if(spell.Name:contains('Cure') or spell.Name:contains('Curaga')) then
		gFunc.Equip('Feet','Cure Clogs');
		gFunc.Equip('Main', 'Rucke\'s Rung');
	
	elseif(varhelper.GetToggle('LowEnmityMode') == true) then
		gFunc.EquipSet(sets.EnmityDown);
	end
end

profile.HandleMidcast = function()
	
	local mndDebuffs = T{'Slow', 'Paralyze', 'Silence'};
	local intDebuffs = T{'Blind', 'Bind', 'Poison', 'Gravity', 'Sleep'};
	local accDebuffs = T{'Silence', 'Bind', 'Gravity'}
	local eleDebuffs = T{'Burn', 'Choke', 'Shock', 'Rasp', 'Drown', 'Frost'};
	local barspells = T{'Barwatera','Barthundra','Barstonra','Barfira','Baraera','Barblizzara'}
    local player = gData.GetPlayer();
    local weather = gData.GetEnvironment();
    local spell = gData.GetAction();
    local target = gData.GetActionTarget();
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0);
	
	if(spell.Skill == 'Enhancing Magic') then
		gFunc.EquipSet(sets.Enhancing);
		if(spell.Name:contains('Regen')) then
			gFunc.Equip('Main', 'Rucke\'s Rung');
			gFunc.Equip('Body','Cleric\'s Bliaut');
		end
		if barspells:contains(spell.Name) then
			gFunc.Equip('Legs', 'Cleric\'s Pantaln.')
			gFunc.Equip('Body', 'Blessed Bliaut')
		end
	
	elseif (spell.Skill == 'Healing Magic') then
		gFunc.EquipSet(sets.Cure);
	elseif (spell.Skill == 'Elemental Magic') then
		gFunc.EquipSet(sets.Nuke);
	elseif (spell.Skill == 'Enfeebling Magic') then
		gFunc.EquipSet(sets.Enfeebling);
		if(mndDebuffs:contains(spell.Name)) then
			gFunc.EquipSet(sets.MND_Enf);
		
		elseif intDebuffs:contains(spell.Name) then
			gFunc.EquipSet(sets.INT_Enf);
		end
		if (spell.Name == 'Silence') then
			gFunc.Equip('Main','Auster\'s Staff');
		elseif (spell.Name == 'Blind') then
			gFunc.Equip('Main','Pluto\'s Staff');
		elseif (spell.Name == 'Paralyze') then
			gFunc.Equip('Main','Aquilo\'s Staff')
		end
		if accDebuffs:contains(spell.Name) then
			gFunc.Equip('Head', 'Nashira Turban')
		end
	elseif (spell.Skill == 'Divine Magic') then
		gFunc.EquipSet(sets.Divine);
		if(spell.Name:contains('Banish')) then
			gFunc.EquipSet(sets.Banish);
			
		end
	else
		gFunc.EquipSet(sets.FastCast);
		
	end
	
	if(varhelper.GetToggle('LowEnmityMode') == true) then
		gFunc.EquipSet(sets.EnmityDown);
	end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()

	ws = gData.GetAction()
	

end

return profile;