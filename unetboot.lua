-- cpm unetboot by pixel, chrissx Media
local f=fs.open("cpm","w")
f.write(http.get("https://pixelcmtd.github.io/cpm/cpm.lua").readAll())
f.close()
