local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');

local Settings = {

	
	CurrentLevel = 0
	
};



local sets = {
	
		test_1 = {
		
			Head = 'Shaded Spectacles',
			Hands = '',
		},
		test_2 = {
		
			Head = '',
			Hands = '',
		},
		
		
	
};


profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    
	varhelper.Initialize();
	
	
end

profile.OnUnload = function()

	varhelper.Destroy();
end

profile.HandleCommand = function(args)
	
end

profile.HandleDefault = function()
	
end

profile.HandleAbility = function()
	
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	
end

profile.HandleMidcast = function()
	
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()

end

return profile;