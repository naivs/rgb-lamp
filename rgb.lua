function led(r, g, b)
    pwm.setduty(1, r)
    pwm.setduty(2, g)
    pwm.setduty(3, b)
end
pwm.setup(1, 1000, 1023)
pwm.setup(2, 1000, 1023)
pwm.setup(3, 1000, 1023)
pwm.start(1)
pwm.start(2)
pwm.start(3)

-- current mode
selectedModeNumber = 0
selectedMode = nil
