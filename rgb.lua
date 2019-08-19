local inner_r = 1 inner_g = 2 inner_b = 3
local outer_r = 4 outer_g = 5 outer_b = 6
local freq = 1000

on()

-- current mode
activeModeNumber = 0
activeMode = nil

function off()
	pwm.stop(outer_r)
	pwm.stop(outer_g)
	pwm.stop(outer_b)

	pwm.stop(inner_r)
	pwm.stop(inner_g)
	pwm.stop(inner_b)
end

function on()
	-- on last active mode
	local lastMode = getLastMode()
	local _GET = {}
	if lastMode ~= nil then
		for k, v in string.gmatch(lastMode, "(%w+)=(%w+)&*") do
			_GET[k] = v
		end
	end

	if _GET.r or _GET.g or _GET.b or _GET.ri or _GET.gi or _GET.bi then
		-- This is for RGB Common Cathodesave
		pwm.setup(outer_r, freq, _GET.r)
		pwm.setup(outer_g, freq, _GET.g)
		pwm.setup(outer_b, freq, _GET.b)

		pwm.setup(inner_r, freq, _GET.ri)
		pwm.setup(inner_g, freq, _GET.gi)
		pwm.setup(inner_b, freq, _GET.bi)

		activeMode = lastMode
		saveLastMode(activeMode)
	else
		pwm.setup(outer_r, freq, 0)
		pwm.setup(outer_g, freq, 0)
		pwm.setup(outer_b, freq, 0)

		pwm.setup(inner_r, freq, 0)
		pwm.setup(inner_g, freq, 0)
		pwm.setup(inner_b, freq, 0)
	end

	pwm.start(outer_r)
	pwm.start(outer_g)
	pwm.start(outer_b)

	pwm.start(inner_r)
	pwm.start(inner_g)
	pwm.start(inner_b)
end

function set(ro, go, bo, ri, gi, bi)
    pwm.setduty(outer_r, ro)
    pwm.setduty(outer_g, go)
    pwm.setduty(outer_b, bo)
    -- setDuty for inner
    pwm.setduty(inner_r, ri)
    pwm.setduty(inner_g, gi)
    pwm.setduty(inner_b, bi)

    -- set to activeMode
end

function setMode(mode)
	-- example: r=1&g=101&b=255&ri=200&gi=0&bi=10
	local _GET = {}
	if mode ~= nil then
		for k, v in string.gmatch(mode, "(%w+)=(%w+)&*") do
			_GET[k] = v
		end
	end

	if _GET.r or _GET.g or _GET.b or _GET.ri or _GET.gi or _GET.bi then
		-- This is for RGB Common Cathodesave
		set(_GET.r, _GET.g, _GET.b, _GET.ri, _GET.gi, _GET.bi)
		activeMode = mode
		saveLastMode(activeMode)
		-- This is for RGB Common Anode
		-- led(1023-_GET.r, 1023-_GET.g,1023-_GET.b)   
	end
end

function setNumber(modeNumber)

end
