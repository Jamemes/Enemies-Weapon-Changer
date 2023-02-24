Hooks:Add("LocalizationManagerPostInit", "WpnChgr_loc", function(...)
	LocalizationManager:add_localized_strings({
		menu_WpnChgr = "Enemies Weapon Changer",
		menu_reset = "Reset Settings",
		menu_reset_text = "Are you sure you wanna reset all settings to default?",
		randomize_slider = "Randomize weapons",
		overall_random = "Overall weapon randomization",
		overall_random_slider = "Randomize weapons for all units. You have to confirm the changes to avoid an unexpected game lag.",
		confirm_overall_random = "Confirm randomizer",
		overall_random_text = "Overall weapon randomization may cause a lag. The lag length depends on how many weapons you choose in the slider and also on your PC performance. It might be quick, it could take 2-3 seconds or even freeze the game completely, if your hardware is weak.",
		overall_random_confirmation = "Are you really sure?",
		
		bm_w_ak47 = "AK47 Rifle",
		bm_w_ak47_ass = "AK47 Rifle (Akan Mercs)",
		bm_w_akmsu_smg = "Krinkov Submachine Gun",
		bm_w_asval_smg = "Valkyria Rifle",
		bm_w_beretta92 = "Bernetti 9 Pistol",
		bm_w_c45 = "Chimano 88 Pistol",
		bm_w_dmr = "Contractor .308 Sniper Rifle (Marshal Marksman)",
		bm_w_heavy_zeal_sniper = "M308 Rifle (Zeal Marksman)",
		bm_w_m14_sniper_npc = "M308 Rifle (Sniper)",
		bm_w_m4_yellow = "CAR-4 Rifle (Taser)",
		bm_w_mac11 = "Mark 10 Submachine Gun",
		bm_w_mini = "Vulcan Minigun",
		bm_w_mossberg = "Mosconi 12G Shotgun",
		bm_w_mp5_tactical = "Compact-5 Submachine Gun (Cloaker)",
		bm_w_rpk_lmg = "RPK Light Machine Gun",
		bm_w_scar_murky = "Eagle Heavy Rifle",
		bm_w_sko12_conc = "VD-12 Shotgun [Concussion Rounds] (Marksman Shield)",
		bm_w_smoke = "Shadow Cloaker's Rifle",
		bm_w_sr2_smg = "Heather Submachine Gun",
		bm_w_svd_snp = "Grom Sniper Rifle",
		bm_w_svdsil_snp = "Grom Sniper Rifle [Silensed]",
		bm_w_ump = "Jackal Submachine Gun",
		bm_w_x_c45 = "Akimbo Chimano 88 Pistols",
		
		ene_bulldozer_1 = "Green Bulldozer",
		ene_bulldozer_2 = "Black Bulldozer",
		ene_bulldozer_3 = "Skulldozer",
		ene_bulldozer_4 = "Headless Bulldozer",
		ene_male_marshal_marksman_1 = "Marshal Marksman (Green Camo)",
		ene_male_marshal_marksman_2 = "Marshal Marksman (Black Camo)",
		ene_male_marshal_shield_1 = "Marshal Shield",
		ene_shadow_cloaker_1 = "Shadow Cloaker (Dog)",
		ene_shadow_cloaker_2 = "Shadow Cloaker (Cat)",
		ene_shield_1 = "FBI Shield",
		ene_shield_2 = "SWAT Shield",
		ene_sniper_1 = "SWAT Sniper",
		ene_sniper_2 = "FBI Sniper",
		ene_sniper_3 = "Killer (Brooklyn 10-10)",
		
		ene_drug_lord_boss = "Ernesto Sosa",
		ene_gang_biker_boss = "Biker Leader",
		ene_gang_mobster_boss = "The Commissar",
		ene_male_hector_1 = "Hector",
		ene_male_hector_2 = "Armored Hector",
		npc_male_yufuwang = "Yufu Wang",
		npc_male_yufuwang_armored = "Armored Yufu Wang",
		ene_phalanx_1 = "Captain's Phalanx",
		ene_vip_1 = "Captain Winters",
		
		ene_zeal_bulldozer = "Zeal White Bulldozer",
		ene_zeal_bulldozer_2 = "Zeal Green Bulldozer",
		ene_zeal_bulldozer_3 = "Zeal Black Bulldozer",
		ene_zeal_bulldozer_halloween = "Headless Zeal Bulldozer",
		
		ene_murkywater_bulldozer_1 = "Murkywater Minigun Bulldozer",
		ene_murkywater_bulldozer_2 = "Murkywater Bulldozer Shotgunner",
		ene_murkywater_bulldozer_3 = "Murkywater Bulldozer Auto-Shotgunner",
		ene_murkywater_bulldozer_4 = "Murkywater LMG Bulldozer",
	})

	if Idstring("russian"):key() == SystemInfo:language():key() then
		LocalizationManager:add_localized_strings({
			menu_reset = "Сбросить настройки",
			menu_reset_text = "Вы уверены что хотите сбросить настройки к стандартному значению?",
			randomize_slider = "Перемешать оружие",
			overall_random = "Общая перемешка оружия",
			overall_random_slider = "Рандомизирует оружие для всех юнитов. Вы должны подтвердить действие, чтобы избежать непредвиденного лага игры.",
			confirm_overall_random = "Подтвердить перемешку",
			overall_random_text = "Общая перемешка оружия может привести к лагу игры. Продолжительность лага зависит от того какое количество оружия вы выберете в слайдере и также от производительности вашего компьютера. Это может быть быстро, может занять 2-3 секунды или вовсе привести к полному фризу игры, если ваше комьютерное железо слабо.",
			overall_random_confirmation = "Вы действительно уверены?",
		})
	end
end)

