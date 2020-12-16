
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
digiline_send("channel", {
  command = "SET",
  name = "my_register",
  value = 3.141
})
```

**NOTE**: the memory is bound to the user who placed it, the same register can only be accessed if it is placed by the same player

# Chatcommands

* **/digiline_global_memory [name]** Returns the contents of the current players memory with given name
* **/digiline_global_memory_clear** Clears the current players memory

# TODO

* [ ] memory constraints
* [ ] crafting recipe
* [ ] persistence

# License

* textures/global_memory_controller_top.png
  * CC BY-SA 3.0 https://cheapiesystems.com/git/digistuff
