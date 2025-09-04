local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');

local Settings = {

	CurrentLevel = 0;
}

local mp_thresholds = {

	['Tank'] = 183,
	['DD'] = 183

};

local mp_set_options = {
	
	['Tank'] = {
	
		Neck = 'Holy Phial',
		Ring1 = 'Astral Ring',
		Ring2 = 'Astral Ring',
		Waist = 'Friar\'s Rope',
		Legs = 'Custom Slacks',
		Feet = 'Custom M Boots'
	
	},
	
	['DD'] = {
	
		Neck = 'Holy Phial',
		Ring1 = 'Astral Ring',
		Ring2 = 'Astral Ring',
		Waist = 'Friar\'s Rope',
		Legs = 'Custom Slacks',
		Feet = 'Custom M Boots'
	
	},

}

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
	
	
	FastCast_Priority = {
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
	
	
	Enmity_Priority = {
		Head = 'Cache-nez',
		Neck = 'Holy Phial',
		Ear1 = '',
		Ear2 = '',
		Body = '',
		Hands = 'Devotee\'s Mitts',
		Ring1 = 'Astral Ring',
		Ring2 = 'Astral Ring',
		Back = 'High Brth. Mantle',
		Waist = 'Friar\'s Rope',
		Legs = 'Custom Slacks',
		Feet = 'Custom M Boots'
	},
	
	
	Resting_Priority = {
		Head = 'Cache-nez',
		Neck = 'Holy Phial',
		Ear1 = 'Pigeon Earring',
		Ear2 = 'Pigeon Earring',
		Body = 'Custom Tunic',
		Hands = 'Devotee\'s Mitts',
		Ring1 = 'Astral Ring',
		Ring2 = 'Astral Ring',
		Back = 'High Brth. Mantle',
		Waist = 'Friar\'s Rope',
		Legs = 'Custom Slacks',
		Feet = 'Custom M Boots'
	},
	
	Idle_Priority = {
	
		Head =  {'Luisant Salade', 'Kampfschaller'},
		Neck = {'Medieval Collar', 'Holy Phial'},
		Ear1 = 'Pigeon Earring',
		Ear2 = 'Pigeon Earring',
		Body = {'Luisant Haubert', 'Kampfbrust'},
		Hands = {'Luisant Moufles', 'Kampfhentzes'},
		Ring1 = {'Verve Ring', 'Stamina Ring'},
		Ring2 = {'Verve Ring', 'Stamina Ring'},
		Back = 'High Brth. Mantle',
		Waist = 'Warrior\'s Belt +1',
		Legs = {'Luisant Brayettes', 'Kampfdiechlings'},
		Feet = {'Luisant Sollerets', 'Kampfschuhs'}
	},
	
	MPEff_Priority = {
	
		Head =  {'Luisant Salade', 'Kampfschaller'},
		Neck = 'Holy Phial',
		Ear1 = 'Pigeon Earring',
		Ear2 = 'Pigeon Earring',
		Body = {'Luisant Haubert', 'Kampfbrust'},
		Hands = {'Luisant Moufles', 'Kampfhentzes'},
		Ring1 = 'Astral Ring',
		Ring2 = 'Astral Ring',
		Back = 'High Brth. Mantle',
		Waist = 'Friar\'s Rope',
		Legs = 'Custom Slacks',
		Feet = 'Custom M Boots'
	},
	
	
	DD_Priority = {
	
		Head = {'Luisant Salade', 'Emperor Hairpin'},
		Neck = 'Peacock Amulet',
		Ear1 = 'Beetle Earring +1',
		Ear2 = 'Beetle Earring +1',
		Body = {'Haubergeon', 'Scorpion Harness', 'Luisant Haubert', 'Kampfbrust' , 'Chain Mail +1' },
		Hands = {'Luisant Moufles', 'Ryl.Sqr. Mufflers'},
		Ring1 = {'Sniper\'s Ring +1', 'Courage Ring'},
		Ring2 = 'Rajas Ring',
		Back = 'High Brth. Mantle',
		Waist = 'Brave Belt',
		Legs = 'Republic Subligar',
		Feet = {'Luisant Sollerets', 'Kampfschuhs'}
	},
	
	
	Tank_Priority = {
	
		Head =  {'Luisant Salade', 'Kampfschaller'},
		Neck = {'Medieval Collar', 'Holy Phial'},
		Ear1 = 'Pigeon Earring',
		Ear2 = 'Pigeon Earring',
		Body = {'Luisant Haubert', 'Kampfbrust'},
		Hands = {'Luisant Moufles', 'Kampfhentzes'},
		Ring1 = {'Verve Ring', 'Stamina Ring'},
		Ring2 = {'Verve Ring', 'Stamina Ring'},
		Back = 'High Brth. Mantle',
		Waist = 'Warrior\'s Belt +1',
		Legs = {'Luisant Brayettes', 'Kampfdiechlings'},
		Feet = {'Luisant Sollerets', 'Kampfschuhs'}
	},
	
	Hybrid_Priority = {
	
		Head =  {'Luisant Salade', 'Kampfschaller'},
		Neck = 'Peacock Amulet',
		Ear1 = 'Pigeon Earring',
		Ear2 = 'Pigeon Earring',
		Body = {'Haubergeon', 'Scorpion Harness', 'Luisant Haubert', 'Kampfbrust' , 'Chain Mail +1' },
		Hands = {'Luisant Moufles', 'Kampfhentzes'},
		Ring1 = {'Verve Ring', 'Stamina Ring'},
		Ring2 = {'Verve Ring', 'Stamina Ring'},
		Back = 'High Brth. Mantle',
		Waist = 'Warrior\'s Belt +1',
		Legs = {'Luisant Brayettes', 'Kampfdiechlings'},
		Feet = {'Luisant Sollerets', 'Kampfschuhs'}
	
	},
	
	
	SelfCure_Priority = {
		Head = 'Cache-nez',
		Neck = 'Holy Phial',
		Ear1 = '',
		Ear2 = '',
		Body = '',
		Hands = 'Devotee\'s Mitts',
		Ring1 = '',
		Ring2 = '',
		Back = 'High Brth. Mantle',
		Waist = 'Friar\'s Rope',
		Legs = 'Custom Slacks',
		Feet = ''
	},
	
	
	OtherCure_Priority = {
		Head = 'Cache-nez',
		Neck = 'Holy Phial',
		Ear1 = '',
		Ear2 = '',
		Body = '',
		Hands = 'Devotee\'s Mitts',
		Ring1 = '',
		Ring2 = '',
		Back = 'High Brth. Mantle',
		Waist = 'Friar\'s Rope',
		Legs = 'Custom Slacks',
		Feet = ''
	},
	
	SwordWS_Priority = {
	
		Head = {'Luisant Salade', 'Emperor Hairpin'},
		Neck = 'Peacock Amulet',
		Ear1 = 'Beetle Earring +1',
		Ear2 = 'Beetle Earring +1',
		Body = {'Haubergeon', 'Scorpion Harness', 'Luisant Haubert', 'Kampfbrust' , 'Chain Mail +1' },
		Hands = {'Luisant Moufles', 'Ryl.Sqr. Mufflers'},
		Ring1 = {'Sniper\'s Ring +1', 'Courage Ring'},
		Ring2 = 'Rajas Ring',
		Back = 'High Brth. Mantle',
		Waist = 'Brave Belt',
		Legs = 'Republic Subligar',
		Feet = {'Luisant Sollerets', 'Kampfschuhs'}
	
	},
	
	ClubWS_Priority = {
	
		Head = {'Luisant Salade', 'Emperor Hairpin'},
		Neck = 'Peacock Amulet',
		Ear1 = 'Beetle Earring +1',
		Ear2 = 'Beetle Earring +1',
		Body = {'Haubergeon', 'Scorpion Harness', 'Luisant Haubert', 'Kampfbrust' , 'Chain Mail +1' },
		Hands = {'Luisant Moufles', 'Ryl.Sqr. Mufflers'},
		Ring1 = {'Sniper\'s Ring +1', 'Courage Ring'},
		Ring2 = 'Rajas Ring',
		Back = 'High Brth. Mantle',
		Waist = 'Brave Belt',
		Legs = 'Republic Subligar',
		Feet = {'Luisant Sollerets', 'Kampfschuhs'}
	
	}
	
	
	
};