_G.WpnChgr = _G.WpnChgr or {}
WpnChgr._mod_path = WpnChgr._mod_path or ModPath
WpnChgr._setting_path = SavePath .. "WpnChgr.json"
WpnChgr.settings = WpnChgr.settings or {}

function WpnChgr:Save()
	local file = io.open(self._setting_path, "w+")
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

function WpnChgr:Load()
	local file = io.open(self._setting_path, "r")
	if file then
		for k, v in pairs(json.decode(file:read("*all")) or {}) do
			self.settings[k] = v
		end
		file:close()
	else
		self.settings = {}
		self:Save()
	end
end

function WpnChgr:create_reset_button(item, menu_id, func)
	MenuCallbackHandler[item.."_set_to_default"] = function(self, item)
		local dialog_data = {
			title = managers.localization:text("menu_reset"),
			text = managers.localization:text("menu_reset_text")
		}
		dialog_data.button_list = {
			{
				text = managers.localization:text("dialog_yes"),
				callback_func = function()
					func()
				end
			},
			{
				text = managers.localization:text("dialog_no"),
				cancel_button = true
			}
		}
		managers.system_menu:show(dialog_data)
	end

	MenuHelper:AddButton({
		id = "reset_button",
		title = "menu_reset",
		callback = item.."_set_to_default",
		menu_id = menu_id,
		priority = 1
	})

	MenuHelper:AddDivider({
		id = "divider",
		size = 16,
		menu_id = menu_id,
		priority = 1
	})
end

function WpnChgr:full_units_list()
	local list = {}
	local NPCs = tweak_data.character.character_map()
	for id, pack in pairs(NPCs) do
		if pack.path and pack.list then
			for id, name in pairs(pack.list) do
				local full = pack.path .. name .. "/" .. name
				list[tostring(name)] = tostring(full)
			end
		end
	end
	
	list["ene_city_shield"] = "units/payday2/characters/ene_city_shield/ene_city_shield"
	list["ene_city_swat_r870"] = "units/payday2/characters/ene_city_swat_r870/ene_city_swat_r870"
	
	return list
end

