local storage = minetest.get_mod_storage()
local changed_entries = {} -- playername -> true

local function get_player_storage(playername)
    local player_storage = digiline_global_memory.store[playername]
    if not player_storage then
        player_storage = minetest.deserialize(storage:get_string(playername)) or {}
        digiline_global_memory.store[playername] = player_storage
    end
    return player_storage
end

-- returns the players memory-names
function digiline_global_memory.get_keys(playername)
    local keys = {}
    local player_storage = get_player_storage(playername)

    for key in pairs(player_storage) do
        table.insert(keys, key)
    end
    return keys
end

-- increment and get value
-- resets the value in store to 0 if it is not a number
function digiline_global_memory.inc_value(playername, memory_name, inc)
    local player_storage = get_player_storage(playername)
    local value = player_storage[memory_name]
    if type(value) ~= "number" then
        value = 0
    end
    if type(inc) == "number" then
        value = value + inc
        player_storage[memory_name] = value
    end
    return value
end

-- get value
function digiline_global_memory.get_value(playername, memory_name)
    local player_storage = get_player_storage(playername)
    return player_storage[memory_name]
end

-- set value
function digiline_global_memory.set_value(playername, memory_name, raw_value)
    local value, cost = digiline_global_memory.clean_and_weigh_digiline_message(raw_value)
    if cost > digiline_global_memory.max_cost then
        return false, "data too long/complex", -1
    end

    local player_storage = get_player_storage(playername)

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

function digiline_global_memory.clear(playername)
    digiline_global_memory.store[playername] = {}
    changed_entries[playername] = true
end

function digiline_global_memory.flush_changes()
    for playername in pairs(changed_entries) do
        local entry = digiline_global_memory.store[playername]
        storage:set_string(playername, minetest.serialize(entry))
    end
    changed_entries = {}
end

-- save changed entries periodically
local function save_worker()
    digiline_global_memory.flush_changes()
    minetest.after(5, save_worker)
end
minetest.after(5, save_worker)