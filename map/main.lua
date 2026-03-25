local beatmap = {
	test = true,
}

function beatmap:save()
	self.test = false
	local file = io.open("main.lua", "a")
	if file ~= nil then
		file:write("test")
		file:close()
	end
end

return beatmap