function WpnChgr:category_units_list()
	local units = {}
	
	local function insert(tbl, sub, name)
		if not tbl[sub] then
			tbl[sub] = {}
		end
		if not table.contains(tbl[sub], name) then
			table.insert(tbl[sub], name)
		end
		table.sort(tbl[sub])
	end

	for name, _ in pairs(self:full_units_list()) do
		local function find(tag)
			return string.find(name, tag)
		end

		if find("civ_") and find("female") then
			insert(units, "female_civilans", name)
		elseif find("civ_") and find("male") then
			insert(units, "male_civilans", name)
		elseif (find("boss") or find("ene_male_hector") or find("npc_male_yufuwang") or find("ene_vip_1") or find("ene_vip_1")) and not find("ene_fbi_boss_1") then
			insert(units, "bosses", name)
		elseif find("zeal") then
			insert(units, "zeal", name)
		elseif find("_hvh_") then
			insert(units, "zombies", name)
		elseif find("murkywater") then
			insert(units, "murkywater", name)
		elseif find("policia") or find("federale") then
			insert(units, "federales", name)
		elseif find("_akan_") then
			insert(units, "russian_mercs", name)
		elseif find("city") or find("ene_bulldozer_3") then
			insert(units, "gensec_swat", name)
		elseif find("sniper") or find("marksman") or find("shield")  or find("medic") or find("tazer") or find("spooc") or find("spook") or find("cloaker") or find("tank") or find("dozer") then
			insert(units, "specials", name)
		elseif find("secret") then
			insert(units, "secret_service", name)
		elseif find("fbi") then
			insert(units, "fbi", name)
		elseif find("swat") then
			insert(units, "swat", name)
		elseif find("police") or find("cop") then
			insert(units, "cops", name)
		elseif find("security") or find("guard") then
			insert(units, "security", name)
		elseif find("biker") or find("mobster") or find("gang") or find("thug") or find("triad") then
			insert(units, "gangs", name)
		elseif find("npc_") then
			insert(units, "npcs", name)
		else
			insert(units, "others", name)
		end
	end

	units.male_civilans = nil
	units.female_civilans = nil

	return units
end

function WpnChgr:return_dlc_by_id(id)
	for name, path in pairs(self:full_units_list()) do
		local pack = string.sub(path, string.find(path, "/"), string.find(path, "/", 7)):gsub("pd2_dlc_", ""):gsub("_", " "):gsub("/", "")

		if LocalizationManager:exists("heist_"..pack) then
			pack = managers.localization:text("heist_"..pack)
		end

		if id == name then
			return pack
		end
	end
end

function WpnChgr:change_weapon(unit)
	local unit_name = unit:name()
	for id, name in pairs(self:full_units_list()) do
		if self.settings[id] then
			if unit_name == Idstring(name) or unit_name == Idstring(name .. "_husk") then
				local tbl = table.shuffled_copy(self.settings[id])
				local weapon_id = tweak_data.character.weap_unit_names[table.get_key(tweak_data.character.weap_ids, tbl[1])]

				if not PackageManager:unit_data(weapon_id) then
					return
				end

				return weapon_id
			end
		end
	end
end

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_WpnChgr", function(...)
	WpnChgr:Load()
	MenuHelper:LoadFromJsonFile(WpnChgr._mod_path .. "options.json", WpnChgr, WpnChgr.settings)
end)