profile.Sets = sets;

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
	AshitaCore:GetChatManager():QueueCommand(-1,'/alias /pld /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1,'/alias /eff /lac fwd eff');
	AshitaCore:GetChatManager():QueueCommand(-1,'/lac disable Main');
	AshitaCore:GetChatManager():QueueCommand(-1,'/lac disable Sub');
	
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F9 /pld TPMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /pld Report');
	varhelper.Initialize();
	varhelper.CreateToggle('WeaponLock',true);
	varhelper.CreateCycle('TPMode', { [1] = 'Tank', [2] = 'DD', [3] = 'Hybrid'});
	varhelper.CreateToggle('Efficiency', false);
	
	AshitaCore:GetChatManager():QueueCommand(1, "/lockstyleset 6");
	AshitaCore:GetChatManager():QueueCommand(1, '/macro book 6');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
end

profile.OnUnload = function()

	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /pld');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F9');

	varhelper.Destroy();

end


profile.HandleCommand = function(args)
	
	if(args[1] == 'TPMode') then
		varhelper.AdvanceCycle('TPMode');
		gFunc.Message('TP Mode: ' .. tostring(varhelper.GetCycle('TPMode')));
	
	elseif(args[1] == 'eff') then
		varhelper.AdvanceToggle('Efficiency');
		gFunc.Message('Efficiency Mode: ' .. tostring(varhelper.GetToggle('Efficiency')));
	elseif(args[1] == 'Report') then
		gFunc.Message('TP Mode (toggle w/ CTRL+F9): ' .. tostring(varhelper.GetCycle('TPMode')));
	end

