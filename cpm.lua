
local SERVER = "http://chrissx.ga:1338/"
local PACK_DB = ".cpm_installed"

local function printUsage()
        print("ComputerCraft Package Manager by chrissx")
        print("")
        print("Usage:")
        print("  cpm u(pdate)")
        print("  cpm i(nstall) <packagename>")
        print("  cpm r(emove) <packagename>")
end

local function download(url)
        local res = http.get(url)
        if res then
                local content = res.readAll()
                res.close()
                return content
        end
end

local function read_package_list()
        if fs.exists(PACK_DB) then
                local f = fs.open(PACK_DB, "r")
                local c = f.readAll()
                f.close()
                return textutils.unserialize(c)
        else
                return {}
        end
end

local function write_package_list(t)
        local f = fs.open(PACK_DB, "w")
        f.write(textutils.serialize(t))
        f.close()
        return
end

local function remove_package(t, p)
        local i = 0

        for k,v in pairs(t) do
                i = i + 1
        end

        while i > 0 do
                if t[i] == p then
                        table.remove(t, i)
                        break
                end
                i = i - 1
        end

        fs.delete(p)

        return t
end

if not http then
        print("The http package isn't enabled in your ComputerCraft-config.")
        print("Please enable it, restart Minecraft and rerun cpm.")
        return
end

local tArgs = { ... }
local installed_packages = {}

if #tArgs < 1 or ((tArgs[1] == "i" or tArgs[1] == "r") and #tArgs < 2) then
        printUsage()
        return
end

local cmd = string.sub(tArgs[1], 1, 1)

if cmd == "u" then
        installed_packages = read_package_list()
        local cpm = download(SERVER.."cpm.lua")
        if cpm then
                local f = fs.open("cpm", "w")
                f.write(cpm)
                f.close()
                print("Updated cpm.")
        end
        for k,v in pairs(installed_packages) do
                local c = download(SERVER.."packs/"..textutils.urlEncode(v)..".lua")
                if c then
                        local f = fs.open(v, "w")
                        f.write(c)
                        f.close()
                        print("Updated "..v..".")
                end
        end
elseif cmd == "i" then
        installed_packages = read_package_list()
        local c = download(SERVER.."packs/"..textutils.urlEncode(tArgs[2])..".lua")
        if c then
                local f = fs.open(tArgs[2], "w")
                f.write(c)
                f.close()
                print("Installed "..tArgs[2]..".")
        end
        table.insert(installed_packages, tArgs[2])
        write_package_list(installed_packages)
elseif cmd == "r" then
        installed_packages = read_package_list()
        installed_packages = remove_package(installed_packages, tArgs[2])
        write_package_list(installed_packages)
else
        printUsage()
end
