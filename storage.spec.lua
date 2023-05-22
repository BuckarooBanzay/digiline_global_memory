mtt.register("storage", function(callback)
    local playername = "singleplayer"
    local memory_name = "mem"

    -- set nil
    local success = digiline_global_memory.set_value(playername, memory_name, nil)
    assert(success)

    -- get nil
    local value = digiline_global_memory.get_value(playername, memory_name)
    assert(value == nil)

    -- set value
    success = digiline_global_memory.set_value(playername, memory_name, { x=1 })
    assert(success)

    -- get value
    value = digiline_global_memory.get_value(playername, memory_name)
    assert(type(value) == "table")
    assert(value.x == 1)

    -- inc value (previously a table)
    value = digiline_global_memory.inc_value(playername, memory_name, 1)
    assert(value == 1)
    value = digiline_global_memory.inc_value(playername, memory_name, 1)
    assert(value == 2)
    value = digiline_global_memory.inc_value(playername, memory_name, -3)
    assert(value == -1)

    digiline_global_memory.flush_changes()

    local keys = digiline_global_memory.get_keys(playername)
    assert(#keys == 1)
    assert(keys[1] == memory_name)

    digiline_global_memory.clear(playername)
    digiline_global_memory.flush_changes()

    value = digiline_global_memory.get_value(playername, memory_name)
    assert(value == nil)

    callback()
end)