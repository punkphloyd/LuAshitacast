local brd = {};



local spell_inst = T{
	['Requiem'] = 'Hamelin Flute',
	['Threnody'] = 'Piccolo',
	['Ballad'] = 'Piccolo',
	['Minuet'] = 'Cornette +2',
	['Minne'] = 'Maple Harp +1',
	['Etude'] = 'Rose Harp +1',
	['Prelude'] = 'Angel\'s Flute',
	['Elegy'] = 'Horn +1',
	['Mambo'] = 'Gemshorn +1',
	['Paeon'] = 'Ebony Harp +2',
	['Carol'] = 'Crumhorn +1',
	['Madrigal'] = 'Traversiere +2',
	['March'] = 'Faerie Piccolo',
	['Mazurka'] = 'Harlequin\'s Horn',
	};



brd.get_instrument = function(spell_name)

	local instrument = '';
	
	if spell_name:contains('Foe Lullaby') then
		instrument = 'Cornette +2';
	elseif spell_name:contains('Horde Lullaby') then
		instrument = 'Nursemaid\'s Harp';
	else
		for k,v in pairs(spell_inst) do
			if spell_name:contains(k) then
				instrument = v;
				break;
			end
		end
	end
	
	return instrument;
end

local spell_inst_string = T{
	['Requiem'] = 'Hamelin Flute',
	['Threnody'] = 'Piccolo',
	['Ballad'] = 'Nursemaid\'s Harp',
	['Minuet'] = 'Nursemaid\'s Harp',
	['Minne'] = 'Maple Harp +1',
	['Etude'] = 'Rose Harp +1',
	['Prelude'] = 'Angel\'s Flute',
	['Elegy'] = 'Horn +1',
	['Mambo'] = 'Nursemaid\'s Harp',
	['Paeon'] = 'Ebony Harp +2',
	['Carol'] = 'Nursemaid\'s Harp',
	['Madrigal'] = 'Nursemaid\'s Harp',
	['March'] = 'Nursemaid\'s Harp',
	['Mazurka'] = 'Harlequin\'s Horn',
	};



brd.get_instrument_string = function(spell_name)

	local instrument = '';
	
	if spell_name:contains('Foe Lullaby') then
		instrument = 'Cornette +2';
	elseif spell_name:contains('Horde Lullaby') then
		instrument = 'Nursemaid\'s Harp';
	else
		for k,v in pairs(spell_inst_string) do
			if spell_name:contains(k) then
				instrument = v;
				break;
			end
		end
	end
	
	return instrument;
end

return brd;