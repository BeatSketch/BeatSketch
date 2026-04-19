local M = {}
local tips = {}

M.angle = 15

--- Draw the sabers
---@param pass Pass the render pass
function M.draw(pass)
	local idx = 0
	-- Sabers
	for hand, tip in pairs(tips) do
		local position = vec3(lovr.headset.getPosition(hand))

		pass:setColor(1, 1, 1)
		pass:sphere(position, 0.01)

		if idx == 0 then
			pass:setColor(1, 0, 0)
		else
			pass:setColor(0, 0, 1)
		end
		pass:cylinder(position, tip, 0.01, true)
		idx = idx + 1
	end
end

function M.track()
	-- From https://lovr.org/docs/Interaction/Pointer_UI, modified
	-- TODO: Get rotation working
	-- Rotation of sabers to make them line up with what beat saber does
	for _, hand in ipairs(lovr.headset.getHands()) do
		tips[hand] = tips[hand] or lovr.math.newVec3()

        -- 1. Get vectors
        -- 2. Determine plane in which the rotation axis has to be (all orthogonal vectors to direction)
        -- 3. Pick one vector (with a coord being 0, length = 1)
        -- 4. Rotate the vector with a quat around the direction vector
        -- 5. Rotate the direction vector around the new vector with quat
		local rayPosition = vec3(lovr.headset.getPosition(hand))
		local dir = vec3(lovr.headset.getDirection(hand))
        local x, y, z = dir:unpack()
		local rot = quat(M.angle, x, y, z) -- The quat is not correct yet, this rotates around the axis of the saber (thus not showing up)
        dir:rotate(rot)
		local rayDirection = rot:mul(dir)
		print("Old vec", dir, "New vec", rayDirection)

		tips[hand]:set(rayPosition + rayDirection * 1)
	end
end

return M