Hooks:Add("MenuManagerBuildCustomMenus", "WC_populate_categories", function(menu_manager, nodes)
	local menu_id = "WpnChgr_options"
	MenuHelper:NewMenu(menu_id)

	WpnChgr:create_reset_button("reset_all", menu_id, function()
		WpnChgr.settings = {}
		WpnChgr:Save()

		for _, pack in pairs(WpnChgr:category_units_list()) do
			for unit_id, unit_name in pairs(pack) do
				local menu_id = unit_name.."_unit"
				local menu = MenuHelper:GetMenu(menu_id)
				for _, item in pairs(menu._items) do
					if item.selected then
						item.selected = 2
					end
				end
			end
		end
	end)
		
	MenuCallbackHandler.all_randomize_weapon_callback = function(self, item)
		WpnChgr.overall_value = math.floor(item:value())
	end

	MenuHelper:AddSlider({
		id = "overall_random",
		title = "overall_random",
		desc = "overall_random_slider",
		callback = "all_randomize_weapon_callback",
		value = 0,
		min = 0,
		max = table.size(tweak_data.character.weap_ids),
		step = 1,
		show_value = true,
		menu_id = menu_id,
		priority = 1
	})
	
	MenuHelper:AddButton({
		id = "confirm_button",
		title = "confirm_overall_random",
		callback = "confirm_all_randomize_callback",
		menu_id = menu_id,
		priority = 0
	})
	
	MenuHelper:AddDivider({
		id = "divider2",
		size = 16,
		menu_id = menu_id,
		priority = -1
	})
	
	nodes[menu_id] = MenuHelper:BuildMenu(menu_id)
	MenuHelper:AddMenuItem(nodes["blt_options"], menu_id, "menu_WpnChgr")

	for id, pack in pairs(WpnChgr:category_units_list()) do
		local categories = id.."_category"
		MenuHelper:NewMenu(categories)

		if not LocalizationManager:exists(id) then
			LocalizationManager:add_localized_strings({
				[id] = id:gsub("_", " ")
			})
		end

		nodes[categories] = MenuHelper:BuildMenu(categories)
		MenuHelper:AddMenuItem(nodes[menu_id], categories, id)
		
		for unit_id, unit_name in pairs(pack) do
			local unit_menu_id = unit_name.."_unit"
			MenuHelper:NewMenu(unit_menu_id)
			
			if not LocalizationManager:exists(unit_menu_id) then
				LocalizationManager:add_localized_strings({[unit_menu_id] = unit_name:gsub("_", " ").."\n"..WpnChgr:return_dlc_by_id(unit_name)})
			end
			
			if not LocalizationManager:exists(unit_name) then
				LocalizationManager:add_localized_strings({[unit_name] = string.sub(unit_name
				
					:gsub("spooc", "Cloaker")
					:gsub("spook", "Cloaker")
					:gsub("tazer", "Taser")
					:gsub("_dozer", "_Bulldozer")
					:gsub("_tank", "_Bulldozer")

					:gsub("_m4", "")
					:gsub("_ak47_ass", "")
					:gsub("_g36", "_(G36)")
					:gsub("_с45", "_(С45)")
					:gsub("_r870", "_Shotgunner")
					
					:gsub("_0", "_")
					
					:gsub("_1", "")
					
					
					:gsub("city_", "GenSec_")
					:gsub("_hvh", "_Zombie")
					:gsub("akan_", "Merc_")
					:gsub("_federale", "")
					
					:gsub("_cs_", "_")
					:gsub("_", " ")
					
				, 5)})
			end
			
			MenuCallbackHandler[unit_name.."_change_weapon_callback"] = function(self, item)
				if item:value() == "on" then
					if not WpnChgr.settings[unit_name] then
						WpnChgr.settings[unit_name] = {}
					end
					table.insert(WpnChgr.settings[unit_name], item:name())
				else
					table.delete(WpnChgr.settings[unit_name], item:name())
					if table.size(WpnChgr.settings[unit_name]) == 0 then
						WpnChgr.settings[unit_name] = nil
					end
				end

				WpnChgr:Save()
			end
			
			for _, weapon in pairs(table.sorted_copy(tweak_data.character.weap_ids)) do
	
				local weapon_name = "bm_w_" .. weapon
				if not LocalizationManager:exists(weapon_name) then
					LocalizationManager:add_localized_strings({[weapon_name] = weapon:gsub("x_", "Akimbo "):gsub("_", " ")})
				end
				
				if not LocalizationManager:exists(weapon) then
					local weapon_id = tweak_data.character.weap_unit_names[table.get_key(tweak_data.character.weap_ids, weapon)]
					if weapon_id and not PackageManager:unit_data(weapon_id) then
						LocalizationManager:add_localized_strings({[weapon] = weapon:gsub("_", " ").." (Not Loaded)"})
					else
						LocalizationManager:add_localized_strings({[weapon] = weapon:gsub("_", " ")})
					end
				end
				
				MenuHelper:AddToggle({
					id = weapon,
					title = weapon,
					desc = weapon_name,
					localize = false,
					callback = unit_name.."_change_weapon_callback",
					value = WpnChgr.settings[unit_name] and table.contains(WpnChgr.settings[unit_name], weapon) or false,
					menu_id = unit_menu_id
				})
			end
			
			WpnChgr:create_reset_button("reset_"..unit_name, unit_menu_id, function()
				WpnChgr.settings[unit_name] = {}
				WpnChgr:Save()

				local menu = MenuHelper:GetMenu(unit_menu_id)
				for _, item in pairs(menu._items) do
					if item._type == "slider" then
						item._value = 0
					end
					if item.selected then
						item.selected = 2
					end
				end
				managers.viewport:resolution_changed()
			end)
			
			MenuCallbackHandler[unit_name.."_randomize_weapon_callback"] = function(self, item)
				local list = table.shuffled_copy(tweak_data.character.weap_ids)
				table.crop(list, math.floor(item:value()))

				WpnChgr.settings[unit_name] = list
				
				if table.size(WpnChgr.settings[unit_name]) == 0 then
					WpnChgr.settings[unit_name] = nil
				end
				
				WpnChgr:Save()
				
				local menu = MenuHelper:GetMenu(unit_menu_id)
				for _, item in pairs(menu._items) do
					if item.selected then
						item.selected = WpnChgr.settings[unit_name] and table.contains(WpnChgr.settings[unit_name], item._parameters.name) and 1 or 2
					end
				end
				
				managers.viewport:resolution_changed()
			end
			
			MenuHelper:AddSlider({
				id = "randomize_slider",
				title = "randomize_slider",
				desc = "randomize_slider",
				callback = unit_name.."_randomize_weapon_callback",
				value = 0,
				min = 0,
				max = table.size(tweak_data.character.weap_ids),
				step = 1,
				show_value = true,
				menu_id = unit_menu_id,
				priority = -1
			})
			
			nodes[unit_menu_id] = MenuHelper:BuildMenu(unit_menu_id)
			MenuHelper:AddMenuItem(nodes[id.."_category"], unit_menu_id, unit_name, unit_menu_id)
		end
	end
end)

