if not file.exists("modes.dat") then
	file.open("modes.dat", "w+")
	file.write("")
	file.close()
end

if not file.exists("last.dat") then
	file.open("last.dat", "w+")
	file.write("")
	file.close()
end

function saveLastMode(mode)
	file.open("last.dat", "w+")
	file.writeline(mode)
	file.close()
end

function getLastMode()
	file.open("last.dat", "r")
	local lastMode = file.readline()
	file.close()
	return lastMode
end

function readPrevMode()
	if selectedModeNumber > 0 then
		file.open("modes.dat", "r")
		local prev = selectedModeNumber - 1

		for i = 1, prev do
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
	for i = 1, nxt do
		mode = file.readline()
		if mode ~= nil then
			selectedMode = mode
			selectedModeNumber = selectedModeNumber + 1
		end
	end
	file.close()
end

function getMode(number)
	file.open("modes.dat", "r")

	local line
	for i = 1, 100 do
		line = file.readLine()
		if line == nil then 
			break
		elseif i == number then 
			return line 
		end
	end
end

function saveMode(mode)
	file.open("modes.dat", "a+")
	file.writeline(mode)
	file.close()
end

function removeMode(index)
	local modes = {}
	file.open("modes.dat")

	local line
	for i = 1, 100 do
		line = file.readline()
		if line == nil then break
		else
			print("removeMode line: " .. line)
			modes[i] = line
		end
	end
	file.close()

	print("before: " .. #modes)
	table.remove(modes, index)
	print("after: " .. #modes)

	file.open("modes.dat", "w+")

	print("removeMode #modes: " .. #modes)
	for w = 1, #modes do print("in final write w: " .. modes[w])
		file.write(modes[w])
	end
	file.flush()
	file.close()
end

function getModes()
	file.open("modes.dat", "r")
	local modes = {}
	local line
	for i = 1, 100 do print("getModes ind: " .. i)
		line = file.readline()
		if line == nil then break
		else modes[i] = line end
	end
	file.close()
	return modes
end
