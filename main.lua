--[[
 ___               _   ___   _           _         _
(  _ \            ( )_(  _ \( )         ( )_      ( )
| (_) )  __    _ _|  _) (_(_) |/ )   __ |  _)  ___| |__
|  _ ( / __ \/ _  ) |  \__ \|   (  / __ \ |  / ___)  _  \
| (_) )  ___/ (_| | |_( )_) | |\ \(  ___/ |_( (___| | | |
(____/ \____)\__ _)\__)\____)_) (_)\____)\__)\____)_) (_)

--]]

-- FIXME: Make this more reliable/versatile
-- TODO: Consider just putting the library in here
local lua_version = _VERSION:sub(5)
local cwd = os.getenv("PWD")
package.path = package.path .. ";" .. cwd .. "/BeatSketch/lua_modules/share/lua/" .. lua_version .. "/?.lua"

-- ┌                                               ┐
-- │                 Configuration                 │
-- └                                               ┘
function lovr.conf(t)
	-- We can also start the headset session later on (by calling lovr.headset.start and do a desktop UI first)
	-- I have yet to figure out the resizing and stuff
	t.headset.start = true
	t.window.resizable = true
end

-- ┌                                               ┐
-- │                    Drawing                    │
-- └                                               ┘
-- Drawing the screen is called once every frame
function lovr.draw(pass)
	pass:text("Hello World!", 0, 1.7, -2, 0.5)
end

-- ┌                                               ┐
-- │              Physics / Tracking               │
-- └                                               ┘
-- Tracking and the like get continuous updates
local tracking = require("tracking.main")
function lovr.update(delta_time)
	tracking.tracker(delta_time)
end
