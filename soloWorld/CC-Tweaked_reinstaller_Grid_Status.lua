--[[Grid Status Reinstaller
Reinstalls Grid Status
Do not use without permission from the creator
Created by: Coolkid10809
Pastebin "https://pastebin.com/W2b0xLTi"
github Repo: "https://github.com/coolkid10809/CCTweaked/blob/main/soloWorld/CC-Tweaked_reinstaller_Grid_Status.lua"]]
local pasteID = "f2gaFKam"
 
if fs.exists("startup/status_reader") then
    fs.delete("startup/status_reader")
end
 
if shell.run("pastebin", "get", pasteID, "startup/status_reader") then
    print("Status reader reinstalled!")
else
    print("Failed to download status reader.")
end