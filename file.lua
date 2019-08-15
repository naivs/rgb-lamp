if file.exists("modes.dat") then init() end

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

function saveMode(mode)
	file.open("modes.dat", "a+")
	file.writeline(mode)
	file.close()
end

function removeMode(index)
	local modes = {}
	local f = file.open("modes.dat", "w+")

	local ind = 0
	while line = f.readline() ~= nil do
		if index ~= ind then
			modes[ind] = line
		end
		ind = ind + 1
	end

	f.write("")
	f.close()

	f = file.open("modes.dat", "a+")

	for i = 0, #modes do
		f.writeline(modes[i])
	end

	f.close()
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

function init()
	file.open("modes.dat", "a+")
	file.write("")
	file.close()
end