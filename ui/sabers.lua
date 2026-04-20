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
	-- MAYBE: Add hand model (see lovr docs for how to)
	-- FIXME: Just do this computation once, it's quite expensive,
	-- we would need to do it twice (or more) with the current structure.
	-- The issue is that we need to somehow know when to trigger a
	-- re-computation vs serving from cache
	for _, hand in ipairs(lovr.headset.getHands()) do
		tips[hand] = tips[hand] or lovr.math.newVec3()

		-- 1. Get vectors
		local rayPosition = vec3(lovr.headset.getPosition(hand))
		local x, y, z = lovr.headset.getDirection(hand)
		local dir = vec3(x, y, z)

		-- 2. Create quaternion to rotate
		local a, ax, ay, az = lovr.headset.getOrientation(hand)
		local rot_axis_rot = quat(a, ax, ay, az)
		local rot_axis = rot_axis_rot:mul(vec3(1, 0, 0))
		local rot = quat(M.angle, rot_axis:unpack())
		-- 4. Rotate the vector with a quat around the direction vector
		-- 5. Rotate the direction vector around the new vector with quat
		-- local rot = quat(M.angle, x + 10, y, z) -- The quat is not correct yet, this rotates around the axis of the saber (thus not showing up)
		local direction = rot:mul(dir)

		tips[hand]:set(rayPosition + rot_axis_rot:mul(vec3(1, 0, 0)))
	end
end

return M
