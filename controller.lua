
minetest.register_node("digiline_global_memory:controller", {
	description = "Digiline global memory controller",
	groups = {
	cracky=3
  },

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		-- default digiline channel
		meta:set_string("channel", "global_memory")
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("formspec","field[channel;Channel;${channel}")
	end,

	tiles = {
		"global_memory_controller_top.png",
		"jeija_microcontroller_bottom.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png"
	},

	inventory_image = "global_memory_controller_top.png",
	drawtype = "nodebox",
	selection_box = {
		--From luacontroller
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -5/16, 8/16 },
	},
	node_box = {
		--From Luacontroller
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, -7/16, 8/16}, -- Bottom slab
			{-5/16, -7/16, -5/16, 5/16, -6/16, 5/16}, -- Circuit board
			{-3/16, -6/16, -3/16, 3/16, -5/16, 3/16}, -- IC
		}
	},

	paramtype = "light",
	sunlight_propagates = true,

	on_receive_fields = function(pos, _, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then
			-- setchannel on submit
			meta:set_string("channel",fields.channel)
		end
	end,

	digiline = {
		receptor = {},
		effector = {
			action = function(pos, _, channel, msg)
				local meta = minetest.get_meta(pos)
				if meta:get_string("channel") ~= channel then
					return
				end

				local owner = meta:get_string("owner")

				if type(msg) == "table" and msg.command and msg.name then
					if msg.command == "GET" then
						local value = digiline_global_memory.get_value(owner, msg.name)
						digiline:receptor_send(pos, digiline.rules.default, channel, value)
					elseif msg.command == "SET" then
						local success, err_msg, err_code = digiline_global_memory.set_value(owner, msg.name, msg.value)
						digiline:receptor_send(pos, digiline.rules.default, channel, {
							success = success,
							message = err_msg,
							code = err_code
						})
					end
				end
			end
		}
	}
})

-- NOTE: uses the digistuff eeprom as ingredient (not a dependency)
minetest.register_craft({
	output = "digiline_global_memory:controller",
	recipe = {
		{"digistuff:eeprom","digilines:wire_std_00000000","digistuff:eeprom"},
		{"digistuff:eeprom","digilines:wire_std_00000000","digistuff:eeprom"},
		{"digistuff:eeprom","digilines:wire_std_00000000","digistuff:eeprom"},
	}
})
