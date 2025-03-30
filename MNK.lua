local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');

local Settings = {

	
	CurrentLevel = 0
	
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
		Ear1 = {'Tor. Earring +1', 'Beetle Earring +1'},
		Ear2 = {'Tor. Earring +1', 'Beetle Earring +1'},
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = {'Amemet Mantle +1', 'Jaguar Mantle', 'Nomad\'s Mantle'},
		Waist = {'Brown Belt', 'Purple Belt'},
		Legs = 'Republic Subligar',
		Feet = {'Fuma Kyahan', 'Fed. Kyahan'}
	},
	
	Town_Priority = {
	
		Head = 'Emperor Hairpin',
		Neck = 'Peacock Amulet',
		Ear1 = 'Wyvern Earring',
		Ear2 = {'Tor. Earring +1', 'Beetle Earring +1'},
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
		Ring1 = 'Verve Ring',
		Ring2 = 'Verve Ring',
		Back = 'Nomad\'s Mantle',
		Waist = 'Warrior\'s Belt +1',
		Legs = 'Republic Subligar',
		Feet = 'Air Solea'
	},
	
	Resting_Priority = {
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
	
	Combo_Priority = {
		Head = {'Temple Crown', 'Emperor Hairpin'},
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = {'Tor. Earring +1', 'Beetle Earring +1'},
		Ear2 = {'Tor. Earring +1', 'Beetle Earring +1'},
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
		Ear1 = {'Tor. Earring +1', 'Beetle Earring +1'},
		Ear2 = {'Tor. Earring +1', 'Beetle Earring +1'},
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
		Ear1 = 'Tor. Earring +1',
		Ear2 = 'Tor. Earring +1',
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Pallas\'s Bracelets','Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = 'Nomad\'s Mantle',
		Waist = {'Life Belt', 'Brown Belt', 'Purple Belt'},
		Legs = 'Republic Subligar',
		Feet = {'Fed. Kyahan'}
	
	},
	
	DragonKick_Priority = {
		Head = {'Temple Crown', 'Emperor Hairpin'},
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = 'Tor. Earring +1',
		Ear2 = 'Tor. Earring +1',
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Pallas\'s Bracelets','Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = 'Nomad\'s Mantle',
		Waist = {'Life Belt', 'Brown Belt', 'Purple Belt'},
		Legs = 'Republic Subligar',
		Feet = {'Fed. Kyahan'}
	
	},
	
	Asuran_Priority = {
		Head = {'Temple Crown', 'Emperor Hairpin'},
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = 'Tor. Earring +1',
		Ear2 = 'Tor. Earring +1',
		Body = {'Scp. Harness +1', 'Jujitsu Gi', 'Power Gi'},
		Hands = {'Pallas\'s Bracelets','Ochiudo\'s Kote', 'Custom M Gloves'},
		Ring1 = 'Rajas Ring',
		Ring2 = {'Sniper\'s Ring +1', 'Venerer Ring', 'Courage Ring'},
		Back = 'Nomad\'s Mantle',
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
	
	
	varhelper.Initialize();
	
	varhelper.CreateToggle('CraftingMode',false);
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /mnk /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F12 /mnk Crafting');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro book 27');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
	AshitaCore:GetChatManager():QueueCommand(1, "/lockstyleset 5");
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
	local zone = gData.GetEnvironment();
	local mylevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (mylevel ~= Settings.CurrentLevel) then
		gFunc.EvaluateLevels(profile.Sets, mylevel);
		Settings.CurrentLevel = mylevel;
	end
	local player = gData.GetPlayer();
	
	local cstance = gData.GetBuffCount('Counterstance');
	if (zone.Area ~= nil and Towns:contains(zone.Area)) then
		gFunc.EquipSet(sets.Town)
		return
	end
	
	if(varhelper.GetToggle('CraftingMode') == true) then
		gFunc.EquipSet(sets.Crafting);
		return
	end
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.TP);
		if (player.SubJob == 'DRG') then
			gFunc.Equip('Ear1', 'Wyvern Earring');
		end
		if cstance == 1 then
			gFunc.Equip('Legs', 'Temple Hose');
		end 
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	else
		gFunc.EquipSet(sets.Idle);
	end
	
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
end

return profile;