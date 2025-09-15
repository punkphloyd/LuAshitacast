local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');
local funcs = gFunc.LoadFile('common/brd_functions.lua')

local Settings = {

	
	CurrentLevel = 0
	
};
local DebuffSongs = T{'Magic Finale', 
					  'Foe Requiem', 'Foe Requiem II', 'Foe Requiem III', 'Foe Requiem IV', 'Foe Requiem V',
					  'Foe Lullaby', 'Horde Lullaby', 
					  'Carnage Elegy', 'Battlefield Elegy',
					  'Wind Threnody', 'Earth Threnody', 'Water Threnody', 'Light Threnody', 'Dark Threnody', 'Fire Threnody', 'Lightning Threnody'
					  };

local brdTables = T{};
brdTables.Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','San d\'Oria-Jeuno Airship','Bastok-Jeuno Airship','Windurst-Jeuno Airship','Kazham-Jeuno Airship','Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library','Western Adoulin','Eastern Adoulin'};


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
	
	HPLow = {
	
		Head = 'Zenith Crown',
		Neck = 'Star Necklace',
		Body = 'Black Cotehardie',
		Hands = 'Errant Cuffs',
		Legs = 'Zenith Slacks',
		Ring1 = 'Serket Ring',
		Ring2 = 'Ether Ring',
		Back = 'Blue Cape',
		Waist = 'Penitent\'s Rope',
		Feet = 'Errant Pigaches'
	
	},
	
	Idle_Priority = {
		
		Main = "Terra\'s Staff",
		--Head = 'Demon Helm +1',
		Neck = 'Peacock Amulet',
		Body = {'Vermillion Cloak', 'Scorpion Harness', 'Raven Jupon'},
		--Body = { 'Scorpion Harness', 'Raven Jupon'},
		Hands = {'Chl. Cuffs +1', 'Raven Bracers','Battle Gloves'},
		Ring1 = 'Minstrel\'s Ring',
		Ring2 = 'Tamas Ring',
		Ear1 = 'Musical Earring',
		Ear2 = 'Singing Earring',
		Back = 'Hexerei Cape',
		Feet = 'Hydra Gaiters'
		
	},
	
	MDT = {
		
		Main = "Terra\'s Staff",
		Neck = 'Jeweled Collar',
		Body = 'Vermillion Cloak',
		Hands = 'Merman\'s Bangles', 
		Ring1 = 'Merman\'s Ring',
		Ring2 = 'Merman\'s Ring',
		Ear1 = 'Merman\'s Earring',
		Ear2 = 'Merman\'s Earring',
		Back = 'Hexerei Cape',
		Feet = 'Hydra Gaiters'
		
	},
	
	Stoneskin_Priority = {
	
		Main = 'Neptune\'s Staff',
		Head = 'Zenith Crown',
		Neck = 'Faith Torque',
		Body = 'Mahatma Hpl.',
		Hands = 'Devotee\'s Mitts',
		Ring1 = 'Kshama Ring No.9',
		Back = 'Prism Cape',
		Waist = 'Penitent\'s Rope',
		Legs = 'Mahatma Slops',
		Feet = 'Suzaku\'s Sune-ate'
		
	},
	
	TP_Priority = {
		Head = 'Optical Hat',
		Neck = 'Peacock Amulet',
		Ear1 = 'Triumph Earring',
		Ear2 = 'Triumph Earring',
		Body = 'Kirin\'s Osode',
		Hands = 'Seiryu\'s Kote',
		Ring1 = 'Flame Ring',
		Ring2 = 'Kshama Ring No.2',
		Waist = 'Swift Belt',
		Legs = 'Byakko\'s Haidate',
		Feet = 'Hydra Gaiters'
		
	},
	
	Cure_Priority = {
		Neck = 'Faith Torque',
		Hands = 'Devotee\'s Mitts',
		Ring1 = 'Kshama Ring No.9',
		Back = 'Prism Cape',
		Waist = 'Penitent\'s Rope',
		Legs = 'Mahatma Slops',
		Feet = 'Suzaku\'s Sune-ate'
	},
	
	
	Town = {
		Head = 'Bard\'s Roundlet',
		Body = 'Sha\'ir Manteel',
		Hands = 'Chl. Cuffs +1',
		Legs = 'Chl. Cannions +1',
		Feet = 'Hydra Gaiters',
		Ear1 = 'Musical Earring',
		Ear2 = 'Singing Earring'
	},
	
	Wind_Priority = {
		
	},
	
	String_Priority = {
	
	},
	
	
	Precast_Priority = {
		Head = 'Genbu\'s Kabuto',
		Ear1 = 'Loquac. Earring',
		Legs = 'Byakko\'s Haidate',
		Waist = 'Swift Belt'
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
	
	SongDebuff_Priority = {
	
		Head = 'Bard\'s Roundlet',
		Neck = 'Wind Torque',
		Body = {'Mahatma Hpl.', 'Minstrel\'s Coat'},
		Ear1 = 'Musical Earring',
		Ear2 = 'Singing Earring',
		Hands = 'Chl. Cuffs +1',
		Ring2 = 'Tamas Ring',
		Back = {'Jester\'s Cape +1'},
		Waist = 'Gleeman\'s Belt',
		Legs = 'Mahatma Slops',
		Feet = 'Sha\'ir Crackows'
	},
	
	Song_FC_Priority = {
		Head = 'Genbu\'s Kabuto',
		Body = 'Sha\'ir Manteel',
		Hands = 'Seiryu\'s Kote',
		Legs = 'Bard\'s Cannions',
		Back = 'Prism Cape',
		Ring1 = 'Minstrel\'s Ring',
		Ear2 = 'Loquac. Earring',
		Ear1 = 'Musical Earring',
		Feet = 'Rostrum Pumps'
	},
	
	Resting_Priority = {
		Main = StaffTable['Dark'],
		Neck = 'Checkered Scarf',
		Body = 'Mahatma Hpl.',
		Ring1 = 'Tamas Ring',
		Ring2 = 'Serket Ring',
		Legs = 'Baron\'s Slops',
		Feet = 'Hydra Gaiters'
	},
	
	SongBuffs_Priority = {
	
		Main = {'Chanter\'s Staff'},
		Head = {'Demon Helm +1', 'Raven Beret'},
		Neck = {'Wind Torque'},
		Ear1 = {'Musical Earring'},
		Ear2 = {'Singing Earring'},
		Body = {'Minstrel\'s Coat','Choral Jstcorps'},
		Hands = {'Chl. Cuffs +1', 'Raven Bracers'},
		Ring1 = {'Minstrel\'s Ring'},
		Ring2 = {'Serket Ring'},
		Back = {'Jester\'s Cape +1'},
		Waist = {'Gleeman\'s Belt', 'Corsette +1'},
		Legs = {'Chl. Cannions +1','Crow Hose'},
		Feet = {'Crow Gaiters'}
	
	},
	
	DynaPre = {
		
		Body = 'Sha\'ir Manteel',
		Ear2 = 'Loquac. Earring',
		Legs = 'Byakko\'s Haidate',
		Waist = 'Swift Belt',
		Feet = 'Rostrum Pumps'
	
	},
	
	Dynamis = {
		Hands = 'Sha\'ir Gages',
		Ear2 = 'Loquac. Earring',
		Waist = 'Swift Belt',
		Legs = 'Byakko\'s Haidate',
		Feet = 'Rostrum Pumps'
	},
	
	Weakened = {
		
		Head = 'Zenith Crown',
		Body = 'Kirin\'s Osode',
		Ear2 = 'Loquac. Earring',
		Hands = 'Zenith Mitts',
		Ring1 = 'Ether Ring',
		Ring2 = 'Serket Ring',
		Back = 'Hexerei Cape',
		Legs = 'Zenith Slacks',
		Feet = 'Rostrum Pumps'
	}
};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	varhelper.Initialize();
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /brd /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /dyna /brd Dynamis');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /mdt /brd MDT');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /def /brd DEF');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /craft /brd Crafting');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /digging /brd Digging');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /helm /brd HELM');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /weak /brd Weakened');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F11 /brd String');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /string /brd String');
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /brd Report');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F9 /brd HPLow');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F11 /brd Gods');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /gods /brd Gods');
	AshitaCore:GetChatManager():QueueCommand(1, "/lockstyleset 4");
	
	
	varhelper.Initialize();
	
	varhelper.CreateCycle('Idle', {[1] = 'Default', [2] = 'MDT', [3] = 'Digging', [4] = 'Crafting', [5] = 'HELM'});
	varhelper.CreateToggle('ForceString',false);
	varhelper.CreateToggle('Gods',false);
	varhelper.CreateToggle('Dynamis',false);
	varhelper.CreateToggle('Weakened',false);
	
	AshitaCore:GetChatManager():QueueCommand(1, '/macro book 2');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
