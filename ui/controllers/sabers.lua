local tracking = require "util.tracking.tracking"
local M = {}

--- Draw the sabers
---@param pass Pass the render pass
function M.draw(pass)
	local idx = 0
	-- Sabers
	for _, state in pairs(tracking.get_hands()) do
		pass:setColor(1, 1, 1)
		pass:cylinder(state.pos - state.direction * 0.1, state.pos + state.direction * 0.05, 0.015, true)

		if idx == 0 then
			pass:setColor(1, 0, 0)
		else
			pass:setColor(0, 0, 1)
		end
		pass:cylinder(state.pos + state.direction * 0.05, state.pos + state.direction * 1, 0.015, true)
		idx = idx + 1
	end
end

return M
