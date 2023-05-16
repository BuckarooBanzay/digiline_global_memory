
function digiline_global_memory.get_value(playername, memory_name)
    local player_storage = digiline_global_memory.store[playername]
    if not player_storage then
        player_storage = {}
        digiline_global_memory.store[playername] = player_storage
    end

    return player_storage[memory_name]
end

function digiline_global_memory.set_value(playername, memory_name, raw_value)
    local value, cost = digiline_global_memory.clean_and_weigh_digiline_message(raw_value)
    if cost > 50000 then
        return false, "data too long/complex"
    end

    local player_storage = digiline_global_memory.store[playername]
    if not player_storage then
        player_storage = {}
        digiline_global_memory.store[playername] = player_storage
    end

    player_storage[memory_name] = value
    return true
end
