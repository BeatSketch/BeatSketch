local tracking = require "util.tracking.tracking"
local M = {}

--- Draw the sabers
---@param pass Pass the render pass
function M.draw(pass)
	local idx = 0
	-- Sabers
	for _, state in pairs(tracking.get_hands()) do

		pass:setColor(1, 1, 1)
		pass:sphere(state.pos, 0.01)

		if idx == 0 then
			pass:setColor(1, 0, 0)
		else
			pass:setColor(0, 0, 1)
		end
		pass:cylinder(state.pos, state.pos + state.direction, 0.01, true)
		idx = idx + 1
	end
end

return M