end


profile.HandleDefault = function()
	local mylevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (mylevel ~= Settings.CurrentLevel) then
		gFunc.EvaluateLevels(profile.Sets, mylevel);
		Settings.CurrentLevel = mylevel;
	end
	local player = gData.GetPlayer();
	local mode = varhelper.GetCycle('TPMode');
	local threshold_mp = mp_thresholds[mode];
	
	if (player.Status == 'Engaged') then
		
		if gData.GetBuffCount("Copy Image (3)") == 1 or gData.GetBuffCount("Copy Image (2)") == 1 or gData.GetBuffCount("Copy Image (1)") == 1 then
			gFunc.EquipSet(sets.DD);
		else
			gFunc.EquipSet(tostring(varhelper.GetCycle('TPMode')));
		end
		
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	else
		
		gFunc.EquipSet(sets.Idle);
		
	end
	if varhelper.GetToggle('Efficiency') == true then
		if player.MP > mp_thresholds[mode] then 
				gFunc.EquipSet(mp_set_options[mode]);
		end
	end
end


profile.HandleAbility = function()

	local player = gData.GetPlayer();
	local mode = varhelper.GetCycle('TPMode');
	local threshold_mp = mp_thresholds[mode];
	
	local action = gData.GetAction();
	local name = action.Name;
	if(name == 'Provoke') then
		gFunc.EquipSet(sets.Enmity);
	elseif(name == 'Shield Bash') then
		gFunc.EquipSet(sets.Enmity);
	elseif(name == 'Sentinel') then
		gFunc.EquipSet(sets.Enmity);
	elseif(name == 'Holy Circle') then
		gFunc.EquipSet(sets.Enmity);
	elseif(name == 'Defender') then
		gFunc.EquipSet(sets.Enmity);
	elseif(name == 'Berserk') then
		gFunc.EquipSet(sets.Enmity);
	end
	
	if varhelper.GetToggle('Efficiency') == true then
		if player.MP > mp_thresholds[mode] then 
				gFunc.EquipSet(mp_set_options[mode]);
		end
	end
	
end


profile.HandleItem = function()


end


profile.HandlePrecast = function()


end


profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();
	local target = gData.GetActionTarget();

	if string.contains(spell.Name, 'Cure') then
		if (target.Name == 'Punkphloyd') then
			gFunc.EquipSet(sets.SelfCure);
		else
			gFunc.EquipSet(sets.OtherCure);
		end
	elseif string.contains(spell.Name, 'Flash') then
		gFunc.EquipSet(sets.Enmity);
	end
	
	if varhelper.GetToggle('Efficiency') == true then
		if player.MP > mp_thresholds[mode] then 
				gFunc.EquipSet(mp_set_options[mode]);
		end
	end
	
end


profile.HandlePreshot = function()


end


profile.HandleMidshot = function()


end


profile.HandleWeaponskill = function()

    local player = gData.GetPlayer();
    local ws = gData.GetAction().Name;
	
	if (ws == 'Starlight') then
		gFunc.EquipSet(sets.MPEff);
	else
		gFunc.EquipSet(SwordWS);
		
	end
	if varhelper.GetToggle('Efficiency') == true then
		if player.MP > mp_thresholds[mode] then 
				gFunc.EquipSet(mp_set_options[mode]);
		end
	end
	

end


return profile;