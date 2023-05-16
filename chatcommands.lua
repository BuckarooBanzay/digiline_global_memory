
minetest.register_chatcommand("digiline_global_memory", {
  params = "<name>",
  description = "shows the current memory value",
  func = function(name, param)
    if param == "" or not param then
      return false, "Please specify the memory name!"
    end

    return true, dump(digiline_global_memory.get_value(name, param) or "<empty>")
  end
})

minetest.register_chatcommand("digiline_global_memory_clear", {
  params = "<name>",
  description = "clears the global memory of the player",
  func = function(name)
    digiline_global_memory.clear(name)
    return true, "Memory cleared"
  end
})
