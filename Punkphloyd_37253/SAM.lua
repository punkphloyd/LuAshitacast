local profile = {};

local blmTables = T{};

blmTables.Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','San d\'Oria-Jeuno Airship','Bastok-Jeuno Airship','Windurst-Jeuno Airship','Kazham-Jeuno Airship','Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library','Western Adoulin','Eastern Adoulin'};

local varhelper = gFunc.LoadFile('common/varhelper.lua');

local Settings = {

	CurrentLevel = 0;
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
	
	Town = {
		Head = 'Emperor Hairpin',
		Body = 'Blacksmith\'s Apn.',
		Hands = 'Smithy\'s Mitts',
		Back = 'Nomad\'s Mantle',
		Feet = 'Fuma Kyahan'
	},
	
	Idle_Priority = {
		Head = 'Emperor Hairpin',
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = 'Pigeon Earring',
		Ear2 = 'Dodge Earring',
		Body = 'Iron Scale Mail',
		Hands = 'Ryl.Sqr. Mufflers',
		Ring1 = {'Sniper\'s Ring +1', 'Puissance Ring', 'Courage Ring'},
		Ring2 = {'Rajas Ring', 'Courage Ring'},
		Back = 'Nomad\'s Mantle',
		Waist = 'Warrior\'s Belt +1',
		Legs = 'Republic Subligar',
		Feet = {'Fuma Kyahan', 'Federation Kyahan'}
	},
	
	TP_Priority = {
		Head = 'Emperor Hairpin',
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = 'Beetle Earring +1',
		Ear2 = 'Beetle Earring +1',
		Body = {'Jujitsu Gi', 'Power Gi'},
		Hands = 'Ochiudo\'s Kote',
		Ring1 = {'Sniper\'s Ring +1', 'Puissance Ring', 'Courage Ring'},
		Ring2 = {'Rajas Ring', 'Courage Ring'},
		Back = 'Nomad\'s Mantle',
		Waist = 'Brave Belt',
		Legs = 'Republic Subligar',
		Feet = {'Fuma Kyahan', 'Federation Kyahan'}
	},
	
	WS_Priority = {
		Head = 'Emperor Hairpin',
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = 'Beetle Earring +1',
		Ear2 = 'Beetle Earring +1',
		Body = {'Jujitsu Gi', 'Power Gi'},
		Hands = 'Ochiudo\'s Kote',
		Ring1 = {'Sniper\'s Ring +1', 'Puissance Ring', 'Courage Ring'},
		Ring2 = {'Rajas Ring', 'Courage Ring'},
		Back = 'Nomad\'s Mantle',
		Waist = 'Brave Belt',
		Legs = 'Republic Subligar',
		Feet = {'Fuma Kyahan', 'Federation Kyahan'}
	},
	
	Digging = {
		Body = 'Choc. Jack Coat',
		Hands = 'Chocobo Gloves',
		Legs = 'Chocobo Hose',
		Feet = 'Chocobo Boots'
	},
	
	Resting_Priority = {
		Head = 'Emperor Hairpin',
		Neck = {'Peacock Amulet', 'Spike Necklace'},
		Ear1 = 'Pigeon Earring',
		Ear2 = 'Dodge Earring',
		Body = 'Iron Scale Mail',
		Hands = 'Ryl.Sqr. Mufflers',
		Ring1 = {'Sniper\'s Ring +1', 'Puissance Ring', 'Courage Ring'},
		Ring2 = {'Rajas Ring', 'Courage Ring'},
		Back = 'Nomad\'s Mantle',
		Waist = 'Warrior\'s Belt +1',
		Legs = 'Republic Subligar',
		Feet = 'Federation Kyahan'
	},
	
	Nuke_Priority = {
	
	},
	
	
	Enfeebling_Priority = {
	
	},
	
	Dark_Priority = {
	
	},
	
	Precast = {
	
	},
	
	Utsu = {
	
	
	}
};


profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /sam /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F12 /sam Digging');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F12 /sam Crafting');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /sam Report');
	
	varhelper.Initialize();
	
	varhelper.CreateToggle('DiggingMode',false);
	varhelper.CreateToggle('CraftingMode',false);
	varhelper.CreateToggle('SoloMode',false);
	AshitaCore:GetChatManager():QueueCommand(1, '/macro book 16');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
end

profile.OnUnload = function()

	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /sam');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F12');
	varhelper.Destroy();
end

profile.HandleCommand = function(args)
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
	
	
	
	elseif(args[1] == 'Report') then
		gFunc.Message('Digging Mode (toggle w/ CTRL+F12): ' .. tostring(varhelper.GetToggle('DiggingMode')));
		gFunc.Message('Crafting Mode (toggle w/ ALT+F12): ' .. tostring(varhelper.GetToggle('CraftingMode')));
		gFunc.Message('Solo Mode (toggle w/ ALT+F11): ' .. tostring(varhelper.GetToggle('SoloMode')));
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
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.TP);
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	else
		gFunc.EquipSet(sets.Idle);
	end
	
	
	local zone = gData.GetEnvironment();
	if (zone.Area ~= nil and blmTables.Towns:contains(zone.Area)) then
		gFunc.EquipSet(sets.Town)
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
	
    local player = gData.GetPlayer();
    local weather = gData.GetEnvironment();
    local spell = gData.GetAction();
    local target = gData.GetActionTarget();
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0);
	

end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()

end

return profile;