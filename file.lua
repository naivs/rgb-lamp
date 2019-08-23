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

function saveLast(index)
	file.open("last.dat", "w+")
	file.writeline(mode)
	file.close()
end

function getLast()
	file.open("last.dat", "r")
	local lastMode = file.readline()
	file.close()
	return lastMode
end

function prev(current)
	local index, mode
	if current > 0 then
		index = current - 1
		mode = getMode(index)
	end
	return index, mode
end

function next(current)
	local index = current + 1, mode = getMode(index)
	if mode == nil then index = index - 1 end
	return index, mode
end

function getMode(number)
	file.open("modes.dat", "r")

	local line
	for i = 1, 100 do
		line = file.readLine()
		if line == nil then 
			break
		elseif i == number then
			file.close()
			return line 
		end
	end
	file.close()
	return nil
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

	local lastMode = getLast()
	if lastMode == index or lastMode > #modes + 1 then
		lastMode = nil
	elseif lastMode > index then
		lastMode = lastMode - 1
	end
	saveLast(lastMode)
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
