local srv = net.createServer(net.TCP)
srv:listen(80,function(conn)
	conn:on("receive", function(client,request)
		print(request)
		local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
		if method == nil then
			_, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
		end

		
		if path == "/color" then
			if vars ~= nil then
				setMode(vars)
			end
			client:send("HTTP/1.1 200 OK")
		elseif path == "/set" then
			print("/set")
			if vars ~= nil and vars ~= "" then
				local _, _, key, val = string.find(vars, "(%w+)=(%w+)")
				local stringMode = getMode(val)
				-- activate mode
			end
		elseif path == "/save" then
			print("/save")
			if vars ~= nil and vars ~= "" then
				saveMode(vars)
			elseif activeMode ~= nil then saveMode(activeMode) end
			client:send("HTTP/1.1 200 OK")
        elseif path == "/delete" then
            print("/delete")
            if vars ~= nil and vars ~= "" then
                local _, _, key, val = string.find(vars, "(%w+)=(%w+)")
                print("number: " .. val)
                removeMode(val)
            else removeMode(activeModeNumber) end -- todo: select next available mode
            client:send("HTTP/1.1 200 OK")
		elseif path == "/modes" then
			print("/modes")
			local buf = [[HTTP/1.1 200 OK
Content-Type: application/json

{"modes":[]]
			local modes = getModes()
            if #modes ~= 0 then
    			print("modes count: " .. #modes)
    			for i = 1, #modes do
                    print("index: " .. i)
    				buf = buf .. "\"" .. string.sub(modes[i], 1, #modes[i] - 1)
                    if i == #modes then 
                        buf = buf .. "\"" 
                    else buf = buf .. "\"," end
    			end
            end
			buf = buf .. [[]}]]
			client:send(buf)
		elseif path == "/picker" then
			local buf1 = [[HTTP/1.1 200 OK

				<!DOCTYPE html>
				<html>
					<head>
						<meta charset="utf-8">
						<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
						<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
						<script src="https://cdnjs.cloudflare.com/ajax/libs/jscolor/2.0.4/jscolor.min.js"></script>
					</head>
					<body>
						<div class="container">
							<div class="row">
								<h1>ESP Color Picker</h1>
								<a type="submit" id="change_color" type="button" class="btn btn-primary">Change Color</a>
								<input class="jscolor {onFineChange:'update(this)'}" id="rgb">
							</div>
						</div>
						<script>
							function update(picker) {
								document.getElementById('rgb').innerHTML = Math.round(picker.rgb[0]) + ', ' +  Math.round(picker.rgb[1]) + ', ' + Math.round(picker.rgb[2]);
								document.getElementById("change_color").href="?r=" + Math.round(picker.rgb[0]*4.0117) + "&g=" +  Math.round(picker.rgb[1]*4.0117) + "&b=" + Math.round(picker.rgb[2]*4.0117);
							}
						</script>
					</body>
				</html>
			]]
			client:send(buf1)
		end
		
		conn:on("sent", function(c) c:close() end)
	end)
end)
