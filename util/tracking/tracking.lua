local trackers = require("util.tracking.trackers")
local M = {}

--- @type PositionStates
local tracker_states = {
	head = {
		pos = vec3(0, 0, 0),
		direction = vec3(0, 0, 0),
		angle = quat(0, 0, 0, 1),
		delta = 0,
		buttons = {},
	},
	left = {
		pos = vec3(0, 0, 0),
		direction = vec3(0, 0, 0),
		angle = quat(0, 0, 0, 1),
		delta = 0,
		buttons = {},
	},
	right = {
		pos = vec3(0, 0, 0),
		direction = vec3(0, 0, 0),
		angle = quat(0, 0, 0, 1),
		delta = 0,
		buttons = {},
	},
}

--- Store the positions for the hands
--- @param dt number The time since the last call
function M.update_hands(dt)
	tracker_states.left = trackers.get_hand("left", dt)
	tracker_states.right = trackers.get_hand("right", dt)
end

--- Store the position for the headset
---@param dt number The time since the last call
function M.update_head(dt)
	tracker_states.head = trackers.get_head(dt)
end

--- Get the position states of the hands
--- @return table<string, PositionState>
function M.get_hands()
	return {
		left = tracker_states.left,
		right = tracker_states.right,
	}
end

--- Get the position state of the headset
---@return PositionState
function M.get_head()
	return tracker_states.head
end

return M
