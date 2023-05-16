local MP = minetest.get_modpath("digiline_global_memory")

digiline_global_memory = {
  store = {} -- playername -> memory_name -> value
}

dofile(MP.."/functions.lua")
dofile(MP.."/storage.lua")
dofile(MP.."/controller.lua")
dofile(MP.."/chatcommands.lua")
