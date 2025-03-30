local profile = {};


local varhelper = gFunc.LoadFile('common/varhelper.lua');
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');


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
	
	Steal = {
	
		Head = 'Rogue\'s Bonnet',
		Hands = 'Rogue\'s Armlets',
		Legs = 'Assassin\'s Culottes',
		Feet = 'Rogue\'s Poulaines'
	},
	
	Idle_Priority = {
	
		Head = 'Optical Hat',
		Neck = 'Peacock Amulet',
		Ear1 = 'Dodge Earring',
		Ear2 = 'Dodge Earring',
		Body = 'Scp. Harness +1',
		Hands = 'War Gloves +1',
		Waist = 'Swift Belt',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Flame Ring',
		Back = 'Nomad\'s Mantle',
		Legs = 'Crow Hose',
		Feet = 'Crow Gaiters'
	},
	
	EVA_Priority = {
	
		Head = 'Optical Hat',
		Neck = 'Peacock Amulet',
		Ear1 = 'Dodge Earring',
		Ear2 = 'Dodge Earring',
		Body = 'Scp. Harness +1',
		Hands = 'War Gloves +1',
		Waist = 'Swift Belt',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Grace Ring',
		Back = 'Nomad\'s Mantle',
		Legs = 'Crow Hose',
		Feet = 'Crow Gaiters'
	},
	
	Melee_Priority = {
	
		Head = 'Homam Zucchetto',
		Neck = 'Peacock Amulet',
		Ear1 = 'Brutal Earring',
		Ear2 = 'Triumph Earring',
		Body = 'Scp. Harness +1',
		Hands = 'Dusk Gloves',
		Waist = 'Swift Belt',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Flame Ring',
		Back = 'Amemet Mantle +1',
		Legs = 'Dusk Trousers +1',
		Feet = 'Homam Gambieras'
	},
	
	SA_Priority = {
	
		Head = 'Emperor Hairpin',
		Neck = 'Spike Necklace',
		Body = 'Blue Cotehardie',
		Hands = 'Custom M Gloves',
		Ear1 = 'Triumph Earring',
		Ear2 = 'Triumph Earring',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Grace Ring',
		Legs = 'Noct Brais +1',
		Feet = 'Leaping Boots'
	
	},
	
	SAWS_Priority = {
	
		Head = 'Emperor Hairpin',
		Neck = 'Peacock Amulet',
		Ear1 = 'Triumph Earring',
		Ear2 = 'Triumph Earring',
		Body = 'Scp. Harness +1',
		Hands = 'Custom M Gloves',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Grace Ring',
		Legs = 'Noct Brais +1',
		Feet = 'Leaping Boots'
	
	},
	
	TA_Priority = {
	
	
		Head = 'Emperor Hairpin',
		Ear1 = 'Drone Earring',
		Ear2 = 'Drone Earring',
		Body = 'Blue Cotehardie',
		Back = 'Nomad\'s Mantle',
		Legs = 'Republic Subligar',
		Feet = 'Leaping Boots'
	},
	
	TAWS_Priority = {
	
		Head = 'Emperor Hairpin',
		Neck = 'Peacock Amulet',
		Body = 'Scp. Harness +1',
		Ear1 = 'Drone Earring',
		Ear2 = 'Drone Earring',
		Back = 'Nomad\'s Mantle',
		Legs = 'Republic Subligar',
		Feet = 'Leaping Boots'
	
	},
	
	SATA_Priority = {
	
		Head = 'Emperor Hairpin',
		Neck = 'Spike Necklace',
		Ear1 = 'Drone Earring',
		Ear2 = 'Drone Earring',
		Body = 'Blue Cotehardie',
		Hands = 'Custom M Gloves',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Grace Ring',
		Back = 'Nomad\'s Mantle',
		Legs = 'Noct Brais +1',
		Feet = 'Leaping Boots'
	},
	
	SATAWS_Priority = {
	
		Head = 'Emperor Hairpin',
		Neck = 'Peacock Amulet',
		Ear1 = 'Drone Earring',
		Ear2 = 'Drone Earring',
		Body = 'Scp. Harness +1',
		Hands = 'Custom M Gloves',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Grace Ring',
		Back = 'Nomad\'s Mantle',
		Legs = 'Noct Brais +1',
		Feet = 'Leaping Boots'
	},
	
	WSDex_Priority = {
	
		Ear1 = 'Triumph Earring',
		Ear2 = 'Triumph Earring',
		Head = 'Optical Hat',
		Hands = 'War Gloves +1',
	},
	
	Recast_Priority = {
	
		Head = 'Homam Zucchetto',
		Hands = 'Dusk Gloves',
		Feet = 'Homam Gambieras',
		Waist = 'Swift Belt',
		Ear1 = 'Loquac. Earring'
	
	},
	
	Precast_Priority = {
	
		Head = 'Homam Zucchetto',
		Hands = 'Dusk Gloves',
		Feet = 'Homam Gambieras',
		Waist = 'Swift Belt',
		Ear1 = 'Loquac. Earring'
	
	},
	
	Resting_Priority = {
	
	},
	
	Preshot_Priority = {
		Head = 'Optical Hat',
		Neck = 'Peacock Amulet',
		Ear1 = 'Triumph Earring',
		Ear2 = 'Triumph Earring',
		Body = 'Noct Doublet +1',
		Hands = 'Noct Gloves +1',
		Ring1 = 'Behemoth Ring',
		Ring2 = 'Behemoth Ring +1',
		Back = {'Amemet Mantle +1', 'Nomad\'s Mantle'},
		Waist = 'Mrc.Cpt. Belt',
		Legs = 'Dusk Trousers +1',
		Feet = 'Homam Gambieras'
	
	},
	
	Ranged_Priority = {
		Head = 'Optical Hat',
		Neck = 'Peacock Amulet',
		Ear1 = 'Triumph Earring',
		Ear2 = 'Triumph Earring',
		Body = 'Noct Doublet +1',
		Hands = 'Noct Gloves +1',
		Ring1 = 'Behemoth Ring',
		Ring2 = 'Behemoth Ring +1',
		Back = {'Amemet Mantle +1', 'Nomad\'s Mantle'},
		Waist = 'Mrc.Cpt. Belt',
		Legs = 'Dusk Trousers +1',
		Feet = 'Homam Gambieras'
	
	},
	
	
	
	INT_Priority = {
        Head = 'Rogue\'s Bonnet',
        Neck = 'Prudence Torque',
        Body = 'Blue Cotehardie',
        Ring1 = 'Snow Ring',
        Ring2 = 'Snow Ring',
        Waist = 'Mrc.Cpt. Belt',
        Legs = 'Mage\'s Slacks',
        Feet = 'Custom M Boots',
	
	},
	
	EnmityDown_Priority = {
	
	}
	};


