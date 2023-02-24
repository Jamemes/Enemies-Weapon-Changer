local data = CopMovement.clbk_inventory
function CopMovement:clbk_inventory(unit, event)
	data(self, unit, event)
	
	if self._ext_inventory and self._ext_inventory._shield_unit then
		local weapon = self._ext_inventory:equipped_unit()
		if weapon then
			self._machine:set_global("pistol", 1)
			self._machine:set_global("is_pistol", 1)
			self._machine:set_global("rifle", 0)
			self._machine:set_global("is_rifle", 0)
			self._machine:set_global("is_shotgun_pump", 0)
		end
	end
end