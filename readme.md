
Digilines global memory controller
# Overview

Global digiline storage for variables of any kind (use with care)

**NOTE**: the storage is not permanent and lost on shutdown

## Usage

Usage:

Reading:
```lua
if event.type == "program" then
  digiline_send("channel", {
    command = "GET",
    name = "my_register"
  })
end

if event.type == "digiline" and event.channel == "channel" then
  print("Value: " .. event.msg)
end
```

Writing:
```lua
if event.type == "program" then
  digiline_send("channel", {
    command = "SET",
    name = "my_register",
    value = 3.141
  })
end

if event.type == "digiline" and event.channel == "channel" then
  -- event.msg.success: true/false
  -- event.msg.message: the error message, if any
  -- event.msg.code: the error code: -1 = data too long, -2 = number of per-player entries exceeded
end
```

Atomic write:
```lua
if event.type == "program" then
  digiline_send("channel", {
    command = "INC",
    name = "my_register",
    value = 1
  })
end

if event.type == "digiline" and event.channel == "channel" then
  print("New value: " .. event.msg)
end
```

**NOTE**: the memory is bound to the user who placed it, the same register can only be accessed if it is placed by the same player

# Chatcommands

* **/digiline_global_memory [name]** Returns the contents of the current players memory with given name
* **/digiline_global_memory_clear** Clears the current players memory

# Memory constraints

* Per-value data-complexity of `50000` "units?"
* Per-player max-entries of `30`

# Persistence

Memory contents are persisted to mod-storage periodically

# License

* textures/global_memory_controller_top.png
  * CC BY-SA 3.0 https://cheapiesystems.com/git/digistuff
