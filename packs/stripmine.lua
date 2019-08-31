
local DEFAULT_LEN = 50

local args = { ... }

if #args < 1 then
        table.insert(args, DEFAULT_LEN)
end

-- refuel

for i = 1, args[1] do
        turtle.dig()
        turtle.forward()
        turtle.digUp()
end
