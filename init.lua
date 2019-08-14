if file.exists("wifi.lua") and file.exists("file.lua") and file.exists("rgb.lua") then
	dofile("wifi.lua")
	print("wifi.lua loaded")
	dofile("file.lua")
	print("file.lua loaded")
	dofile("rgb.lua")
	print("rgb.lua loaded")
else print("error: wifi.lua or file.lua or rgb.lua is not found") end
