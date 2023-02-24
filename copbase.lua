local data = CopBase.init
function CopBase:init(unit)
	data(self, unit)
	
	if self._char_tweak.weapon then
		for id, preset in pairs(tweak_data.character.custom_weaponry) do
			if not self._char_tweak.weapon[id] or id == "is_shotgun_mag" or id == "is_lmg" or id == "mini" then
				self._char_tweak.weapon[id] = preset
			end
		end
		
		for _, preset in pairs(self._char_tweak.weapon) do
			if self._tweak_table == "taser" then
				preset.melee_speed = 0.5
				preset.RELOAD_SPEED = 0.66
				preset.spread = 20
				preset.focus_delay = 4
				preset.melee_dmg = 10
				preset.tase_distance = 1500
				preset.tase_sphere_cast_radius = 30
				preset.aim_delay_tase = {0, 0}
			elseif self._tweak_table == "sniper" then
				
				preset.range = {close = 15000, optimal = 15000, far = 15000}
				preset.use_laser = true
				
				for _, falloff in pairs(preset.FALLOFF) do
					if type(falloff) == "table" and wpn ~= "is_sniper" then
						falloff.r = falloff.r * 10
					end
				end
			end
		end
		
		local fix_rifles = {
			"sniper",
			"tank",
			"heavy_swat_sniper",
			"marshal_marksman"
		}
		
		for _, cop in pairs(fix_rifles) do
			if self._tweak_table == cop then
				self._char_tweak.weapon.is_rifle = tweak_data.character.custom_weaponry.is_rifle
			end
		end
	end
end

local data = CopBase.default_weapon_name
function CopBase:default_weapon_name(selection_name)
	local custom_weapon = WpnChgr:change_weapon(self._unit)

	if self._equiped then
		local akimbo_found = string.find(tweak_data.character.weap_ids[table.get_key(tweak_data.character.weap_unit_names, self._equiped)], "x_") or 0
		if self._unit:brain()._logic_data and self._unit:brain()._logic_data.is_converted and akimbo_found == 1 then
			return data(self, selection_name)
		else
			return self._equiped
		end
	end
	
	self._equiped = custom_weapon or data(self, selection_name)
	
	return self._equiped
end