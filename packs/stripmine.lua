
local len = 50

local args = { ... }

if #args > 1 then
        len = args[1]
end

-- TODO: refuel

for i = 1, len do
        turtle.dig()
        turtle.forward()
        turtle.digUp()
end
