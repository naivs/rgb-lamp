-- pin a = gpio-13(7)
-- pin b = gpio-15(8)
-- pin press = gpio-3(9)
rotary.setup(0, 7, 8, 9)
rotary.on(0, rotary.TURN, function (type, pos, when)
  print("Position=" .. pos .. " event type=" .. type .. " time=" .. when)
end)
