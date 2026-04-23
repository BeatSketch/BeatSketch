local M = {}

-- NOTE: Can use the line function directly to draw the history (can add any number of points using it in one go)
-- pass:line(position, tip)

--- Draw the Beat Saber block lanes
--- @param pass Pass
M.draw_lanes = function(pass)
	pass:setColor(0.1, 0.1, 0.1, 1)
	pass:box(1, 0, -27, 0.5, 0.1, 50)
	pass:box(0.333, 0, -27, 0.5, 0.1, 50)
	pass:box(-0.333, 0, -27, 0.5, 0.1, 50)
	pass:box(-1, 0, -27, 0.5, 0.1, 50)
end

return M
