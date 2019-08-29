
local function printUsage()
        print("Usage:")
        print(" cpm u")
        print(" cpm i <packagename>")
        print(" cpm r <packagename>")
end

local function download(url)
        local res = http.get(url)
        if res then
                local content = res.readAll()
                res.close()
                return content
        end
end

if not http then
        print("The http package isn't enabled in your ComputerCraft-config.")
        print("Please enable it, restart Minecraft and rerun cpm.")
        return
end

local tArgs = { ... }

if #tArgs < 1 then
        printUsage()
        return
end

if (tArgs[1] == "i" or tArgs[1] == "r") and #tArgs < 2 then
        printUsage()
        return
end

if tArgs[1] == "u" then
        local cpm = download("http://chrissx.ga:1338/cpm.lua")
        if cpm then
                local f = fs.open("cpm", "w")
                f.write(cpm)
                f.close()
                print("Updated cpm.")
        end
elseif tArgs[1] == "i" then
--        install()
elseif tArgs[1] == "r" then
--        remove()
else
--        printUsage()
end
