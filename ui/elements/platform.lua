local M = {}

--- Draw the Beat Saber platform
--- @param pass Pass
M.draw_platform = function(pass)
	-- TODO: Materials? (https://lovr.org/docs/lovr.graphics.newMaterial),
	-- then pass:setMaterial
	pass:setColor(0.1, 0.1, 0.1, 1)
	pass:box(0, -2.5, 0, 2, 5, 2)
	pass:setColor(0.5, 0.5, 0.5, 1)
	pass:box(0, -2.5, 0, 2, 5, 2, 0, 0, 0, 0, "line")
end

return M