end

profile.OnUnload = function()

	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /brd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /weak');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /dyna');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /mdt');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /craft');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /digging');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /helm');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /string');
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /gods');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F11');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F11');
	
	varhelper.Destroy();
end

profile.HandleCommand = function(args)


	if(args[1] == 'HPLow') then
		
		AshitaCore:GetChatManager():QueueCommand(-1, '/lac set HPLow 1');
		AshitaCore:GetChatManager():QueueCommand(-1, '/lac set Song_FC 1');
	end
	
	if(args[1] == 'Dynamis') then
		varhelper.AdvanceToggle('Dynamis');
	end
	
	if(args[1] == 'Weakened') then
		varhelper.AdvanceToggle('Weakened');
	end
	
	if(args[1] == 'Digging') then
		varhelper.SetCycle('Idle', 3);
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 18');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		
	elseif(args[1] == 'Crafting') then
		varhelper.SetCycle('Idle', 4);
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		
	elseif(args[1] == 'HELM') then
		varhelper.SetCycle('Idle', 5);
		
		AshitaCore:GetChatManager():QueueCommand(1, '/macro book 19');
		AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
		
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		
	elseif(args[1] == 'MDT') then
		varhelper.SetCycle('Idle', 2);
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		
	elseif(args[1] == 'DEF') then
		varhelper.SetCycle('Idle', 1);
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
	
	elseif(args[1] == 'String') then
		varhelper.AdvanceToggle('ForceString'); 
		gFunc.Message('String Mode: ' .. tostring(varhelper.GetToggle('ForceString')));
		
	elseif(args[1] == 'Gods') then
		varhelper.AdvanceToggle('Gods'); 
		gFunc.Message('Gods Mode: ' .. tostring(varhelper.GetToggle('Gods')));
	
	elseif(args[1] == 'Report') then
		gFunc.Message('Idle Mode: ' .. tostring(varhelper.GetCycle('Idle')));
		gFunc.Message('String Mode (toggle w/ CTRL+F11): ' .. tostring(varhelper.GetToggle('ForceString')));
		gFunc.Message('Gods Mode (toggle w/ ALT+F11): ' .. tostring(varhelper.GetToggle('Gods')));
		gFunc.Message('Idle commands: /def /mdt /string /craft /digging /helm');
	end
