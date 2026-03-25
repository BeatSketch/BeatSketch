package = "BeatSketch"
version = "dev-1"
source = {
	url = "git+https://github.com/BeatSketch/BeatSketch",
}
description = {
	detailed = [[
    A Beat Saber map maker that allows you to play the map you envision to create it
]],
	homepage = "https://github.com/BeatSketch/BeatSketch",
	license = "GPL-3.0-or-later",
}
dependencies = {
	"lua >= 5.1, < 5.6",
	"json.lua >= 0.1.3",
}
build = {
	type = "builtin",
	modules = {
		["config.parser"] = "config/parser.lua",
		["config.validator"] = "config/validator.lua",
		main = "main.lua",
		["map.main"] = "map/main.lua",
		["ui.main"] = "ui/main.lua",
	},
}
