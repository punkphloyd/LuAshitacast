local profile = {};


local varhelper = gFunc.LoadFile('common/varhelper.lua');

local Settings = {

	
	CurrentLevel = 0
	
};


local bstTables = T{};

bstTables.BstPetAttack = T{'Foot Kick','Whirl Claws','Big Scissors','Tail Blow','Blockhead','Sensilla Blades','Tegmina Buffet','Lamb Chop','Sheep Charge','Pentapeck','Recoil Dive','Frogkick','Queasyshroom','Numbshroom','Shakeshroom','Nimble Snap','Cyclotail','Somersault','Tickling Tendrils','Sweeping Gouge','Grapple','Double Claw','Spinning Top','Suction','Tortoise Stomp','Power Attack','Rhino Attack','Razor Fang','Claw Cyclone','Crossthrash','Scythe Tail','Ripper Fang','Chomp Rush','Pecking Flurry','Sickle Slash','Mandibular Bite','Wing Slap','Beak Lunge','Head Butt','Wild Oats','Needle Shot','Disembowel','Extirpating Salvo','Mega Scissors','Back Heel','Hoof Volley','Fluid Toss','Fluid Spread'};
bstTables.BstPetMagicAttack = T{'Gloom Spray','Fireball','Acid Spray','Molting Plumage','Cursed Sphere','Nectarous Deluge','Charged Whisker','Nepenthic Plunge'};
bstTables.BstPetMagicAccuracy = T{'Toxic Spit','Acid Spray','Leaf Dagger','Venom Spray','Venom','Dark Spore','Sandblast','Dust Cloud','Stink Bomb','Slug Family','Intimidate','Gloeosuccus','Spider Web','Filamented Hold','Choke Breath','Blaster','Snow Cloud','Roar','Palsy Pollen','Spore','Brain Crush','Choke Breath','Silence Gas','Chaotic Eye','Sheep Song','Soporific','Predatory Glare','Sudden Lunge','Numbing Noise','Jettatura','Bubble Shower','Spoil','Scream','Noisome Powder','Acid Mist','Rhinowrecker','Swooping Frenzy','Venom Shower','Corrosive Ooze','Spiral Spin','Infrasonics','Hi-Freq Field','Purulent Ooze','Foul Waters','Sandpit','Infected Leech','Pestilent Plume'};
bstTables.Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','San d\'Oria-Jeuno Airship','Bastok-Jeuno Airship','Windurst-Jeuno Airship','Kazham-Jeuno Airship','Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library','Western Adoulin','Eastern Adoulin'};


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
	
	
	Idle_Priority = {
		Head = {'Celata', 'Luisant Salade'},
		Neck = 'Peacock Amulet',
		Ear1 = {'Beastly Earring', 'Melody Earring'},
		Ear2 = {'Geist Earring'},
		Body = 'Kirin\'s Osode',
		Hands = 'Thick Mufflers',
		Ring1 = 'Venerer Ring',
		Ring2 = 'Kshama Ring No.2',
		Back = 'Amemet Mantle',
		Waist = 'Life Belt',
		Legs = 'Thick Breeches',
		Feet = 'Thick Sollerets +1'
	},
	
	MPMode = {
		Ring1 = 'Tamas Ring',
		Ring2 = 'Ether Ring'
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
		Ring1 = 'Ether Ring',
		Ring2 = 'Tamas Ring',
	},
	
	Rest_Default = {
	
		Legs = 'Monster Trousers'
	},
	
	TP_Default = {
		Head = 'Celata',
		Neck = 'Peacock Amulet',
		Ear1 = 'Beastly Earring',
		Ear2 = 'Spike Earring',
		Body = 'Kirin\'s Osode',
		Hands = 'Thick Mufflers',
		Ring1 = 'Venerer Ring',
		Ring2 = 'Kshama Ring No.2',
		Back = 'Amemet Mantle',
		Waist = 'Life Belt',
		Legs = 'Thick Breeches',
		Feet = 'Thick Sollerets +1'
	},
	
	TP_Acc = {
		Head = 'Celata',
		Neck = 'Peacock Amulet',
		Ear1 = 'Beastly Earring',
		Ear2 = 'Spike Earring',
		Body = 'Kirin\'s Osode',
		Hands = 'Thick Mufflers',
		Ring1 = 'Venerer Ring',
		Ring2 = 'Kshama Ring No.2',
		Back = 'Amemet Mantle',
		Waist = 'Life Belt',
		Legs = 'Thick Breeches',
		Feet = 'Thick Sollerets +1'
	},
	
	TP_Eva = {
		Head = 'Celata',
		Neck = 'Peacock Amulet',
		Ear1 = 'Beastly Earring',
		Ear2 = 'Spike Earring',
		Body = 'Kirin\'s Osode',
		Hands = 'Thick Mufflers',
		Ring1 = 'Venerer Ring',
		Ring2 = 'Kshama Ring No.2',
		Back = 'Amemet Mantle',
		Waist = 'Life Belt',
		Legs = 'Thick Breeches',
		Feet = 'Thick Sollerets +1'
	},
	
	FastCast = {
		Head = 'Panther Mask'
	},
	
	Reward = {
		Head = 'Beast Helm',
		Neck = 'Justice Badge',
		Body = "Beast Jackcoat",
		Hands = 'Ogre Gloves',
		Feet = "Monster Gaiters"
	},
	
	Rampage = { -- 5x attack, STR: 50% 
	
		Head = '',
		Neck = 'Peacock Amulet',
		Ear1 = 'Beastly Earring',
		Ear2 = '',
		Body = {'Haubergeon +1', 'Scorpion Harness'},
		Hands = '',
		Ring1 = 'Sniper\'s Ring',
		Ring2 = 'Kshama Ring No.2',
		Back = '',
		Waist = 'Life Belt',
		Legs = '',
		Feet = ''
	},
	
	Mistral = { -- STR: 50%
	
		Head = '',
		Neck = '',
		Ear1 = 'Beastly Earring',
		Ear2 = '',
		Body = {'Haubergeon +1', 'Scorpion Harness'},
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	},
	
	
	Calamity = { -- STR: 50%, VIT: 50%
	
		Head = '',
		Neck = '',
		Ear1 = 'Beastly Earring',
		Ear2 = '',
		Body = {'Haubergeon +1', 'Scorpion Harness'},
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	},
	
	Decimator = { -- 3x attack, STR: 50%
	
		Head = '',
		Neck = '',
		Ear1 = 'Beastly Earring',
		Ear2 = '',
		Body = {'Haubergeon +1', 'Scorpion Harness'},
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	},
	
	WS = {
	
		Head = '',
		Neck = '',
		Ear1 = 'Beastly Earring',
		Ear2 = '',
		Body = {'Haubergeon +1', 'Scorpion Harness'},
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	},
	
	Charm_Accuracy = {
		Head = 'Panther Mask',
		Ear1 = 'Beastly Earring',
		Neck = 'Bird Whistle',
		Body = 'Beast Jackcoat',
		Hands = 'Beast Gloves',
		Ring1 = 'Angel\'s Ring',
		Ring2 = 'Angel\'s Ring',
		Waist = 'Corsette',
		Legs = 'Beast Trousers',
		Feet = 'Beast Gaiters'
	},
	
	Charm_Duration = {
		Head = 'Beast Helm',
		Ear1 = 'Beastly Earring',
		Neck = 'Bird Whistle',
		Body = 'Beast Jackcoat',
		Hands = 'Beast Gloves',
		Ring1 = 'Angel\'s Ring',
		Ring2 = 'Angel\'s Ring',
		Waist = 'Corsette',
		Legs = 'Beast Trousers',
		Feet = 'Beast Gaiters'
	},
	
	Pet_Only_Tp = {
		Head = '',
		Neck = '',
		Ear1 = 'Beastly Earring',
		Ear2 = '',
		Body = '',
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	}
	
};


