while true do
    turtle.select(1)
    if turtle.suckUp() then
        turtle.place()
        for i = 1, 16 do
            turtle.select(i)
            turtle.dropDown()
        end
    end
    os.sleep(1)
end
