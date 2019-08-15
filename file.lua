function init()
	file.open("modes.dat", "w+")
	file.write("")
	file.close()
end

if not file.exists("modes.dat") then init() end

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

function saveMode(mode)
	file.open("modes.dat", "a+")
	file.writeline(mode)
	file.close()
end

function removeMode(index)
	local modes = {}
	file.open("modes.dat")

	for i = 1, 100 do
		local line = file.readline()
		if line == nil then break
		else
			print("removeMode line: " .. line)
			-- print("index: <" .. index .. ">")
			-- if tonumber(index) ~= i then
				modes[i] = line
			-- end
		end
	end
	file.close()

	--file.remove("modes.dat")

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
