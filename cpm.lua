-- cpm by chrissx

local SERVER = "https://chrissxyt.github.io/cpm/"
local PACK_DB = ".cpm_installed"

local function printUsage()
        print("ComputerCraft Package Manager by chrissx")
        print("")
        print("Usage:")
        print("  cpm u(pdate)")
        print("  cpm i(nstall) <packagename>")
        print("  cpm r(emove) <packagename>")
        print("  cpm l(ist)")
        return 0
end

local function download(url)
        local res = http.get(url)
        if res then
                local content = res.readAll()
                res.close()
                return content
        end
end

local function write_file(path, contents)
        local f = fs.open(path, "w")
        f.write(contents)
        f.close()
end

local function download_and_write(program, url, verb)
        local c = download(url)
        if c then
                write_file(program, c)
                print(verb.." "..program..".")
        end
end

local function get_packages()
        return textutils.unserialize(download(SERVER.."packages.list"))
end

local function get_list(p)
        return textutils.unserialize(download(SERVER.."packs/"..textutils.urlEncode(p)..".list"))
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

        local l = get_list(p)
        for i,j in pairs(l) do
                fs.delete(i)
        end

        return t
end


if not http then
        print("The http package isn't enabled in your ComputerCraft-config.")
        print("Please enable it, restart Minecraft and rerun cpm.")
        return
end

local tArgs = { ... }

if #tArgs < 1 then
        return printUsage()
end

local cmd = string.sub(tArgs[1], 1, 1)

if (cmd == "i" or cmd == "r") and #tArgs < 2 then
        return printUsage()
end

if cmd == "u" then
        local installed_packages = read_package_list()
        download_and_write("cpm", SERVER.."cpm.lua", "Updated")
        for k,p in pairs(installed_packages) do
                local l = get_list(p)
                for i,j in pairs(l) do
                        download_and_write(i, SERVER..j, "Updated")
                end
        end
elseif cmd == "i" then
        local installed_packages = read_package_list()
        local p = tArgs[2]
        local l = get_list(p)
        for i,j in pairs(l) do
                download_and_write(i, SERVER..j, "Installed")
        end
        table.insert(installed_packages, tArgs[2])
        write_package_list(installed_packages)
elseif cmd == "r" then
        local installed_packages = read_package_list()
        installed_packages = remove_package(installed_packages, tArgs[2])
        write_package_list(installed_packages)
elseif cmd == "l" then
        for p in get_packages() do
                print(p)
        end
else
        printUsage()
        return 1
end
