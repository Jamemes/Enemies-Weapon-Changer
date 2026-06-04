Hooks:PostHook(CopBase, "init", "WpnChgr.CopBase.init", function(self, ...)
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
end)

local data = CopBase.default_weapon_name
function CopBase:default_weapon_name(selection_name)
	local weapon_id = data(self, selection_name)
	local custom_weapon = WpnChgr:change_weapon(self._unit)
	if self._unit:brain()._logic_data and self._unit:brain()._logic_data.is_converted and custom_weapon == "x_c45" then
		custom_weapon = "c45"
	end

	if custom_weapon then
		if self._default_weapons then
			self._default_weapons.primary = custom_weapon
			self._default_weapons.secondary = custom_weapon
		end
		
		if self._default_weapon_id then
			self._default_weapon_id = custom_weapon
		end

		local weap_ids = tweak_data.character.weap_ids
		local weap_unit_names = tweak_data.character.weap_unit_names
		for i_weap_id, weap_id in ipairs(weap_ids) do
			if self._default_weapon_id == weap_id then
				return weap_unit_names[i_weap_id]
			end
		end
	else
		return weapon_id
	end
end