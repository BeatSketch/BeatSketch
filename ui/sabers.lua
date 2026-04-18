local M = {}
local tips = {}

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
    -- TODO: Make configurable
    local rot = lovr.math.quat(0, 90, 90, 0)
    for _, hand in ipairs(lovr.headset.getHands()) do
        tips[hand] = tips[hand] or lovr.math.newVec3()

        local rayPosition = vec3(lovr.headset.getPosition(hand .. "/point"))
        local rayDirection = rot:mul(vec3(lovr.headset.getDirection(hand .. "/point")))

        tips[hand]:set(rayPosition + rayDirection * 1)
    end
end

return M
