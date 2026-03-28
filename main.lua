-- TODO: Make this more reliable/versatile
package.path = package.path .. ";" .. os.getenv("PWD") .. "/BeatSketch/lua_modules/share/lua/5.4/?.lua"

local map = require("map.beatmap")

function lovr.draw(pass)
	pass:text("Hello World!", 0, 1.7, -2, 0.5)
	local beatmap = map:new()
end