profile.Sets = sets;


local function HandlePetAction(PetAction)
    gFunc.EquipSet(sets.PetReadyDefault);
	if (bstTables.BstPetAttack:contains(PetAction.Name)) then
        gFunc.EquipSet(sets.PetAttack);
	elseif (bstTables.BstPetMagicAttack:contains(PetAction.Name)) then
        gFunc.EquipSet(sets.PetMagicAttack);
	elseif (bstTables.BstPetMagicAccuracy:contains(PetAction.Name)) then
        gFunc.EquipSet(sets.PetMagicAccuracy);
    end
end


profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	
-- @ = Windows Key
-- % = Works only when text bar not up.
-- ^ = Control Key
-- ! = Alt Key
-- # - Apps Key
-- ~ = Shift Key (possibly, not confirmed)
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F9 /lac fwd Reward');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F9 /lac fwd Charm');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F10 /lac fwd TP');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /lac fwd Report');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F12 /lac fwd Digging');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind @F12 /lac fwd HELM');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F12 /lac fwd Crafting');
	
	

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 8');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
	
	
	varhelper.Initialize();
	
	varhelper.CreateToggle('DiggingMode',false);
	varhelper.CreateToggle('CraftingMode',false);
	varhelper.CreateToggle('HELMMode',false);
	varhelper.CreateCycle('RewardMode', {[1] = 'Alpha', [2] = 'Beta', [3] = 'Gamma', [4] = 'Delta', [5] = 'Epsilon', [6] = 'Zeta'});
	varhelper.CreateCycle('CharmMode',{[1] = 'Duration', [2] = 'Accuracy'});
	varhelper.CreateCycle('TPMode', {[1] = 'Default', [2] = 'Acc', [3] = 'Eva'});
	
