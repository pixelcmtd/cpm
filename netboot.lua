-- cpm netboot by pixel, chrissx Media

local SERVER = "https://pixelcmtd.github.io/cpm/"
local SUPPORT = "Twitter @chrissxMedia"

if not http then
        print("The http package isn't enabled in your ComputerCraft-config.")
        print("Please enable it, restart Minecraft and rerun the cpm installer.")
        return
end

local res = http.get(SERVER.."cpm.lua")
if not res then
        print("Cannot reach the server. ("..SERVER..")")
        print("Please contact us about that: "..SUPPORT)
        return
end
local cpm = res.readAll()
res.close()

local f = fs.open("cpm", "w")
f.write(cpm)
f.close()
