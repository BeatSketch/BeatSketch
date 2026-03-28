-- Import json library
local json = require("json")

--- The BeatMap file abstraction. Only use the provided functions
--- to mutate the state as they provide some guards
--- @class BeatMap
--- @field data table
--- @field counts table
local BeatMap = {}

--- Create a new BeatMap
--- @param bpm number
--- @return BeatMap
function BeatMap:new(bpm)
	local o = {
		data = {
			version = "3.3.0",
			bpmEvents = {
				{
					b = 0,
					m = bpm,
				},
			},
			colorNotes = {},
		},
		counts = {
			bpmEvents = 1,
			colorNotes = 0,
		},
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

--- Save the BeatMap to disk
--- @param path string The file path to save to
function BeatMap:save(path)
	local file = io.open(path, "w")
	if file then
		file:write(json.encode(self.data))
		file:close()
	end
end

--- Add a new block
--- For documentation, see https://bsmg.wiki/mapping/map-format/beatmap.html#color-notes
--- @param beat number The beat index where the block is to be placed
--- @param x number The lane for the block
--- @param y number The level (i.e. height above lane) for the block
--- @param hand number Set to 0 for left hand, 1 for right
--- @param direction number The direction to hit in.
--- @return boolean True if successful
function BeatMap:add_block(beat, x, y, hand, direction)
	-- Type check
	if
		type(beat) == "number"
		and type(x) == "number"
		and type(y) == "number"
		and type(hand) == "number"
		and type(direction) == "number"
	then
		-- Create a new block
		local block = {
			b = beat,
			x = x,
			y = y,
			c = hand,
			d = direction,
		}

		-- Put that block into the table
		self.data.colorNotes[self.counts.colorNotes] = block
		self.counts.colorNotes = self.counts.colorNotes + 1

		return true
	end
	return false
end

return BeatMap
