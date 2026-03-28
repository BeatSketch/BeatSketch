-- Import json library
local json = require("json")

--- The BeatMap file abstraction. Only use the provided functions
--- to mutate the state as they provide some guards
--- @class InfoFile
--- @field data table
--- @field counts table
local InfoFile = {}

--- Create a new BeatMap
--- @param bpm number
--- @param audio_file string
--- @param song_duration number
--- @param name string
--- @param subtitle string
--- @param author string
--- @return BeatMap
function InfoFile:new(bpm, audio_file, song_duration, name, subtitle, author)
	if type(bpm) ~= "number" then
		error("BPM not a number")
	end
	local o = {
		data = {
			version = "4.0.0",
			difficultyBeatmaps = {},
			song = {
				title = name,
				subtitle = subtitle,
				author = author,
			},
			audio = {
				songFilename = audio_file,
				songDuration = song_duration,
				audioDataFilename = "BPMInfo.dat",
				bpm = bpm,
				lufs = 0,
				previewStartTime = 20,
				previewDuration = song_duration - 20,
			},
			songPreviewFilename = audio_file,
			coverImageFilename = "cover.png",
			environmentNames = {
                "DefaultEnvironment"
            },
		},
		counts = {
			difficultyBeatmaps = 0,
		},
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

--- Save the BeatMap to disk
--- @param path string The file path to save to
function InfoFile:save(path)
	local file = io.open(path, "w")
	if file then
		file:write(json.encode(self.data))
		file:close()
	end
end

--- Save the BeatMap to disk
--- @param difficulty string The file path to save to
--- @param njs number The note jump speed
--- @param njs_offset number Note jump offset
function InfoFile:add_beatmap(difficulty, njs, njs_offset)
	self.data.difficultyBeatmaps[self.counts.difficultyBeatmaps] = {
		characteristic = "Standard",
		difficulty = difficulty,
		beatmapAuthors = {
			mappers = {
				"BeatSketch",
			},
			lighters = {},
		},
		environmentNameIdx = 0,
		beatmapColorSchemeIdx = -1, -- means use default
		noteJumpMovementSpeed = njs,
		noteJumpStartBeatOffset = njs_offset,
		beatmapDataFilename = difficulty .. ".dat",
		lightShowDataFilename = "Lightshow.dat",
	}
	self.counts.difficultyBeatmaps = self.counts.difficultyBeatmaps + 1
end

return InfoFile
