--- @alias hands "left" | "right"

--- Tracking and storing of the tracking. This can then be used to compute the map
--- Only use the provided functions to mutate the state as they provide some guards
--- @class Tracking
--- @field data TrackingData
--- @field private idx TrackingIndices
local Tracking = {}

--- @class TrackingData
--- @field left table
--- @field right table
--- @field head table

--- @class TrackingIndices
--- @field left number
--- @field right number
--- @field head number

--- @class Coordinate
--- @field x number
--- @field y number
--- @field z number

--- @alias Coordinates table<number, Coordinate>

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
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

--- Store the hand position
function Tracking:hands()
	self.data.left[self.idx.left] = headset.getPose("left")
	self.data.right[self.idx.right] = headset.getPose("left")
end

--- Store the headset position
function Tracking:head()
	self.data.head[self.idx.head] = headset.getPose("head")
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
