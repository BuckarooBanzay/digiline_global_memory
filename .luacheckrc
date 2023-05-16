
globals = {
	"digiline_global_memory",
}

read_globals = {
	-- Stdlib
	string = {fields = {"split"}},
	table = {fields = {"copy", "getn"}},

	-- Minetest
	"vector", "ItemStack",
	"dump", "minetest",

	-- deps
	"digiline", "mtt"
}
