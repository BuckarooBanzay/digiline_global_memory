
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
    if cost > digiline_global_memory.max_cost then
        return false, "data too long/complex", -1
    end

    local player_storage = digiline_global_memory.store[playername]
    if not player_storage then
        player_storage = {}
        digiline_global_memory.store[playername] = player_storage
    end

    local count = 0
    for _ in pairs(player_storage) do
        count = count + 1
    end
    if count > digiline_global_memory.max_items then
        return false, "per-player entry-count exceeded", -2
    end

    player_storage[memory_name] = value
    return true
end
