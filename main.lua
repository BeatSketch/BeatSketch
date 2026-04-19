local button = require "ui.button"
local sabers = require "ui.sabers"
--[[
 ___               _   ___   _           _         _
(  _ \            ( )_(  _ \( )         ( )_      ( )
| (_) )  __    _ _|  _) (_(_) |/ )   __ |  _)  ___| |__
|  _ ( / __ \/ _  ) |  \__ \|   (  / __ \ |  / ___)  _  \
| (_) )  ___/ (_| | |_( )_) | |\ \(  ___/ |_( (___| | | |
(____/ \____)\__ _)\__)\____)_) (_)\____)\__)\____)_) (_)

--]]

-- ┌                                               ┐
-- │                 Configuration                 │
-- └                                               ┘
function lovr.conf(t)
	-- We can also start the headset session later on (by calling lovr.headset.start and do a desktop UI first)
	-- I have yet to figure out the resizing and stuff
	t.headset.start = true
	t.window.resizable = true
end

local b = button:new(0, 1, -2, 0, 0, 0, 2, 0.5, "Test-Button", 0.25)
-- ┌                                               ┐
-- │                    Drawing                    │
-- └                                               ┘
-- Drawing the screen is called once every frame
--- @param pass Pass
function lovr.draw(pass)
	pass:text("Hello World!", 0, 2.2, -2, 0.5)
	pass:text("BeatSketch", 0, 1.6, -2, 0.25)
    b:draw(pass)
    sabers.draw(pass)
end

-- ┌                                               ┐
-- │              Physics / Tracking               │
-- └                                               ┘
-- Tracking and the like get continuous updates
-- local tracking = require("util.tracking")
-- local song = tracking:new()
function lovr.update(delta_time)
    b:handler(function ()
        print("BOO")
        sabers.angle = sabers.angle + 10
    end)
    sabers.track()
end
