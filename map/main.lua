--- @class BeatMap
--- @field data table
local BeatMap = {}

local json = require("json")

--- Create a new BeatMap
--- @return BeatMap
function BeatMap:new()
	local o = {
		data = {},
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
--- @return string
function BeatMap:add_block()
	return ""
end

return BeatMap
