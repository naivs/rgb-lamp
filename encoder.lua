-- pin a = 13(7)
-- pin b = 0(3)
-- pin press = 15(8)
rotary.setup(0, 7, 8, 3)
rotary.on(0, rotary.TURN, function (type, pos, when)
  print("Position=" .. pos .. " event type=" .. type .. " time=" .. when)
end)