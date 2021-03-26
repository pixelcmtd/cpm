while true do
        program = io.read("*l")
        res = loadstring(program)()
        print(res)
end
