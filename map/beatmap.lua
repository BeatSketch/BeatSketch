-- Import json library
local json = require("json")

-- ── Begin TYPEDEF ────────────────────────────────────────────────
--- @class BeatMapData
--- @field version string
--- @field bpmEvents BPMEvents
--- @field colorNotes ColorNotes

--- @alias BPMEvents table<number, BPMEvent>
--- @alias ColorNotes table<number, ColorNote>

--- @class ColorNote
--- @field b number
--- @field x number
--- @field y number
--- @field c number The hand (= color), 0 = left, 1 = right
--- @field d number The cut direction, see https://bsmg.wiki/mapping/map-format/beatmap.html#color-notes

--- @class BPMEvent
--- @field b number The beat to set it at
--- @field m number The bpm to set

--- @class BeatMapIndices
--- @field bpmEvents number
--- @field colorNotes number

--- The BeatMap file abstraction. Only use the provided functions
--- to mutate the state as they provide some guards
--- @class BeatMap
--- @field data BeatMapData
--- @field private counts BeatMapIndices
local BeatMap = {}

--- @enum SaberHand
BeatMap.SABER_HAND = {
	LEFT = 0,
	RIGHT = 1,
}

--- @enum CutDirection
BeatMap.SABER_HAND = {
	UP = 0,
	DOWN = 1,
	LEFT = 2,
	RIGHT = 3,
	UP_LEFT = 4,
	UP_RIGHT = 5,
	DOWN_LEFT = 6,
	DOWN_RIGHT = 7,
	ANY = 8,
}
-- ── END TYPEDEF ──────────────────────────────────────────────────

--- Create a new BeatMap
--- @param bpm number
--- @return BeatMap
function BeatMap:new(bpm)
	if type(bpm) ~= "number" then
		error("BPM not a number")
	end
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
--- @param hand SaberHand Set to 0 for left hand, 1 for right
--- @param direction CutDirection The direction to hit in.
--- @return boolean - True if successful
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

--- Add a new bpm event. Changes the BPM from this beat onwards
--- @param beat number The beat index where the block is to be placed
--- @param bpm number The new value for BPM
--- @return boolean true if successful, false otherwise
function BeatMap:add_bpm_event(beat, bpm)
	-- Type check
	if type(bpm) == "number" then
		-- Create a new block
		local bpmEvent = {
			b = beat,
			bpm = bpm,
		}

		-- Put that bpm event into the table
		self.data.bpmEvents[self.counts.bpmEvents] = bpmEvent
		self.counts.bpmEvents = self.counts.bpmEvents + 1

		return true
	end
	return false
end

--- Returns the current BPM
---@return number
function BeatMap:get_current_bpm()
	return self.data.bpmEvents[self.counts.bpmEvents - 1].m
end

return BeatMap
