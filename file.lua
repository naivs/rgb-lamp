function readPrevMode()
	if selectedModeNumber > 0 then
		file.open("modes.dat", "r")
		local prev = selectedModeNumber - 1

		for i = 0, prev do
			selectedMode = file.readline()
		end
		selectedModeNumber = selectedModeNumber - 1
		file.close()
	end
end

function readNextMode()
	local nxt = selectedModeNumber + 1
	file.open("modes.dat", "r")
	local mode
	for i = 0, nxt do
		mode = file.readline()
		if mode ~= nil then
			selectedMode = mode
			selectedModeNumber = selectedModeNumber + 1
		end
	end
	file.close()
end

function writeMode(mode)
	file.open("modes.dat", "a+")
	file.writeline(mode)
	file.close()
end

function getModes()
	file.open("modes.dat", "r")
	local modes = {}
	for i = 0, 100 do
		line = file.readline()
		if line == nil then break
		else modes[i] = line end
	end
	file.close()
	return modes
end