MenuCallbackHandler.confirm_all_randomize_callback = function(self, item)
	if WpnChgr.overall_value and WpnChgr.overall_value > 0 then
		local function randomize_all()
			for id, pack in pairs(WpnChgr:category_units_list()) do
				for unit_id, unit_name in pairs(pack) do
				
					local list = table.shuffled_copy(tweak_data.character.weap_ids)
					table.crop(list, WpnChgr.overall_value)

					WpnChgr.settings[unit_name] = list
					
					if table.size(WpnChgr.settings[unit_name]) == 0 then
						WpnChgr.settings[unit_name] = nil
					end
					
					WpnChgr:Save()
					
					local menu = MenuHelper:GetMenu(unit_name.."_unit")
					for _, item in pairs(menu._items) do
						if item.selected then
							item.selected = WpnChgr.settings[unit_name] and table.contains(WpnChgr.settings[unit_name], item._parameters.name) and 1 or 2
						end
					end
					
				end
			end
			managers.viewport:resolution_changed()
		end
				
		local dialog_data = {
			title = managers.localization:text("overall_random"),
			text = managers.localization:text("overall_random_text"),
			button_list = {
				{
					text = managers.localization:text("dialog_ok"),
					callback_func = function()
						local confirmation = {
							title = managers.localization:text("overall_random"),
							text = managers.localization:text("overall_random_confirmation"),
							button_list = {
								{
									text = managers.localization:text("dialog_accept"),
									callback_func = function()
										randomize_all()
									end
								},
								{
									text = managers.localization:text("menu_back"),
									cancel_button = true
								}
							}
						}
						managers.system_menu:show(confirmation)
					end
				}
			}
		}
		
		managers.system_menu:show(dialog_data)
	end
end
