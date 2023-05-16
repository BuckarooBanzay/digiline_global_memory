local MP = minetest.get_modpath("digiline_global_memory")

digiline_global_memory = {
  store = {}, -- playername -> memory_name -> value
  max_cost = 50000,
  max_items = 30
}

dofile(MP.."/functions.lua")
dofile(MP.."/storage.lua")
dofile(MP.."/controller.lua")
dofile(MP.."/chatcommands.lua")
