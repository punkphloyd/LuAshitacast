local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');

local Settings = {

	
	CurrentLevel = 0
	
};


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
	
	Idle = {
        Main =  'Terra\'s Staff',
		
        --Head = 'Gold Hairpin',
        Neck =  'Smn. Torque',
        Ear1 =  'Dodge Earring',
        Ear2 = 'Dodge Earring',
        Body =  'Vermillion Cloak',
        Hands = 'Austere Cuffs',
        Ring1 = 'Ether Ring',
        Ring2 = 'Astral ring',
        Back =  'Hexerei Cape',
        Waist = 'Friar\'s Rope',
        Legs = 'Custom Slacks',
        Feet =  'Custom M Boots',
	},
	
	perp = {
		Body = 'Austere Robe',
	},
	
	Carby = {
        Head = 'Gold Hairpin',
        Neck =  'Smn. Torque',
        Ear1 =  'Dodge Earring',
        Ear2 = 'Dodge Earring',
		Body = 'Austere Robe',
        Hands = 'Austere Cuffs',
        Ring1 = 'Ether Ring',
        Ring2 = 'Astral ring',
        Back =  'Hexerei Cape',
        Waist = 'Friar\'s Rope',
        Legs = 'Custom Slacks',
        Feet =  'Custom M Boots',
	},
	
	hmp = {
        Main = StaffTable['Dark'],
		
        Head = 'Gold Hairpin',
        Neck =  'Smn. Torque',
        Ear1 =  'Dodge Earring',
        Ear2 = 	'Dodge Earring',
        Body =  'Seer\'s Tunic',
        Hands = 'Austere Cuffs',
        Ring1 = 'Ether Ring',
        Ring2 = 'Astral ring',
        Back =  'Hexerei Cape',
        Waist = 'Friar\'s Rope',
        Legs = 'Baron\'s Slops',
        Feet =  'Custom M Boots',
	},
		
	FastCast = {
	
	},
	
	SummoningPrecast = {
	
	},
	enfeebleBP = {
	},
	
	hybridBP = {
		Ammo = 'Hedgehog Bomb',
		Head = 'Evk. Horn +1',
        Neck = 'Smn. Torque',
        Ear1 =  'Magnetic Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Shep. Doublet',
        Hands = 'Smn. Bracers +1',
		Ring1 = 'Evoker\'s Ring',
        Ring2 = 'Serket ring',
        Back =  'Astute Cape',
        Waist = 'Hierarch Belt',
        Legs = 'Evk. Spats +1',
        Feet = 'Summoner\'s Pgch.',
	},
	
	healingBP = {
	},
	
	physBP = {
	
        Head = 'Austere Hat',
		
        Hands = 'Austere Cuffs',
        Legs = 'Austere Slops',
        Feet = 'Austere Sabots',
	},
	
	skillBP = {
        Head = 'Austere Hat',
		
        Hands = 'Austere Cuffs',
        Legs = 'Austere Slops',
        Feet = 'Austere Sabots',
	},

	critBP = {
        Head = 'Austere Hat',
		
        Hands = 'Austere Cuffs',
        Legs = 'Austere Slops',
        Feet = 'Austere Sabots',
	},
	
	magicBP = {
        Head = 'Austere Hat',
		
        Hands = 'Austere Cuffs',
        Legs = 'Austere Slops',
        Feet = 'Austere Sabots',
	},
	BPDelay = {
        Head = 'Austere Hat',
		
        Hands = 'Austere Cuffs',
        Legs = 'Austere Slops',
        Feet = 'Austere Sabots',
	}
};


profile.Sets = sets;

profile.Packer = {
};

--Bloodpact Lists.

