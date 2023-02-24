tweak_data.weapon.m249_npc.usage = "is_lmg"
tweak_data.weapon.rpk_lmg_npc.usage = "is_lmg"
tweak_data.weapon.benelli_npc.usage = "is_shotgun_mag"
tweak_data.weapon.m14_sniper_npc.usage = "is_sniper"
tweak_data.weapon.svd_snp_npc.usage = "is_sniper"
tweak_data.weapon.svdsil_snp_npc.usage = "is_sniper"
tweak_data.weapon.heavy_snp_npc.usage = "is_heavy_snp"
tweak_data.weapon.dmr_npc.usage = "is_dmr"

local char = tweak_data.character
local custom = deep_clone(char.swat.weapon)
custom.is_sniper = deep_clone(char.sniper.weapon.is_rifle)
custom.is_lmg = deep_clone(char.tank.weapon.is_rifle)
custom.is_dmr = deep_clone(char.marshal_marksman.weapon.is_rifle)
custom.is_shotgun_mag = deep_clone(char.tank.weapon.is_shotgun_mag)
custom.is_heavy_snp = deep_clone(char.heavy_swat_sniper.weapon.is_rifle)
custom.mini = deep_clone(char.tank_mini.weapon.mini)
custom.akimbo_pistol = deep_clone(char.presets.weapon.expert.akimbo_pistol)

tweak_data.character.custom_weaponry = custom
