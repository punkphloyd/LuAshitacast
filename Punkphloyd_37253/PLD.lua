local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');

local Settings = {

	CurrentLevel = 0;
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
	
	Idle_Priority = {
	
		Head = 'Kampfschaller',
		Neck = 'Holy Phial',
		Ear1 = 'Pigeon Earring',
		Ear2 = 'Pigeon Earring',
		Body = 'Kampfbrust',
		Hands = 'Kampfhentzes',
		Ring1 = 'Stamina Ring',
		Ring2 = 'Stamina Ring',
		Back = 'Wolf Mantle +1',
		Waist = 'Warrior\'s Belt +1',
		Legs = 'Kampfdiechlings',
		Feet = 'Kampfschuhs'
	},
	
	
	DD_Priority = {
	
		Head = 'Emperor Hairpin',
		Neck = 'Peacock Amulet',
		Ear1 = 'Beetle Earring +1',
		Ear2 = 'Beetle Earring +1',
		Body = {'Haubergeon', 'Scorpion Harness', 'Kampfbrust' , 'Chain Mail +1' },
		Hands = 'Ryl.Sqr. Mufflers',
		Ring1 = 'Courage Ring',
		Ring2 = 'Rajas Ring',
		Back = 'Nomad\'s Mantle',
		Waist = 'Brave Belt',
		Legs = 'Republic Subligar',
		Feet = 'Kampfschuhs'
	},
	
	
	Tank_Priority = {
	
		Head = 'Kampfschaller',
		Neck = 'Holy Phial',
		Ear1 = 'Pigeon Earring',
		Ear2 = 'Pigeon Earring',
		Body = 'Kampfbrust',
		Hands = 'Kampfhentzes',
		Ring1 = 'Stamina Ring',
		Ring2 = 'Stamina Ring',
		Back = 'Wolf Mantle +1',
		Waist = 'Warrior\'s Belt +1',
		Legs = 'Kampfdiechlings',
		Feet = 'Kampfschuhs'
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
		Back = '',
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
		Back = '',
		Waist = 'Friar\'s Rope',
		Legs = 'Custom Slacks',
		Feet = ''
	}
	
	
	
};

profile.Sets = sets;

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
	AshitaCore:GetChatManager():QueueCommand(-1,'/alias /pld /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1,'/lac disable Main');
	AshitaCore:GetChatManager():QueueCommand(-1,'/lac disable Sub');
	
	
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F9 /pld TPMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /pld Report');
	varhelper.Initialize();
	varhelper.CreateToggle('WeaponLock',true);
	varhelper.CreateCycle('TPMode', { [1] = 'Tank', [2] = 'DD'});
	
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

end


profile.HandleAbility = function()

	local action = gData.GetAction();
	if(action.Name() == 'Provoke') then
		gFunc.EquipSet(sets.Enmity);
	end

end


profile.HandleItem = function()


end


profile.HandlePrecast = function()


end


profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();

	if string.contains(spell.Name, 'Cure') then
		gFunc.EquipSet(sets.Cure);
	end
	
end


profile.HandlePreshot = function()


end


profile.HandleMidshot = function()


end


profile.HandleWeaponskill = function()


end


return profile;