end

profile.HandleDefault = function()
	local zone = gData.GetEnvironment();
	local mylevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (mylevel ~= Settings.CurrentLevel) then
		gFunc.EvaluateLevels(profile.Sets, mylevel);
		Settings.CurrentLevel = mylevel;
	end
	if (varhelper.GetToggle('Weakened') == true) then
		gFunc.EquipSet(sets.Weakened);
		return
	end
	local player = gData.GetPlayer();
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.TP);
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	else
		if (zone.Area ~= nil and brdTables.Towns:contains(zone.Area)) then
			gFunc.EquipSet(sets.Town)
			if(varhelper.GetCycle('Idle') == 'Digging') then
				gFunc.EquipSet(sets.Digging);
		
	
			elseif(varhelper.GetCycle('Idle') == 'Crafting') then
				gFunc.EquipSet(sets.Crafting);
	
			elseif(varhelper.GetCycle('Idle') == 'HELM') then
				gFunc.EquipSet(sets.HELM);
	
			elseif(varhelper.GetCycle('Idle') == 'MDT') then
				gFunc.EquipSet(sets.MDT);
			end	
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
	
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	
	if (varhelper.GetToggle('Weakened') == true) then
		gFunc.EquipSet(sets.Weakened);
		return
	end
	local spell = gData.GetAction()
	
	if varhelper.GetToggle('Dynamis') == true then
		gFunc.EquipSet(sets.DynaPre);
	else
		if(spell.Type == 'Bard Song') then
			gFunc.EquipSet(sets.Song_FC);
		else 
			gFunc.EquipSet(sets.Precast);
		end

	end
end

profile.HandleMidcast = function()

	if (varhelper.GetToggle('Weakened') == true) then
		gFunc.EquipSet(sets.Weakened);
		return
	end
	local spell = gData.GetAction();
	local mylevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	
	local target = gData.GetActionTarget();
	local instrument = '';
	if varhelper.GetToggle('Dynamis') == true then
		gFunc.Equip('Main',StaffTable['Light']);
		gFunc.EquipSet(sets.Dynamis);
		gFunc.Equip('Range', 'Nursemaid\'s Harp');
		if(spell.Name:contains('Foe Lullaby')) then
			gFunc.Equip('Range','Cornette +2');
		elseif(spell.Name:contains('Threnody')) then
				gFunc.Equip('Range','Piccolo');
				gFunc.Equip('Main', StaffTable[spell.Element]);
		end
		
		
	else 
		gFunc.Equip('Main',StaffTable[spell.Element]);
		if(varhelper.GetToggle('ForceString') == true) then
			gFunc.Equip('Range', 'Ebony Harp +2');
			instrument = funcs.get_instrument_string(spell.Name);
		else
			instrument = funcs.get_instrument(spell.Name);
		end
	
		gFunc.Equip('Range', tostring(instrument));
		gFunc.Message('Instrument ' .. instrument);
		
		if(spell.Type == 'Bard Song') then
			if(DebuffSongs:contains(spell.Name)) then
				gFunc.EquipSet(sets.SongDebuff);
			
				if(varhelper.GetToggle('Gods') == true) then
					gFunc.Equip('Ring1', 'Luftpause Mark');
				end
		
			elseif(target.Type == 'Party' or target.Name == 'Punkphloyd') then
		
				gFunc.EquipSet(sets.SongBuffs);
			
				if(spell.Name:contains('Ballad')) then
					gFunc.Equip('Hands', 'Sha\'ir Gages');
				end
			end
		end
	end
	if(spell.Name == 'Stoneskin') then
			gFunc.EquipSet(sets.Stoneskin);
	end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;