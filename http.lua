local srv = net.createServer(net.TCP)
srv:listen(80,function(conn)
	conn:on("receive", function(client,request)
		print(request)
		local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
		if method == nil then
			_, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
		end

		if path == "/color" then
			local _GET = {}
			if vars ~= nil then
				for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
					_GET[k] = v
				end
			end

			if _GET.r or _GET.g or _GET.b then
				-- This is for RGB Common Cathodesave
				led(_GET.r, _GET.g,_GET.b)
				
				-- This is for RGB Common Anode
				-- led(1023-_GET.r, 1023-_GET.g,1023-_GET.b)   
			end
			client:send("HTTP/1.1 200 OK")
		elseif path == "/save" then
			print("/save")
			if vars ~= nil then
				writeMode(vars)
			end
			client:send("HTTP/1.1 200 OK")
		elseif path == "/modes" then
			print("/modes")
			local buf = [[ HTTP/1.1 200 OK

					<!DOCTYPE html>
					<html>
						<head>
							<meta charset="utf-8">
						</head>
						<body>
							<div class="container">
								<div class="row">
									<ul>
									]]
			local modes = getModes()
			print(modes)
			for i = 0, #modes do                       	
				buf = buf .. "<li>" .. modes[i] .. "</li>"
			end
			buf = buf .. [[ 	</ul>
							</div>
						</div>
					</body>
				</html>
			]]

			client:send(buf)
		elseif path == "/picker" then
			local buf1 = [[ HTTP/1.1 200 OK

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