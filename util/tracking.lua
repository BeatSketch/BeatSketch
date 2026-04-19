-- Import json library
local json = require("json")

-- ── Begin TYPEDEF ────────────────────────────────────────────────
--- @alias hands "left" | "right"

--- Tracking and storing of the tracking. This can then be used to compute the map
--- Only use the provided functions to mutate the state as they provide some guards
--- @class TrackingHistory
--- @field data TrackingData
--- @field private idx TrackingIndices
local TrackingHistory = {}

--- @class TrackingData
--- @field left PositionStates
--- @field right PositionStates
--- @field head PositionStates

--- @class TrackingIndices
--- @field left number
--- @field right number
--- @field head number

--- @class PositionState
--- @field pos Vec3
--- @field direction Vec3 The direction vector
--- @field angle Quat
--- @field delta number

--- @alias PositionStates table<number, PositionState>

--- @class Coordinate
--- @field x number X coordinate
--- @field y number Y coordinate
--- @field z number Z coordinate

--- @alias Coordinates table<number, Coordinate>
-- ── End TYPEDEF ──────────────────────────────────────────────────

--- Create a new Tracking store
--- @return TrackingHistory
function TrackingHistory:new()
	local o = {
		data = {
			left = {},
			right = {},
			head = {},
		},
		idx = {
			left = 0,
			right = 0,
			head = 0,
		},
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- FIXME: Do we really need the delta time here
--
--- Store the hand position
--- @param dt number The delta time between this and the last call
function TrackingHistory:store_hands(dt)
	self.data.left[self.idx.left] = {
		pos = vec3(lovr.headset.getPosition("left")),
		direction = vec3(lovr.headset.getDirection("left")),
		angle = quat(lovr.headset.getOrientation("left")),
		delta = dt,
	}
	self.data.right[self.idx.right] = {
		pos = vec3(lovr.headset.getPosition("right")),
		direction = vec3(lovr.headset.getDirection("right")),
		angle = quat(lovr.headset.getOrientation("right")),
		delta = dt,
	}
end

--- Store the headset position
--- @param dt number The delta time between this and the last call
function TrackingHistory:store_head(dt)
	self.data.head[self.idx.head] = {
		pos = vec3(lovr.headset.getPosition("head")),
		direction = vec3(lovr.headset.getDirection("head")),
		angle = quat(lovr.headset.getOrientation("head")),
		delta = dt,
	}
end

--- Save the tracking data to a json file
---@param path string The path to save to
function TrackingHistory:save(path)
	local file = io.open(path, "w")
	if file then
		file:write(json.encode(self.data))
		file:close()
	end
end

--- Get the tracking data
---@return TrackingData - The tracking data object
function TrackingHistory:get()
	return self.data
end

--- Get the tracking data
--- @param length number
--- @return Vec3 left - The tracking data object
--- @return Vec3 right - The tracking data object
function TrackingHistory:get_tips(length, idx)
	return (self.data.left[idx].direction + self.data.left[idx].direction * length),
		(self.data.right[idx].direction + self.data.right[idx].direction * length)
end

function TrackingHistory:get_current_tips(length)
	return (self.data.left[self.idx.left].direction + self.data.left[self.idx.left].direction * length),
		(self.data.right[self.idx.right].direction + self.data.right[self.idx.right].direction * length)
end

return TrackingHistory
