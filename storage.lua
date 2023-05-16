local storage = minetest.get_mod_storage()
local changed_entries = {} -- playername -> true

function digiline_global_memory.get_value(playername, memory_name)
    local player_storage = digiline_global_memory.store[playername]
    if not player_storage then
        player_storage = minetest.deserialize(storage:get_string(playername)) or {}
        digiline_global_memory.store[playername] = player_storage
    end

    return player_storage[memory_name]
end

function digiline_global_memory.set_value(playername, memory_name, raw_value)
    local value, cost = digiline_global_memory.clean_and_weigh_digiline_message(raw_value)
    if cost > digiline_global_memory.max_cost then
        return false, "data too long/complex", -1
    end

    local player_storage = digiline_global_memory.get_value(playername, memory_name)

    local count = 0
    for _ in pairs(player_storage) do
        count = count + 1
    end
    if count > digiline_global_memory.max_items and raw_value ~= nil then
        return false, "per-player entry-count exceeded", -2
    end

    player_storage[memory_name] = value
    changed_entries[playername] = true

    return true
end

-- save changed entries periodically
local function save_worker()
    for playername in pairs(changed_entries) do
        local entry = digiline_global_memory.store[playername]
        storage:set_string(playername, minetest.serialize(entry))
    end
    changed_entries = {}
    minetest.after(5, save_worker)
end
minetest.after(5, save_worker)