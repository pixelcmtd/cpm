-- cpm unetboot by chrissx
local f=fs.open("cpm","w")
f.write(http.get("https://chrissxyt.github.io/cpm/cpm.lua").readAll())
f.close()