profile.Sets = sets;




profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	
-- @ = Windows Key
-- % = Works only when text bar not up.
-- ^ = Control Key
-- ! = Alt Key
-- # - Apps Key
-- ~ = Shift Key (possibly, not confirmed)
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /thf /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F12 /thf Digging');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind @F12 /thf HELM');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F12 /thf Crafting');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F9 /thf Evasion');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /thf Report');

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 7');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
	
	
	varhelper.Initialize();
	
	varhelper.CreateToggle('DiggingMode',false);
	varhelper.CreateToggle('CraftingMode',false);
	varhelper.CreateToggle('HELMMode',false);
	varhelper.CreateToggle('Bloody', false);
	varhelper.CreateToggle('Evasion', false);
	
end

profile.OnUnload = function()

	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /thf');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F9');
	
	varhelper.Destroy();

end

profile.HandleCommand = function(args)
	--if not bstTables.AliasList:contains(args[1]) then return end
	
	local player = gData.GetPlayer();
	local toggle = nil;
	local status = nil;
	
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
	
	elseif(args[1] == 'Bloody') then
		varhelper.AdvanceToggle('Bloody');
		gFunc.Message('Bloody Bolts: ' .. tostring(varhelper.GetToggle('Bloody')));
	
	elseif(args[1] == 'Evasion') then
		varhelper.AdvanceToggle('Evasion');
		gFunc.Message('Evasion Mode: ' .. tostring(varhelper.GetToggle('Evasion')));
	
		
	elseif(args[1] == 'Report') then
		gFunc.Message('Digging Mode (toggle w/ CTRL+F12): ' .. tostring(varhelper.GetToggle('DiggingMode')));
		gFunc.Message('Crafting Mode (toggle w/ ALT+F12): ' .. tostring(varhelper.GetToggle('CraftingMode')));
		gFunc.Message('HELM Mode (toggle w/ WIN+F12): ' .. tostring(varhelper.GetToggle('HELMMode')));
		gFunc.Message('Evasion Mode (toggle w/ CTRL+F9): ' .. tostring(varhelper.GetToggle('Evasion')));
	end
	
	
	
end

profile.HandleDefault = function()
	local mylevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (mylevel ~= Settings.CurrentLevel) then
		gFunc.EvaluateLevels(profile.Sets, mylevel);
		Settings.CurrentLevel = mylevel;
	end
	
	local sa = gData.GetBuffCount('Sneak Attack');
	local ta = gData.GetBuffCount('Trick Attack');
	
	
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
		if sa == 1 and ta == 1 then
			gFunc.EquipSet('SATA');
		elseif sa == 1 then
			gFunc.EquipSet('SA');
		elseif ta == 1 then
			gFunc.EquipSet('TA');
		elseif (varhelper.GetToggle('Evasion') == true) then
			gFunc.EquipSet('EVA');
		else
			gFunc.EquipSet('Melee')
		end
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	else
		gFunc.EquipSet(sets.Idle);
	end
	
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	
	if action.Name == 'Steal' then
		gFunc.EquipSet(sets.Steal)
	end
	if action.Name == 'Flee' then
		gFunc.Equip('Feet','Rogue\'s Poulaines')
	end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
	gFunc.EquipSet(sets.Precast);
end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();
	if spell.Name:contains('Utsusemi') then
		gFunc.EquipSet(sets.Recast);
	end

	
end

profile.HandlePreshot = function()
    gFunc.EquipSet(sets.Preshot);
    gFunc.SetMidDelay(1.0);
end

profile.HandleMidshot = function()
	
    gFunc.EquipSet(sets.Ranged);
	if varhelper.GetToggle('Bloody') then
		gFunc.EquipSet(sets.INT)
	end
	
end

profile.HandleWeaponskill = function()
	local action = gData.GetAction();
    local sa = gData.GetBuffCount('Sneak Attack');
    local ta = gData.GetBuffCount('Trick Attack');

    if (sa == 1 and ta == 1) then
        gFunc.EquipSet(sets.SATAWS);
    elseif (sa == 1) then
        gFunc.EquipSet(sets.SAWS);
    elseif (ta == 1) then
        gFunc.EquipSet(sets.TAWS);
    else
        if (action.Name == 'Shark Bite' or action.Name == 'Dancing Edge' or action.Name == 'Evisceration') then
            gFunc.EquipSet(sets.WSDex);
        end
    end
	
	if (action.Name == 'Shark Bite' or action.Name == 'Dancing Edge') then
		gFunc.Equip('Neck', 'Breeze Gorget');
	end	
end

return profile;