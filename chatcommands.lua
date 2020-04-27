
minetest.register_chatcommand("global_memory", {
  params = "<name>",
	description = "shows the current memory value",
	func = function(name, param)
    if param == "" or not param then
      return false, "Please specify the metric!"
    end

    return true, dump(digiline_global_memory.get_value(name, param) or "<empty>")
  end
})
