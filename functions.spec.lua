
mtt.register("clean_and_weigh_digiline_message", function(callback)
    local msg, cost = digiline_global_memory.clean_and_weigh_digiline_message(nil)
    assert(msg == nil)
    assert(cost == 0)
    callback()
end)