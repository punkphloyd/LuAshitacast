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
		Main = '',
		Sub = '',
		Range = '',
		Ammo = '',
		Head = 'Beetle Mask +1',
		Neck = 'Justice Badge',
		Ear1 = 'Onyx Earring',
		Ear2 = 'Onyx Earring',
		Body = 'Field Tunica',
		Hands = 'Chocobo Gloves',
		Ring1 = 'Astral Ring',
		Ring2 = 'Astral Ring',
		Back = '',
		Waist = 'Friar\'s Rope',
		Legs = 'Field Hose',
		Feet = 'Field Boots'
	},
	
	
	TP_Default_Priority = {
		Main = '',
		Sub = '',
		Range = '',
		Ammo = '',
		Head = '',
		Neck = 'Bird Whistle',
		Ear1 = '',
		Ear2 = '',
		Body = {'Haubergeon', 'Scorpion Harness', 'Eisenbrust' , 'Chain Mail +1' },
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	},
	
	
	TP_Defence_Priority = {
		Main = '',
		Sub = '',
		Range = '',
		Ammo = '',
		Head = '',
		Neck = 'Spike Necklace',
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
	
	TP_Acc_Priority = {
		Main = '',
		Sub = '',
		Range = '',
		Ammo = '',
		Head = '',
		Neck = '',
		Ear1 = '',
		Ear2 = '',
		Body = 'Beetle Harness',
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	},
	
	TP_MP_Priority = {
		Main = '',
		Sub = '',
		Range = '',
		Ammo = '',
		Head = '',
		Neck = '',
		Ear1 = '',
		Ear2 = '',
		Body = 'Choc. Jack Coat',
		Hands = '',
		Ring1 = '',
		Ring2 = '',
		Back = '',
		Waist = '',
		Legs = '',
		Feet = ''
	},
	
	Cure_Priority = {
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
	varhelper.CreateCycle('TPMode', { [1] = 'Default', [2] = 'Defence', [3] = 'Acc' , [4] = 'MP'});
	
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
		gFunc.EquipSet('TP_' .. tostring(varhelper.GetCycle('TPMode')));
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