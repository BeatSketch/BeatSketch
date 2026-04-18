local M = {}
local tips = {}

--- Draw the pointers
---@param pass Pass the render pass
function M.draw(pass)
	-- Pointers
	for hand, tip in pairs(tips) do
		local position = vec3(lovr.headset.getPosition(hand))

		pass:setColor(1, 1, 1)
		pass:sphere(position, 0.01)

		pass:line(position, tip)
	end
end

function M.track()
	-- From https://lovr.org/docs/Interaction/Pointer_UI, modified
	for _, hand in ipairs(lovr.headset.getHands()) do
		tips[hand] = tips[hand] or lovr.math.newVec3()

		--
		local rayPosition = vec3(lovr.headset.getPosition(hand .. "/point"))
		local rayDirection = vec3(lovr.headset.getDirection(hand .. "/point"))

		tips[hand]:set(rayPosition + rayDirection * 50)
	end
end

return M
