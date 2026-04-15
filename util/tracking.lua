-- ── Begin TYPEDEF ────────────────────────────────────────────────
--- @alias hands "left" | "right"

--- Tracking and storing of the tracking. This can then be used to compute the map
--- Only use the provided functions to mutate the state as they provide some guards
--- @class Tracking
--- @field data TrackingData
--- @field private idx TrackingIndices
--- @field private songStart number
local Tracking = {}

--- @class TrackingData
--- @field left PositionStates
--- @field right PositionStates
--- @field head PositionStates

--- @class TrackingIndices
--- @field left number
--- @field right number
--- @field head number

--- @class PositionState
--- @field x number X coordinate
--- @field y number Y coordinate
--- @field z number Z coordinate
--- @field rx number Rotation around x axis
--- @field ry number Rotation around y axis
--- @field rz number Rotation around z axis

--- @alias PositionStates table<number, PositionState>

--- @class Coordinate
--- @field x number X coordinate
--- @field y number Y coordinate
--- @field z number Z coordinate

--- @alias Coordinates table<number, Coordinate>
-- ── End TYPEDEF ──────────────────────────────────────────────────

local headset = lovr.headset

--- Create a new Tracking store
--- @return Tracking
function Tracking:new()
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
		songStart = os.time(),
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- FIXME: Do we really need the delta time here
--- Store the hand position
--- @param dt number The delta time between this and the last call
function Tracking:hands(dt)
	local x, y, z, _, rx, ry, rz = headset.getPose("left")
	self.data.left[self.idx.left] = {
		x = x,
		y = y,
		z = z,
		rx = rx,
		ry = ry,
		rz = rz,
	}
	x, y, z, _, rx, ry, rz = headset.getPose("right")
	self.data.left[self.idx.left] = {
		x = x,
		y = y,
		z = z,
		rx = rx,
		ry = ry,
		rz = rz,
	}
end

--- Store the headset position
--- @param dt number The delta time between this and the last call
function Tracking:head(dt)
	local x, y, z, _, rx, ry, rz = headset.getPose("head")
	self.data.head[self.idx.head] = {
		x = x,
		y = y,
		z = z,
		rx = rx,
		ry = ry,
		rz = rz,
	}
end

--- Call this function upon starting the song
--- TODO: We may not need this, as it may be possible to use the audio playback position for this
--- Which is probably better, anyway
function Tracking:set_song_start()
	self.songStart = os.time()
end

--- Get the tracking data
---@return TrackingData - The tracking data object
function Tracking:get()
	return self.data
end

--- Get the coordinate of the tip of the saber for all stored poses
--- @param hand hands The hand to return it for
--- @return Coordinates tip the coordinate of the tip of the saber
function Tracking:saber_tip(hand)
	-- TODO: Implement
	return {
		{
			x = 0,
			y = 0,
			z = 0,
		},
	}
end

return Tracking
