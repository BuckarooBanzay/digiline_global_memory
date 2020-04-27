
digiline_global_memory.get_value = function(playername, memory_name)
  local player_storage = digiline_global_memory.store[playername]
  if not player_storage then
    player_storage = {}
    digiline_global_memory.store[playername] = player_storage
  end

  return player_storage[memory_name]
end

digiline_global_memory.set_value = function(playername, memory_name, value)
  local player_storage = digiline_global_memory.store[playername]
  if not player_storage then
    player_storage = {}
    digiline_global_memory.store[playername] = player_storage
  end

  player_storage[memory_name] = value
end