local MagicBP = T{'Searing Light','Meteorite','Holy Mist','Inferno','Fire II','Fire IV','Meteor Strike','Conflag Strike','Diamond Dust','Blizzard II','Blizzard IV','Heavenly Strike','Aerial Blast','Aero II','Aero IV','Wind Blade','Earthen Fury','Stone II','Stone IV','Geocrush','Judgement Bolt','Thunder II','Thunder IV','Thunderstorm','Thunderspark','Tidal Wave','Water II','Water IV','Grand Fall','Howling Moon','Lunar Bay','Ruinous Omen','Somnolence','Nether Blast','Night Terror','Level ? Holy'};
local PhysBP = T{'Poison Nails','Moonlit Charge','Somnolence','Punch','Rock Throw','Barracuda Dive','Claw','Axe Kick','Shock Strike','Chaotic Strike','Camisado','Regal Scratch','Crescent Fang','Rock Buster','Tail Whip','Double Punch','Megalith Throw','Double Slap','Eclipse Bite','Flaming Crush','Mountain Buster','Spinning Dive','Rush'};
local SkillBP = T{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water','Shining Ruby','Glittering Ruby','Crimson Howl','Inferno Howl','Frost Armor','Crystal Blessing','Aerial Armor','Hastega II','Fleet Wind','Hastega','Earthen Ward','Earthen Armor','Rolling Thunder','Lightning Armor','Soothing Current','Ecliptic Growl','Heavenward Howl','Ecliptic Howl','Noctoshield','Dream Shroud','Altana\'s Favor','Reraise','Reraise II','Reraise III','Raise','Raise II','Raise III','Wind\'s Blessing','Diamond Storm','Sleepga','Shock Squall','Slowga','Tidal Roar','Pavor Nocturnus','Ultimate Terror','Nightmare','Mewing Lullaby','Eerie Eye'};
--local EnfeebleBP = T{};
local HybridBP = T{'Flaming Crush','Burning Strike'};
--local HealingBP = T{};
local CritBP = T{'Predator Claws'};

--petElement gets set when you cast an avatar so we can match it to day/weather/staff
local petElement = 'Light';

local function HandlePetAction(PetAction)
	--There is an extra character somewhere coming through in PetAction.Name
	local BPName = PetAction.Name;
	--print(string.format('...%s...%s...', PetAction.Name, BPName));
	if MagicBP:contains(BPName) then
		gFunc.EquipSet(profile.Sets.magicBP);
	elseif CritBP:contains(BPName) then
		gFunc.EquipSet(profile.Sets.critBP);
	elseif SkillBP:contains(BPName) then
		gFunc.EquipSet(profile.Sets.skillBP);
	elseif HybridBP:contains(BPName) then
		gFunc.EquipSet(profile.Sets.hybridBP);
	elseif PhysBP:contains(BPName) then
		gFunc.EquipSet(profile.Sets.physBP);
	else
		gFunc.EquipSet(profile.Sets.physBP);
	end
end

profile.OnLoad = function()
    
	varhelper.Initialize();
	
	AshitaCore:GetChatManager():QueueCommand(1, '/macro book 28');
	AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
	
end

profile.OnUnload = function()

	varhelper.Destroy();
end

profile.HandleCommand = function(args)
	
end

profile.HandleDefault = function()
	local petAction = gData.GetPetAction();
	if (petAction ~= nil) then
		HandlePetAction(petAction);
		return;
	end
	local player = gData.GetPlayer();
	local pet = gData.GetPet();
	if (player.Status == 'Resting') then
		gFunc.EquipSet(profile.Sets.hmp);
	elseif (pet == nil) then
		gFunc.EquipSet(profile.Sets.Idle);
	elseif (pet.Name == 'Carbuncle') then
		    gFunc.EquipSet(profile.Sets.Carby);
			gFunc.Equip('main', StaffTable[petElement]);
	else
		gFunc.EquipSet(profile.Sets.perp);
		gFunc.Equip('main', StaffTable[petElement]);
		if(player.HPP <= 75) then
                --gFunc.Equip('Ring1', 'Conjurer\'s Ring');
        end
		local env = gData.GetEnvironment();
		if (env.DayElement == petElement) then
			--gFunc.Equip('body','Summoner\'s Dblt.');
		end
		if (env.WeatherElement == petElement) then
			--gFunc.Equip('head','Summoner\'s Horn');
		end
	end
	if (player.IsMoving == true) then
		gFunc.EquipSet(profile.Sets.Movement);
	end
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	if action.Type:contains('Blood Pact') then
		gFunc.EquipSet(profile.Sets.BPDelay);
	end
	
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	local spell = gData.GetAction();
	gFunc.EquipSet(profile.Sets.FastCast)
	if (spell.Skill == 'Summoning') then
		gFunc.EquipSet(profile.Sets.SummoningPrecast);
    end
end

profile.HandleMidcast = function()
	local petAction = gData.GetPetAction();
	if (petAction ~= nil) then
		HandlePetAction(petAction);
		return;
    end
    local action = gData.GetAction();
    if action.Name:contains('Cur') then
       	gFunc.EquipSet(profile.Sets.Cure);
    elseif action.Name=='Stoneskin' then
		gFunc.EquipSet(profile.Sets.Stoneskin);
	elseif action.Skill == 'Elemental Magic' then
		gFunc.EquipSet(profile.Sets.Nuke);
	elseif action.Skill == 'Summoning' then
		petElement = action.Element;
	end
	if action.ActionType == 'Spell' then
		--gFunc.Equip('main', ElementalStaff[action.Element]);
	end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()

end

return profile;