end

profile.OnUnload = function()

	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F10');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F9');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @F12');
	
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
	
	elseif(args[1] == 'TP') then
		varhelper.AdvanceCycle('TPMode');
		gFunc.Message('TP Type: ' .. tostring(varhelper.GetCycle('TPMode')));
	
	elseif(args[1] == 'Charm') then
		varhelper.AdvanceCycle('CharmMode');
		gFunc.Message('Charm Mode: ' .. tostring(varhelper.GetCycle('CharmMode')));
		
	elseif(args[1] == 'Reward') then
		varhelper.AdvanceCycle('RewardMode')
		gFunc.Message('Reward Mode: ' .. tostring(varhelper.GetCycle('RewardMode')))
		
	elseif(args[1] == 'Report') then
		gFunc.Message('Digging Mode (toggle w/ CTRL+F12): ' .. tostring(varhelper.GetToggle('DiggingMode')));
		gFunc.Message('Crafting Mode (toggle w/ ALT+F12): ' .. tostring(varhelper.GetToggle('CraftingMode')));
		gFunc.Message('HELM Mode (toggle w/ WIN+F12): ' .. tostring(varhelper.GetToggle('HELMMode')));
		gFunc.Message('Food Type (cycle w/ CTRL+F9): ' .. tostring(varhelper.GetCycle('RewardMode'))) 
		gFunc.Message('Charm Type (cycle w/ ALT+F9): ' .. tostring(varhelper.GetCycle('CharmMode')));
		gFunc.Message('TP Type (cycle w/ CTRL+F10): ' .. tostring(varhelper.GetCycle('TPMode')));
	end
	
	
	
end

profile.HandleDefault = function()

	local pet = gData.GetPet();
	local petAction = gData.GetPetAction();
	
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
        gFunc.EquipSet('TP_' .. tostring(varhelper.GetCycle('TPMode')));
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	else
		gFunc.EquipSet(sets.Idle);
	end
	
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	
	if(action.Name == 'Reward') then
		gFunc.EquipSet(sets.Reward);
		gFunc.Equip('Ammo', 'Pet Food ' .. tostring(varhelper.GetCycle('RewardMode')));
	elseif(action.Name == 'Charm') then
		gFunc.EquipSet('Charm_' .. CharmTable[Settings.CharmType]);
	else
		gFunc.EquipSet(sets.Idle);
	end

end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
	gFunc.EquipSet(sets.FastCast);
end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();

    if (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Enhancing);

        if string.match(spell.Name, 'Phalanx') then
            gFunc.EquipSet(sets.Phalanx);
        elseif string.match(spell.Name, 'Stoneskin') then
            gFunc.EquipSet(sets.Stoneskin);
        elseif string.contains(spell.Name, 'Refresh') then
            gFunc.EquipSet(sets.Refresh);
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure);
    elseif (spell.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.Enfeebling);
    end
	
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
	local action = gData.GetAction();
    if (action.Name == 'Rampage') then
        gFunc.EquipSet(sets.Rampage);
    elseif (action.Name == 'Mistral Axe') then
        gFunc.EquipSet(sets.Mistral);
    elseif (action.Name == 'Calamity') then
        gFunc.EquipSet(sets.Calamity);
    elseif (action.Name == 'Decimator') then
        gFunc.EquipSet(sets.Decimator);
	else
        gFunc.EquipSet(sets.WS);
    end
end

return profile;