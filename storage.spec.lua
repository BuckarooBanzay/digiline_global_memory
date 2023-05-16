mtt.register("storage", function(callback)
    local playername = "singleplayer"
    local memory_name = "mem"

    local success = digiline_global_memory.set_value(playername, memory_name, nil)
    assert(success)

    local value = digiline_global_memory.get_value(playername, memory_name)
    assert(value == nil)

    success = digiline_global_memory.set_value(playername, memory_name, { x=1 })
    assert(success)

    value = digiline_global_memory.get_value(playername, memory_name)
    assert(type(value) == "table")
    assert(value.x == 1)

    digiline_global_memory.flush_changes()

    local keys = digiline_global_memory.get_keys(playername)
    assert(#keys == 1)
    assert(keys[1] == memory_name)

    callback()
end)