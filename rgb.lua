-- current mode
activeModeNumber = 0
activeMode = nil

function set(ro, go, bo, ri, gi, bi)
    pwm.setduty(1, ro)
    pwm.setduty(2, go)
    pwm.setduty(3, bo)

    -- setDuty for inner
end

function setMode(mode)
end

function setNumber(modeNumber)
end

pwm.setup(1, 1000, 1023)
pwm.setup(2, 1000, 1023)
pwm.setup(3, 1000, 1023)
pwm.start(1)
pwm.start(2)
pwm.start(3)
-- needs for inner too
